Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEE7DA10
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349389; cv=fail; b=Y9jbtGeqdVddj7gfz0cUVUOht+gYHNSgs8WoBYyV97Vznpw915lNaKHRFjga2CJr9FBCgttFAFWs+FOmHQTpz/I/8+lx9SnPj9cDurZIpM6BlhOvpnWiJ+MsGseQzIIlTEWya2yT9tjC0PNoGaukIjWwR8RKrzRcVBffcfuWfKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349389; c=relaxed/simple;
	bh=cTROtWdEhP2aLwo2ZhjsmI/weze1r+YTjUXdWFSpE4E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VxWs2szW4CK6ZdZykbMcAHjnAQttmwyv3Tm6zMRM6aU2EyEssWiOROBu9FVWoVyg/ZSDoZDqeMfQWCkj4/Qqh9U+z7w8/A8PPMSBjmHySJS8oc2WfrIn9it9a51T7MU7+fni5qaymxQJe2cM0HcSNKpcVxjOJuRCLrvGxSDPaWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DPxpsSuO; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DPxpsSuO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic8dViBfkwAm/FfraUQP9XljH22K4XI1CCAYI9BeuUNFNhwE7/iMmPzqdzYldwFwwsB2DIhjp9Gna8UDQZhBkEQUEFXy2DAzFaK21mJpSJdJosFSESgCmMv9c22+/+UwJSesslsI6+x8U7mbUhgVGNl81aXyGd6hTYYxR8sZvFrA7+9KVso5mSSECbQKPTQ5IwPAyF+f489fA6cXhTyZ2FGf7NnsfayMtUNLFsdsUJWkuWEBDW0ju33TyJETCyFaiusCRlhfXoe22XxRcdR+YocS2NrVUsCGDJ1oxvbWt2hdpGK0Ldjxlhjgo084Q63E43Urkc93CRUHDvB9PEIWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARtqCXNRb34mBWVTEGP5IFDVu1lbrD+VXlByhNgtX+8=;
 b=gpRxOZY5Y7MywnYAF1YXeYFNz4jmigkehp/v+tXCp+PS8/S9GQo6ZW4g2dghw2U9RDLY1077E84cD/nUDenaVaGAaKvm7qtCOIiHtxNwyG7eKbF6yyi3MMbrXZ+NZYTTjv5GswYinDqwnZhDESFeAUHKAoydt1PkikzHrxGbdH52VXvEbtuDWNYv3Zi19WWIU4+W/147asYsxKF0HGKVVIqIJJ4fxTlU99pqGbsD1nstppGVNJCKwoKBau0oGeq3qw5rc3QhgNTmX8MjrtFMj5V/nInInMgWWn/mT2s5c3CmcB91vPDTefYyTcKRceNDP43gqu6YvQ4ZqeTh3MY7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARtqCXNRb34mBWVTEGP5IFDVu1lbrD+VXlByhNgtX+8=;
 b=DPxpsSuOo6aRzoQ7ookkSBmno+4JobbIos3ClTqKCvCGxo/B1THV6HfjxfMs90e43utGiOv6ge/k6MGYSpX+QieV3AaetGZum/1rFs+2bgeSyqTQceUJHPVdox/7nD3IvXOLbeSuP1iWbzEqTONFfHXLJ29qANyBAIJ15QnS4eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 17:03:03 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:03:03 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/3] Broadcast source reconfiguration support
