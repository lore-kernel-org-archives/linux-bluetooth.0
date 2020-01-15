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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2077CC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9B82187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc6Vgqvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAOGgr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37787 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgAOGgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:47 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so7230549pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f30rZKlrtkh1hEkV+gg94QkLJeCf3terA+mqfksfe9Q=;
        b=nc6VgqvsIHhbs5zzpBPPudMkHswh1OhoyDCwlXn/wQ5N26cFveQseQMWNrTyBgftTX
         vaV/S3FXlXCWC8af7kQCznw9vI7ELCiveXl3OO6LukPiFWIvb4erftUMccUC+chl5Dd+
         gnGiWRzxncYYlLIvZkeaA//tJ+7pHHK/8C6KFN9+h1Sdf4Ib9Y9frKiHOe8z//M4U5DN
         QczxEqdVU912Ee255iHvbp0lDD4k/7w8/Hzl3RStHBTS0tH1XrDtJvC0fBL1w25eqZGl
         VQuJcsckPjx7z0tkrk72jX6BRrRe6/rjaBLR4Kx30Y9zTUg/48E2+0KI5NGc1exoi028
         tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f30rZKlrtkh1hEkV+gg94QkLJeCf3terA+mqfksfe9Q=;
        b=BkRqA+ft17+69U/T12AlBaoTsvKtFvQ3gRMko+XZxuSug70no9Vc2Bs9RUR/Spx+No
         MoqYJTq7pAPq4e7YSyXRQv1VFXvtnCECIxn4gqhG+6trM9I38qHx8mv/eJjGLuTVD3pk
         YhvLnSb6LTd2Uoczrq77lppflJUjuYg+M2qA5ebRFzlHWKcYjYUQq/8WeaoZKHhIzsv4
         l9D91mbZb7P8nWEXmKtnG3p4cfB21RDTL1P6vJOxG0D3Fws4VDTn7ZKRAohq9sIKpet6
         FwRHdisfO4tVLj+ZekSAuuRoJ9GA8KJDDQ0fOpWCAoHMTyos3X1mf2iIvmexRh5SrAye
         OlkQ==
X-Gm-Message-State: APjAAAVoUCvFaa0ghUtpqIMFJRtma7ehcvX8Oj0htwLBtFbRgMMN5BlA
        NA5rYeKpDtm+KMraodUtiSMKgsAAQdE=
X-Google-Smtp-Source: APXvYqyCK9Ugi5JMeEr+ErLIRICnnbble+qKWnDQegpQ6s17jyV2cSBtJNfkjCWwqCKwyfYYP+3fQw==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr33958967pjb.44.1579070206290;
        Tue, 14 Jan 2020 22:36:46 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 11/11] Bluetooth: btsdio: Check for valid packet type
Date:   Tue, 14 Jan 2020 22:36:33 -0800
Message-Id: <20200115063633.32441-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check for valid packet type before calling hci_recv_frame which is
inline with what other drivers are doing.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btsdio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index fd9571d5fdac..b35d70073546 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -145,11 +145,20 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	data->hdev->stat.byte_rx += len;
 
-	hci_skb_pkt_type(skb) = hdr[3];
-
-	err = hci_recv_frame(data->hdev, skb);
-	if (err < 0)
-		return err;
+	switch (hdr[3]) {
+	case HCI_EVENT_PKT:
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
+		hci_skb_pkt_type(skb) = hdr[3];
+		err = hci_recv_frame(data->hdev, skb);
+		if (err < 0)
+			return err;
+		}
+	default:
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	sdio_writeb(data->func, 0x00, REG_PC_RRT, NULL);
 
-- 
2.21.0

