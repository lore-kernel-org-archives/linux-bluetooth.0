Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0883CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA18A2073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQpaKIjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgGAKBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E50C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f16so433651pjt.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkjx5T9Sq5IYIs+S7efhCR5KF66qOJdP9PWteN5i6Lo=;
        b=IQpaKIjkCKXiUJiPwiiS/vQiL0VViTB8EJ4zSEitaRCCIv1GmJZO0TvqeIiwjZSxA+
         aUEHwJXYWc+TvF0abTyLbPr/HrdA0yMVgzfabd4nZqJizQnLd3GMAJSk9k55gJ324pQV
         lskhYX3IP58lwLaQOyryQluWrCk5hMbDO4reJzhlgUeEjke5Ia0dR5mceMDUYjS4jRkI
         h5QqsUVFyTmRmbW4wtF9+LVmWO6J1YjqhCaBLsLRrA+RwXZDtJ7tDWKWBCfI4D3nFbOo
         GwufLsMnn1nYOofrnuF2TeFo+iEHvopeqVst+QCZfICd0pSbU/IVmbYE5QVoRG81DNou
         /E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkjx5T9Sq5IYIs+S7efhCR5KF66qOJdP9PWteN5i6Lo=;
        b=lLNEYaZDl8Qlv3Pr3kVz2vG4HO+n7iX49BBcq2CBWrSuqAijeAgVXvJdJwN4sUKyuv
         Oy1FRuCTYZUJPI71yZxT+VRqil1kkxuC7xO/J6LnEBZQeVybFvbJQ5rLoUWheJV3GZbV
         X+yY1B+NpVX6WjgxwqgzONAkmmpGQex/atkdREvF2l2NL35TUSM5/oONJobL8c3GOFCK
         NKmAGDjE+bMfYN4wC65DrxxJYfwy8OSdUJ173ZQiFG1iaO65g7jHGd6Hl2DdO7T1Quda
         VqTPHWLZRKvA/CisMCYQG4rL6AhpBEMnUOAw4v7yrJfGPIrE8KAoGPvUAtRyIVtbiVHY
         WBlQ==
X-Gm-Message-State: AOAM5314HzO2Tc5JaOAA3LgSBr9+WDZOd2ZRhBFyoDZL5xlWhA+S4dnA
        n0kzyANRx2ijgFz2huJ5Gk/5s9Blg6AJDA==
X-Google-Smtp-Source: ABdhPJyFe2XHAKYJmO8+Lc4E1rTPDNDtHKOjbaEjlnvDZpcVm7aDpeMsMuHCKY/CG50ryTaCyfEY5g==
X-Received: by 2002:a17:90a:e602:: with SMTP id j2mr23767397pjy.200.1593597692090;
        Wed, 01 Jul 2020 03:01:32 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:31 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 7/8] Bluetooth: Enable RPA Timeout
Date:   Wed,  1 Jul 2020 15:34:31 +0530
Message-Id: <20200701100432.28038-8-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable RPA timeout during bluetooth initialization.
The RPA timeout value is used from hdev, which initialized from
debug_fs

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index abab8b5981a7..4ff2fc4498f3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1637,6 +1637,8 @@ struct hci_rp_le_read_resolv_list_size {
 
 #define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
 
+#define HCI_OP_LE_SET_RPA_TIMEOUT	0x202e
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
 struct hci_rp_le_read_max_data_len {
 	__u8	status;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 604a411a9b8f..b496d5395bd3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -762,6 +762,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
 		}
 
+		if (hdev->commands[35] & 0x40) {
+			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
+
+			/* Set RPA timeout */
+			hci_req_add(req, HCI_OP_LE_SET_RPA_TIMEOUT, 2,
+				    &rpa_timeout);
+		}
+
 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 			/* Read LE Maximum Data Length */
 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
-- 
2.17.1

