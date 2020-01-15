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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81DC33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345482467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX8wJFAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAOGff (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAOGff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so8005279pff.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=WX8wJFAtanMOzH2ttrbsBPe80zn2y4ZE6Q0H+0+wgOm4X/U/hQVEt+6knbvy2JD19O
         UREQ6VEUWcjtlOfgsDOptqPZt1st0zvZ7zAQQLfOYfblQ2fefcIdDemAbc2BsdZB3izh
         PakKmcS7Q3vXPGVEZ3UpQ4BWG1QwG0FbryGNZcKdls2sSwRrbSCqZymQ19SqU5trEHYD
         Yqaxjy9e0eA1Cl3NuvpjCxbAexJOHYISfeJbjxlFfBekcxrYlJr67pI4ixejWvdGGk0u
         Edir7qEEbYeVjAwHBZvVi/15luzcBgTzUloh0SF/RkcT4FbXswG3aHjNznGMZJZC4wL5
         MTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=nQ3eLhh077TY+//9nilQESwmrXNSRR2nOjBqEm6+JWn6Ciak6B6s3NmhGqGe04U4zs
         8b3fzJRIOnoTatuQAsgSFCOiIsl8Z7uSJj8VuA9XEu/HhbF8XwZKLfilxoaM9lYCkRPz
         6pKLtx0NRye7hibygnca8jd+1KB3E36CYFLKXAg8F06r2q0kpYU2yRqLE75sohy8gUGo
         RvIdfPrhvm2qiKp1DSqME9lU8FWcqMNWd9YwwRTmBstUWWUIhT1s6HQeXCzvlBpmGHdo
         AJX3W+7lGp8Lya0h5C7MRBQFX6+XeqsG/lHVlhqOL740HtLGbRSEtDEAmJeChNsJxsfr
         +6DA==
X-Gm-Message-State: APjAAAW0tpGpuhWmqoQffUJo61q/S0qNKc+EpyGRzYN/f7HhJP8Lx5kH
        agH0d+is5hlQ3DAIwO8PkcKZMPoNNXw=
X-Google-Smtp-Source: APXvYqzUAzY1VO7+Kc7GMjQ4vu/sYBf3+BYUaLfrmaf1/bc7s/So39DcVGU1aU4DDYzIT/VyZEkxlw==
X-Received: by 2002:aa7:9729:: with SMTP id k9mr30032547pfg.72.1579070134689;
        Tue, 14 Jan 2020 22:35:34 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Tue, 14 Jan 2020 22:35:17 -0800
Message-Id: <20200115063523.32127-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
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

