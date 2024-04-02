Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2130.outbound.protection.outlook.com [40.107.15.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BF69944
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057985; cv=fail; b=CK7vecYCWgpGiDDA7a+1aKaYb6L2ZJR5UYVHz7vatyMnJxrj64wJWbAOMHViwSvzpaXs0FCe4MZU3q2jHN1sck/upwU7ZhnxApq4RfZquSo+4W3ej/7/iy242Z7gxDrCfMkX1URwtK9W4DHwcRNVhWBWs9Nlh9ULgmQ1BUaKVyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057985; c=relaxed/simple;
	bh=XzQbkpwy1R3gMOvSbgOk9LeL4rfwuOiwdOPN07k0xzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2kQEXUCwNqv2WA5bHzLIKQtHoWPnYfy9ppjvJno0zITlK6oI7GcwbVl1BvQdIlgjeK+c9TXDizZdTQSlOZn0VnPPiqJWIdvRLSewl/a6DnR2s098DLfM7Q5PLZTnb7hiPQ5294p0zLVS9vI0w82y9aHYc2lhtTDz+JFKh5ZwXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VgBlZBnl; arc=fail smtp.client-ip=40.107.15.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VgBlZBnl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWeYXW9WyP6AH7FC+t1AdUKVHYdBA7H7QuJ9mT4tF8ggmWclErqTk6oFUNMKb1TjcYKN/UnTANFskUeLcSWuiPyD969+Iefc6ZciASjscfuIBhZ4azthlsVOS+sxoU9K7qr7a1i+PxvWtLqCvNqrLsRVslPq/c1PmChr3JGbtpJPxsC4W2XOoAwjhcu1/xxUlt2unHevkjs5zJShfNmMCedj6niBeykrwxIICWDVr/GKqvKmid1pR8dT1aIVc5lvCirKc/WCD8HpYycj04TglxlRMLTlkF07nVeJAnosAAIZnWHmSFrJ3ZnXZCQ92J2ELcm0Jzsq3OkBqsmaSVbP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psv5Pon1KE9xEjFe/9e3dq7dfDkzhfjPF8fbEcv/Xmo=;
 b=Zufa++bTuEx8VqroMB/3nFDPdHmVzkZRVoKDWZ36b6cCeyioUbrW2gbUFpZ//IfHnBWe1TZ2m9h0Sj9UjeriGTZLpKCD+sgseW5NLaBwUgHiIpKGV45l4p8kwrqETVJOS7YzoXwb/2SB1r86l62QqEtRyexKliQDVT9a0/zuV9jcE4gnapRsqivHUnmwFnhKa+wjowQF/TXeKFw0bnTJ43XJVIPC9BD0f9H1fZdDRx0XXdjNHLzi/TUlKRQSMMIEw8Vf71WyhGxHEdBhshw6m2WOvHmI4Oo7Yd5PCPWaZgHq+0ZnhI5M49leKAFLpldEaeyFbRRHw/UZeQhtgCX/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psv5Pon1KE9xEjFe/9e3dq7dfDkzhfjPF8fbEcv/Xmo=;
 b=VgBlZBnlU8a2g4TZuupLoDwnFR476KgpWkb5Y1pkY1hjm8DKTnhBRDlSaZCO473szqp6wN+IYeNm4g4j/chyw9GDl3Ca29EAhBkxtUBt/aQwYDeaNXG4Po7soS9PCPBRY/waT/5haQ+KEfyE6ZxluBBPwvzgaYDHjR4bcw/Kjj8=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:39:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:39:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated
Date: Tue,  2 Apr 2024 14:39:31 +0300
Message-Id: <20240402113931.3164-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
References: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0258.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Bix3NfUk7tonOSu8Pu5E9EdhOlVU2v6wvShYOLt5iCn1xuumPGOTdPy+A782HHHR/wczM0D/cDjHO4TAawFPgkcaI3/Foc2Nx3qvnm6dHVQDz5cipuo/TCOxLVy+y0CtaQNFTdF7HKWCYK2cPuGKvn6nhttkdtKb6WJ5KWlqlMHwrgw3hdZqQZx0+l+Lq4VUIF4MUQL45re9+bM3EA/CEochmOvxvkmKhLf26RpGPm7udQljtrifAkcLj3P1deAqzj1dHzHhcjchysdPsjXN6GNrJv/fmvKcc16Z4NILBRB7PdzKyu+k/BeaAOQCK2uSLUqXT3WH19PpQAgfa2TWlMmC4QNCei+C8Yx8FfJUBDlFyK1CIFMb95RQfkPAZ/HqUal2ouQ5WAgOrIIIMHv2LMx3KtDB7k/PbxcX3jOdhsFSd+2eAw7elqkODeS+TN/DvcZlDX55Ouv3grlm6bcMXCl37M9GFey3WGANrUww+BgCtrgI44q8BVTCPkrHOGgnJ8OloT88/VZWgqGqT1rvpeXzlUhkJQP0iPEd6NfGCXNsFO47z/0I50TZRvgOIaS2TZFXHdVKwBQfheUDKHR1eGEUXuaYfy4icQu/DFMhxr73yrXIl0yVWeBnKsGXSw/td1QNXZ+iI2ijnTwL+zOxedPVvj3DvBg41+jawJdpCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4g1kBAdev99nLQfHIszY+p5h+h8o4uR+4jeRfWd5qQowID/SNmRnFtniltmH?=
 =?us-ascii?Q?YLae7me/CRpFXMleK9Komhx6RNsAPzPC0hLh4AAxM958EE4zq4gjUE3tYjbq?=
 =?us-ascii?Q?TKaJEGD8qlXMH9pH/SW42+hjOrY/tq7PSDjYyg0eJDZS8JR8VxMLH8eNRYdD?=
 =?us-ascii?Q?o/uyZSvesqJ16+C41JYDQo8iItUBxRCJVc6AmVc6o3RBisLt1kuUuDDyy3By?=
 =?us-ascii?Q?EHtTk782c8IaR0GQodZBzLPxPx1wuGSkcfJ4aRkhLbkNu9w+RHvkUDxvKytU?=
 =?us-ascii?Q?IdRAhnJJdKW77UEoFnZcCQxdiM4yQePaQzr+ERiXVsFfD6cpxgOhOCIVSgZ1?=
 =?us-ascii?Q?epTl/ff9VTuEwihNgalTcMkK/T7io85sIsJbDvRKi5c4+rJ/dnXcgHf83arx?=
 =?us-ascii?Q?f1HDPSLxaBM5BYlgt2yf+aXENd4KiSKXvkW2EEQRBvIFzwkGuuoEcdXYnDkt?=
 =?us-ascii?Q?LptEQpccHzbTM9Me1WuIlqRJLeykia1Q2rqtlzri67R4/F0B+nU5Q22WuWGU?=
 =?us-ascii?Q?6hg4x28RfBLStdozvzKDly/PkMXcCkwukoVgVU71ofKb4d3mefgswOdL4Uxk?=
 =?us-ascii?Q?w+KCgi3d+R7BE42Z+wZWT6XC7EzV4uk/CLsMhGXKnHlXE+AKZUSnTopbZLKK?=
 =?us-ascii?Q?AkprxAm+PXij55OEiQjXVCnsHx0JcGNrconRqhU8peq3oaC2CaSjfy1XG67/?=
 =?us-ascii?Q?XsIn/2ULmzmWpeVztiD3V/1/AtPzXUeMeWAq6ngzpJPQ+eNPB+ZnKOShJbAT?=
 =?us-ascii?Q?RPc2OEH27AeIfY0tFMEn8PVw4Hw0q5u4b40RG+XQCXJNkjWbJMh87WeOlsc8?=
 =?us-ascii?Q?tcrIACGNRgwpvezQwZ6qC2BPq0u63XSp4Qk+A65VMi9FeyoaiVNhezNuCXsD?=
 =?us-ascii?Q?Qe+7Vcf6xLeTuUFc1vrPLmAgR1+IqQNIOl5h6L9AcLRbgjBRYhYNP60aWneu?=
 =?us-ascii?Q?E8MxfB5NNTDiVOEr8RkvSuB5uXh05U8QArkFVx4xXJS60sEx+DlgWnOC6Ggu?=
 =?us-ascii?Q?9jmIfnv6ysSUFhCro8czMhxXmINLtPkaW5jsc0/FaUMKrD9jOWKW70cm6JdL?=
 =?us-ascii?Q?yyL7doN1aoIfFgs1F7YUuWYh9BTq9I8ZK4eNzfs11+4PhHU1wf82B1GnQ0jr?=
 =?us-ascii?Q?leRDv2kqxstqWqYpx7ojAePVXLFMMOdCZUmBRp2FYUKSnLkMdflE0r92MxE6?=
 =?us-ascii?Q?guEIQYwBUtvV0agMjfouqgJyYOFyXxQwSH7/15fuE+Hbe0sMwaIClwWg9lnn?=
 =?us-ascii?Q?EguixXvfepCR+QuIs7FCoi9Zn/oZQgaWBNxPq+cXc57Hi2s8O6aRqTNkl/Q8?=
 =?us-ascii?Q?CpLgD8rHgfvvClwcSqq9NXfQ44CN9dYgslg5dz6bGNF2B3npFSOWa0GvQ/uI?=
 =?us-ascii?Q?NYdaXS7gXTFoe+EwOgzFfN8sDFJPteZNKs2HPpMsO4QjTD1oYaPcO8G+4jzD?=
 =?us-ascii?Q?Yt50rX0AdNJQbn85cfspyyU+RCm6gO9GMFTLTqV9zek1Gf9IUuzI7Rv8GryV?=
 =?us-ascii?Q?ut+OC2t4+ioZxVeblOhSO13ZS0lm+AgHIJDfFbIMpUJzSnM4Xgk9nHgqSTuF?=
 =?us-ascii?Q?aiObcyzc82XGvE3K8/+no+j7HObTw4vEBt9Xf4anB6c4wt3Um0zdoMPWLHEi?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f265d04e-52e8-4fc0-98c2-08dc53099627
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:39:41.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g29Ev5AlUS54TIaNG0Xuc78/OCDL3FyLdhPa/JlA3OSVC0ossvVLmp7ylKLbyAp8+5wO6tJvYdZRUWySnXusSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

In case of a Broadcast Source that has PA enabled but no active BIG,
a Broadcast Sink needs to establish PA sync and parse BASE from PA
reports.

This commit moves the allocation of a PA sync hcon from the BIGInfo
advertising report event to the PA sync established event. After the
first complete PA report, the hcon is notified to the ISO layer. A
child socket is allocated and enqueued in the parent's accept queue.

BIGInfo reports also need to be processed, to extract the encryption
field and inform userspace. After the first BIGInfo report is received,
the PA sync hcon is notified again to the ISO layer. Since a socket will
be found this time, the socket state will transition to BT_CONNECTED and
the userspace will be woken up using sk_state_change.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  3 +-
 net/bluetooth/hci_event.c        | 58 +++++++++++---------
 net/bluetooth/iso.c              | 94 ++++++++++++++------------------
 3 files changed, 74 insertions(+), 81 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90ddbf88ed9f..fd6fd4029452 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1379,8 +1379,7 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK ||
-			!test_bit(HCI_CONN_PA_SYNC, &c->flags))
+		if (c->type != ISO_LINK)
 			continue;
 
 		if (c->sync_handle == sync_handle) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4220c80c1c4e..868ffccff773 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -6498,14 +6498,16 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	if (!(flags & HCI_PROTO_DEFER))
 		goto unlock;
 
