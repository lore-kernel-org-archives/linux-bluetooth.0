Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5847CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338B920720
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 15:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLs/igHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGFPoz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgGFPoz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 11:44:55 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E9C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 08:44:55 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u133so7293936vsc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTsBX04mEBGPv1WhXNBZwuT674fIoWLWZXtYZxokmDc=;
        b=LLs/igHinh+dfXo+MuLreYu8kx5tg3sVAiKujXkBRBuXFNG3bH41P14GE0iHOChPOI
         dTs1hJmnX4fWkikstAP+3+MlHBnQAnIV3gk+heS7UNJarE7CRJPHs9s76E4J77EgVkbr
         EVwGetEzTac3qG98ai9nCJluDiejllkXYs2zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTsBX04mEBGPv1WhXNBZwuT674fIoWLWZXtYZxokmDc=;
        b=lta63LFwA5MsCITeHHgpMz9qcVQaUbQzoajDTTcIjcgY358swGhQzOZgv8ihj1xmc9
         inUi1GXiPLiSNkDSgOkGPKXcQWP85J0iHzqem3JyOV4bGfg3v38aA8Yxuh6cOl/cAET/
         4qiDd2DVSkksEVckx4C5eKEOC0H9uEPG5SzZ8vqlSvsFQy9Ey1BAYLmKjAmn2pgj3yht
         CimEOeWuBsNuhzezivUAwSNwjUexWf466Zdoqfb/yzufLiANXAWt1BD9jbub0xvhpcbi
         z157+Y0K9n/ebatbpkKgqQYoZlsR9X1JZMTE4zaT17dLl4NgRIHCDGKjyT5iW4iVaIku
         X6AQ==
X-Gm-Message-State: AOAM533DibNDCX2gzfXlrckKNnUOszmpqaw0APiuNRKZ0eHGo+YeK88E
        H38rOSNcwRT23ctBjTIbWuyujgESkzE=
X-Google-Smtp-Source: ABdhPJxvrSkD9HjYRPDV6v3iOXVyHkiBHpdgnbz4DquN3b+dwDJkiEXXT8m9wjaZ0ZoVvLOWtdbtFg==
X-Received: by 2002:a05:6102:21b4:: with SMTP id i20mr37484539vsb.164.1594050294287;
        Mon, 06 Jul 2020 08:44:54 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id o15sm4437576vsa.20.2020.07.06.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 08:44:53 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3] Bluetooth: le_simult_central_peripheral experimental feature
Date:   Mon,  6 Jul 2020 15:44:49 +0000
Message-Id: <20200706154449.3828193-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds an le_simult_central_peripheral features which allows a
clients to determine if the controller is able to support peripheral and
central connections separately and at the same time.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3:
 - Back to the original design of V1 and integrated Marcel's feedback.

Changes in v2:
 - Slight change of design based on offline feedback

 net/bluetooth/mgmt.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9b9728eeac..b34e6f3c07ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const u8 le_simult_central_peripheral[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[42];
+	char buf[44];
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
+	u32 flags;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -3766,7 +3773,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	if (!hdev) {
-		u32 flags = bt_dbg_get() ? BIT(0) : 0;
+		flags = bt_dbg_get() ? BIT(0) : 0;
 
 		memcpy(rp->features[idx].uuid, debug_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
@@ -3774,6 +3781,19 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	flags = 0;
+	memcpy(rp->features[idx].uuid, le_simult_central_peripheral,
+	       sizeof(le_simult_central_peripheral));
+
+	if (hdev && test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+	    (hdev->le_states[4] & 0x08) &&	/* Central */
+	    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
+	    (hdev->le_states[3] & 0x10)		/* Simultaneous */)
+		flags |= BIT(0);
+
+	rp->features[idx].flags = cpu_to_le32(flags);
+	idx++;
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
-- 
2.27.0.212.ge8ba1cc988-goog

