Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1383CC1
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263139; cv=fail; b=FR8fquJsWkc59VL/3DtEd//jNVE2Sib4WAndsjQpel7sa8GY8ph4V7qJIJAgtzG/GScXyMzV9go1nPbs7WcDUL93vTGjeTZeJntPW5qVw/LOJhE1rr+TF5f+PIFT0x0PnKM+m34qu9wTG9aCsMX933MjWoHMeKsyTwApdjy+fyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263139; c=relaxed/simple;
	bh=AEfuS1FW1X5hPKfT8mgOJ0NZZWuL4adZA9s6K7qbjxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXczqt63KJLKbbVG1IZVqeyyuZnDbe/3k/DqBYwaT8aaLez6f+gOv7RPaY1g3+oYMyDhKDP2Ya80pPZyiezj+nkV+5/s6i+OnAMMkFcDZ9qIi/WpXr75t9PPSERHOikovq+gulFvdLSSENr8vOWlJctx+sP0Lhw4+AqlnOuTO+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RIbhi4EM; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RIbhi4EM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4YHXtxUV2yPTqonUYpNuoiIXJbzcqhzTc0ckKTcDAhIE/S2xRxvA92krscSswzzwfhpsj4Jd42YK/0MYSHemN1/qC0HaogrQhv/VD7NO+Kxv0PuwqaZbWppE2rWlQS/UQDhyysx4Ga/guEnRSgnDNHg3+dEMWfyH5AYZoRzwOdmhuQSh1YRYT2A/q9FXxGro8IB1AUKeUlJILVT3efEQsrq0VeNu17lp/4TrkJ5ei4IevkUU9/Brkizd/V8BWWxV5aLonSGIQq6M68lhtQBxAg41kZUFx4CXhaGxtSOHDPTdt8ZW4EUjkt+vt1ozo8ZX1d+gYuHD5q0tX4n11qS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ys24QNCjDKMobW1lFmEUKDCj3xGE33elVgGbKrANKI=;
 b=FD8xugioekdPX8q1Y43nYHcU7Nh+WtAMsaei85WUJw6Ox6cEHXgSDSSWsTQZBf0IeoepBWghtNKBrgVWclgKWKTLKEImH3WOkyZ9PKJOWX7VVnRuHjqBEgJLy+AhVzDqtr+soqHBn6zhjIiSnJOf9Hokffkh4XmGLT1MMJO/pLpLL/IVoRUnPCqQdoqdGZSM9SDqLL4Xgc2sz1BXUdVNBt3z6hBmIrNiP6ctl9YIO52a8+KQQR+yNDXGCXtExDLVnr7PZQhZnEZBoM2pluoNcAYQOv+2tTU529QxSxK5vgFop7AEirv2gGYyAIR+WUKz0REr57U06UxODwrRMBMJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ys24QNCjDKMobW1lFmEUKDCj3xGE33elVgGbKrANKI=;
 b=RIbhi4EM+v5C5HL4xZ7IdIi4h2USRnkIgeKiEBeWCOXegLeiQBv13b7el8lbMEgLAjfw8pUayhL0y1//dpFWfSIPU2qVkKqi9D6PjFaetJLwBqlzEkfonWMrNnGXcg50iN18DVNCUFvjcZuJFlrFJinJD6G/Lstdg7+f17HzxdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 10:25:30 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:25:30 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