-	if (ev->status) {
-		/* Add connection to indicate the failed PA sync event */
-		pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
-					     HCI_ROLE_SLAVE);
+	/* Add connection to indicate PA sync event */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
 
-		if (!pa_sync)
-			goto unlock;
+	if (!pa_sync)
+		goto unlock;
+
+	pa_sync->sync_handle = le16_to_cpu(ev->handle);
 
+	if (ev->status) {
 		set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
 
 		/* Notify iso layer */
@@ -6522,6 +6524,7 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_per_adv_report *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
+	struct hci_conn *pa_sync;
 
 	bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
 
@@ -6529,8 +6532,28 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
 	if (!(mask & HCI_LM_ACCEPT))
-		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
 
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	pa_sync = hci_conn_hash_lookup_pa_sync_handle
+			(hdev,
+			le16_to_cpu(ev->sync_handle));
+
+	if (!pa_sync)
+		goto unlock;
+
+	if (ev->data_status == LE_PA_DATA_COMPLETE &&
+	    !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
+		/* Notify iso layer */
+		hci_connect_cfm(pa_sync, 0);
+
+		/* Notify MGMT layer */
+		mgmt_device_connected(hdev, pa_sync, NULL, 0);
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -7063,10 +7086,8 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT)) {
-		hci_le_pa_term_sync(hdev, ev->sync_handle);
+	if (!(mask & HCI_LM_ACCEPT))
 		goto unlock;
-	}
 
 	if (!(flags & HCI_PROTO_DEFER))
 		goto unlock;
