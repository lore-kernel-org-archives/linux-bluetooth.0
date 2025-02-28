Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FD1EF39D;
	Fri, 28 Feb 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756460; cv=fail; b=I5QIbcDAZ89Imzu4m6jq0imxSwoq6M2yUjHD61z73rK9mMlYs1Bz6EtL6An23EkIo2n427jwrra8WVkUhJwqum93pYnceY8pU7cVDJJdz/BLz2tJ03MrCLz/X61M6BWJra7YcP+RbJiJcyZ0+ejM8WVK/6elmAXFmHQ1RUTHhPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756460; c=relaxed/simple;
	bh=vzePHn0e03nhaqdw3iMaarYuE8lqZbhwmZiUyd5NCG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMS7maXNCSP8pp3uTzoMlxHHhbFhaWBCp0DDF48CrlHLg912bJyzQPfo8UewDJLJEdWa3Nf2wKKV9wY+Y4q2EzYP2Mqn0aFrDgVKs6ElRSBhq61xyrIoukLfbjTRJ6TUXk+wcIUJueFSerkStOlYr4skNTSLQuyWatY7VL64PFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iJuUIrCL; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iJuUIrCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2OXsG4FG7u05BjZ654AlOzoxq3ECLT6Q4UUP4oyL/lakTQlP6l/abAmE48zlUYkssUI+AklnoBnz5jigyoNFP9CyQk2mpd5mgwuaJI0lII9lwqTNJGenIcp49AboybycSXp98ALbI5SglpMpBxxpTLyRvBVqMAOjDajIL7FbMTHYquXbd4Vgm46Jyyh0Sh64/et+LABVIMw9bLbb9aqhm/v0eik+hThhrjyQUkn+yz5bwRN2vTpETyc5NDuZhexUcyCNp+jHx1MRi2eEPQrFvlTZ17iSrXel+pL93Crz2OnYpkfO0450Wil+fs7sma9ISN3LAfy9ncrUhvvbyk50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROZGbLqbCqp+eBfQ6sb0o7xEgEJfSBPg/fIRR/8V7/M=;
 b=xLAClQOP3F1G3/R244rBu3RVlTSoTN+vouTAvMaX2CY9Lfb9ZysjNYLhe/KWfFeW/f6AO0u6VbVSQOEG0/U5kv+YNXYjSCSGedw4CEhZHheY2Af6opuKYCiSEItwxbPkK/EBzoMflt6WI4exaUZ3pmrV6eKbhArZXLR/4T9EJ30jxj/GCtlCC06krVbhwz3BIZbRmKPF2Q94xBOHQLbXmaguBQfIsknzMJ3jyq000mAdxxgRwMXWQfGY7dMzj75UPGcXcbD/5+YvSvZejD0tPq+Htf108aywu5dqLq0D9LNOkTmghtFq1BpJmaGh6ykRMVxGKjh3byOmEbDvpV/3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROZGbLqbCqp+eBfQ6sb0o7xEgEJfSBPg/fIRR/8V7/M=;
 b=iJuUIrCLLWCok8+aqULaE84rx4DUoZSKqxJf9KqUvQuxxw6cvJm9si2FDeb3a6qjQqAly8ZhIohqL/qO4dctUz5dUGeI4zNKdEaoKwh3b1+jBDvOa0ssly6FGAHUflm7QK9N+3c6ClMvIoRgWYhvyHDUv3apJ/Yb0Zi3c7KOZorFYEc+gTdGQxgWF/4olnjW3uiac8T37zKV6rtVEgF/xWG/4Lt4ScQrb6BU5FxtzwwfHbEIwVAV4UuVU2cnn/uiZDCSjfGyjvJQclMdyQ0CaCWo/GK5O1P8hxFg8/ZzqvD5rANEe0nBtqGRme0h8cPFKgjrdwaijCgt8o65150INA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:27:36 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:27:35 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v6 2/2] Bluetooth: btnxpuart: Add support to set BD address
