Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 14:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiKPOer (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiKPOe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 09:34:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538979FEE
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668609268; x=1700145268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=srE8m0xldG+kxWw/ypimLtqJrtJY208l26NLOxwiZzg=;
  b=j0GDEloSiRFLf9O0jtx4NNyrr7WremfofrR4wn1Y8oKt/6Abu70bSkxx
   7lUB/3GZJlWqB3BCVZVKjlS9fDKBy7cL66eEIMwIccELAJSPxMPorn59C
   gsC3EPZf8j2SNWUBfZA4egmw1Natn5JmBPuBmxGeF27MekJRpMs1C47/g
   aOMQCwUnu3ps1opNnUa1MGSh7vQTd2DFA18h6SDAk8oa3amlhiz3fJLwp
   v7s4XxSG9i9SLmM3gvq5PUCxYeMGoo6atJS1Qj+FfX8+XfsZbhelZ+Cp3
   QpjUHUyt4sbXYV3QtcYUGTQvXKlt6JiFBYAu9SCrphJtU7s+8A1ZgkTz5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312563217"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312563217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672411377"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672411377"
Received: from tester-inspiron-5482.iind.intel.com ([10.224.186.131])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2022 06:34:26 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com,
        Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH] hci_event: handling CIS QoS
Date:   Wed, 16 Nov 2022 20:03:34 +0530
Message-Id: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This sets QoS on CIS connction establishement.

Signed-off-by: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
---
 net/bluetooth/hci_event.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index faca701bce2a..d04af3ad6b73 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6778,6 +6778,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
 	u16 handle = __le16_to_cpu(ev->handle);
+	__le32 interval;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
@@ -6798,22 +6799,25 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
+	memset(&interval, 0, sizeof(interval));
+	memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
+	/* Converting from microseconds to milliseconds */
+	conn->iso_qos.in.latency = (__u16)(le16_to_cpu(interval) / 1000);
 
-		memset(&interval, 0, sizeof(interval));
+	memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
+	/* Converting from microseconds to milliseconds */
+	conn->iso_qos.out.latency = (__u16)(le16_to_cpu(interval) / 1000);
 
-		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.in.interval = le32_to_cpu(interval);
-		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.in.phy = ev->c_phy;
-		conn->iso_qos.out.phy = ev->p_phy;
-	}
+	/* Converting interval to microseconds */
+	conn->iso_qos.in.interval =
+		(__u32)((le32_to_cpu(ev->interval) * 125 / 100) * 1000);
+	conn->iso_qos.out.interval =
+		(__u32)((le32_to_cpu(ev->interval) * 125 / 100) * 1000);
+
+	conn->iso_qos.in.sdu = le16_to_cpu(ev->c_mtu);
+	conn->iso_qos.out.sdu = le16_to_cpu(ev->p_mtu);
+	conn->iso_qos.in.phy = ev->c_phy;
+	conn->iso_qos.out.phy = ev->p_phy;
 
 	if (!ev->status) {
 		conn->state = BT_CONNECTED;
-- 
2.25.1

