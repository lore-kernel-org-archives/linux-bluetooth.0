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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA719C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9412074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IT9pgTTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFPADe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFPADc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:03:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B680C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f130so22671575yba.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nuit4bBIRBkyo+2krW4KL+PEr6ovVm41hSjXIW2cVh4=;
        b=IT9pgTTQtV/Ow0IediFSpgwJdUV07hQOY1rVuH54wSUoZFogEG+7zqUEmT2b4csGpD
         KAdhqkxHKNaZ+smcjUvSkESqd0eQDHPX7XWpIQW2x9qOF3BlHyAPA8YuptZ/LmtpMO0C
         3w7V+jN7mOoUFjgFpCeXyW+WGH9LHX2x2ibz7yORcVWttS0QYS/zCUpU2HLMkeun/PNR
         Z1pwVAG6xH8MtkyoSwt6CfH3RGYwa+V7dymmxwXutsmqrw+OS+8zULZAdsEKyzmUbo9G
         G0pO4RiBFzeQ4Zl1IJcl5FtUGRTHrXfsCmZNTb7kk+j5vUDn12H/Ji8sdHBZTMCgO2Cw
         BArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nuit4bBIRBkyo+2krW4KL+PEr6ovVm41hSjXIW2cVh4=;
        b=Dnh+26i+G2OamUuNFvguGCU/+oewnWUQs5oV/DYK6iKZPX722EkB6z4SQHt4jHVcJ0
         Wlzq0gwnmvGK7RgdhhVmZn0/1gA+H9MxQjdsAla/DqsJXs3DZ2g0Rv2ExKzgjdJI/W9y
         g9Z0DgB5TUsMCi3jfh0XKeR1Jw1fWzfTT8BIV3793EqzjBPGK6bZK/b+dzdsGmXAjoXD
         hwbIN134XPM8X+VrzEBp4mZENfPuvPhYwbKXpWq4k9dVwhLv3qTFQUlAPyxvchGre0q8
         0QNuwglyGTg/Z3wYMh/bU+Mq7E9R1zIHagFnLHW2Bd4ttjC6JF9Sp9hcR4L00R3kVc61
         YhBg==
X-Gm-Message-State: AOAM532TbPA/fVAh4XTC0Mte7XljJHM91MdxMHGdQXc9qW0wa1nJAFDr
        NKKi47Vi+jbBYAJbOE8z3BfOzHEOEcagoPqPY1gNVcOOQ8/c3PFiYtRlqgrr/JVwu0h5/+k2Fth
        LOW+jUYPTK4uDwsUVtAG4d2zbyF45wRNwA0aWkz2Ys+dQSAMTXJ78Mj+XxnQIRB3JUAs2Ziu2zK
        /XuuUlSqcIaTc=
X-Google-Smtp-Source: ABdhPJzpbFOtaoKCv94D6MK9NqWdp467iokuC5/s4FVgpVZmB5XF6DGwVXW1QNh5UTyNqv5lscwIISWcYW3s97he7A==
X-Received: by 2002:a25:50cc:: with SMTP id e195mr135590ybb.452.1592265810284;
 Mon, 15 Jun 2020 17:03:30 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:03:17 -0700
In-Reply-To: <20200616000318.42664-1-michaelfsun@google.com>
Message-Id: <20200616000318.42664-3-michaelfsun@google.com>
Mime-Version: 1.0
References: <20200616000318.42664-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v1 2/3] btmgmt: Add btmgmt command advmon-remove
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

This patch introduces a new btmgmt command =E2=80=98advmon-remove=E2=80=99 =
to allow
users to remove previously added filters along with a event handler to
handle kernel issued MGMT_EV_ADV_MONITOR_REMOVED event. The command
will work with the new MGMT opcode MGMT_OP_REMOVE_ADV_MONITOR.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 tools/btmgmt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 1aae7098c..719e92196 100644
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
+		error("Too small (%u bytes) advmon_removed event", len);
+		return;
+	}
+
+	print("hci%u advmon_removed: handle %u", index, ev->monitor_handle);
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -4645,6 +4658,44 @@ static void cmd_advmon_features(int argc, char **arg=
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
@@ -4697,6 +4748,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt=
, uint16_t index)
 						advertising_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
 					advertising_removed, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADV_MONITOR_REMOVED, index, advmon_removed,
+								NULL, NULL);
 }
=20
 static void cmd_select(int argc, char **argv)
@@ -4857,6 +4910,8 @@ static const struct bt_shell_menu main_menu =3D {
 	{ "advmon-features",	NULL,
 		cmd_advmon_features,	"Show advertisement monitor "
 					"features"			},
+	{ "advmon-remove",	"<handle>",
+		cmd_advmon_remove,	"Remove advertisement monitor "	},
 	{} },
 };
=20
--=20
2.27.0.290.gba653c62da-goog