Date: Fri, 28 Feb 2025 20:59:17 +0530
Message-Id: <20250228152917.5432-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
References: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 4849b663-8bff-4548-bb43-08dd580c6d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYVfYOF7SP1Jf4YN7beyb4fDLqdsRjRHveogDrymLjyLR5Ev0+rUBRoPTdNd?=
 =?us-ascii?Q?W/8Vp0ZnGE23a31ul+V5eSjZrQ1z8Tf+79n3cw8y+uwuLty4C3gRpYzRR6rS?=
 =?us-ascii?Q?iEgO7Xp7CLHdtado6VDf0uAQZex8FxMTPstM99U7/4z3FGepEkkgjWwDWNEr?=
 =?us-ascii?Q?jumfFgkWSK7gf/SdZ1Qb1KkUU+AGv86e1IHnf14RgewQciuHUzo1uEGd3iaZ?=
 =?us-ascii?Q?EpAmF9WiOirSACD/hJ0FiWQedpWoyQoLPKU+xObPjP32limBH6hrzr4yD1BP?=
 =?us-ascii?Q?BJ0AyF6w7OOPkV/zxGom6i0j50D3p3Ief842j0Lx5VGvnHGi45wdydn3CeBr?=
 =?us-ascii?Q?GfGsWG9zPiPvfvXULqbwL4mKg98CyQN8woWLmo5XOl1bTfx5LzsfPuEPWfkZ?=
 =?us-ascii?Q?Oe+XPoRax5pcDYdy6g45dhJZHDe1bIHs+XQ4JuUdT6gjNCSEk4nqW0bBAY6H?=
 =?us-ascii?Q?XV/HkDpH01rOl2pZDPgpNe64lME21rZFov/8PGvEaDhc9vdkhI/ER58DssF1?=
 =?us-ascii?Q?eGouduhx+QRwcVZ/TT6+HMfHn9VyFkhxDIZqTrU0scwEK4KZeGq37cBCxWdN?=
 =?us-ascii?Q?zJE7SkjapuWFaugUGr3+PmvD1KA/8MdMj8P7DclDW8ehKzhPTuEu2cnX/dwo?=
 =?us-ascii?Q?lxEhzBEIFZpopC8nu6X9mQx0J4cxk71EU66JzZYRTZ6iCvyIAiMGJ77mcC7x?=
 =?us-ascii?Q?97f4sTqyfnQZlF4IcRKivh0J6N3k2iOIE/FYJonmh9tQ+QQLXwhSu9wMsJOc?=
 =?us-ascii?Q?I1WTWeqhrUxNifIBG2qqOACdYtwL3tajQJHt8enBKOgAMvPER+c/oKSRg3iR?=
 =?us-ascii?Q?EwT8amfpdbwpkXwLfC/zIxCrwVMoDVGet/UaL/RkPoZ15VPHfTor0QsBcj/6?=
 =?us-ascii?Q?6kFEfzr8Th/WYUEgMRlAn8xzcgBN83qgeSWiD85wE4a7k34SeiOM8tFP3UXX?=
 =?us-ascii?Q?5vPF3r1jYQDbSa6MOfRjWI7QlgzZYC/YsKJ+YT+uJ/XUZtcdYQ15Zhx7f+0h?=
 =?us-ascii?Q?GWwRUTHP0LZBUXI0oyvHaQhuTxXpLon2/0keRqv9zffTGoq2k8rob9PMz9V8?=
 =?us-ascii?Q?vGiifaalcmZ/jmWlGXF2j4LcT/4uCzw+3DnTuKw3F3zVXi68QgQf25XAvjoL?=
 =?us-ascii?Q?7oB6HAaVATXW/HMBk5fczz7DOW2GQGscsfTUkM4AM5OrrrbcMDf0VMI3a8sK?=
 =?us-ascii?Q?xigowHgVsTVI67fGUgKjTWe40t5WMNshdR4g6zKhh0b8G/ID9RK2UnpbXqRQ?=
 =?us-ascii?Q?yExyTLCWE+uLS+ynOCgquOioIcSnN5kVlNCtPHPvNeSuc1HBWlgWLk4kHMJp?=
 =?us-ascii?Q?6jOaw7kOcLTmilpRfrkKo5TqauCOVIQell0ACZOW39Tc62B+Ua8eeWe/c/uX?=
 =?us-ascii?Q?gsPkM0ii2Bt2kxQxWgMJvSlHap6h1JP/1UDWBn1uz7afanFI5/rSuTd8YHgi?=
 =?us-ascii?Q?gom1Y1cf/n0C6j7TxWm3qZ94IIEgkmj9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOakBPNLOfM8fuDAokDHf5/Hj7l0reqmQR5RnINOLUFFhP6ECjWWUIJgLLbP?=
 =?us-ascii?Q?kEa5f/hUnPpzIY4gvnYc7i8n0aFd1Tl+Zw950Gr4Zq4Hnu5/YVWYp4sXQ3Jv?=
 =?us-ascii?Q?QnBpDPHfvBlTjcVBB1i76CTcHGqNNBXE4Ti+G+DtD51qw/qljVyOuYa4rdVW?=
 =?us-ascii?Q?Qn8YRaywVsWYxerhQgx3pKMiOCX7HL2p4PsBgcFoiaXqSf+gdZruzEipdrT1?=
 =?us-ascii?Q?0Jv3YmYDCcSQHi7+vdlcKjHkrLVWx/Ins3Uozu/9TUpHdkfzJdf67us1Z4Gl?=
 =?us-ascii?Q?ewIihtmEx0MAtHglsXtMfieYVXuahbU3AsodMO2elXieTSNPPY0f0I2dvMvb?=
 =?us-ascii?Q?V35URuWaeFFVt+py+AN5xSW8jfZDKRB6S8tAPC0bpAGXEd2j1pjKnWIU7mF9?=
 =?us-ascii?Q?Le8pAZbPGzjPnZmu6fDyJmkWHaI/zJYdm2qWkUCmLxE255yaJGOTS3mwLBQS?=
 =?us-ascii?Q?un0ijtJqXYBYRwAXLoC8++yOaVmqxDi1ux/9GE9Aji49w/7s+PVtK7TjUs2M?=
 =?us-ascii?Q?jCtGq4cc7pyevNMQ3gnprSaZKFH3nVkz3y0+PkE9LDkl24h6Qo3wDqjhffR5?=
 =?us-ascii?Q?C61dWbP7bTuvOm1HBKpWrmS6Kx60TIMM3aTcgFU84qp8RVMA/KSuL12KZEkD?=
 =?us-ascii?Q?iPuS2JYpEad+UTknHE8JigIFn0mi8Th8B/ZpHs0aFj1eXsY+1i6922K+n4jR?=
 =?us-ascii?Q?gt2/qh0B+w4xDrYj6sxzfZSB278d5xpUUAnU/mPcI1Pb+gFMmtuBsmY2DkKl?=
 =?us-ascii?Q?0onJQd1RMLTz/B3m0weEa4SjG0tXlvky3cjbV6q4GiKk4XtrR8P55jLrLrMl?=
 =?us-ascii?Q?VyXai7C2jkNPOrYjV/m7Xn5rDhAGP6ONJgAy1hCZT4aJxxYA08D9Vyuovtff?=
 =?us-ascii?Q?tVguHv+o1w+/V8Ol9+RVzZPNXyRouq/flwWmpdOgWGmUQUb3zigwE9C+DeQq?=
 =?us-ascii?Q?KN8tXvK352M4/5SSjxYYM0LD+I8O1CaAUMwMmMcA/ehGRI7P4AOGb2fGTEYU?=
 =?us-ascii?Q?sXkI8cuhXKvctgqhiwLinsea0VodEA1Yphc4++I3rhaM7a2/GCMRHHLp2rKd?=
 =?us-ascii?Q?q/Dkvi0oaUxvlAq3I+YA8NG8WEFd4BJ7Km6ou08Fp1sV2Lau70Qv/jTm1WgA?=
 =?us-ascii?Q?ViFg/uPbSI3Fguzhmje+N/t78mBoqVvJbOegNwhAyFGH6lZqB1MdlsqCj0qG?=
 =?us-ascii?Q?bVUCChh6FUDUOP0nct+o70hhMN2hsu+IHujCGgZItgR+Tt+fwXjJwWlmpAv/?=
 =?us-ascii?Q?txspn+KYcJelUZos6LjpnJ8q8iK5dkbvVmnUoJ8tquibhye9UOulZNBGAC56?=
 =?us-ascii?Q?22soC4Kjg5fLNJOasASZjx7ttYo4rfMaERCbu2b9iRkUxi0QETy/PIZXTJT5?=
 =?us-ascii?Q?Ita9OLd9k8C9XCMxuoC9s5gUV8051FW1YWh+D63BqygVpfmaaA/9tBtdSCmh?=
 =?us-ascii?Q?vhZyewQnsVPqGCtFaJGVX77PZUdljmc/V7UmD+tiUYiPcNTnyLXv1iMwr4u+?=
 =?us-ascii?Q?qBnC4+KKFs/eazbn/BRMu43q6EHM6IxyTtZyMZBqJRuJJ7zUFP7WNyRyx7d0?=
 =?us-ascii?Q?KVWDwFXypaaMpHSQlW7daBrGYKhMnIZH9lVXQYOqFFQY9SWOlV63hqYqA/aQ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4849b663-8bff-4548-bb43-08dd580c6d8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:27:35.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npkt3fg0obq14TTG6g/uGx74QldHE9a+sXGoav42+9FlC2p0LTRrwAgeo4AxErJFov/mqoBDeDfInZp0VUQpak2j3TiuKvhnnFD7851jLA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

