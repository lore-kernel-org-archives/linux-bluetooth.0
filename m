Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCD218AB4
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705917; cv=fail; b=OUHbL9KbDMZ3nYrupWi/ryTfhAjhJkuhvZe2VmT6D93sA3EstIRVxO1BP3+8IJCxx5iysDA6jyxPoDLkQ8zVMoyb7KUkeZ8jPN2zM4EBZRdvfEcRy77t4i9VWKS+LU/yJR+aYaXgNykM2+VYoTsuOv9178KdYqOpwKbCAvDJiYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705917; c=relaxed/simple;
	bh=fDyzbu4skCw6Oxlh/rLVZCVAcRtWWmmjgvrTUNC6ubA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FcpsuQDFQtzNrnSV8et0gJSf5D+QrK3jDwXiP4Qd8TJkdvsfev4ReifK7RhnOaQFPvqMyefMsB98C9hmAAmI6ywwjgh4XfgSpeEti+e7819xCBuRN8laJsojEFinRtm0GIBjrqZYU4fdnqXSrFCA0yxiu5AngkWDPtcmd2273eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WD/BUVMX; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WD/BUVMX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scVD158OPsNCyuPd0kFy030m1KJTaA7NezJBAScsFmlfgS8sIwxg/UujBjLBmLBHzAyv227lPEIw19u2Lf+Lo8A6KEWail/XrTB5uNFkzNawX8SX4sIOr3uBeqoOJ+NgDTLlJQv5iHVI15LO3jR3xWyMC8XQu4P/Y5mQS/eq4wvwHriIaiYuAQ+CcJvAlXdyuRiif6+J54rESYgVHV/vyibRVbhXroOlM7rZGKYNUs9CYBJ6hcXiGiG8G5xHgBBvOqaup+6hcYYwqob3yEVno0VKz2Elb+crhU4whIjE8G/5bst6QF9Ma9hO+hrIEp/hMWFk5aRzpj0lngSVaXh3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t77ePn4P9D9wq20y6ne9eZ169Zh3EIHOEVYiNDL6mfU=;
 b=OT7lLWdtxhFm/xyY7yEjZGCyEcOY5ZU8SuQ3zBla5wg+/mZiHiZcKKAiWkwddWBL0kysDr07AMNW6ZZpBGgvOJoEpgxDhUSjxK4CWVIIGS4C2swsC7zFeMint0sH0FeK7hKOkpzTMFzsWk+4+Pqxko3rtSd9F1Aa9StDTtecBQtMfOPdyXxwhcPYVdsn0cemA3Vl53FjKR/bOJEJB80TFL5MZgZUe5bIg4WyJM6ZtdKt14jvsnsv2Eu0iHjRDU4v49l9i9hvPmhPJoBHMELMRz41gx1j9IOnKJn79M97TDeqKm481GDunxlk4tCOkkPN2ClsvGaXTzHTUxWty77eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t77ePn4P9D9wq20y6ne9eZ169Zh3EIHOEVYiNDL6mfU=;
 b=WD/BUVMX3H2fs4doP3Ti8DHQTgTBBewVYNmHmX1MHn31QfUelsCUz423CwHSp8i+SEmNb2K9yzI3oJyw5cVoyurmUVQ/5a5ebYo4Rrt9RCvZLG0K9pVE97bpb575TMgahLthJkg/MSwJW7SXMqTLwA2+ob3JBhlsgJH2eVdPWsNo9izCjv3ppRClUPBfYa0HFDfUbM6Wp27hPzJXrEuIMlkpVD+CoBY7Y02KkJu4nrrVFgP4S5dPpTx1ztxgZkyrX5tLwtfoZRhTHvfS8xTVziibPlbIOwEPp6P785KSRPnFNJuySvpzVCyafZZU8ItQL1in0aZp3w0P3x3sVoF1gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:45:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:45:08 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Rework transport select for encrypted streams
