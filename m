Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD10525361
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 02:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S+BfWsZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgFVCPD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgFVCPD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Jun 2020 22:15:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1504C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 19:15:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id x14so5091916uao.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2020 19:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GzbZawQfjVYUnnfeXeboiugUqURIYd0TcC8uvKgzJI=;
        b=S+BfWsZ2yVOvCcBv5chTEn6LbpDSHzTOoxqpKQw3FtjP/nf8uxagc9+xg7iiMPCG43
         I0gYnVgEV6i8lRQpLJExJS+Q+IhrrOCwL2SdAlA1PK/3eOg59DBUPzpVh26/9TMgbFsb
         Dshn4RLfiScbYIg01P5ilra4Vn770djlLT4vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GzbZawQfjVYUnnfeXeboiugUqURIYd0TcC8uvKgzJI=;
        b=Wmz8MPH7fxITSQcym8Iq4NPg+vNnXYd+wQ8itGp/s8JuSzNFUhW6gYL7ByFUUVG4ku
         lv2CTR/HDI9wjmOHE94cUgQTvYVYdN0DPB3P3bWOW6xNjsRtTaS66ye0n3CRdk5E3CXc
         O9LwU2cpke94KPR3To7RqYUpUXH3Bl5Qs6QjyyaqHZNjZjHKYm23F3RZsFcmypRBGDqO
         ZFRMBHoIoaGP7dvx5ApTQxKD5sgFVmY9blv+EBDIAy3RSqx54jd1epdFmFQiwugMOYjO
         PS0I3eKs0coSRv1xWoP0xMjR1S4MzK8Ok2EfismJSp4J2T6eSHKtIviYAhMk0wNEMa+R
         a5Yw==
X-Gm-Message-State: AOAM530uYYjl4/O/wyKRNuVSC0mC4/XVMGh1E+nuLiG77upqDje9z8h6
        A47TUH3dokRUflOiuu+/d86Q0kFNSA0=
X-Google-Smtp-Source: ABdhPJweAheB2IdermmNjoi1LRmh3E23du16MYwq46/3aUmmOJZaAu+Hq8mK5t9+OFPnagg1qSIJcA==
X-Received: by 2002:ab0:614a:: with SMTP id w10mr10099787uan.35.1592792101577;
        Sun, 21 Jun 2020 19:15:01 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 8sm1284658uat.0.2020.06.21.19.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 19:15:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH v2] Bluetooth: use configured params for ext adv
Date:   Mon, 22 Jun 2020 02:14:57 +0000
Message-Id: <20200622021457.156164-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the extended advertisement feature is enabled, a hardcoded min and
max interval of 0x8000 is used.  This patch fixes this issue by using
the configured min/max value.

This was validated by setting min/max in main.conf and making sure the
right setting is applied:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen
25                                          #93 [hci0] 10.953011
…
Min advertising interval: 181.250 msec (0x0122)
Max advertising interval: 181.250 msec (0x0122)
…

Signed-off-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>

---

Changes in v2:
-fix commit title and typo in description.
-Moved le24 convertion to  hci_cpu_to_le24

 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_request.c | 6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 16ab6ce87883..1f18f71363e9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2516,4 +2516,12 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_len(h)		((h) & 0x3fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
+/* le24 support */
+static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
+{
+	dst[0] = val & 0xff;
+	dst[1] = (val & 0xff00) >> 8;
+	dst[2] = (val & 0xff0000) >> 16;
+}
+
 #endif /* __HCI_H */
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 29decd7e8051..9301c1d54936 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1799,8 +1799,6 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	int err;
 	struct adv_info *adv_instance;
 	bool secondary_adv;
-	/* In ext adv set param interval is 3 octets */
-	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
 
 	if (instance > 0) {
 		adv_instance = hci_find_adv_instance(hdev, instance);
@@ -1833,8 +1831,8 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
-	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
+	hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
+	hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
 
-- 
2.27.0.111.gc72c7da667-goog

