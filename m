Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E2C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 12:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132120722
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taZK7smQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRMtf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:49:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33755 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRMtf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 07:49:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so19348735wrr.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Er13n1f9r1dDvRCAZ2ELhKqMF8fgzn7udaqvsc/4g=;
        b=taZK7smQ1extpIirFf1VUycjTZ+Wf3rCFCRKN1qRE60IEYsxYVzfE5dKT+5Wq7rqz9
         7DKBHd9gqmlNnlKnRKlN7Rq3lm7YYgldk/oxmoLvOvygErZJ/9s+45CHovon6wvPrupB
         Rd+aOF6CC9eg+xQNMXe4gwVmwX1qLZp8T51kW11KvyoFtj452SZMDhLWc4TJVr3ZLxFV
         6vfCnQAddfIqDrO9GAUQop0mAyUoiR7oOadvUTZROZSptZQ6RbIE+b7t9RCeyhD3Vh4y
         B966H0ZW9zcf2OYGA1rlqKjeOzcnYRT0ZLq/hQKZRKD/i11aaxy0ZF/RdjuaGN3yOKWu
         4fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7Er13n1f9r1dDvRCAZ2ELhKqMF8fgzn7udaqvsc/4g=;
        b=qhRebtD7QjLLV7ss4k/wQ1/EhWDuljRspMXhuwf360VBRZ8aV8QwMZNFdGZvmzbKcG
         JbqNO7JqxpTnh1petyi5Oij2roxtW8W/RDpPra0RcHxKPS5qmB90ithg9tM2SLUuHq0h
         Aia3JDIRpF5KbJf1sFe0g15I5+tDO9i7/O+k7QcWF/DwMb/LeVv8/3CcgBaXms9HFmGD
         phF+fbyiLD+svkf2JkHBVs9v4qHLhfdOW6qL2KRMBomveO6XeNR8HxU0MRFy6cW6Oazh
         yUhfTVir72GP6Gtc/F/hu+9X+P4Xmw3kOGx2i8K4jDU+qC5Nhho4Q7NZ3oD849r82c9i
         HLGg==
X-Gm-Message-State: APjAAAUAbUADTqNFTMKOubLoZGjpQZ2CrNV/TG29T8MrdCaS8tgKmhUz
        ZpqbSSJu7iahqdC8qY9a2PA=
X-Google-Smtp-Source: APXvYqy1VG9RfCQHWb2F6er6G/r9FeY1aG9QWGY2SVhXaef63q/YTO4gnF5wLgD7hMvZoXVlzr3efQ==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr31197333wrw.64.1574081371585;
        Mon, 18 Nov 2019 04:49:31 -0800 (PST)
Received: from mamamia.internal (a89-183-49-198.net-htp.de. [89.183.49.198])
        by smtp.gmail.com with ESMTPSA id a11sm20550343wmh.40.2019.11.18.04.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 04:49:31 -0800 (PST)
From:   Andre Heider <a.heider@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH] bluetooth: bcm: Set HCI_QUIRK_USE_BDADDR_PROPERTY for default addresses
Date:   Mon, 18 Nov 2019 13:49:30 +0100
Message-Id: <20191118124930.2138112-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some devices ship with the controller default address, like the
Orange Pi 3 (BCM4345C5).

Allow the bootloader to set a valid address through the device tree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/bluetooth/btbcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..e1471777486e 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -79,7 +79,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
 			    &bda->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 	}
 
 	kfree_skb(skb);
-- 
2.24.0

