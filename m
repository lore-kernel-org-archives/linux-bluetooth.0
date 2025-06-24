Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E332AEED
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725369; cv=none; b=puifm9NrI65WxYBAmrsECbq9m8lzhCzEBSqjI1oV1/xikOzApCl9p10ukjfurrMahcylJl+1r8yMx31fm8ct6D3w7/OhILuuwp2c8+pgYJBQgLIk6Yf7Mgdjr6Ongc3Pd9VVVugAOqsKTWEUtC0gLElQTNbrnzoyMQ6I5QC4G+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725369; c=relaxed/simple;
	bh=geqj9b2XJkf8FaNH26RAgCAO3Ox67lc2WOECE1xJBkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyO8fht1qKQzvciiCfu6RVKOtSw/aAnFyQbXE4lhEWrHomVDNBSne8+zPfVq/ny+5ylY2sfY+zAklgIcPZ7pSNQaecGH57rGjqZk/PnmyahZ9a3Kzyoj02vsljWqWz1iIrjxo2Qcc/wR38De4yV5v9jSugg46VseDEsdCTHkFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=ryIyJmT4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="ryIyJmT4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1750725360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PH+jOw/j3JhvnN+p6cZr5KJBmGYF7ALIYXdAv6HRXy8=;
	b=ryIyJmT43Fk1Vlr/zw/MTlmqJrzJuK7HqNt7+uFFQ8yJWkf6A9ARpmdFT5pM3BM9CYNuHj
	dJx5PZj6bNKTassXwhDKCmYGE/8a1ALfZFlOQnNhsz3jy6ZoKISzekkXFrrF+ZLiIIFUIE
	CP/hdsHvqMsErLY1xPK9HrMhBBGs4mc=
From: Ronan Pigott <ronan@rjp.ie>
To: linux-bluetooth@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>
Subject: [PATCH BlueZ] zsh: amend completions
Date: Mon, 23 Jun 2025 17:35:30 -0700
Message-ID: <20250624003551.107489-1-ronan@rjp.ie>
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

Finally, update the bluetoothctl command invocations to account for the
media lines printed after some of the non-interactive commands.
---
 completion/zsh/_bluetoothctl | 133 ++++++++++++++++-------------------
 src/shared/shell.c           |   4 ++
 2 files changed, 66 insertions(+), 71 deletions(-)

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
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 6b4f7a7ef503..0685a1cdb21a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1726,6 +1726,10 @@ int bt_shell_get_timeout(void)
 
 void bt_shell_handle_non_interactive_help(void)
 {
+	if (data.zsh) {
+		shell_print_menu_zsh_complete();
+		exit(EXIT_SUCCESS);
+	}
 	if (!data.mode)
 		return;
 	if (data.argv[0] != cmplt)
-- 
2.50.0

