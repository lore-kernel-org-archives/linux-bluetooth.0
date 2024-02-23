Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D07D417
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694124; cv=fail; b=pDN+KLBwr5/IOwose/x4gDAFTi1KmvZxmT74rH0QTHmhDvqrOtE6Xmn9N7bjUPMaDhJJ4x96RNdt7AC+v6YBMingz/T2k1c/gwb87qQGqkcM8rEm14yGA2DenLpI0PnewnTmMCXKzTCV71YZ+VhP7PbEiWYdoP/E4DWzP80mXB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694124; c=relaxed/simple;
	bh=D8wrtfuDP1AmNy1HYvdYQgfjMOhc9MervDSQQ6f8aH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ryjq69/YTYeZskJ3HYyNA28wLYV/m6ZYjHTQmu8Bb7aLGEtk21UDWyKj/YMum0pfMBIaVSrO6fsIuC7TfPnq7LCbMdTQ9BSdofMdn/rib2n0OtWaoRNopUW0Ygdjg33aaoxJKb+v1DXRm18iFySww1Ku+EZHMEJ8L3/oBAyZ/FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mv5Ku5s3; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mv5Ku5s3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAdn+ytZi/3z+xla3RQdqaSQ9nbvh6ltWKTf8uXq095PEtKkDauB4zCPoV8OdWGs0eEjjpbUeKvaPuGDHjtGzZULnXL0gF1lEfdgwcrtH3ky4PBdrjecvylymq4Y/7l4FsHXo/XIqVKPTdZVrAfjwZUxZvBdzTvX/IEsaQ1vzaSpjp6NM/Z7dxhPf95GPHn27uFLwBrmi3FetJ+rmYPsQBeDK43N/s77uMOlenWu2Ux96l0SUAUAVCfLyabHqviIRZpsfPA4p0wnwYmBxiLuGIvr/18dV0O/607bX6oZvxTQ/Ajt4lFpGppqH5w55TM4b7j/ovnIjevkhm1mPzHP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYmd0kNgcJNnAnJAQb0uBAZluiYGViFi/z8VJs6SsdQ=;
 b=BA8/RUEiEWNktdBRKtN7WdtBF/FBWP5qTlA49TjrzuIJ1nXNUn+B+6BzlVted8CPFn+mLAYbevKFNUVnSlLnG1+DtmyQDdcF32DsV605GXD/Ts/J7u9ynQeBujn7xqKLmT24tGZSbELN07fBuO2qR2ReLtIVdgyyhFHw7tntESi+bcYTnLF9WbkI38z2Vt+XpT7mrWSFNU/uVV5rlUW/0vZabOALNAeABio0Ky5xtYzqltZBZjf3l6DsPd8UAyn0hXM88ptvfCJIUrfMewBGvVga8lrGUrY9X3NpnW7wkIdd5r7jZg//SKHYRgSIXs474yTs1zfu4qmAVGdp0fbUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYmd0kNgcJNnAnJAQb0uBAZluiYGViFi/z8VJs6SsdQ=;
 b=Mv5Ku5s39EBYgRK4BtmTc0QWQJ3yNl8/H611hmiE3yiaLTbmPnefdTrzhZqH35FjhzJlGbR4FVaAio1PplQaMrtt51ut1b+VFWjulIYRn+r77RktpxY7rPGBotr8dsb4jolD+aDuRRg/PT80MjysGuNNk1AmybqhrlNYV5dyiiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:15:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 13:15:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [1/2] Bluetooth: ISO: Add hcon for listening bis sk
