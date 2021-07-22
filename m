Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914DBC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C661279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGVFUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41843 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhGVFUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:31 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210722060105epoutp03b651546b1f34baa3e79c505d0165dca9~UB4yf3_he1006110061epoutp03p
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:01:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210722060105epoutp03b651546b1f34baa3e79c505d0165dca9~UB4yf3_he1006110061epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933665;
        bh=TOVJeRLqrpM2C6gWzVfH/5BMx07AEgbwpq9e1f615Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uazDXwTsk+2fXmDVqOkIhtlwRrs0uRRawQaH4e7/bH8gvvkILc/LXwYJ576io8VSn
         Dl7ngB+T2VanqfVVsmHf7rO7P4vLI2gqW8IIeNpQ8X0dikWWYqLwRqcx3XMsPlFHNx
         3ACX3rQEzpYetimdAyUm/Sp68ryf0oxTxCnXVkug=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210722060102epcas5p3a7ca0b4255a7d2531303f5408a429273~UB4u2r8PW0665006650epcas5p3d;
        Thu, 22 Jul 2021 06:01:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.1B.09595.D9909F06; Thu, 22 Jul 2021 15:01:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210722055013epcas5p350d88f402bbe4c55f1f868dbb2decbaf~UBvTSavM-2138821388epcas5p39;
        Thu, 22 Jul 2021 05:50:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055013epsmtrp159358437877ed17d100b1907ef0594e6~UBvTR9EZX3119631196epsmtrp1r;
        Thu, 22 Jul 2021 05:50:13 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-c6-60f9099d7883
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.14.08394.51709F06; Thu, 22 Jul 2021 14:50:13 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055013epsmtip1b1230acbd100318b1de6b85a398f0808~UBvSaq0qa1155311553epsmtip1A;
        Thu, 22 Jul 2021 05:50:12 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 5/8] adapter: Add support for LE PHY Update Complete
 event
Date:   Thu, 22 Jul 2021 11:19:48 +0530
Message-Id: <20210722054951.8291-6-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmlu5czp8JBqunK1rcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJXx7OtT9oLFchU/t55lb2C8KdHFyMkh
        IWAisfH1ArYuRi4OIYHdjBI9yw8xQTifGCXe9d1nhXC+MUpcXvmFpYuRA6xl3SJNiPheRon9
        T9sY4ToO3F/PBDKXTUBT4vXHL2C2iICyxLN9h8FsZgFdiTPv17GB2MICQRJHbhxmBbFZBFQl
        rp38yAJi8wpYSWz5fYQF4j55idUbDjCD2JwC1hIHHt1kB1kmITCZXWLN+bfsEBe5SGw5rglR
        Lyzx6vgWdghbSuJlfxtUfTOjxI7NG6GcHkaJBz+62SCq7CXONT1jBRnEDHT1+l36EGFZiamn
        1kEdzSfR+/sJE0ScV2LHPBhbRWLDqk64ZR+PLWSGsD0kzi44zwwJlT5GiSeTulknMMrNQlix
        gJFxFaNkakFxbnpqsWmBUV5quV5xYm5xaV66XnJ+7iZGcDRree1gfPjgg94hRiYOxkOMEhzM
        SiK8KkVfE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzsscDpQTSE0tSs1NTC1KLYLJMHJxSDUwr
        r++5HF7z7nhFqpoE641QhxdrGbqWegjuX56l8WnGBss/l9PbSluaL6rtnHC0ZKtwiiJn2Qde
        gaKFvOe6UuXKRFLzcrbqFvje5D/EetB/33eZhPvzdmwKFz3YOF/kftX7xIrmFgf+/Xp8E/09
        ymdkz7LYld42dcfJ0243Z2p0ar1P8DpyIK62ufcc99OFc4tO5nl+/6yxp5P12Yb47zOnW9xY
        L9rzPeGlhOB+iYhTe+pYdXbPO739vKaGyaqAxP0n2LiWXOx+JvWn5POvNceTTJzu1wW+YJpy
        42rhi/dpUsuZEpt/bb67OzPT7Ed7ZfB0n3XS/H8uGll+OPtGPNXdYXv1tQul/W9znqd1GSQo
        sRRnJBpqMRcVJwIAHNvZT1UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnK4o+88Eg9sPDSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mp49vUpe8FiuYqfW8+yNzDelOhi5OCQ
        EDCRWLdIs4uRi0NIYDejxOE3/ewQcSmJx8t0uhg5gUxhiZX/nrND1HxglLj67yULSIJNQFPi
        9ccvTCC2iICyxLN9h8FsZgF9iacXrjOC2MICARKXNr5kBbFZBFQlrp38CNbLK2AlseX3ERaI
        BfISqzccYAaxOQWsJQ48uskOYgsB1dx7vYV5AiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnF
        pXnpesn5uZsYwaGipbmDcfuqD3qHGJk4GA8xSnAwK4nwqhR9TRDiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qByfBnkoe6zdGkeQdc5/50/qC7wHHjVJl2
        wc3XdHml1x1UZ3seyvJX+t2TmJkib3QUZYMDnwiy1X05x/O9OJQ1Svr5quvzzb6pO65eFMKo
        ePTV3IuOVRWyGWueh6uJlPHYnj/44wunWkwV770FiQ8FNS317ixP9bNSLKytKlf2bAlJefVJ
        324CX53mf66jfG7fM2ckq2/MdJwsVcfrfCd650v9ztUGotN0vvoYsKrezX4syDfT2JWXjclP
        d3M0u85Zk+A4iyXa81zd5CYH7Ll0TuuzRCfLoRnHKnMOn3VNaD11n/ngAtVKrq5H+7rNnJ3X
        FFzIzp9gfG+qxlNbbaOJ7Nm7qv5Evln++sGlldJKLMUZiYZazEXFiQBgyM4vhAIAAA==
