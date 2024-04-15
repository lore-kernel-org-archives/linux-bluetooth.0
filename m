Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A2119
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192322; cv=fail; b=oTrn39MIBXGmUg0CnxyDh+3XDeTBbCzYFDPpdApgpk2AYuldVXLe90p13U4eCfZ+OANAo1/NLs9xWl89MMcZo67YI04RdsCXpu1EVA+nphXP5AwAMmAPBXgT+VUN3Jc6pPJRaNmhVx19ePXElPltxN4s2omzKZPzgiFlOniAZRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192322; c=relaxed/simple;
	bh=rwWmX310qcWcPcuKNxCdGAClFIbFwmN1R5qqyPHrUC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkM+gGx45gC40nh6WaQMWZFvJb3aNGat+3x/thd9S9dU+MRndgTIVNcUV6xnTJgltk5jjMhVw7jE8s3IU1QOuDgPW+pLyY4ZkzPAWRaHF4ZmlGjsirjo5A/R1i69ywgYLqcIwbilt5t5tLf2+5eUO0eXs2O1WBprXi1SEHxUhS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pdo+Ac1y; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pdo+Ac1y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRmrGxD6ttQ1iP7fG3IM0MsZ3Y66semoIl9PjrPJhJaEsp8Iry/1NQTg7dL5pBwDNW1SRDcOPxOyuuf59CyCmfGXmglnQvaKtDgoreWfgJcCV06j1QYass1lrqyo9iDIa3OcN2lbDselh2oFsZ0K6PSpzq9dIUMZhj7Lh6A+WCpmo1w2SfR2/Rk1l1W7nPX1X0gPVAiuiz0g9s/31+UKWJa05D0CslK7L+t0Anhtcx4p08HNIgRHvDl4UG5zQV/MeQ5VkKfzSvl/1OW9gRZU2cgGkaeHoWGjLGD7fZf8MRlmSy8HCAvIp4foqBrIb4iiIdddNZYFuunqox4zzWRldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRKJFpOgStRqnBnj6eiHXDrFM+e2gc47Dptq9UEY1Mw=;
 b=PTE5Kmb6yYAc7gKUTjYUmd5jZnqJL2TSjUqs+xDmhO7ndR4WBcJAIMJCNzihB7vAiORc8f09fC7HAHmVlfgchPSSZkiZzRThCPyGrWLygC/ga+OrO7/RfXcUec5UDBKR1R18h8u/JdC5+fVjlfROisPfsaRWHNIZtBVsoGxJQPBk4eMKW29zmG6sEV5IT35yxHXZYp380Mt+E7eB+uz21aso/X7x/pmAmXn/vQn3F1aG81u1S02AuDKVMMQUgy9ieSjz7sJjlrJHW9cwF7d8M8syjsUh0Y5nSQgYi8n/G/UhOj02c3oNBE1aEboNEZLJf/D7zCa2DwHUZZRY83Mszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRKJFpOgStRqnBnj6eiHXDrFM+e2gc47Dptq9UEY1Mw=;
 b=pdo+Ac1ygXxf+epDCVbZW1VYSoZq3SEA7fGkpyD8s87TTQ/9D/khY4Bq9EFW/yq7u8He7ssJtsKMAy+ZzdcORQA1EVmqy4RvmmEGsMNWO8bpts7wHlr8dFBETe8C/+fF6v9OvsNF6V85GCcoUtJxLh02jpXw0kLbDJbRjkHxj3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:45:17 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:45:17 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_event: Fix setting of unicast qos interval
