Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB629BD90;
	Wed, 25 Feb 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039280; cv=fail; b=GHpcLXXLL/4fn+JEqhNJ8GBMf+lCYTneGwiGdSm9EjEBTYtaK+cuTOtYSDy1xMJ/Y37vvKFFwtPo7/0Ju/C3G+6V1ikGSxAHuhMcxKLM6EGX67KGnzcJLtJ+UFxeLFmUvaCA6hOTD1s1BhGDIPytE2sl9I6UEqURIAaKBxOjy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039280; c=relaxed/simple;
	bh=bOz8U/B6HUS5ENRlDAewYChClisxT0+29YwrK4Qnymk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc3McdtB6ddgMlTGCe4DecCh8/6A9YAKAA9kvBx2KKU2bQ8VwRRu5g+Rt3g1kNwp5dbCwgtSWEcN8Jhkmk8Y++doUhdSLOXwwybEVFTII9IAM/t77gWTpTcebsGvAInAMKK9UvgJTlHAMsrHRfwtqLa9bBev+QtMdXap0hKxgXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=p+0+k3hl; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="p+0+k3hl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpJINiHDaoz2ldv2NJbn8Pg8Zu+7hruKpi+mPRgn+baqDR+DcWGfdTJRPXWEuPLJ6UEaIK0SahZMnctuM1zqT6yEqwZQe+/Np80zzAFur0inA8C2ni/7/vscgkZRjrGdWiww9nSLK/CLsDI0ItFPstRxpKO/4uqZ2Lsfxg69ZtYmIXYfAIsWz2KSsV+99pJf6/AlBW0uS1nWx+mA0EdM0APQzXr/SMqt8ITi7B3L+naP+r6trB73x98jCPH3GfBYaEDLBZtaebgPuwiwrhsPL2BrrCTwdBM+m4WUpGkxX2ZT1TqHiGisgu+YNgWJH7ka8RnVTZjQVgbCzQkTaV59mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cvy13Z/P9sCIjr2cF0VMx/NWTJMzeg0H+lvqcvC3ZiU=;
 b=QeoIx56Hvgz1UzCSKnyZq1CAT23n3UsPBATpPhDhckqLmO1QPeZBLVc2IvxySfmtCDDvRqmLDR1lNoKOXiQtEdbcGAYRVnwOB7vVwVTiX2xeuzfvgn8QUKpiX7i0UTCHj+IznMuOrw6Sdlbho9x01G3RZQNFGEYKcj/WNhyXAXAMTwd/MuxOZgr6UitH/Ig38ND6ZfMLcRUF3bkyJwomHJPBpA79HKLUO+F0ZMaO+PdmBazyqwSc9AcrQKBg1mYDZtJd78ok9MlWTCp2PX07a/rVKWJq90/5He78PkS1vtuZhdte1lNlHd/u8zLqB0IblljhCyp+6oxb+Y1rULvJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvy13Z/P9sCIjr2cF0VMx/NWTJMzeg0H+lvqcvC3ZiU=;
 b=p+0+k3hlbvGFX9Cnp/a++JGoUeqKNn/wkP3DLdsgZbei0e+noOR89KBtMl/eAHp7tfYNi+F39rPbZCO1kjKrMXG9iTxu/oYT69iIBz57t/oO8gIDqM3drkpIN72FOIH/JqKQhczEBEFhU1om6+FcX/gg63MGqwd98z6CjvTVgw0=
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by DU4PR03MB11215.eurprd03.prod.outlook.com (2603:10a6:10:642::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 17:07:53 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::5b) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 17:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:07:52 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 18:07:52 +0100
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>
Subject: [PATCH 2/4] Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS
Date: Wed, 25 Feb 2026 18:07:26 +0100
Message-ID: <20260225170728.30327-2-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225170728.30327-1-ceggers@arri.de>
References: <20260225170728.30327-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|DU4PR03MB11215:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8c79b9-34bb-4f56-fa22-08de74906985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	V/s1pr42fSnwGx0zybRn1XM3ZJcGtNk0viABS4WZSu5rY3VKkvAntKWExtA9lC+gidBOKs6EwCtyWS77Pbq5YBAeiO5qBHTb/27v9QgiIkrjqXhIsPBtc6sQEhBTYY2pjReziOiCNGob3nt5ZQDSYp/xRZ1NaQuf25h3MkcYMb9JYOy1jPn10yFAggwwbhFCug6tsbUko/ofBAKt7WW5g2AezL9umW2Olyh+P0OMnKo14YVsHlFhClE0sAZShtTHaeR+mzmKjaWXMraDo6GsXfNaQKiadqNFC/Pm0hxXdunGAT5Pi1Rro6aCADgH4pyYCFLMH4UL6js6vNSpsxjLhjyGFLom2BHrdpsV3MkXk8kIo3kYlMMvFRjwoeC+UP1n22TTXWaeqGUj9MTmKr460gZQtONV4UOzsMPZEcJlXa7DnT3o0e/j8eEHfLihP6aqJ+I3/2Ko8Ujn6uTX4EBp06cL/RS/kfe6y4g0EomCwlABI5zKg2/g4eF65xzXG121YPoHHFAC0CHZhmBot3M0ub7LsGqX2W3j/nhrTLmsREatTBo5o5qquFFPzL8vQsGda9ZNPoH1nmMecfVxCHyGbsfZyZBNw5Qk9rKOflfzRytALJufw8IWKN8BoGBoO/uCwtI2eONgkgN8fO6h1ldrmk9S/0PgAGSok28ZlR4NY8tmIheRUzbnahCaCVNVDrR8yom7Npb9g1lS4OxmwWnMHos5Pr9fJRCFd+9BcW6rVTl/Ku0x1NYDqCNh/rtDw5CC4LDZCrNUXTOzq0CS+yMe5yYB+8uKK1tfUbxQGTNN4wM+kqKlC0BzQQoJdWGOlmFhtw4d4zlf0OjEoiPYReDjTw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	can9pUMg0nWJH6psQm3cE/+3yEh+W9+NUuxkkmajdrOUGB3g6+RzzbJvcErMbp06BwXAy4DUdPPRLLwIGjo3U8lEc2KcaWgUrv/EcaVO3nnBOKna+T+6x/wPVXkf17P+bJeTlswXRZILNNHnEEhGd+6qgVnfmBPPlOLMkyMtKjTEcNhIy05xPiMH74jWU43fRDsdsdV1EMNWQC4Y+ewCVTtLcSweO+SaknFZCrVGwTxFbeVA91MWJNROdlzjRAL5VEmUdJyL57kg/jWOCzAIOvQ5MqryncAhas0kNydOf+C1NXfbBsN8HRz5rC2ldCTfRKnDUHzdAH0jNG5eGSrwYvot3B9kIj09B10NzY88xGcv5deHFbwGHY00L2QcUaYZNJDy7Dq+M3vh0QyIMudBe9pQN1MYbQnAmjp+QZw9/hW5J9JYzcU2f7B6XIzuK32S
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:07:52.7240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8c79b9-34bb-4f56-fa22-08de74906985
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB11215

