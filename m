Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24BC47420
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 00:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538512371F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 00:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRNSN2v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIYAk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 20:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgIYAkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 20:40:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C5CC0613D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 17:40:23 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so843426qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z8efH0VT0gu9mhE3Qe4fVs6J3IFKx4DbBtzU2cWSOyc=;
        b=RRNSN2v/SyaYP2fZsZh2mG7mDOWv4UWpwlF4ah5Ah7pxNRp4gjq5SRIjmzOqEvtuNg
         o2sZIvQXtBPsbhmZxlSWBHeRJtBCSS/DQpLgpUmZKrrP9dyXTU0506LL192MiSvzY4l2
         P55P5nHR+wxjI1Gs0ydUIf0fyYUrBmK8XHfyFu/oVSqqsdXZLjYLyGdtBus6B1Plui3C
         CSJdObmJswm4v5Y8kYvKlCq08vWHXbwA4lohzsyPJ5WcMX8mnTYWlvKJlxpb0vkoSfEY
         6ovwP5H3ioE2gnIgIBVtS4T5+9afRYesMgJ5C5MXE8gLn+NyaeMfENu8SJHiHwrYMxdj
         4idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z8efH0VT0gu9mhE3Qe4fVs6J3IFKx4DbBtzU2cWSOyc=;
        b=GtTeRdOC85diAYNq8AKw6DdtfUGqZSob0EfSxTaOZXMZ2X8v+BXrfjjKtu+u57gYYQ
         hPRq0iNLVkZHndDQU3DOXkYqJArN3zB9PG809M2Gp/QcjQkRvn7L6L8VElH9kcnwFZql
         ZVGIBZ6IaBu+KyLI7DPheYTTVfmkT7pBcB8Li+UPWdNgHScizWjXWjd1JzpRQmt1nPBn
         ev7Vwg96swp7VXr4X/MBBcN1TrDNpQP0HtSxXiqLKk2eYtNK+kZufDL5d5Hs6sOtxpIW
         F6r/ZRBskej7gDV9zkFYqPGs9N0C1SJI8BgWzxCEIwXaHKRN4AfFqHdrziXtO/10Sahi
         xcmQ==
X-Gm-Message-State: AOAM5302InPyoZCgwsmaIYZItR37nI7YttExpvmWqmXg5FMLueXtOiCZ
        4rYKEXKR1HF7FD69cRa6eAN13URG4vaJ5N+KMlbn
X-Google-Smtp-Source: ABdhPJyV/rAxfDsY0L/wJmbvjNXMni1QAb7QYZR3zx5lVh17Q9z49dofhpNr8cuz5voKcmUTwrMX5BPRRI2y94zqSYmw
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:4f30:: with SMTP id
 fc16mr1922865qvb.6.1600994422858; Thu, 24 Sep 2020 17:40:22 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:40:03 -0700
In-Reply-To: <20200925004007.2378410-1-danielwinkler@google.com>
Message-Id: <20200924173752.v3.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20200925004007.2378410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v3 1/5] Bluetooth: Add helper to set adv data
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
index 8a2645a8330137..3f73f147826409 100644
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
2.28.0.709.gb0816b6eb0-goog

