Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59DC33CA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FA92072E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5bSwD/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgAKCW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44592 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgAKCW1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so1536757plb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=E5bSwD/zO1MqKP2pfv1cCP9rjCI9eJ7ABW/ndDSVgTjopRjRSNwJR2WRL38IsLr8Zl
         LA6NFY7rE7RqSK+AWM4vEm8BURYhH7DqH/+h0TIKCYwkS6UiaVrXe/JZ9urvFrmbznX9
         z0kz/+kYzfn5O0vVh/xB7NrM+GqGq2AumPvb/XJEanhM6GaqFHdsfz0o51sdjb3rySRp
         ID71NCNJnz7PvnZha1yKR0+/tWX2mW0A04I4D3uCRNxFNpUrXxel0s7E0zsQ+VTL17Pn
         PPEKQwbfRmvpfhl6NanqFIvfR9kPBOsLd7ev8nS1ygOmRPV7cogduc65M9j73+uY35eh
         bycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=USEOZUMQqgWaCONkki2m6ja/lnQELlZ8dmNbw/rH2cVzKbL/I+8tTqPu3qr/sJB1mV
         DwTCZSJ8C1LMX6QlGlOv04Tq8kRN6Uu7IDmt6lXlKNz4uYvYpq19nWdY1Ogshdz2kwUV
         EJXnqxXhml+EYDn3tjgaEBJJFvyVIlaVjMYjpmQYu0Gt6sokntZPnQ/ealkotOIU2xCd
         KOpGYRC/wvvEyT/H5r7c/pQ5w38taJOs66t+mid+R524Y6wqq748mi5mU1o45EYuI8Xj
         yzuGwJR9SbPQP1q3DKyl1CDplf9+wZPRQpTyX6dxndgNivLY8ZB34UM2pPzfOXVlEHqZ
         Mx5g==
X-Gm-Message-State: APjAAAUlB+tXvlx1sM2b2wKUwEfhRSfFRC2UK6IEhlydE9gezPkH3UEP
        E18ECMjbYI+s0mmJSLilOyfbj23pysc=
X-Google-Smtp-Source: APXvYqz6NvWwFaAFIZ1q224IJmaL1Jj9tdKD+NeL4h5i60WaIT3UnbNP/pLD60TsUicjcrHpGJZUww==
X-Received: by 2002:a17:90a:28a5:: with SMTP id f34mr8853975pjd.79.1578709346359;
        Fri, 10 Jan 2020 18:22:26 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/10] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Fri, 10 Jan 2020 18:22:13 -0800
Message-Id: <20200111022216.30842-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200111022216.30842-1-luiz.dentz@gmail.com>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
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

