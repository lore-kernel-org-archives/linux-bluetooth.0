Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C662074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMIyZLpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFPADf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPADd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:03:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5BC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id k23so15411583qtb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=P8sypJtpBIoUK0gFq2shspleE46NBUSITI+9t3y6wLg=;
        b=MMIyZLpP7PvVUwB/FzkBHtZ6KEedPwelOp68ZTf1r6vx/2QiVYa2oqGzdOaBHFJVBH
         FUScv8X3shOPWG8sn8TF0BeZxJjlRhcbMTXwhemtd77X4mzRG97SZub1pk+4994CQEYP
         LuizN6saipNAPRCGXQ1EWXHqnsl0XPnCTu84RSQSILLP3pMhsipQaViWWzmJeiRufHgb
         1mpoCf0+hm2bDcY0Z3Srg0jpiu47jU1UfTfyh91rYDvmfQDl3jVSoI0hv0FtU7P+q/0c
         1fIGnqbRJ3z/Ea4fg6P8VDncYrv2X573D/QpSE8C8cmikYn82hg0O9WFJaPqfBbdl7WZ
         13IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=P8sypJtpBIoUK0gFq2shspleE46NBUSITI+9t3y6wLg=;
        b=f66LohLqye42cpMs++7+dnijYIni9kprBQ0por9k6SiN3wUccC7zENLPM3Dv3XGJg8
         WIgoY5WToDDlkfPp7bkEJSHuQcYQOhpAE8nKmJFGJzYmPNnAmEZpTe9oulEAnL8A50Rl
         0g7wHSFFVvrH8ykOQ2WpF2g9hyE/8F5iXH+jokkp5HcN2VQXQ7daijianLcv5fvbMHyt
         5OHg1MMffjZc0eqOvjeR51oOMSx/u+I+tu7RAU05mSVITOgLhobEMldJxxRHEYCH1gqO
         sCHc6ssActz15GcaHtPhZpRbHnPL0U+hS6o87MdGud1Dvsi/20g7QdB4n01mTRbVncxf
         foLg==
X-Gm-Message-State: AOAM532iZg8TNbhZZ67HaZLKMydS7d+JaRHeT2PU1tJa8/nHvHFTWSDB
        OO/kgPHWJ6KFJlH4GD9dK65uvItl+2uoz/d/j0ZlAPIAxCyf+Nzhdm0OxKOY5KKgpRD7fw/Df5m
        mIjyL8t6Kvhaf7X28cz2SFEBPIvYf8t7PZPU0u5QeHS8OiEwwzRcBO/yd4mK87K7Bu0/WU/ki1w
        22PDQ1KNrrNSo=
X-Google-Smtp-Source: ABdhPJyZaKVjhYo7XFEMHBD10vphC0JtgA0K1wrMJ3iAznPOE3d35mzJuiL8OrpiIxbBNDnWlSFtfBw2EWkD/hJUXA==
X-Received: by 2002:ad4:552b:: with SMTP id ba11mr278705qvb.145.1592265812333;
 Mon, 15 Jun 2020 17:03:32 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:03:18 -0700
In-Reply-To: <20200616000318.42664-1-michaelfsun@google.com>
Message-Id: <20200616000318.42664-4-michaelfsun@google.com>
Mime-Version: 1.0
References: <20200616000318.42664-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v1 3/3] btmgmt: Add btmgmt command advmon-add
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com,
        chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces a new btmgmt command =E2=80=98advmon-add=E2=80=99 to =
allow users
to add advertisement monitor filters and return monitor handlers. An
event handler is also added to handle kernel issued
MGMT_EV_ADV_MONITOR_ADDED events. The command will work with the new
MGMT opcode MGMT_OP_ADD_ADV_MONITOR. This patch only adds support for
adding pattern based filters.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 tools/btmgmt.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 719e92196..2bdaf03fa 100644
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
+		error("Too small (%u bytes) advmon_removed event", len);
+		return;
+	}
+
+	print("hci%u advmon_added: handle %u", index, ev->monitor_handle);
+}
+
 static void advmon_removed(uint16_t index, uint16_t len, const void *param=
,
 							void *user_data)
 {
@@ -4658,6 +4671,147 @@ static void cmd_advmon_features(int argc, char **ar=
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
+		if (!sscanf(&pattern_str[i++], "%2hhx", &pattern->value[j]))
+			return false;
+		if (i < str_len && !sscanf(&pattern_str[i], "%1hhx", &tmp))
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
+		"\t -P, --pattern <ad_type:offset:pattern> "
+		"Advertising Data bytes\n"
+		"Monitor Types:\n"
+		"\t -p, --pattern-monitor			"
+		"Pattern Monitor\n"
+		"e.g.:\n"
+		"\tadvmon-add -P 0:1:c504 -P 1:a:9a55beef -p");
+}
+
+static struct option advmon_add_options[] =3D
+					{ { "help", 0, 0, 'h' },
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
+				sizeof(struct mgmt_cp_add_adv_patterns_monitor) +
+				patterns_len;
+			cp =3D realloc(cp, cp_len);
+
+			((struct mgmt_cp_add_adv_patterns_monitor *)cp)
+					->pattern_count =3D pattern_count;
+
+			memcpy(((struct mgmt_cp_add_adv_patterns_monitor *)cp)
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
@@ -4748,6 +4902,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_ADDED, index, advmon_added,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
 								NULL, NULL);
 }
@@ -4910,6 +5066,8 @@ static const struct bt_shell_menu main_menu =3D {
 	{ "advmon-features",	NULL,
 		cmd_advmon_features,	"Show advertisement monitor "
 					"features"			},
+	{ "advmon-add",		"[options] <-p|-h>",
+		cmd_advmon_add,		"Add advertisement monitor "	},
 	{ "advmon-remove",	"<handle>",
 		cmd_advmon_remove,	"Remove advertisement monitor "	},
 	{} },
--=20
2.27.0.290.gba653c62da-goog

