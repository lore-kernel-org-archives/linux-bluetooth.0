Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26492137930
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222485; cv=fail; b=SLdMNUnAILc+5T33Vp7Cpq+912C+L5Mi5gA/eXd4Xj5q1fnC2V7MoEh0E3Or6Cak+OOq0BM8Zvaxo1GnVf4w9UBLeMnVu6FHu7ltjoqQwlMv+SsSJJGkqx/GTEy7xpnBv9BcNK+h35/q7p/gZHqp0QfVSzBC0yxZd6KP7OUcZbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222485; c=relaxed/simple;
	bh=d8aeS6Ffuctl78fBSa2D+lxepvoH2QvDqFNL4qJEu4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hZM4owMT7Kr8ikNAvOPGBtKpq8zpO9JJRjgdTpKsXTMChBetO9FLM6RAQ0N6FduawFl+LrwzWMNWRBDU6N9QjW68eRUymhFR+67GPwJGWXRcBok0Uepoim2vdnwmKgXz3mwzeNmhHd1qQlVRlIlwVg430667FgqTiYUVlYvNCtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jx9pPgCP; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jx9pPgCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYMP7afw2EZ8B8yu9uiCU3S6hVP6MPvCcdsduoN0YRCIFZ3LC4A66J/PGE6NbR9795ULY5bxA9caW8nswlUbYM4jdoMeAnHBFoL55rl3tovWpHk+6MI7CbdqPEgelaTMadJpsVxshIP8Z/XGsH53szkYi6G9vfNR6NwtO+/8e2js5/PJGyi4klqYceZLMkLL4RPz+3vauAN67iquwoy4/kB8yW915bUUZxx2+eDOftIiT45mnT2Sr+yyBSKb7oNXk1HsL+TuYxsUnLtOkZEQrXdRW0rvw3DdtT6SVK1XxU7LG79kh02hGT9I8ct0WEHCkZhnzlW9bVMxA2TWIfMktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdqhsbDZcrI+PpO/NPxvUa5RQcFJQW29FZpfx1uFHq8=;
 b=Vf9LgqOZ3Mh04j+ay6pKkAQm/m8ptm1r5X6vLXG3mEe6u8Sqz93AXTHXS0lMcGnuODpQys5HRJOcAvB+306EyfW+xpUarQUDlX9j3s93dH+WgC81+3Gg11CQ3IayWdfUZGDKQwvcJn5rSKl6V5qHA3iuIrcysyxTDGA4nOTD/I+0nn32jlxzT0UBVGObjj2oxGUEIEUC40lPuRE/zaN6k9p9xLYNojkbEGOUOz2UFyVDAfVvw+/mPtbkOxhZMRg9U9okEid3eAsKkjrigk4SsieQQ0LygTI6ua2MG3jAqUA6ITB1gNFsWpR0tHv5zsykILJLiUPa6stYuZF7vVNqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdqhsbDZcrI+PpO/NPxvUa5RQcFJQW29FZpfx1uFHq8=;
 b=Jx9pPgCPBRb0vcR4NoNGwgY+/KkJDc4LY9Lp//vxLzHEpc3AvS9EKu3cXNO6zrX5aWRct/Vku6EFxvR0ckJVSI7hKtXyJgvw3OtnlNiQbOm+kvAOct70gbmCHEfTmamvn/r5xXpJRo4bc0tkGrAuRjIIJ/HQnfRfmJaczcatoBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:28:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:28:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/2] Update BAP Broadcast Source state machine
