Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65BC4363D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FF92399A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUXZHxbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIXVFi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXVFi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 17:05:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF20C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:05:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a16so338227qtj.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lfUrSvL5mSmgkGeFrvZ2sz+eWpH4UoNjDWxPkPMqvf0=;
        b=NUXZHxbPtPy1AOpRAbEZ3LlGtwkcDni1a3xQ2FUSFaf+rcwRxzBJ+7yVuTtrfCWXOu
         50VjxmCmm/WbUoU33aS44aWY962SmEMszRTX4ovq7F0Mq7g0T0B2/jo/ZsMnB+W46KpM
         Avh9wp9lgTvNjTC8JuRc7KSXaah8BFo1qpU8sVDed6A6ZC9fM9wKvi3kSuZGgLb0vp0j
         1ljaT8LOl9LhcJHAtR/iWt62FqBbCvKOqs/nAD3o10nxDRDhU1S0Gk1R3QAzyaWowuM0
         bm+wVL6hBdG/eU6UFFn4grmGT/3l18CopC8HShPxe2tY6PALoaUuqU8ObASjDV2D3eQS
         tx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lfUrSvL5mSmgkGeFrvZ2sz+eWpH4UoNjDWxPkPMqvf0=;
        b=QEmBppd6El2XtVigqSI/4AzCXHgOJbav9h8PzqukSl5hUTH3rXtdu5oM6LYV3sWtZ/
         vD0RVUkRrMVJ2Mk7JtZHr1zC44MTA9TpVLf6Qwyd6WpQzqX3hQR91EHZsAPt9Gn+/fUL
         OneUImGHpodIl0OETmRWRZzlv4ekp5n5VkCCzAppPUaCwRflpi4sfwrtRjZBj2VOt+Nr
         vq0VVGyiP8FcCcQ1niOUy/Qbi2bEi1ZDrSCQiRD7QrUZeGpmMO68Uw4WeZ39FJKuOhCt
         LAGzdeBVCRYPZ9WxvrpZAiVYjnxmHwZIeDfYXUJNDxLNHTeltw9nfVdA67DeKmV71FQe
         NdFQ==
X-Gm-Message-State: AOAM533Sa9dW4vcNCT6dYQ2mf7Zmeu8mzaDpOQdClOWpzWtr2p7YIe4k
        CrC1HMjP7ozv1Awjcd6kcf31d6YzzMRG2mtN4yklEIb8Uzj9YB9DT0K0Lt+ZenhPjHcyDMpZa0/
        dXCxAPSKqmsLXymLc8U8oM/ry7XaYhE6KV5sziEol/Nsa7eoWSm5aLf2CBZpIz/tRcDMZXLi/Rg
        qA
X-Google-Smtp-Source: ABdhPJytH4eo92YM5DUzOR2nPo0hiEOUQS1Jyq7SFfgHXjHc/X2tqv6Sn1YxuosAIMUV0Hp3Nme1NZuMUhVX
Sender: "yudiliu via sendgmr" <yudiliu@yudiliu.mtv.corp.google.com>
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:ad4:58e7:: with SMTP id
 di7mr1218171qvb.36.1600981536096; Thu, 24 Sep 2020 14:05:36 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:05:31 -0700
Message-Id: <20200924140527.Bluez.v1.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v1] device: Disable auto connect when pairing failed
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

Changes in v1:
- Initial change

 src/device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a4b5968d4..764cca60e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6033,11 +6033,17 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		device_cancel_authentication(device, TRUE);
 
 		/* Put the device back to the temporary state so that it will be
-		 * treated as a newly discovered device.
+		 * treated as a newly discovered device; also disable auto
+		 * connect.
 		 */
 		if (!device_is_paired(device, bdaddr_type) &&
-				!device_is_trusted(device))
+				!device_is_trusted(device)) {
 			btd_device_set_temporary(device, true);
+			if (device->auto_connect) {
+				device->disable_auto_connect = TRUE;
+				device_set_auto_connect(device, FALSE);
+			}
+		}
 
 		device_bonding_failed(device, status);
 		return;
-- 
2.28.0.681.g6f77f65b4e-goog

