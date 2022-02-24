Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F35C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiBXICx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBXICv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 03:02:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9391F4D0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:02:21 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so1196515pfv.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hN1KUPWY9afQ+BTU7QFCfJEL4ItjM5NtWEclGmWNcXg=;
        b=P8XBCUrKImQIgvvkoL+Ag6i0k/gmXTQhemT6aB426W3/R9nVtcbGfXQ84W//P3JIQb
         4Us1KRjR8mEE4wimOzZ2Z2OiN3DTwRYqhwfJsbzM0f7vgWF1Fwo3t0mDuzy6YJ2Ywkda
         HsSlp2AeXmexzV/lUJwTXh8uN5fEPet9cchgYleLUgAgRxKLBrhhQioa71l69hSIyOiI
         lO/BctcCcGSe8AYGYRKbHAKuKw7L+pf1djfmyrQwalYDkLCapqLyb7QAU4Xq7JCfqUXp
         DPUQZscOPTflu01HtJU8n2xHxRlIDv3tRETy2IXYUFn4Mz1B1hLzlfs0U3v2jPCavku8
         uUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hN1KUPWY9afQ+BTU7QFCfJEL4ItjM5NtWEclGmWNcXg=;
        b=NmIo9Yh4Xg0aRQJUOPtjFWOe9hKOiKQl7BP9qcm+KZ2lv1F0RLLiM6wRc+jO+pmS2n
         OA25m3qGL69EOOaP8iq7DvJEdbFRZXHh5KhJ/zggI+F0DrVzPSamyE+hAcX239KR4vLL
         vBCf6wArU6j9XY5iQlYP9lAvsTJwDldQekjRWu5wcLNGX0O1d5Kxn1w41VQbQj19h9M5
         BwPOpguIm+E7cEsXIBAtaCA+6JkuRdoxhVg9+cHVO+tTH5RC7B/G374k+JBPUmyEh+72
         VFYZEg0fkRflbZKUDppTV427z2wJND7abY5ic42hAJB9XzRvmM6DLJWznM301QBs6Tkd
         Si6Q==
X-Gm-Message-State: AOAM531tTrp0PlgRC1jk8s7oLGFpnngtQco+yutSr/dlT2NZ10JC9RGP
        Gc5EVtjpZUYGNBAd0dXDhSF7M19+whE=
X-Google-Smtp-Source: ABdhPJy6PTHYYjPuM9F/L7r+n1SWKhcmV+u9mB97oHvwqgg1J5h42vqruCmEb8huPBWfX4Ni52Qq9w==
X-Received: by 2002:a63:451e:0:b0:373:6a1d:2ad9 with SMTP id s30-20020a63451e000000b003736a1d2ad9mr1443541pga.114.1645689741050;
        Thu, 24 Feb 2022 00:02:21 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a740800b001bc691c79fcsm5099794pjg.49.2022.02.24.00.02.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:02:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
Date:   Thu, 24 Feb 2022 00:02:19 -0800
Message-Id: <20220224080219.38653-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_update_accept_list_sync is returning the filter based on the error
but that gets overwritten by hci_le_set_addr_resolution_enable_sync
return instead of using the actual result of the likes of
hci_le_add_accept_list_sync which was intended.

Fixes: ad383c2c65a5b ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b66a2271c433..ca51d6138540 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1844,7 +1844,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
-	int err;
+	int err, ret;
 
 	/* Pause advertising if resolving list can be used as controllers are
 	 * cannot accept resolving list modifications while advertising.
@@ -1930,6 +1930,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		err = -EINVAL;
 
 done:
+	ret = err ? 0x00 : 0x01;
+
 	/* Enable address resolution when LL Privacy is enabled. */
 	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x01);
 	if (err)
@@ -1940,7 +1942,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		hci_resume_advertising_sync(hdev);
 
 	/* Select filter policy to use accept list */
-	return err ? 0x00 : 0x01;
+	return ret;
 }
 
 /* Returns true if an le connection is in the scanning state */
-- 
2.35.1

