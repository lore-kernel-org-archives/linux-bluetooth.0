Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621A53379
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779942; cv=fail; b=fCAbzhxv8HfxbY0EZGbTReu9LR4ZHBM+5CLVSOekDukZiyWqxwvLNOgEN1aBTxoEnFvy8xG1du8zgGFKiQ/F2ZRgIYvkF62Oukx6xxCqnzPJUfjFrj855zvuhZaBJTQK8hemXA2xp2MJl4m6vp/IN1jED7lDSKPHOaBhOmlDniE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779942; c=relaxed/simple;
	bh=yeURGILriQHArK3X2sq+b2XajEf7L+ri/9V/vTYqYnI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MW4W5D7iBJt2ZMqIjgCpoMFVhM/809h52s961t9do9mQh2G0CcqCIQrERbZjEFl6r5HwXjgOUV/X/fOf7Lc4X4vpH4soHmwVt0QSBhe2eDRFGD0ojZJ6reUFDQ4l4gyyPL9cuDC2w4IjWEU5YxUim0wjcMle+Okgp3Uq3CsD8NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3UrToYL; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3UrToYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcJaXkR0yNvPXJpoklmk09J4UnzLXY6pDaUq8KCUpDBOD5fOsjccQ+EPt1qtPPiOdc1bzd7TUwQOD5DD3DZrld538NmKtuJGsz46w5apYZye/GEIqKNYzub/UWDKY3ptU1GDeVoh5hf0WpLJIoASY9qZt50XLWrqvtY8/be7HA///U5FfS5bCgz/mveKbZ/MFVe3ygOqxmZAIsb0A+IL9Wcl925ZRjxD19Q/j4jhnupJWNDZghFh7qysH9uqFUvWunEHcm2FGNrl4xKJITkKJStDm8jKeVEmTn4Ial3sq3lANqZtRXQXinNHt531mc3q3lke7u5JgXKYQyCKCTsfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE9BRdR/Y2OiEW/z/0d3fjh/Lr2At2tEz5i5FqkjxmM=;
 b=XNoiadnA4zQd9aL0CplmN4tIMW28iAfWLsByFDyxWXX9vnXEA8MqPJwEHwf2MA0gvHsfECqXBgjQuKor7WK+NypsDanFFFqYICf5f1KhgfEtRgZdSEIbUidYNwEjFGG2ydCppqlE46exXcBONEFGA/PVzESss34atkAA26gjNx7DKk+kcNxpYOpzVstpc9KrXog/AJ139Y6nsh7wKMPj6CFMukALgqgC6Y2PIIFYAZnQqRBXWA7Ni0stf0f/uSbBV5tOiVjFeTdAVLpJqdOzO/n+CA6JNpAYDfoGhQG652WKsAOwX6uzQQl0ty+NuGDDRoi0zglPqNkHlZfL45K9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE9BRdR/Y2OiEW/z/0d3fjh/Lr2At2tEz5i5FqkjxmM=;
 b=H3UrToYLwN3aA6CZHYSoeQjO5LWNNG/5wLUacu2WLJix/5m7JiUKjTEcTw7U84bZ0xcUGslIVO9cbcw5aPdu/qsOXDk6ENW+tMfnnejkVP/o9BucLFJS4/2xyBxCuA/AAYlCMMZoAACki+z9BXtvwGyuHFrQatK7oNXJ5N9Wilc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:38:56 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:38:56 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 0/5] Broadcast source reconfiguration support
