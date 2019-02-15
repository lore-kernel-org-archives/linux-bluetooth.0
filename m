Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABFCC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1666F2192C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="SuvKb9wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBOM6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:58:36 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:41505 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBOM6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 07:58:35 -0500
Received: by mail-lj1-f178.google.com with SMTP id z25so456708ljk.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWEz7zSEjDlDSjv3V+jQRviXlljEQFErgD0ODNT+dZA=;
        b=SuvKb9wlTzYwAXys47M24KA2uLlydDrdaH2wh4jrXDUfdN4WOBJtxIo2B4VsWsmjO4
         tOt1hscXdNN95kzV0YaOiaDn05cS8bljpI508tf0ESsef/NObc/N3yZKqci8BIIh5RDf
         0YpNleaQF6O6+GZ1IdPXzaL14JyFufEaIsn2X7Sm68lzoG8SaLS5UIJY1ZsOELKCEjQu
         QoVHquZSrusSIw5QnJe7SEYg9gnXEKf0f9q6IhToYwds7C3KUxEWTXnENt2lVi08RTkm
         +J+C6buULy4NDUdnyiFtf5nn+2YdzLm/3gGPZ7r13WSAb73F/RDW8uSrM13X9yvWIjBN
         I+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWEz7zSEjDlDSjv3V+jQRviXlljEQFErgD0ODNT+dZA=;
        b=kSCF6aq9plHIyrrqgHdJ8FVc6sAnJZ7WUHro4TNjGeLSsaWZjWfJISYYaCYXxcXeNU
         42gbfTBLCJj/1wptKk4aCWoGANsn5Xqln5hsiVv6MJ3PJ7ot38wjvuVnOcnZ3/XVSMsJ
         t8Dcvo4o8wAjXNUfoA65rERbVuHRNYg0Iuyn67YpXvXXX7nTw+/k1vuWYnuDfA6ksikY
         sdmUesb5V2ZMiHhk/cTGhEMW39OO9bW1NBX26hKSMwlCxt5b0dkzvbX0nevbblH/Xz+l
         Wxjckf8mrgnOxc/n9DRoSBgKYdi9UZTjYNhy+t4iSHutJcn3G6KIx8Vjl29qcp0jgH/z
         TuDg==
X-Gm-Message-State: AHQUAuYQ16JVqFm4zZ/76axO/PJVRA/DthyAa2lEFl+JcdLs0Tqht9AB
        1TdIlKBl4xHv6RF9KNWmRw9rSsxJf84=
X-Google-Smtp-Source: AHgI3IZ+CEU1b+X3b/dgfPYcm64DgDlf8trbH7rybri5tbZYbsHqlwwH6D9ChxpYefyCwI7fMUmYUw==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr5979551lji.121.1550235513240;
        Fri, 15 Feb 2019 04:58:33 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id s21-v6sm1239854lji.49.2019.02.15.04.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 04:58:32 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Fix LE Read Transmit Power Command deconding
Date:   Fri, 15 Feb 2019 13:58:28 +0100
Message-Id: <20190215125828.20410-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Min and max TX power are signed intergers.
---
 monitor/bt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index ec62864d6..1fbb40efc 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2359,8 +2359,8 @@ struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
 #define BT_HCI_CMD_LE_READ_TX_POWER		0x204b
 struct bt_hci_rsp_le_read_tx_power {
 	uint8_t  status;
-	uint8_t  min_tx_power;
-	uint8_t  max_tx_power;
+	int8_t  min_tx_power;
+	int8_t  max_tx_power;
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_LE_READ_RF_PATH_COMPENSATION		0x204c
-- 
2.20.1

