Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C84236454;
	Mon, 23 Jun 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671089; cv=fail; b=J/ot6VYOYvfFrDrMH30lfPxJpgbMUa9hQO2TfcPLE+rc6e3V/sjEq+nThMcr7zvvqGqpDKxeLsNuqtT82H9U5ws147CbslhUJkN+n1UOfb8EYzgvjFKgN8PWgt+pwK+5w91zQjk9Xhc5cvW3sO6sez0CbU+1UPnYcsTsoWwapKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671089; c=relaxed/simple;
	bh=83eHsoEg5mGqRhzj6CYkLkxPXSgwbbOUOWW/ldB7L8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpzMzbjF26dnoUremOo+4t+xqeBaVvQX8T1ycNTI6Wa2rEBxNFuRFnm8rWVzaI7wXwysxxVX8xGkUFBZ31o487pyCz8teCLMApIq3ypMtJHOpBMKACGaN5h32eycRQV6u8+llEtKqwn3QHdKIkCCYo/JwoDkg9wz5rqBUfDykq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q3/zphYd; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3/zphYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1Eud6x/hm9RUZuv3NQxS+U2fg7/h2yfZvXZT7sKTEgDVzeLdIAaF5tYtvqhmt9dQ3lvD0f6MVzqKd5WXw6q97gDE9mJaCUn99/ZV75LKJ7pjWZuqKYw3DC60DCEdeR/Rsr7w0y+KSqe74Quc2K0ERmPnFek6HTzUZ3xxHQFeobrv3ujOV/OmIXZj6nsnsx3gsvk9KlTTSEwC9ugcYA93iYldEVHX5Z5EsQH5YQFBf9YwG3upHpmInEc+8FYENvY1JObED1lwxJ5hIue3+N9BUzstBzBRMTpAHPAJ8ySpT0fcd2spAVnNZSZeIOEXTEJ53QoOiq5kYVRBQCjNeSs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QMLhMR5j22m+6jE0bbgBm8bpEu2kPoQZqNKg78Ao/k=;
 b=XYPul5LFihJh3JwCb6SXp8ESNTwSOXR9HOyfYcjytOba18guoEweLI343hSzsqqP855LZq2/Zg1iF4X1xvIS6JsQRRhGfynydFKFRjw9CJeH8XegzHGbTHEXXc/3lpY3N47cqTi57WWJGOKHXUS/XiGQsnWHxxt4dRWSd6QbD9FmmhAnNur/4Fo6r/SioGjZgaUdxRWCBTX9DwkMEmClGa1He/DGx3tZM/z/fSTDHmtPAnA8hnRX6ZGigIuBC5QzEu+PMdRXfY9gFp5osRI1rOPU95jBn/0gJioeX8uybBvpBGHXHwJn67ABHnOgEr+kARCbIpyq21buGrEvittKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QMLhMR5j22m+6jE0bbgBm8bpEu2kPoQZqNKg78Ao/k=;
 b=Q3/zphYdwE/UwALVCBUaygHUCH070V7ueqwABEQ8sFnFHz+YVGpPXCK3Qjrn5jr0ZR8Vqoa8+MfHTFdC+I6+1KLBZ+4eDO+MUbR4MA/19cpzIhP3CBhzFwnsiTxAVFRgWbgLjRTXN2TQICg6sJUUjw+8g/8zXgdcgU7ALP7GnsPf8H4BaTcCsj0XHP1WpFEmWkxUeLApudf2jeZi0EGN7RGvrnrqvz7tvQg3X7745/C3NsYpNFrB4KOGd15tjW939GQzEd9L2yEWfXhd1z8yCrKO8WZoIzhATrVjVN3P2hEmxshnLGgF8GWvxGJrAgAZAdAb4XNVEcnGte4jYuv6+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by OSKPR04MB11438.eurprd04.prod.outlook.com (2603:10a6:e10:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 09:31:25 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 09:31:25 +0000
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
	manjeet.gupta@nxp.com
Subject: [PATCH v6 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Mon, 23 Jun 2025 14:43:22 +0530
Message-Id: <20250623091322.131502-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
References: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|OSKPR04MB11438:EE_
X-MS-Office365-Filtering-Correlation-Id: 55add80c-7374-4f1c-89e5-08ddb238b951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzGR/D+7gBNFFxMptCUejAaSgTAbC7eyP+an7yqnne0mN9oKYkeQmN1yDGzr?=
 =?us-ascii?Q?RVpNnRLZCmx0tC1TTvFAONLHZDnOY9i3/xvZNR8tLqg799Tv1WxFTOLY4B5E?=
 =?us-ascii?Q?Lo0ibi/HUZLWhJdCZApuEvG8Ajh1DYPwJuew5FzRXizQv8LvlAffN++Qh/Xd?=
 =?us-ascii?Q?83aEkmdLpaxCcO0Lzj/ywEkVyA5dgSTv3Olj0/Ku+CrMpnlsfJDkM2FjJKHY?=
 =?us-ascii?Q?RhBXSwZ8OXT/OUwDfv4nx1D9mlc/Ct8Y1HcWsuLPFNBO+1IrGZ03XylBhxsY?=
 =?us-ascii?Q?cjvGpQqa0d23PJxyT2+Li1CBhiEeIfr6AEVkelZK3bo6vrROv9vunTf5UbU1?=
 =?us-ascii?Q?oGUBrb5q7eE5dkxnJfhW5dhdGxHvarVHUHKb3g+ABhc1LzyqtuoxTOBxKTrS?=
 =?us-ascii?Q?4VSk/AmTbvJCW3AdM3eNTj25Ru64FeZbx6Zz06sWl0vr/e0LGgTzclG97TJJ?=
 =?us-ascii?Q?Mckhkw2YDgRKgJS+EurNqjSVbpxC2TJ4XLfd8gSdhBVQtBvKf95ozlJNrMq3?=
 =?us-ascii?Q?cvNdmK4Bm7+pN00+uM1bkNHhMNgGlbZnWvLawF9vpPHgvV63unae4FaPxeYi?=
 =?us-ascii?Q?sabjqcnWGXcHyS3DTLoACmaIjs6m6iib1q5+Vpmh3KKBLneaozuAo7vTkvw4?=
 =?us-ascii?Q?2DJ4rP1K4nd8CD6+e+26Fq+sH8G6bzaY/LCr5+jpXMX6NWoJVuMowLB4gM1N?=
 =?us-ascii?Q?axHkqc/Q3gDFHj9Ji9k6nEYS7J7C+Mhm94Q+F0rAXmK0HeLCBpWZsQ450yZC?=
 =?us-ascii?Q?wcFxaE3Ik3k3AxzVGwX8wtS1643oJ7IHkSCLPAkoyYmvJ8ojuaiQA4nn3OVh?=
 =?us-ascii?Q?/tCK2PQl7FyL6rhw/Uzha7N14HSra9nL43/cUoENtikfdLzGCG76zHaZJVqW?=
 =?us-ascii?Q?Flz2tsszq4qyH03WopHaHHP725aI3pvcZtW+DmWQfohdoaaK+Kh6WaZ0MQyT?=
 =?us-ascii?Q?NlIjgP4TKR//Qn0R2LaITw+15x7RP0h8XdQwhw/zmdNTQldvMMom7inhVvjM?=
 =?us-ascii?Q?AuurODqKTJktjjm0kPKItA0/ilbDdDjZs4MpTYv6c793rJ9/X0rbwzHW+ic3?=
 =?us-ascii?Q?jOm+G9CsoWIuhze9QmLJDYcJUWJOreJKoLTnk3zBZ8qHrcYbDI85Se0P7TlF?=
 =?us-ascii?Q?rAipw6ldrbXFmR72ss6VL9ROO88qO4gM3+qwSCuj7TF+Sedv0+ID6ydBgC0F?=
 =?us-ascii?Q?QVdzHbe8fMJ8eJSvVf3DgoINw8Hb3f78vBuz3dRGkWlTlyX9c5XQAudugytD?=
 =?us-ascii?Q?WtGJwhzOOBJ8aW7S8wgQF6IDOjaBAXl5vBwAqcbLrYXbubfV5KX+k+E0pCYF?=
 =?us-ascii?Q?g5S7HKzejUL2dUQh31xc7UabvTf4AfmK2I9HIXwkkIruTn9TGZs4RyUNSufa?=
 =?us-ascii?Q?TykSYa9WPtOyGg1VaQKtDenGVuKbgjsPILsgLy8uMQCRHWCHvq+7SY0EW5+p?=
 =?us-ascii?Q?TqjHp3yTwbDBfWC/DNqx8/XKW5sUAwwAsPWrvP0nTXRq4+vpRstN3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hoyTPSR6lQGkXvKN0gUQxoTkdaRV5KkTHkTZ0Vmg+mlDVi++0MjSrjOLRBt4?=
 =?us-ascii?Q?WdHwvJhnPtDrk1CyO4Qy+trXBxnTcj7R01Lfhu1GUOrFf+GyRSvzSaW8nrmu?=
 =?us-ascii?Q?r1bXMmheifbjcOBClVzRcapXp2rzQv+p4fLPUeJoeVNd3Y6M3fCKZVcvO3cf?=
 =?us-ascii?Q?sgLSx2ggMERMpNLiTrCwN3xyG1L0oaibPkKoiKJETLtRA2G1TEGIl4O6ZP6z?=
 =?us-ascii?Q?B5pU6qRryXzZll+iJgGxPQkLCeYCHhU0Hgso6IWgtHhz/K4k9nUjO0GJDE18?=
 =?us-ascii?Q?SbAhRVS7bDEcbS6EEctJDvZJhMuH44TkckNzXmVKPDfWn66Dryf9hOY91RDc?=
 =?us-ascii?Q?fZYm9sxMzKoXEj4DbHWQHwzvCHXi3j2qkChz71Gu67QuAD7X6+6iQe5LOpQO?=
 =?us-ascii?Q?WI9qA7f0bESficspjZYbRU8tjci7C4Qyi4iqBgtBv7QftNaa1oVvOwKUm4Ps?=
 =?us-ascii?Q?ckHczexoPpri/+tYjviNoVp1e1P09/vbuFw4tEvqnDffd6Da1RMCQ2+mx3c0?=
 =?us-ascii?Q?tDnvMFKR2qNuurRNJ3PxIQjvnBXMGAolI3tATjvQApuv6cLQpmSLeQ+yXVJ8?=
 =?us-ascii?Q?zSvoqVkj2geZcb5acn/sReIAnkuj3QUV0ky6U+zlP4/50RJ2NpixA3NE61YO?=
 =?us-ascii?Q?a9R78ZWpHQO3q6UF9QEX0mAZYVI3Sde85TQmiPUECQnUn7N4uN+L2TypA2n+?=
 =?us-ascii?Q?To/jYrRX8bhNMxFnkzhbmdvmnZoFS+KPeOIcwPRSYsBEDeXynd091zZfJVGw?=
 =?us-ascii?Q?iPcEfSkdE9FbEZ1sE7BwtAWz0g7TVD3M3tug8T+ejd3mYOFa1g6kM+iR4ygf?=
 =?us-ascii?Q?v++qBS6a7LnW3AeLSZtbWNtR0fM8VOVnYYwIAXLFCjivnc+HQh1BBhApZSMs?=
 =?us-ascii?Q?JZzO5hFkkFS9ZdlYcfB1w9TSA6oevA8GMRBndJp48kMVaGzGTwxVx8jL1JCO?=
 =?us-ascii?Q?NrVB7g8CRmkXjYQwzd6NeWDSxmQy+B05usT8Ug9qE5Nex11OqhOtygI3xfjL?=
 =?us-ascii?Q?ILytZKemNifpV9zPg+uFZFpaamj5BRTkMYOTmuvwlgjw5JAuvSmkTT9bPcdc?=
 =?us-ascii?Q?fshzOMJoHGtPKHNMq9n6UjFcNUtG57dOO5FvhSak74RptwbT57LttPjRtj08?=
 =?us-ascii?Q?WYOfanIbv7CQcE7jmyHxfVzbc07iu6e9MHPoO7tS32DbcCjIkgPlthZz25x5?=
 =?us-ascii?Q?fO5j3DM6i4lknKvyrGHmUJRPO1Ne4PrOxU52j+06DP5cThj74MIixQkN1Fs/?=
 =?us-ascii?Q?8xPN6FbqmokcHs0fdXFWKR06ONjHZaR4DyVnHnL2i2wzZMNIPRLVRXMWUMHC?=
 =?us-ascii?Q?8LRrv9FEb9g11n3UNmhfz26OuXtSCNPRb/P/HGblSPgZklgqexhIutF/dman?=
 =?us-ascii?Q?vRiZVaEilmS8hB/RmZ5RRvFUjpfuqDN5EPb3ko0edT2ac5wjoezlsLVPTQie?=
 =?us-ascii?Q?grIPf//V2uSWTzWlqiRHfODIFIXAvanKs219icYqRPtuJj18n3tfD7Z3Y/xe?=
 =?us-ascii?Q?fo8aRDqnRL9z79NsLQU5om73ucmFMdflTJbPiKFJb6WaIMEN8OL40utnrM9r?=
 =?us-ascii?Q?toujHbioTBAJU+Zds8O4FnpAkY93UpdtgiOFTl+w4jtMpFAMmkYKUR0mSABo?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55add80c-7374-4f1c-89e5-08ddb238b951
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:31:25.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/6KJbmI4zrzI5Szo0s0ebdtXrLUmxZF3h1PDe3hBbq3r6ck0yNi7xRT7oQMNqPGWZhobho+kW4YAwn8YvFYu8t7MJZYsxTh5sh/VBcphrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11438

This adds support for 4000000 as secondary baudrate.

This value is selected from device tree property "max-speed"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

Earlier, the secondary baudrate was fixed to 3000000 in driver, but now
with "max-speed" property, this secondary baudrate can be set to
4000000.

The secondary baudrate is set by the driver by sending a vendor command
(3F 09) to the firmware, with secondary baudrate parameter, in
nxp_post_init().

Any other value set for max-speed other than 3000000 or 4000000 will
default to 3000000, which is supported by all legacy and new NXP chipsets.

This feature is applicable for all new V3 bootloader chips and w8987 V1
bootloader chip.

This property does not apply for w8997 compatible device, since it
downloads a helper.bin FW file that sets secondary baudrate as 3000000
only.

The switch to 4000000 baudrate is validated using a Saleae Logic Analyzer
and imx8m-mini with AW693 M.2 module.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Change DT property to 'max-speed'. (Krzysztof)
    Add support for 4M baudrate to w8987. Update commit message.
    (Sherry)
v3: Add check for 'max-speed' and set default to 3000000. (Sherry)
    Add functional and testing details in commit message. (Paul)
v4: Add error message for invalid max-speed. (Sherry)
v5: No Change.
v6: No Change.
---
 drivers/bluetooth/btnxpuart.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..c56b52bd8d98 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -73,7 +73,8 @@
 #define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
-#define HCI_NXP_SEC_BAUDRATE	3000000
+#define HCI_NXP_SEC_BAUDRATE_3M	3000000
+#define HCI_NXP_SEC_BAUDRATE_4M	4000000
 
 #define MAX_FW_FILE_NAME_LEN    50
 
@@ -201,6 +202,7 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
+	u32 secondary_baudrate;
 	enum bootloader_param_change timeout_changed;
 	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
@@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
 		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
-		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
+		if (nxpdev->new_baudrate == HCI_NXP_SEC_BAUDRATE_4M)
+			uart_config.clkdiv.value = __cpu_to_le32(0x01000000);
+		else
+			uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
 		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
 		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
@@ -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 		}
 		if (nxpdev->baudrate_changed != changed) {
+			nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   nxpdev->secondary_baudrate);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 			}
 			goto free_skb;
 		}
@@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1222,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (nxpdev->baudrate_changed != changed) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		if (nxp_fw_change_baudrate(hdev, len)) {
 			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   nxpdev->secondary_baudrate);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
-			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+			nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 		}
 		goto free_skb;
 	}
@@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1780,17 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate ||
+	    (nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_3M &&
+	     nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_4M)) {
+		if (nxpdev->secondary_baudrate)
+			dev_err(&serdev->dev,
+				"Invalid max-speed. Using default 3000000.");
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+	}
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

