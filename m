Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D3E92FC0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJEVX2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:23:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A495
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:23:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6969b391791so1170805b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696541005; x=1697145805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDhpUIqvl1ORkTIiMf5KpxmE5DtBrjSETYkFCLhSs/U=;
        b=Ooqcjk2MWgi84wJQPiAcjhCANO7BZ3icVSOHezBR8ZBdXQ1nOYr+97GnlYM5rl6XgZ
         z8cZnG5gK9+Hgz46QB0JJ0evFqpA1TSNPpPJM3SINAgE5uOUcwclVs6OLpUjeNfnVVKZ
         KhhxWD166Rom08yUY5rpN4ADsYDgaYCBTU2OivXkfEflZURvfciyYSOOY7paOEIYZ5ZU
         EsTNVMeBUQul+MPicCPglteqSkZJYkZM+oK2bahYuoGilVXwqN8k7lnIy+FMgzjU4FWV
         pSIMD4+xwXiK3jNP2dxQqRPX6qz0XIpC+oPHps+ZxleJlTiOXCSQKKxTj1iimjvf1YOG
         RGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541005; x=1697145805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDhpUIqvl1ORkTIiMf5KpxmE5DtBrjSETYkFCLhSs/U=;
        b=PKwL1hjtOruOPfYIkRhOp3QHOvpPCq4bcD9+C4zR1bxircYx02I2sZd+33JvGPdTeE
         IM3fIt1qbeqT5Amv7CJFTkSaQ0GsEvPa0DOeRkWAajj5PahCadlwkjDCgarUTJPw9tbP
         T93gcKXtEtlcRBnY6N6TwZyaD0WRK0Jr4HRnfPEY32fRYhoTDp7DUqM0WeXTcwgR87Dk
         E8ZbmX5s0GDEaqi0v4KY7pEbeQVJB1RDZXHJezyUWOKeqAEAsaaHzo6MsQ4j9mi6V0rG
         B4zHxngWA9JxzxgPr7ZCFsIzN2+MHxEy/OC+NhYgTnEJuoJUpWKcLnQE76wtVBEKW192
         JQOg==
X-Gm-Message-State: AOJu0YwykeDDdBS3tlhZQkT/MnCh0QDTmns7G73pzJXa9J5dVaH9/Snc
        axic6LLsz/LPlJH4E8pHtuQ1K662m0K+i+lS
X-Google-Smtp-Source: AGHT+IFg/VMNlQbXAFrgHsDWbbo22W2NOkHKXDeqKWc8wwtdiRZBi4mhiCcU/y7LbZEoR4tTiQcNfA==
X-Received: by 2002:a05:6a21:3293:b0:16b:89c2:8c0e with SMTP id yt19-20020a056a21329300b0016b89c28c0emr174759pzb.61.1696541005237;
        Thu, 05 Oct 2023 14:23:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm2208410plr.134.2023.10.05.14.23.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 14:23:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Fix using memcmp when comparing keys
Date:   Thu,  5 Oct 2023 14:23:21 -0700
Message-ID: <20231005212322.3886919-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

memcmp is not consider safe to use with cryptographic secrets:

 'Do  not  use memcmp() to compare security critical data, such as
 cryptographic secrets, because the required CPU time depends on the
 number of equal bytes.'

While usage of memcmp for ZERO_KEY may not be considered a security
critical data, it can lead to more usage of memcmp with pairing keys
which could introduce more security problems.

Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore NULL link key")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 43ed691d0d90..d9c1bfb3082f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -26,6 +26,8 @@
 /* Bluetooth HCI event handling. */
 
 #include <asm/unaligned.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -4754,7 +4756,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	/* Ignore NULL link key against CVE-2020-26555 */
-	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+	if (!crypto_memneq(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
 		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR",
 			   &ev->bdaddr);
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
@@ -5294,8 +5296,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 		 * available, then do not declare that OOB data is
 		 * present.
 		 */
-		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
-		    !memcmp(data->hash256, ZERO_KEY, 16))
+		if (!crypto_memneq(data->rand256, ZERO_KEY, 16) ||
+		    !crypto_memneq(data->hash256, ZERO_KEY, 16))
 			return 0x00;
 
 		return 0x02;
@@ -5305,8 +5307,8 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	 * not supported by the hardware, then check that if
 	 * P-192 data values are present.
 	 */
-	if (!memcmp(data->rand192, ZERO_KEY, 16) ||
-	    !memcmp(data->hash192, ZERO_KEY, 16))
+	if (!crypto_memneq(data->rand192, ZERO_KEY, 16) ||
+	    !crypto_memneq(data->hash192, ZERO_KEY, 16))
 		return 0x00;
 
 	return 0x01;
-- 
2.41.0

