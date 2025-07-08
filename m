Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD214AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979739; cv=fail; b=QOSZTU4fPh0RhNYCDa2nQU7loDh+lWQBcu6bqbRDsUH42sOPAF+/gzEcr1aIeLZA/Fwr/LOmFD0UZpnXezF6r+BUKWjzVctltTEmUVcana4gXSghlVmkF4NDw9mjBvihehITGZeqPcPRKzdT+GTMcxEceAZNLxHxzmP+q8D812o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979739; c=relaxed/simple;
	bh=pj5L4AGNfy9mbBITh49OoIELy+5/zO3yN67x5Gk1Lig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCrBP/F8iKszTQSGrObOM+9DS6ALRPlY+y5SeK3JQs/xTqSIlEqYqEFLvoS0s9HLOmoRmCF6/dqvL2ZVp7KSPTyAaPJlH4qrowxiSPwVd0YqnYU4s+O+Nso9IsYSonyvyHEgkHRYoj5puBIDruGof9xEBKQj2qkC/LBBMaiUDzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=RAoOMzL8; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="RAoOMzL8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGAWTVAF1+POda/o24t+OH+UAB3Fz+DmRn06JyC/fL3ZUC60eI5KsXmx277l3GhRJ8Ksyt3tgfyyCt6YlLRZYIrsbJo9gTPUl6kVa4W5TfnT/8uEXTKBHx6YtcW59QG/h292jw9Mlp3Y0uhuemiGDzOhE688PUaQv0zeh0HGSVtCQRRVtq8M+xOfPDf3qyQJnmqjooYHvbIYgcpdmJBB6XNgXgsS0jq8epaU6TAcC351rmeK4GALcyarPQbOcPG6wDfx0s0+WL0v6ecpG9H9iiNE9wduDSODGJ06g+f6SXzKIk2kjYmNis76u+Zq5SgWtZfAAJIG2g7tU94FUf2Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyk0OBTcDm2XWj1S771Ab1WzkI73mkcCZcPMIXh06Ss=;
 b=Bt/xOdnK69wDn7IfYmXUsAZkBtYWaaORZmgMHgIqdKy9yG7cm2TLZq5Q4FRQzR4IESMKuCdSDe8IRFeFJ+XwDpc8yM8n6Xsa6wr1NFsDjYC8INgM6BjXd9bMmiuhW0q3f/2Mmd/ocL1ZvEPRhwWHHmpGcZUWi6eunMrxtQkQvsu5BdMJYYrJoy85mpxShnL3Q7iwEc7q37jqFn6CaRF/X1JRFZh+uWf9SG8AseT0GZtZ9rU9MdFvUrzr3zaRlXaEA++Kcn8NV5Iq52Emlx6tpo9wn+k/s/Vy2ucvdIcs0sK8o+nvLEQmNgg5Ba6J+dqZYXP0et/PQ4g8JJhiZDmMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyk0OBTcDm2XWj1S771Ab1WzkI73mkcCZcPMIXh06Ss=;
 b=RAoOMzL8n4AviD7o20bSASyQ24o+ZlgUzGNKLLW4QyJ0p7PovbRbKLVI0YZcj62vHqC3BOWJpNhgaCSeBo3MfcyMfT6FUkJvNasZ/CS8AvXqFle/HyNYj8Grb5UdpBlbsPeHo0Q9PkQra4fHnocnXeWC+aIEW1FclaWQoAunALA=
Received: from AS4P190CA0045.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::16)
 by AS8PR03MB9342.eurprd03.prod.outlook.com (2603:10a6:20b:57d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:02:14 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::53) by AS4P190CA0045.outlook.office365.com
 (2603:10a6:20b:5d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:02:14 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:02:14 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 08/15] mesh: net: update comment
