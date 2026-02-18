Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EC346770
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437324; cv=none; b=WaIGm8Js9byl0w/btAxk0lWabQ2DuGbcaohfnvbYUYbq7wN6j+Y1AKhMHElYODhxnj2zz4oTcKjsCfrU1lyXNHNxlmA/CZSKP5ORz7/IdRuo6cfdMizjDpIGqfmyvQBvtkQjf/WNJj6Tx3SP4syebHWNNdy6SWQ7QcnRW2oJFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437324; c=relaxed/simple;
	bh=Nu3WYT5qVnLunqt/in+1HGYR6oNwdvu361q+e+GWsPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwkLNvF0aVzaz+d6kYOlIs/n1Be0rUKjj05i1hQtHHAlq8JyVzuXoCePUOlEllasaAowKStIto7Y1O6vZ6PJ4opg5keZaNZEsTcRA3XUFGC7tJ56NeTolpJIP/F+17gT7FCI/e+m3v+uYNDX6an0y/Suxy/iXcTYGeRYNKA0QxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=VdlEUAjz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="VdlEUAjz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1771437321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zdQLkVyJCYqInp62rFNEWMf+c+jOP5Rk90zQCBmSdd0=;
	b=VdlEUAjz7T2SnWeYkc9BAmD4NLY5cBK728vSJd1oUY4tAGB9re6oHgqaqI7sU5DG5nnVmo
	iVtlZJSqi0O9zScEGBz6oRrJBh+g7PApLfHzLWdtz4GwIOac8MzhQoFQSpAFaupIM68x6H
	poKapxo//s4JvGNXtQ1cpQBYo8aen5Y=
From: Ronan Pigott <ronan@rjp.ie>
To: linux-bluetooth@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH BlueZ v2] zsh: amend completions
Date: Wed, 18 Feb 2026 10:47:30 -0700
Message-ID: <20260218175439.15660-1-ronan@rjp.ie>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

First, use the correct completion return value.

The return value of a completion function is significant, if we fail to
return success additional completers may be invoked when they otherwise
should not be.

Also cleanup up the zsh completion, removing the redundant definition of
_bluetoothctl and using the _call_program helper where appropriate.

Finally, update the bluetoothctl invocations to be a little more robust
when parsing the output of device and list commands in case new output
lines are added.
---
Changes in v2:
 - Dropped the hunk from src/shared/shell.c. I think it was left over
   from a prior version of this patch on the branch where I had rebased
   the input changes I submitted. This patch was originally submitted in
   [1].

[1] https://marc.info/?l=linux-bluetooth&m=175072534107658&w=2

 completion/zsh/_bluetoothctl | 133 ++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 71 deletions(-)

diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
index 610ca2b8d59c..b6f513376532 100644
--- a/completion/zsh/_bluetoothctl
+++ b/completion/zsh/_bluetoothctl
@@ -1,97 +1,88 @@
 #compdef bluetoothctl
 
