Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04821BDE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514927; cv=fail; b=dUB4oSGUh2NdTkMCWXaXkj6x9xtHVBZeZSJx9ud+WgRlYdob32P5YDanq27C7eSNinntbauJg1Zw4Jv8FRw+SO8DvCN/XXaV1eVv4J0arRFwFtCLWbMAtQp6oij1nJ8xfo/hvJ9aRvNcAdJBELpjXzcEMvN+dgJ2jJQ6R3JYa5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514927; c=relaxed/simple;
	bh=LUcLvKO4hLs1S4iIstRJDtXXezHmM6dfKuddd7Kjdw4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Iz51rp7ioTV/7tlv5KHv79B5Io1WRydqMQh+GlpBy/yCSu6BM+Vzh1fT7mrJ3RQEpd703TmOgU4r+/k+bAqo+VGHKp52gfhX1HCCbyoSAEzPXoQLjNN6jZahgLtKCFUNKbfk8P/JJWW8oMFAVR09/sX2bv0NhAU7nSoaWcCjGvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A/TAP+Q4; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/TAP+Q4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7jRe3Y4W/E5s1Ci5Lve50VWLxifJlwy7SKMb/3sjsXFkb578T19PcAGHi4nIzxh+ygNdT0SFcb25O6hXpzuIJuZhL9UOfHdhmuCgwW64WkfiWHRsgC5Z8Uaoe1LqNoEFavePl4+l81wnYt8UKWm+7bDZD3Vao00RC/wIxFF1jTH34Aecb3VL+RYVvM4oqXA1Z8lRlQxeemvs4XRjzvgvnRYiFF+AgmXWlgV0n84DZMRZpOsCKGWmtDa3PibPiv64QloUstfm9WZZ11euNdrr94GOeB5IZGYB2utTXXoqhvEhzHMwDiHJ3Vd1iFrNqAycH2wZKP0m5vfFGZMDvtlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7MUt96MSs7+qryZyhhmSSupkQ2k/k8MGHRJlO7TZGw=;
 b=f4H0YBQpSCRGzeodm2Y6FqzRIuLvuD/AMu1oRQUN13Ijre2PLW9r1Aq+EUHI6lVKuRUNET4O1FdJmqKiEIkrgSPONAfgVlhFjZUI5kz9V9R0KbP/UCLSAa3t/VSixI2ZA+iIG1f6e4JE/ZqkmTodn+pkeo4WJSKJ6Qv7UBw5adtWB5N1+vRLqY/Z4jTZ/J0PDfSgVDu170q4BlOGM4c1MnjqNeDCm4wEWdgZe67pr25Z7I0s9jTn1BcC/mD4uhdJmVFXl/YhlK4tBAmuHhG8Xs00xmJCfCsTAZUM8Hn0bwFngN1C/H8U+EnD+0onCVNb3Q8XiToYASS24Kz4Z3iv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7MUt96MSs7+qryZyhhmSSupkQ2k/k8MGHRJlO7TZGw=;
 b=A/TAP+Q4f2JRoeGo3ufSs1+M9hFwMilUlkic4yYKHIfyMx5GLaPGjs5eKPUEBhB0qBKcnX0AKeSg2Zo6fig0JQIqJY4P/EtUiRUJCCCPqQvi/LSk3PjYccIguNftLDF33TEr+zR05IvRX6QnttWpfN969g10GOiu4O+Ki7MWVFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 0/5] Broadcast source reconfiguration support