Date: Tue, 16 Apr 2024 13:25:01 +0300
Message-Id: <20240416102501.42996-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416102501.42996-1-vlad.pruteanu@nxp.com>
References: <20240416102501.42996-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GVXPR04MB10518:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4ef346-d583-43e5-ef00-08dc5dff8aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	km5MaVTEr3fMCsbHwJOPyyxyID4PDEwHZskwRMLALqwjvqLjEbNcA3A+7j81ATDjh5ika8xbkCOmVsOvFNSZazGZVC/OKQthNiAM71MBD/qNhz2eGkCutv48Rc1OBdtDz88XZPglCIp58ZVaTB19bA66ojjPHQS/mp/8kicQqPJB9iXDKibp8SjUGGKEGTDewXyJFtb0tZ6tZOx31dlRGxCv6hwVR4K9ZAv8QJXY9qVpD7R0rHF48ijr+BaIY9PHYGXMUpH0eqK4/jeQPY6n9p5TC4StpHNgVEWj9f8fLbY8Zno7aOGKppwrW5IJjp16OF7DqDcXtCafRl9zFmIB1UuIJalQcBBWVbxgzUjzrxGI2p+lPAdND4C5UcxtcSxd91usOqp6kI6/TSFcbMlQiZE0KEC9SHwQnN886DSceSdOZmHMUfDvZuTQlgYfQz9OgeovdkK4tyCRMnmJTgCSPTprSomy44lK3PEfOl9WOb99kJn1QGgQlVg8TEUGfi3DSNMgywWlpQbgTa5vYz9oMQYxGJQ9pNwV8RMR8UQuMs+CAsCVKUT9xzL/WB69SsqUKvz4RUGli55Co3B1WbX+wluX6lvjZ97qhz8fwMtROjY9izFOBLY+GvJ2OazDr6ZmiT0jOA9rx6aWUS/V1WcpWkGuxTMvPuPgk7M13YSihS2KxoCJpiXjfVAECZCtcQw7WUOnkqwAeyVvqdN1tvTbknAOzhJUDnvR20AXpHsUh4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMq39Sc9wR79KD+pXl2x2UTb1mEhegK5elRuKxda8AECajDo1v5SV/4WlYdP?=
 =?us-ascii?Q?4Nb+6j/npgHsIJF6FLptbiFhRGRuNTFhvvc9CQrzg4QQKN3YP6XHt2DQSqDO?=
 =?us-ascii?Q?OnTwdFN5wBUV1/62BNh0QnhR7qSqz6wOnGZc1AFM+t8s03DBvv7VzLuTaAJ6?=
 =?us-ascii?Q?7t33N4pPJNIRVhVeV/BpFZXDTGDt8RUPFUiNAjhSIzuB6ql2rcVI9cN8AGqy?=
 =?us-ascii?Q?CaHvVQDcU6MjHbWlkSJMAnNFIX0ivd7wQNMQOr/gAfnHCL/vr/gkqTX2tBKQ?=
 =?us-ascii?Q?fiLseFd/s6wTIwSVu7CNjYuOybIH1DpT8ijVBmXVicydyOSY9Sd1eKCZe4u2?=
 =?us-ascii?Q?1S1bUjfjmmmuap62f/uUgmQCdpsMtE8xmHx7hJ56OObXyF/vLlfoRtXbYzS8?=
 =?us-ascii?Q?R0hXQyO9QllUDdACXN4bURt7V7I2egM72DpKc5fYg1+fv3md5zzcJ39bnS/B?=
 =?us-ascii?Q?ZlurqiRBlDpsXmY2rQnSZVQqkKXcuU+VPq0lCAuPuD6MtkaiFBr+U3CZlbVT?=
 =?us-ascii?Q?0dCNy3pXv56Rq3rCUtpsWUNfcUWybl+jnlltwUunPZUUjOi5bkQFsQ6KNiOV?=
 =?us-ascii?Q?87nFwxAliWYgX09ap2qCPQEvnJV4dsPUVf+tZ2oLz7p9VFO8ZLRnl7TJ6MMH?=
 =?us-ascii?Q?REnmbrFF4HIqDK2bB2F3l+aJS9SvQVLP1mj+BsQAJXNibGJbVx77G+4qeaW3?=
 =?us-ascii?Q?hatcBbeECXRZ/Y9qDOAQvOMrtX5rqOjZU775uaDGEP69kG5RQSy229hN9HEj?=
 =?us-ascii?Q?X4mMd0duLDwhczPKNJdfUOM2SsMDlmRO8JUwPkkAGfxmFZDoEqRlvPqDiXyI?=
 =?us-ascii?Q?TAtyYOdimxAuPANf0gaJ59xvTYyF9VI72vNpNHG4d/dJlttncQGkCgmRoaFy?=
 =?us-ascii?Q?NGcVH8zMLOSlsXhGFYFjomVIYZkcoygVIF46RhKSrLpqgC58KyzsiCUq0cTD?=
 =?us-ascii?Q?z3y/2Zv4mGgQDYecLF/CHMezA+30b5+jFeChsDnNdEF5elYQxLNNbfmjDtjk?=
 =?us-ascii?Q?y5GQ/sqTUxBIYzqw75I1GAx6PNB6dVB94oaIE//vxn8r37JNbzlcb45OKtDL?=
 =?us-ascii?Q?d7v9v5Z5F/GoM3npPqsaCUYCta5jIF4Mfh/U5ihFK7VDPfMBz0QCOlsF9dtM?=
 =?us-ascii?Q?1VAIV+VRPfcWyTzRbHgYQgocDDGBHomG1RV/JYn3Svs1teYolcXrSjKLX4Fk?=
 =?us-ascii?Q?ed5uP6M0fej1kDK5DofN2QiUC7ghAhPeIMxmZxtbxYUqpdtKnnV+lKyil6qS?=
 =?us-ascii?Q?VRdX22KgYOVbq3fYs1mNua9GUZvsjgoz4xivoRGUjFdwcLyTRdoNgRUty2Xj?=
 =?us-ascii?Q?bduxVT1TvSVM4J/DAtD2xMGJgOMZZw8Lpf84LwROIA6GlWxJh33P0PSRfpRC?=
 =?us-ascii?Q?NFx6o6y7wJfaRgJ5sna8dUXI/tC7aI6dth7SCTnzVlIhnazTfE/XYUc4AI3x?=
 =?us-ascii?Q?bxFbNEGumwNx9yIO8FNjDrDFNZtekeCjnKax5Waf+w6ODgum/s+fHmBwnCa1?=
 =?us-ascii?Q?rECIuLc9snfeYWZ/sJmNDwR7mCZ0RBI4oOarnqUwQ+988HDibRP29mi4/FDf?=
 =?us-ascii?Q?Gs+jSd/Uy543sxfK+ywisYKJ2OLKpKa+7FiSmvx3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4ef346-d583-43e5-ef00-08dc5dff8aa3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:25:30.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpg4iktyG81U2D01Ax8+MHkwb3ZozkPUbjdb0CtIvAGSO9kz/9vkg+NvDLEt2Tq4SnERZ1lVdUPndH3s51y3iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518

