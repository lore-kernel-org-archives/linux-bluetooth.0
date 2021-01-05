Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EBDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A50222581
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbhAEDOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbhAEDOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 22:14:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7801C061798
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 19:13:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q11so54735350ybm.21
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 19:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lXQ0LpCr8+V+7Lii7uhFuJpkcYXzYIJ/ONcFeoVEIR4=;
        b=jcmsbc72OuqdaSQeaTfO8rvp9crZv/yEAZ0FIvsIePK4nDA9dzzdlv/EtP2eR/nWZ/
         fZIly9qtXrfVsf9zLMIL72EE9EiOXnb4hr4BxLPehWGlPK3hNMc4Fj9yfnLOPVMcLxsW
         ARYiMbRNd7Rj0h5x5MCVXGIzCdUO59TWvT1BTkSUZ0BMTUjABWvQzUeSuYasYmfIdYdj
         khr2uKVQJaC2iiWQXGvBk9cyosx9Ia7LuDfUKRrzsjHejDpr/KjsrG7C+Pbt8gMasUzz
         3zLALoOKmoAHDaX7/5qWj0IOjB9SR6uzRqQ2hlX28BHmeN0FVS93afDkjuObQKFmvgb7
         NM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lXQ0LpCr8+V+7Lii7uhFuJpkcYXzYIJ/ONcFeoVEIR4=;
        b=NW/zuiwBpQCe59KnvPQdxma02yMamMW6pmWmZdpUCz+2GULcu8FCnJO56d+crL9OhP
         vptqbWgk/TvCDky6Wf00YYHHigQRRdCIHgXqEOjKvRP4ubG+mJBNhs3bHq0BupNPnAVT
         o2S1YZTeaxIC5aE5G745V5NIvbkaw5wyS4B0+xqFDZB2ZyuAPoQaTHYk3R+xqQqURomx
         CEfnUnXm4z3orX9OwtvmZ6BSb7+vZCAFn68p1bpSXbtTxZGP9hLlW+qvXRJkNwORnnZj
         fxIjvyRHFDjuir+47qezqE0q/x68e6vtS/yOUAKXOLsfn5oDlZvRKDjrbm9aj+zXj8KC
         dL0Q==
X-Gm-Message-State: AOAM533oVjg1qm8PE6+1oSkE1Jh8IBlSVTU/q7xp/YtnHd/w0ec5G64S
        j9IEZ5yDuj4V8SpbQoZaCbqDtZlTRcnoRVGCtiVJFgIja5iA5SMZIzSzK2hWrGZ33e3A3jajVcA
        C65TnL/1ghondduhSn5g5s4D2qIKT/H7Ja8khlcsMDT7ntCpoP1HsAgoqpOdfKztTmcN8iyELAY
        899zIwfrOLkho=
X-Google-Smtp-Source: ABdhPJwDMPE5mxFkAdIEPsydvbToi3occBJKcP34/aUse6cI2g26/JOpXpPQhXbPZIK5rNFr8VeA1/88PRHN27GGbg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:2e07:: with SMTP id
 u7mr107298310ybu.393.1609816394868; Mon, 04 Jan 2021 19:13:14 -0800 (PST)
Date:   Tue,  5 Jan 2021 11:12:56 +0800
In-Reply-To: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20210105111219.Bluez.v4.3.Idca009971ca95228a3fa7232ef648f18ff64d185@changeid>
Mime-Version: 1.0
References: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v4 3/4] btmgmt: Add command set-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, apusaka@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add command set-sysconfig in btmgmt

Example usage:
[mgmt]# set-sysconfig -h
Parameters:
        -v <type:length:value>...
e.g.:
        set-sysconfig -v 001a:2:1234 001f:1:00
[mgmt]# set-sysconfig -v 8:2:abcd 1:02:0100 0016:2:0600

Reviewed-by: apusaka@chromium.org
---

(no changes since v2)

Changes in v2:
- Replace hard tabs with soft tabs in commit messages

 tools/btmgmt.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 7d83d3ee6bd5..850268b4c322 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1798,6 +1798,113 @@ static void cmd_read_sysconfig(int argc, char **argv)
 	}
 }
 
+static bool parse_mgmt_tlv(const char *input, uint16_t *type, uint8_t *length,
+								uint8_t *value)
+{
+	int i, value_starting_pos;
+
+	if (sscanf(input, "%4hx:%1hhu:%n", type, length,
+						&value_starting_pos) < 2) {
+		return false;
+	}
+
+	input += value_starting_pos;
+
+	if (*length * 2 != strlen(input))
+		return false;
+
+	for (i = 0; i < *length; i++) {
+		if (!sscanf(input + i * 2, "%2hhx", &value[i]))
+			return false;
+	}
+
+	return true;
+}
+
+static void set_sysconfig_rsp(uint8_t status, uint16_t len, const void *param,
+								void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Could not set default system configuration with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Set default system configuration success");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static bool set_sysconfig(int argc, char **argv)
+{
+	struct mgmt_tlv_list *tlv_list = NULL;
+	int i;
+	uint16_t index, type;
+	uint8_t length;
+	uint8_t value[256] = {};
+	bool success = false;
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	tlv_list = mgmt_tlv_list_new();
+	if (!tlv_list) {
+		error("tlv_list failed to init");
+		goto failed;
+	}
+
+	for (i = 0; i < argc; i++) {
+		if (!parse_mgmt_tlv(argv[i], &type, &length, value)) {
+			error("failed to parse");
+			goto failed;
+		}
+
+		if (!mgmt_tlv_add(tlv_list, type, length, value)) {
+			error("failed to add");
+			goto failed;
+		}
+	}
+
+	if (!mgmt_send_tlv(mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG, index,
+				tlv_list, set_sysconfig_rsp, NULL, NULL)) {
+		error("Failed to send \"Set Default System Configuration\""
+								" command");
+		goto failed;
+	}
+
+	success = true;
+
+failed:
+	if (tlv_list)
+		mgmt_tlv_list_free(tlv_list);
+
+	return success;
+}
+
+static void set_sysconfig_usage(void)
+{
+	bt_shell_usage();
+	print("Parameters:\n\t-v <type:length:value>...\n"
+		"e.g.:\n\tset-sysconfig -v 001a:2:1234 001f:1:00");
+}
+
+static void cmd_set_sysconfig(int argc, char **argv)
+{
+	bool success = false;
+
+	if (strcasecmp(argv[1], "-v") == 0 && argc > 2) {
+		argc -= 2;
+		argv += 2;
+		success = set_sysconfig(argc, argv);
+	}
+
+	if (!success) {
+		set_sysconfig_usage();
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void auto_power_enable_rsp(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -5078,6 +5185,8 @@ static const struct bt_shell_menu main_menu = {
 		cmd_exp_debug,		"Set debug feature"		},
 	{ "read-sysconfig",	NULL,
 		cmd_read_sysconfig,	"Read System Configuration"	},
+	{ "set-sysconfig",	"<-v|-h> [options...]",
+		cmd_set_sysconfig,	"Set System Configuration"	},
 	{} },
 };
 
-- 
2.29.2.729.g45daf8777d-goog