This adds support for setting BD address during hci registration. NXP
FW does not allow vendor commands unless it receives a reset command
after FW download and initialization done.

As a workaround, the .set_bdaddr callback function will first send the
HCI reset command, followed by the actual vendor command to set BD
address.

The driver checks for the local-bd-address property in device tree, and
if preset, it sets the HCI_QUIRK_USE_BDADDR_PROPERTY quirk.

With this quirk set, the driver's set_bdaddr callback function is called
after FW download is complete and before HCI initialization, which sends
the hci reset and 3f 22 commands. During initialization, kernel reads
the newly set BD address from the controller.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Signed-off-by: Kristian Krohn <kristian.krohn@remarkable.no>
Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
    HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
    property 'local-bd-address' found. (Neeraj)
v5: Initialize local variable ba, update Copywrite year. (Kristian)
v6: Elaborate commit message, add User Manual reference. (Paul Menzel)
---
 drivers/bluetooth/btnxpuart.c | 63 ++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..2eb14b9beb70 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  NXP Bluetooth driver
- *  Copyright 2023 NXP
+ *  Copyright 2023-2025 NXP
  */
 
 #include <linux/module.h>
@@ -98,13 +98,16 @@
 #define PS_STATE_AWAKE          0
 #define PS_STATE_SLEEP          1
 