@@ -7075,24 +7096,11 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 			(hdev,
 			le16_to_cpu(ev->sync_handle));
 
-	if (pa_sync)
-		goto unlock;
-
-	/* Add connection to indicate the PA sync event */
-	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
-				     HCI_ROLE_SLAVE);
-
 	if (!pa_sync)
 		goto unlock;
 
-	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
-	set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags);
-
 	/* Notify iso layer */
-	hci_connect_cfm(pa_sync, 0x00);
-
-	/* Notify MGMT layer */
-	mgmt_device_connected(hdev, pa_sync, NULL, 0);
+	hci_connect_cfm(pa_sync, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3fcaef506bde..73aea27d8498 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -54,7 +54,6 @@ static void iso_sock_kill(struct sock *sk);
 enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
-	BT_SK_PA_SYNC_TERM,
 };
 
 struct iso_pinfo {
@@ -81,6 +80,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
+static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
 
 typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
@@ -197,21 +197,10 @@ static void iso_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
-static bool iso_match_conn_sync_handle(struct sock *sk, void *data)
-{
-	struct hci_conn *hcon = data;
-
-	if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
-		return false;
-
-	return hcon->sync_handle == iso_pi(sk)->sync_handle;
-}
-
 static void iso_conn_del(struct hci_conn *hcon, int err)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
-	struct sock *parent;
 
 	if (!conn)
 		return;
@@ -227,26 +216,6 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	if (sk) {
 		lock_sock(sk);
-
-		/* While a PA sync hcon is in the process of closing,
-		 * mark parent socket with a flag, so that any residual
-		 * BIGInfo adv reports that arrive before PA sync is
-		 * terminated are not processed anymore.
-		 */
-		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-			parent = iso_get_sock(&hcon->src,
-					      &hcon->dst,
-					      BT_LISTEN,
-					      iso_match_conn_sync_handle,
-					      hcon);
-
-			if (parent) {
-				set_bit(BT_SK_PA_SYNC_TERM,
-					&iso_pi(parent)->flags);
-				sock_put(parent);
-			}
-		}
-
 		iso_sock_clear_timer(sk);
 		iso_chan_del(sk, err);
 		release_sock(sk);
@@ -863,6 +832,7 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
 	iso_pi(sk)->qos = default_qos;
+	iso_pi(sk)->sync_handle = -1;
 
 	bt_sock_link(&iso_sk_list, sk);
 	return sk;
@@ -910,7 +880,6 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 		return -EINVAL;
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
-	iso_pi(sk)->sync_handle = -1;
 
 	if (sa->iso_bc->bc_sid > 0x0f)
 		return -EINVAL;
@@ -987,7 +956,8 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 	/* Allow the user to bind a PA sync socket to a number
 	 * of BISes to sync to.
 	 */
-	if (sk->sk_state == BT_CONNECT2 &&
+	if ((sk->sk_state == BT_CONNECT2 ||
+	     sk->sk_state == BT_CONNECTED) &&
 	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
 		err = iso_sock_bind_pa_sk(sk, sa, addr_len);
 		goto done;
@@ -1412,6 +1382,16 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			}
 			release_sock(sk);
 			return 0;
+		case BT_CONNECTED:
+			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+				iso_conn_big_sync(sk);
+				sk->sk_state = BT_LISTEN;
+				release_sock(sk);
+				return 0;
+			}
+
+			release_sock(sk);
+			break;
 		case BT_CONNECT:
 			release_sock(sk);
 			return iso_connect_cis(sk);
@@ -1559,7 +1539,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	case BT_ISO_QOS:
 		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
-		    sk->sk_state != BT_CONNECT2) {
+		    sk->sk_state != BT_CONNECT2 &&
+		    (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags) ||
+		    sk->sk_state != BT_CONNECTED)) {
 			err = -EINVAL;
 			break;
 		}
