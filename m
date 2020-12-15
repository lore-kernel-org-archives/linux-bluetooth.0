Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B19CC4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC90320738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 09:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgLOJse (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 04:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOJsV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 04:48:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7346C06179C;
        Tue, 15 Dec 2020 01:47:41 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 11so14168627pfu.4;
        Tue, 15 Dec 2020 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ca+mZ398Rl+dDaOGaQV9OoXFwqIu+yToEg8Czl1cro=;
        b=iwidnU7y/iLKg4Vsr5e5wDkO7iDTG2mRpWpz7f2Dh4+uzMUBRhNQp8+xRYijyxnUAe
         jaf3DhNBSlKCh6eP/n05sEPxCKEurE8SAo7Ltfz1+eW5jryOL/B709y6r3pQ0YTmlHFY
         Pu2QsEnx2U42/qukF/1HsIPkmBSmr1kz+iJrleumAiwDzzcjc0Uktu+pH4/cL0PwAASV
         isa3cW9pHQfeBE/tHCJCF2BabYmfslUgx2Enm6qdfiREpHe67QvpyQGDs4kFi3UjrJcK
         /Vw5i0GEHkC4fI+/0J6xCE0inVNbVG/8JA20x5+iI1ZiCqhuV+EFWkegRzhHO1L5INeP
         I2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ca+mZ398Rl+dDaOGaQV9OoXFwqIu+yToEg8Czl1cro=;
        b=PJD6w594qcJI2wYKUN3cX8vfXGa5869rwMOeZjZmUTmbe5GkQ6g3nqItNz5fB7gaZd
         m0T+936bQAkdfH3cT0214OfwwDDje7xbRc0AK6n/KAPdz2VtRV+vPIuUXsy3uO75vFXb
         6mgRUOzRlIes5ip8LUD20uti41vKir4cSnt5WuzWj0wCtsaopK676hOLQzZleAQqL1FF
         zoU/kMhIAcseWB8OOGVdfnpVpJj8XePAMfYfrUnp1sp7ki/wA4VZuYk30W37h37xHSKf
         cib90hCh13cyj3EoIG9ov97bgPsmHVCjMeCGoBBASNk11ZaPycF/rIopdEWmH9vsdsUk
         OM7Q==
X-Gm-Message-State: AOAM532NKGdoMwc4dzw7ZYO2QEoXRlAjXOdgZ8kUhSi+n24RpUNsiegr
        ZVbL5bmhm2lTfXV45ewJJbY=
X-Google-Smtp-Source: ABdhPJw6V1GV3O509T2cIjHrgflK7BIaf9NGoTzII5FKkl4k9LMou2Nqj2TH8SqfmWG/DEYI36AuGA==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr6708995pgt.202.1608025661232;
        Tue, 15 Dec 2020 01:47:41 -0800 (PST)
Received: from ubuntu.localdomain ([49.206.55.110])
        by smtp.googlemail.com with ESMTPSA id w22sm22373976pfu.33.2020.12.15.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:47:40 -0800 (PST)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        matthias.bgg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagdish Tirumala <t.jag587@gmail.com>
Subject: [PATCH] Bluetooth:btmtksdio Fixed switch and case should be at the same indent
Date:   Tue, 15 Dec 2020 15:17:30 +0530
Message-Id: <20201215094730.361510-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Switch and case where not properly aligned

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/bluetooth/btmtksdio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ba45c59bd9f3..605b0cc84697 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -442,15 +442,15 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	}
 
 	switch ((&pkts[i])->lsize) {
-		case 1:
-			dlen = skb->data[(&pkts[i])->loff];
-			break;
-		case 2:
-			dlen = get_unaligned_le16(skb->data +
+	case 1:
+		dlen = skb->data[(&pkts[i])->loff];
+		break;
+	case 2:
+		dlen = get_unaligned_le16(skb->data +
 						  (&pkts[i])->loff);
-			break;
-		default:
-			goto err_kfree_skb;
+		break;
+	default:
+		goto err_kfree_skb;
 	}
 
 	pad_size = skb->len - (&pkts[i])->hlen -  dlen;
-- 
2.25.1

