Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1042F1FD3
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255717; cv=fail; b=tB82x9yGLXiDdOb9xYVE+d8J/4U9Tlao0FQTRfQZSm79VEbC6m5DVs3F4TNazGfBDPya+IptIzkAG4jzQcIkQYsgrV/JPO2jS1aaAsaJNzJlfBiY7Gk/rraWRKVgc9CqIJbWO6WT5TjRSYk4Y1c1pF+Q8OpnR7Ha2cP36dhPQ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255717; c=relaxed/simple;
	bh=by6tVbSamzkDFbDggvq8zdDtzPAmQOIPU/vzZWffIEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1JHe/DqLChEjQQ0CSsCDCNWrz/umQmko1gDmdkTtgx+V4+gQJOyuScDv95JgS3lhFXdVySnGFZHKodF4gVcmSTtWZ/1P+ysr/pnaXG056jgtmSGUcdhbcFiVVgbzudFHjDrV30WfwlQqzuKKmLZO3pljkvetAECPIia5n3oB74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=LL0l2RTd; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="LL0l2RTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9HPwZ16uLg6CzNpweIqyZ2wrYQ6mz6XhPy4S2tw16TJGJ7GbWSjfC5o9Ql5b0F9IaKdFQyXExgOZkVSNnS1CpwYiMHsxoBKVO6kRswBaQtky4OIKVSCJgcs+tHpHizWMYrFr0x4gFRKkr1J4snRKLp+pkpmwokBFW58WEOk0f1o9yNC32LavhPOT5ijnw8scO3ra8K/Hy3RbJYDht95Cy3YRbz8PnjCidsdCmI/T/RbjA5PcetghhRvYELU9qGmiQekjflms5DdOQM6tDWHxAhsRaZJMHjO1d89SA0oG2ASA31pVclq7V0fJSMh+FWTxwp0KtNGdS/msilgqS1t7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnYhv/p8R783aDyhqAhQrbhcXHez1W8DxTimyt23RDA=;
 b=kv83cjoU2IhAajevjdXjDb8/f7FWP9/aTSGnZ3lKCcRydxHy8WasSFzXGmId4iKyDvq1/qQEZ6WrkoT1gAml81DVQH997zy2zE0/ClW+3y/neuy9KGhsK711/hRF/VVdsmrKMjAwdBrcHW4u4fxDRJmzh4GOQJx2pEoKbM+FcWyLcsIonwAPldgVK7+sADZO81uMp1JEImzlJAieI86DRsTI2B5+ELXRpDtHqcPxoF3nEamV6iqp3kGKnRgJKXHpH7JdDoujlLGzYdVBJiQATh+e4ESJrxvcjbUBEwGFHyOV2xln2AKaMYi2IxJaOhP8CHeQJLCiGIaB/eo+DHDF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnYhv/p8R783aDyhqAhQrbhcXHez1W8DxTimyt23RDA=;
 b=LL0l2RTd0VD4qTr55ApaVcAb3lzr0WajfZSxms0YPJclEupigCT2czntPxt3wCSP9FJz1H/JMBKoQb+qbXyLr6OuodpPHiQj8OSjGDyucNLwuxDnXa7mjX+w8ZRdKnXqAk0AxHWwrgKuLz6ywaU5RD7Z+2TanghpjQkdTN97D5A=
Received: from DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) by AS8PR03MB8468.eurprd03.prod.outlook.com
 (2603:10a6:20b:52e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 17:41:51 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::27) by DUZPR01CA0135.outlook.office365.com
 (2603:10a6:10:4bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 17:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:41:50 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:41:50 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/9] mesh: net: constify tx path