Date: Mon, 20 May 2024 19:27:55 +0300
Message-Id: <20240520162757.78187-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::47) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8845de54-1709-44d9-ed62-08dc78e9d117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3f5PuyzA42+go3RqscWhsk1Vbjv3z1rHo9eVWmZ/z9C6fJqqXOoQNlk6RQYj?=
 =?us-ascii?Q?B1VtpOHBNeF7CcC2HT4kP0fpN7jVjE9zSciRXNmlUFoKy5uxJ/V/YHSF9j76?=
 =?us-ascii?Q?JD2BW/sE7bGyoenXai9QjatgNjvX7ll/2iePtOEtjsmWQG+lrjHemH0Qao5A?=
 =?us-ascii?Q?y3Vc0UP3JDA2/HRXjkRgYGG1dtFZg2Kdq+NERi9awpn1+KRlgWhVRgs1vxNa?=
 =?us-ascii?Q?llAxs9i7Q87ipvn/ypEbjMSxjQx2NcftYLHZq9pXgapwcIvQNXKHa4nFg8cU?=
 =?us-ascii?Q?/tbq6waBzgN811nQsBxNVWnNjpWxpJ4nrNT12h4Kw7uxkQyOHraHmWGH5qcn?=
 =?us-ascii?Q?YTS24cSYsLe9VojJjkoUcIf806qdlpQ+TotHYBc6FbdlhQMkadcum93u1eqM?=
 =?us-ascii?Q?xIYod9BN5MfOUlX7XOKL+SsK8ZliVf1xbucOasAPxw6rg3/czZ4zbWVd2h4L?=
 =?us-ascii?Q?b4VCdewG5xKXST6COm1H6f35CShLk9UjMH3fY8ux1zCd+BRH3SnvQ4waTr2R?=
 =?us-ascii?Q?av3T0CBGyNKtvFIw3idRueWceuAXLbwXU/G4TkfcZT1qPvAEYBfv/dqwxzq5?=
 =?us-ascii?Q?PnpHpSEmAcyTo+/pz52EvBRz4cd/ZzDjYaE3fTB/dw5a2Nc0qjy8clLkF1si?=
 =?us-ascii?Q?REdDvP6oQfE4S7vS7q68M2S25pgiKwXeIvycJmD8deF37V/R6dugq3QBSAtG?=
 =?us-ascii?Q?iFc1pb6mQjQtqYKvvmy0vWJmwDrjbwyiZfmMKn7Rltbl5DXn3TAkINFi3lq8?=
 =?us-ascii?Q?Ct2tcsH+uOKpPYMN4n3i5JCxlFzGCSZcfHxGam8kmdl+JTda5d8+kSdKi1Kz?=
 =?us-ascii?Q?YjeHA1Yj1LUkwnRaRwCnTWoA3bj7zNRl604hhJnsV3VwGZv3JvDLnVRGeb+L?=
 =?us-ascii?Q?h9DN8g2ez5OGbUwVjqk/n8UYJUljvA4rayE//HNH99YBKFuoqYfjgb4SveiO?=
 =?us-ascii?Q?hEws1dOEir3eKQyYbQ5ZQKeKvXhZZTSNVK9RikO2qCSue/Kpu1SN87GAh/5G?=
 =?us-ascii?Q?QV7aNgTAR/2wMeh6dsv6/pjE3wH1+IxL5H1kVnMr4tWCN9TVtlNsaOFaqH8n?=
 =?us-ascii?Q?pwlR/O3gLJ5gfcjbNtC4WHOUOpL1n3P6UeLmoiuVdVxUR6a3/KRw53b2SXgh?=
 =?us-ascii?Q?kHu6U1VWWQp+kz+SZrE/ROQSZZ8+aJMFdpGMuInC7bD3EqZg5H2ccytNLLDP?=
 =?us-ascii?Q?t1LsItBZGdKrzGFV3NSWyC3aDTxC1XeG3PaS8iGa2C+Jm7yYECmRxGKWhQjQ?=
 =?us-ascii?Q?Zwpr2calayYIrIgSXxVVoKReWfooTQWAUlP8o8atZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YyPSN/iMLAB4ydPwQVyqJR/iZJDJr1PJod7amd07groAZi+YhiVTyL7iFAY?=
 =?us-ascii?Q?UQ6I+ebzSnOwYldot7hKs5RL1meu5w9YbS+fDjEF/z7tOUndhURenuBvvOvW?=
 =?us-ascii?Q?Qu7rwFlaMIx1q42G73mxmDwpWFl40n+ogG7Xf4tOB0cj3CSeUKNNgHKFiJrn?=
 =?us-ascii?Q?w8pBUof5GzDdkV1NqnBp49jTgn1BSzGcMgQeSxuruzQ/1/Ijx+CBiOjtIDjU?=
 =?us-ascii?Q?SkdS8efsptF6y3P4LIS4WzgCg6R6ISl+eynh9aDpb7twZG8mhXm7tmaeuOCf?=
 =?us-ascii?Q?GaBOb+dh8BR6P9djlxyQvs9N2vFq1zBJeEOzsEQJa1rqstEJXOiNkgktn7IH?=
 =?us-ascii?Q?DEtwiO6s3wajOlzyFOUlddJU5IMSxHgXDqxiuC30WBnxk/ELBJt/NqiNp99/?=
 =?us-ascii?Q?+Ql5l7ntdMwMOsO77ErgksXuptOZw7yBbRFr2VduJHxUqcY37EPGUBHHAH3B?=
 =?us-ascii?Q?LsmjkltWuYv2OMdRuYdN2O0ZtBk3x2/PAScWkUX0d/W1B9hpvHbGTY75s5ZZ?=
 =?us-ascii?Q?K0wZRZnFzqyglKXMzW2QHqMcY2MP1N/7eGZzdIOhYcw0L7b5dLuKUHDKWwrM?=
 =?us-ascii?Q?tAL2EMMfmS78dBcBFYeAHariEk5RvI+nI6JHX6fGCaLnXf3pzy0kcx2jMrBo?=
 =?us-ascii?Q?A79E9HDFUjuBbZwR8nxXoYhPaDon3ZlAJpCDxxbL+kv7CLP/pYnryqTc2HCU?=
 =?us-ascii?Q?WdwW2w7hSvc65+zdD7ZI6aOSfJfy+WmrTQj8of2fdL1i2AgMG7LJnoFZhU93?=
 =?us-ascii?Q?JkgekKZ54u9Th4feA66bXRRv8DFL/wsuvigXl1zy+6M4DYxWsNvS7NyUBj4v?=
 =?us-ascii?Q?aWvRenqWYxWTiYJyEJP1bVh1jIoDRzgXIVFMgSC4D8BHur6+JL3F8EcFDF+F?=
 =?us-ascii?Q?XYDj5HyPnYP3gQd1llE2lJO9HCvg/qryyllU7DvnfCuaMHKnJtnaRq3jUBU7?=
 =?us-ascii?Q?deAhps5Jtu7id6JNMvgXcuTJxbhvkOD75gRj6IaqgjioPaCmZlRxWcE6wBvQ?=
 =?us-ascii?Q?Ji3MfEO3yRDsWlfRgl3vEp9p1x+pqvvfW6QL1KYRxg204JUZivwemJQtWoCN?=
 =?us-ascii?Q?Tn2y9/Eb3tUZK09S0E+Z9ZHOHsnKbbz6AUdP/U35zjN7v2yLUntPFvp5VnT4?=
 =?us-ascii?Q?ac0klNK/QiT1UlJE0NH3F5XntAAH+RwwTHUIJ2VKHC4w1+RjAAlWXZFbeTcW?=
 =?us-ascii?Q?/3ZSuPXSaPZBHMa995/cO0E9Uwb46CSbqMLJpdoGIK0LMfu61BQr022FRPj9?=
 =?us-ascii?Q?RI/f4HDnslGWz1QmCDxbZ8yK9gqx4jxzCBbPSqRCcXEkdRbo/D9+jLM0UYf9?=
 =?us-ascii?Q?9jxEdD62enz6qFQwDf+Htfeh6oIDaCeczOw61W+4QP/XPTW3T4+ZzBizXFhP?=
 =?us-ascii?Q?bPV/aruUlp2G7LWyOKdvOg5QqoWs5tqL4fF8sKX4amsR0ZGv/uioTvRr/EBa?=
 =?us-ascii?Q?0EM7qnxrTa9vcrCwiwK2kwr24I9FU36Vzz8kDa9pElnI21ZFuEMQpu0Sh/8i?=
 =?us-ascii?Q?aMGf1+nNAP2T+XOTNF6Qgkqy1ABy0RqdW1onU6mMCtUSo4uCqXHtepYxyrtr?=
 =?us-ascii?Q?dv0zNwfBlDSsyJrN91pbiGMkcbCqLyqC3N/eNdBf7PvrCIVCF6PFgVZjydTo?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845de54-1709-44d9-ed62-08dc78e9d117
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:28:01.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlKi2f+ac4wX3uTEVOQ7ka8mAfD2w/9Rvtr/xWfemONK85W4rOhNisYzWQN1+gDoQkx+uxqHS4xp7lP6B9Pv9ke2vJKI3BRw+Rt+lW7+ecA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

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
  shared/bap: Update BAP Broadcast Source state machine states
  bap: Update BAP Broadcast Source state machine states

 profiles/audio/bap.c | 13 ++++++++-----
 src/shared/bap.c     | 39 ++++++++++++++++++++-------------------
 unit/test-bap.c      |  4 ++--
 3 files changed, 30 insertions(+), 26 deletions(-)


base-commit: 62d38d6c9ef4017ff6a84af0a9cd9242a7f6a211
-- 
2.40.1