Date: Fri, 20 Dec 2024 16:44:57 +0200
Message-ID: <20241220144458.27739-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0043.eurprd03.prod.outlook.com (2603:10a6:208::20)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 74283a56-b75b-488d-9e8d-08dd2104e654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wqiyJIb6Tc+e4vQoEXNtWLDVhIp0HbbfC7iPGeUj1/xD66/GnKeeqlH0/TRu?=
 =?us-ascii?Q?l3x2tuQjC1Hy8i0RQz7XvBCzfoyGQ0wFpEH170v2rR9oWfzcTkupZYjMUlKM?=
 =?us-ascii?Q?B7k5TkPADYr4RN9JBXsfFvps+auSUPPxoNdm4AnGeH5969OlYUOID1GgR1gO?=
 =?us-ascii?Q?NO6SoG4J2DF0dAplYcA8zMgYboS9hK77CvsDIWj08qO4opBzZxbjrUZgm+3D?=
 =?us-ascii?Q?8sk/k1tuBfvRbV2TUJEoEuHzPiUWzwlQzyPrMczR/JWGMX6TGEkIZx/brnsL?=
 =?us-ascii?Q?vRB6jl0ilcUPbqfjGmd3pI++d+oDvnri4kQjpIZSQHpskSOpyMY5o++UfqNU?=
 =?us-ascii?Q?XGi9DezuqxAKuyRX45L0cYOUtVe/5mh9qAEo4g579ltF/Db02Mb2V74ZzanD?=
 =?us-ascii?Q?XV4vNbyyzD+4w87LtxxFEt6ybsttGRrIpnftYuzXa3YnOkgGRAyi5HuF00xd?=
 =?us-ascii?Q?zdIcF/5DlD7RWYUeguAHoBOiAM5hr3yF16G/Z18xcHbjBdxW7WlZyq4zmO36?=
 =?us-ascii?Q?kKHcDwzNGpLrPjZMJD4wx+zMn56OqIDRX73cF0sXm2R6TQabPFO3nUKs3AF8?=
 =?us-ascii?Q?VRK3LLtpqpiiBnC95IpDe85SCF1nWe0jcOVaO6jlh/Xt5awTDk1gQyq7Ac9A?=
 =?us-ascii?Q?kb3o5Xj5aKVWCnb4ukAM/yN5JxIjqqN+CfvTMc6TQhWRQopUQp++nFfGOywX?=
 =?us-ascii?Q?al13Uw28queojNu105PwgTpSCXAJwKXSScEjOG9UHvmbDABa8L3VP/4DllMr?=
 =?us-ascii?Q?FCxpwr5g5peN31sXCrtWOk2MSgpgWNSvXpFu9PJP6VaVhRU1ya6+y+gMMMrZ?=
 =?us-ascii?Q?94Ik327eZ5Y0j7ddIVMscjpvHSnqkEenXRkhxCXEjqMWBSi7N1Gb81iwXOoY?=
 =?us-ascii?Q?cgjUss+aj8Wz32+hs75VeZJnA5Yp2Y7VHHfEHrR6Rg3GrniMdydE5g5kLNRS?=
 =?us-ascii?Q?JpuV1NfAAc/vetXCUctzm4Z9/bTwaXT4CB1YHfWwjUmn0wGnJaPJ6WlmwJO/?=
 =?us-ascii?Q?pz4wUOsX/1gGh2068zPYsm/mSR+d3ffCF6Jc/blEonCOAWrdhOwXstytoqf2?=
 =?us-ascii?Q?z+QvjcG0Z0Rs0DqkbVBGm3UrVrbKNVAwUDqTmvpl8+5YuH3ociHfSB43kS6O?=
 =?us-ascii?Q?ueyyF7OjQiV+AVVMkmxRrQ5Btct41teRgsSZKcIqOeYl9h1J6QhLYV3W9r8L?=
 =?us-ascii?Q?ApUnDKm3eS7imieed0ZpHbQjuXSQ9ij0J7RnCXFjB+txEJvDsvi2oe+TML2g?=
 =?us-ascii?Q?YbqcduQ/0W1lySNYxOzZyBGUflCN503io7ZCWQCzOYowSTSgEGSFXIlavWe3?=
 =?us-ascii?Q?8Lid0sT35qVp/VAiQqcU0rFi77JCZ1B96U/4uC2bUcIf/WdKa4ch+WuJSLcs?=
 =?us-ascii?Q?gLYT2lSPxdjrchOLnTeEYwx+VxhS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5ylRpAp/ILzMfJcOgbojABMYp4MD+VRspMk4VzgedGoMboSAwAfzdoz9mFc?=
 =?us-ascii?Q?YivEu40VJkfdsoyaNVyR3NgR+NfgLBLIyEZJL4xw6K6H6RprUikrGoS8nwwj?=
 =?us-ascii?Q?GEkiaGci2SmXMZEiKifMXpW23uhYd02Ccdg7XMCA6I3LrZpb8nXcfisCTKw7?=
 =?us-ascii?Q?ZggsmC/3gYUttBaTncxK6QL+0AhFn/ROkCmCBFcY/iO3DG5gm1pTzsomMAHD?=
 =?us-ascii?Q?5f9CrH6weQCQotXSdbC52FbZuxMWQje1Tapt/x4EwULFdo3yG3VUf0JioyhD?=
 =?us-ascii?Q?P0jKghPpG0QQ4qGznzhm50v42eUYz95gTtW8GGUvw00rawy0q5togQ0W7ZrM?=
 =?us-ascii?Q?rbf6S0/oPXk+YuD+0OHYGvMqndGa+TigW1Ynu2ir+tWVxm8pXI9q3AZ8j57v?=
 =?us-ascii?Q?AtyTv5BowyZUlIy0cPkDskS+YBhH927CalmUpfm2yxCPrxlN5SOnpWCzhtac?=
 =?us-ascii?Q?JPLrMH71mnLRRoVH+IfKNFpqn/93lWBTAJtDUQ8anD+djQLunBPQFXuP3LG7?=
 =?us-ascii?Q?V6QVDpgS9hm8nuYCY04CT5FYNYIkyxSWLzoBMgQUPl92OKGlJUHNj76n5ueX?=
 =?us-ascii?Q?RtSCJD7lAE8AeG4/9p/ZMzJn7V+gYBZxOQy3SRUys8bpFfkymf7gk5BTea9i?=
 =?us-ascii?Q?+ZDNXRQYwt1CHTwr0CQn54sDF8eaURNv0g1MbklIpL0QYX9+hDXf0zHB+gi6?=
 =?us-ascii?Q?FCorqfy5e8HEU67tfS1qmPirRmi1De0IYs5SpvN4bJ4WNcdanj57cC6Fd4di?=
 =?us-ascii?Q?J79ZQQPpVb5DT5t0+b3NXOuFbinXQGIgz6dx/6hLzZkYshuvCQQgd3BMSIKw?=
 =?us-ascii?Q?lLxMXeii4WqkzOQvkteCf+5yxiB77RSRqeYfttjyHIE3qOlI5mtCYmixAH4z?=
 =?us-ascii?Q?yblSQIKqQyxoE0yrh+BZV3NNqpUQHjV+kffrNPXhrDBG+RTT3Hkwm4q2mDvA?=
 =?us-ascii?Q?0CDI47haWwPCaQYjNa8q1DH/HTIXgRcGJcTMiq3b+tSPQm+YabUsBzR8JG9Q?=
 =?us-ascii?Q?Rv74amoGG0I2TuFRjCSU6hVjQJ8mKgdi18mkU4ETcaD1n7/XWWhyFqbMSQhc?=
 =?us-ascii?Q?Jwvxp+fpAzsaQm5TEnrfUGvpPb1hhXZluyu759Bdt4m3r0OLVQmg1srJnHrN?=
 =?us-ascii?Q?v0HrZP09AV1wK7FB60Az4W/oClnEH97k+tKKPwQYivgG2rPOemwK2Xh2kzok?=
 =?us-ascii?Q?JMLMm6FMnYsUv2fTBLY1Ds83czN9yPhbPE7NXrOBwIwqw95oSi661paqngcF?=
 =?us-ascii?Q?MVMQaTmFhekJPVB8nZEgQ/3k5I6ODYHaJX0HpiC4/1ter1Tz157BAbMLBpoR?=
 =?us-ascii?Q?6gt3/Dj/FtDuizpRaOuCMk4aJY+zVoqrwyQQ45xcL+2ilwyi+Ib6vFmqc1YS?=
 =?us-ascii?Q?lgI3zTSAhhNgXyKKnlSeE3s0gswOiHH/7wpVkiPZZtjW4sxFjAWlGlFo9b2R?=
 =?us-ascii?Q?L5zFo1X4HjoZN7zVbFPScO060uCKb1hs1PW1unDBMKyZ0pzuNC5g47BOV3OG?=
 =?us-ascii?Q?0WU3iwWO+p6iQtFHGYPiUVDsHber4DAXPFEGsjKs/oTC6rLVAcgbWSEmIuMq?=
 =?us-ascii?Q?qLmVYGJolYx6XuPdwC35HukfZneaOY+0vzxQjAjvipsDSmMQxHszU1mwFFy/?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74283a56-b75b-488d-9e8d-08dd2104e654
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:45:08.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IGrPtcwJ3vW65NzR1LemOywgP5bfB5veRUrGNpwTcLllHWcHJSF3eHT/EEHQkp/Br8MmESGypSwPkeC32YAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