Date: Wed, 13 Mar 2024 19:02:57 +0200
Message-Id: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::6) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: b0005e26-6d0a-49b1-6760-08dc437f7242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NDKyC7J8dWJLNFFZnZRJHTCkff3SKJRXkxCcbCpUGpMXYv/CY2SCe7zqq2W3cgd/7m1DZq4y4UL/jlsnOH9oeofLgtzhY6TyBNmXc/bfkWK8W7tm8mr+X2Dgb8xFhn19SD2V/joxd7Lva1LxsMpQLdlBwC+Mx5sqDf+XbX7M1A0s56ldHv0BAgynnVUdCmNLY0YIcwdmIrqx0l8azHr7rLCaoUutRTJzonmk8WvOHfMY5utWt1kLG16vNhmvaQR5yXbYQn2s6lYSFCiD5+6FQVhtWEG+9GYV73GJuleDJHe3U9YBiucych4hthiz0NdSrz702/04eRxjv5b0+sFHHpXwcEBUlNbWVqJ6Kk4G3EmMW5y7Weju8wXYkzKtyA6LuL42qTrvnLEulbMXawq1ITg14+JTTPU8eZoz0D1w543xZsJbt1Eu4QnXCLdPZN9JBBnqEoFZlsvp5Z4GxoWlcOwKMFV51If5MTEpB0nDxuFNHxwMvooymP2HnZwM0+eHDKHqQ6hFziCG6Utp3OMGmVRMJRwI9y5Mj7tAm3G5OP7EoPqejPKxAVQnwBlImiQjntUW7OZEvfNWUk7d4fAonoNlSgOpNGazP83/Vfzsn+MyLQlt+SryE6am6Ihrpg4XRabRyZ1MlhhE5Bm8sJu3ubdMIWuB/Zf/evPh2G3maF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zytv5XPBrS5oNFrT/lcYMYdwqpdfbQgWk5u03ZxY2g8DyEbvLsIKf2CM0L+J?=
 =?us-ascii?Q?kB9X5JVYPwnj1c31SVh2Xfbv0DNA2YpHCvg0o6N2iVFAwEap3Qsd8Nc2//Vm?=
 =?us-ascii?Q?XXXJO/FFuk8GUwxRiWA9gmU8rt4MDVlg8iTY45UpYzaBb0Bi8zdh5vQwa/IY?=
 =?us-ascii?Q?1OQpSaZj/5SSOogTTGoBOPy4lA/oWhS4h2fz300BED5yYRtaiEDupvHhQq2z?=
 =?us-ascii?Q?GEYtdc47Eqa156uVlFkLNpK4RHSEkNppBCte3UFL/DRo6BUX7Yl1iGg4PsrY?=
 =?us-ascii?Q?zf0jQH6e4lFlkPTztgOnYp48sWVdtjDzzcd3r7IK3ypP5Wf0aaJv7nN6Kx17?=
 =?us-ascii?Q?XckcUOj5mukIuwgmiJZl8jfHcz7yHn4bvggRfsSbOixo45aAn7/IwV1zPUFC?=
 =?us-ascii?Q?pzo0UrH0L2Kwl0oL+ibAV1Kvgkz65no+C4zeBlu5PgNh05OdaYBD6K2TttZm?=
 =?us-ascii?Q?Onixn0XrGN+L6xJasisrtK4mo9OL0xwfg6ycFzb1M2uYwpOVr/KXgnubk+XH?=
 =?us-ascii?Q?T1RS0SlYRn0Gqk8TRqAlnegmRR3VNV+e6GVoVnlnNstJ7GCOKPPdDcKwKPcH?=
 =?us-ascii?Q?kk5p+BfsCVdLunNffvo1EvoyEMrGItzJm07P5rdUcu/73u6M8tVcXfPPgjVX?=
 =?us-ascii?Q?sMMnLmyMttFIPRpXyNndZBgV89ohG9TpCbOehszzJKMF6B9cq0XnsVrcsYeI?=
 =?us-ascii?Q?boUDLveBgfUh7mOzDariSnUfde3lGIM1Huc1LyoaE0FOwo3eQgk1PfATbuG1?=
 =?us-ascii?Q?o5lPZmIUG6/TsV295fySwpAe1r6jl8yAY/E6Whp+e0w37RUII26MxOwpcCh3?=
 =?us-ascii?Q?6Pqd1jzyo+FTYFY5ezUDp9ytNgN5qekOhq+yrk3PNmJfhCQutZdDjBb965ba?=
 =?us-ascii?Q?h1fgAObZ7t57kwa4mF6YjdyaJ1b7tQ8PaIlrRCyxN2yHiw1/pWlx+iKDbZSH?=
 =?us-ascii?Q?tnSQ8niqw6EkV+6lD0YqrfrSaBOOZp/JNqbHYsY2QsGiL7EEouGI5Hi6iOSG?=
 =?us-ascii?Q?mrUwxQt7BzAeqpTBllV63GrZav0rdso1xGE0pBPNzx3Vk+dR61o0VBmkewim?=
 =?us-ascii?Q?n+ODcET3l709QAvuwVGaEIw67L+lW1/31scIGDyGvEGPjkW8jhinULT2HdOp?=
 =?us-ascii?Q?jeVNOJuJ8BggKpaD4IQyAsCTbjSGMpQM9f6pxCcQ3hxKY1+9y2oEOTKnIzCg?=
 =?us-ascii?Q?0yr5n9+wwc4pkwdNeOiHq/CxDKwRhbFKLDDsHc7TToUkBRjHH4Z/MenAWGkU?=
 =?us-ascii?Q?HXtIkUAEHezn+iuSYr8BElZDPjHobRuE2RE6tDA9MNTLwH14Hl3ML8RGfkuY?=
 =?us-ascii?Q?yb5tuyhQUvRFH61ImAHp0lGP81OcnYA7+gFI31PtQOTv1jDmDjEQZKb4wFAE?=
 =?us-ascii?Q?VcURb+akBrNWlQalZjZfcozxjFbc5aBlEQKMZAkoeyVZ4pWapWAXTNlbmx/1?=
 =?us-ascii?Q?NAOywX8O+s5NWSYa8h5MV1GuJqecAaHbhr7BGOs+/7/P6wrlT76Dz/A/zVuI?=
 =?us-ascii?Q?UjI/hs1RMi46GX0w+2XUxV86qrbTB8s8dfQKYHd4YctVG+N0HC3x+UQfAu1O?=
 =?us-ascii?Q?G6wjxLtleIAKphvA5lcckiisYLeaOcx7M9frjkJZolELU2YN365f7B6eRCoW?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0005e26-6d0a-49b1-6760-08dc437f7242
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:03:03.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcxdUTzcv8D2U/g216K5E9XJ/OSqaLRRnddeL/riAnp7AfFoNUtjR/IBYCaEhLSXIpl+x+mz/YooOHC+LzD3g9nA2XaNbOwrg31xRig/sys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

