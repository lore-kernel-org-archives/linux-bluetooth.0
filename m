Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED512B7F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479282; cv=fail; b=DAskksgIGinw5cymRQqObY2cVdGPEUzTaPXVuZwlg6khjR24ZpMvccTMcjvaktMxB/Oe0c9UW48VrUhQOdHYOept5EdTaHNFw2v48BciHKuf5gbdbn84Eng5ZWCxWENzEihi00EBsUxzseLR+Ms2yU0QRLOiXzP5sDcVCIrGfE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479282; c=relaxed/simple;
	bh=wngMJEzYfbwoIvU/nIgtekRHDAt7OesbzAs2rJ7fq+U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RucMhUdrfMhCGjwpSXljtUkYjtteZ/PyxL1jwLRUdoE1QNXQC1jvvpmlHf7shh95k//uPGyAt2BzyCmaYD6VNA4NOMW3Rps2lXp/UMYXuXJgQdWjotoOzdC0ERIsGQP2CuzhNCzHxdzOrUh6BZYaUuh/e/FLbXVOHzn2gS3P95Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4fMzeSG; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4fMzeSG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfjEd3mTMcFKd1DUQYVFxVC9KknZLTD/ayZuIQTeHo1CvGvvJE+vd1v3iajkKDCZYirgGPQ/GJ93E0gE2sejMSxvt2NHJOHfV/VsqEP7QbPUliFvv8zUFIzU3lvWY8QEAeXdJXfPvUafUjNmtGjdeyKzyohbWdIDr8xVcIYWJEi6vu6DBImbMKgubgs/JmROCVGINTVBeAJxlfNkzgDEGsMBeLv6fBLKlGv28oE+COU0/pne9Yl7+HGQrXVxenti6vyy3FGy2AIdOF0rCU8bU7P3lVjmwUxXNfmfiqyv1RYoPoVfY4r2LU9DFjxy2BihIn+njsT0bVIUpJagGxhzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTgPN/1m4dsBiLXMgxvzdFsCjpujP6f9rIqvUdZgS0A=;
 b=ZP6SkmhKbyDdydI/28+bOzp9RclLmlNNHvSjn3Nzz8/gqyOF5RMGy5UObyc1zUkj9Ks8rboskdEC0OWVpX7hxFRmRkBDG/zYV065KVa9FWT/cWukhBufESvmeq/7EvNS1hQ9BLVSfXhlGcmcP1quMRik1L1bg/3PhYVZTfmSacol2oUpsDh1Luv8OrrYTcH2LhTFwArqzCmESVtAZRPKwGisphSbOgd7mBMV6T4EtH+M34odSneYRRO0+8vAqt/Vi313Z5mBjdVYZf6E55bQGWMIo2hp4Q9vSXlDgBJc8wcLhFDv4w9Xqzt4fyGCM047e/DLg88KdtlGSxz6f+FsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTgPN/1m4dsBiLXMgxvzdFsCjpujP6f9rIqvUdZgS0A=;
 b=W4fMzeSGLyCEGuZAUrRPY0Vshl+7Tmj3QKFdBRJfVXsrZ/K2LolJNv/cbcy3wZ+ttJM4zYfcfGE1o4dWa0P4JpPwNuAmrxUvF+LyBErRHUSBqsZkqjiyKzTStYQfBp+ZhV8JYnGODGzCnFPevQsd+fCBgbHivCLl45AWcTi7DIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GVXPR04MB10658.eurprd04.prod.outlook.com (2603:10a6:150:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:47:56 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:47:56 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/2] Update BAP Broadcast Source state machine
