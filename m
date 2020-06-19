Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F8CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF35223FB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esvSys0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgFSW4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgFSW4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 18:56:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D70C06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f16so11850330ybp.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=SXhIo9LNigC0v9REfYKXNQY9BqzfuMrJgk9FRI6OKaY=;
        b=esvSys0ZYYAsXBYjdomUT2HU6LMKSFWwQsKVzFA3HdQHvH3+DD0eY1iHmhYRUxugVJ
         L6lRy/SaBg9dXLgzz4hEyfK5aPV6Eeax6vwqHImcv4i/bhsDZ8nAiPJbmtegDlCi7Z/z
         n65A590w9cak5OTKR4VhfZQtIydGkJarJrxe7nFCOEyTtuzcH7xpoQ2o38rIyVWpyLt6
         NH9VDeL1vbSZnGNrtLom+y2eM6IogVZBsYgK0ZPJJzDm0MGLsY9ZLJosIJkXLeZoLB2z
         dCF7mCdL2wBX0nwcsPOOdYSRHFNVbYxZKoSL3IkYdkKtNMT+PYK45d6tLDfDq9weIXZW
         nsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=SXhIo9LNigC0v9REfYKXNQY9BqzfuMrJgk9FRI6OKaY=;
        b=X/b2YHaNOhbz53Umedy/risY3vkPeDcS89oGefrjMpQCIqiXfjGOM5xv9CtAB9Ly30
         IqbhNyHuLkSo89JmKZpc/+9sQ0ARiWsG5koDhum402fposiTcYWE8nYDWMXDAQsWdPd8
         Td506EVDbE5thomYEXPFpTVV45k7II5mdfb/jULafkFMvUXJ67a+Gx6Y5cFg+xpnf+eG
         v6dvJwaEGPbfYUwL3LJv7CuDBDSJjyEtMrU44JjlvspiTGwFYARXgSDiJWeeyYeHPOjw
         znGF8aonzZmVaM8fgjAA4U3+A0qLvi4hnZaJuQ75/bA43DT40UQH1bCcH0vgyRjTFAAN
         lCQg==
X-Gm-Message-State: AOAM532QwvJXdVB8USSx/M8wv/Q7IUxp7HcCOdnx7jMbWWpND3B5DC7m
        hOEbegsnJ1yJRkd3diHeLKYzyrRWX6BcllFeumRolp3Jl0BmtVCwC/oqyuhFgF1chjc47kGj1vb
        b4WA5ALKFmV292FwZXJk/P6mLAc2+4FcRStGQziV2n8GKKOPF7xH8qD3aOvE3G3iZN4PlHy12TA
        ORq0hX18pi9Og=
X-Google-Smtp-Source: ABdhPJznVjr4OQuKL+Vv/Ga/q4TlPBZilzMbW07fCgu1pDppmKIO75blu5Xx8kP4pn8ZBltg8LT3b3d8FnOrJDsZyw==
X-Received: by 2002:a25:ca45:: with SMTP id a66mr9966011ybg.164.1592607401939;
 Fri, 19 Jun 2020 15:56:41 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:56:23 -0700
In-Reply-To: <20200619225623.10200-1-michaelfsun@google.com>
Message-Id: <20200619155612.bluez.v4.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
Mime-Version: 1.0
References: <20200619225623.10200-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [bluez PATCH v4 3/3] btmgmt: Add command "add" into "monitor" btmgmt submenu
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, mcchou@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org, alainm@chromium.org,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces a new command =E2=80=98add=E2=80=99 within "monitor" =
submenu to
allow users to add advertisement monitor filters and get back monitor
handlers. An event handler is also added to handle kernel issued
MGMT_EV_ADV_MONITOR_ADDED events. The command will work with the new
MGMT opcode MGMT_OP_ADD_ADV_MONITOR. This patch only adds support for
adding pattern based filters.

Tested on Atlas Chromebook with a sample stdout below:
[mgmt]# add -p 0:1:c504 1:a:9a55beef
Advertisement monitor with handle:0x0005 added
[mgmt]# add -p 0:1:xxxx
Failed to parse monitor patterns.
Usage: add <-p|-h> [options...]
Monitor Types:
        -p <ad_type:offset:pattern>...  Pattern Monitor
e.g.:
        add -p 0:1:c504 1:a:9a55beef

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v4:
- Use regular options instead of optget options per feedback, and fix
endianness

Changes in v3:
- Fix build errors

Changes in v2:
- Move add command into submenu and fix build warnings

 tools/btmgmt.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 1c46041ccb18..48c9e58872f3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1013,6 +1013,20 @@ static void advertising_removed(uint16_t index, uint=
16_t len,
 	print("hci%u advertising_removed: instance %u", index, ev->instance);
 }
