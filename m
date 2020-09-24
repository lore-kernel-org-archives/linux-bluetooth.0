Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96237C4346E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516822371F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 23:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDxNFsbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIXXRs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXRr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 19:17:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:17:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i17so495314qvj.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=BRLWzw5KfOjJw5AE9R3gLTg9imcZgd5TO4r9CcaoPCQ=;
        b=CDxNFsbuqgptnC5RyTR8/pA7twNx/mawY/cqEq85M671xbEzmEQjL+hMUUbxHMyvfg
         bknEpjXZFP+cLCkJLfOteUWt9AzDoHdegXvs66lumwId1zeb/HctNf6+wixOOHkw571q
         Ad2Kf/WYrTCSsztAo+QfM52UZl36c4MO8gG2VdJY6PkNAbuAWYD29+q1T2jCGk54ETnJ
         6a+zdkLA8qIBLtf84nGuIFL/+KOSGyX7EBy7UmVapLS4NOOxRdcYhYTShYxVuLJ6FZav
         5plQxBL8dBmAWyiFfDvWoCf60nbl+UWsGCorwGCyEjeuKKOAjswrkUM2H77x70KAjO+9
         pfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=BRLWzw5KfOjJw5AE9R3gLTg9imcZgd5TO4r9CcaoPCQ=;
        b=udtO8FQ6xhrLZh2L9R29j/wE4AIlljGxY3yO8bAUjn3A9ZwZ/ncDBwFWn2b6dbhPqi
         GsSpLOJiuCljThm7N5amiJwusr2OOiuFW1y1jgvcTZJL5redVWn7lrdcnNeRwaEKcjYy
         qf/GyAfx9civwz8IcBFoND92uIFdjEASIbYntG0H1/8+bfsShe9A5kxx54WNGMfsS4Dz
         5ov6CVNEa84HLAZVLiHZE/jYUQGn5r18L4TBXjVFnGjlol2aYwUBQHDUKkWwM4ZeOaOO
         7Xch0EG5YlFfzL/8oHAcL/M0luLaubwR9Fq5asd+jBYXW7srHVuvn72wZtkNK0GBrBUA
         MNXg==
X-Gm-Message-State: AOAM530Vy6NQa5JMBvqxRTNi4PYDIBHm376a69Oh8a0YZ1mA9UxkMzST
        IdgLN+HzkzpwBsIFKzchOCt+xqh9jCp2c9ZIlVRVKU9Q1lgGOfLAG75L8RzZCGGQGfUcrHtlt4y
        ml18oXltfSUQEdheiW/HI3129BRjb77FEUw+DxjnWrlPq02SmtulM0yIcyQnoe3gpeEENjDly6a
        4q
X-Google-Smtp-Source: ABdhPJxlZcl8HCfrlFHHI2Gikz0Ybj9zHpRLlcm2vQrSrNkHGPLth+C0ocOgBJ+rt2hN7Cl97VZP9jkqzTsq
Sender: "yudiliu via sendgmr" <yudiliu@yudiliu.mtv.corp.google.com>
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a0c:a482:: with SMTP id
 x2mr1631875qvx.56.1600989466672; Thu, 24 Sep 2020 16:17:46 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:17:42 -0700
Message-Id: <20200924161730.Bluez.v2.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2] device: Disable auto connect for temporary devices
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When connecting a LE keyboard, if the user input the wrong passkey, the
stack would keep auto connect and thus allow the user to retry the
passkey indefinitely which is a security concern. This fix would
disallow the auto connect if the authentication failed.

---

Changes in v2:
- Move the logic into btd_device_set_temporary

Changes in v1:
- Initial change

 src/device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index a4b5968d4..13159d927 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5684,6 +5684,10 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 		if (device->bredr)
 			adapter_whitelist_remove(device->adapter, device);
 		adapter_connect_list_remove(device->adapter, device);
+		if (device->auto_connect) {
+			device->disable_auto_connect = TRUE;
+			device_set_auto_connect(device, FALSE);
+		}
 		device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
 							device_disappeared,
 							device);
@@ -6036,8 +6040,9 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		 * treated as a newly discovered device.
 		 */
 		if (!device_is_paired(device, bdaddr_type) &&
-				!device_is_trusted(device))
+				!device_is_trusted(device)) {
 			btd_device_set_temporary(device, true);
+		}
 
 		device_bonding_failed(device, status);
 		return;
-- 
2.28.0.681.g6f77f65b4e-goog

