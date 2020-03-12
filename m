Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACDC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD1206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdQTkCBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCLKGv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:06:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43596 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgCLKGv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:06:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so2825019pgb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3YDtsZFvd+LPTd0Sd0anKk1uRn89slB36yxlIFn11go=;
        b=jdQTkCBGhoVnBa+vbD/hrrTmZNBq1rDe3VTL/ZHKxOrp7gykKpuEvh6XGyY7e4gS6L
         Umj0OHpaCI6rN7RkOMoe1Boi9I7cTesnDsN7R7OS8orNIvh5dbGo262/4q2U1t46qOJM
         gLkHyNnu+u4ZoTVN1PVCpJPzMPTrmRFNxC20wEXdpLtELx6JPhe+g/83qgvAH+XzVqM+
         nNhGCGKxDoqb81CFWqQpR+dwtTFNc8AU5AVN9AQaCyN6SdwrCVozDSf0RRcboggcZTkM
         YpDM30x8hMR0CtzRPiEq1cHFuQ0D4vhiVqoMP9Hu/8omS/38GXTPCHmbgyBNzUp0CsI4
         0fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3YDtsZFvd+LPTd0Sd0anKk1uRn89slB36yxlIFn11go=;
        b=huHvNJLUAxwPPijEVEfmzvAUyFiR2foQ1EcnQVw37c5lPiJ/8prFn9ioBm3+D/uioN
         u4PZv8Pghsa0siPo54nrIcBPHuBYojCi0ueyCFgdFZqPn8mnPPiIPTTCe/KWeTTXP9sj
         IuyR2Yl3fd1aYYIEEAy0rtjwzvg67DrG6ieTVCzML6kODmdQUv7AEzA0hZN5+d9Hwc2T
         2SEeTHyq8X8GjRe51Y055DlNGsmroFbBua8ONJ6/JhBmeAQPTe2kgsdxgAGvaP7TT9xX
         xYLkEICV1bHbrw1TQwcfUAlf71rvaFQK5w5ynE+O9VMfRbdBokP1geAvZzenD2ueVrqt
         3eEw==
X-Gm-Message-State: ANhLgQ1vT9qQXPilZEGsElMHtxIZpYY4C+wJu76WsvZdZVX3mtVSt44f
        0B1JIrFgVoQXbJkRyh/4vFPSfcOuLu8=
X-Google-Smtp-Source: ADFU+vvmKGDrp+ae0vMf7DCodYgnQUqJG/NrbYg5fiJZ1d91al3ZYbg1eTuvL04mZVaRmGTSYIr1iw==
X-Received: by 2002:a63:4912:: with SMTP id w18mr6865770pga.122.1584007609629;
        Thu, 12 Mar 2020 03:06:49 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:06:48 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 1/7] Bluetooth: LL Privacy Delete Store Resolving list
Date:   Thu, 12 Mar 2020 15:37:48 +0530
Message-Id: <20200312100754.3445-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch help to delte the resolving list stored in the BT
Controller w.r.t BD_ADDR.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 33 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..352bc43940ff 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -457,6 +457,7 @@ enum {
 #define HCI_LE_DATA_LEN_EXT		0x20
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_EXT_SCAN_POLICY		0x80
 #define HCI_LE_PHY_2M			0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..5f04ef88da35 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				     bdaddr_t *bdaddr);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index bf83179ab9d1..f4bbd3b79210 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -885,6 +885,39 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr)
+{
+	struct hci_cp_le_del_from_resolv_list cp;
+	struct hci_request req;
+	struct bdaddr_list_with_irk *irk;
+
+	BT_DBG("");
+
+	/* Nothing to be done if LL privacy is not supported */
+	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
+		return;
+
+	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	      hci_lookup_le_connect(hdev) ) )
+		return;
+
+	/* If the device is not present in resolving list
+	 * no need to send HCI command.
+	 */
+	irk = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, bdaddr, addr_type);
+	if (!irk)
+		return;
+
+	hci_req_init(&req, hdev);
+	cp.bdaddr_type = addr_type;
+	bacpy(&cp.bdaddr, bdaddr);
+
+	hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLV_LIST, sizeof(cp), &cp);
+	hci_req_run(&req, NULL);
+}
+
 void hci_req_add_le_passive_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
-- 
2.17.1

