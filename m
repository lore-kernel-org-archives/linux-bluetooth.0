Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C58C64E7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A101C208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAk7zpej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbgKXSIV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404220AbgKXSHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 13:07:53 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98761C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:07:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o1so16793140qtp.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ugBjHs8qLQMChRHRG7+A3K4v2J2RLx38B7emQOjbJo8=;
        b=kAk7zpejlXea9eHTXlou0iTVDqjH1/CCr1DU06i0EEuuCGqlb4qgAtTzGo/amDke1c
         raRfU4kKXPcIgwinghEc1v0zIdEW1dgH4O2S8op6//kEJuVy+PVfcrQ0PxStQv3HilaM
         U7DmacelpbBpbexeeIsE2R53F3AIQEw9s7H6jkyMv8pcJaM80oflSGLweRdIMgwo/LNM
         gPiwVGMFWGK0n5fG2qlfJqmK4K33uSXRq3H5ihCyKlPmo4eNBY93XAPc5txrzT1DPSVe
         wJgYkgehdRHPjrubjyzWBLzWW6CMg/P1jep/2Dq/sNf1KFhbwkat9UZ4AoTyhvP5D/Lv
         WPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ugBjHs8qLQMChRHRG7+A3K4v2J2RLx38B7emQOjbJo8=;
        b=V6dg890lhm2DEjDeJhrCG9SyIAz8uiuUqcwKFjs1usY0nXzwt5i2AHtrdGwdYNkt1C
         ZW+6M4NIJHkYm64kUFQtBWiSVZ0EKLNwwIEkew7J1CtO8247LTLm2mk46+fflpxtjeSj
         /9inBbt+wkm83FxGO3/kNTi6B6eI5QWUapJYF1STXVv/xM2F2LDBXgovSIm4Td3rjF14
         HC1GdosoF/bhmZyW5LLhMZr1Gn1Asvw7kzw/X8nIV82xEVAZEPIgRLr+MCeYVLD0xsX8
         V2X4F+ZkOFhf0G/IbOcXf41XSPPI0LCh4q354yTUH4SDJ3pCGtA/ET6yoPpTDIO0ghsj
         +jLw==
X-Gm-Message-State: AOAM5322zfVANz6HAxO+8geG7pRMZp1G4rPqksUUR5vfNuwCEqYMXUhk
        hmFNGWzFkWmhf2Q0mUEvymjJdWZCNzHvxSqHtUiC
X-Google-Smtp-Source: ABdhPJzD0QDXO0+1CEVK+AXfBOJH93TC7KtgOs4WwMcRM7CKWmyYYLEYoUW/+g9V/oxHG9m3IY8Qx+nz73idpqmEk7L0
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:7711:: with SMTP id
 s17mr9337263ybc.240.1606241272796; Tue, 24 Nov 2020 10:07:52 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:07:42 -0800
In-Reply-To: <20201124180746.1773091-1-danielwinkler@google.com>
Message-Id: <20201124100610.v5.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20201124180746.1773091-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 1/5] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We wish to handle advertising data separately from advertising
parameters in our new MGMT requests. This change adds a helper that
allows the advertising data and scan response to be updated for an
existing advertising instance.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd163b..300b3572d479e1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1291,6 +1291,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
 			 u16 timeout, u16 duration);
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 502552d6e9aff3..35afb63514f38b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3005,6 +3005,37 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	return 0;
 }
 
+/* This function requires the caller holds hdev->lock */
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			      u16 adv_data_len, u8 *adv_data,
+			      u16 scan_rsp_len, u8 *scan_rsp_data)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+
+	/* If advertisement doesn't exist, we can't modify its data */
+	if (!adv_instance)
+		return -ENOENT;
+
+	if (adv_data_len) {
+		memset(adv_instance->adv_data, 0,
+		       sizeof(adv_instance->adv_data));
+		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
+		adv_instance->adv_data_len = adv_data_len;
+	}
+
+	if (scan_rsp_len) {
+		memset(adv_instance->scan_rsp_data, 0,
+		       sizeof(adv_instance->scan_rsp_data));
+		memcpy(adv_instance->scan_rsp_data,
+		       scan_rsp_data, scan_rsp_len);
+		adv_instance->scan_rsp_len = scan_rsp_len;
+	}
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_adv_monitors_clear(struct hci_dev *hdev)
 {
-- 
2.29.2.454.gaff20da3a2-goog

