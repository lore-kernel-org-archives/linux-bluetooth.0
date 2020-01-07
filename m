Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA49C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126D6207E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXelxqWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgAGHlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:06 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33232 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGHlG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so5068102pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=EXelxqWKLyyV0gjmGRjKBqH15R+9xmJUBsYk19RO+1f277SnaZORQin1vPBAT0GdWj
         Ucu43OO7XsS76eQyQ1d9VEjTlD/90Lq2Xay/hiethOJ5xdhluovFESISakrnDqpg4d+w
         BmeEkB6kfXtLy7R1HiRpSHNIe4Wxmg2o8l+E+8Xn+BGxctIhWvaCOWiKxMc9EZeXrpGT
         7RDFfKg7KantLDEyWMN41U9HONMI8DkgE8gw9bWKUy/zB/7uRdLq4BhmAzzsaESly4Q9
         XTwlOU4uBdZDNvVFGP0TTN9CDmTkMC1/Rz9YmJdW8Oo1HtDamI6hUXSuvhyHDF8uqW92
         eiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGe4H6YZx4HGcWjUhBG9tFRR0Cqf/n0gDFJdojZvusY=;
        b=peWqEd8QNQtVLJcd9vhYoy3o9HY7hVdaPf0wnxesFVxx6IrjaIoHPR2aOihe6ERt7q
         sfHQKkijcyiul0IqYdK2aSLqMP+lKvUhU1hwYonfCEF9Ephg08abAZ1Vic2njmL85oUf
         0bfJ7stJeFJf6FRUyH8NMdC2ESRjQqkMUeC5o03gptwHOMcoOQFhudqvRwbriM3GZ8i0
         mmZlOPA/6561zPArQ7IUODGlTiRlElaiCNJzSCKDArlqjkVA37SbW7oBgFRr2WaQjbiL
         RvnPYSRciANGmlnWp2EiH9tMEbR3IkOW1XNWAn4r2hpeY4WDgBsGx88zeTcfW1YuaGeN
         +RSw==
X-Gm-Message-State: APjAAAXVVEQU8vnSUVoMFra77dKQND2MyuwY2+yWD9bCSQ2xLcY7VC9l
        2G/4F4xwrIqGf2+n/Q9FFiUGuEw8hnI=
X-Google-Smtp-Source: APXvYqxLDw7cf+zZqzdpxdsFXaI2Ab7+BxW8SZeN9LhQQ9A7izUknxGKuBEI38sQScDDGYBTdQw5nQ==
X-Received: by 2002:a17:90a:246c:: with SMTP id h99mr47985938pje.134.1578382865648;
        Mon, 06 Jan 2020 23:41:05 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Make use of __check_timeout on hci_sched_le
Date:   Mon,  6 Jan 2020 23:40:53 -0800
Message-Id: <20200107074056.25453-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
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

