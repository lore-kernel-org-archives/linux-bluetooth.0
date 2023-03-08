Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323DC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 00:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCHAwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHAwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 19:52:04 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DDA8C48
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 16:52:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a7so9241676pfx.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 16:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqSEsPP2Qc9avva4EXCBw4/r2HhRoTMabXS46bng8UI=;
        b=Re/OXOEHoLbmNvvXnEj43TGfPpJ+l3UICme+4TF+TFb5z46t6TnuDHatPk6lhcJ9Br
         TkLQhOYroTuwhipcTMo0Wwo4Vly/p4XYeg95QK+x7UkbLW/CiAOdIoAiqSc52p1qa9QG
         O6TaKE9Bj7c/r21UXQszSJNahf6bMjQtldp6+06zDVBOv4XDTVPC7WZJZJcdZDnRFWqI
         +FnmLe39QdPZTenefqwwbrFNrzuODq8PJkVF5v5kPWLHdDeOfQJ/TQdZbsGc7tXfHyTg
         7JbcMfAFB/7k7QEm/RrCwAqHPOUQZ6imv/IWk1fBPvij7hjfeOh5uJ99beD9kHDSW4mC
         ET3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqSEsPP2Qc9avva4EXCBw4/r2HhRoTMabXS46bng8UI=;
        b=b2lu9xtnidc99aRtRZrezPSvwwTLuxIk4AeOpr9dzngH77vCmBHHgqTq3Yte78dI84
         1Cbt6a0LKg1r0jpcNIbBHPzUbFW6gRgiSVLLh1yNOFettha1rNVFIbFNzno/O5fX3c2C
         nXJZoFF/qBWeXZXchuZ+orwrVABJCbd6+g0ZPVwWT+0Nh9kEVyLyGCd7zQh7iwh9IN9M
         cVZ21Phc8JE7YW7caYNqHS5eJMFI8R7UXqvOHOVNxziUO9LUhCy+Mtq7beqZ8Q2ENi3J
         27Xk+OmdDTwk5FXMwEZ1bkloXwrIepfsTju+bjt2Z8saI2PVZM6y24o580lJ0xiC+OsQ
         TMHw==
X-Gm-Message-State: AO0yUKUMxkSzZ0PsHzjFc8aajs71uIVfqlm//3tqLYM4UidXBwigk0uh
        /AxNaiJKPT+b0OQ71Wtu6p95bbAiDWI=
X-Google-Smtp-Source: AK7set9xLly7MjiXLdiW7zpQzKTMEd5Zo1LQTfKftHYJOPWzF2NY+FpcxhJy6YFjb5/vdRK5s4Z1MA==
X-Received: by 2002:aa7:973c:0:b0:618:920c:8cb2 with SMTP id k28-20020aa7973c000000b00618920c8cb2mr12980760pfg.21.1678236722688;
        Tue, 07 Mar 2023 16:52:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78dd2000000b005d61829db4fsm8379610pfr.168.2023.03.07.16.52.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:52:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gatt: Fix creating duplicated objects
Date:   Tue,  7 Mar 2023 16:51:58 -0800
Message-Id: <20230308005158.2661414-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308005158.2661414-1-luiz.dentz@gmail.com>
References: <20230308005158.2661414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks cid before attempting to create device, if the device is
using an RPA it could be that the MGMT event has not been processed yet
which would lead to create a second copy of the same device using its
identity address.
---
 src/gatt-database.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index ea282d4bc193..3b53bf2a3c84 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -632,6 +632,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	struct btd_device *device;
 	uint8_t dst_type;
 	bdaddr_t src, dst;
+	uint16_t cid;
 
 	if (gerr) {
 		error("%s", gerr->message);
@@ -641,6 +642,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
 						BT_IO_OPT_DEST_BDADDR, &dst,
 						BT_IO_OPT_DEST_TYPE, &dst_type,
+						BT_IO_OPT_CID, &cid,
 						BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("bt_io_get: %s", gerr->message);
@@ -655,9 +657,21 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (!adapter)
 		return;
 
-	device = btd_adapter_get_device(adapter, &dst, dst_type);
-	if (!device)
+	/* Check cid before attempting to create device, if the device is using
+	 * an RPA it could be that the MGMT event has not been processed yet
+	 * which would lead to create a second copy of the same device using its
+	 * identity address.
+	 */
+	if (cid == BT_ATT_CID)
+		device = btd_adapter_get_device(adapter, &dst, dst_type);
+	else
+		device = btd_adapter_find_device(adapter, &dst, dst_type);
+
+	if (!device) {
+		error("Unable to find device, dropping connection attempt");
+		g_io_channel_shutdown(io, FALSE, NULL);
 		return;
+	}
 
 	device_attach_att(device, io);
 }
-- 
2.39.2