Date: Thu, 23 May 2024 18:47:52 +0300
Message-Id: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0142.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::9) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GVXPR04MB10658:EE_
X-MS-Office365-Filtering-Correlation-Id: 326176e8-0912-48da-74a6-08dc7b3fb72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gi9ZgRZJEs+1JTaS7FUCsE6kFoKwD5nEnyl6L0ZqBlVFYnUzBDdmV4hRGQ2T?=
 =?us-ascii?Q?GPWzZTkBuMdRtWlQaQvKLx9Gi5q4BsjMnIFLHo1c55VWYvrxwZ6S8eP7IWFx?=
 =?us-ascii?Q?IGW72TVvO8QqmH5YXa4A9OO7asqLOQh+2O5Ue4lH32qXM6rezNSThmbYl6Tb?=
 =?us-ascii?Q?qKQ5z4VczVXPN/GY2anXmnY411QtDOH1DlgWve+8Kp8FHrnfj7wGizm9QUNB?=
 =?us-ascii?Q?fw119bJBTJPcjB/3wqoGg9m48fJPJtGpmbLkPEpPo4VbXL+GDp2NqyMLylnl?=
 =?us-ascii?Q?oCTcQ2aA3vIyvTGhUj1KunR9rFN9MApD/Jz/LnkJtm4xL217SCjLN18+PmEB?=
 =?us-ascii?Q?WF3yViMTBCHkMPvwK8yfvqjuDvKvOwQ8AGDcg+Q7Y+rjr7GF12k7oV3g7bhy?=
 =?us-ascii?Q?mqhHA6vnyC5csJ3TtzMY+RqjimDv+anZCndFE2OcPo1rUx+xI/+1yYnOAk40?=
 =?us-ascii?Q?LBmudmSOoKJZoclL9itxdng5KzVidOZfbVMRGspSNzuQO3Zal7atAJbtafFN?=
 =?us-ascii?Q?lcct2RHst1/rjqZDDkImCWcwHmnJt4RUKoEh3d2qoIHkT2aRJ35qpjw0Jsc+?=
 =?us-ascii?Q?jUAAN06NrBMjl4+moYMB/HKLz2Bryk+D63Re/e26xpYubLMlH+qPJqUHM1a0?=
 =?us-ascii?Q?5GDfUKFlWbXM7CRtN8VsISj/E3Id593n8s1x8JSFzpWpd3AkFXIgsCipGTlR?=
 =?us-ascii?Q?m2d45SGa04SAQj3yzbEoF/f7G1lqia95E+LVN6EaJ7T2dTpTx0gMZ8puFIkf?=
 =?us-ascii?Q?APyMhx19QTuxtQzK1p+QEBL3+l837R0dvQvQtmFrM2j9xM8iEe79hnaMyqbZ?=
 =?us-ascii?Q?6FD3UXpD5Z6DGg3hUNqdlaucr1iumxIS30Ck427i5MWeBuc4xbMWtPgJh/70?=
 =?us-ascii?Q?n5tTa3p/bTF85jYotSI3SOsLpUVQsu5ZvFRTcc1xAdbDnxpb4GUtyHDeTwCH?=
 =?us-ascii?Q?dF93MYerb6lVX1HAV6wVpAdD2XHlJuUNDq/6xTI67RDp3VMrDL5tXrCgUdgL?=
 =?us-ascii?Q?s2LVJtshRbCeJy1ClyIxAynFUsSB4DjevgzZkt5MWyaW/tbKGgzEHHWUNoCa?=
 =?us-ascii?Q?liL0vHRWAcvb3FOOgK+blU3RzU82NBHi+gVxMMoUCAiTBlhoXqZ5ewP04eqB?=
 =?us-ascii?Q?NslDqEcl4xA7qtc4jx1iZWK9TY8EPTPfXVNBi07NBSnpzkItDywgqOXNyPmP?=
 =?us-ascii?Q?CWEJADe3ESNpQmz3Bdw1dA7+e4u0nl+vQCCqLqzokP994GuhRfNjGREBSgwk?=
 =?us-ascii?Q?m/5cNXsdpqF0ML/cLS5T+m2YARUU1FO9erXA13cggA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZRXbK+X1zTu28Vcri4cCL61GxYM41jyVKuv7dwYLtEqSHX7kZ79aifalsz/?=
 =?us-ascii?Q?27Kc/GU9OxGHcO7kVIrVJvaQDG5wYNsgB642Bhek7lnB+tm2T3rYdDYwFKYO?=
 =?us-ascii?Q?c9NTmbv+Oy1TdrMnPhw1HivZgOBAOpSF1pkpxzn7lG3yR2derDhoU7cGrN1b?=
 =?us-ascii?Q?ExRi4GCdwPOqnhj0s30kHSGXif1DPlEX9xhflkRkWmwu0RmpiEtNw8kfSnzV?=
 =?us-ascii?Q?aY78A9AtXDxrMGX1Y4Sj/BUYpmh56qc7b7bFy9R4phuqyRGGI2NRBHcvq8vE?=
 =?us-ascii?Q?V4qGQjbGifjAFnty7ibysU5qCcMA0Xxd/obPc02ffs9/6rJEoDHNzkS2o4mA?=
 =?us-ascii?Q?KvWwlx1ScNtaZbkuqYXYz0YGhqof0k/+o8kH8ecOgexQi+XJ9wgBJ82s8kWx?=
 =?us-ascii?Q?8DY5NK8/LfYa0Dq6fCeMr7/ygdwkgBhJ+Hi0PiOSFyBumjfTyUWJ4yzghkjK?=
 =?us-ascii?Q?l7niCnUfQ1cNoZ6mcd/gP17XHA2aWRLB4Xj79Y44jpE0E6mGcziKHWDf4fN2?=
 =?us-ascii?Q?txtm9sHqrmb3aMgRGsOZTUn0lEJqe7XdqxfPmMDmLrdaSnRD2ESKHLxzqP6s?=
 =?us-ascii?Q?vDogfPGPQz2bKMHuFuhsTSOSIq9JD+B4Z1RqFMl2NQrmMr9DnSnyKkELr7So?=
 =?us-ascii?Q?a3+/g/IT5t6qC0O1PyTM46pOWJLQyjFjgOW1GflVplbGxQ2+34uTkXk3HWO9?=
 =?us-ascii?Q?KKmoFo226SoxmsA9Snh0dGK/w6Hy+gimCQrncLwE86n/rDD2kSv5daJNH4MN?=
 =?us-ascii?Q?XEFAgf32ghfdHB5wn/E+mzN5Z0MmiBkYnl6XPdYLakSZsMRpOKE8GpedXyTu?=
 =?us-ascii?Q?M4FNYqAPIuVCCONc2OSr49virmCMXug0onFi3c4qoVDcCgYzyfhPv6qs0q0X?=
 =?us-ascii?Q?JZxw+nirz/LBv/W7CeK98rEQELIKc6kbarmI2RNjPlvc0YjC8NV3TJWaiOkz?=
 =?us-ascii?Q?tQs5r4tzk3hEuZ2dC2kAi1BKEuR+Bi9csHo9kWLC9dqy2IkBYW/VAqFvxEOe?=
 =?us-ascii?Q?W9s0Qu6c5VkM3if1/G3HxoZF3FJfej5KP4X4mR7Ecr7YAOpKCKgYEeTzmR+r?=
 =?us-ascii?Q?urkntanUMlS5B1YKvJVehdsJgyr+lZojlcfguO/V5S32Hkl+iGU7siSsV243?=
 =?us-ascii?Q?Bw6+kuwxBcRrpFv8PL6h2EoluBc0Bwes0ps+mV2u60NF/WvHfkjpTM48IBbX?=
 =?us-ascii?Q?hXCrSPqgNMzE7JXBgz0xqiXsthi6a4qGrgQG+oYcLSXlZ2VGZhPRt5HtTTjT?=
 =?us-ascii?Q?/gVDOqh2Vw79Ggqgfz7wFnjSZ8c1Y5oh+Tap7rZXqkJbbcKXf0kZSKjxKylh?=
 =?us-ascii?Q?A1nUiFH4ZclcnlRho9146kwqSy5SR2ELy9l3OetC+tSAiF/+y8B4F980n1xX?=
 =?us-ascii?Q?LZnf97rja+3P4U+qM5E4P6AjM7KmYGP+9PjPLRgYrdHR0B5xPgAJOewam5Af?=
 =?us-ascii?Q?Y3ak1dnX9/uRBCn8b4POcT6rtCq9Q5r4a+11LM6QEgChAXVqrahP4kaAGPIS?=
 =?us-ascii?Q?atx1pkSrGC7FDlwQ5fXUGAv0qamhv+oHWW9JhY5DiS+uFDNYMfHvvrYoxXx+?=
 =?us-ascii?Q?4+anf7vv8uNnW0X84/tWX1KAZaChtNc/VKdPULW+keeFFFFtrtptDv/5Cmfk?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326176e8-0912-48da-74a6-08dc7b3fb72c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:47:56.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T1+J8qXQYctxIKEa6SAp8e9tGJSseBaQSzj7odDIJxGLNyMa5YBk6Fcyou7Nr9j/dXxXroUk3W4Utd8ejGJ2VB3rUaaMmNKk1H4hc8OAK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10658

