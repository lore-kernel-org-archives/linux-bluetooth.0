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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8305C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884B520767
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9Z6gsUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFPADd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPADa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:03:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC0C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b135so22802273yba.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=0S8jfx64Oylkhow8HNw6DxJgN6A+Bkg1Tt/PI3xOWUk=;
        b=H9Z6gsUBUfayvmNtJumNBWi+1HvNh8zX6TV4OY2yjyg0yRJBJ0Iz6IEZ0FycinDWYB
         lgyprixhQjS/SqqVjM8kYyDFJRTK+WhtuN3YFSjafzJfwY83J/nDnGuUcrO6NWjs1oea
         /cA+sI/mwf75OCT917TO2UeRHoEp0/2QSZUe2yp4NRha6pPF9NDiY5HYaML+o6/JadvV
         5XnKp7l9d4RL+Tc1Pg/LkCZQJeGuPScjzTivSj71g2mI7+/6l1ffIHG6Z1NPuabLT0DW
         nNi+sTUkDx361xA+TEVz/jXcW6Fcdy95wC7K+FX+BBvTOxWvmjADrLGEjBNdXJEkn4zB
         tLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=0S8jfx64Oylkhow8HNw6DxJgN6A+Bkg1Tt/PI3xOWUk=;
        b=fydog5DgBAgMrkevmdbrT1HY8je9tKjT2CTUdKWg1b+Ghgfs3F9C0hGDsmldUhrijC
         tvukBIAxsW+EoMqTRTTxrwNACSxs3jw5/vAveM6qItzGU6BSzWjTbDRDpmdxnwmMkWQv
         NfVV60zFaUubPJZchogqqWR7UTnP6MUKxxjKG55xCFursch8R985a68aqqZbVX2psQ9f
         b57+7iPoJJ7ah5CVSbGUVAZ4h6kPRlOCrgY9hrQ1APuBCUI2KfLKLqtzsWakvA4R6Ow5
         l9U+4L82JwGcEEdMs/kialN+EHIZPFzKtFFPVgrOA4fMq6aa8QMTlMxhwbUQE3jqdWon
         g6Qw==
X-Gm-Message-State: AOAM533d3vjIJWN3uyG2izpnMpMwzE7PaLTHfWlWZbUE+SDj8RcwnQMU
        LgmyPHXPONxLOQ+jat+4S5GCC2s67L917cRgJBZ09L6McSlt3iEZb30sUe3KRXrX3rBjy6+yVE5
        1CxtBuaYcFFIRLcbM70YednR30xlKezYNjaqUJdrQfyDJKqdlw9b2lbZtWB0pSU+hvK2N43Jg1W
        Ye0HaFrHBAxbI=
X-Google-Smtp-Source: ABdhPJzZnSMswq5l2yb9BtBIBcXyfjEniV1RHFmljNpPC3kqcJFmsnrS1u7e/oQwo6MOfdphCoo+DrxObijcYbgXcQ==
X-Received: by 2002:a25:2313:: with SMTP id j19mr175464ybj.144.1592265808520;
 Mon, 15 Jun 2020 17:03:28 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:03:16 -0700
In-Reply-To: <20200616000318.42664-1-michaelfsun@google.com>
Message-Id: <20200616000318.42664-2-michaelfsun@google.com>
Mime-Version: 1.0
References: <20200616000318.42664-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v1 1/3] btmgmt: Add btmgmt command advmon-features
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

This patch introduces a new btmgmt command =E2=80=98advmon-features=E2=80=
=99 to help
user query for supported advertisement features. The command will work
with the new MGMT opcode MGMT_OP_READ_ADV_MONITOR_FEATURES.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 tools/btmgmt.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 46e7465b3..1aae7098c 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4567,6 +4567,84 @@ static void cmd_wbs(int argc, char **argv)
 	cmd_setting(MGMT_OP_SET_WIDEBAND_SPEECH, argc, argv);
 }
=20
+static const char *advmon_features_str[] =3D {
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
+	for (i =3D 0; i < num_handles; i++) {
+		print("\t0x%04x ", le16_to_cpu(rp->handles[i]));
+	}
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
@@ -4776,6 +4854,9 @@ static const struct bt_shell_menu main_menu =3D {
 		cmd_expinfo,		"Show experimental features"	},
 	{ "exp-debug",		"<on/off>",
 		cmd_exp_debug,		"Set debug feature"		},
+	{ "advmon-features",	NULL,
+		cmd_advmon_features,	"Show advertisement monitor "
+					"features"			},
 	{} },
 };
=20
--=20
2.27.0.290.gba653c62da-goog

