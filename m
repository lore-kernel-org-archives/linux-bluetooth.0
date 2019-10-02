Return-Path: <SRS0=2Aeq=X3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF179C352AA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8E21920
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 12:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="lNiYFAcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJBMW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:22:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34878 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Oct 2019 08:22:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so12581741lfl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2019 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSo3iWavk1pRbXCG/cqDdrV1tt/zFbSArjbwwbv/BmU=;
        b=lNiYFAcZsoN8uZ4+T3aMiO5Q+miuhgHQxY8Qwe2CwS0QdMb1kls9A6nnZ4prhP7qjd
         Dl4CJ7Tf7Qu+Vx7W7Xmcrk1L0n+QQlHItFwIjIvc/o1rEAc4Yj6rfzoZhCuz5Fmk0Ilv
         9nC8EcQ+rgYU78encLKY4DJAR4VAwDVWtr8RBsBkn87+7odW5sm1O6zQfLkUgcD9+K17
         X/GUhJfLSl23scZA9ce904sNXcnlt4W731SGsSnnVLl3aIWv7EWuTFsXCJw46+CeDdhk
         e58mQPY3DbyTnIoQOMP5JHEuOGzngzYsgdajYd1lw0qVk5VCMiUWhBAcp2EibY/X+y1W
         xJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WSo3iWavk1pRbXCG/cqDdrV1tt/zFbSArjbwwbv/BmU=;
        b=Gxbc4S1m7oxT/FB0KeTFoI739L9NpuHYq5gs5Y6aiK+MArhB5HPkaaOjPyjQX1pNkM
         uh6rZzyH2vlyycaIbBoGoAL27JcbtDwD8EscxauqP9eE5+EDNU+ZI+5m9QbKBwLxmuG0
         c4o2xsAlbc/Faso7LYQ8+EfFFIJQeoLsiygacHFstLJKROo5Teb5rfQ7lylbeGYsyOJa
         2oON/mDBW8SXhItaoJw0LbFCyr4/n7eZKe5xm7r3iKCJsUT1zoQWn2kccVVa37CC58jE
         fmlViXkOAvoJvl91oL0l5hfisE2Eym5e+7iD0Uk3tMkQ500p7CFdAl8ozotfRXCxrDKP
         FBuA==
X-Gm-Message-State: APjAAAWZXZ8wDichn1b0iUdSbb5R0rGiKZeFULR8M51l41mgW3Lp2Omn
        V/olz6rQmr2Kdrb5s7tutPcfTmqGxPM=
X-Google-Smtp-Source: APXvYqyiEaeQZlLx7NQAG18XA7HjkyOOJbwm9wBxGbem7A1sK9gkFpSBa1WTULcbZEokvuKccJ1nOg==
X-Received: by 2002:a19:2313:: with SMTP id j19mr2161089lfj.138.1570018973320;
        Wed, 02 Oct 2019 05:22:53 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id m17sm6105577lje.0.2019.10.02.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:22:52 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        =?UTF-8?q?S=C3=B6ren=20Beye?= <linux@hypfer.de>
Subject: [PATCH] Bluetooth: Workaround hd directed advertising bug in Broadcom controllers
Date:   Wed,  2 Oct 2019 14:22:43 +0200
Message-Id: <20191002122243.31519-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It appears that some Broadcom controllers (eg BCM20702A0) reject LE Set
Advertising Parameters command if advertising intervals provided are not
within range for undirected and low duty directed advertising.

Workaround this bug by populating min and max intervals with 'valid'
values.

< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15                                                                                                                                                                                                                                      #75 [hci0] 29.155775
        Min advertising interval: 0.000 msec (0x0000)
        Max advertising interval: 0.000 msec (0x0000)
        Type: Connectable directed - ADV_DIRECT_IND (high duty cycle) (0x01)
        Own address type: Public (0x00)
        Direct address type: Random (0x01)
        Direct address: E2:F0:7B:9F:DC:F4 (Static)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                                                                                                                                                                                             #76 [hci0] 29.156745
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Tested-by: Sören Beye <linux@hypfer.de>
---
 net/bluetooth/hci_conn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ad5b0ac1f9ce..7ff92dd4c53c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -934,6 +934,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
 			return;
 
 		memset(&cp, 0, sizeof(cp));
+
+		/* Some controllers might reject command if intervals are not
+		 * within range for undirected advertising.
+		 * BCM20702A0 is known to be affected by this.
+		 */
+		cp.min_interval = cpu_to_le16(0x0020);
+		cp.max_interval = cpu_to_le16(0x0020);
+
 		cp.type = LE_ADV_DIRECT_IND;
 		cp.own_address_type = own_addr_type;
 		cp.direct_addr_type = conn->dst_type;
-- 
2.21.0

