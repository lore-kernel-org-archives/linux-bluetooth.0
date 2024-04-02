Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E869945
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058217; cv=fail; b=f9KKl6snlpu/cHZFPLNbn7PvlbncFeuejMFocMbRLZejC/EqHWFkJQlm+wD0X9MYi97xalRtycD3o6tbVuMg9WfUq0FnILHHNYc8dMmYt9/9K5nt7rwJxha+KWn8mvSBwjZemewakV2eZ1jIXCrJyKDY14QyXNqt5skiQnA+n/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058217; c=relaxed/simple;
	bh=uOQWCpqc6bI2/tFCrkCoARAueuQNnRmAzrpslqeNGo0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S+OwhRt8IR/tGDg0zbrMVZICgL7MS9CIDA2FK0W1Yo59UoMuAkNcgUmR7TGoiE9+1YJyU34f2/FEnp8Oaqe7Le2pHc7b8F7Xr6tY6k6OO+AwPwpiFtyNoawaGUQYaw7UCbsPJ/b8YvWMKuUq+wkHHeEa7xDFDr8DWKPjZVG55PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rtr1TYR8; arc=fail smtp.client-ip=40.107.7.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rtr1TYR8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSWInETo/H/3yfksml42SZ9bnqzPz4D2mRuUjvkFrMk9k3Gpw44tqAIrnLvJM6XUQgBcBvhm0fiIjpayZcKmBjcGtv7b+iNm3WKa6u67A3ZBCYiQimbgGMt9J5u9l4cak7EB4WQvgXXFY+iUQ3DfuMLxEe0WhubFQ7MYR8b6lUoiTdxeYThtX5F/oInKYIknBQhPhBjrTTqOWBH3LyOlje9ipFZc6fhZ5GoSRrOqtuyU6qyE77bhCDzouBBZiv3SCMqAgkDtArRIMnCnaQvo5CstlZjN0hL/Kxhb8BAb+uiaYE/He58evAXf61dD9fyJsmhceGTS5j5R8BC9ALw/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i+dBDPhyPiapU33OEicPoxDQin12qT21a3OpDdg2h4=;
 b=V7Lnbry/Y6bXxaDO3outmTZBcj2CcdIL/m+u+ST+AofWwJqTJnNZ/1i+wDD88fy4ozqBqywYrCv2K8Frr+Fk4Y/4gg9gOitYFTcJI0FiQfp3UO5zjF28whKM6IGYEatEQIwXSYKLywizp1oNpoBCarFI13K3cXGvLPHcyfBgAN65xz7Xur2P+uy/FwcAs1l6QYABNpt2QoN7IdySUP3GB+Ex0WoQC4rYiUWqUoAO6KoovDCv6PO8TiP+l+OekVlIlfS32foQI6Q7QqEhKCuasFFuBsJiI9vJzbL7K/8g2td4Rg1AEGOfQax+xoZRg3UtMr9O5XcldsDzG9H8W5TbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i+dBDPhyPiapU33OEicPoxDQin12qT21a3OpDdg2h4=;
 b=rtr1TYR8gqEpLwE6BwxFCSR/S7IlpyDPZGbIfurMls5/JPHj/8GFWK3WVboptEw2AcKh5OnugXCmx4XRZDLuGtzc1NM7yVNDG9Z8/M9HcxmsXKHpYIiYOAA5xpFAIWrQj2tglTFltREJQJRuPz4q5fo5Kk1aICi/tBi/AyiR3kM=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:43:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:43:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] iso-tester: Add test for Broadcast Receiver Get BASE