Date: Fri, 15 Mar 2024 17:01:53 +0200
Message-Id: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: fe33dfb7-2732-479d-8f3d-08dc4500de7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hJBn2+rlzUO+W5TJfDEWzlgUHIVIdqzo+XCIcGMguipI2bijmWSNZPUKqG0x6f3+j0wwBfpNVQYb4izCKVNiN1M6Ka4MY1Zk+5Ywl6OzMu+cSEWwKLJH0X/FYdIEHUSpSmvQuJQW9ERgbFRTxybnmLQ8UDjLhcjtQmAltdBRvMLp5/ejXBVyo5AZs/MK/OaEHy2BpOEXwHm+0DZ0vzoQZrh4q447ad7o3reORx4QLLHrQchQcMcn2DQoWXMd6uBt+IRgdy28e9wjpwQhiqVEe+dvmSqTfpfmNCC9QQocAjkAPXZGRrI5vqroXL/HdpbqGpdKR802aZEPPkJD1eWtP+xmsPGU8RMhyBjuYA1hwswCkxY/Ek4vRp63HxJeBPYAmMVyeDAQU2M1TjYSMi4bOdnY1aPeg1U40t4jpbZnDUNBfOPOVYL+2Bh5vKRLqpTitR6dBFdRwvHQtzyUykkYwzC82PQpUGO2kfmUNht48h3YFFVysONdGGXqw4NSf4MSxznBHzvsMrK6gzr7DWbGAinoBbghUauFBFLt+e+l1YRLKKHjNH5Rcojcux2u4txZ0lTCbo2pHyisSA+fxrFcSWEDD2Y1FkrW+TzGFbLoNsBkkMCnY7NbgHh8mS6umigK7f9E6gZpVvh9Js3dw6yIBlgkXYld+a5QempBenQQe2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2UtUuNPSePawGk+PXnfYFxheA8xcOpO4KNojphQ/VbMRzv6rnYMSXFHLaTp?=
 =?us-ascii?Q?kohx2SwAbOfcjSC9IBbVjhU+W/DgI0Wu4db9uhX78TITiPNcm31n5S8qSKeA?=
 =?us-ascii?Q?KusnbZtUfM5kPtGjeM+Xw83YChTUudOjKV1JdebsoCMiF7RSyIqckBZX3Pxj?=
 =?us-ascii?Q?Uq0Wkk7+RutKgvyi6vktuOHIue9VgXMG6KhjZjNnFlTVdnzlFZXw6ox00/yp?=
 =?us-ascii?Q?ohW+EYfWHCqLBkCd146jb00hchrgFROtQwu0Ln8FljVfZYHOTR8xBZki671c?=
 =?us-ascii?Q?6NqRlsX9rqzSdNCgdVCAyFr076O5/LYJNSo+nKDqBYnE/IxFvQqdOjEx0PeR?=
 =?us-ascii?Q?ItmLY+Coylmg/AyuXSZzbus8X4Kzyxd1uTcv4++6CQEmwOCXn1+rJ2jpkH+q?=
 =?us-ascii?Q?ygXXaaXbsY+dX1IopDxxpAxstPZCzmichGfIRq3MHizYm6FjicZtHxr6rhuh?=
 =?us-ascii?Q?JYgpGzT6N1k4lHluuZMAyTmADB+gjaVB+VB6S8Y4r4g7u9N/S0d8HF2KQLmK?=
 =?us-ascii?Q?if4RWe4XnFXt5G5tNz2ebFu6TOdXvW/aglyn3kInNAwc0YDkjOMUpU5mXAi7?=
 =?us-ascii?Q?4JyaP/AvRvRv+FC6XGxiYvpS12YiWWsHu2my5414DoQxck92o86qN9niPRf9?=
 =?us-ascii?Q?AcwPV6Vh1ZhInqBGwAJt8O0SO8T/3KDq0Qwreb1WxNghurHerboXPXazPXBH?=
 =?us-ascii?Q?gbJMYorwtS0AyJQ/GO+2on0SJ5UjDVdawg0IlO59n5w9HYiJ7Cy8WK3XUioE?=
 =?us-ascii?Q?LXnsKUsTXq6nmymEafnrjya5xagRNY4SewCk1Q/TiL++OMviqBfYaZa+xYHp?=
 =?us-ascii?Q?aca72zbZyVWaJ1CuGIiCujBwfpIel+e+WcQjs/xx6h1Y3oPbc81nfNblC3PV?=
 =?us-ascii?Q?40Sn9Xy5jhkPcmD1A99+dBD9K6N/0UE4v5RaDM/H9gIXoATu2wRjrxxOQA9d?=
 =?us-ascii?Q?8xxViHxdLqPOJbhZY3YlubdURVykTmldxBkKqQn8PNez9gjARiBkaspaar8N?=
 =?us-ascii?Q?hX64hfqFl6Xwh3TGp49e0wd+5YFBhRFQUatgV03es8NjocwY6oxJ1J6cS5ne?=
 =?us-ascii?Q?2wnmY33E1mZRoKywNoFWZwDpT4ALK0QOXVvUGXBlL+Khyh6kTfGzck7ErUsy?=
 =?us-ascii?Q?xGLPTjdeNoZTssQxnEnQnQvQGnp1pMTPy4pXt6lMjUTjf3IcfvQzTferbjna?=
 =?us-ascii?Q?U6BOSyh/YCk83vlEFMBVF/Qbn5c2RImQkalAbf21xVscWLONY33eHbDAX3Ea?=
 =?us-ascii?Q?/ir6V06qZaCL8y6tTAseZT+0VuLGQ/kS9Wj4NO1MhMBPJy/hXe2MAQrRkneD?=
 =?us-ascii?Q?60jOH+d4bwtjAtRfPZbC0UnxPfyG/iAWMGvZ1cBPJsRPozRgg+eX3pFNAURd?=
 =?us-ascii?Q?ACjDy7FBTyi5oPDn1pnppgDGOsCa7+fxggMl6418kzsiNesomy32qj1e0fmu?=
 =?us-ascii?Q?YgA14XVvhW9IBJCcRk8XsW3WrHEek8bdydmcQZz7SIkv6otW9I0GSaXmczhe?=
 =?us-ascii?Q?z+dwh19nsJmdzgG+9FIkRySbZ1hYbEJ5/ahttS2qWCHgvgZrXjh6Bi6O76l1?=
 =?us-ascii?Q?h2vc7+09txWuZ/qg0vahC7shLgrbAPxmp/rOzvXZbwDcjsA75gR5vcxU9ilj?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe33dfb7-2732-479d-8f3d-08dc4500de7b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:01.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHzBYAnO5GmdMBoKeLh/eflY/pf+47BtQkVS0Oigb8p1RI9kYB0F0k0d/MVJ0+z/YpDxcNevRvvRNu473U6T7zacekGfNBzO0SgQSN8ejig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