=20
+static void advmon_added(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_adv_monitor_added *ev =3D param;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) %s event", len, __func__);
+		return;
+	}
+
+	print("hci%u %s: handle %u", index, __func__,
+					le16_to_cpu(ev->monitor_handle));
+}
+
 static void advmon_removed(uint16_t index, uint16_t len, const void *param=
,
 							void *user_data)
 {
@@ -4658,6 +4672,112 @@ static void cmd_advmon_features(int argc, char **ar=
gv)
 	}
 }
=20
+static void advmon_add_rsp(uint8_t status, uint16_t len, const void *param=
,
+							void *user_data)
+{
+	const struct mgmt_rp_add_adv_patterns_monitor *rp =3D param;
+
+	if (status !=3D MGMT_STATUS_SUCCESS) {
+		error("Could not add advertisement monitor with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Advertisement monitor with handle:0x%04x added",
+					le16_to_cpu(rp->monitor_handle));
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static bool str2pattern(struct mgmt_adv_pattern *pattern, const char *str)
+{
+	int type_len, offset_len, offset_end_pos, str_len;
+	int i, j;
+	char pattern_str[62] =3D { 0 };
+	char tmp;
+
+	if (sscanf(str, "%2hhx%n:%2hhx%n:%s", &pattern->ad_type, &type_len,
+			&pattern->offset, &offset_end_pos, pattern_str) !=3D 3)
+		return false;
+
+	offset_len =3D offset_end_pos - type_len - 1;
+	str_len =3D strlen(pattern_str);
+	pattern->length =3D str_len / 2 + str_len % 2;
+
+	if (type_len > 2 || offset_len > 2 ||
+					pattern->offset + pattern->length > 31)
+		return false;
+
+	for (i =3D 0, j =3D 0; i < str_len; i++, j++) {
+		if (sscanf(&pattern_str[i++], "%2hhx", &pattern->value[j])
+									!=3D 1)
+			return false;
+		if (i < str_len && sscanf(&pattern_str[i], "%1hhx", &tmp) !=3D 1)
+			return false;
+	}
+
+	return true;
+}
+
+static void advmon_add_usage(void)
+{
+	bt_shell_usage();
+	print("Monitor Types:\n\t-p <ad_type:offset:pattern>..."
+		"\tPattern Monitor\ne.g.:\n\tadd -p 0:1:c504 1:a:9a55beef");
+}
+
+static bool advmon_add_pattern(int argc, char **argv)
+{
+	uint16_t index;
+	int i, cp_len;
+	struct mgmt_cp_add_adv_monitor *cp =3D NULL;
+	bool success =3D false;
+
+	index =3D mgmt_index;
+	if (index =3D=3D MGMT_INDEX_NONE)
+		index =3D 0;
+
+	cp_len =3D sizeof(struct mgmt_cp_add_adv_monitor) +
+			argc * sizeof(struct mgmt_adv_pattern);
+
+	cp =3D malloc0(cp_len);
+	cp->pattern_count =3D argc;
+
+	for (i =3D 0; i < argc; i++) {
+		if (!str2pattern(&cp->patterns[i], argv[i])) {
+			error("Failed to parse monitor patterns.");
+			goto done;
+		}
+	}
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR, index, cp_len,
+					cp, advmon_add_rsp, NULL, NULL)) {
+		error("Unable to send \"Add Advertising Monitor\" command");
+		goto done;
+	}
+
+	success =3D true;
+
+done:
+	free(cp);
+	return success;
+}
+
+static void cmd_advmon_add(int argc, char **argv)
+{
+	bool success =3D false;
+
+	if (strcasecmp(argv[1], "-p") =3D=3D 0 && argc > 2) {
+		argc -=3D 2;
+		argv +=3D 2;
+		success =3D advmon_add_pattern(argc, argv);
+	}
+
+	if (!success) {
+		advmon_add_usage();
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void advmon_remove_rsp(uint8_t status, uint16_t len, const void *pa=
ram,
 							void *user_data)
 {
@@ -4748,6 +4868,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_ADDED, index, advmon_added,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
 								NULL, NULL);
 }
@@ -4775,6 +4897,8 @@ static const struct bt_shell_menu monitor_menu =3D {
 					"features"			},
 	{ "remove",		"<handle>",
 		cmd_advmon_remove,	"Remove advertisement monitor "	},
+	{ "add",		"<-p|-h> [options...]",
+		cmd_advmon_add,		"Add advertisement monitor"	},
 	{ } },
 };
=20
--=20
2.27.0.111.gc72c7da667-goog

