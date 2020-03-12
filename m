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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADEC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6968E206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYWu85IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCLKHA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:06:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id p14so3031851pfn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFsJl0Fn403l1TnT4AByOXtpFE82PM3y4xKf+BP4gC4=;
        b=kYWu85IZ3wezV2aKjpDgATgwJoYU6h7YZi2pHlfyOBVZb4INymOQqbIgSw5d2jiJld
         ug41k/yz9d06tGhRSaOA+8UPYNVpKCooxbI4BB6HKCdHDm0+3S4gpnECqwAyG1k4NekT
         ItoU/6jFv4qWFQNpYPDR20X17JBIzIPOp9xUR8QqysDgRB2rEzdbnIk76WZDoJMJRFML
         lECctTOA3ksG50cfwcELsD0DTgqFWAE819e9r8FwOl8DcgIszWZNrANf0egdx0WgpnFx
         hOQ53nbEs5/Z2mdlwmkjcIaD2EiyoX5U+aJV0YEslFyDQnoB6eI5eaGMgNqKTDyVWXpc
         KSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFsJl0Fn403l1TnT4AByOXtpFE82PM3y4xKf+BP4gC4=;
        b=pvN121UofxoAeu1IiXXSEfCLJC3N0DOphZ/F8jlen9VjSOX/Z8q3W8u0uBPPqjmjVC
         MDDqBQL0F2N4wQkzB4QUUjAP3jNWi8E2iy/Hb6/ftoPXd5mcFZ+OLIDl7ng6LgSYbGEC
         X9pRIjxlgG+Tkp2Mwj6jdKx5KNBzRPbmajetPy/BLG8U8SqWhQGTMvITyEQmEMMm0UXL
         H5A4NUWo50Gic/2/dl6EPzrxV1Bmki6/psxXOLue3CbT49EjlNEPABMjxLXnAM1d5o0G
         B1QgKukZuIEMqQVcz2AaARooyxkc2N3aaSsnYHwMUrfxEGVfx2Az0vYEZO0ZsS6dkzQt
         /Z7g==
X-Gm-Message-State: ANhLgQ15J3PMdelj9fSBCZXFKNR76sYJNVAtrVmmxGhPrmzL6UUJThAg
        SoPaTBZtNbBoBG/fKWc8Isk4dGMm7+BcFA==
X-Google-Smtp-Source: ADFU+vusA1Ca7e6IQkcP8kqJslycwEuqLzA3UKVnc3EUViTFXldhQxK013iDjLsxcA9pIUskyt0LTQ==
X-Received: by 2002:a62:aa17:: with SMTP id e23mr7527949pff.45.1584007616590;
        Thu, 12 Mar 2020 03:06:56 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:06:56 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Subject: [PATCH 2/7] Bluetooth: Add device to Resolving List
Date:   Thu, 12 Mar 2020 15:37:49 +0530
Message-Id: <20200312100754.3445-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Patch is used to add the device to resolving list. The patch
will look for the local IRK list and if the device is present in
the local resolving list it will be updated and the same updated
w.r.t to BT controller by first deleting the existing and adding
the new IRK w.r.t bd_addr.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
Signed-off-by: Joy Shermin <shermin.joy@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_request.c      | 80 ++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f04ef88da35..e5e09d530ce7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
+int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
+				  bdaddr_t *bdaddr, u8 irk[16]);
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
 				     bdaddr_t *bdaddr);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f4bbd3b79210..88225a9ca1f8 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -885,6 +885,86 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+int hci_req_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
+				  u8 irk_val[16])
+{
+	struct hci_request req;
+	struct hci_cp_le_add_to_resolv_list cp;
+	struct bdaddr_list_with_irk *irk;
+	u8 entries;
+
+	BT_DBG("");
+
+	/* Nothing to be done if LL privacy is not supported */
+	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
+		return -EPROTONOSUPPORT;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	      hci_lookup_le_connect(hdev) ) )
+		return -EINVAL;
+
+	hci_req_init(&req, hdev);
+
+	irk = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, bdaddr, type);
+	if (irk) {
+		/* Device is present in resolving list.*/
+		if (memcmp(irk->peer_irk, irk_val, 16) == 0) {
+			/* Device present in resolving list with same IRK.
+			 * No HCI communication is required.Sort the
+			 * Kernel list.
+			 */
+			hci_bdaddr_list_add_with_irk(&irk->list, bdaddr, type, irk_val, NULL);
+			return 0;
+
+		}
+		/* IRK has changed for the device in resolving list
+		 * Queue up commands to delete the existing entry and
+		 * add new one. Sorting will be done when command complete
+		 * for add command is receieved.
+		 */
+		goto remote;
+	}
+	/* Device is not present in resolving list.If resolving list
+	 * is not full add the device to resolving list.
+	 */
+	entries = 0;
+	list_for_each_entry(irk, &hdev->le_resolv_list, list) {
+		entries++;
+	}
+
+	if (entries < hdev->le_resolv_list_size)
+		goto add;
+
+	/* If the resolving list is full, queue up HCI command to delete
+	 * the entry that was used least recently to make space for the
+	 * new device. Kernel list will be updated when command complete
+	 * is received.
+	 */
+	irk = list_first_entry_or_null(&hdev->le_resolv_list, struct bdaddr_list_with_irk, list);
+
+	if (!irk)
+		return -1;
+
+remote:
+	hci_req_del_from_resolving_list(hdev, irk->bdaddr_type, &irk->bdaddr);
+
+add:
+	cp.bdaddr_type = type;
+	bacpy(&cp.bdaddr, bdaddr);
+	memcpy(cp.peer_irk, irk_val, 16);
+	memcpy(cp.local_irk, hdev->irk, 16);
+
+	hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
+	hci_req_run(&req, NULL);
+	return 0;
+}
+
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr)
 {
 	struct hci_cp_le_del_from_resolv_list cp;
-- 
2.17.1

