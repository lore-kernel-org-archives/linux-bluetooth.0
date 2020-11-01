Return-Path: <SRS0=tvhF=EH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C700C388F7
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Nov 2020 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F31206D4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Nov 2020 02:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umom7FhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgKACwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 31 Oct 2020 22:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKACwU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 31 Oct 2020 22:52:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8DC0617A6;
        Sat, 31 Oct 2020 19:52:18 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id v18so9970141ilg.1;
        Sat, 31 Oct 2020 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ymv3krvO+KBpzoJZenR2aK/VabbYECbdVnvgf1aHcp4=;
        b=Umom7FhPP0wQBFSz/kQEncP2eWGjXuwIGQfqDwxya1rqfct8OivoHMD9DlvXjOvYCg
         JlcubDmdX/orK9l9TKEYbb4nyrDucdG9pBSrm2L6dbXyq1ma2kyvQQkmvENVVT6CAkc5
         KhSehz2wJOfVDlmyToBY+7jgd51EWdMLRCjrIepfQkcP0PC0k53E+HpSGip/s9O4hvFy
         wcklAToVv1gJfJqUObf4tWINGEJNNPJuSquQDRhXzdyiuxX46IOypJDqeVoNXB/2FiEa
         m4LnFGRNsJop71U62vyXcmKMorOac3delEH81VVq4CI3ef/oLeLqm8QFFHCLEw9tuyuQ
         o56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ymv3krvO+KBpzoJZenR2aK/VabbYECbdVnvgf1aHcp4=;
        b=G2WAr2VPxFoO8i88WXanaBUtoIGUeIOXp4IBbrr2OVpaYjbrf0SBN/ARM2WfzZbbK+
         AApT8Mq23B6DmK3XmmwfrdV4OaqP5A7gDfOmEMawaZyszfFJuPBJ+PTQyvtOha5JGhW3
         4oLrMQo/S7rvse3xyxp9Q/E92IEWrBTf1q+ND2klCmpO3DeNWxkqHomkw5WD7t1EzN83
         FoI04RVSndASyeU4aSW9UDsuOfVYrw/kafrs/kCeUWGMzaf+ljU3aPc9rUSmQztZsbEB
         gVRj6p1S84kh6/IFYy1LzsLD0z/G6pLAh4aB4ycw4dsQiqs9blcvbDPzmxuxloEJe9gb
         9/6g==
X-Gm-Message-State: AOAM533DN2XaUaQLnzLGYVT0dh7PfPil2r1AlHQFc2qiDI0JRxyhx7kI
        fGrLY28tK5DqpD56yGFDOEg=
X-Google-Smtp-Source: ABdhPJy6mj+25OiPaqECWMwQaAcnQa0HeeY9zWUnIXqxexhDEJr9SVCMK5+QNs3/9KPJ32r0hTgquQ==
X-Received: by 2002:a05:6e02:f0e:: with SMTP id x14mr6252204ilj.307.1604199138036;
        Sat, 31 Oct 2020 19:52:18 -0700 (PDT)
Received: from fedora-project ([2604:2000:ffc0:0:74b0:102f:8bef:7279])
        by smtp.gmail.com with ESMTPSA id r12sm7421416ilm.28.2020.10.31.19.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 19:52:17 -0700 (PDT)
Date:   Sat, 31 Oct 2020 22:52:15 -0400
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: resolve various warnings
Message-ID: <20201101025215.GA4828@fedora-project>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use template string as opposed to function name. Add a blank
line after declaration to improve readability. Replace symbolic
permissions with octal values. Use usleep_range for small msec
values due to the fact that msleep() less than 20ms may have
unexpected behavior/sleep longer. This patch removes all
checkpatch warnings.

- https://lkml.org/lkml/2016/8/2/1945
- Documentation/timers/timers-howto.rst

Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2d3f1f179a1e..22da59d8f471 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -555,7 +555,7 @@ static int qca_open(struct hci_uart *hu)
 	struct qca_serdev *qcadev;
 	struct qca_data *qca;
 
-	BT_DBG("hu %p qca_open", hu);
+	BT_DBG("hu %p %s", hu, __func__);
 
 	if (!hci_uart_has_flow_control(hu))
 		return -EOPNOTSUPP;
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
@@ -1215,6 +1215,7 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
 	if (IS_ERR(qca->rx_skb)) {
 		int err = PTR_ERR(qca->rx_skb);
+
 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
 		qca->rx_skb = NULL;
 		return err;
@@ -1302,7 +1303,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	if (qca_is_wcn399x(qca_soc_type(hu)))
-		msleep(10);
+		usleep_range(1000, 10000);
 	else
 		msleep(300);
 
@@ -1350,7 +1351,7 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	if (on)
 		msleep(100);
 	else
-		msleep(10);
+		usleep_range(1000, 10000);
 
 	return 0;
 }
-- 
2.28.0