X-CMS-MailID: 20210722055013epcas5p350d88f402bbe4c55f1f868dbb2decbaf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055013epcas5p350d88f402bbe4c55f1f868dbb2decbaf
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055013epcas5p350d88f402bbe4c55f1f868dbb2decbaf@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will subscribe the MGMT LE PHY Update
Complete event.
This event will come whenever the particular PHYs changed
either autonomously or as a response of set PHY property.
Upon receiving the event, it will notify the user by emitting
"Phy" property changed event.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 lib/mgmt.h    |  8 ++++++++
 src/adapter.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/device.c  |  7 +++++++
 src/device.h  |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321..4d2acb778 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1014,6 +1014,13 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_LE_PHY_UPDATE_COMPLETE	0x002f
+struct mgmt_ev_le_phy_update_complete {
+	struct mgmt_addr_info addr;
+	uint8_t status;
+	uint32_t phys;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1152,6 +1159,7 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"LE PHY Update Complete",				/* 0x002f */
 };
 
 static const char *mgmt_status[] = {
diff --git a/src/adapter.c b/src/adapter.c
index 5de92a570..f616879fd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9740,6 +9740,41 @@ static void phy_configuration_changed_callback(uint16_t index,
 					ADAPTER_INTERFACE, "PhyConfiguration");
 }
 
+static void le_phy_update_complete_callback(uint16_t index,
+					uint16_t length, const void *param,
+					void *user_data)
+{
+	const struct mgmt_ev_le_phy_update_complete *ev = param;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *device;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id, "Too small le phy update complete event");
+		return;
+	}
+
+	if (ev->status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id, "Failed to set le phy: %s (0x%02x)",
+						mgmt_errstr(ev->status), ev->status);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	DBG("hci%u device %s PHYs updated %u", index, addr, ev->phys);
+
+	device = btd_adapter_get_device(adapter, &ev->addr.bdaddr,
+								ev->addr.type);
+	if (!device) {
+		btd_error(adapter->dev_id,
+				"Unable to get device object for %s", addr);
+		return;
+	}
+
+	device_le_phy_updated(device, ev->phys);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9980,6 +10015,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						phy_configuration_changed_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_LE_PHY_UPDATE_COMPLETE,
+						adapter->dev_id,
+						le_phy_update_complete_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
diff --git a/src/device.c b/src/device.c
index 6f74989c7..4b11772b8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5684,6 +5684,13 @@ done:
 	}
 }
 
+void device_le_phy_updated(struct btd_device *dev, uint32_t phy)
+{
+	dev->pending_phys = false;
+
+	device_set_phy(dev, phy);
+}
+
 int device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
diff --git a/src/device.h b/src/device.h
index 4ae9abe0d..b3b32b231 100644
--- a/src/device.h
+++ b/src/device.h
@@ -154,6 +154,8 @@ int device_unblock(struct btd_device *device, gboolean silent,
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
 
+void device_le_phy_updated(struct btd_device *dev, uint32_t phy);
+
 int device_connect_le(struct btd_device *dev);
 
 typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
-- 
2.17.1

