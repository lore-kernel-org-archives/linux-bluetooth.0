Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E36C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09CB2147C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="HGCLw7ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBTKOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:14:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37550 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfBTKOz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 05:14:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id z15so863399lff.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Feb 2019 02:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8yWBVeqG5fQZd4aLRhI+N8mvPnQMTiX5y0RXn8k+PI=;
        b=HGCLw7kuBUOvMxtxYnsuDJNSykPxnb6Lmu2h0KBZ1RPjiuFET9c5gulimdKvYNyqUw
         nwk1n/omskw4WZ7zVvWEAcJ0ImRR359i18z7gUgxFpm82ujXItK9+Vbj0uPkfSjtE7u1
         k8PanTFxdPQdLI0y5kUdWzbBuPTBg/nF6z3mgX9LabpWVL2B3b0FfJqy2RlWENweVieO
         2ar1vyJO4EuPHktFHFN4Qd6tCLH86xm8K7nDrNk1aect0lNE+2CnCgY1U1THWSJtNYeg
         5IKOnoXUNJWVYmM6M+cUt2tz8lDyRDHmSMbzlHM5gcoggetVT5jD22g6vYFbjb99Wd0I
         Tp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8yWBVeqG5fQZd4aLRhI+N8mvPnQMTiX5y0RXn8k+PI=;
        b=pWhXx0D3TZsJxnazze1p5WlwlqEYCTAkdsR1i6D4eBvCXSRV92KvPFU2YLv2g4JD2s
         Sx0KkZSRPdUySRPofwJKdcgHmgbeDzk6Pm2FR+h+efyuDrPIZ3reqMlBxvfgTm65Tzw+
         k8thyc1bN6iaapbnK/t3B2DYJ9KKeR3xE7imExU/OIobsZLIkzybrdGgwxatt5YYVztr
         aJUhlWIFABas3c5uZBOnx/yDpRAVqoVeOCiYcq0DdMXsG8HbDoZgCjORV/7XzhrhUoFB
         TIpCdiyOPV0hD1c042MgDFtllMkAkt1ChLtZnjeZ2CR3liNxzN8g49j+5syz7G9iMWxj
         EMXQ==
X-Gm-Message-State: AHQUAuadygq+m/f7OyA5PW5EZpUst+LWG3tN/QAMbse6int8sxzfe9nO
        pgWDVInPIQVbOkeeaQsxnGR1QzKmWjI=
X-Google-Smtp-Source: AHgI3IYMtaxhL8kgYRmYfpljJwQcOl8CfCWBvdmR62G+utnz68wxBA+nHztFy3zMPoDtBLYmGBNdfQ==
X-Received: by 2002:a19:911c:: with SMTP id t28mr20399535lfd.78.1550657692607;
        Wed, 20 Feb 2019 02:14:52 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id x19sm3856218lfe.42.2019.02.20.02.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 02:14:51 -0800 (PST)
From:   Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 4/5] Bluetooth: Fix set advertising while connected
Date:   Wed, 20 Feb 2019 11:14:27 +0100
Message-Id: <20190220101428.3086-4-andrzej.kaczmarek@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
References: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

__hci_req_enable_advertising() will check if advertising is allowed
while connected by checking states supported by controller so there is
no need to disallow this "by default" on all controller.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
---
 net/bluetooth/mgmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954f8146..d44681c99341 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4334,7 +4334,6 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev) ||
 	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
-	    hci_conn_num(hdev, LE_LINK) > 0 ||
 	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
 		bool changed;
-- 
2.20.1

