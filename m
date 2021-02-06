Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D66C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBB464E83
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBFOPL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 09:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBFOPJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 09:15:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C638C061756
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 Feb 2021 06:14:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f1so14794877lfu.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Feb 2021 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9k1YM7+WMW0ESXMJ6uw/g/9phZuX7TXSzi3wbRk4eU4=;
        b=fNsSbCgcftFadPCfcH4GtgyhIfuhPq7FzYhVLxutg3hKJ3kaTPzg1e8P3jVVwpNZzH
         5aClq+9Z6zF+EnaWm70ls0r1coi8jq30bsTeEqrA8GCsp3j8rgyS7EuxrGfbr/FXPucR
         aYKMGGbHx41XSP/jKo5d1MGhwRU070sefy6VENuRuhtdUi+AmErLBGAbb3L+BYN+oON8
         KMko6KOAE8Xm5r8RxreLB4Wnm8kHXZWi5uaF+n65S6HqZX9+rM9ciK2ebBloYKObwwnj
         T61THhE6+lJqXbDgoLznBqIIV6vSpDWtDu4OA0fCLAureNYxjSxbFfvwnVGn+0U693Dk
         8MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9k1YM7+WMW0ESXMJ6uw/g/9phZuX7TXSzi3wbRk4eU4=;
        b=Tg9R9RIIgEgSKWopeUtO7kMdkYZGAqRrf7FCVMW/HXVvq+7LToTTTeiPR6yT04v2aX
         iW/zFmJ0xaSTSjHHB1mDkqq562PAt9VtwUxvB6Z6Oe6EVuiwozdCT3AMSzJUwVUdIQhy
         8cWOJBbLA39KDVtHIsG3+qZMhJhyb9kog4nFloPxH2bHay6RFe+kXfay91unDwMSREy8
         +iVCoE5OVl2sL2C1qQkARG7oUGFFCxOvvEJs2eecjsCEe/WDhHNd+cVWnBhxAK5NDZys
         xV3xctRF0oyVEV0BdayfJFbcWVxgm4gtd1tIsfIvv2x8Sn10gS1pI4MAOJGGZU8Qa7vM
         ve1A==
X-Gm-Message-State: AOAM531B5+Dmg0uTszK++1qnYNvKRSTzFoY3Dydqt70qBmCyy00z323k
        ZJHXzxMg2XxTgbQQKsMq0yPVcSAdH24zOD/VZ7c=
X-Google-Smtp-Source: ABdhPJy5W731sVV4snseBAn7sm/qlTKUmccVX9foPKqzkg5KhPuLRv3wuoPasE0u54uwQI2Tp+N6Og==
X-Received: by 2002:ac2:4ad0:: with SMTP id m16mr5203104lfp.53.1612620866630;
        Sat, 06 Feb 2021 06:14:26 -0800 (PST)
Received: from localhost.localdomain (dy57dxw0xwqyrd19ksxjt-4.rev.dnainternet.fi. [2001:14bb:676:39cb:d393:40e1:d7a8:7ccf])
        by smtp.gmail.com with ESMTPSA id w15sm161137lfp.171.2021.02.06.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 06:14:25 -0800 (PST)
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/1] Bluetooth: Fix Just-Works re-pairing
Date:   Sat,  6 Feb 2021 16:14:23 +0200
Message-Id: <20210206141423.13593-2-matias.karhumaa@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206141423.13593-1-matias.karhumaa@gmail.com>
References: <20210206141423.13593-1-matias.karhumaa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix Just-Works pairing responder role in case where LTK already exists.
Currently when trying to initiate re-pairing from another device
against Linux using Just-Works, pairing fails due to DHKey check failure
on Linux side. This happens because mackey calculation is skipped
totally if LTK already exists due to logic flaw in
smp_cmd_pairing_random() function.

With this fix mackey is calculated right before requesting confirmation
for Just-Works pairing from userspace which in turn fixes the DHKey
calculation.

Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
---
 net/bluetooth/smp.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b0c1ee110eff..c3ea50fcac6d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2122,7 +2122,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
-	u32 passkey;
+	u32 passkey = 0;
 	int err;
 
 	BT_DBG("conn %p", conn);
@@ -2174,24 +2174,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		/* Only Just-Works pairing requires extra checks */
-		if (smp->method != JUST_WORKS)
-			goto mackey_and_ltk;
-
-		/* If there already exists long term key in local host, leave
-		 * the decision to user space since the remote device could
-		 * be legitimate or malicious.
-		 */
-		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role)) {
-			/* Set passkey to 0. The value can be any number since
-			 * it'll be ignored anyway.
-			 */
-			passkey = 0;
-			confirm_hint = 1;
-			goto confirm;
-		}
 	}
 
 mackey_and_ltk:
@@ -2206,17 +2188,16 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
 		return 0;
-	}
-
-	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
-	if (err)
-		return SMP_UNSPECIFIED;
-
-	confirm_hint = 0;
+	} else if (smp->method != JUST_WORKS) {
+		err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
+		if (err)
+			return SMP_UNSPECIFIED;
 
-confirm:
-	if (smp->method == JUST_WORKS)
+		confirm_hint = 0;
+	} else {
+		/* Just-Works needs hint for userspace */
 		confirm_hint = 1;
+	}
 
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
-- 
2.25.1

