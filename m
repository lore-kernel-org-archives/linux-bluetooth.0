Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F19DC2D0F6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45C420714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8Aco4ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgEMCTu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgEMCTg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 22:19:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A723C061A0E
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:19:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so7088432pgg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XY9o4PMaJYaO2R8EhFQqhMvaTSOOlIIvMuAUeMmeUOI=;
        b=C8Aco4ESAdgnHiLfDM2byt4dDD+oa/T+cWmKnu8BQYbhBo6LRp9U1jMyyluLEMl2cJ
         sxeleYRnu1D4cNv6opkhro4gi0u/jMF3bwtdRz/kOMwIwaQEBeQVXNq25/YQTHF9VEAW
         jDUT22MkDElv7Dhtkr+wbPANacbcs1eITwizU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XY9o4PMaJYaO2R8EhFQqhMvaTSOOlIIvMuAUeMmeUOI=;
        b=cC+qSxg/YqK4DTEDJccSDXCP5aJzpBt63UdrDb8+8+cfsKJjVJXGHsE5osRbf2xuGt
         uWxTujXWgkoFsqavM04smO/28FPDqRpHKZH9lHIYZv5ZnyewzrEDON+aV6NKxNIVxa7g
         V3uQwg4iP318wG4j3SoaNKUPuwtzgoD0/V7epqKmvduV08gNc1EqNjuxqwr7rZ3zS+NT
         lVDP2iWnd6/podRnN1ijOTbPIJ6QFSLy5PUrvOAJjVcF9tpcCyl/OifksQ+IsUsnQNDB
         Db6ePxY/I3XRTLWkZxdk5uxgiFmbGUJLjhL0xAl/k1VvUramzZhEor801C2EeLP+cNz0
         UDyg==
X-Gm-Message-State: AGi0PuYReYmYletYm9HrEmsBF1TVNKvPIoGpVLD8xsmhihDzoLmOgU1k
        ifnjeyU6V3YakbuTndBNcjDedQ==
X-Google-Smtp-Source: APiQypJfcGRTCMS+eutRkjoY4piQYyahEUu2m7R3wSh9zeupmG5+5vbUl4+CAShJOgLPjgj4uWsz9Q==
X-Received: by 2002:a63:d60a:: with SMTP id q10mr22951807pgg.37.1589336375736;
        Tue, 12 May 2020 19:19:35 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm14170600pja.53.2020.05.12.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:19:35 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Implement hdev->prevent_wake
Date:   Tue, 12 May 2020 19:19:27 -0700
Message-Id: <20200512191838.3.Ic08447a6d2fa9668ae0f2f485db5c3c5d1bee39e@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513021927.115700-1-abhishekpandit@chromium.org>
References: <20200513021927.115700-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Implement the prevent_wake hook by checking device_may_wakeup on the usb
interface. This prevents the Bluetooth core from enabling scanning when
the device isn't expected to wake from suspend.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ae3ad7a60131..c17359c0e3201 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3698,6 +3698,13 @@ static void btusb_check_needs_reset_resume(struct usb_interface *intf)
 		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 }
 
+static bool btusb_prevent_wake(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return !device_may_wakeup(&data->udev->dev);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3831,6 +3838,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->flush  = btusb_flush;
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
+	hdev->prevent_wake = btusb_prevent_wake;
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
-- 
2.26.2.645.ge9eca65c58-goog

