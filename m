Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D824AEC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945761; cv=fail; b=H1NCmeeP6D89nggzfbT5v/Uyx+PDMNJdd+x4aveo6Nvf4XBXqlMDPrtco2FTw2pcG4OTH9u3ujIOUwjAesf530Qf3dlNuF3sI91Dc0hCO1l9kEWdnFULJpMNtxM6Fx11PkYj4TfJwVRqxnL7oR1PeY/gFjRRS/dBQImEthLNWYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945761; c=relaxed/simple;
	bh=BunyusXFQS8C7UE7nXuKYSUpWr7TXgbJUOhcUMGYkCk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kYspW+fJfLn6RVpAogfUtpMqClvDEv3Q2JJVrn5bmgoGOAST99g8dlcBc7LPeLNxzZIWPm9e5IpckWVkIqDMwFDVdnNEPLoM54Gf0wTSaeY62llaREK+2RS7w6wwPfIOHBeL+fmdk0sHrkV7hzrkEncFI33diCaZKTk0LQsbTI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BUElYcUa; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUElYcUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYX5KGTTvyluI/p1yD1mVQ60P1U8XT1YEe532diKPz99GyQuPeoAXOolMZEOJVmAZp9GQmSI71U+SduPvnn3FVomwyTMSn8OqwjegkqioSQyu+xSGpcECqikGwNAj/Nlu7AMUTlEF+fJyKLJmK1lhoJoRmqgLnBJiYK0aJ1YLJMfZpM64HBDXbrMBBSBfD8hNbiPjKRa2stvNHOAfnc8TbVX8X1GSVEGDS+YRlRi2ymCTJZ8f5s0xiyXVe+e8Ew5l7ln4bMZQSxwUUyGp/94aipcQikhxQBiR6Ur/yGdQ/aIyFdgU7SMU45vtoTTX0nK3q48rCU9Z4n0JEpwBdG/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v/rdlu3uSmoylOdPV7+odrX88kyK90L0y1BOG+rPNQ=;
 b=hq0DbOtF7AZzvxzeU6hAvmR/zs1mdbmPNrXvdfYOC2061OY7X3kEKqvRrL9J6/tpI5Ave+fV59fnWQxFFDWPP/N5rjqRyKILmSjUFNrA609cygflZW3e15fX/T046SkzcdNll1olhoqMBcBRwZBfuI+n/vId9n2U7wia2n9gFpcrhJfogIM1tmkwfWhhf23jRG3j2TzgQ5E69tbE2QWNU28ycEKniLKUQUeTyoglRy7WEO2QnZsC5NHZTtIOgKpIuYNkEreKrZBoyBo4x0oHP/hNwyqSafXwPfT1WYx0fNtp/y3yS5ZZlWcQbohAaTUtxq0+0KQmQTy52XMPVzlnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v/rdlu3uSmoylOdPV7+odrX88kyK90L0y1BOG+rPNQ=;
 b=BUElYcUarSEEh3tFXHO13F4tslsr4g02j9iITaZ1RCBXHlAeH1j1GcPQNFgbtciEdCRT7B6HfIlt2JLt+cmbNJzh1qS+sYKZCgM1PirfAsORXBtMlsek7s6/uZlz0oSWBKfBSNz4lqN9/QbIRURQRFhzc5wIH8TCcdfSLtadmfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 14:42:35 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:42:35 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/2] Allow endpoint config without local endpoint argument
