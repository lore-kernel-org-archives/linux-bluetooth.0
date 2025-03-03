Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15E1F3B85;
	Mon,  3 Mar 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001174; cv=fail; b=BN2g6U5oYmV63e+iDi+QiqXG4oKV2r5a/j2lmty96TnbyQkrZWRohCk4gUEQk676KBd1KK0WW/XEneA+2WqWxjCYnBcxa2nFOJwwihsYdRpbvLpkrq8SjCiy1mowYqjKM4qTHiNagGPk9/pj5qMDMA3SyX2eM2XkNGSD6HpxHC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001174; c=relaxed/simple;
	bh=QgG9cV6xkOAfeXqU6leuQL0aiOkSYY1h9qzxiRuETY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0mi/3D5ysMoPmNd6XdIJdlOcNWlvI+1BwaChK1Uz3vrE27kmH/UxNZSh5OJNARU4CclvHm9dMV4IFlP5wtjHBL+vSMrt1PCIfNtbtVjToqnGOl1qLbAZ/LYN9sEdGQl9wbGQ5+YuHmkb9Rr1vTTbmTTYOu6lT5HNPnIMS+2UhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ENnShRuz; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ENnShRuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN/RBL45SwKbRXjE6wcZ7+okBYmkdLFkMMaAqc9KtNsB8tIe82Q06ZVuJP957CfWIqHEQUzpFI/AJFxRf+y8qlLN8/gZg5GQX1iwhA6ThHjez6jFp/N88On4BhO0hXR+yqj6m97XwPfL7ZnbRPm2itXfxd3i8jsS+FKrKyN0e9Tr8x/W027fqjRWNS8y8qxYmrAaD3d7QXMQ3CSHXGoD5hIWqpmuLKVQyeWMRakGmwD5+O0ILSrcHoQGhfZS45xxIXmehVjyIMNuH0qHtu78iwLmD4GOx5np9AivLU+1dVK1MeWXxTibeyr7vVmzPZSvrRD13xzVXet8ZVLEGw2iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J/WObNg4WV5HLlizyW1hFR8Cf6feJqMU60KgErW2yU=;
 b=op5LjCy/lKNlE60tarKStD/PUUnxW9Lm1NRvB6jeJXna4ykZsTItcOybGJshdhRJgPz8+l+YjcI2OdTgIDNehPko88OoM3FnmBHm30bHiZhzXh/kvGZHDAdrKObY6oqCsAC8V3ncms+bSPj7rvqrBiepdtiI0X/tiKK7FLp97JCMxejRdTFNmtx2/+zIwg2UfTmz/+6nLV3b+dlupNzkSJNW7kXbLaMp9CVonbJTYvcJkypF5haY3C1ojGpXvz1t3F5WUItMxuLkD55OGm/g7I4Zp55X6xo0xjJwtcBTCDuc8ViP5jtbPVTy5KJMnNKQEYMWhFNZCdlLVDAFgMENZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J/WObNg4WV5HLlizyW1hFR8Cf6feJqMU60KgErW2yU=;
 b=ENnShRuzGZPhcwvmYYu6Wa2MqZShsQb3l49vHd2xIawOvw/tE4gqECTfDUhA8UMcWR2eH4aT14Gewd2Aswrkbry//qc/3ytk7AGrGa8HoOofs97JgRv+hInFxRkozitYudylnEiacOKiJusHqsJ9AVpC3+LtsG4EpuzuD6X46IIe5DwOZMstV57ADgfufg198kDN6ECk73HOUMZ5WS0bJAvAJYwUJ40v7IbWNQD5DXKXI4vpuGngLNoTXHu7D2/HF9wbYO4GwVjurWbuHCoAa6ct8Ye8PtLWci1wpTKP0qFhdYJUHjJTS7/0uxfSAWdpnDhMGMYDG0WRlPRno09qng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB6994.eurprd04.prod.outlook.com (2603:10a6:208:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 11:26:07 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:26:07 +0000
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
Subject: [PATCH v7 2/2] Bluetooth: btnxpuart: Add support to set BD address
Date: Mon,  3 Mar 2025 16:57:52 +0530
Message-Id: <20250303112752.7292-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
References: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM0PR04MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7afdd4-730d-484d-5efe-08dd5a463104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1veTNpOhUDedew+OyNljlludOk+DcXarDKgG9D8m8Vi6YC0Xr0snVvWfefy?=
 =?us-ascii?Q?+dBzRuHjCzRtngbLOFWQDrF0M+/nYIV+Qq2CW9iMNU0Us2rZF3eHaioy6nmJ?=
 =?us-ascii?Q?ksjWT/Ma7CndO6q4Doe3jqBCgPdAvtNcgp/74627yLxmPW3yMQFffNmq3BR2?=
 =?us-ascii?Q?6hmn6XJe59XOw7agp3LuKh1TYp6mOuF5TIKDPY4dWMcDdVb8QKw30moN3Oc7?=
 =?us-ascii?Q?s6F59xgjqVtramHK/R8648uq/yc6eqAlw84YtWyq0tf7HACRUviRACHRaq7s?=
 =?us-ascii?Q?FqNiGoeKE0tG7KxCUdji8iiwafAmgQlOimOIg70Ge49vXSByOITQCT1walxN?=
 =?us-ascii?Q?LL+woow+8ebTnFPrg7js10+8As9MeopBrkRezDMMghXTxv8PyUqQVyZzPn4l?=
 =?us-ascii?Q?ORC5Uw4vdBjCq7bc71NhIg8Y86zE0BxCkXIR62NjAmeJ+4MZo0mw+IOirdQZ?=
 =?us-ascii?Q?vQEz2JHzSnzAkMgU1Z0CZf+tFdgoscMb4WJ96gbxc7Suj0+itZsrh5d2229i?=
 =?us-ascii?Q?2+3Jad3eZrYxhpfpK3Ygvh4Ki6tOD/7QIMFqCxlGSfuumLqUcIlXXp8a+OkL?=
 =?us-ascii?Q?HfdidiaCK61VSQYSpXWMOPsHFVmpwletbTs3NNc94DqCoNtun5hY+zWHDyeK?=
 =?us-ascii?Q?Iri+r8soAJCsh9NXEbESwM9lShnQCRze7K5N/tF2Gm4K7N8jKbmLuaMHSlyk?=
 =?us-ascii?Q?LoqZtVBlrxRJ46kWCFkhm+x0mN4ac1FQzFNxab6mQnF8/dW6QRnKB+yBprzA?=
 =?us-ascii?Q?/BlcLEyJ3FgtRASq8+zT31Dg/+w3Z8pevlT6zntDZVGhnwFgQ9Iq8fzqBO03?=
 =?us-ascii?Q?yLxAt1w+FVVaY3IW5YxI5ksGA4fqlvblPl7JtGseP1umO8T2NAIIDKvEFSvJ?=
 =?us-ascii?Q?M4KvnqrotZ7x1hp1jJLIIEVB5OVxCmFGBawgrdCYN1jxY72rN4/XfaAsoV4V?=
 =?us-ascii?Q?zr8ZAoyHi7PLi3DliIzJbevmpraNo0bjQopf2POjcZPHvz01W3VU8V/MId5Z?=
 =?us-ascii?Q?ILaLOnteMMLhbCmQHpkOCtNF2ByZgQfvjinDA5e0ycf89PxpZkrVowZhMPkN?=
 =?us-ascii?Q?97+qek9jkJaCZTxpyjyA2aRVmOP3Lco5oQDfXDyNVWA+bcio9SmKV1vfeZ5Y?=
 =?us-ascii?Q?cigmbMkZAUugLYgSRAytFjnfr+61mKrcJU27UgOh80QnrBMCgTvsmlkcgHhb?=
 =?us-ascii?Q?rHO39v2bh2Qwo+YTP/06hJQRpwRqfEDM3S60mCAsZH/oORceJE8fmIyI4dH0?=
 =?us-ascii?Q?qJkqE8SpNeIYExlgDwJr94f5o1WoI7FIfJIGtQIv4sUKEDSdLrUZLQZnYLiE?=
 =?us-ascii?Q?wNCre0wuBbJV79dQAsz3M8qAIzS+9d6u8tpdLBFGzuwM12BAYFodFJwt0CWs?=
 =?us-ascii?Q?+NJ2SgpfIMGYe72dQcC18Lh+6zwRwW9vM0NS1yr/vQ9SB1E9gORW5HwfiKqD?=
 =?us-ascii?Q?K3jfVPcTLOJh/pPD//SOTO6nex3+Jnnx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQv2mHZKbY2oiQraWDxMukdV0UkIJQrqKvvXXC/3mjMgHX9ELr7NTk1y4j6a?=
 =?us-ascii?Q?7ybVD8gmkFlt1zhM3dCSOK8nYmyzSx7K2lsLAjHMraW353i1v5qisHDt9V29?=
 =?us-ascii?Q?52X4TtyjFah6SfPiBJxGwG7Rq4eh4VmGHjw6qGjCOC5C8SQGUvNeYy8XEhe7?=
 =?us-ascii?Q?QpmYc3qYnrJXjqTJEthfcWRO7QepALnuMILPeeCQnTtYmq7DnVUADQ98IUA4?=
 =?us-ascii?Q?heLcYooIP1aMPQydDS0DBzLDE9Iq8uwTZuwviEmq86QX5YVrtOhpwiCSJnK7?=
 =?us-ascii?Q?5lCgRNubWMj4zV+icO0aFL1ctbqBDaSuI7m7IcRFIStZS9cPzGzTUOvS4WHt?=
 =?us-ascii?Q?inUGejLGKJYTEDfmr1Ay6qvhVNFMNrwY+ROYyKrSlb9/s1N7eeBIafOtsFza?=
 =?us-ascii?Q?6Pp4fS4ptn/RDzzcbydmfVH8psJStsCeuLifY4+KNX9yP0673LZNiYbFKroV?=
 =?us-ascii?Q?akkbkUQcS8LkfGMZzYkCxhblK71DaOY3VwcvjQH2tNDUNYvFt3wrrAwdVMg0?=
 =?us-ascii?Q?gZvyEDOIgG1y6i5vegbSvLG2RhtJvzZ37GvEM4CMlPXQXXpoC43/vhNCyAFq?=
 =?us-ascii?Q?e6lC9Ixu96N6ANrZvQpm3hXdIGslj0aliXtQuvLwIkyvcGAATMVJOfSkxWI5?=
 =?us-ascii?Q?CKJoPbFTyxPwqL+VJNpmtzhyf70aiMKDmK5yrjPyCHhqs9S2hqRA7LTAIbYr?=
 =?us-ascii?Q?rAl8Jl4rOZfQW1a8R81ZewqXXgmmn0w0PIbeB7b4xyo6bokSJv1y+tQiF3Zc?=
 =?us-ascii?Q?N2R8ooktFWV9ENxghiL1n0ehp1U1Ba/Vl6r0Zzpc738eBFtMS/P84IQdcElA?=
 =?us-ascii?Q?izAq+DRSJV2DI+C1xpXOqaUDYUPj37WQTi70d1UkSnWhOGIjV/phWZRzC05+?=
 =?us-ascii?Q?WLjYryTx0oTa2hTnEO1roMl49rb6DReyPHLtp7i1NMIohNVzAvpZWn3oqprx?=
 =?us-ascii?Q?S5FyEvvEVXYmaTYBPiNMZbZRNcv+UyKxQ4h860Wjx6hOUcAG7Pq0uS3IcqWW?=
 =?us-ascii?Q?sa5c9wCD4Z7ODIwWBHNjyAQdsq+3ksghrfTU7wRElsHKl3ymaAu0018pIQJD?=
 =?us-ascii?Q?UtWuR2MCJveYIrIEOkB3miIWSkxSXzqHaexBMIgm3hPPPMzVqCjVhZrhihTT?=
 =?us-ascii?Q?4OiV+EEFZzOKE7YBBscNkCPM4+iI1Jow/0DFtQYDWcChuMaPmrS7fNy05MFj?=
 =?us-ascii?Q?It6fu7OsgVmim7uxSE4pSfb74e61x5EFtZUBOhaJpGexPSyQB1g2REWjnTng?=
 =?us-ascii?Q?QMm+Y3OgnJ+7JrulyccEJ+BK5ImJAR4f16rIwC1Jd82jD/c72hieRVCrhio0?=
 =?us-ascii?Q?RyKNSFLpOI7n8+NxebghMSJeL6RnxWESKl7j2yVz5Vs8jplCt54bouKumKue?=
 =?us-ascii?Q?2//0NWdf6Rx5XWtyJqFqUeYIIhznqmU1X4lT5p5YZ6mWzjmdiX9uT+nu8qRU?=
 =?us-ascii?Q?6ti+8E3FAjSJ2bh5GVRhDpx2mIpemO3TwNBjqhCHENi0e6s3Ldquy2ePKm95?=
 =?us-ascii?Q?jY2ctzFLis9oG4fd894ZEbjfPGYGwVPHva61Z0cxHtz6OvAOhu7N5ThiD7Io?=
 =?us-ascii?Q?lVlEdw6hOVeAXTwe0d5Jm6Nx03rUCiMlfjt7D43oZ6g/uxEktakt9P24rVp3?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7afdd4-730d-484d-5efe-08dd5a463104
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:26:07.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /a/ilD5q84pj/bJbRi4QjuP6MmoHUIuTLksWW9jxJ9Y0nR6SFXmd8Yg8zs0kUaf2JjVwsj8FjEfG47h/kP99kXRjqHFLYwLFPqd+wQMaD/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994

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
v7: Use __hci_cmd_sync_status(). (Luiz)
---
 drivers/bluetooth/btnxpuart.c | 58 ++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4f2f429c9800..21b07684dd68 100644
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
@@ -1209,6 +1221,33 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	union nxp_set_bd_addr_payload pcmd;
+	int err;
+
+	pcmd.data.param_id = 0xfe;
+	pcmd.data.param_len = 6;
+	memcpy(pcmd.data.param, bdaddr, 6);
+
+	/* BD address can be assigned only after first reset command. */
+	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (err) {
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+
+	err = __hci_cmd_sync_status(hdev, HCI_NXP_SET_BD_ADDR, sizeof(pcmd),
+			     pcmd.buf, HCI_CMD_TIMEOUT);
+	if (err) {
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1522,6 +1561,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	bdaddr_t ba = {0};
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1570,8 +1610,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
 	hdev->wakeup = nxp_wakeup;
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

