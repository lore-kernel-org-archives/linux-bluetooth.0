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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946A021501
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9OfjYlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFQHzp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 03:55:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BACC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o140so1594576yba.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=a19SkpFrQn+XChAVdQe+Vd7tw8P3zyx3W3OzzMc/4m8=;
        b=t9OfjYlNb2dnPKnVzIIiZcrQX0sKDA2p5rVc03wQoMOY1mhwm+pLuXt5F89XchSiL6
         WP5n272lA7DwuJmV/oL0zQKpKz6GX9diNI6e9zpOhqGjR8mQ4bzWJVjDaxlB66g0BT8D
         BepAh1q4iZJQ7MStk6dbbtlM4W858LtJGZDYr1g7c7Qzw1R4jgBEm+00BoGi0fgYh1mo
         3Epj5SZBp+IlPTi+jMfqjncxhIkPJZpRFZXRDZrASpK/j2c25w5QDOjwaRIkexNHE9Fr
         5HbFydw6q+y2MVe8i2G9HeFnwVStpavHiRM7DkeN1yafrsWpleGhlT4yGCgc3alj+LmY
         GtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=a19SkpFrQn+XChAVdQe+Vd7tw8P3zyx3W3OzzMc/4m8=;
        b=dgOqX1j5CP1MFTBQ25oy6qClv+YDzj8McT3V6dRcVQ73wkABH+lfD8wqMGVVnzscuc
         2LA7vRoG3yenJY3fqutYAmADBcGA/E8bb9kzru1BrDO1qoOcGP/Ls4Bbpwa3uSS0GQp+
         2gZdjmggYSq+PolyN33BHpcfktdMlNjhl1bGfBXE5Sh8Zut0P/Xc8cEOK3cCRhKRrdrh
         THqGu+lfBYn/K6zzwCwGFLiF3VoZ54n69rfBvTI56Tfzpx67OJnT16EZ8uYW+jsYKVJ6
         bKmHkys1742WXSHun78uNjENgSOZoV5VqyllpLzx0RRuYMQq16GrObxJGPS1CwZO0QnZ
         6K1Q==
X-Gm-Message-State: AOAM531M/sKlLtDTM5KmpnuHAr6IUTzxsNYTbZ5H4/akH9/tpjxOk8J8
        UGnrgozwmFDC9mhM5uGRBfJRBPDKF42G1RzprGQ1gqfv5uqNLmwPZc6+IxgRrI7QZmSAtv0Susj
        q9Rzr0VkQfIy1zqUCvLi0N+tWN2TulX/U/f7UiHhVSfhHjKF/o5ftIN/wQcaPG9kFYw3KwHtDSD
        kIwFhgydVadpo=
X-Google-Smtp-Source: ABdhPJwp5WdxOAORnf4wngrTelEOy/+OjJcZJ4uetYzEJl2DS4Pk4GA6MDHcloKomK+Yi6Xh8mhsxajTNzwK0gcw3w==
X-Received: by 2002:a25:744f:: with SMTP id p76mr9608187ybc.89.1592380542926;
 Wed, 17 Jun 2020 00:55:42 -0700 (PDT)
Date:   Wed, 17 Jun 2020 00:55:35 -0700
In-Reply-To: <20200617075536.98672-1-michaelfsun@google.com>
Message-Id: <20200617005531.bluez.v3.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
Mime-Version: 1.0
References: <20200617075536.98672-1-michaelfsun@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v3 2/3] btmgmt: Add command "remove" into "monitor"
 btmgmt submenu
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

Changes in v3: None
Changes in v2:
- Move remove command into submenu and fix build warnings

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