-/* Bluetooth vendor command : Sleep mode */
+/* NXP Vendor Commands. Refer user manual UM11628 on nxp.com */
+/* Set custom BD Address */
+#define HCI_NXP_SET_BD_ADDR	0xfc22
+/* Set Auto-Sleep mode */
 #define HCI_NXP_AUTO_SLEEP_MODE	0xfc23
-/* Bluetooth vendor command : Wakeup method */
+/* Set Wakeup method */
 #define HCI_NXP_WAKEUP_METHOD	0xfc53
-/* Bluetooth vendor command : Set operational baudrate */
+/* Set operational baudrate */
 #define HCI_NXP_SET_OPER_SPEED	0xfc09
-/* Bluetooth vendor command: Independent Reset */
+/* Independent Reset (Soft Reset) */
 #define HCI_NXP_IND_RESET	0xfcfc
 
 /* Bluetooth Power State : Vendor cmd params */
@@ -310,6 +313,15 @@ union nxp_v3_rx_timeout_nak_u {
 	u8 buf[6];
 };
 
+union nxp_set_bd_addr_payload {
+	struct {
+		u8 param_id;
+		u8 param_len;
+		u8 param[6];
+	} __packed data;
+	u8 buf[8];
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -1197,6 +1209,38 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	union nxp_set_bd_addr_payload pcmd;
+	struct sk_buff *skb;
+	int err;
+
+	pcmd.data.param_id = 0xfe;
+	pcmd.data.param_len = 6;
+	memcpy(pcmd.data.param, bdaddr, 6);
+
+	/* BD address can be assigned only after first reset command. */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, HCI_NXP_SET_BD_ADDR, sizeof(pcmd),
+			     pcmd.buf, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1500,6 +1544,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	bdaddr_t ba = {0};
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1547,8 +1592,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	device_property_read_u8_array(&nxpdev->serdev->dev,
+				      "local-bd-address",
+				      (u8 *)&ba, sizeof(ba));
+	if (bacmp(&ba, BDADDR_ANY))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

