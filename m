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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5871C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808F920724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTxOM3hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCLKHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43494 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKHG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:07:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id c144so3019450pfb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zBwx/dz5Yma+kmqRs4Q3CZ2L+oCkvmiphJfnBmSHoc=;
        b=KTxOM3hqnqbjZqty/iuu7ACE4GoqjlVc3uOc53AEBD7EC1GP2rqCbVZ4dHRpxfGc+/
         9Pc/zYgwknjSJ+5/q+OsFURpaiJy9B+cI0GrQWvWzZdDQR/WR+VliiG7mLcUIjm5IRZL
         oHjbxdtHd1DW5SgZNe/B1FkQ64/I+ITonr42rgPJBM6P0/2m1diMSjuP3bsLAW6tA0xo
         mipBPjN66MMOwuY/oqrlZc2bzLEpThVqpHDYnXZnkOCyhVyTE0lzqMQek2vuIkrzNOsb
         XXtcB/APSOhj5O7e9v2sVXFYM8ZacwzwqAgbG/9v2c5x5EvMl5fs+PT8OIwUytJUtQ7o
         YRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zBwx/dz5Yma+kmqRs4Q3CZ2L+oCkvmiphJfnBmSHoc=;
        b=UL0CkN/EDAECsZEE55Pv/ccJgh4gAEv/o0GfLwT5XuKoTo3Dp0jlSZMbY7QA+HuMSf
         frJc+ybp1FjMhIUriqwx1VuBmfxIdpF07dqV+cZQkp5ULt3OhZx2Rwy+Dr02TBYNRG4I
         WAg90ma4KVCw6eHC3BzvEPJFNcraE0bpJprEAS2XegkSWriTUV4uYqriVYD472aZs6qC
         PRLcLy9mWTXJVKZuZpoBFcnPw3AVyNqbYe9J0jURJu3KRv7sYx7yrtUeWWu4jQBrHtpW
         TSUBZ6oRanXW4N5pIAtwwHaD4OFouvgu7i8+CobBUXRaqxkvU1hjuOm41uxa+lydmPH1
         3wbQ==
X-Gm-Message-State: ANhLgQ35JTdYtke3YnLm0Bcx0lAYFMj9Cbw0R8Yr4uZzwx8PQyBHxchy
        NVKLIGFTTJYxUAjqDANfmcyESee7W+F9mQ==
X-Google-Smtp-Source: ADFU+vtzhYpfTnXPkbszd76BTbtMinFozrX27uddzYcByBLxwux/YtJtJJp2fBmoi4Go0vqO7zPsrQ==
X-Received: by 2002:aa7:9482:: with SMTP id z2mr2656007pfk.147.1584007624679;
        Thu, 12 Mar 2020 03:07:04 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:07:04 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Subject: [PATCH 4/7] Bluetooth: LL_PRIVACY re-load resolving list
Date:   Thu, 12 Mar 2020 15:37:51 +0530
Message-Id: <20200312100754.3445-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch is used to load the entries in the local IRK to the
Bluetooth LE controller resolving list.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
Signed-off-by: Joy Shermin <shermin.joy@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_request.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43d31a9339a6..46d2d3e10c97 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1659,6 +1659,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
 				  bdaddr_t *bdaddr, u8 irk[16]);
+void hci_load_resolving_list(struct hci_dev *hdev);
 void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev);
 
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9ffb62178d24..e17db3103a3d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1015,6 +1015,35 @@ void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev)
 	hci_req_run(&req, NULL);
 }
 
+void hci_load_resolving_list (struct hci_dev *hdev)
+{
+	struct smp_irk *irk;
+	u8 num = 0;
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
+	/* Load the first le_resolving_list_size entries from IRK
+	 * list in to resolving list.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (num++ >= hdev->le_resolv_list_size)
+			return;
+
+		hci_req_update_resolving_list(hdev, irk->addr_type, &irk->bdaddr, irk->val);
+	}
+
+	rcu_read_unlock();
+}
+
 void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr)
 {
 	struct hci_cp_le_del_from_resolv_list cp;
-- 
2.17.1