This patch adds support for broadcast source to reconfigure a BIS.
endpoint.config command has a new prompt for broadcast source:
" This is a BIS Reconfiguration? (yes/no)"
Yes or y if a BIS reconfiguration is required
No or n if it is a new BIS configuration
"The BIS index is assigned in the order of the configuration
starting with 1"
"BIS Index (value):" a value representing the BIS index if this is a
BIS reconfiguration.
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
BIS Index for reconfiguration? (value(1-31)/no): 0
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): 1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 2
[/local/endpoint/ep0] Enter Metadata (value/no): n
transport.show /org/bluez/hci0/pac_bcast0/fd0 to view the update
Transport /org/bluez/hci0/pac_bcast0/fd0

Configuration.Location: 0x00000002
Configuration.Location: Front Right (0x00000002)


Silviu Florian Barbulescu (3):
  player: Add reconfiguration prompt for broadcast source
  transport: Add support to update the transport configuration
  bap: Broadcast source reconfiguration support added

 client/player.c            | 33 ++++++++++++++++-
 profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c | 27 +++++++++++++-
 profiles/audio/transport.h |  1 +
 src/shared/bap.c           | 11 +++++-
 5 files changed, 144 insertions(+), 4 deletions(-)


base-commit: c9dddb642663b8bafe8998fef6132a2bb36d609d
-- 
2.39.2

