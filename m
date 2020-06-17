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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B25C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53E421501
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6EcvM3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFQHzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQHzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 03:55:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7519C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s7so1627232ybg.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=kMhRDzlGP4OVBvVNpjBjO9yKhZDDBHzVjRXl2j9FDQc=;
        b=k6EcvM3SYylF/mj6Frwg2IKJFXg8eZz88W7J6Rf2Lwk9Zvj1+a9pn9LFbBlfBnNS0/
         cdQAOqLiknjdYJxsKKVPLzCPVNwDuH91m3aEGy38IpgbfxqUzzac58l5N0RHDITVJmti
         tDrEjXmWdW9uuQtcF0ljqRSauUWKOCnB22EXb7/3Xb4PEFPDW+8FZRzUVGjPdWRhdhKS
         8/tv6pPPHmzJmIl2qMl/0e/9z09xl644kptNlhRdbPzoO08KfKr7I4dyxS1WUCndfnzG
         Ml0I8f1Z/qn1p4AXwm5zfZgIWrw3uEfm9cc4NF4++ZdRGYla7gYlahBMQ/r9Af5tuLQ2
         lFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=kMhRDzlGP4OVBvVNpjBjO9yKhZDDBHzVjRXl2j9FDQc=;
        b=nmWrDi2x9vNx4Cxkf0l9lcVRFs21Ll5Z8vNN4ikwrhbWkYvzZq+rLJ10qXkIqJbATp
         5/uP535P8ZS1hZUOJBdJk1WRTAhZ/LCc6ki/U62YeiE+Ct+Q9pm1VTImC01LfCb6491Y
         XAEDXPpD0kM+KJe+r4ilYhxnaBbLlzIOyvEu4dFEDxD1//yrR2zac7YX+e3g90yqEWoH
         2BF/r/ci4s4QJmiPoE0K/m+meinU2gU2IJcVljnRrwUwzScpA0701sWvhXpimzBFbVSY
         vWJS7MCuArncuqKUdcL/hX6GBNYXojCzBCnDb3XTB2aAc+CuEVgPFsIiukXMyFBzM5CX
         jj6g==
X-Gm-Message-State: AOAM532QRCoVkVeauUa+2xX647oSsdXnKOQhTXX2mNvYv5UzgJ+oNN3T
        LBXW/WCzRKN6jNbcIj2R1Raz96wdgUEDHWzyQNWmiqUZQNgjzTu7vu9n6h7YKacvUkY+qICSakO
        EpQoDxhXZubjsK+j/y8Gkn0FfdBcKUq+MeMFhceUnNjX+gWR+kMsUPl5NhIV+N/F6Df/4/9gNVg
        u7ZWGCSK0ZcQM=
X-Google-Smtp-Source: ABdhPJxN48bh0OBAqWE3ZnE4QeSjU3qocVBtf+NPv+esu70SAH/PQE8cdLCwji51wljNZ9KouzOMNqrpbNcSz9KwFw==
X-Received: by 2002:a25:3784:: with SMTP id e126mr11365271yba.267.1592380540948;
 Wed, 17 Jun 2020 00:55:40 -0700 (PDT)
Date:   Wed, 17 Jun 2020 00:55:34 -0700
In-Reply-To: <20200617075536.98672-1-michaelfsun@google.com>
Message-Id: <20200617005531.bluez.v3.1.Ia9d7e5ca8da3bb6e1356b2b0e6fa18fafa022af0@changeid>
Mime-Version: 1.0
References: <20200617075536.98672-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v3 1/3] btmgmt: Add "monitor" btmgmt submenu and command "features"
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

This patch introduces a new submenu "monitor" along with command
=E2=80=98features=E2=80=99 to help user query for supported advertisement f=
eatures. The
command will work with the new MGMT opcode
MGMT_OP_READ_ADV_MONITOR_FEATURES.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v3: None
Changes in v2:
- Move features command into submenu and fix build warnings

 tools/btmgmt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 46e7465b31c9..a0487d4de178 100644
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
+	int off, i;
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
+	if (len < sizeof(*rp) + rp->num_handles * sizeof(uint16_t)) {
+		error("Handles count (%u) doesn't match reply length (%u)",
+							rp->num_handles, len);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	supported_features =3D le32_to_cpu(rp->supported_features);
+	enabled_features =3D le32_to_cpu(rp->enabled_features);
+	num_handles =3D le16_to_cpu(rp->num_handles);
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
2.27.0.290.gba653c62da-goog