Date: Fri, 23 Feb 2024 15:14:41 +0200
Message-Id: <20240223131442.3077-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
References: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0039.eurprd09.prod.outlook.com
 (2603:10a6:802:1::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: f5715d11-dd31-4c6d-e78d-08dc34717b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5wVqCtCUSBKQkLsWHPpELCzafzIpdKd9bf1XDutK4udy9sM8abcVZZzODcoGGFJoO30ck2VaYXDqLbv8m6bpAbc+Y/QcpWA54rh9ZSm+nxoExrB4ko/52LSDDqJW/464cULBXzOrVqWl7mBJIblRfaKmLqdG4VbxOXl3sq42RN/dJTFQhZEGOZmHdIJpXerGAgaFbTs1e9whZDD4hfIE2wHzXriy/Ujyi6mfA2PO9rb/PI92x+U5bdC3/Yq34nRXpbeXkXy8abpS/fA5/aWpQAMtcrOv56pDZFXIEEjnjn1BhpxUm1XMfzRO6nHxnCy1ouUNqJFlqSIqKAvww8ipwdiAmQzjF8eGoyfvowqHzeJiRLz10JAQ4a0NxuYEGR8fJk5wocghIVUPsiwxrcsxgP9WxAAug3hmTqpkqnY8zd73odwR+gJpHsCfMhJDARRL/TOmLtECkr1yDnPCm4N3iMOeKX3d+T2AmSJb+3n3A9hMIVmS6yjiDVq2QLjX4Jx6JScLJhfrDfjOSruMD11mOfwxjSJY6pNLhlvagK0aGCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2zPQ8nl7USSPUNj+DIPlN2ZmU7+Ww+gKu7h5hCbnS6lBLMmb7YgMPl7vPnp?=
 =?us-ascii?Q?QN4LFz3S24sAksCzX6URozZxn5Ux2+5VNymM7Mt19UaqJxHX8hM6LAcYT0IU?=
 =?us-ascii?Q?0G46xDS2gzAF+Y/6AAjA3vmdR3yQDvC9vlf2FJqGb2P1vl4iwFw9wxRqk02A?=
 =?us-ascii?Q?33iX33VVE9imrBhMtashxAroeP5QinhwUVTNERNcfomXQ2zlOcFt0do5f8RR?=
 =?us-ascii?Q?TnMK4ag+QuV9+jKgXYdTENOTr/BUR0rQ2vkpM1RHARFAZLd9XUEUWQcWbg1r?=
 =?us-ascii?Q?rIPF4Il1Vf/2dvOwA+FxjijeAa8V5+YRGKRVbukaj1EbnnDrqs0j+KYvkttY?=
 =?us-ascii?Q?7rUWyNfchC4KI7LRIyk15q43JXfHFdUNRiapEqoha13WeJtxOe0TL0kd4Zzf?=
 =?us-ascii?Q?cNMi7ET8bV6Qn/4qHQMYYJaoC0j8lcBZSH4/pkwctrdHlFHFGX5oEZTgaxUF?=
 =?us-ascii?Q?HwD8yDEp4KpCIlKRTWGLsM8BxFnqshIyiPrQCwSfMgHizc3fYkTjqQRUL00u?=
 =?us-ascii?Q?1/oNQzbVUJazD6wEytSn+UGR9BmwsJpOZSaHsYPbFpzxc5RkueiuXXfiA6kg?=
 =?us-ascii?Q?hBlxnHaKsA8sXVKU3TjLeHTCfWGMye5EB51/exhKzmVpQITQkzJw0VodJNNz?=
 =?us-ascii?Q?aT5FOGBSsTEZbURnfdnkJ6Nr4BAmKPYAshHa84YKlmHVUc89QaWBjyxsSFDv?=
 =?us-ascii?Q?NngAaVSFvB8f1bq85ynXmm7DX0mmdNbs6+CdUckubFB1tNhN6QTDmp+b7Ajq?=
 =?us-ascii?Q?e9VHYo5FA9OhyDySjhxsKfbwEYfTzrAsHUoKBBmtceNI4CLmaVMKWJkIPW0N?=
 =?us-ascii?Q?+cB6gE1OfA77qmRnzxjBclVqvl/NV+fXX6QY/udwlT/VwpsVm0doQwpJGxsT?=
 =?us-ascii?Q?ex2HRs5ZbrI80ocpt6Pt3aq2etzI1VNd3++ff2a1pVwTgjLhOT+X5un9cQM1?=
 =?us-ascii?Q?quaVkoOhPy56p6Ev8gD+TNLvFXfv+vSsTcgOJaTFYUdNBXMAH7SaCu/ZxKOL?=
 =?us-ascii?Q?caYW7CVeoJkb+W/9a+xoDSFFATBMrSjMWM8R7oKl32b+NLTbH8KEYBEUXxQ8?=
 =?us-ascii?Q?hwvFTSeGMxQ3YCn8zHQSuXdQCqrm1NEDqZ+zUjeqwzq0zoFmaqsHYv7MPybD?=
 =?us-ascii?Q?b/EzTVfpeMnIz5Qv8kEXnc28sW2IhalAfFZkqL5h3I72mPeacW2cYkoRo9Rr?=
 =?us-ascii?Q?OdWGEwaYT1WwYyqUn6AZkPY2K/Ff21etp6l60HZzOyMxgcCtpyUfO0Tp7Dfh?=
 =?us-ascii?Q?uxozvtccgr9z1L64+3NHbqrTWC/xKqQWauGcSQh9N7s4qsi58Y/O0zINy3np?=
 =?us-ascii?Q?sKqYxm8+ZEOpuYQ0OfTdQZHepqh9L80YhTk3VFYVRqQP7E/7y8nGz7Ad1bvb?=
 =?us-ascii?Q?8ixbcvTiJcvOxaMmsAOBleA2+2Zquwjtm7wEHSkggtbguzYbTMF0SY8Ydy6e?=
 =?us-ascii?Q?LUQNJQlpseTfF2SGQhYa22ERhaBKMUXoZzVxKHdmB3qX7inO5r+D+SGr4JXY?=
 =?us-ascii?Q?Hunvl4bnwkPX3UDdbxCZ6Hbqr1wkliDyNQXXtMZnWWlHgs6HM4Hy5+Ak+nrz?=
 =?us-ascii?Q?s2UazxXRqSQpFpGORJJnjnpHkH47+QlNaVw7NI0b2Xojd+gd7uM6WG6ZNmlB?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5715d11-dd31-4c6d-e78d-08dc34717b5b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:15:18.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOIcKV2lb7iJWmYyKCtLbDZwvC+iqF4x8WcOQ2B5g/IlQCnfWNEh+CD6RCEv03tLNDqqPVGlbiICUdYZA3/ueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447

This creates a hcon instance at bis listen, before the PA sync
procedure is started.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  6 ++---
 net/bluetooth/hci_conn.c         | 32 ++++++++++++++++++++-----
 net/bluetooth/iso.c              | 41 ++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 317d495cfcf5..199a9f81cf50 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -1528,8 +1528,8 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, struct bt_iso_qos *qos,
 				 __u8 data_len, __u8 *data);
