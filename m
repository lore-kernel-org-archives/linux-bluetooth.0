Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25768C00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80C5222BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVGCdZEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKBTMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTMi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:38 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B0C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:38 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x23so7319683plr.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y5r28XmAxF0NNbIcT2BD4Vqev34gsw4BOZU4JB5iY+o=;
        b=ZVGCdZENno/uNUOa5iU8Tx5ComRRtvsWg5Pr990rirb5T2n9pRgYu5LOk7hE6g4NTS
         3HfnAIHsTfFQ6B2PpXHAb3djDYpEn1UX/xWaZD4fNFfS8MkGu65UskLoSKOB/tO2NMlt
         1UelIIpYJNvf0UNQcQXUl1CS8SN2rV+AYzSDCBOV87UzC5jN2lvcidD0iRuAn5j3F1Ej
         sLL/KIYYctqKUitf3dEQQqU7nk2xJmc6eA75c48Dec542/zidFza5lQQy5/3FkBBFGLk
         o8t/obBjWBi/XROLnL/THbmkqbccElme5RbR4CUx1g590ppuB6Ek9PnMyb2jUzs39E/r
         mVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5r28XmAxF0NNbIcT2BD4Vqev34gsw4BOZU4JB5iY+o=;
        b=jMX0u8KL5GITh22QmKijqOnssv/8Nfd0i3gwgh/azudVceenEPchMwXxpOAbVuyr1S
         Q023DZFrhpYq22rCIjjLiKXI3j2qjN2YI+JG2wrYjTqFCEUcByK5/oQJh5Lc3bCbpTIb
         KvjqYgSUCq17+HWgTIFw6dbfLPZwUokeSPuNohqzD7BPY1mYJ2HA+YtDYmqyRz7IgZBY
         NYwbOdDLDSO++buoafZ51DiQGUMNuGevhncZZCvIR5OfRmBADbIVkdGr70jMESTpLOKj
         j2nnMqdyDOyZn65dyuWJW2mj5EyLxA1Zg2vet1gIZEstgTrLS/u1KcWLG8ztzDw8V5hZ
         m9TQ==
X-Gm-Message-State: AOAM532QSJIZozGu5UWfOg4m3u9p9eFwHFLgKJ8XT96amXaHd72T6x8/
        BBurpU3hHyikcLCGx34XjXSjD8T5XHP5Bg==
X-Google-Smtp-Source: ABdhPJzTQapwz61h0mQsqZ20w783VMN1baMIrsxmz2Bw6q93/7xzKyWHG8vgiFtMSaYiXEHy5wHYhQ==
X-Received: by 2002:a17:902:9a89:b029:d6:c37c:7c69 with SMTP id w9-20020a1709029a89b02900d6c37c7c69mr9012957plp.11.1604344358070;
        Mon, 02 Nov 2020 11:12:38 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/11] emulator: Fix not gerating proper advertisement
Date:   Mon,  2 Nov 2020 11:12:25 -0800
Message-Id: <20201102191232.1848737-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When a btdev instance advertise using the legacy command and the other
instance uses the extended version to scan the report type are not
actually setting the legacy PDU properly.
---
 emulator/btdev.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c89815b3e..42276a2ce 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2154,6 +2154,29 @@ static uint8_t get_ext_adv_type(uint8_t ext_adv_type)
 	return ext_adv_type;
 }
 
+static uint16_t ext_legacy_adv_type(uint8_t type)
+{
+	switch (type) {
+	case 0x00:
+		/* Connectable undirected - ADV_IND" */
+		return 0x0013;
+	case 0x01:
+		/* Connectable directed - ADV_DIRECT_IND */
+		return 0x0015;
+	case 0x02:
+		/* Scannable undirected - ADV_SCAN_IND */
+		return 0x0012;
+	case 0x03:
+		/* Non connectable undirected - ADV_NONCONN_IND */
+		return 0x0010;
+	case 0x04:
+		/* Scan response - SCAN_RSP */
+		return 0x0012;
+	}
+
+	return 0x0000;
+}
+
 static void le_set_adv_enable_complete(struct btdev *btdev)
 {
 	uint8_t report_type;
@@ -3413,6 +3436,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 		lsap = data;
 		btdev->le_adv_type = lsap->type;
+		/* Use Legacy PDU if the remote is using EXT Scan */
+		btdev->le_ext_adv_type = ext_legacy_adv_type(lsap->type);
 		btdev->le_adv_own_addr = lsap->own_addr_type;
 		btdev->le_adv_direct_addr_type = lsap->direct_addr_type;
 		memcpy(btdev->le_adv_direct_addr, lsap->direct_addr, 6);
-- 
2.26.2