Date: Tue, 8 Jul 2025 14:59:40 +0200
Message-ID: <20250708125947.11988-8-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AS8PR03MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1ebfe0-a439-4e58-71c4-08ddbe1fa922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C2YCiRx0zrCLTJmPFvOsnxepSRtCv8Ecq4ewSDp5AbOg4LZATC9nsAgQhulV?=
 =?us-ascii?Q?CqZqbOyzxqF32+e81JmyRPrlNtmSD8OwkKeBmMTOdWjfwcpx0bqyJ3fhULLR?=
 =?us-ascii?Q?gxFlaQtUo3MiVuA7SZIkVLwsGjfw2Pi/I255F4zd2VmYZqE8CQIRedE905Ei?=
 =?us-ascii?Q?XxTlYtn1Rpiixh8ixY/uPYwbvyvjles+QcVQdvXeu5DqwO797RmRCa5cfdz3?=
 =?us-ascii?Q?/IIio1qDDxI8sOJ82Wqw4WZxZU9gWFskJes54mLWacjRYwi9RARdo1pfv62s?=
 =?us-ascii?Q?s/CeWSORJqfTy7qAwwCSqd/mA14PAeBp2JFwB53VORBBG/M9I9ZR79qA7JtQ?=
 =?us-ascii?Q?Ju1Eys7cNLMcqlMuQYOxy8d4GjPR3bs6J/WTdNXBsQV3F/oAJ5XfsFTNT1CQ?=
 =?us-ascii?Q?J7hJp0ojYdcKwW+X+yx5E82ZCIIChY4Gpy4C1mq4MKDIsg86pXM5ziRaG+z+?=
 =?us-ascii?Q?Rr8c11Ouk15ZsLztPHdc84KF+1G5cGUS1zQpOrQY27x6ms/E104Quttji5yB?=
 =?us-ascii?Q?GVvFMzCSHqVJDyqBTeSdbBK8e3h0G8PVIzocJN+ADEB3ViRdkd7zoHK8tcyI?=
 =?us-ascii?Q?QQKS7MuT6ujupq5pT7/zs4GDoca0vzaLqnwoGEJrDmSXi5kUpl3YQsnTlGSn?=
 =?us-ascii?Q?CT7EiJmiKpkZYQ1Qj4ZDNYkbItY/5+V8UwwlMfkRVJpUjC/HQE++bE0BBCKg?=
 =?us-ascii?Q?g1mYYhq+JbKvFyFz9ozcJMVhvpY4wsE01YbWUdCnrx/AbIEZeWxgQ4cdvj4H?=
 =?us-ascii?Q?eCQSMTpYm6s/MAeAAXyvgzltuvrfeeMLu0ftyIScGgkjgyNvzWkaMx2dWTQ0?=
 =?us-ascii?Q?rQ9ba4qKbViHJ0VB+EEdYQ32Wb4IYM7tjSjCcQbWAQdgYXBGwb7y0ScBScWG?=
 =?us-ascii?Q?X9lDb1TvqWv5h9z6NSi3HDdkJdUJKABzf3QYdIzAUkAwfeUh8HyNIkjvfiRi?=
 =?us-ascii?Q?s4vjcoQVhUwMlG3j2QGwpr4aP5EW6Vw+dI50YaIkUZUsdYmY5qDbaPEGzs9R?=
 =?us-ascii?Q?7IqYib8lWl2kVqiMkD5JZk0Dqyn3IuKt5k1wm8gY2lkbk8wH8wBwQapY4PcU?=
 =?us-ascii?Q?EgoxT9cYUM9p7qilV5Vk6Y1ZtocK0ZN1n07YYgPh9FsVO9kDlMG5CtaMOsqY?=
 =?us-ascii?Q?ttSNUrSWHAY5lz3/1+FYz2t6hANwy2CEYib3PvXYaKdm3REUjf45pWqCHWnR?=
 =?us-ascii?Q?7o7fNuHMcKNSD9n5FDtOWlemd0ILdyuAAgzulFvcc/yeCYGNrhLBYRwL0LYU?=
 =?us-ascii?Q?HKDup7TSSXshj19OZ11pcTh/5YHl5cIQz9bhIcasmgQ1Hg5yK54Oneat7vhf?=
 =?us-ascii?Q?u3TQpyiUOz9b7CwpaheaNHw59aslAJML35myLkf1QI0/ViS5b++PuPY42SyL?=
 =?us-ascii?Q?VTSQDdUW64ul1+0whSuHKA251Z18nebCuzXWUcfs3AxqkPqWuZUfvz1tsV3i?=
 =?us-ascii?Q?cGro4/kke0WfOevlYKT08sMr26si/Kg14Cfo1L1SbBlhavY7XDXTBYhpPPBk?=
 =?us-ascii?Q?K0ws/FJ5poXujoBSa0H2cS16N5ibwD+m1BKN?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:02:14.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1ebfe0-a439-4e58-71c4-08ddbe1fa922
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9342

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 2e10aadcec19..b61cb8cc41ac 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2494,7 +2494,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (relay_advice > data->relay_advice) {
 		/*
 		 * If packet was encrypted with friendship credentials,
-		 * relay it using master credentials
+		 * relay it using flooding credentials
 		 */
 		if (frnd && !mesh_net_get_key(net, false, net_idx, &net_key_id))
 			return;
-- 
2.43.0

