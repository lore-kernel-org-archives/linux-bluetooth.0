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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1751D20853
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBZBHrTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQG0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQG0w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:26:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D917C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p7so1037712qkf.21
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GcwHGX7RGWUKJO3An6LOhwQ6jtAqhn84pbCpNrhGuIw=;
        b=LBZBHrTK66Dm+WO7c869NlobEzRClR0CQr56XuhSNl3Fi3gqNfBGyg8jA2HyL2ehIX
         yhX9fAcfy8eSpN9fvTU5s8z7Ia2zgqxuim8VXus+ot3MFkGctlZGZ1UxFH80FgLu4ZIF
         c9eKERI/nmSPoFTEd/nqeDfAnquMUz5eAmH+gdlPp9HDC1kcwDRRaws9rwOiBU3RkMWY
         QIn0IJTrxKRDdpOyp/6bEJspi2anXFkAhh3lfcM41O0UAtm+8k/Q/A45QWXwQ0vTHBoG
         C99yh618i6znSZq4vm59tni0b6pbDLL/3+Y8wgc5u+z+Sv6Izlm4/Lu9IZ7oZMCIPXbc
         pQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GcwHGX7RGWUKJO3An6LOhwQ6jtAqhn84pbCpNrhGuIw=;
        b=TsY7RMmxgTmrSEQ/Pd+5918NzlyCIAnZ7uciozYr/vDZsso3jo6YvDrB8dgLQatf0m
         E9v/eW+WQr5jXpFMcDy7fPkyvbsvCSlMRjWx1krXfm9tmyZQhkwdlFz08XDpE/xRw/Cz
         sRgW4MckosoMNQHoioFdGtC4xlRDqpTWMtBBhw39g+mvclMGwa3ezkhgjdIHr7IbfPbP
         ro6m+lUAZAO9TgjZz0FMiKv9sjZX5BF8Ir+BVEsFtHa1C7DWHPWtkVVc4MNREzOn91bK
         yfg1qRgwhs7fX+Pqd/s17ep+wI4/5Mr8LdZ8wU6co0lO21yvKg93qviahhji4BA1m6tj
         NNTw==
X-Gm-Message-State: AOAM5328TIrjTCH8IqBtiMFBK2/CJ8+I2XJgVHKUZurwxgSG9nciHwVe
        g6qKLPiaPM6gJfNzXRhrevK78q4/oP8aDH/nWxcpn/QVMgmdAkjY832uNuAdQRA9Tc6GyLJCe+i
        bZd/S4RYxE/VcLtyyqbSB53GRkYyqg6Xf3+bpVLKj7b/9fS9l+RWgnQuBwo1hWFlaC02jjrCd0g
        Rc/JKfOUoAVG8=
X-Google-Smtp-Source: ABdhPJytL4NA3gwdJh/kPJqAQItz7sQYO3UTF44JXLX26mEo8zoWt2TYmGBDRyYRuo5ufe01yWxSSN0fg7P3imuN/Q==
X-Received: by 2002:a0c:f84c:: with SMTP id g12mr5955486qvo.31.1592375211270;
 Tue, 16 Jun 2020 23:26:51 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:26:44 -0700
In-Reply-To: <20200617062646.165307-1-michaelfsun@google.com>
Message-Id: <20200616232642.bluez.v2.1.Id1b811687f1245eca676a6c5fae4fd13a70c7732@changeid>
Mime-Version: 1.0
References: <20200617062646.165307-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v2 1/3] btmgmt: Add "monitor" btmgmt submenu and command "features"
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

This patch introduces a new submenu "monitor" along with command
=E2=80=98features=E2=80=99 to help user query for supported advertisement f=
eatures. The
command will work with the new MGMT opcode
MGMT_OP_READ_ADV_MONITOR_FEATURES.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v2:
- Move advertisement monitor commands into monitor submenu.
- Fixing build warnings.

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