Core 6.0, Vol 3, Part A, 3.4.3:
"... If the payload size of any K-frame exceeds the receiver's MPS, the
receiver shall disconnect the channel..."

This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
0x0027 -V le_public -I 100').

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
Maybe the naming of 'mps_orig_le' could be improved...

 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 010f1a8fd15f..c6744cce75b1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -552,6 +552,7 @@ struct l2cap_chan {
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
 	__u16		mps;
+	__u16		mps_orig_le;
 
 	__u16		tx_credits;
 	__u16		rx_credits;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ddac5b9270bf..c9555b0a3461 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -568,6 +568,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
+	chan->mps_orig_le = chan->mps;
 	chan->rx_credits = l2cap_le_rx_credits(chan);
 
 	skb_queue_head_init(&chan->tx_q);
@@ -580,6 +581,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
 	/* L2CAP implementations shall support a minimum MPS of 64 octets */
 	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
 		chan->mps = L2CAP_ECRED_MIN_MPS;
+		chan->mps_orig_le = L2CAP_ECRED_MIN_MPS;
 		chan->rx_credits = l2cap_le_rx_credits(chan);
 	}
 }
@@ -6662,7 +6664,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
-	if (chan->imtu < skb->len) {
+	if (chan->mps_orig_le < skb->len || chan->imtu < skb->len) {
 		BT_ERR("Too big LE L2CAP PDU");
 		l2cap_send_disconn_req(chan, ECONNRESET);
 		return -ENOBUFS;
-- 
2.44.4