This fixes the transport select flow in bluetoothctl: If the user tries
to select multiple encrypted transports, the prompts for the Broadcast
Code overlap, causing the UI to be distorted:

[11-AE-0A-C1-F4-30]# transport.select
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Borne House
(null)Setting broadcast code succeeded
(null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     State: broadcasting
(null)Select successful
(null)

This commit updates the transport select command handler to first
link all transports before setting the Broadcast Code only on the
primary link (the Broadcast Code is common for all BISes in the BIG).
After the Broadcast Code is successfully set, each link is selected
one by one. The bluetoothctl log below shows the updated output:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 11:16:BD:36:58:3F 11-16-BD-36-58-3F
[11-16-BD-36-58-3F]# [CHG] Device 11:16:BD:36:58:3F Connected: yes
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-16-BD-36-58-3F]# transport.select
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-AE-0A-C1-F4-30]# Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
[] Enter brocast code[value/no]: Borne House
[11-AE-0A-C1-F4-30]# Setting broadcast code succeeded
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# transport.acquire
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2 acquiring
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3 acquiring
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 11 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: active
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 7 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: active

The BIG Create Sync command is sent with the correct Broadcast Code,
for the 2 acquired BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 426f726e6520486f7573650000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f)
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)

Iulia Tanasescu (1):
  client/player: Rework transport select for encrypted streams

 client/player.c | 159 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 32 deletions(-)

-- 
2.43.0

