Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4169C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBCB20853
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZhLlwWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgFQG05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQG04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:26:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6172C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e82so1423086ybh.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=SoYlWLI+33p19wNmYw7plTycfez+rmjmJaOynsuUNes=;
        b=TZhLlwWO1LDE91onGjzLhhPOYaIX08XNk+NAXAjNeOHQ6AmDkz+MKeId5cPxMv3fDt
         PGuf5fBUB0Hy1nvmCi2djt/4yX9+vjN7idImWpeZ1JmU/dYwodpYb9El+w53YNaP5WBV
         1GdlBtVHT8zaQClicocxpHptALufP+PprbXICKbIIbpwrgO+LYN2EZg+7TrIPptdvPIl
         Ay/VY+/sjTtd7yRA2+66r1wW11sWeCwtJEhdcp3wctWZH0P0No58KVfJHgg+W6nrKLTq
         reNItVM6oWv+vWijbjJaVLVI4sHK6rZh3R6yd7pW9CFvCpEix1WXEQChDhGJ+00I1RcJ
         jZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=SoYlWLI+33p19wNmYw7plTycfez+rmjmJaOynsuUNes=;
        b=uL8xrK6jzhJ/du7FRVsQFnB3tgSqQHs1Ke4BnKaEjt276jnkvb33WL/uWy3iBLZ28O
         xMCJ/IseCygBGbzd8LWjIdgyMS1PxU4mFKt9GClbOTyok6AZVmpqoa1E0P7lmSQNR/0E
         dMTdCMWUiSD6XYCQM+STaRdhUff2FgKzTf4hVSyFnZnRtUb1ByYHdB+f7Og0tun4Kp2J
         Wwj8RROTWqNcmbZez+uGMh6VkfyHUe1tvxatxCTLvKVRLYswBapo9EiG6QmI8NgwPK67
         RM/lE8T6ZChojq1i52mNAiWGMZgvOGJLPBjOLqvXSLzy8YW9zhMbRgNh5VGVO+tAeNc3
         LjWg==
X-Gm-Message-State: AOAM533mmmyN+l01TjjdGyFGCyNuuDAisaQ1GdJEU/gWALkuWihFc+wz
        iJQJPB5RcY7jXGBRimq8j4AfKwEpDCJ4bx3tFBz5EPswgSIFfsZyoj1GgncckIAojNKjZet1nHn
        7h9zZtkeiI9cmDHLFg3GKsmz5IC4u++nRHSTSotSx4bOCv7D422es8lsP0L9o7CDDUrXVNZy6B5
        BY2Qyq4l0KOcQ=
X-Google-Smtp-Source: ABdhPJx30w8wThqD1dT0adDxA9vrSz19+Xh+bTcViw1YgPy1/I4Wrnz2yogieqOtHpGgP8fpWmP6ZXh+Dtx5juINyw==
X-Received: by 2002:a25:2604:: with SMTP id m4mr9945084ybm.470.1592375214994;
 Tue, 16 Jun 2020 23:26:54 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:26:46 -0700
In-Reply-To: <20200617062646.165307-1-michaelfsun@google.com>
Message-Id: <20200616232642.bluez.v2.3.I29854cfe9ccae25c34666856326c07cd680151b1@changeid>
Mime-Version: 1.0
References: <20200617062646.165307-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v2 3/3] btmgmt: Add command "add" into "monitor" btmgmt submenu
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mcchou@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        luiz.von.dentz@intel.com, Michael Sun <michaelfsun@google.com>
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

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v2: None

 tools/btmgmt.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 5a70e9e1c3e9..22d59ccb3011 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1013,6 +1013,19 @@ static void advertising_removed(uint16_t index, uint=
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
+	print("hci%u %s: handle %u", index, __func__, ev->monitor_handle);
+}
+
 static void advmon_removed(uint16_t index, uint16_t len, const void *param=
,
 							void *user_data)
 {
@@ -4657,6 +4670,148 @@ static void cmd_advmon_features(int argc, char **ar=
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
+							rp->monitor_handle);
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static bool str2pattern(struct mgmt_adv_pattern *pattern, const char *str)
+{
+	int type_len, offset_len, offset_end_pos, length, str_len;
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
+	print("Options:\n"
+		"\t-P, --pattern <ad_type:offset:pattern>  "
+		"Advertising data bytes\n"
+		"Monitor Types:\n"
+		"\t-p, --pattern-monitor			"
+		"Pattern Monitor\n"
+		"e.g.:\n"
+		"\tadd -P 0:1:c504 -P 1:a:9a55beef -p");
+}
+
+static struct option advmon_add_options[] =3D {
+					{ "help", 0, 0, 'h' },
+					{ "pattern-monitor", 0, 0, 'p' },
+					{ "pattern", 1, 0, 'P' },
+					{ 0, 0, 0, 0 } };
+
+static void cmd_advmon_add(int argc, char **argv)
+{
+
+	uint16_t index;
+	void *cp =3D NULL;
+	struct mgmt_adv_pattern *patterns =3D NULL;
+	int opt, i;
+	int pattern_count =3D 0, patterns_len, cp_len;
+	bool success =3D false, type_selected =3D false;
+
+	index =3D mgmt_index;
+	if (index =3D=3D MGMT_INDEX_NONE)
+		index =3D 0;
+
+	while ((opt =3D getopt_long(argc, argv, "P:ph", advmon_add_options,
+								NULL)) !=3D -1) {
+		switch (opt) {
+		case 'P':
+			patterns_len =3D (pattern_count + 1) *
+					sizeof(struct mgmt_adv_pattern);
+			patterns =3D realloc(patterns, patterns_len);
+
+			if (!str2pattern(&patterns[pattern_count++], optarg)) {
+				error("Failed to parse monitor patterns.");
+				goto done;
+			}
+			break;
+		case 'p':
+			if (!pattern_count) {
+				advmon_add_usage();
+				goto done;
+			}
+			cp_len =3D
+				sizeof(struct mgmt_cp_add_adv_monitor) +
+				patterns_len;
+			cp =3D realloc(cp, cp_len);
+
+			((struct mgmt_cp_add_adv_monitor *)cp)
+					->pattern_count =3D pattern_count;
+
+			memcpy(((struct mgmt_cp_add_adv_monitor *)cp)
+					->patterns, patterns, patterns_len);
+			type_selected =3D true;
+			break;
+		case 'h':
+			success =3D true;
+			/* fall through */
+		default:
+			advmon_add_usage();
+			goto done;
+		}
+	}
+
+	argc -=3D optind;
+	argv +=3D optind;
+
+	if (argc || !type_selected) {
+		advmon_add_usage();
+		goto done;
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
+	optind =3D 0;
+	free(patterns);
+	free(cp);
+	if (!success)
+		bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void advmon_remove_rsp(uint8_t status, uint16_t len, const void *pa=
ram,
 							void *user_data)
 {
@@ -4747,6 +4902,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_ADDED, index, advmon_added,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
 								NULL, NULL);
 }
@@ -4774,6 +4931,8 @@ static const struct bt_shell_menu monitor_menu =3D {
 					"features"			},
 	{ "remove",		"<handle>",
 		cmd_advmon_remove,	"Remove advertisement monitor "	},
+	{ "add",		"[options] <-p|-h>",
+		cmd_advmon_add,		"Add advertisement monitor"	},
 	{ } },
 };
=20
--=20
2.27.0.290.gba653c62da-goog