Date: Wed, 20 Mar 2024 16:41:51 +0200
Message-Id: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcc8b5c-fc3f-4574-90d2-08dc48ebfba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THQLjqVA6C4DlFTBCjxuER9Qd/noHKojYdHpdEeuoyY2B3maElWHKFZ9VuHMS9jVJ6CMupueitMrkRBEq8mtr8le2hXaBEzw7Jh4bef2zBZtI7qvk7n4NHd0lFHL15MFWk/e8/SLtmqlEsqAkb+XhvTWzg0adExbLB6hvr/SFMWMDd4clhrnzWSfD/ytxbPo9TGPkSAum1OvJncjfI0DSfp0iW2DqapSAZUBBrHsu2acH6BmNEg8+PQ1eYNZaW7nt8ihWIlHw4lwDXqZ97GKkb3FO21+uSJusc7UOBKNMmlyvTQMiPDhVkScc4ZiSG0qoVxlSBhjnPYFHnYtfOMNOG8UeXXBVfnTVL/brV/gtEpKH6GL9EFUI9IbhXJe8UdF5iSwjZVLwJUYeEGBiTL+2PJBBULX8gbgFo6EnUQ3e44cOiIqBmBv/L8Y5lB+fLbRqmn1+l8tHGO43Z3bkPcfoj9hiDFuWbyIxb3nipYItXWp2QMSHp/PSK5EncauxRmGpgU+TF4bwPFQfUdUnY6m7gaA6JVRiQKXnSC7g1cwuCT4ji9OmF+HKWja5hb8O/YHBzkG7OwPpi1Kg61e1+Ewps3/CxfxQz9EEM4eh6CjVqm0nrGxqlygz4BD4yKj5JcfTAixzooEo/AR/mDlUGU5BK933eD1CQH50+l6ZJJcikk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMMRicgNgCUFfxxh9D1jpQEclUThydhrjt9GHkZgLVjm6UKWjjPJoRGvVMBc?=
 =?us-ascii?Q?eVJCj+sQzqFrPy7ucg08kg3pOGoGwpdk2GgMDhw6Qj6XOKADCsAliWJl0Y6R?=
 =?us-ascii?Q?KbtLqNXvCiC1EK/pOURmqwtBkgzYiStxgoqDBmDcMsRmaPVcedEsGgswpGVZ?=
 =?us-ascii?Q?h+kD1uWnPVoVnHIE6Dy9Kc3S3UxN5jF1qLdAMIlpTeB5XWX+OY9Qh9VfGgVc?=
 =?us-ascii?Q?aVFAvPvM6xbz0Bpoix7Y8PKYZR1k/ZYEPqw9EP36qBmkxwDrOjnxBh0IXkC6?=
 =?us-ascii?Q?ZOXHy21PaWZMPGoJ1JFuvFY3/4DMnTwBeoICDWouigZ0/Luocm4RyicLzmZS?=
 =?us-ascii?Q?IEZ1Ght/ObKb0/Sjwa14Mt+sz4W+yl1L/Xpo0673rfSE4zSfhE7cpTKxvrFp?=
 =?us-ascii?Q?UhOrEHyPzwmzxDVGh32rMGA/LbTIAEZORFpshXMRnEiIMNZ5fZex5OkTyB3R?=
 =?us-ascii?Q?OPLJ56zvOoylq3XLeSNo+rSc8LbmdfSrjWwd4txJIDajXYc95L6X4c8hVQvm?=
 =?us-ascii?Q?li8e+CtnyM8Tx9Vm7IGLmeYtI58Z9LMya5x8Z3WabXFQxOxZTSh1XaSlEKpa?=
 =?us-ascii?Q?NJ7bJYFwVjkI+ZTjRK7qjPLhW7MDm/1+SJ6YXsOAMn/okNrBPxN8nyoN76ZY?=
 =?us-ascii?Q?uTcBhVRy7TowSEg03BRfAcMjcoEgOyq/C7goefHvcBh8vvM3GEnD4kRRdeiV?=
 =?us-ascii?Q?571HcnSu8hr6XNnmJNbE4xwSAquiqAhVt6mmQHLE7mkJB/SxP5QCNx+W9GtK?=
 =?us-ascii?Q?M/JYsIe+K6tR9Pwz30grx8RPrAbfq/hAfjaH1FMrMSqDiDjAPex/G/Vq3vey?=
 =?us-ascii?Q?hl2glIJml3z0bS89yAn5BzIlonehbQR/E8q8ZiWvECsN4Ls4/DOBM0Ey2MmZ?=
 =?us-ascii?Q?cRRy1wsb63qsrhTftnH6mBxbpxKaQx8ysczeiNE7RYGFT92rmb0PSObqqXcD?=
 =?us-ascii?Q?DZ0hZeaXDFTMUvqn+d1ruzK92R5XwzFbaNSghrtRS6Lk5yql9oM/5m7m0TlE?=
 =?us-ascii?Q?Z1JQ6cC0kFd8sVPSkK0sQ1hQaivsE2AaNo4B60X+R+I4JhzJS+oHGGMDvQKh?=
 =?us-ascii?Q?dnDSGFX8ZT99Oq7vwJn4BBbU9VQOm6UdRAOIEpKxKpRhXDrp0m64MhkIbhdv?=
 =?us-ascii?Q?+1pCGVZZ+dQoWbBwvTsZijDo2IuVvCEwSpAhlTNJ4ViIj5RigoevnN33Uz1Q?=
 =?us-ascii?Q?7IFM+MiRAv8pCbHCEniBQz1dhGqLWEFCsNvw9OGQuBTKLRN2csTOr2qw6bX4?=
 =?us-ascii?Q?9aZfCSmuUEyAwPc9jRo4tbfHQXyHcBdQ8psNhrni04gVYwvy3X4WGrAvQ/jY?=
 =?us-ascii?Q?jntPItSOlnRyJobwKFOpN5CjBRRr54MybieQBxwPYZU86qxvKWiTbCBz/U45?=
 =?us-ascii?Q?4TnT786u6dDhe40iL4NfqAH4UVa/KBsO4YSFpJr4ZE8rOQ3BMIKrMiPOxs7r?=
 =?us-ascii?Q?zec/mg/eWbUqH9lAiUOCqsgmx/07JrhEE5CMToAqqpOsNP2GccALa38BlLIU?=
 =?us-ascii?Q?6FZgCyGY0zs0aN7aMG0SB4Lxx7JRvjo89b4IDwgMxxaHeh7AaqDG45gYK1c4?=
 =?us-ascii?Q?+Ft7DOo6MdO1Fbr0Sjx8kPelMtb9uWyqoxL40CJnQAuRDt7nMmjI1sB672lF?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcc8b5c-fc3f-4574-90d2-08dc48ebfba2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:42:35.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbKXXoSz2uZ5wY2fTRbRD0Z+DUnZAGjDuTW0MKM6U5h+YWFgrK3wx3Pu0iml/Nvkz50TH7DYLUaSmHyxGhbdiMiWxGx7xbhXgOaSeX4RArM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797

