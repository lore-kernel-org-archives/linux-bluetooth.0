Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5005C0007A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 20:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B008221F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgLCUNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgLCUNz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 15:13:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F7C061A52
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 12:13:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so4152591ybi.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 12:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=geIMsFFIZqSd0430J3+wSzkbtqIXHs999irC0Bk3sH0=;
        b=drdVxg6V3PWFqMZH0gBZaY73nM9QnVIXBMS3Bv+xAb1RUY2e3SQPxl1vcVaC9h3fny
         C4PHIJmZMIRHSbZVYcMTnkNa+jkoPAamKCWyuGVbtJKr09TomeWAKI6jHrEmWVZhEclg
         IDg0GrWJHGZX5ciL00UX3xzP9Ila+ArBfbAB7XKQwYIAb3Btv/3A3EMQJuZoFPrZuQiD
         btuCUVCj+4o86/fv+Jmkar84+RR2JOSrDnQzxw7mKI6QUHEfDZMTtaecgpz5XTrXNZRI
         gncYaTE4BPEUGh/014afrnvBkkEsDWhyTK4O8HZShNEYGslHWz2LPMS/yj7RQeetlOl7
         kNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=geIMsFFIZqSd0430J3+wSzkbtqIXHs999irC0Bk3sH0=;
        b=SkheNr5sT7VykY6kQwV+XVgkD3QV+n9OSRXDPGvVKaeSVgE/R1lwU/W1vvLf7UAJze
         5Nh/jgfROGxrrABA82lpxZs9m5DZffgGiuEsx2GWF8sOvlnSlFhOYFOJtI2GlhKUbx78
         wpxGd1LMot81HtVXffxvcUvqAJ5wHdNyxScCClzW0Wnlb6QOY0Ja0OXnNcF5Zq4fbEqw
         PRhct/MQZJFZ2IKDFHz7hBIZq2P2Df1keYQFSV59EtSZcRoKlwjqJo8rz7kFh1AEEJg9
         B5NeZZTt3IKuZbdDaVb7AIGiYxnnXlmkU7FvT/SGl/fIURClKmFyF4QXC2b34S4plN4m
         uBwQ==
X-Gm-Message-State: AOAM531QB4wnLE9mvg//9/EMWE6Aajqu1F9fmWRGLCEq8LbB61Q1IWdB
        M//KJH3oCdXTZUDVB0SBqrGukhR5tL3ZFxMO0Zuc
X-Google-Smtp-Source: ABdhPJw4dk1Tp6nvpXSQ/sACE2Vgo6lEhHqReyH7jlvIwkl4NYv5N/qaJrl/gE4mooleU8oBLJW+PyJo38moqdZ7r20V
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:f623:: with SMTP id
 t35mr1165855ybd.399.1607026387866; Thu, 03 Dec 2020 12:13:07 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:12:48 -0800
In-Reply-To: <20201203201252.807616-1-danielwinkler@google.com>
Message-Id: <20201203121154.v7.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20201203201252.807616-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v7 1/5] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 63c6d656564a19..4bf0b6a04aea8c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1302,6 +1302,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
 			 u16 timeout, u16 duration);
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8cfcf43eb08fd3..46ec523d96a76c 100644
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
2.29.2.576.ga3fc446d84-goog

