{{/*
ingester zonename
*/}}
{{- define "mimir.ingesterZonename" -}}
{{ include "mimir.resourceName" (dict "ctx" . "component" "ingester") }}{{- if .Values.ingester.rollout_operator.enabled }}-{{ .rolloutZone.name }}{{- end }}
{{- end }}


{{/*
ingester multi zone specific labels
*/}}
{{- define "mimir.ingesterZoneLabels" -}}
{{- include "mimir.labels" (dict "ctx" . "component" "ingester" "memberlist" true) }}
{{- if .Values.ingester.rollout_operator.enabled }}
rollout-group: ingester
zone: {{ .rolloutZone.name }}
{{- end }}
{{- end -}}


{{/*
ingester multi zone selector labels
*/}}
{{- define "mimir.ingesterZoneSelectorLabels" -}}
{{- include "mimir.selectorLabels" (dict "ctx" . "component" "ingester" "memberlist" true) }}
{{- if .Values.ingester.rollout_operator.enabled }}
rollout-group: ingester
zone: {{ .rolloutZone.name }}
{{- end }}
{{- end -}}


{{/*
ingester multi zone pod labels
*/}}
{{- define "mimir.ingesterZonePodLabels" -}}
{{- include "mimir.podLabels" (dict "ctx" . "component" "ingester" "memberlist" true) }}
{{- if .Values.ingester.rollout_operator.enabled }}
rollout-group: ingester
zone: {{ .rolloutZone.name }}
{{- end }}
{{- end -}}


{{/*
ingester common annotations
*/}}
{{- define "mimir.ingesterAnnotations" -}}
{{- if .Values.ingester.rollout_operator.enabled }}
{{- $map := dict "rollout-max-unavilable" .Values.ingester.rollout_operator.max_unavailable -}}
{{- toYaml (deepCopy $map | mergeOverwrite .Values.ingester.annotations) }}
{{- else -}}
{{ toYaml .Values.ingester.annotations }}
{{- end -}}
{{- end -}}
