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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DCC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E2721D7D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 22:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMfnMWNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgFSW4l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgFSW4k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 18:56:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789DC06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c17so11721197ybf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=A1e11u7HNsaVCh/raWH9GxHfgJx+PWPc1jfYmJ1V0lU=;
        b=hMfnMWNMn27o2KaghyB1Z3B5n6jw2ENw+Typiktn6Ixmu//Ez7uOwtzHX1z0GISlmD
         DLlS/BDIY4FUxftFHmY+Cbu4L7Aae+E0ZPr574JkhZJAtJGR4H5v8zX0tYnQLApbWr3o
         OeezGvsIqaHgF5pmMsB8HrWPRNRaEUBg2jlRuzjfXRRCtmRxqyGf6KSfgoV0TIZGghGd
         eEqTkhpqRJ5Ls31Qho1DtS0tgrL0fwcg1oKqUCZsOKMljQs712bD2iHmVHM7dUYX4v1Y
         FzVh699kkGBpHQhyuLod2CXgX1q+oQ2K9YGeGzXL9ZlL7weoBs70qT/C87dlz9l67h5l
         d3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=A1e11u7HNsaVCh/raWH9GxHfgJx+PWPc1jfYmJ1V0lU=;
        b=OrJiuN2W1M9G+6Bt7umZTnNt1YqwEsRg5mjV16iXdFL0IklZP5cLcqLp2XFZLrBHHV
         Eywyde7ZhlvE7OhzZp9bdWkWjjRvO7iS3tniqQZ7S16geqvhUt4hDWZx7WN0MM3RLyCy
         iRYFoD4hFk/bPlvE2Axd5HhINjPUksR3/NsGCL5+Yus27uWo4tyq9uwPIVQPmEz1mZwb
         shldMDI8mdK+igaQzJ4ZxrA4pbvTLFDjUtqZwcLcRz+ndJ9nn6Bn5aNbQeMVdSGw8P74
         RdVghawjjFT1PqmaBCT6rnFSAyQEsK8H9SfMNakxEvAjPBeZX4ZDOu7OILe/hHf6bFO4
         eC9w==
X-Gm-Message-State: AOAM532eeenpZcCwE7imWxrJpqCmem/xKFMIFMhjhaLfE09gK0Whou43
        PkJthno9edPOoA7EKsmzCyJkDwta4c5OfX5V4733trsnYmybltNcsdlQ7Ju0cKvOEqx7q7JWdd0
        O1h4Dmg00FBXxCISITbUxQOX5pExv7+Q10GXki9HLFqmlG1b5LeF9rFO1THgqCySwIgmoxqWLx+
        pBx+eIiVaoVRI=
X-Google-Smtp-Source: ABdhPJwTmInh8CdMqD6XeoH2v/heJNj9oPacoqlSfUuDbSBCDk4j+9WD4IsBIoLaL5yhvSFZIhN4FO+SVDqLtG9I7w==
X-Received: by 2002:a25:32d1:: with SMTP id y200mr10090665yby.507.1592607400013;
 Fri, 19 Jun 2020 15:56:40 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:56:22 -0700
In-Reply-To: <20200619225623.10200-1-michaelfsun@google.com>
Message-Id: <20200619155612.bluez.v4.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
Mime-Version: 1.0
References: <20200619225623.10200-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [bluez PATCH v4 2/3] btmgmt: Add command "remove" into "monitor"
 btmgmt submenu
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

This patch introduces a new btmgmt command =E2=80=98remove=E2=80=99 wihtin =
"monitor"
submenu to allow users to remove previously added filters along with a
event handler to handle kernel issued MGMT_EV_ADV_MONITOR_REMOVED
event. The command will work with the new
MGMT opcode MGMT_OP_REMOVE_ADV_MONITOR.

Tested on Atlas Chromebook with a sample stdout below:
[mgmt]# remove 1
Advertisement monitor with handle: 0x0001 removed
[mgmt]# remove 1234
Could not remove advertisement monitor with status 0x11 (Invalid Index)

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

Changes in v4:
- Fix endianness

Changes in v3: None
Changes in v2:
- Move remove command into submenu and fix build warnings

 tools/btmgmt.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f50d29651346..1c46041ccb18 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1013,6 +1013,20 @@ static void advertising_removed(uint16_t index, uint=
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
+	print("hci%u %s: handle %u", index, __func__,
+					le16_to_cpu(ev->monitor_handle));
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -4644,6 +4658,44 @@ static void cmd_advmon_features(int argc, char **arg=
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
+					le16_to_cpu(rp->monitor_handle));
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
+	cp.monitor_handle =3D cpu_to_le16(monitor_handle);
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
@@ -4696,6 +4748,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
+								NULL, NULL);
 }
=20
 static void cmd_select(int argc, char **argv)
@@ -4719,6 +4773,8 @@ static const struct bt_shell_menu monitor_menu =3D {
 	{ "features",		NULL,
 		cmd_advmon_features,	"Show advertisement monitor "
 					"features"			},
+	{ "remove",		"<handle>",
+		cmd_advmon_remove,	"Remove advertisement monitor "	},
 	{ } },
 };
=20
--=20
2.27.0.111.gc72c7da667-goog