Date: Fri, 11 Jul 2025 19:39:20 +0200
Message-ID: <20250711173958.25689-5-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711173958.25689-1-ceggers@arri.de>
References: <20250711173958.25689-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS8PR03MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e57570-7d49-4bd3-fb68-08ddc0a237a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yiHGkiPDyBU4KFGvniog9BT+Gx5IJph6blJKIrpCpnIK4mzYOTkMNusQKIOT?=
 =?us-ascii?Q?pbwxOup2B9LGDat8FDwjsoVxdRzkRCUe3/CaFXvmMCHm8aUcMCmG18/xCAe7?=
 =?us-ascii?Q?elns6qorsdwZvx4o8g3SJbS7ZP4aFJtZRqhEtiDNsfSFTsg/nG87YCfQ+Cdw?=
 =?us-ascii?Q?3aLOlMpL/MXT+N13xcyTmiAMybdHXIvwx23pXWonKRh5b4DVthKb8kw1K0Og?=
 =?us-ascii?Q?iNmwWxxql2lbBX3N0conYwgyevP8Ax0VfC5W52VSsguN5/ELugNwcI4Hk7QI?=
 =?us-ascii?Q?DZftGy923okL++PmY/KunE0lU0syGdz5/Y1TUK0++SiPhLlQfiNADEIiEy1l?=
 =?us-ascii?Q?OQ7APXdBp64i+R8Hk3iLEyDM/b6sNOfZvMg5a3u38h2okNtsx0NfB38Gfhc7?=
 =?us-ascii?Q?uDTnVY29EogtEap9ihiBHkIdNf5IkVSNqjoR6siZqhH6PsEkeeQC7nCoAVJq?=
 =?us-ascii?Q?mA8QJ9IBT+z49q2hDj8MM4QB9aLh+Ga+uV3CutgFv2N0otcc1WREaWJghvvG?=
 =?us-ascii?Q?suJsqSYUo2rYVgD/c2UoX4ZFgQXlDV5fzoqIaFw/dzgZC+9e3pTdf21oeLjC?=
 =?us-ascii?Q?biTv8nfPvPne9e7NFGof0Mu7HfqeH8PSLPxCiIoK6xxBCzaj8dAslwLk4qT/?=
 =?us-ascii?Q?4J+4IG+S5FKo+kNwHwL1vyr9RXPyjraMrF6yqtCtbUrhxaOUXWmk+MtrMs8l?=
 =?us-ascii?Q?KT9HFAuYm15xtkSrKMn/96WjSwjQA7HvBmTFfKN19XR8JDCt1b49l0xW5IAu?=
 =?us-ascii?Q?qMLRExwXYO8Drl76H/rzdo6xOo5WofP2Jkul88DASQgG6hSQlanO3bzyUKM2?=
 =?us-ascii?Q?5FKekbYkEVMPbHiWNeVDSe5FwgjmKduqBKtXN7ihXMLGB6yEeI3KQlhMD/Tg?=
 =?us-ascii?Q?59Flb1nMxR5ReZd8PwbDC0S3YorguQ9Qk8c0/HnMqZMcy2gaYECaKqXzXg6Q?=
 =?us-ascii?Q?2MV66CuBjZqyzHG1qNhm0wTD8PKSY5DYcku/Jsyx8mxaekFgtH9fTU0hn36O?=
 =?us-ascii?Q?uuSG6KSmQMeSdTHmphkfNQzRS+bCtOSOMN+aazQlxjaNIV91HpieWdWcZqj2?=
 =?us-ascii?Q?np/peFF1i0DplC4pkdWIxFgKomCV9DQlVTyUI2vaMg+2v9b0581hdX9VUDyu?=
 =?us-ascii?Q?kREp8eAV3yXCXs0xMFQkH1O9OqrPYlUtiPPbDfuBsTsQHWJ894GtM88/01Uh?=
 =?us-ascii?Q?fNrXfvrc9xeMpo6hQgDwq28vtsCZXmuqUshGwwZ+h8LdAS2X81oYC3KrWJT3?=
 =?us-ascii?Q?6Ulg3aJlNYNwJnDV7S5WPy6UgUgQZRyatjq6waCInVIY817VW1mhsHqfpBsB?=
 =?us-ascii?Q?GxNjLPtZU/TYEUyR5PGeVadtIKMe+hhjDTF7AeUXUQEp4VirlkuAXSpUwKiL?=
 =?us-ascii?Q?bosSeU3vglEL6GvwZvzqWUZzXf5KVJaaS3gmCjjpM1Jzhc6XobUjNWsfhhOu?=
 =?us-ascii?Q?QYN2cEXWPfSa6DTCxUpdJR29gX0qMS0rs2b7Si1uR/Ev+2aiIhyRzWStg3Ay?=
 =?us-ascii?Q?z3p7nv1wwyL6WUGA/Aoy8wYQPYIUajYaPTBY?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:41:50.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e57570-7d49-4bd3-fb68-08ddc0a237a6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8468

Although the first byte of network packets has the same value for all 4
'send' functions, it feels much more natural to assign this byte at the
location(s) where the packet is assembled, rather than where it is sent.
This improves the readability because send_msg_pkt() isn't called with a
partially uninitialized buffer anymore.
---
 mesh/net.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index b6ff11ffd777..496e4dd7fc04 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2292,7 +2292,6 @@ static void send_msg_pkt_oneshot(void *user_data)
 		return;
 	}
 
-	tx->packet[0] = BT_AD_MESH_DATA;
 	info.type = MESH_IO_TIMING_TYPE_GENERAL;
 	info.u.gen.interval = tx->interval;
 	info.u.gen.cnt = tx->cnt;
@@ -2305,7 +2304,7 @@ static void send_msg_pkt_oneshot(void *user_data)
 }
 
 static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
-						uint8_t *packet, uint8_t size)
+					const uint8_t *packet, uint8_t size)
 {
 	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
 
@@ -3159,6 +3158,7 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	l_debug("segN %d segment %d seg_off %d", segN, segO, seg_off);
 
 	/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
+	packet[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
 					msg->remote, 0, msg->segmented,
 					msg->key_aid, msg->szmic,
@@ -3216,6 +3216,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_debug("SEQ0: %6.6x", seq);
 	l_debug("segO: %d", segO);
 
+	packet[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(false, ttl, seq, src, dst, 0,
 					segmented, key_aid, szmic,
 					seqZero, segO, segN, seg, seg_len,
@@ -3370,6 +3371,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	l_put_be32(ack_flags, data + 3);
 
 	/* Not Segmented, no Key ID associated, no segO or segN */
+	pkt[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst,
 					NET_OP_SEG_ACKNOWLEDGE, false, 0, false,
 					seqZero, 0, 0, data + 1, 6,
@@ -3457,6 +3459,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 			return;
 	}
 
+	pkt[0] = BT_AD_MESH_DATA;
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst, msg[0],
 				false, 0, false, 0, 0, 0, msg + 1, msg_len - 1,
 				pkt + 1, &pkt_len))
-- 
2.43.0

