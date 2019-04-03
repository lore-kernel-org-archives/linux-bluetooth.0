Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F1C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113E62084C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9SNkJCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCGqg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:46:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43503 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCGqg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 02:46:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so7647324pfd.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2019 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QjhL6eHplfenH9MUyklSZQ3sBCcJSullMD0cGNtbrOg=;
        b=I9SNkJCqX49N99G5tekR9i2qb1M0ZufAn7FEYZIzB4IXMloMKhQO8GCbsCXk/NdOG6
         UP/BpK56KzbQngyANGFWuz1y5300df04H2enx3Y5nhjjmd3fnVwQypwdr+K/0ch1Txw1
         S0qvWm2TRfHJl+hqoWdYiJ+GHcUG2JvKI3x61lN2GJEfvjyBFW05GFkWFmg8f447r58F
         y489J0k5Sg1HmYzWJKoNHh4KQcSvTGXN7dlmYaCv4THiXoVsNT6uos26SpK8lvtbjXZu
         TrEloLdAAbrLcVYkIpqSH6sE3vcyszYrm2KYSdBBPIFs1dRBPfyVVs2ysFcETFYILOkW
         ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QjhL6eHplfenH9MUyklSZQ3sBCcJSullMD0cGNtbrOg=;
        b=qpvTxq/bGR2qt9xm1wAlBiaVUrTnCzcQ6nu+iZbsDUmVUR5boHl2ok3H6rjw8XTt9S
         eDzUIJLz/RgmetyPtlyh97tibmNn0z1yIeun6ABJNv5ZoJtEmKSJEFb0OTxsiEwweX5T
         cKCNc4Jd+Np6sf7V1WGd9Nwz+WB5VlgwwXH2SKddXWI7Yi37EYUdcNtWrUDdfHuiH784
         W26bA/mGqkTY8a9qDUh790dCWPx/01yBGvSFXhrXlrIiYEeBAp3Nm8Ogsz3yL5zl2Iju
         VxTobxfZuY5vVc+AoGWNMtfY5Pjj+0FVo5dQZR7i33P6onwwaVRzle7QG0AzwN+KHiLp
         K5gQ==
X-Gm-Message-State: APjAAAX8VnIC60WgHX2GOXv3y9ZW4j7WEPDIRyhYNxmuhuCRx7trxUi9
        +wMNUlBxzmFENENMn7wF3VJmFKfgROY=
X-Google-Smtp-Source: APXvYqwoc3cjG5FZ1g5r3URxZex24b3Ps/lD8nF4gKTjejpF2GRaCAocX674SSGyDhDYpFDoqwgkRg==
X-Received: by 2002:a63:2b4c:: with SMTP id r73mr24050pgr.181.1554273994895;
        Tue, 02 Apr 2019 23:46:34 -0700 (PDT)
Received: from wcs0336-Latitude-E5440.iind.intel.com ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id 143sm23009026pge.50.2019.04.02.23.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 23:46:34 -0700 (PDT)
From:   Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Google-Original-From: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Subject: [PATCH] Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt
Date:   Wed,  3 Apr 2019 12:11:44 +0530
Message-Id: <1554273704-4004-1-git-send-email-jaganath.kanakkassery@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In ext_adv_report_event rssi comes before data (not after data as
in legacy adv_report_evt) so "+ 1" is not required in the ptr arithmatic
to point to next report.

Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd68..66b631a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5433,7 +5433,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 					   ev->data, ev->length);
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		ptr += sizeof(*ev) + ev->length;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.7.4

