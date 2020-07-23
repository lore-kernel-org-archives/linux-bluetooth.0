Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0CC433EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1432086A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFRzsf1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgGWMff (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44600C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so3001651pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=dFRzsf1dtJ5p3hfGbld7FnwiV7O43cPZARtjXsGsdizh1lJyrpqfrGxBUbiNOnTvqT
         9/Pn56r33XsbHvFLfBBmLtnUXF3rfyhMDnzUG4Svu+h8CsdQAvU4zxDP0dsEzNPpOBeo
         au4WPYmWQ5T++DmrKur/z+rJxYYc7Fo6A38oVHQfdb9d8XS8ZPEmB+cuFQWbIiyud2C6
         +PnIMn9b4PVz7M9oM2QChdLr9Oy9yU/sH2WQzyLTaFebu4yq02sXUIDjsjVT68EerR1p
         EZen6NzAzCL4DdyIHfDzxmX2BqKtO+bnKtCQRu0fjM3CcY/1KmbZuLmuNecPQXqQ77Vb
         Zj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PK9IFrqGA8tYf+eWNXSfj5UIMsffCcBtO2fOhU2TTN4=;
        b=lItbP/XdrV9Wy0U3MwknDLV2ls/DjrUtlbsHbkfjo8jldYGPbXZc5e+iemcxHMSFwE
         3cD2PzEX+OQXhw0GW/o1vbnOOeOzuxWq8YpEBOdmiL96JZvHf8IoXtZ/rAoh9/xROB+k
         FLdBfmXVnNqNti/HnsUj286dNKwLXIABZWdTE4Mz5BV/freywpifrZ44JgWA+hxoCkUG
         fiK1RqZvyamVwHe+uX0q/8Ow4uQx4AAWpbbS+tjmACr+dCZYQ0+icACycqNP56SMtxkt
         gZHmE5kFVz+vwW9v1sIsMWX54ZgDA419Laa6EQ+yjKSexdTHDZKOdTOpPWfPPaksGyZq
         3i9A==
X-Gm-Message-State: AOAM532bUbdSvMI9eddl/M82EDtngtNFnPYmOkn9NDBIFw0K9b7nLHf6
        txNHuW/+GF2JSxfJK9rNAMidxspi2MDwNA==
X-Google-Smtp-Source: ABdhPJwg0oMH2ei7aOXDJJOrLjMJeU6NykB9GOZPJityNhfQwu2vRE/9WRj+ch7l9/53LyWzQxpkhw==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr214701pjt.208.1595507734661;
        Thu, 23 Jul 2020 05:35:34 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:34 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 7/8] Bluetooth: Enable RPA Timeout
Date:   Thu, 23 Jul 2020 18:09:02 +0530
Message-Id: <20200723123903.29337-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
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
index 4af208b82138..2030536cc5d8 100644
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