Update BAP Broadcast Source state machine states to use BAP define states
 for source Idle, Config, Streaming, and an intermediary state enabling.

Updated test-bap to.

output from broadcast-source.bt

[bluetooth]# endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]#   1;39m[/local/endpoint/ep0] Auto Accept (yes/no): y
a/local/endpoint/ep0] Auto Accept (yes/no):  Max Transports (auto/value
3/local/endpoint/ep0] Max Transports (auto/value): Locations
4/local/endpoint/ep0] Locations: Supported Context (value)
[/local/endpoint/ep0] Supported Context (value): Capabilities:
[bluetooth]#   03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00  
[bluetooth]# Metadata:
[bluetooth]# Capabilities:
[bluetooth]#   03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00
[bluetooth]# Metadata:
[bluetooth]# [CHG] Controller C0:07:E8:8B:69:F2 Pairable: yes
[bluetooth]# [CHG] Controller 00:AA:01:00:00:03 Pairable: yes
[bluetooth]# [NEW] Endpoint /org/bluez/hci3/pac_bcast0 
[bluetooth]# Endpoint /local/endpoint/ep0 registered
endpoint.config /org/bluez/hci3/pac_bcast0 /local/endpoint/ep0 16_2_1
[bluetooth]#   1;39m[/local/endpoint/ep0] BIG (auto/value): 1
3/local/endpoint/ep0] BIG (auto/value): Enter channel location (value/no
0x03 0x02 0x04 0x000] Enter channel location (value/no): Metadata
[/local/endpoint/ep0] Enter Metadata (value/no): 
		Configuration.#0: len 0x02 type 0x01
