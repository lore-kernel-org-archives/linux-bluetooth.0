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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92857C1975A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F89206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm0JKmK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgCLKHC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37957 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKHC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:07:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so3029445pfn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8MluMm6f37XTe3y61evZ3K/RFwbeZ1K+tfhSmXkmKU=;
        b=rm0JKmK3M9l2ShN5Rm8hIF7crWT2uzhqAbDpxufwiAgbh1CYUcivvSY/Nceab+uNgK
         qGWeDnK4GF2/aySFt4k+uJz3BeNhcC9kaMaL4XHUWGlrxwSZc9oF4lk0oPPBD+OMfMeO
         iFZbZJGPnosn7TiUdSNzabAt9sdCAAME/8NtzlxIiyZJXImW6nap7omgnQWlob0A9XTC
         qIiPxIr2kImMYbc5OSed3ldtMMiJWiU31DVNGR0canN9M8WiiuFBGbPA/LfVRjaHT0Rm
         VNIMOTDtNG7692PFC544J4JZpUO++CpYf8MPha7zkt9nuezRYUEbYrPYUp/xOcQUDKiu
         AJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8MluMm6f37XTe3y61evZ3K/RFwbeZ1K+tfhSmXkmKU=;
        b=buBzRKicmAYpUz+HE78frQXN9HxxK8houDbSRCv+x8s1A9xK+luW+sMdx/PG3wNNY1
         cRSDrW1uRE3OiiiPUq2o/6/SQneYzgURPYZizD2RpHoa4ew1i8VgXxbOukF5O2E0vxna
         F2aAYp0MfMa36/tNyRo2PUF2ycd6ug48rYi/k7W6iy5+S16NzwjGFhP6+USGW6lAmzne
         TKXJeRSJXZzkrz/o6v6BgFAH/3q+xwExTdER6UlmFv1Q352F+o58xZJG6xPaobHcfv2G
         QQfj7m/xKsEswr076apW8v825R800Qj+UOZd5QS7i7z7D6D8lbreC1NWFChikFnxctII
         dRRg==
X-Gm-Message-State: ANhLgQ2UNCTPT0gR5vWSQ9wW9lzx0uQdkwUg6pmLEhHTUhz9ndStKTFX
        GUVCwuJPyKavgXeUI3Eg/yWDiNi3gDpupQ==
X-Google-Smtp-Source: ADFU+vv2v0eV3wXPQmxJO73n9PC05yAbeZKT7Voy9YiXlRwLN+iRvj9kNi0SJjTDuzpepSMsrM2jAw==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr5294374pfl.293.1584007620683;
        Thu, 12 Mar 2020 03:07:00 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:07:00 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Subject: [PATCH 3/7] Bluetooth: Update the Resolving list when Local IRK changed
Date:   Thu, 12 Mar 2020 15:37:50 +0530
Message-Id: <20200312100754.3445-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Whenever the Local IRK changes. i.e privacy mode is toggled
this patch helps to change the IRK list in the bluetooth
controller

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
Signed-off-by: Joy Shermin <shermin.joy@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5e09d530ce7..43d31a9339a6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1659,6 +1659,8 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
 				  bdaddr_t *bdaddr, u8 irk[16]);
+void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev);
+
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
 				     bdaddr_t *bdaddr);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 88225a9ca1f8..9ffb62178d24 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -965,6 +965,56 @@ int hci_req_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t *bdadd
 	return 0;
 }
 
+void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev)
+{
+	struct bdaddr_list_with_irk *irk;
+	struct hci_request req;
+
+	BT_DBG("");
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (!(hdev->le_features[0] & HCI_LE_LL_PRIVACY))
+		return;
+
+	/* If resolving list is empty, nothing is to be done.*/
+	if (list_empty(&hdev->le_resolv_list))
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	      hci_lookup_le_connect(hdev) ) )
+		return;
+
+	/* If resolving list is not empty, then clear the resolving list
+	 * and add back each entry with updated local IRK.
+	 */
+	hci_req_init(&req, hdev);
+
+	list_for_each_entry(irk, &hdev->le_resolv_list, list) {
+		struct hci_cp_le_add_to_resolv_list cp;
+		struct hci_cp_le_del_from_resolv_list cp1;
+
+		cp1.bdaddr_type = irk->bdaddr_type;
+		bacpy(&cp1.bdaddr, &irk->bdaddr);
+		hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+			    sizeof(cp1), &cp1);
+
+		cp.bdaddr_type = irk->bdaddr_type;
+		bacpy(&cp.bdaddr, &irk->bdaddr);
+		memcpy(cp.peer_irk, irk->peer_irk, 16);
+		memcpy(cp.local_irk, hdev->irk, 16);
+		hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
+			    sizeof(cp), &cp);
+	}
+
+	hci_req_run(&req, NULL);
+}
+
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr)
 {
 	struct hci_cp_le_del_from_resolv_list cp;
-- 
2.17.1

