Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990AC3A59E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077A20644
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7rKd1Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHPHos (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:44:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45709 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHPHos (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 03:44:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so2696064pfq.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZ/GzucfjBa3b2iF50joCEX9lZhufidY+SRNHjtSrtw=;
        b=A7rKd1CuC0wvJmRL3nQBByX+YL7mSXKR24ohrzy4OQHvXzki1LhDhuGcpWWUiWZ10m
         2sk77mqgUVjP05Gh1UIA9o7/XsrGONvpBcurhvx0Tm7p7IK8o/4P/gL/yd0mZyL70B3H
         3jTz1zK+vCZvwECg4Iy0C3yXbFmm8lsOlB7yBVme04n0LAZFvWyYKZ6thWJuTKAEWj4f
         vasprqbKKNMwEDOG4PH3gM5MT3e6rn0cEf9hhBOxHDelQ1q6LLirmfHGERxY+loURIxJ
         ma/NyRsJYVJNirOHGuBW+R4uZvvEdpDCphAZuFONSQ3X6E/Adm4GpjJ23qUxa91B8NPu
         1LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZ/GzucfjBa3b2iF50joCEX9lZhufidY+SRNHjtSrtw=;
        b=iF4MCOtT/Fw7AJX5GiMfQwrNFCRrVCAIcyoBLUL2YQILZ6lVhD4x3TgySOShCI6t6S
         CpSYnhj6OLN73pDZfTfn67UVQnAMUPW12ZzzUO/emImfh9mfvAIP7g7cLF/ZRpnQKeLv
         HQq50Yqy6P4DAsqpG0rZ7hQxJWIGr8pMqnigkNTM8AeGaAj1tlKJsIggC8Vs05i+i8T8
         yJ9S4TXFQLnNWDl3ktbwrJcy7T057wZwt/Zcm7c/pggz/VUvQDoz/jCN3RRiT4FQys0b
         Nd/C8gN8hZDQic48iFsn4kL/afyu2yi3BGbs9vGlaq5QlGzonOgM8gOy0T+vYhOpM+ui
         JHPA==
X-Gm-Message-State: APjAAAUqASU9lD2TZT6T714E1rtyXMHw3bYG+tPtThvjv9Q8XW263QEP
        4+asB6IOWxZoE1GydT4FjJbJywA=
X-Google-Smtp-Source: APXvYqwo6TeYcvdvfFhQge2O3hDa5IXRfEh/O9x/ODlf3hH+TpDSQefCyAucxJAsuFQiefatkUjTng==
X-Received: by 2002:a62:8648:: with SMTP id x69mr9559691pfd.92.1565941486880;
        Fri, 16 Aug 2019 00:44:46 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:71a0:9ddd:9d48:afb])
        by smtp.gmail.com with ESMTPSA id v184sm4186679pgd.34.2019.08.16.00.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:44:46 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ 2/3] completion: add bluetoothctl zsh completions
Date:   Fri, 16 Aug 2019 00:43:32 -0700
Message-Id: <20190816074333.24673-3-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190816074333.24673-1-rpigott@berkeley.edu>
References: <20190816074333.24673-1-rpigott@berkeley.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

---
 completion/zsh/_bluetoothctl | 131 +++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 completion/zsh/_bluetoothctl

diff --git a/completion/zsh/_bluetoothctl b/completion/zsh/_bluetoothctl
new file mode 100644
index 000000000..c9c177a83
--- /dev/null
+++ b/completion/zsh/_bluetoothctl
@@ -0,0 +1,131 @@
+#compdef bluetoothctl
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
+_bluetoothctl_agent() {
+	local -a agent_options=(${(f)"$(bluetoothctl agent help)"})
+	agent_options+=help
+	compadd -a agent_options
+}
+
+_bluetoothctl_agent_cap() {
+	local -a agent_options=(${(f)"$(bluetoothctl agent help)"})
+	agent_options=( "${(@)agent_options:#(on|off)}" )
+	compadd -a agent_options
+}
+
+_bluetoothctl_advertise() {
+	local -a ad_options=(${(f)"$(bluetoothctl advertise help)"})
+	ad_options+=help
+	compadd -a ad_options
+}
+
+_bluetoothctl() {
+	local curcontext=$curcontext state line ret=1
+
+	local -a simple_commands=(
+		"help:Display help"
+		"version:Dispaly version"
+		"list:List available controllers"
+		"devices:List available devices"
+		"paired-devices:List paired devices"
+		"reset-alias:Reset controller alias"
+		"default-agent:Set agent as the default one"
+		"export:Print environment variables"
+		"system-alias:Set controller alias"
+		"set-alias:Set device alias"
+	)
+
+	local -a toggle_commands=(
+		"power:Set controller power"
+		"pairable:Set controller pairable mode"
+		"discoverable:Set controller discoverable mode"
+		"scan:Scan for devices"
+	)
+
+	local -a controller_commands=(
+		"show:Controller information"
+		"select:Select default controller"
+	)
+
+	local -a device_commands=(
+		"info:Device information"
+		"pair:Pair with device"
+		"trust:Trust device"
+		"untrust:Untrust device"
+		"block:Block device"
+		"unblock:Unblock device"
+		"remove:Remove device"
+		"connect:Connect device"
+		"disconnect:Disconnect device"
+	)
+
+	local -a other_commands=(
+		"agent:Enable/disable advertising with given type"
+		"advertise:Enable/disable advertising with the given type"
+	)
+
+	local -a all_commands=(
+		$simple_commands
+		$device_commands
+		$toggle_commands
+		$controller_commands
+		$other_commands
+	)
+
+	_arguments -C \
+		+ '(info)' \
+		'--help[Show help message and exit]' \
+		'--version[Show version info and exit]' \
+		+ 'mod' \
+		'(info)--timeout[Timeout in seconds for non-interactive mode]' \
+		'(info)--agent=[Register agent handler]:agent:_bluetoothctl_agent_cap' \
+		+ 'command' \
+		'(info):command:->command' \
+		'(info):: :->argument' \
+		': :_message "no more arguments"'
+
+	if [[ $state == "command" ]]; then
+		_describe -t commands 'command' all_commands
+	elif [[ $state == "argument" ]]; then
+		curcontext=${curcontext%:*:*}:bluetoothctl-$line[1]
+		case $line[1] in
+			(${(~j.|.)simple_commands%%:*})
+				_message "no more arguments"
+				;;
+			(${(~j.|.)toggle_commands%%:*})
+				compadd on off
+				;;
+			(${(~j.|.)device_commands%%:*})
+				_bluezcomp_device
+				;;
+			(${(~j.|.)controller_commands%%:*})
+				_bluezcomp_controller
+				;;
+			*)
+				if ! _call_function ret _bluetoothctl_$line[1]; then
+					_message "Unknown bluetoothctl command: $line[1]"
+				fi
+				return ret
+				;;
+		esac
+	fi
+}
+
+_bluetoothctl
-- 
2.22.1

