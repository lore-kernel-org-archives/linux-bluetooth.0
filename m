Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB00FC47082
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE23613D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEZFOq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhEZFOp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:14:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E5C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i5so24604923pgm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5qSqx3TwuZ8VsmUQSyplqhBBlTtHbqLkNIGiOXodxw=;
        b=fTP39yXqqzvXM0GK4pQGyOpTF+SJJzxNyTuplT5txEw8iUhh+aPIDYj+/mH1cautGK
         tE+2Hxd8YysEEMD30tioOc610IIP0UPTmSqhH9AmBMCSQ0SEI+x0SOpjFQcQlnW0JL3m
         6RaJGBcIlOSEWyBA/rpul/33jQ0nuCUR0ixG1BBcDQ+mTTvt41MAtWZJ/lNrn5M37RCq
         UKefwwVpexaimJ1KJts68IqHYU5ezWIkMAayFA6F4WFZVse5Eo1xuarOq78dh8FjGvdp
         Z9h4b5RrCp8Un+mt2Y+pDzHE5Wa93DzpYB21/tw8h/YGG091KejS3nutgnduvihv+w8C
         ME2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5qSqx3TwuZ8VsmUQSyplqhBBlTtHbqLkNIGiOXodxw=;
        b=WWXTiAoKcCKYbgTdNyyPC8hJCTj6e/Yhpu4Np8zGOkVdDk1HMjWmVKRzAyv76kaNkC
         Mkfx9BGz+67YeaHcBuNz0+OVwgzoCkAP52D/LJjnjTa6G+y+xo7WQqm73FMbCSiDNsgr
         JzTnymF9hiwP3g4hhuF8VgWqBVdRDWCe+PjiK2dx9D1QixZj4fIqzILQU3paafP4O3oc
         cHXqKY1CY2/7c0jFA7AQelA06wE7Ez5tEAGYQxQ+x1x+K3Gs3km+voRoT4JRZd7weLs1
         vSNRrws08Bml0vdbFTfyF3bItezznxPTQZSWKb5VSqmXbqfFstrQ3TgxOybklJfnN7ii
         70FQ==
X-Gm-Message-State: AOAM533D6+obiShVJ64mxYWikSmdjSn8yNMcdXhlpd/sndcJ8EX2KDqw
        vTNXJmLpKRLndfA1DtoFPp9NjheZIwb9FA==
X-Google-Smtp-Source: ABdhPJwllc2xGqHVnSqwPoD57B4NCA8ecPHSS/gaQ5P5qsJuLQKm5/ZLTdFGUqxdh8U/m2WczUKm/Q==
X-Received: by 2002:a63:b545:: with SMTP id u5mr22822391pgo.261.1622005992600;
        Tue, 25 May 2021 22:13:12 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id h8sm13865944pfv.60.2021.05.25.22.13.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:13:11 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 1/4] tools/btmgmt: Add device flags commands
Date:   Tue, 25 May 2021 22:13:07 -0700
Message-Id: <20210526051310.423630-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds commands for get/set device flags mgmt ops.

Usage:

get-flags [-t type] <address>
        -t type    Address Type
                      0 BR/EDR
                      1 LE Public
                      2 LE Random

set-flags [-f flags] [-t type] <address>
        -t type    Address Type
                      0 BR/EDR
                      1 LE Public
                      2 LE Random
        -f flags   Device flag.
                      1 Remote Wake Enable
---
 tools/btmgmt.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index bf3b460d0..a6ac026dc 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1000,6 +1000,24 @@ static void advertising_removed(uint16_t index, uint16_t len,
 	print("hci%u advertising_removed: instance %u", index, ev->instance);
 }
 
+static void flags_changed(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_device_flags_changed *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) %s event", len, __func__);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	print("hci%u device_flags_changed: %s (%s)", index, addr,
+							typestr(ev->addr.type));
+	print("     supp: 0x%08x  curr: 0x%08x",
+					ev->supported_flags, ev->current_flags);
+}
+
 static void advmon_added(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -2110,6 +2128,156 @@ static void cmd_auto_power(int argc, char **argv)
 	}
 }
 
+static void get_flags_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_rp_get_device_flags *rp = param;
+
+	if (status != 0) {
+		error("Get device flags failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Supported Flags: 0x%08x", rp->supported_flags);
+	print("Current Flags:   0x%08x", rp->current_flags);
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static struct option get_flags_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_get_flags(int argc, char **argv)
+{
+	struct mgmt_cp_get_device_flags cp;
+	uint8_t type = BDADDR_BREDR;
+	char addr[18];
+	int opt;
+	uint16_t index;
+
+	while ((opt = getopt_long(argc, argv, "+t:h", get_flags_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		default:
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		bt_shell_usage();
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	str2ba(argv[0], &cp.addr.bdaddr);
+	cp.addr.type = type;
+
+	ba2str(&cp.addr.bdaddr, addr);
+	print("Get device flag of %s (%s)", addr, typestr(cp.addr.type));
+
+	if (mgmt_send(mgmt, MGMT_OP_GET_DEVICE_FLAGS, index, sizeof(cp), &cp,
+					get_flags_rsp, NULL, NULL) == 0) {
+		error("Unable to send Get Device Flags command");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void set_flags_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0) {
+		error("Set device flags failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static struct option set_flags_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "type",	1, 0, 't' },
+	{ "flags",	1, 0, 'f' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_set_flags(int argc, char **argv)
+{
+	struct mgmt_cp_set_device_flags cp;
+	uint8_t type = BDADDR_BREDR;
+	uint32_t flags = 0;
+	char addr[18];
+	int opt;
+	uint16_t index;
+
+	while ((opt = getopt_long(argc, argv, "+f:t:h", set_flags_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'f':
+			flags = strtol(optarg, NULL, 0);
+			break;
+		case 't':
+			type = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		default:
+			bt_shell_usage();
+			optind = 0;
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		bt_shell_usage();
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	index = mgmt_index;
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	memset(&cp, 0, sizeof(cp));
+	str2ba(argv[0], &cp.addr.bdaddr);
+	cp.addr.type = type;
+	cp.current_flags = flags;
+
+	ba2str(&cp.addr.bdaddr, addr);
+	print("Set device flag of %s (%s)", addr, typestr(cp.addr.type));
+
+	if (mgmt_send(mgmt, MGMT_OP_SET_DEVICE_FLAGS, index, sizeof(cp), &cp,
+					set_flags_rsp, NULL, NULL) == 0) {
+		error("Unable to send Set Device Flags command");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+}
+
 /* Wrapper to get the index and opcode to the response callback */
 struct command_data {
 	uint16_t id;
@@ -5197,6 +5365,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_DEVICE_FLAGS_CHANGED, index,
+					flags_changed, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_ADDED, index, advmon_added,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
@@ -5381,6 +5551,10 @@ static const struct bt_shell_menu main_menu = {
 		cmd_read_sysconfig,	"Read System Configuration"	},
 	{ "set-sysconfig",	"<-v|-h> [options...]",
 		cmd_set_sysconfig,	"Set System Configuration"	},
+	{ "get-flags",		"[-t type] <address>",
+		cmd_get_flags,		"Get device flags"		},
+	{ "set-flags",		"[-f flags] [-t type] <address>",
+		cmd_set_flags,		"Set device flags"		},
 	{} },
 };
 
-- 
2.26.3