@@ -1790,7 +1772,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct sock *sk = conn->sk;
 	struct hci_ev_le_big_sync_estabilished *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
-	struct hci_evt_le_big_info_adv_report *ev3 = NULL;
+	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
@@ -1827,12 +1809,12 @@ static void iso_conn_ready(struct iso_conn *conn)
 						      iso_match_sid, ev2);
 		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
 			ev3 = hci_recv_event_data(hcon->hdev,
-						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
+						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
 				parent = iso_get_sock(&hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
-						      iso_match_sync_handle,
+						      iso_match_sync_handle_pa_report,
 						      ev3);
 		}
 
@@ -1875,7 +1857,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		if (ev3) {
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
-			iso_pi(sk)->qos.bcast.encryption = ev3->encryption;
 			hcon->iso_qos = iso_pi(sk)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1969,26 +1950,29 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
-		/* Try to get PA sync listening socket, if it exists */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
-				  iso_match_pa_sync_flag, NULL);
-
-		if (!sk) {
-			sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
-					  iso_match_sync_handle, ev2);
-
-			/* If PA Sync is in process of terminating,
-			 * do not handle any more BIGInfo adv reports.
-			 */
-
-			if (sk && test_bit(BT_SK_PA_SYNC_TERM,
-					   &iso_pi(sk)->flags))
-				return 0;
+		/* Check if BIGInfo report has already been handled */
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+				  iso_match_sync_handle, ev2);
+		if (sk) {
+			sock_put(sk);
+			sk = NULL;
+			goto done;
 		}
 
+		/* Try to get PA sync socket, if it exists */
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECT2,
+				  iso_match_sync_handle, ev2);
+		if (!sk)
+			sk = iso_get_sock(&hdev->bdaddr, bdaddr,
+					  BT_LISTEN,
+					  iso_match_sync_handle,
+					  ev2);
+
 		if (sk) {
 			int err;
 
+			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
+
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
@@ -2007,6 +1991,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				}
 			}
 		}
+
+		goto done;
 	}
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
-- 
2.39.2

