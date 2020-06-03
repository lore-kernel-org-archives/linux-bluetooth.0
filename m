Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31832C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103C520674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7px6/FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFCROT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCROT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16686C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f3so2005003pfd.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=agt0nawk/JvvEuRuffYxBaaD0CzjiES3RArXV+8d3mU=;
        b=V7px6/FNhO00cLPUOgAdw5UXg+zCciP/pV6q4yoDz1qr1m21NrrMD6Xhdp0fn/FZm0
         LPl7yqCaRG/9ulr5j6exR06g4gzaaWL9b5IKPKWj2roqU4lXKn9oqsxmwBEWqDFPsDyU
         TqhTtktaDLorvKNxtHwNhuXi+uMv6zcfC3eST9NHcuC4RsWS6QgkpVmAM9AzjznMm+IN
         wwNYVYdfIrbBvQksDwFa80lNkuPKr9kW2WSUb2+7tGELFvy2QaYXaN5yq1/qbsJQhi55
         vljIj7a9NhdRmNKnJOIlXoeyg8njN6C2/jt8e9aReq5Hitasjic8qcUD+dcB4UqRIrT6
         gGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=agt0nawk/JvvEuRuffYxBaaD0CzjiES3RArXV+8d3mU=;
        b=R4hbmS1YvfP0cJeS1gaHZ1jX1Qg422PxX0r6nQ13s8ueYhpIXIUk3PtUqtHfiveNk9
         YQc2Fpi0EiDeIxWG9zysxb+wZNnB7qTaVRnz1tnuI3+nMbWVIKHSkH7wtJWVwPjtXAvy
         buHdRpkzQftJcQgmVIiT+oKemq/J4VliyPUFOTOTsrlnby4dCVOcXtidfOxKs45nenMR
         jOZIgeTKDtiMON6o0CV3/8oHO5yGW5qDKWQyATz6eJYPTEhIh5C7tbyUyvauNt7KU+TF
         fOxm2Dm9gklGyiW+eHfzJc/S3GoWCLRUYG5vvouDYyim6zx+XGdvepQHIJ+3CMCKY6Z4
         5xYQ==
X-Gm-Message-State: AOAM531WPIB7PhO0QznybwvU2nHYKVNnKQMh1aNaC7M+S4cuNWsLUPwZ
        Bh1muSt74QgekeJ7budrfoYHNFtDA0c=
X-Google-Smtp-Source: ABdhPJw3wbt5UAEkgDBbZdvYegMlNWEbocRkDO1JYZZcIUp/ghAb2QaCY6BEdD2hb4DKhdEfzKs5RQ==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr371315pgn.81.1591204457319;
        Wed, 03 Jun 2020 10:14:17 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:16 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 2/7] Bluetooth: Configure controller address resolution if available
Date:   Wed,  3 Jun 2020 22:47:08 +0530
Message-Id: <20200603171713.9882-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

When the LL Privacy support is available, then as part of enabling or
disabling passive background scanning, it is required to set up the
controller based address resolution as well.

Since only passive background scanning is utilizing the whitelist, the
address resolution is now bound to the whitelist and passive background
scanning. All other resolution can be easily done by the host stack.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_request.c      | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cdd4f1db8670..c17c8d820493 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1279,6 +1279,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
+/* Use LL Privacy based address resolution if supported */
+#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1fc55685da62..1d885ccd5419 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -676,6 +676,12 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		cp.enable = LE_SCAN_DISABLE;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		__u8 enable = 0x00;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
 }
 
 static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
@@ -808,10 +814,16 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 }
 
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy)
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
 {
 	struct hci_dev *hdev = req->hdev;
 
+	if (use_ll_privacy(hdev) && addr_resolv) {
+		u8 enable = 0x01;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
+
 	/* Use ext scanning if set ext scan param and ext scan enable is
 	 * supported
 	 */
@@ -885,12 +897,18 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+/* Ensure to call hci_req_add_le_scan_disable() first to disable the
+ * controller based address resolution to be able to reconfigure
+ * resolving list.
+ */
 void hci_req_add_le_passive_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
+	/* Background scanning should run with address resolution */
+	bool addr_resolv = true;
 
 	if (hdev->scanning_paused) {
 		bt_dev_dbg(hdev, "Scanning is paused for suspend");
@@ -936,7 +954,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
@@ -2725,6 +2743,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	u8 own_addr_type;
 	/* White list is not used for discovery */
 	u8 filter_policy = 0x00;
+	/* Discovery doesn't require controller address resolution */
+	bool addr_resolv = false;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2746,7 +2766,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 	return 0;
 }
 
-- 
2.17.1

