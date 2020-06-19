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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C635C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2880121D7D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCfziuW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgFSW4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgFSW4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 18:56:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25382C06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l19so8294485qtp.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=roAyZpjVSESurkaK6RP9hHgfsiB7rFjIxv3cT1jDzMg=;
        b=aCfziuW590Vw5kWK+wketdQr5Z+o2Cm9O2UiG1XhEUyDmNstt0Y+0p1UCjsmNC5/sn
         P1Cp0Vd54wqoBtAq2z0/rEtOSz3G+5n8amvNOlwPKyFCaXCwtKZWx9/Y86lqrGAM4RmX
         I5l9bsvAdneovsW7JJ09/mNf0KbPjcjR2KRBNwTFywJ4w1nT76iJvLJOk8lCsocTfH+D
         aeKeqHJge/hHd4rOYAmZQRdxKOQkt2MPJBmU7s0I9f4lEuoS3nLK5Ivki7efptXRl61X
         odhhEDZrhfddPRuuxwZv0wk0WTnASWv9mkkIZBQ7rgv67QkwABzvVf0wyiVonA+Fz3YF
         Ghuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=roAyZpjVSESurkaK6RP9hHgfsiB7rFjIxv3cT1jDzMg=;
        b=bpZBu4+C8AOzJbXEtQqXXmRjKUqB+IpmvnbxP6QQW8sHidG8CQCci7cLbLBvZe/AjU
         fozazZTgCrnK3k9k2ZLWrsmojWOtLMwfV5Yydql3LxgBwlrqU/Lc1k0xOVI4mykKXlGl
         5dLsqpbl2Ez1YRPl1bZg4umT59XCdQM3pSzHTkNgLQ2ViX008+K4eq5Sdb7EClcZnTqg
         YnVgmODEQSNn72Bu0m1Om8wB8zx67DwRgOkwA6oJsALzZfG/y7IM0EYbuEE81EJy1IRA
         FPH132awtamv2aCzxQSjos8CDc91kYuDeGU+lUU3XJqCBAQCJiZj4vhhCF5TneTa2Rcx
         CJmw==
X-Gm-Message-State: AOAM532XMEU+lgHkWWDvZOnklEDViRi9GeLtYd93eXka+SanyNisGDao
        TP+VNS27M43tWsaFnHXag1SzmrF/ba6VB2h3ZjiQ5XyN4T6EL71qYXEFwSk+NZ5txSAUzZUGKw7
        M3iUbUeqn6v3Alb9poLxqrBaMOczeAJVv2V6RZezWGugVETI3MmX8FLn9Jd8RgGKfGMPf8nqrA6
        wH49PzzSA3M8o=
X-Google-Smtp-Source: ABdhPJy2bytPUwEqwWeMfLZE00f/RAmHZ5fZkYcyxm/rLyJFUVLl0VIjzTbsw1+MwUYgVwj6qAbXmxxejwf9+q641w==
X-Received: by 2002:ad4:556e:: with SMTP id w14mr11073069qvy.137.1592607396161;
 Fri, 19 Jun 2020 15:56:36 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:56:21 -0700
In-Reply-To: <20200619225623.10200-1-michaelfsun@google.com>
Message-Id: <20200619155612.bluez.v4.1.Ia9d7e5ca8da3bb6e1356b2b0e6fa18fafa022af0@changeid>
Mime-Version: 1.0
References: <20200619225623.10200-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [bluez PATCH v4 1/3] btmgmt: Add "monitor" btmgmt submenu and command "features"
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

This patch introduces a new submenu "monitor" along with command
=E2=80=98features=E2=80=99 to help user query for supported advertisement f=
eatures. The
command will work with the new MGMT opcode
MGMT_OP_READ_ADV_MONITOR_FEATURES.

Tested on Atlas Chromebook with a sample stdout below:
[mgmt]# features
Supported features:
        None
Enabled features:
        None
