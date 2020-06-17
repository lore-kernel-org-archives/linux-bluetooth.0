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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3FFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E1F20853
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehyPmaAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQG0z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQG0z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:26:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB599C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a188so1393376ybg.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=r9vfWzzZ6gr06ZsUMT6gZTsgrP11R9hvw6rTrzGGJSU=;
        b=ehyPmaAbJpCT71V+0gLnS5vWSsCS7ra/KHNWyBVk2OML+fXh9IFI4hFiWvTo44FBxQ
         NYcoqi5/8Ig1SR5dG1fICYMRk2cBCZNPD8J9GZjFuiE54VWHtJeJUaZhra+ux3PsyNLB
         14GcgKYDHAkBJGQ2K2Bn+KWnMok39TqN1Ive/g5AAuSqoGIYfAqPP7yfa97DFuLeKhiZ
         Z7Pvlyt4KlogPbktQKjjyjAAhb2yCY9GIdQGnv3WmQNQHpJO71vPCJgFtWI+BX4CpwbH
         UZk6jZ/M7Yx5I8VJcbPUHwPoh/jAKqCue20cD9aqbkDN0bzLPnaEkYK8sKUYwUrPPf6R
         g9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=r9vfWzzZ6gr06ZsUMT6gZTsgrP11R9hvw6rTrzGGJSU=;
        b=lUxf19Q5qMbwf5Rr6DS3V1NgPeztOJEeY6b8oidCqxqz/b3M+7w9HOLxKUEiKx2Fpq
         +/ng+mkXgz5AgNmiBFfZz5nhdT+gGVfal7gMmFuuIRCr8AK0r3DiavbLtAXySWhT28us
         sWg7+1bac3ztoU4tkh4f1DZfLrSfmKqqpZRqPCvRIYr/TZlyboDzfdBM1+K5jlR/dVEW
         wX2MKxlKKB+EqVABBXPTopGiFA/7M5snfzOCBNsXCRfB34YM9SZMBbSAnqN8uleIKI0r
         3FDAe2FrKHtAbzMcFquwWlCUzAx7aHRUiIZHcRymnxiYoiDoyx/oZiqPj+0l4OgvncnF
         ZPZA==
X-Gm-Message-State: AOAM533jVXRmzKXiIImwX+gAPW8TzTNJA/CrRBQ8NuxEVzL1Kp8pAJPE
        tGQ+IBHHRziPfDfaY9A91dmTnhIa0xcrQEUCZLLKeJiBkoap+HvFUxvdwlg343RNVCv+2Oc35LQ
        9KYvMGHFUxUAHn0Wi9NumZtvNFMSb7OXSmNW6SbJDbLiCl9ZBiStxRo4aBcoTvkcogiPHPsZrrZ
        jON1em1kej3c0=
X-Google-Smtp-Source: ABdhPJxR57AJd7w0+k5McT5G+wzAR+012Vl+zDWA8h448S6IVvCL3jB5TwBo0GO9mouMAySZWMDBnRqx8wJqL6Uexg==
X-Received: by 2002:a25:dfcc:: with SMTP id w195mr10735032ybg.372.1592375213053;
 Tue, 16 Jun 2020 23:26:53 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:26:45 -0700
In-Reply-To: <20200617062646.165307-1-michaelfsun@google.com>
Message-Id: <20200616232642.bluez.v2.2.I6847f3a5339713811d88b3a234e6454e11f0f042@changeid>
Mime-Version: 1.0
References: <20200617062646.165307-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v2 2/3] btmgmt: Add command "remove" into "monitor"
 btmgmt submenu
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

This patch introduces a new btmgmt command =E2=80=98remove=E2=80=99 wihtin =
"monitor"
submenu to allow users to remove previously added filters along with a
event handler to handle kernel issued MGMT_EV_ADV_MONITOR_REMOVED
event. The command will work with the new
MGMT opcode MGMT_OP_REMOVE_ADV_MONITOR.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v2: None

 tools/btmgmt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index a0487d4de178..5a70e9e1c3e9 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1013,6 +1013,19 @@ static void advertising_removed(uint16_t index, uint=
16_t len,
 	print("hci%u advertising_removed: instance %u", index, ev->instance);
 }
=20
+static void advmon_removed(uint16_t index, uint16_t len, const void *param=
,
+							void *user_data)
+{
+	const struct mgmt_ev_adv_monitor_removed *ev =3D param;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) %s event", len, __func__);
+		return;
+	}
+
+	print("hci%u %s: handle %u", index, __func__, ev->monitor_handle);
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -4644,6 +4657,44 @@ static void cmd_advmon_features(int argc, char **arg=
v)
 	}
 }
=20
+static void advmon_remove_rsp(uint8_t status, uint16_t len, const void *pa=
ram,
+							void *user_data)
+{
+	const struct mgmt_rp_remove_adv_monitor *rp =3D param;
+
+	if (status !=3D MGMT_STATUS_SUCCESS) {
+		error("Could not remove advertisement monitor with status "
+				"0x%02x (%s)", status, mgmt_errstr(status));
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Advertisement monitor with handle: 0x%04x removed",
+							rp->monitor_handle);
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_advmon_remove(int argc, char **argv)
+{
+	struct mgmt_cp_remove_adv_monitor cp;
+	uint16_t index, monitor_handle;
+
+	index =3D mgmt_index;
+	if (index =3D=3D MGMT_INDEX_NONE)
+		index =3D 0;
+
+	if (sscanf(argv[1], "%hx", &monitor_handle) !=3D 1) {
+		error("Wrong formatted handle argument");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cp.monitor_handle =3D monitor_handle;
+	if (mgmt_send(mgmt, MGMT_OP_REMOVE_ADV_MONITOR, index, sizeof(cp), &cp,
+					advmon_remove_rsp, NULL, NULL) =3D=3D 0) {
+		error("Unable to send appearance cmd");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 {
 	mgmt_register(mgmt, MGMT_EV_CONTROLLER_ERROR, index, controller_error,
@@ -4696,6 +4747,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
+								NULL, NULL);
 }
=20
 static void cmd_select(int argc, char **argv)
@@ -4719,6 +4772,8 @@ static const struct bt_shell_menu monitor_menu =3D {
 	{ "features",		NULL,
 		cmd_advmon_features,	"Show advertisement monitor "
 					"features"			},
+	{ "remove",		"<handle>",
+		cmd_advmon_remove,	"Remove advertisement monitor "	},
 	{ } },
 };
=20
--=20
2.27.0.290.gba653c62da-goog

