Return-Path: <SRS0=UCBE=UR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768FAC31E5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1AD20863
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jun 2019 22:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="mXMRsfFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfFRWsk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:48:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42044 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbfFRWsj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jun 2019 18:48:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so1188153lje.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8772S93SESJK7k4owiJBKvos4eqPSCTz+wD3Mw1imI=;
        b=mXMRsfFQJAPYdse+uAWzSKjIfN/Lz/jZT/lIjbTE6baWDexkaNIIuOuBl5NTZgUpxy
         C3WQt7J3dYeE4jKl54hdzuUMT9Ucw+GCY34uHUS5FFgDA6Tt9V3nOswYfqJSlxCBXP74
         v0JcVx6sWmNLaiC40C0PB7Aj8jCZ3tIM73oTcKWHcjkElLZ5SA4+2pXnpTNjSyaJza3Y
         o7djHoGilHU0bLCEnMpkEFSNZ6Y9qf+/ETM3ddInToNTTUIwR3v0ub44HRSYHTOK8V5b
         ygCJpQdMY5Wqx0/Nz5iGR25tUMgneIJk65pUcs4mVOda+6zflGdsIjJqVXZGb7HR0bhj
         I4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8772S93SESJK7k4owiJBKvos4eqPSCTz+wD3Mw1imI=;
        b=Mb+APMBUzdJS0rwS2InYLHkio4wBWlvVQJdHDMDfLMqurDuNCH6eL6le0IRTXtIlsI
         H+qSb6AvX93/jIyHp9RraCN7rP21XsQvByVwPoT7Y18RP2vsQ3VM2iUqTDUGpPaf6NZM
         G88+U1iAuM4qffdnU2+5xAG46B74dqUXBP8SeYXtn6jrZnjY3e5k7n747hPuqe6B3lkV
         whQj9hWsKTtlF2Pj+N3zkZhz19nR8RI0cP1J4JdHyi9jfuD98ZSrp+4BSmd0WxJROp6o
         UmDqtEeF0K8qGF9i0P7JbHX0jK58sxIVksyjT8lKabdo7HHH5jKBH44kqx3TTu6O8NuZ
         siQw==
X-Gm-Message-State: APjAAAWn8e/FypRimV3Cp2sSRCxEzh+xVcxIAbmPMSP29N1wSf2N8vZd
        qL5brLo27vTEroLJ/IZQzsm+IpBo0iE=
X-Google-Smtp-Source: APXvYqyAjiVKxCOYRa3BP9kn0EdaEbwl1LmG/mIuTFk7SJGcqL1RixwWU93f2PljEzxkooclI8d2fQ==
X-Received: by 2002:a2e:3807:: with SMTP id f7mr24271929lja.87.1560898117578;
        Tue, 18 Jun 2019 15:48:37 -0700 (PDT)
Received: from localhost.localdomain (ftth-nat-19.ip4.greenlan.pl. [185.56.210.19])
        by smtp.gmail.com with ESMTPSA id h11sm2398837lfm.14.2019.06.18.15.48.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 15:48:36 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        Maarten Fonville <maarten.fonville@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP: Workaround Microsoft Surface Precision Mouse bug
Date:   Wed, 19 Jun 2019 00:47:47 +0200
Message-Id: <20190618224747.446-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Microsoft Surface Precision Mouse provides bogus identity address when
pairing. It connects with Static Random address but provides Public
Address in SMP Identity Address Information PDU. Address has same
value but type is different. Workaround this by dropping IRK if ID
address discrepancy is detected.

> HCI Event: LE Meta Event (0x3e) plen 19
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 75
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E0:52:33:93:3B:21 (Static)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00

....

> ACL Data RX: Handle 75 flags 0x02 dlen 12
      SMP: Identity Address Information (0x09) len 7
        Address type: Public (0x00)
        Address: E0:52:33:93:3B:21

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Tested-by: Maarten Fonville <maarten.fonville@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199461
Cc: stable@vger.kernel.org
---
 net/bluetooth/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e68c715f8d37..d528d95a2c27 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2579,6 +2579,20 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 		goto distribute;
 	}
 
+	/*
+	 * Drop IRK if peer is using identity address during pairing but is
+	 * providing different address as identity information.
+	 *
+	 * Microsoft Surface Precision Mouse is known to have this bug.
+	 */
+	if (hci_is_identity_address(&hcon->dst, hcon->dst_type) &&
+	    (bacmp(&info->bdaddr, &hcon->dst) ||
+	     info->addr_type != hcon->dst_type)) {
+		bt_dev_err(hcon->hdev,
+			   "ignoring IRK with invalid identity address");
+		goto distribute;
+	}
+
 	bacpy(&smp->id_addr, &info->bdaddr);
 	smp->id_addr_type = info->addr_type;
 
-- 
2.21.0

