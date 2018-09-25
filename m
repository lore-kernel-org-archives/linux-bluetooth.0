Return-Path: <SRS0=tqgc=MH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F1C43382
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977C9206B5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqBtNwNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977C9206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeIYXNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:13:40 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52268 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeIYXNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Sep 2018 19:13:40 -0400
Received: by mail-qt1-f202.google.com with SMTP id s1-v6so9364285qte.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Sep 2018 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XNFrG7MHfW16jX5ND0syUvGF4DO69Z3RPxcmPG5lFf0=;
        b=OqBtNwNtxV3EuBKxq/mIjMeN+ntNXPy8yv/Q/yLKneAUkqhG8FCZribchXch4ImA4Z
         XPFYcC6oeOidgx9tm7w/A9tt7oGVcq/Dk820yTi1V40UPhqnmAst6AINl4A4lvInKKL5
         EJRb8gdIHBpuH4cEBOCu+V1lA7WuTMeWHN0LXjlf9kimrB5sUJwFGLXZY+YPgFaoq1Vq
         sGEhguE3bDEyL8LL6tPBg0IpjAJvhWmpLbsAhtOcfkW4jsdh4ktBmY9OfDta+PUN25sj
         VRklUHaNRoNdQtC7i6WyTVMNeY7kRi02lLl5jIuK9r7gz7HzsgW/CZb7K274jlrHtXEs
         Stdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XNFrG7MHfW16jX5ND0syUvGF4DO69Z3RPxcmPG5lFf0=;
        b=PjbahCs/CcTE7aMflO7F2MAiGaKAQXXCgPxSHGyoLavC1X5xdK0zQa7P+hcGLD7oFB
         oePqeM9kUJWTjqh7MMNV+2vUICLuS74LXUvWjNq4IYveo82K6+G2NjKa6M+9BxOJE8Jg
         t8DIlf0kohBvUmH2UnmQVBYxadPdHmzAGgRN0nZHxoMj0W4QGTwV9O9ikWaGG84lqssd
         Y1Nbz/YVlY6NYwo5ZuRYs4HrslimzbtdNT54wnMs2rBPVjNfhm5DNi9JMxrDXoh3WDSR
         EHgNHM2tbB4NAnMWglUDi9n+wFj4Iwg/OE4KFtFVwz0KidJP1aVW2kuRqVU+AlsaSHRt
         XuOw==
X-Gm-Message-State: ABuFfoj30gyKJLZbocIRL5g8ZZJadVxk4XPbKqm8luZvHX+hBl2x6vDJ
        XAznIEPQi2nu17kfWTPtzSIOPE8jMZDMxpNxdi5Sx+jBPnS0pDnxOmZzVvE8zosLlnRfuKbxIvk
        9ktdwA2wfUMtRci4ASxcTigNXEGqfecNDeIk9+M0sNytjThO7+wxhAsJzUqNL+KCDcryq/aIu1Q
        9skgo=
X-Google-Smtp-Source: ACcGV62uInoXeaBNlynW1albrBI7BA9WP/W+1WQ3+BeIXSYHS+QjhLPTImPiIVXlhjmLkIIYf56FA5XG4DHK1A==
X-Received: by 2002:aed:3bd1:: with SMTP id s17-v6mr649750qte.24.1537895114958;
 Tue, 25 Sep 2018 10:05:14 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:04:57 -0600
Message-Id: <20180925170457.33979-1-teravest@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] Bluetooth: btusb: Add quirk for BTUSB_INTEL_NEW
From:   Justin TerAvest <teravest@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     jpawlowski@google.com, johan.hedberg@intel.com,
        Justin TerAvest <teravest@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Intel "new" controllers can do both LE scan and BR/EDR inquiry at once.

Signed-off-by: Justin TerAvest <teravest@google.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd2e5cf14ea5..61cde1a7ec1b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3096,6 +3096,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
-- 
2.19.0.605.g01d371f741-goog

