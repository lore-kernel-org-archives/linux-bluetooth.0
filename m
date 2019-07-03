Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46995C06513
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D9A218A6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSdB+xWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCODs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:03:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCODs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 10:03:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so2540757ljg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HrdzLpThnp4XMqVvFHU1y9LanmyXQ0RXfMKTA3VGb0=;
        b=YSdB+xWCehp2+0sESEgYKEfRwY9ww4FK/gH7ZavkKgw9cxLALDqhq41vgRN/yX18BN
         M0uKKG3nmW9EzSe9AZv4qgS/nBe3O/cBsKdywMAe7GmtjFHN0yucZqzayXg63jl8NYp1
         8m07AfXOQH+LbBbKusqoSh13BwF6UETBW4lIQ9dXN5flU5BEOxY7XQXeEf1MtQFbNS7C
         X5RxLH2Y8/yFM9rGlJflXVlaJrovMQyDZj3pk/tiV8QzVSzRzN+DbMX7r2eAZOvp1z7Y
         itD47D84yV/RPQV9nQCG+Y/IzyaFR2+cwTM9+/D9FbB7++wVOyiDQHgDX1qrv9+TRTwT
         a/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HrdzLpThnp4XMqVvFHU1y9LanmyXQ0RXfMKTA3VGb0=;
        b=tT9BQt/yWFm1jzD2KrLi3H8mhEWTcGHEFTzrwdpDmX57OoQl2qBhHs3decQXBF7JO3
         goSzRZe+LwP7hL/xDRDN63B0z8GKulnwYpPkExXE55LbPRQ/0kxDgmV6s+ETyh30T9Kf
         8TkxMpue5KE44KCIqVKc3eF6NUCsLb9LApIYEKkWiEGyaxcD22cVgRJA+lyjmiKNczwY
         XbMMiXKmzYQDVYx1dxVbnQDgR/S+U+V6APouxjPRU+/1FncpmAKJWP67BR6h2pnAvy2X
         FBvRo5wo/ucL6d4s/oAb7ckBG1n26LuGFD7/firnqTUAta+izlJbeb2hUb/14Ql6zu1V
         xmHg==
X-Gm-Message-State: APjAAAWd/p79nrgjJbaqsvwrKd26j2dyNWFS/s8dd/f9r3kqIdt1ScOz
        eI4mhNZQQR7vr1+2pI9cpjj6Bd+oPebizQ==
X-Google-Smtp-Source: APXvYqwLEIdLDOrqxlLjweLgHINwB2gtwSR7lMVFcG71RrUZt77W61ybKxDQQAtyaxsY79frCU8+KQ==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr21685813ljl.8.1562162624935;
        Wed, 03 Jul 2019 07:03:44 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id u13sm412070lfl.61.2019.07.03.07.03.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 07:03:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use controller sets when available
Date:   Wed,  3 Jul 2019 17:03:43 +0300
Message-Id: <20190703140343.11210-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of controller sets when using Extended Advertising
feature thus offloading the scheduling to the controller.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c    |  2 +-
 net/bluetooth/hci_core.c    |  3 ++-
 net/bluetooth/hci_request.c | 40 ++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_request.h |  2 +-
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978ce8c45..1d2fa24d752f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -912,7 +912,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 				    sizeof(cp), &cp);
 		}
 
-		__hci_req_enable_ext_advertising(req);
+		__hci_req_enable_ext_advertising(req, 0x00);
 	} else {
 		struct hci_cp_le_set_adv_param cp;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6b2540ba7f8..9547354a9773 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2829,7 +2829,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 		memset(adv_instance->scan_rsp_data, 0,
 		       sizeof(adv_instance->scan_rsp_data));
 	} else {
-		if (hdev->adv_instance_cnt >= HCI_MAX_ADV_INSTANCES ||
+		if (hdev->adv_instance_cnt >= hdev->le_num_of_adv_sets ||
 		    instance < 1 || instance > HCI_MAX_ADV_INSTANCES)
 			return -EOVERFLOW;
 
@@ -3197,6 +3197,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
+	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36cc149..5970d77f9911 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1596,7 +1596,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.tx_power = 127;
-	cp.handle = 0;
+	cp.handle = instance;
 
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
 		cp.primary_phy = HCI_ADV_PHY_1M;
@@ -1638,11 +1638,21 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 	return 0;
 }
 
-void __hci_req_enable_ext_advertising(struct hci_request *req)
+int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *adv_set;
 	u8 data[sizeof(*cp) + sizeof(*adv_set) * 1];
+	struct adv_info *adv_instance;
+
+	if (instance > 0) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+		if (!adv_instance)
+			return -EINVAL;
+	} else {
+		adv_instance = NULL;
+	}
 
 	cp = (void *) data;
 	adv_set = (void *) cp->data;
@@ -1654,11 +1664,23 @@ void __hci_req_enable_ext_advertising(struct hci_request *req)
 
 	memset(adv_set, 0, sizeof(*adv_set));
 
-	adv_set->handle = 0;
+	adv_set->handle = instance;
+
+	/* Set duration per instance since controller is responsible for
+	 * scheduling it.
+	 */
+	if (adv_instance && adv_instance->duration) {
+		u16 duration = adv_instance->duration * MSEC_PER_SEC;
+
+		/* Time = N * 10 ms */
+		adv_set->duration = cpu_to_le16(duration / 10);
+	}
 
 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		    sizeof(*cp) + sizeof(*adv_set) * cp->num_of_sets,
 		    data);
+
+	return 0;
 }
 
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
@@ -1674,7 +1696,7 @@ int __hci_req_start_ext_adv(struct hci_request *req, u8 instance)
 		return err;
 
 	__hci_req_update_scan_rsp_data(req, instance);
-	__hci_req_enable_ext_advertising(req);
+	__hci_req_enable_ext_advertising(req, instance);
 
 	return 0;
 }
@@ -1718,10 +1740,13 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 		adv_instance->remaining_time =
 				adv_instance->remaining_time - timeout;
 
-	hdev->adv_instance_timeout = timeout;
-	queue_delayed_work(hdev->req_workqueue,
+	/* Only use work for scheduling instaces with legacy advertising */
+	if (!ext_adv_capable(hdev)) {
+		hdev->adv_instance_timeout = timeout;
+		queue_delayed_work(hdev->req_workqueue,
 			   &hdev->adv_instance_expire,
 			   msecs_to_jiffies(timeout * 1000));
+	}
 
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
@@ -2739,7 +2764,8 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 				if (!ext_adv_capable(hdev))
 					__hci_req_enable_advertising(req);
 				else if (!err)
-					__hci_req_enable_ext_advertising(req);
+					__hci_req_enable_ext_advertising(req,
+									 0x00);
 			}
 		} else if (!list_empty(&hdev->adv_instances)) {
 			struct adv_info *adv_instance;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 692cc8b13368..ea4191c76fb3 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -82,7 +82,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
-void __hci_req_enable_ext_advertising(struct hci_request *req);
+int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
 void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
-- 
2.21.0

