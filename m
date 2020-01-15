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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D9C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6592222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXyFonMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAOB73 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38164 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAOB73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so6090029plj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=GXyFonMmahvD/LSe5vjI8dRGZE21MexfKis0hdwXHjueRMGAJt40KFf4kHPnTy9WTH
         2vazSKRFyQ7ET3rOISNNN3AtkDGjsQDljB2h65Kc1UoInl6blwe7Wi0k55iDHP3Yinxm
         mslRzN8CbOZ4/JvbFPHwDYDz/rySBahR/KO86ziLC6RwBvqmgEBgEwcmxJYCJxzPXexL
         o+uBnP4/kOS9HLLl0g5xwHkf9cIk5J9hnkw5/BoImWjPtY94jXItIbyBeriQrxhZCx0R
         AX7909mLDuCNPN8Jzmqc2GqAWvYHAfnoMPMULW7185rHLWJb4tsvtzPMhJG/Z+kgbepz
         hhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=YusI/HrwDZd3nVQJLlOxEpmXCt16vNknofgPYXBdcbdRfC1hVKfz64zqOKze2k+Guk
         c3cgq0JCto592udQPqiulswCxlVz1uLPkVjHqc5UtZXgu8PuMPGLYyageAhQXDtXaU2r
         NnE4GqhHzxJSmqNhueogQkEQd3q7xydInGseJmxZmVhzo3HyRNujDpH1Ml5f/9VRxyPW
         1JGXXo+5l+LHKm98DDhX+W3wEPyRra4XfrYwWEtYrnsSBSPuJVaIvmlKjbpMq+jg0xcx
         wwllTPZ36HI9Cow3cEplF9HTuE/Lr2DIFiRkdVYwyckOneW0+QbUT/UhBncir5xg+k6m
         KAMg==
X-Gm-Message-State: APjAAAUczlq0UVqSNZQ7mSYHTY05irqyO/BBHT/63L3f2qWNRyiZE92p
        bRwhK1qVtP5c08xm9YvfFoFS6wcaSgg=
X-Google-Smtp-Source: APXvYqzjnDWiBah1AWncnXNqtMRm7MLQ1RSXGN6QMrhPi8cM8157Xi0LSiBeP0vOWB5uhHwpB3MXpw==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr4969219pll.238.1579053567933;
        Tue, 14 Jan 2020 17:59:27 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Tue, 14 Jan 2020 17:59:17 -0800
Message-Id: <20200115015918.1187-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115015918.1187-1-luiz.dentz@gmail.com>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
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

