Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1234EC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BE3207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjIgM4Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgAOVCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45705 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so9074906pfg.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=EjIgM4TbOgYpc8/i6CdSwCLbGyV+G5/pGCLD7yUBBmtrBykviI4b0AMrvuQm716CNr
         kgU2J0jDNw9eEle74+ewMHAm+/Nh6mWQxJKJPJOeNANrgvNBX1oQ4C293Jknn537tamJ
         tWg7kstxXrjZXM0UYhx74MA9EMohORFjVWxwpSYdut0bwaCciRiNm4iHctbR8VR8knHq
         LmZKLpxyf8j30H9X/aeNkBBDj0WLgeJkIYZrKA/adVmoZV+6sEmpXcz2vvmEtig3pM9g
         tG1xS5B+ru86MakoFBH3XkDjCuuoQ36R3CBYJvuyYPCtvZG6q9bxEPzT6bXrBmr4GcK+
         J+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=fbScl6/dPhnTaX6htU4EIztKycz6Xuh0/EJTzUxIuMIyVV+2fLtHD6D54HLu7KgCXf
         9YHGZvHrtFT3O2bk1yo3YfhAbVHgfuEI0JtnCS7g4b+9YS1yuYgBNN1ZYmNkqtB4CFGN
         ydMUiytjjjkl92tad2FEsqnu6utE4pDR0mFNXldXbNPaRNE1Gj8R40lGDtATZ+SRJxW4
         gUZFrY61V4gTDy5k+0ZOayN263wTQQ5d1GXZkQX+mEoHacjXrNF1Uv17jaNFOdragOWt
         z2ua+c2vwcBoc9ug7sy+8AKWHY9jvSSxOetQe2/xyNkFXlkQaOabjtsrpioRcIporU/P
         E7ig==
X-Gm-Message-State: APjAAAVw2gzwUK89ejCdNDqTdtZ0UsfLcK49Zhp5/o0ir5rOSYmZTpRN
        mXE/e6UhqzviCog2DwJmQAEJLKjuwus=
X-Google-Smtp-Source: APXvYqyxsHwdVcE/xlVfNAZCG6c+QMtTZ1WPXusIBH0wAoM7QsBmxkth+f1fBZfSv+1VrHTFUojPyQ==
X-Received: by 2002:aa7:8a8e:: with SMTP id a14mr33531256pfc.217.1579122152618;
        Wed, 15 Jan 2020 13:02:32 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 08/11] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Wed, 15 Jan 2020 13:02:18 -0800
Message-Id: <20200115210221.13096-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reuse __check_timeout on hci_sched_le following the same logic
used hci_sched_acl.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc78fcc3672c..2fc367f30b6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4298,15 +4298,10 @@ static void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
-		/* LE tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->le_cnt && hdev->le_pkts &&
-		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
-			hci_link_tx_to(hdev, LE_LINK);
-	}
-
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+
+	__check_timeout(hdev, cnt);
+
 	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
-- 
2.21.0