Date: Tue,  2 Apr 2024 14:43:23 +0300
Message-Id: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E40ZjMdjO632MWuuu7jEiA80meGEzk6SM0DCUcvfbn6GgsGaUarVL5IJxe84sZ2Bt2wla7uucVZqHKCRjgGm4isdd3L6bODISZ8OSitNOwXDr/NJQipCEkAhWWU+7c/Q96RgIoND4JZ9yNBZbLQno0BP+Yi5M+tSl24Wbokj5ALEYYlWdGa42FPtKWfp4qDJ8IEnV5TNJW2pWHPvMzgMmaPPA2lqwuN6f7hie33GpUexyQyPolEp8JpkZKnAPUrperLYMvY/h0Z0xV0YwdOzBreAGMw8m7BjWeCjz/ckeMMZ5BnS5uJEKE7va82tPuNake1jUwRm72oTuHnvnGershiMM917qUEDPz8h88Wp4mddviXuwzoyqFde+sBmd8w21y0Pdfz69zTMK+mZ4T/O/omT4w9DzaRy0+QbBQTOb2ZU47WufADFXaASbp9fNwusRI8PLlzjZ/6Z3T4q++tt7cr8fG5ocqtPLaZGzOfJCew+1lxmGx8hIrylo00x9XdP3gD1nVwWFAz2Dbb4lgjyze6Cg/YnFS1s42ESHjLTUCGo/J5YsKMijuXkfB0aKopZahaylbk27anVQ7+DFwVC8jURikfC1Ag00Vc6JRpt1KDU7PJCBw2IrM6LyXaoBN6hDdLYxB84kD0hdWdVuqIpxm4UcoR4kYUyCU1aYG3TEak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lst9PGZJiXU2k3TgiNVbpZ6GPKBzV6gy2evxY63L12BwmKi+cX9PqsX+3DqT?=
 =?us-ascii?Q?2D4XA128QTJvAQqYovXLkP7pwhnG/PYR/47nL0uYdN3kdSZ22B+2NR0yXA19?=
 =?us-ascii?Q?+76WX3FVjkRfXowMwBUXOi4iAnb0Lqvx9fLameCyP/6UQ6TdVdLtKBBY2gpF?=
 =?us-ascii?Q?zbK2mTrxQtNqa9sBM3GF6Q1wgvt47APmMkwkKiLn+ziPzErMWNdnCykaxfNy?=
 =?us-ascii?Q?TRvL/zMBoh1LqDfgM2/WoPnoctvGteEH3VHs13CoLe+VRtvTpsma+5YTol+Z?=
 =?us-ascii?Q?7PMVmy0bKYCrn89E60M+m1Sq8jG93mtHmfVJ/SnG+TqpR2L8zxLHnYYQikou?=
 =?us-ascii?Q?kUsSlWX9yJzHI+sUd5rWOsdYbBzYDk3IPxNnFY47Uhn8YycKncouSJAlpnhd?=
 =?us-ascii?Q?k9TJCSurFgvJk3cYPm5ka/61c/mjIGc5aa+EF9iYG8HaMIVsuTpv/LLn5LwI?=
 =?us-ascii?Q?zQ3gXsyGJBSk1HqpsvbWJGbaf62derHGNHPxZD/IExj7FNr10OhworW4I+lt?=
 =?us-ascii?Q?Wsi1MLJsLQimoTOYEJyFcOZ1rcf6AoYC2rRDSnU5zGGuMN1G5VSo4TDLkWxh?=
 =?us-ascii?Q?GewcH7ZHwH8hJjIF2hwnKTLgHGJei+LDMTUhZsFU+PrUOwVmiJBL9B6DSttz?=
 =?us-ascii?Q?KIixAYfaQxDwKhitYuJLZla+304+du5cMRielIGAQILCmL05zYZoP3my/2Su?=
 =?us-ascii?Q?mpIj1mYJc8oTm0ZUapgYfp6dB+hKvWdJSpKvZhbGHSkHhidmQ3jB6uoGxU72?=
 =?us-ascii?Q?BivWo72OWGXRz7uCC/0UFix/OIRuX7cJgDONTyGC0jAv/81xp7H24PzJ4rb/?=
 =?us-ascii?Q?E7jsEGl4aCrBNN2QM3hkHA9yPJSdSHzvBkxVpEvUAgBcWQHfz07yzsVMm7a1?=
 =?us-ascii?Q?CKZggx7UeC06UMoDQ9FRgB5/CWCw5p/dcELk/q1Fs5KqCCDprFdyvd8qN5WU?=
 =?us-ascii?Q?zaIYV1pBn+l+wpgM2bnHTXEzosrLVAdbDEW3WAFKG/wYcfJT0iHM1XfKOLfD?=
 =?us-ascii?Q?1zEm2h8/QDnid0fCrodRPOUqixypGUo6NR7HwULtAWf8Y5GKt3qwv2Ya+2Sn?=
 =?us-ascii?Q?Dvxyf+K2gr3WvGqzwgTl3CDseNnowOehTQF4Fixyjk5HCP5PxmeGQzNhUGmc?=
 =?us-ascii?Q?q39AZINNREl2hSNMtEXLXDF12yGltIn1BR7hnHiNZ0WhOHspJzq1aTOf32/T?=
 =?us-ascii?Q?PqcKeWOg9Y39fG0/pA9S4kSXmlLvH3qroYxxlOUvTOWGGWPSVSdwsgmc0yW8?=
 =?us-ascii?Q?lNJ4UBNxGizf356lz8zMJ23F23H3nVoXEr1Dw/6s1nlWgxBQDALsDF+gDMBq?=
 =?us-ascii?Q?Y9fcbAU9juqRy4Yr3kkBGw74pbZK2ziRE+S7apLHiXQ1g5/HzH5M/kUQbVms?=
 =?us-ascii?Q?OtZFmPQDofSF9wdhBtzCyNOQFknEhl2sMr9Zzi8r1Bq9hUTYzxknCWnv3+ho?=
 =?us-ascii?Q?wCgFwZV6+bnNHvOnntj000EkH62OcTVEs732klcm276htdGKbgiEUy8SYu5Z?=
 =?us-ascii?Q?Rw/ZpWItYd7qXHIpV0e0gbbksR6iDq8QmLPZJfsQhOl61o47ODU1Hv1V6QRq?=
 =?us-ascii?Q?cl+IRPSzYcSmmQRbkSY8oCzZbL2iCuLdMtH44emqZQPYYddnxHBFnDwxKmen?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd8270-3b48-4040-59e1-08dc530a1fd0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:43:32.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvn9lRNMNvoo7SdaXHVeQfA/EoTmiiOStRzcFXLDWj8K1I9bGJUW2FNqa3xuk5rPRT8n20HZ+p3Fg2ApKfKzLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

This adds a new Broadcast Receiver test, to validate that a Broadcast
Sink is able to sync to the PA transmitted by a Source (when no BIG
is active) and is able to successfully detect the BASE:

ISO Broadcaster Receiver Defer Get BASE - Success

This test depends on the kernel updates introduced by patch
Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated

Iulia Tanasescu (3):
  lib: Add macros for HCI_MAX_PER_AD_LENGTH and EIR_SERVICE_DATA_LENGTH
  bthost: Add support for Set PA data
  iso-tester: Add test for Broadcast Receiver Get BASE

 emulator/bthost.c  | 48 ++++++++++++++++++++++++++++++-
 emulator/bthost.h  |  4 ++-
 lib/bluetooth.h    |  5 +++-
 tools/iso-tester.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 121 insertions(+), 6 deletions(-)


base-commit: 4520eca3e5d81be77dba629cd62f8d59632240c1
-- 
2.39.2

