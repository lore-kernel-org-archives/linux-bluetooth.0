Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FCC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B832065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNNujD3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgGVQUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgGVQUm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jul 2020 12:20:42 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A8C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 09:20:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i3so1791478qkf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qs3lYzmo9cqp4fumqX6CW3QqvW1CbWYAHI9HVd1WRcQ=;
        b=kNNujD3czFwvnsHM5188PpNTRjXV7Oe6kT441O/ElcuN+jKR4nSu+JcbMxp4fkXjfw
         JCpqdGrTHPmiYnolYX2KjfJiC9jnsDd3XffsW7RGGDeDgr0ag5ImFGGjeS3WJjvHxbz+
         z9sGRZsMv9bAcoiGenBoP1et03dhezjCscVyEEychL01H2XsMfBfvqeSIydjiKLAddLC
         e0YEa24KB3qydo5aUxvozQ0wO1wc2G6YoEmrBaPQGgtoyA3vM+U9508fggi+Hkn4Ryi8
         DD6g3y2NOtAgpVXzqFRg7O93O5usX5YE8WmzH2OSHqYwhp63lBKEuR2h7+NTK+hulQzq
         xZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qs3lYzmo9cqp4fumqX6CW3QqvW1CbWYAHI9HVd1WRcQ=;
        b=fWBcxYh02V8Ky+4Yp/w58jJjrb59/ZC/tK4vCnignJxyyUG7nFQ5xUtYbEmcONcJLn
         aPiPECEcWTfoGDi112jjZAnOuCfH4NRe2hhh9yQAzg4TpK1IQXoTyXuOR2iE2UyrSiYy
         7QXJGwwUh6+ORJ3zgEo7HAjYCvkv/1/svLemQmvJF/F2lVuf41WJREhTm9+4Qagz3Prw
         fGNi5hLUu4z1tGA9XT8o1sq/fPnvUQeSGUoSma1LNQAso8sKOlEXnE+KEXkAHvadygaV
         vkuroagWin2n717m7iZ+OLZ0gXKb9dEPyiGsnYj0aMQusk5sH0UFCX3/2eFNyhFtKeQ/
         aYMA==
X-Gm-Message-State: AOAM533jNsRQe0HXV/pj4CNl9j+Y38ovCzYkarxU8f22ySd6YCJlScuO
        V3L2zhizTBzZfNPIhIJrSDfEh1lzeAcpP8A+Y6jaBGcwKbvhGhzKr2WiJ8ZSfUdSAQ5CtmyUiLR
        DmZz0mxGUL1BiHJ8kf0VKVMLFAA2kBVkS2r1ZEugMT8QdvDizEqGf25HMrPwRHofBHhut1xxYoU
        p3
X-Google-Smtp-Source: ABdhPJwO+WDirnSZBnQSyTLPIFKLheKCmBQRZhMupwopyfOuYutTRZDzdJed4rr4pTXOgvHRjQAzYlvMqbiP
X-Received: by 2002:a0c:9e52:: with SMTP id z18mr737177qve.59.1595434841622;
 Wed, 22 Jul 2020 09:20:41 -0700 (PDT)
Date:   Thu, 23 Jul 2020 00:20:32 +0800
Message-Id: <20200723002022.Bluez.v1.1.I45e09d196073f099e1b67d2d69efd5cd20237ad1@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [Bluez PATCH v1 1/2] input: authenticate when connecting to a bonded device
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth HID1.1 spec, part 5.4.3.4.3:
If the Bluetooth HID Host is bonded to a Bluetooth HID device:
If encryption is not already enabled, the Bluetooth HID Host shall
enable encryption with the Bluetooth HID device before sending an
L2CAP Connect Request to open the HID L2CAP Control channel.

When creating connection, this patch checks whether the target
device is bonded, if yes then we use the medium security level
instead of the low one to enable encryption.

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 profiles/input/device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2dc2ecab2..9f89f4459 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -112,6 +112,12 @@ void input_set_classic_bonded_only(bool state)
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
+static bool input_device_bonded(struct input_device *idev)
+{
+	return device_is_bonded(idev->device,
+				btd_device_get_bdaddr_type(idev->device));
+}
+
 static void input_device_free(struct input_device *idev)
 {
 	bt_uhid_unref(idev->uhid);
@@ -979,8 +985,7 @@ static int hidp_add_connection(struct input_device *idev)
 		device_get_name(idev->device, req->name, sizeof(req->name));
 
 	/* Make sure the device is bonded if required */
-	if (classic_bonded_only && !device_is_bonded(idev->device,
-				btd_device_get_bdaddr_type(idev->device))) {
+	if (classic_bonded_only && !input_device_bonded(idev)) {
 		error("Rejected connection from !bonded device %s", dst_addr);
 		goto cleanup;
 	}
@@ -1153,16 +1158,23 @@ static int dev_connect(struct input_device *idev)
 {
 	GError *err = NULL;
 	GIOChannel *io;
+	BtIOSecLevel sec_level;
 
 	if (idev->disable_sdp)
 		bt_clear_cached_session(&idev->src, &idev->dst);
 
+	/* encrypt connection if device is bonded */
+	if (input_device_bonded(idev))
+		sec_level = BT_IO_SEC_MEDIUM;
+	else
+		sec_level = BT_IO_SEC_LOW;
+
 	io = bt_io_connect(control_connect_cb, idev,
 				NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &idev->src,
 				BT_IO_OPT_DEST_BDADDR, &idev->dst,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 	idev->ctrl_io = io;
 
@@ -1227,8 +1239,7 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 				reconnect_mode_to_string(idev->reconnect_mode));
 
 	/* Make sure the device is bonded if required */
-	if (classic_bonded_only && !device_is_bonded(idev->device,
-				btd_device_get_bdaddr_type(idev->device)))
+	if (classic_bonded_only && !input_device_bonded(idev))
 		return;
 
 	/* Only attempt an auto-reconnect when the device is required to
-- 
2.28.0.rc0.105.gf9edc3c819-goog