The latency parameter of the broadcast qos is calculated wrongly.

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G

For framed PDUs:
Transport_Latency_BIG = BIG_Sync_Delay + PTO x (NSE / BN -
IRC) * ISO_Interval + ISO_Interval + SDU_Interval

For unframed PDUs:
Transport_Latency = BIG_Sync_Delay + (PTO x (NSE / BN - IRC) +
1) x ISO_Interval - SDU_Interval

For broadcast sink the latency should be taken directly from the
BIG Sync Established event and for the source it should be taken
from the Create BIG Complete event.

The interval parameter of the broadcast qos reffers to the SDU
Interval and shouldn't be set based on the latency. The Host will
read this value from the BASE.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_event.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 868ffccff773..dff4bedc3e9b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6983,6 +6983,8 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 
 		if (!ev->status) {
 			conn->state = BT_CONNECTED;
+			conn->iso_qos.bcast.out.latency =
+				DIV_ROUND_CLOSEST(get_unaligned_le24(ev->transport_delay), 1000);
 			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
 			rcu_read_unlock();
 			hci_debugfs_create_conn(conn);
@@ -7029,7 +7031,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
-		__le32 interval;
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
@@ -7044,11 +7045,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
 
 		bis->iso_qos.bcast.big = ev->handle;
-		memset(&interval, 0, sizeof(interval));
-		memcpy(&interval, ev->latency, sizeof(ev->latency));
-		bis->iso_qos.bcast.in.interval = le32_to_cpu(interval);
-		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
-		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+		/* Convert Transport Latency (us) to Latency (msec) */
+		bis->iso_qos.bcast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->latency),
+					  1000);
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		if (!ev->status) {
-- 
2.40.1

