Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F4AC4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2643E20735
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku5BbWZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgJ1Wuf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389556AbgJ1Wud (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:50:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s12so579169pfu.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=j9PRoCK9JmS5PHro2aXk4eIPqO/Hcdx6BXy0bDJAfRw=;
        b=ku5BbWZP8UwJEoyy2Tb91sFXbjQSlaT1x7nuWb4QgVtbJSfqABqnpzFi7sHW1exI7U
         Pki1mUrq5Tp38JPg5LkaHFOB08txL5BHyivV8dg4hiVzEov7MPku8BKo29VQRl/XhOgx
         xexnDHRxyknCTAVJtN9PYNYd3gsEb47cxXtfavNxiZv0VxRjNGeYb2TmfE/krXP7YXdJ
         Ju2EC82wisifEnxKa8KAr6JX+rrjRDscyMj2QwF0lEy0HTonFkykwSFvDpuLJrLoFqJ3
         U1EFkvuVjhx94fJhW5rRog+b/pYMGrLmuKMdKel+Nu2LQoqOZukwudBsL7Kxk1aoMsbh
         NtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=j9PRoCK9JmS5PHro2aXk4eIPqO/Hcdx6BXy0bDJAfRw=;
        b=HOQA2wxM6t2Inpm7zKSvpwmZjI9YCKyFmnA5XZMfJl3mWcbg/HD2lKughl0o/IFSOC
         Ncl41fCo3J57oIsWi93Uv9uDkC3Jpn5yvhH0tw1oApKgVB9aZGj2njOM64n+kKrHlB2R
         rAJqYGmY5QFwGYLWTQZ8vBSuKzF8ouHeC+Z0UZwhCiTF/3nDn2KwnhZvqhtIe3qqOU35
         yQwl3vv1Z2LNE9DGg/7kMB/F1Un1cxql4+OHkj674tao63F0RrujVxi8TW6/l4Vc3Nz+
         /zuUYG0peQdhcBKj9DrU6FMnZObTcozt9JqnKedpXdv3ZSzfTo6mbON1O/qmXzVgF7GF
         zjOQ==
X-Gm-Message-State: AOAM533wZHUu8yjgI8ZbLmG9uXH6MtZHspyvgISqJbmt4RRq1Lrb5+rK
        J4cSWD21pqS6iM3vLRbREk2jqxl7lv8SBBfDcFz2
X-Google-Smtp-Source: ABdhPJyyo4kYUT14DCOtn5mSjpMptD8O/xrb3R5Cd+nKq2Y3T7WOBYKzuo6k7qEyUoFXR1Pgi31CckCuQbeZGs6ffg+/
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:d713:: with SMTP id
 y19mr274822pju.87.1603925433054; Wed, 28 Oct 2020 15:50:33 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:50:13 -0700
Message-Id: <20201028154914.Bluez.1.I8216fab388e34d8a1373efc71a252c2c5a085564@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH] adapter: Use initial temporary status to decide device removal
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a connection fails, the temporary attribute of the device is used
to decide if the device should be removed altogether. However, a recent
change to device_bonding_complete resets the temporary attribute so that
it will be treated as a new device which will eventually time out. A
side effect, though, is that the device will now always be removed in
connect_failed_callback immediately, regardless of whether the device
was marked as temporary to begin with.

This change stores the device's temporary attribute before
device_bonding_complete is called to ensure it is only removed if the
device was temporary to begin with. Otherwise it will timeout, as I
think the author intended.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 src/adapter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..9eb60ba03 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8877,6 +8877,7 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
 	char addr[18];
+	bool initially_temporary = true;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id, "Too small connect failed event");
@@ -8897,6 +8898,11 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 		 * request structure. */
 		if (device_is_bonding(device, NULL))
 			device_cancel_authentication(device, FALSE);
+
+		/* Store whether device is temporary before the attribute is
+		 * cleared in bonding_attempt_complete
+		 */
+		initially_temporary = device_is_temporary(device);
 	}
 
 	/* In the case of security mode 3 devices */
@@ -8914,8 +8920,7 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 
 	/* In the case the bonding was canceled or did exists, remove the device
 	 * when it is temporary. */
-	if (device && !device_is_bonding(device, NULL)
-						&& device_is_temporary(device))
+	if (device && !device_is_bonding(device, NULL) && initially_temporary)
 		btd_adapter_remove_device(adapter, device);
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

