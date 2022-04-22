Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 23:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiDVXF2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiDVXFJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 19:05:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805EFD95E5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 15:34:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ks6so18998699ejb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHfIxAFqQN61lGS5l7pwUUOsrYG7F+//1ileyJBeizo=;
        b=ZdjJr/jxili3+imimW4/sFImfb58urLOAQ0p1mf0BseJDxFqSLPBVLIknx8B9+dWeT
         fcevYTW55XjczS/hVesMxyGNm4lWFoib4Pl8XaCsvk54Brrr1I4+DkvUPcVnGsO1IgX8
         MmcQq20Xx7MuITaBp0y011PXB2Heajg94riVzUYCnLYDhmD2ElVGmkGJbBcQJBnA2C5w
         TrG4MLirDJsXzuNqCpJ8ymMA2DwV1Jn+l7xy02bTT19PnORyFZitU6xbg466QVVdMyBM
         lPg+BqqWcLKSTJGLD/xUkaB6K+tvoeKKuvkGwkr6rt8tIl8QhRoHxnlpFEan1uXeyZiJ
         AnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHfIxAFqQN61lGS5l7pwUUOsrYG7F+//1ileyJBeizo=;
        b=ef3fgpc4CkSaCkxCai8108RJCsGlg4bN5lmrHsZ6n/HfZlVqP5V414NnqafY/0Bx1i
         nVPudL8FHxHuDvnzIJvlen2YPy0DWfFqlefZ73uZalyIcoLiHtTrva3CjtE1rg4TPLDs
         3JRrIQKhPKdnURauEAAbLX6KdQkzjUJf5DHY4D88YG1UOZjU41XGYY/8KheikaXPMyRM
         4QJc4mxiLUYO2tSUS7vjRg4ILyqgJuPQqPs0/wc5kaRBPaK/2gjuZ+eoLwHTooKw3V3F
         kgDmYZb0cJKQtJcc5y6oS8t0ZJz99eS88qPTlWgVnJj/J90iR6pM1l5nkl5GJ8U6MpvD
         OnDA==
X-Gm-Message-State: AOAM533dORJA3jzSYy7psbaKp7LNDWFxl1AMlFzBoxTWEx2p4fD7y/i5
        elbtNh0BLhjE58AwCYTQGS7LPM9DkPM=
X-Google-Smtp-Source: ABdhPJweyDXWKpwyma13wBLZpLgX7NjnB1dxJdb2ElLCncr8UGPiFI1YQtwkYFDx4R5LEAurJybG8g==
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id i3-20020a1709064fc300b006e066a5d59cmr5959048ejw.131.1650666847981;
        Fri, 22 Apr 2022 15:34:07 -0700 (PDT)
Received: from nlaptop.localdomain (178-117-137-225.access.telenet.be. [178.117.137.225])
        by smtp.gmail.com with ESMTPSA id zk19-20020a17090733d300b006f00e918483sm1137073ejb.84.2022.04.22.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:34:07 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ankit Navik <ankit.p.navik@intel.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] Bluetooth: protect le accept and resolv lists with hdev->lock
Date:   Sat, 23 Apr 2022 00:31:17 +0200
Message-Id: <20220422223116.70026-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Concurrent operations from events on le_{accept,resolv}_list are
currently unprotected by hdev->lock.
Most existing code do already protect the lists with that lock.
This can be observed in hci_debugfs and hci_sync.
Add the protection for these events too.

Fixes: b950aa88638c ("Bluetooth: Add definitions and track LE resolve list modification")
Fixes: 0f36b589e4ee ("Bluetooth: Track LE white list modification via HCI commands")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis as my master's thesis
in order to obtain my master's degree.
If you would like to have more details, please let me know.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. This was compile-tested and runtime-tested on x86_64.
This issue was found on Linux v5.17.4.

 net/bluetooth/hci_event.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..f314eb0bf284 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1835,7 +1835,9 @@ static u8 hci_cc_le_clear_accept_list(struct hci_dev *hdev, void *data,
 	if (rp->status)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->le_accept_list);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -1855,8 +1857,10 @@ static u8 hci_cc_le_add_to_accept_list(struct hci_dev *hdev, void *data,
 	if (!sent)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_add(&hdev->le_accept_list, &sent->bdaddr,
 			    sent->bdaddr_type);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -1876,8 +1880,10 @@ static u8 hci_cc_le_del_from_accept_list(struct hci_dev *hdev, void *data,
 	if (!sent)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_del(&hdev->le_accept_list, &sent->bdaddr,
 			    sent->bdaddr_type);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -1949,9 +1955,11 @@ static u8 hci_cc_le_add_to_resolv_list(struct hci_dev *hdev, void *data,
 	if (!sent)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_add_with_irk(&hdev->le_resolv_list, &sent->bdaddr,
 				sent->bdaddr_type, sent->peer_irk,
 				sent->local_irk);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -1971,8 +1979,10 @@ static u8 hci_cc_le_del_from_resolv_list(struct hci_dev *hdev, void *data,
 	if (!sent)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_del_with_irk(&hdev->le_resolv_list, &sent->bdaddr,
 			    sent->bdaddr_type);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -1987,7 +1997,9 @@ static u8 hci_cc_le_clear_resolv_list(struct hci_dev *hdev, void *data,
 	if (rp->status)
 		return rp->status;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
-- 
2.35.2