-int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid, struct bt_iso_qos *qos);
+struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
+		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1acc75a49bb0..193ef947ca47 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -2057,18 +2057,31 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 	return hci_update_passive_scan_sync(hdev);
 }
 
-int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid, struct bt_iso_qos *qos)
+struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
+				    __u8 dst_type, __u8 sid,
+				    struct bt_iso_qos *qos)
 {
 	struct hci_cp_le_pa_create_sync *cp;
+	struct hci_conn *conn;
+	int err;
 
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
+
+	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
+	if (!conn)
+		return ERR_PTR(-ENOMEM);
+
+	conn->iso_qos = *qos;
+	conn->state = BT_LISTEN;
+
+	hci_conn_hold(conn);
 
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp) {
 		hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-		return -ENOMEM;
+		hci_conn_drop(conn);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	cp->options = qos->bcast.options;
@@ -2080,7 +2093,14 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	cp->sync_cte_type = qos->bcast.sync_cte_type;
 
 	/* Queue start pa_create_sync and scan */
-	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
+	err = hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
+	if (err < 0) {
+		hci_conn_drop(conn);
+		kfree(cp);
+		return ERR_PTR(err);
+	}
+
+	return conn;
 }
 
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 04f6572d35f1..d9ee69fa1384 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -3,7 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
- * Copyright 2023 NXP
+ * Copyright 2023-2024 NXP
  */
 
 #include <linux/module.h>
@@ -690,11 +690,8 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 		iso_sock_kill(sk);
 	}
 
-	/* If listening socket stands for a PA sync connection,
-	 * properly disconnect the hcon and socket.
-	 */
-	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
-	    test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags)) {
+	/* If listening socket has a hcon, properly disconnect it */
+	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon) {
 		iso_sock_disconn(parent);
 		return;
 	}
@@ -1076,6 +1073,8 @@ static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
 	int err = 0;
+	struct iso_conn *conn;
+	struct hci_conn *hcon;
 
 	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &iso_pi(sk)->src,
 	       &iso_pi(sk)->dst, iso_pi(sk)->bc_sid);
@@ -1096,18 +1095,40 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	hci_dev_lock(hdev);
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
-	err = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
-				 le_addr_type(iso_pi(sk)->dst_type),
-				 iso_pi(sk)->bc_sid, &iso_pi(sk)->qos);
+	hcon = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
+				  le_addr_type(iso_pi(sk)->dst_type),
+				  iso_pi(sk)->bc_sid, &iso_pi(sk)->qos);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto unlock;
+	}
+
+	conn = iso_conn_add(hcon);
+	if (!conn) {
+		hci_conn_drop(hcon);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = iso_chan_add(conn, sk, NULL);
+	if (err) {
+		hci_conn_drop(hcon);
+		goto unlock;
+	}
 
 	hci_dev_put(hdev);
 
+unlock:
+	hci_dev_unlock(hdev);
 	return err;
 }
 
-- 
2.39.2

