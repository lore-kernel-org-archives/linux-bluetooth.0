Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCDEC55ABD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 04:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714F221D91
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 04:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFzZkcSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgKKEzm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 23:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKEzl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 23:55:41 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD4C0613D1;
        Tue, 10 Nov 2020 20:55:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u4so626126qkk.10;
        Tue, 10 Nov 2020 20:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OJIv0opzVbfrAjXNpwUzELsHB6itnaiepO4pAicv9Tk=;
        b=PFzZkcSpK0l2foKtH3NnzBLmIzTFVVNSCLcSoKOCRFyeYqtDMKmd12s8R3Q1gM3YtC
         AKbxRZGf4Uf57kSKXVeYp/JioYr9nac2LveVBXD/TVy2mMrZZlXCWkc5H5NkiyVp07vy
         CXqFE7uqnXSIlgcx+R+BiKvEiD4MT1SL019bRuyFCoCH47z763QP+N9gVzPikUi98VyB
         r0PiOlrBINuHhrfMPK6Negp89xASdN15N+goWCs4mhq9pUcWnDVvkalSr8SxqJ0KlHAi
         avhHB8i6S7F3wziKrC9oJemGvASaBZ+PlII+nHLN+j6pdKXu4DfMnXJf0xeXIF1gABEr
         6e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OJIv0opzVbfrAjXNpwUzELsHB6itnaiepO4pAicv9Tk=;
        b=ZFRpI1ao0k6Kc5+vM5/dYs59SmCKKDeE0yl60U1tJ1I4ShE2dtXDaA7V51dJL+sqUx
         RBSWgDxxclo4AisVifp5mxQJX72qrbaZwfPzIplnz3NMW1gk6731Sy1G85RnqXc6wL2l
         ajhkzqtV0I2Oe9i1uWI+YZE2klzWBPctYtx/bTn4IbCSzjMYcjb5VZAzcFyaF+NMBL6W
         sNhgTuaNOiufzxIM+uo0hFr4wkw8Gc3m/2ZHhZf7w89FQMt1h1zULcCtSPI9QIzM8WF4
         dxR8Nd22DBPmRYDSBDvNmSpoymxkS7ShFn56HyFY5IY8HTpzfsb8RRsHAAxm3/iapgCZ
         oqWA==
X-Gm-Message-State: AOAM531cQiXmABkvsBZDhi2XpnXlFsdiKcyJfwl2hV6/3Nf028oqegxS
        EFJiuyI5mttqiTjz3Y7YbbA=
X-Google-Smtp-Source: ABdhPJwPCDxMsqGDi538lzx9L1zKn6yWdHktJ2upA0OEbwDv5HCWNQXsVkuVrgvSN29eRIy9uxxdRA==
X-Received: by 2002:a05:620a:886:: with SMTP id b6mr3789982qka.427.1605070540846;
        Tue, 10 Nov 2020 20:55:40 -0800 (PST)
Received: from fedora-project ([172.98.75.205])
        by smtp.gmail.com with ESMTPSA id h129sm1148142qkd.35.2020.11.10.20.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 20:55:40 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:55:38 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, kernel-janitors@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH][v2] Bluetooth: hci_qca: resolve various warnings
Message-ID: <20201111045538.GA90261@fedora-project>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replace symbolic permissions with octal values. Use usleep_range
for small msec values due to the fact that msleep() less than 
20ms may have unexpected behavior/sleep longer.

- https://lkml.org/lkml/2016/8/2/1945
- Documentation/timers/timers-howto.rst

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2d3f1f179a1e..039fb117bd8f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -631,7 +631,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
 
 	/* read only */
-	mode = S_IRUGO;
+	mode = 0444;
 	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
 	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
 	debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
@@ -658,7 +658,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
 
 	/* read/write */
-	mode = S_IRUGO | S_IWUSR;
+	mode = 0644;
 	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
 	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
 			   &qca->tx_idle_delay);
@@ -1302,7 +1302,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	if (qca_is_wcn399x(qca_soc_type(hu)))
-		msleep(10);
+		usleep_range(1000, 10000);
 	else
 		msleep(300);
 
@@ -1350,7 +1350,7 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	if (on)
 		msleep(100);
 	else
-		msleep(10);
+		usleep_range(1000, 10000);
 
 	return 0;
 }
-- 
2.28.0