Max number of handles: 32
Max number of patterns: 16
Handles list with 2 items:
        0x0001
        0x0002

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Move features command into submenu and fix build warnings

 tools/btmgmt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 46e7465b31c9..f50d29651346 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4567,6 +4567,83 @@ static void cmd_wbs(int argc, char **argv)
 	cmd_setting(MGMT_OP_SET_WIDEBAND_SPEECH, argc, argv);
 }
=20
+static const char * const advmon_features_str[] =3D {
+	"Pattern monitor with logic OR.",
+};
+
+static const char *advmon_features2str(uint32_t features)
+{
+	static char str[512];
+	unsigned int off, i;
+
+	off =3D 0;
+	snprintf(str, sizeof(str), "\n\tNone");
+
+	for (i =3D 0; i < NELEM(advmon_features_str); i++) {
+		if ((features & (1 << i)) !=3D 0 && off < sizeof(str))
+			off +=3D snprintf(str + off, sizeof(str) - off, "\n\t%s",
+						advmon_features_str[i]);
+	}
+
+	return str;
+}
+
+static void advmon_features_rsp(uint8_t status, uint16_t len, const void *=
param,
+							void *user_data)
+{
+	const struct mgmt_rp_read_adv_monitor_features *rp =3D param;
+	uint32_t supported_features, enabled_features;
+	uint16_t num_handles;
+	int i;
+
+	if (status !=3D MGMT_STATUS_SUCCESS) {
+		error("Reading adv monitor features failed with status 0x%02x "
+					"(%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		error("Too small adv monitor features reply (%u bytes)", len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	supported_features =3D le32_to_cpu(rp->supported_features);
+	enabled_features =3D le32_to_cpu(rp->enabled_features);
+	num_handles =3D le16_to_cpu(rp->num_handles);
+
+	if (len < sizeof(*rp) + num_handles * sizeof(uint16_t)) {
+		error("Handles count (%u) doesn't match reply length (%u)",
+							num_handles, len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Supported features:%s", advmon_features2str(supported_features));
+	print("Enabled features:%s", advmon_features2str(enabled_features));
+	print("Max number of handles: %u", le16_to_cpu(rp->max_num_handles));
+	print("Max number of patterns: %u", rp->max_num_patterns);
+	print("Handles list with %u item%s", num_handles,
+			num_handles =3D=3D 0 ? "" : num_handles =3D=3D 1 ? ":" : "s:");
+	for (i =3D 0; i < num_handles; i++)
+		print("\t0x%04x ", le16_to_cpu(rp->handles[i]));
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_advmon_features(int argc, char **argv)
+{
+	uint16_t index;
+
+	index =3D mgmt_index;
+	if (index =3D=3D MGMT_INDEX_NONE)
+		index =3D 0;
+
+	if (!mgmt_send(mgmt, MGMT_OP_READ_ADV_MONITOR_FEATURES, index, 0, NULL,
+					advmon_features_rsp, NULL, NULL)) {
+		error("Unable to send advertising monitor features command");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 {
 	mgmt_register(mgmt, MGMT_EV_CONTROLLER_ERROR, index, controller_error,
@@ -4635,6 +4712,16 @@ static void cmd_select(int argc, char **argv)
 	update_prompt(mgmt_index);
 }
=20
+static const struct bt_shell_menu monitor_menu =3D {
+	.name =3D "monitor",
+	.desc =3D "Advertisement Monitor Submenu",
+	.entries =3D {
+	{ "features",		NULL,
+		cmd_advmon_features,	"Show advertisement monitor "
+					"features"			},
+	{ } },
+};
+
 static const struct bt_shell_menu main_menu =3D {
 	.name =3D "main",
 	.entries =3D {
@@ -4815,6 +4902,7 @@ int main(int argc, char *argv[])
=20
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
+	bt_shell_add_submenu(&monitor_menu);
=20
 	mgmt =3D mgmt_new_default();
 	if (!mgmt) {
--=20
2.27.0.111.gc72c7da667-goog