Update endpoint config command to create a local endpoint for broadcast
endpoint.
This will be used to configure a broadcast source/sink if
register endpoint is done from another application like PipeWire

Sample output from using the endpoint.config with endpoint and preset
to configure a broadcast sink to connect to a BIS.
The register endpoint for the broadcast sink has been done with PipeWire.
[Waiting to connect to bluetoothd...
[bluetooth]Agent registered
[bluetooth]hci0 new_settings: powered bondable le secure-conn
cis-central cis-peripheral iso-broadcaster sync-receiver
[bluetooth][CHG[0m] Controller C0:07:E8:CE:94:CD Pairable: yes
[bluetooth]AdvertisementMonitor path registered
[bluetooth]scan on
[?2004h[bluetooth]SetDiscoveryFilter success
[bluetooth]Discovery started
[bluetooth][CHG Controller C0:07:E8:CE:94:CD Discovering: yes
[bluetooth][NEW [Device 18:41:1D:57:63:C6 18-41-1D-57-63-C6
[bluetooth][NEW Endpoint /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0
mendpoint.config /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0 48_4_1
endpoint.config /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0 48_4_1
Configuration.#0: len 0x02 type 0x01
Configuration.Sampling Frequency: 48 Khz (0x08)
Configuration.#1: len 0x02 type 0x02
Configuration.Frame Duration: 10 ms (0x01)
Configuration.#2: len 0x03 type 0x04
Configuration.Frame Length: 120 (0x0078)
BCode:
01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
Framing 0x00
PresentationDelay 40000
Interval 10000
PHY 0x02
SDU 120
Retransmissions 4
Latency 20
[NEW Transport /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0/fd0
[bluetooth]Endpoint /local/endpoint/baa/lc3 configured
Sample output from using the endpoint.config with endpoint and preset
to configure a broadcast source BIS.
The register endpoint has been done with PipeWire.
[Waiting to connect to bluetoothd...
[[bluetooth][0m# Agent registered
[[bluetooth][0m# hci0 new_settings: powered bondable le secure-conn
cis-central cis-peripheral iso-broadcaster sync-receiver
[[bluetooth][0m# [[CHG[0m] Controller C0:07:E8:CE:94:CD Pairable: yes
[[bluetooth][0m# AdvertisementMonitor path registered
[[bluetooth][0m# [[NEW[0m] Endpoint /org/bluez/hci0/pac_bcast0
[[bluetooth][0m# [7mendpoint.config /org/bluez/hci0/pac_bcast0 48_4_1
endpoint.config /org/bluez/hci0/pac_bcast0 48_4_1
[[1;39m[/local/endpoint/bcaa/lc3] BIG (auto/value): [0m0
[[1;39m[/local/endpoint/bcaa/lc3] Enter channel location (value/no): [0m1
[[1;39m[/local/endpoint/bcaa/lc3] Enter Metadata (value/no): [0mn
Configuration.#0: len 0x02 type 0x01
Configuration.Sampling Frequency: 48 Khz (0x08)
Configuration.#1: len 0x02 type 0x02
Configuration.Frame Duration: 10 ms (0x01)
Configuration.#2: len 0x03 type 0x04
Configuration.Frame Length: 120 (0x0078)
Configuration.#3: len 0x05 type 0x03
Configuration.Location: 0x00000001
Configuration.Location: Front Left (0x00000001)
BIG 0x00
BCode:
01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
Framing 0x00
PresentationDelay 40000
Interval 10000
PHY 0x02
SDU 120
Retransmissions 4
Latency 20
[[[bluetooth][0m# [[NEW[0m] Transport /org/bluez/hci0/pac_bcast0/fd0
[[bluetooth][0m# Endpoint /local/endpoint/bcaa/lc3 configured

Silviu Florian Barbulescu (2):
  bap: Fix MediaEndpoint prop codec returns 0 for bcast src endpoint
  player: Update endpoint config command to create local endpoint

 client/player.c      | 80 ++++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/bap.c |  8 ++++-
 2 files changed, 84 insertions(+), 4 deletions(-)


base-commit: b8ad3490a3507476844d6c6a87b2cb336f7d4eb9
-- 
2.39.2