This patch adds support for broadcast source to reconfigure a BIS.
endpoint.config command has a new prompt for broadcast source:
BIS Index for reconfiguration? (value(1-31)/no):
Values n or 0 represent that no reconfiguration is required
Values between (1-31) specify which BIS to be reconfigured
example form client/scripts/broadcast-source.bt
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
BIS Index for reconfiguration? (value(1-31)/no): 0
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): 0x03 0x02 0x04 0x00
transport.acquire /org/bluez/hci0/pac_bcast0/fd0
HCI Command: LE Set Periodic Ad.. (0x08|0x003f) plen 41
Handle: 1
Operation: Complete ext advertising data (0x03)
Data length: 0x26
Service Data: Basic Audio Announcement (0x1851)
Presetation Delay: 40000
Number of Subgroups: 1
Subgroup #0:
Number of BIS(s): 1
Codec: LC3 (0x06)
Codec Specific Configuration: #0: len 0x02 type 0x01
Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
Codec Specific Configuration: #1: len 0x02 type 0x02
Codec Specific Configuration: Frame Duration: 10 ms (0x01)
Codec Specific Configuration: #2: len 0x03 type 0x04
Codec Specific Configuration: Frame Length: 40 (0x0028)
Codec Specific Configuration: #3: len 0x05 type 0x03
Codec Specific Configuration: Location: 0x00000001
Codec Specific Configuration: Location: Front Left (0x00000001)
Metadata: #0: len 0x03 type 0x02
Metadata: Context: 0x0004
Metadata: Context Media (0x0004)
BIS #0:
Index: 1
transport.release /org/bluez/hci0/pac_bcast0/fd0
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): 1
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter channel location (value/no): 2
[/local/endpoint/ep0] Enter Metadata (value/no): 0x03 0x02 0x04 0x01
transport.acquire /org/bluez/hci0/pac_bcast0/fd0
HCI Command: LE Set Periodic Ad.. (0x08|0x003f) plen 41 #47 [hci0]
Handle: 1
Operation: Complete ext advertising data (0x03)
Data length: 0x26
Service Data: Basic Audio Announcement (0x1851)
Presetation Delay: 40000
Number of Subgroups: 1
Subgroup #0:
Number of BIS(s): 1
Codec: LC3 (0x06)
Codec Specific Configuration: #0: len 0x02 type 0x01
Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
Codec Specific Configuration: #1: len 0x02 type 0x02
Codec Specific Configuration: Frame Duration: 10 ms (0x01)
Codec Specific Configuration: #2: len 0x03 type 0x04
Codec Specific Configuration: Frame Length: 40 (0x0028)
Codec Specific Configuration: #3: len 0x05 type 0x03
Codec Specific Configuration: Location: 0x00000002
Codec Specific Configuration: Location: Front Right (0x00000002)
Metadata: #0: len 0x03 type 0x02
Metadata: Context: 0x0104
Metadata: Context Media (0x0004)
Metadata: Context Notifications (0x0100)
BIS #0:
Index: 1

Silviu Florian Barbulescu (5):
  player: Add reconfiguration prompt for broadcast source
  transport: Add support to update the transport configuration
  bap: Broadcast source reconfiguration support added
  player.c: Remove bt_shell_noninteractive_quit on  acquire,release
    commands
  client: update broadcast source script to support the BIS
    reconfiguration

 client/player.c                    | 37 +++++++++++++--
 client/scripts/broadcast-source.bt | 12 ++++-
 profiles/audio/bap.c               | 76 ++++++++++++++++++++++++++++++
 profiles/audio/transport.c         | 27 ++++++++++-
 profiles/audio/transport.h         |  1 +
 src/shared/bap.c                   | 11 ++++-
 6 files changed, 156 insertions(+), 8 deletions(-)


base-commit: 84628e5d109cbec0bbd515c12c4b5224380784fe
-- 
2.39.2