-__bluetoothctl() {
-	bluetoothctl "$@" 2>/dev/null
-}
-
 _bluezcomp_controller() {
 	local -a controllers
-	bluetoothctl list |
-	while read _ MAC NAME; do
-		controllers+="${MAC//:/\\:}:${NAME//:/\\:}"
+	_call_program bluez-controller bluetoothctl list |
+	while read KIND MAC NAME FLAG; do
+		[[ $KIND == Controller ]] &&
+			controllers+=("${MAC//:/\\:}:${NAME//:/\\:}")
 	done
 	_describe -t controllers 'controller' controllers
 }
 
 _bluezcomp_device() {
 	local -a devices
-	bluetoothctl devices |
-	while read _ MAC NAME; do
-		devices+="${MAC//:/\\:}:${NAME//:/\\:}"
+	_call_program bluez-device bluetoothctl devices |
+	while read KIND MAC NAME; do
+		[[ $KIND == Device ]] &&
+			devices+=("${MAC//:/\\:}:${NAME//:/\\:}")
 	done
 	_describe -t devices 'device' devices
 }
 
 _bluezcomp_agentcap() {
-	local -a agent_options=(${(f)"$(__bluetoothctl agent help)"})
-	agent_options=( "${(@)agent_options:#(on|off)}" )
-	compadd -a agent_options
+	local -a agent_options=(${${(@f)"$(_call_program bluez-agent bluetoothctl agent help)"}:#(on|off)})
+	compadd "$@" - -a agent_options
 }
 
 _bluetoothctl_agent() {
-	local -a agent_options=(${(f)"$(__bluetoothctl agent help)"})
-	agent_options+=help
-	compadd -a agent_options
+	local -a agent_options=(help ${(@f)"$(_call_program bluez-agent bluetoothctl agent help)"})
+	compadd "$@" - -a agent_options
 }
 
-_bluetoothctl_advertise() {
-	local -a ad_options=(${(f)"$(__bluetoothctl advertise help)"})
-	ad_options+=help
-	compadd -a ad_options
-}
+local -a toggle_commands=(
+	"discoverable" "pairable" "power" "scan"
+)
 
-_bluetoothctl() {
-	local -a toggle_commands=(
-		"discoverable" "pairable" "power" "scan"
-	)
+local -a controller_commands=(
+	"select" "show"
+)
 
-	local -a controller_commands=(
-		"select" "show"
-	)
+local -a device_commands=(
+	"block" "connect" "disconnect" "info"
+	"pair" "remove" "trust" "unblock" "untrust"
+)
 
-	local -a device_commands=(
-		"block" "connect" "disconnect" "info"
-		"pair" "remove" "trust" "unblock" "untrust"
-	)
+# Other commands may be handled by _bluetoothctl_$command
+local -a all_commands=( "${(@f)$(_call_program bluetoothctl bluetoothctl --zsh-complete help)}" )
 
-	# Other commands may be handled by _bluetoothctl_$command
-	local -a all_commands=( "${(@f)$(__bluetoothctl --zsh-complete help)}" )
+local curcontext=$curcontext state line ret=1
+_arguments -C \
+	+ '(info)' \
+	{-h,--help}'[Show help message and exit]' \
+	{-v,--version}'--version[Show version info and exit]' \
+	+ 'mod' \
+	'(info)'{-a+,--agent=}'[Register agent handler]:agent:_bluezcomp_agentcap' \
+	'(info)'{-t,--timeout}'[Timeout in seconds for non-interactive mode]' \
+	'(info)'{-m,--monitor}'[Enable monitor output]' \
+	+ 'command' \
+	'(info):command:->command' \
+	'(info):: :->argument'
 
-	local curcontext=$curcontext state line ret=1
-	_arguments -C \
-		+ '(info)' \
-		{-h,--help}'[Show help message and exit]' \
-		{-v,--version}'--version[Show version info and exit]' \
-		+ 'mod' \
-		'(info)'{-a+,--agent=}'[Register agent handler]:agent:_bluezcomp_agentcap' \
-		'(info)'{-t,--timeout}'[Timeout in seconds for non-interactive mode]' \
-		'(info)'{-m,--monitor}'[Enable monitor output]' \
-		+ 'command' \
-		'(info):command:->command' \
-		'(info):: :->argument'
-
-	if [[ $state == "command" ]]; then
-		_describe -t commands 'command' all_commands
-	elif [[ $state == "argument" ]]; then
-		if (( ! ${"${(@)all_commands%%:*}"[(I)${line[1]}]} )); then
-			_message "Unknown bluetoothctl command: $line[1]"
-			return 1;
-		fi
-
-		curcontext="${curcontext%:*:*}:bluetoothctl-$line[1]:"
-		if ! _call_function ret _bluetoothctl_$line[1]; then
-			case $line[1] in
-				(${(~j.|.)toggle_commands})
-					compadd on off
-					;;
-				(${(~j.|.)device_commands})
-					_bluezcomp_device
-					;;
-				(${(~j.|.)controller_commands})
-					_bluezcomp_controller
-					;;
-			esac
-		fi
-		return ret
+if [[ $state == "command" ]]; then
+	_describe -t commands 'command' all_commands
+elif [[ $state == "argument" ]]; then
+	if (( ! ${"${(@)all_commands%%:*}"[(I)${line[1]}]} )); then
+		_message "Unknown bluetoothctl command: $line[1]"
+		return 1;
 	fi
-} && _bluetoothctl
+
+	curcontext="${curcontext%:*:*}:bluetoothctl-$line[1]:"
+	if ! _call_function ret _bluetoothctl_$line[1]; then
+		case $line[1] in
+			(advertise)
+				compadd - help on off type && ret=0
+				;;
+			(${(~j.|.)toggle_commands})
+				compadd on off && ret=0
+				;;
+			(${(~j.|.)device_commands})
+				_bluezcomp_device && ret=0
+				;;
+			(${(~j.|.)controller_commands})
+				_bluezcomp_controller && ret=0
+				;;
+		esac
+	fi
+	return ret
+fi

base-commit: eae36399e75807dcf3d88d9af18909288fa71ee4
-- 
2.53.0

