Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4134C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA7E20716
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCKf+BOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgFVNad (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgFVNad (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 09:30:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D8C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 06:30:32 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j13so9628555vsn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8uqE44TmELPF9VXApMhMS05SOSSguTci3Kx8JF62j8=;
        b=hCKf+BOLquGjqqkEy7v+MbROZLoVataIZTJ3s1Yu+z/NFnYjLf5NHn1FgkEacxD0Ne
         5tZ1j4DLXFlcfgGjirYe0NPSIrI+RuD8P8IqRVGlAGlBcTsk6pV83FV9PNfptt1s9cjS
         0H+QzhM8DN5RNKSDGW0BEDsdR+MvyciAcO9Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8uqE44TmELPF9VXApMhMS05SOSSguTci3Kx8JF62j8=;
        b=Ym8nwB7foMFqU+DWYHCwzy5bNQ9cXMRyF7USDbbIm3uMc8oDM2/JSIdeQCYqwZDR8N
         ZgICxLhAD+jctQSUPso51mTCAtyK/0q4LuOiysuvQd8Eq2O2cWdFg10ARRHyfY6T0x/V
         N17+DT6i8ngyMX5ZuguT6rfeIWZ4FOqb+CpEyC61mYpmHK4lBRE/8eQG04iVFOdky0gZ
         il1l/rEkyA2TYkZ26+eQXbFVQQC+eIUajiNNRNJODCxcfWRzD4BHYJbC34nFMQkT54Pe
         iyl2ecYwghUc08zlIpp97XxNh0avlRXms6Gp8s2T6BEu5J5OcnWpY+I6LKTX8j/+4KK8
         ARCA==
X-Gm-Message-State: AOAM531cipm8KvhNzwT9eEmNJawtpSDGKCwVGKhZ6ndR7zWBqgC0yKZw
        FR1Glx7ylucCEpzovwFC6OX3/YDNoj0=
X-Google-Smtp-Source: ABdhPJxssBZQbVdWErHlqnt0R2Dfnq2fGncnnnravkYXTVgZf4zhG9ub6uyf3/GQgPUP7ACvEwKy4Q==
X-Received: by 2002:a05:6102:48b:: with SMTP id n11mr16482372vsa.112.1592832631593;
        Mon, 22 Jun 2020 06:30:31 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id d3sm544278vko.51.2020.06.22.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 06:30:30 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH v3] Bluetooth: use configured params for ext adv
Date:   Mon, 22 Jun 2020 13:30:28 +0000
Message-Id: <20200622133028.26882-1-alainm@chromium.org>
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

Changes in v3:
-adding 3 octet comment back per Marcel's suggestion

Changes in v2:
-fix commit title and typo in description.
-Moved le24 convertion to  hci_cpu_to_le24

 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_request.c | 7 +++----
 2 files changed, 11 insertions(+), 4 deletions(-)

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
index 29decd7e8051..86ae4b953a01 100644
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
@@ -1833,8 +1831,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
-	memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
+	/* In ext adv set param interval is 3 octets */
+	hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
+	hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
 
-- 
2.27.0.111.gc72c7da667-goog