Date: Mon, 18 Mar 2024 18:38:48 +0200
Message-Id: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: f025c782-e38c-45cc-c8e8-08dc4769e7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oFmb0IZnQLzZWdH64oZs+NnCxl074ABj/ibuHb1vMe5xJnDRHPfBXIvIp3vP8K7gPNicW36nYxnbNxq6905ulpsN0RZAv0PBrXteCsWKGBBOwjNS2JB8IQ74XjGwQiMKUQ7HFnifzpebMsLYkBP/mDEqZ+/Th9UZD602ipDnhmcOp4ev1A0P01gQiTBuMfUArF4np5xfSZzaInZ3OOLOiol4GNBrzdG34BNdU1KkhBZuRKHxA3KkAEOotsvsNg0xY5O6RSrdAir9b59dRjqQHjNnPboE1A7s5t6kmJ6eF58NjV5zWCLi1S4vG+apCu1vDrPffqOFOiTWGMWvtzf1Dl2XrCNpH9T1meBNX1/3Qt8lF/HCdbnflM3mt6L/Qf8KZ1U5YMKaJZIYyc/kqtvX4tD1a0Lhe8zUXASO/88KcoUF046qB7pYW4dYbMV0DpoGtl/H54WSfVvfJMxIOimVyzYCmGI67PCye5Dfw8UM/sS6voRb2wJQGn63/AtBbr7RBDcShzV5bcPnpDxcibl+mZjTiEPGbZ/tdXcS5369rRxCVfjYN/NntqPmw/VHcUyUI/rU/wblXCGxAefc0iuTJa96WjsOC8DIbG4MjeLHarL+dgS0XOkOEHvff4R1TpyjnNMJxazhJyyw6FCWaK8qDutp49F+iCxiYxbKL4LuJR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ft9vJT8oZfeCdwuL9hSfSLnTh+ON8lO/vJ+2NVaBawuSELP+uyez4YeoMOck?=
 =?us-ascii?Q?mMKWuKkLXiU3Lg3kEMM25x/pyEPnjQdASzvM8ohPC1L42ZPwBVThV7uKBi8f?=
 =?us-ascii?Q?xcBNH/S0/KHGuegecFyUq+q6xnr5Nw64Xn8/exF7BszkCn9CCe4yV1Kqo7e2?=
 =?us-ascii?Q?1P+kqVN4X/dXE6WmsDV1UOgYyFw1MOSBJFhfiWk2LWtu4fkEapt1CPKYXeLN?=
 =?us-ascii?Q?xFOnM6FL+zVhSdOvHBaJCVHs7N/e6jRDb3wRsKKUVrptNxQlCZtRthznQffi?=
 =?us-ascii?Q?ytIo1W3sIMbcvm5iPeEyPVZGBWOD2IeYx49eXHTiYpBZ0LsFJmU4Pscvjt/a?=
 =?us-ascii?Q?zZbBvnRZH8xwXXRnseKn//4WYLcB5SDRea+p4mcj1dQIMdwfLbuyPPgjJMh3?=
 =?us-ascii?Q?CiwzGI8fr2cupchUs0rDkmpGPTTEgDgXmKDSVCPtQpNlvSphf+OwBIU+ybcl?=
 =?us-ascii?Q?Kcx95yspDjz3MS+Lv4xyDQORMuOe4Qm9atfZQ8IUPnJlptV83gZdt7yqdYKy?=
 =?us-ascii?Q?UvmirCfBPqmo1C+TvjeiRMDaZKaeReguh+G9y3JCa2aBKZRj71yhC2yodtd+?=
 =?us-ascii?Q?aoTTEmrdaOS2oW6uRKnEKkHr7C7LcqSLLhvh8RSorFiccCs+eQvx4DRNLiAl?=
 =?us-ascii?Q?uKd1ALG7U/pHMfOdlmqx7zWlayidcAVKNaM873B2++uPwhTkBjPxhKt7Lz1H?=
 =?us-ascii?Q?PuAOWTeyAwgRYo8E115fUUPD+VXq8R19GMDHiBdpJLF8RQ0xww8stjRkP1lg?=
 =?us-ascii?Q?rVuObuGwlXIw8C1tvdxGyhojqys/SsqQcj+6FdcnNzTNBc4xNTQNTAkfTwhG?=
 =?us-ascii?Q?z8cBtqgJj6SGPgBNkWBYw7DWomxqBJ/7gXC6riJ2pJzL3JiIqZr1UYlgM8qG?=
 =?us-ascii?Q?zlVUCBJ3HPhsXT175ly01Gmu34VPaIwtTWQsN1N4eg/2P+IPWgSTExRIKGWd?=
 =?us-ascii?Q?DxIWz+HMhkgDJvZg3D0J0X/A+1D3K2sZPJyyFN4Gi/Q0rpgZX4UyxA/wkMjT?=
 =?us-ascii?Q?FLu0gbir7rI6RiyDrxUAVfst7XvkLP7HJXfs+BbPQkyZHF4sqLJNwsF7/BD+?=
 =?us-ascii?Q?rwX8+V2thgoUJDlyzS3K0n6oX8JXdcYy7H9KGCnwQixKbn5HMdgm3+beM7xw?=
 =?us-ascii?Q?bU7lfiX3aDBPHJwzpNnsyq3aa8rM5RwA4iIlQ6ZJmr1UuaVkd3eftfM3LQgj?=
 =?us-ascii?Q?oSZy04dTGP5LZa6qaLYTGYng10USrI9dzG6hksIzF18h7qHS3+ZVqm0b5RPN?=
 =?us-ascii?Q?Il+2Kv0oGcMshrMmfJlik2jo2ar2fGvj/CMqFu+bmkjTMWb6JSCR2fGk70Rp?=
 =?us-ascii?Q?ZDIhmDeGCIsmVPJdpPn/GC6/M9T1GiGyT/y/pMiXLqGPLQ61UmTM8TyZuozW?=
 =?us-ascii?Q?i5vE+JXCwroInki2/fNfMViSzHau7Q/jhHPd76MIGrzZz/atCA63QY2UQ7Hr?=
 =?us-ascii?Q?qkQNu4lqxyXWImahUNjIz52oWtV3FlN6ChOJoAag3jOdxZig8M6e4btuL4k4?=
 =?us-ascii?Q?hrWlf2uqvmUdkWM8mCyd74FrZ95Wgg8EIoXNNH+vI8b35UZ365pSC2hDDwIe?=
 =?us-ascii?Q?d0dAG9VRfNJQkmr1BPKKy9++eDWe7qS/pZR7YBvqkMhiSrZ69Zxb5dQhKlex?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f025c782-e38c-45cc-c8e8-08dc4769e7b3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:38:56.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPYHPQZQ75tMyozZfreMiRdfwMKwcAhm5gHSrjwsgVk0eUnpYJiPpkL6suCHtpajWo1TRDRCCIcHMXj9C0cJ7jb/ZTMGUM16/LDJOSpcHeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

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

 client/player.c                    | 35 ++++++++++++--
 client/scripts/broadcast-source.bt | 12 ++++-
 profiles/audio/bap.c               | 76 ++++++++++++++++++++++++++++++
 profiles/audio/transport.c         | 27 ++++++++++-
 profiles/audio/transport.h         |  1 +
 src/shared/bap.c                   | 11 ++++-
 6 files changed, 154 insertions(+), 8 deletions(-)


base-commit: 84628e5d109cbec0bbd515c12c4b5224380784fe
-- 
2.39.2