[bluetooth]# 	Configuration.Sampling Frequency: 16 Khz (0x03)
[bluetooth]# 	Configuration.#1: len 0x02 type 0x02
[bluetooth]# 	Configuration.Frame Duration: 10 ms (0x01)
[bluetooth]# 	Configuration.#2: len 0x03 type 0x04
[bluetooth]# 	Configuration.Frame Length: 40 (0x0028)
[bluetooth]# 	Configuration.#3: len 0x05 type 0x03
[bluetooth]# 	Configuration.Location: 0x00000003
[bluetooth]# 	Configuration.Location: Front Left (0x00000001)
[bluetooth]# 	Configuration.Location: Front Right (0x00000002)
[bluetooth]# 	Metadata.#0: len 0x03 type 0x02
[bluetooth]# 	Metadata.Context: 0x0004
[bluetooth]# 	Metadata.Context	Media (0x0004)
[bluetooth]# BIG 0x01
[bluetooth]# BIS 0x00
[bluetooth]# BCode:
[bluetooth]#   01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8
[bluetooth]# Framing 0x00
[bluetooth]# PresentationDelay 40000
[bluetooth]# Interval 10000
[bluetooth]# PHY 0x02
[bluetooth]# SDU 80
[bluetooth]# Retransmissions 2
[bluetooth]# Latency 10
[bluetooth]# [NEW] Endpoint /org/bluez/hci2/pac_bcast0 
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# transport.acquire /org/bluez/hci3/pac_bcast0/fd0
[bluetooth]# Transport /org/bluez/hci3/pac_bcast0/fd0 not found
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# [NEW] Transport /org/bluez/hci3/pac_bcast0/fd0 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci3/pac_bcast0/fd0
[bluetooth]# 	Properties.Device: /org/bluez/hci3
[bluetooth]# Auto Accepting...
[bluetooth]# Endpoint /local/endpoint/ep0 configured

Silviu Florian Barbulescu (2):
  shared/bap: Update BAP Broadcast Source state machine
  bap: Update BAP Broadcast Source state machine states

 profiles/audio/bap.c | 22 +++++++++++++++++-----
 src/shared/bap.c     | 39 ++++++++++++++++++++-------------------
 unit/test-bap.c      |  4 ++--
 3 files changed, 39 insertions(+), 26 deletions(-)


base-commit: 6e51acb0e846a141e3a1ccd0f243b7fe9de7c111
-- 
2.40.1

