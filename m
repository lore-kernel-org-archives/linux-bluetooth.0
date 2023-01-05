Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A5FC54EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Jan 2023 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjAEWKM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjAEWJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 17:09:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30367BE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 14:09:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cl14so4846579pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNud4kWdkw52+hXAnumbx8Ikmuw+BRe/Pf1t1Z/q3Y8=;
        b=QOvEbBJ6Pz0b7wJvrbxCCq88bebfI8kMwj31mnJ1IkhpwRY+xbW4RwogMOM/uc90KK
         h07gzh0+83sDvk19FB091QxdWESboAEzMoW/PxF1Q/q3h2t2favLsXUuMKgLDNzRnkge
         l05gV0kCYJ5/RNaKgQoWsTm5M1rReUuPQKhKPY8McLsPx+7033AHoEVRS17YWp1P9Y8X
         jc9Nl7G5uSBeHTqp/TKEldlTnXK3eCA1/a5Okez6Cf4l7p88c6zprnWCkY5JkiBvgqa7
         60g7ORKbe/9XUghUtkSEtCuuN/SBz08DR0aRtFWvkvJKLaxQHc1eiJdP+f5O1aMO7iwa
         p4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNud4kWdkw52+hXAnumbx8Ikmuw+BRe/Pf1t1Z/q3Y8=;
        b=5U3/Z34S6tAsuoue0Mb35CKafc9E26c9srW6ZjHt5d3mzbUZGBc1mDgqGGltgeKi4n
         p8aWuJldRG/p9i6U6klIANAlQkI+K4Oe18/7fyJwXUYGQYTwrJk/0cwdJzimQqYDVl/u
         5lenusYosRwoDtmW3KuWBEosSEILJTgxNA9b98QZ9oq+rPDTyvgUWQ40adpFqg9hYu8L
         zpcdOiO0TApwVvX0sJ9jE9Q5Sz44ODUWctZb64z7LVUIH47QUS9jmhulc6U8c/619ucW
         QPcSDOjDgfITRjJcZFA/izWmcmpdpafvwLyYjqZd/T0KCwSWAKsi140MCn8bUDdWcQZ4
         yeKA==
X-Gm-Message-State: AFqh2koMnpS9g1mj+WR0NS/LjyeeTije3N27TMZ0FT6IUGbb0a/lcs1G
        vV2ebi9BuIElQ2FlOT/l5rmo7ntu52s=
X-Google-Smtp-Source: AMrXdXsGCBdyo3L4/G7HSss0WYQ8vB2kK8TMOpoguSJR2DQsPCYdFgmKK17/6fMgZVFfnXgXj3iQGA==
X-Received: by 2002:a17:902:f145:b0:191:10e0:b912 with SMTP id d5-20020a170902f14500b0019110e0b912mr52494033plb.41.1672956591194;
        Thu, 05 Jan 2023 14:09:51 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001929827731esm16744861plb.201.2023.01.05.14.09.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] hog-lib: Fix not handling BT_ATT_OP_HANDLE_NFY_MULT
Date:   Thu,  5 Jan 2023 14:09:44 -0800
Message-Id: <20230105220944.2373424-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230105220944.2373424-1-luiz.dentz@gmail.com>
References: <20230105220944.2373424-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a temporary fix for not handling BT_ATT_OP_HANDLE_NFY_MULT in
GAttr so the code will use g_attrib_attach_client to attach the
bt_gatt_client instance which is then used to register notifications
including those sent with BT_ATT_OP_HANDLE_NFY_MULT.

Fixes: https://github.com/bluez/bluez/issues/71
---
 profiles/input/hog-lib.c | 23 +++++++++++++++++++++--
 src/device.c             |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 021db386f3b7..7ff1ede3db35 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -374,6 +374,15 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
 }
 
+static void report_notify_destroy(void *user_data)
+{
+	struct report *report = user_data;
+
+	DBG("");
+
+	report->notifyid = 0;
+}
+
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -393,7 +402,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	report->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					report->value_handle,
-					report_value_cb, report, NULL);
+					report_value_cb, report,
+					report_notify_destroy);
+	if (!report->notifyid) {
+		error("Unable to register report notification: handle 0x%04x",
+					report->value_handle);
+		goto remove;
+	}
 
 	DBG("Report characteristic descriptor written: notifications enabled");
 
@@ -1798,7 +1813,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 		r->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					r->value_handle,
-					report_value_cb, r, NULL);
+					report_value_cb, r,
+					report_notify_destroy);
+		if (!r->notifyid)
+			error("Unable to register report notification: "
+				"handle 0x%04x", r->value_handle);
 	}
 
 	return true;
diff --git a/src/device.c b/src/device.c
index 995d39f2ccee..28b93eb9ac38 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5152,6 +5152,7 @@ static void gatt_client_init(struct btd_device *device)
 	}
 
 	bt_gatt_client_set_debug(device->client, gatt_debug, NULL, NULL);
+	g_attrib_attach_client(device->attrib, device->client);
 
 	/*
 	 * Notify notify existing service about the new connection so they can
-- 
2.37.3

