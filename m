Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980AC3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E9520880
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d882ujB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHQGg2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44034 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfHQGg2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so3995700pgl.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2kBzO6yAeiZ58u3a1dhmifrEqATA5dV//e0NzEMWZc=;
        b=d882ujB1s6yt2XusrFRusv2LEoGruePTwkDjJxWUobP8tq4AtLU/z9I+Du594ccmIa
         OeVBi+Ra+ZjDDwuvyDMSTXvOkuuXjW6tgDuABCPqOyQsMFBqfL+tMzIImV60B2w7dRpo
         k5LaZ4iPOsoDrpTiXZhwJYTd899DClIUpxjAPptR+4ImOM8tIAYXaH93erztLwgLaRzT
         vY4F951DDptoa5QvAKKjCAJGxACMOYQdYGJU06gO2doR+ItNreCBW9QcLNR+Po/LKLli
         Rspz0y+pbfxrrqICS2InjBYYR2Je7wqxfp0B6jJn71T2tRmx3QiHFO700StchFc+rBuJ
         /q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2kBzO6yAeiZ58u3a1dhmifrEqATA5dV//e0NzEMWZc=;
        b=Vule+wfZfe/1Oo+m0HX8kHGyXYskpJYy77MHHjQckmYp+gPPi79wvpg0GpgFXOYpB1
         kuB8vYonr3pjO5qIFdGSNIIUKv2TXZa0I3qiTSSU0M3un5Z0otm775Xs3z7mXnBN3Xg4
         bJXKqsDN7vBL711KsVBks1Ugx/AZh2Z79w2IkWDD50VUzTyrbmY86g8l7whAv6Cpy9rS
         PDeaThbnqKbq+7+mUZ53E6+4c1IvlzOhm3/KhEIYGb+mU624TvjxAy2MAejr7qwzPTK7
         vsEdArBF1qNwPaw7RR8GaBFzm2daJVGsLMhC7DRarC5q3o2ovpkEqJUBmATpDNRTVOkn
         dFwQ==
X-Gm-Message-State: APjAAAUdLeUpb9X1U+tWwE2tXfmvECP3FMHgg57fSQ+z7FBEtKC7abde
        5/OPJkcI2bVuAD13/KrMLrgrV1I=
X-Google-Smtp-Source: APXvYqwuK9xAfj5saYzYQu1/x39p4JCJpGiUklnFq0bv8h+F99eRrf22jOWykXFhe+mt8Ry18nckBw==
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr14261962pfq.93.1566023787061;
        Fri, 16 Aug 2019 23:36:27 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id y128sm6684095pgy.41.2019.08.16.23.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:36:26 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ v2 3/4] completion: add bluetoothctl zsh completions
Date:   Fri, 16 Aug 2019 23:34:51 -0700
Message-Id: <20190817063452.23273-4-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817063452.23273-1-rpigott@berkeley.edu>
References: <20190817063452.23273-1-rpigott@berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

This zsh compdef provides completions for the bluetoothctl command.

It has been modified from version 1 of this patch to get the command
names and descriptions from the newly introduced --zsh-complete.

It utilizes the output of `bluetoothctl devices` or
`bluetoothctl controllers` to provide a descriptive completion menu
in those contexts.

e.g.

$ bluetoothctl connect <TAB>
04:52:C7:0C:D4:A7  -- Bose QuietComfort 35
40:4E:36:D9:8F:28  -- Pixel 2
A4:38:CC:20:5D:E0  -- Pro Controller

---
 completion/zsh/_bluetoothctl | 98 ++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 completion/zsh/_bluetoothctl

diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
new file mode 100644
index 000000000..bf35e503e
--- /dev/null
+++ b/completion/zsh/_bluetoothctl
@@ -0,0 +1,98 @@
+#compdef bluetoothctl
+
+__bluetoothctl() {
+	bluetoothctl "$@" 2>/dev/null
+}
+
+_bluezcomp_controller() {
+	local -a controllers
+	bluetoothctl list |
+	while read _ MAC NAME; do
+		controllers+="${MAC//:/\\:}:${NAME//:/\\:}"
+	done
+	_describe -t controllers 'controller' controllers
+}
+
+_bluezcomp_device() {
+	local -a devices
+	bluetoothctl devices |
+	while read _ MAC NAME; do
+		devices+="${MAC//:/\\:}:${NAME//:/\\:}"
+	done
+	_describe -t devices 'device' devices
+}
+
+_bluezcomp_agentcap() {
+	local -a agent_options=(${(f)"$(__bluetoothctl agent help)"})
+	agent_options=( "${(@)agent_options:#(on|off)}" )
+	compadd -a agent_options
+}
+
+_bluetoothctl_agent() {
+	local -a agent_options=(${(f)"$(__bluetoothctl agent help)"})
+	agent_options+=help
+	compadd -a agent_options
+}
+
+_bluetoothctl_advertise() {
+	local -a ad_options=(${(f)"$(__bluetoothctl advertise help)"})
+	ad_options+=help
+	compadd -a ad_options
+}
+
+_bluetoothctl() {
+	local -a toggle_commands=(
+		"discoverable" "pairable" "power" "scan"
+	)
+
+	local -a controller_commands=(
+		"select" "show"
+	)
+
+	local -a device_commands=(
+		"block" "connect" "disconnect" "info"
+		"pair" "remove" "trust" "unblock" "untrust"
+	)
+
+	# Other commands may be handled by _bluetoothctl_$command
+	local -a all_commands=( "${(@f)$(__bluetoothctl --zsh-complete help)}" )
+
+	local curcontext=$curcontext state line ret=1
+	_arguments -C \
+		+ '(info)' \
+		{-h,--help}'[Show help message and exit]' \
+		{-v,--version}'--version[Show version info and exit]' \
+		+ 'mod' \
+		'(info)'{-a+,--agent=}'[Register agent handler]:agent:_bluezcomp_agentcap' \
+		'(info)'{-t,--timeout}'[Timeout in seconds for non-interactive mode]' \
+		'(info)'{-m,--monitor}'[Enable monitor output]' \
+		+ 'command' \
+		'(info):command:->command' \
+		'(info):: :->argument' \
+		': :_message "no more arguments"'
+
+	if [[ $state == "command" ]]; then
+		_describe -t commands 'command' all_commands
+	elif [[ $state == "argument" ]]; then
+		if (( ! ${"${(@)all_commands%%:*}"[(I)${line[1]}]} )); then
+			_message "Unknown bluetoothctl command: $line[1]"
+			return 1;
+		fi
+
+		curcontext="${curcontext%:*:*}:bluetoothctl-$line[1]:"
+		if ! _call_function ret _bluetoothctl_$line[1]; then
+			case $line[1] in
+				(${(~j.|.)toggle_commands})
+					compadd on off
+					;;
+				(${(~j.|.)device_commands})
+					_bluezcomp_device
+					;;
+				(${(~j.|.)controller_commands})
+					_bluezcomp_controller
+					;;
+			esac
+		fi
+		return ret
+	fi
+} && _bluetoothctl
-- 
2.22.1

