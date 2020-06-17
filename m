Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84152C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A021475
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeGUhcKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQHzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 03:55:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EFC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r17so1576062ybj.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=AHug7416TrGAN+DxUi/X/EFoDospBelapopGrAcTGls=;
        b=oeGUhcKdwtkA2Ait2uyV15TDLHTnqC+pxZVXO/POSYMRy0nH+mk4bHbKZuOR2lrQVl
         aYRLvJqfa1YY8pBlTtKimAkY0RM19cI5Ti835XG1ZA3KHWfb/ZY/v8PrmKQW4AVSGKoI
         Rh7+NMol+oXKGDJi5X/dhrXr8iHkmMT4OW/ZTMiDDKhAe25mxNSXziALCE6KePBUenSX
         i7j8rGl/gBHP9s/v+NvHZYwlbBSuvAYNijwqb1vvRfijk63vwTK1brZypjJYQ+auyu0S
         f1MOb6lwsujP7ippWeS2Uy0d/25CNXkxCzWdqn1GAJi+GxRsod6lEj1SCqDDPYYQEc4p
         gFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=AHug7416TrGAN+DxUi/X/EFoDospBelapopGrAcTGls=;
        b=EHaXlQoq2W8eDk/Peqj/8KLvFbdn3K7DElRYYYT6MdAg20YivxDVfZPSVHVrpWpaF2
         7gEZqNKo4h1Kx+sT+9DpqSJOi4yALRbJvvFaYoOz0P8obvTm/B9v8UUMRT/HBhInxBDF
         lPM7KL57DMhR2/wZWkUkhOzzEsF2s4b322UEbjIjO36nMB+IoyEHVYakQVYDk7kiQAkf
         8DuEzqqY7CxK7BAV26wR9+GhZsixZDksox0VMghmdSJwaHqujR/KmNQ404JUCgLAatB0
         KDPn4PHNrw4EOFuvgCTM1UoCRTqUTPY9FYY9gBPFi0+pZWrZJI/VNaPPDhGRq6yhCyd1
         aivA==
X-Gm-Message-State: AOAM533TjqD5D96s3c3Wj4W3rWQiwZFFfFK7KP2/of0qkXkNGuwjAwKT
        d82tgZa+gWau2pUqLG/HAfeyPdvR3IZZQskZr0G+Eo3zM9kezylx4Uw+cyI2ou8W4CcBCKUGnJM
        s/TC9GlYltJ3Gpg9RNwkmzYo8QsfdPxTmhNIE6TprGgb6hSL59/8ESCw7TZ018sx6f6sr/7KcM4
        9xy2RonW2NsL4=
X-Google-Smtp-Source: ABdhPJw/Cvm7nFrB1civXfysyEwJsAXJHWQ1dcwURTplo/trq8v6saZmwmwC4vMSMOi797Rn6OwJoXHZpLsRJBK4uA==
X-Received: by 2002:a25:b88d:: with SMTP id w13mr10576465ybj.520.1592380544789;
 Wed, 17 Jun 2020 00:55:44 -0700 (PDT)
Date:   Wed, 17 Jun 2020 00:55:36 -0700
In-Reply-To: <20200617075536.98672-1-michaelfsun@google.com>
Message-Id: <20200617005531.bluez.v3.3.I55df963e4055bf1778db6f9e46f166b88472e051@changeid>
Mime-Version: 1.0
References: <20200617075536.98672-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v3 3/3] btmgmt: Add command "add" into "monitor" btmgmt submenu
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        luiz.von.dentz@intel.com, alainm@chromium.org,
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

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v3:
- Fix build errors

Changes in v2:
- Move add command into submenu and fix build warnings

 tools/btmgmt.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 5a70e9e1c3e9..ce2a198b1b29 100644
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
@@ -4587,7 +4600,7 @@ static const char * const advmon_features_str[] =3D {
 static const char *advmon_features2str(uint32_t features)
 {
 	static char str[512];
-	int off, i;
+	unsigned int off, i;
=20
 	off =3D 0;
 	snprintf(str, sizeof(str), "\n\tNone");
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
+	int opt, patterns_len;
+	int pattern_count =3D 0, cp_len =3D 0;
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