Date: Mon, 15 Apr 2024 17:44:30 +0300
Message-Id: <20240415144430.34450-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415144430.34450-1-vlad.pruteanu@nxp.com>
References: <20240415144430.34450-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 151e7aa4-b5da-446c-f995-08dc5d5aaac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K3/4+nSKoyky6d6LpXi1cihPDCPPa+yhMusV3fMHObw7t6bzaN2Nz44NFgwCEOB+xbO+RBSErkqxN+hM/98loprVmuSBomDGhmOXTuOk8BpdmdLM+jsUUHTHPxbtCf6OlJ1Mr4KD6zmxiatKsn8iTmw9wRxXlST/dMmtea7hWh5hHIZipunmGoBoxQki4d6RNrHp+h0hqdc0jJCVS8mZCccwO93JHDNNiSVyv7Z5z59L77WomkqOdo+HIbBgYhdxCi/MiHeCihScTJwagxNlJxgY/K0x0dF86hlGq1ZJYUxTUjrzXGOYGdO1iyeol0ljwzeUM0sZAn6c35BBbCQ++Mt8PwwM35BtuaWst6VXi9gxC/5AiaD57o/lYvt1EsG6RTfUXhZ03+GLuyfP8XfDU67ziU8h12iMbBX9770uKG0GGceTtvL/yfDqXAu1cLrjgBNHSW3c134QKwTyzW2TFhgOVk0SEJpRKbV8Cdix51+F71IPjoisNOEMlV8/2QPLQvai1gS6yVjsiP7dSI5vkC+sS5MMtjLYEGq8vuhQAliRYm5N+8LPgf2WsX1fMMqByC3UkuUNJKOTs/IGM7aPifZRemN1QMu8+0qjVa7c9MIn58FOzfmz/zY5OvofDDVw2FflxsB7Ov2vg1HrET/rpVVmgzDaIp2oP4EL9WWjBuhjwUbnYtUA3/sUkXmzMOBgJrsBmgY7I3TbladKkSRKdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsZxfUxm7U513nt66dZO0PwVABZW0SMtJKE8R1wPcskiLdkqHUPQit8oAEIS?=
 =?us-ascii?Q?NtwOZXzL/Z67RFzmzPaRM9nlVn1Pm4p0ShjGAtFSU6NC8MbVbgmERKmptQ96?=
 =?us-ascii?Q?+zIdyCuQOLhu8BlAMLb621LX9kTM99Mm0UKpEfnoKobfyKd5kQPU1YO3+yH9?=
 =?us-ascii?Q?8D3lyjej1DTg0E9kL0OaD0gSeTsBmEAat3kQQtYNDHqGuu4CpEPCBlMKAcrD?=
 =?us-ascii?Q?luVJDKR5PqMTSrXI9Y1A8TtEDvkxzrkiqTEuBir+KZUkg6/jtRSmfjkJDncl?=
 =?us-ascii?Q?K8bEhyRw7fz2tnRlOfI0NQhSx0DrOdBfzef/qXfc3o8ZBzAPNsjgLu7igEiI?=
 =?us-ascii?Q?t+Ybkfgj8tuikoVD3XgpJIxEaR+cKRuQOL+9q6WsJ3FpXNCqwHJHv1Ccf6EC?=
 =?us-ascii?Q?sC5qH9C98n3ASSo1kyZ3ZifV/pJAYfM5tyh4aV4Hrn0CXsoceJwCzHrS+H5d?=
 =?us-ascii?Q?jNd1NNFTA/VjWohCsmBLzv1KlRRZhOB+doHf7713oHWbu6cekmJyURzrqb+o?=
 =?us-ascii?Q?May/L+hUuOofaFJnPdOIk7jcvEU483nl00bt8GuufuA6Jaebvi3+7vMS4dDG?=
 =?us-ascii?Q?GpgdffL8nGOBwQ1dSplkgv8NcASFRD4cBlgE/u66nEQ252dNrd+O/K6n79qY?=
 =?us-ascii?Q?XGFjMv3+/3IEAI3V/fFQzjTFtWNH6w1cOTKI8w4Sv9RbhAgzHM5bTC1gPlUy?=
 =?us-ascii?Q?OL7an5Rw7CM1D22PrJOa2rReIYz2VXtKqoNxhjV9NMp1Lz3i1kynct+jch97?=
 =?us-ascii?Q?8VRKrkG+T5i1xUaqESwp8Qu7FkvQZFI67NSR5D9i6q+kg6OVtgf0n4ybaPKP?=
 =?us-ascii?Q?1SjGgxOfJTKkeVGgJExKeXF1pBwR07hjvSaYZe56gLpf7BEU1m4peCaebJ9Z?=
 =?us-ascii?Q?NLKKfV1ICroNNktVVu4HRWg7x21jfekQ9Xc0w/L29UA0rqjzdT6mOLpGDLKP?=
 =?us-ascii?Q?PNGLUtk7KdRMW0zcAoAZywju6q2SZpbIga9TGb5WuAS7RWiRRsVSqvmlYNy3?=
 =?us-ascii?Q?UAhO9aoRHzw8Sk6ZhTS7NuFbsHSqwYoC0y/BGk7+UbTg87o/V+2oFQzdvfgM?=
 =?us-ascii?Q?ihw7jRU3Ez0yDBPto8qAD7uIlcHYQIVT9z5szGWaHxn9QCSF/UidRMX6IMFb?=
 =?us-ascii?Q?3DUxOFZnTmeTHlgtudwIW/vDEqd1NmgPa8AlgGRMlWXY/+WkMTi6SvwllV9Q?=
 =?us-ascii?Q?kfvipoXKMm4G0idSz96Obn98bQV6LCxOKWl5itiorFrnZ19CodzBTRHKmtu+?=
 =?us-ascii?Q?3gNxqE7pzxIubc0O7JL5GTnOYta55Wm/d/1ZkieF/TFvov5UL+ELA49Afcj9?=
 =?us-ascii?Q?9w8YDEN1cVt9T7puUoEyESokdnjUkeSPxsO0AS49FLq6j0xCWbsaiviQACU7?=
 =?us-ascii?Q?6N0IpwHKI3NjVEXCdLsOKDPJkwSz1y+gBC/7ecGNPwVvbAgyuvykktO2wLLW?=
 =?us-ascii?Q?E+5ypkzyjxRBNnMJ0IwLUQITLBReYW7KU3N8zqGVB1zMINttsyHZHEaOMoFp?=
 =?us-ascii?Q?dbgq7ZOWNSCpffdQi7yQGGU4oigeE1mefYhxnL+bG+qGONxbABslV/R/4zvw?=
 =?us-ascii?Q?+zBM20L6F5fPJqjyMv3YD+cTfrNaJC2ManYntYKH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151e7aa4-b5da-446c-f995-08dc5d5aaac2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:45:17.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czVNZOL4ZgFX3jHqDvGTp8qzxa4xUvM9VPKV5QZfKskMpwm8+UoV6N9Yzb2KRc4+GuU8ioGE9AMp9CEovUtIOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151

qos->ucast interval reffers to the SDU interval, and should not
be set to the interval value reported by the LE CIS Established
event since the latter reffers to the ISO interval. These two
interval are not the same thing:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G

Isochronous interval:
The time between two consecutive BIS or CIS events (designated
ISO_Interval in the Link Layer)

SDU interval:
The nominal time between two consecutive SDUs that are sent or
received by the upper layer.
---
 net/bluetooth/hci_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 868ffccff773..83cf0e8a56cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6824,10 +6824,6 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
-	/* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
-	qos->ucast.in.interval = le16_to_cpu(ev->interval) * 1250;
-	qos->ucast.out.interval = qos->ucast.in.interval;
-
 	switch (conn->role) {
 	case HCI_ROLE_SLAVE:
 		/* Convert Transport Latency (us) to Latency (msec) */
-- 
2.40.1

