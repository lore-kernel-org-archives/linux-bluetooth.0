Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BF30F946;
	Tue, 13 Jan 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290420; cv=fail; b=emi/dpwX8JYwZVvWN30suusv5gQzDoZmpTxR6iobtlChrS87hwaEw/wJMbR0C56ZGNf0wh7uCPBoNB9pZGs2rWwODc9qqa/LE3Q5LCgfYO9bJKeFofT8GqXNQo9G9yNxLyKGeaTolOEy/bodUJNOgzBGAJndhe14XFZ4Y/N6NNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290420; c=relaxed/simple;
	bh=jqzynD18vV/wXRhzRSmQBPYiCC+Ze0gsPQ8LS9o1Aa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqCMvTNKtYEVSLBJX/1TtjQFzEaBGJoqLlnMhQ+EwRz6JPQxwQB7il8g8ZibwclRGzYwmys3yAkT0cr+MoSB3Ai1Xrt8yx6XG1szu3uQMwkFICT8uiof1Y7MMq1VoS9SiJXGKhQr8IPKex7/Nju+Tx3aKA58eLvx0EAUquJpssY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WHuMxlfY; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WHuMxlfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kd3YD9316IjMlIXeDO1zI18FIyNWefao+RfKiNZRj8gNmgEk8ARQ1oK9CnbiLeummRA2k24Py1UwcexvaVPnwECJB1vMrjzeS7HKWKgl2fISarJ/JYzWHYBOaSTGAQ7X1wk4DbdsxTTaO7+mFBudaD9Qdt8lgl0hrGU1dG6kRFTuBHfXLXssHf66aMl1oDUwOx0Pj39F62fUXammRiyM9ZVj8guR2h9FCkQm2ecVike6yWiPPT/K0nNVB7XcO7ieXg5e/7qKufDAcSlp+WYbhq5+sd9qhWe0wuTFFJsA685xNJvzdlXsRMqSvG8BCf9cP7HC8vZrWWwXJl2bjBYZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7McIxIWnUD2IYBKCvgtzIQ3QckPbhWiYEoP6n59s0GQ=;
 b=w2xeCEP/2bxgGNiMokUi/quFpnHrWTR7LQLe/oDl60poLhj1nstKU39Kg9hU6ksyHsj/p0Y/vn2vY3zaAZZfX7kw6T25kkpqcuRYoLRXDfjKgHLMuArYh6edyKgQlkziFejHW4AAbiJ27U8iE3sT8/E3mfDnJN3OohTufOfPwEsOOCn2pkIRyt7n56hDweUde0UxFkz9QyO2VQ4bSYfj2vvEBcIaV5zuFjR/85qYbIppwnVX8mmkX6OrYuvwu0oHHx/hpERoNGwvXoYpE0gyUpD8ZCIslqC6WUe99jFECoMkUDvZgvCIViywRXxa9ZTj7avlWQUUrL4kFqsH/ZtPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7McIxIWnUD2IYBKCvgtzIQ3QckPbhWiYEoP6n59s0GQ=;
 b=WHuMxlfYpP+wAWxIormiO6BZTrn2V0P9TkGSoyQXdkTF2LGGngFMFptwIOiY2SsxwIS2QLu3UP0FrK48slEi4w9Um8DMvkTaScKqmyrsfZK1kBbZJV3DWnS6jMhkJ7Tt39+kVZqN1TlEtvr+i4G9OPFyJeZUiVa5RO+k/MXvpMF09gPQRnR9I9AbE7SGeNvSBeKKvGZAyUYi6CILe8J6KVa6utgTP4hbVdMFajdvHyCGp7T3TwdfbJBrF1MOW2XmxFT1XM8w88xc2F7wYcrVNjHIf8+X6Mw5pZkVE9mep0OnBtr6of369BNlAQMAaCAOTMrkLjeT4wS8Tvqph4Pnpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:53 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:53 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] Bluetooth: btnxpuart: Print FW version and enable chip specific features
Date: Tue, 13 Jan 2026 13:17:09 +0530
Message-ID: <20260113074718.2384043-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dad713-95cb-4f74-1e00-08de5277eb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrAMSoLMxt071QV9I0Rp/3iihSg7hPq4kG5zUKsWioE9Mp4VLHKdYKtKM+Ud?=
 =?us-ascii?Q?8uB9NClqtg+FbTrpmMYsMMwAxZGc25kHfAgYplQzf/CLJcHCs5CUAs2YDU6m?=
 =?us-ascii?Q?nVVKPXk8v7Rl55fDgOdofgS0evH1M1shsi0csBKFC3PTwVcvfBjAtyxgSN9S?=
 =?us-ascii?Q?W69riu3iLRbUa67Aq3xVuECvM01H9R6KtHRQcWDE4IFbM/S106gaAwqcZ/C6?=
 =?us-ascii?Q?VnF5DdeRVvgbnEaLddICRoYyLkyzosrv+OS23M3XiZH93Y+6NmgibbRWbLdQ?=
 =?us-ascii?Q?dt0P5LU9WIHnvQ++x85cNDpcflzvcKtP4Sv+TziJq0FFlOnHl8tYHCsP4Dgy?=
 =?us-ascii?Q?N0GARl/fnIolwWWjk6FwIq9CT6VprOgVQOXzxHDmK+l3qh/LgamypbWl8O+E?=
 =?us-ascii?Q?F2wli4HYjwU/U8uJyP4l5jkBE/gHTiwlmY0SVvDardUuKCJZE+yTu1cpXD/W?=
 =?us-ascii?Q?C8WHIzpQuvWcIy9NS+MrTVm0rcWamgeFAB+6gIGng6Y/YHg5rpXiQL0IIov+?=
 =?us-ascii?Q?1m/ZQC7C4ss2zCd15WX/UkIH5u9wHZ6LEncWgoZz+L+vGL0GTMHK+fwsPffF?=
 =?us-ascii?Q?SMUVBcATiwaLZPausOx21JlihES315FeU/A4WHFzb4sr1uMlq7pd9yuRoeg2?=
 =?us-ascii?Q?UCU+PvkOvDUXovIPPeongl/HNSkCSFwG23Xhawb9yQutmMJP41jljhmPMjEB?=
 =?us-ascii?Q?27lA5uTQVCDLzC4VWJFOH5ichurFnE1wCmV0/oyt3YLZ1emOqFXxGQj8+PyA?=
 =?us-ascii?Q?Be0DNrXcAwDIT6mUCjMIb/OreAsZOG7AlGEypf0/AoP326FDvx7/hB/gfMls?=
 =?us-ascii?Q?AjwMqYLH6MUB77jUhgKQ9HPOkEJ8QlTQGE19lMVAa7kZamM3fSCLWQHJj9dJ?=
 =?us-ascii?Q?L9LwkVO/CghgK7igripWka9XT3DvABSSmjkvMXpTKer3kpsO6//MJiZ25+1k?=
 =?us-ascii?Q?DYJzIcyqt1NSFk/cj+M6dklgMES6n1xa820nEwAg+SsKpMbuCi4chhpSzpT6?=
 =?us-ascii?Q?+t13vCtdNewjC9gxBi9Yv9+GkeNS5znpgMdT18zaPPocbQPS/4zLv+Ltmr7J?=
 =?us-ascii?Q?Ytli+u605Ucg1TsNNa1LSoYogarPEwUpZkbII/GOwbUBWfHZ3teJ3cASNB6p?=
 =?us-ascii?Q?nLqF+z98JihdFa8Z087pey/zIo1w9I7yiLXKweGsgkBA7Kq+BtOeOjNbWjI/?=
 =?us-ascii?Q?w8dMxhmcck5StStS/1OqcrtNgd4KL5EdbnjRghzwwWDWgs0HfxP+Z5WE9K8P?=
 =?us-ascii?Q?XXcEmdeWfqDXKJE83lK15oR2CCR4khgnRMTRa6Vn34XMAzoHaPD1afCGJJJn?=
 =?us-ascii?Q?K+Uuz2h+iiOhpgFAIgzpDzJoqKD4X2obiaOCA36SiYCMWHsiR51GHi7kOjSw?=
 =?us-ascii?Q?lKoSWsm0DlgD8u9pEuOlAN+XMS/qtNbwTH5MNZPbezUZeuFMItdRpiFUzgpM?=
 =?us-ascii?Q?KgT6f7i5W7yTqt0rQb+Qhc3c4UeD8RygFiARb5yjpQ9DlIrYeagxfUeDqvSE?=
 =?us-ascii?Q?s5rKWyVJI3lflF3e19uX3pvP0oD7RehZRWrj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SU+h1G+GKj/pHTWmkBXFAUNcdZBA0ZH/pRxf8F3WwPD2GjNBPC7dXVnkx7lM?=
 =?us-ascii?Q?rCDkKAfOXBtS48FuXyZxL519Gw9pOuKfKj3DOskRQET2blZRUhtJA7par8Ao?=
 =?us-ascii?Q?kke+xkSn+370p+ijCTGZ7SkMgJGan8wHvTUn8OvE8RKRQWvlgCuYttV922Q0?=
 =?us-ascii?Q?HsivyZAdj7Ohb1GZuUofRIoazTUCxkoBU6Hz/gWeiVHRcveMf0+tCau+seQs?=
 =?us-ascii?Q?dnN/abAfJEfGDba8UMQ1s+cNr9vQrnA8LZb1G9WxJBBd9JZrrOSax5bx4R3z?=
 =?us-ascii?Q?OUEFPCRH3o2m34HlTv2SvWtm/BKYmnemECGK36lJ9R3oKYt0ZzGUuo5uyz5h?=
 =?us-ascii?Q?+G5neWtz8hwoa2eoV4iq2zvr33R9uKk8sTNR9s9+UThBZFs0mNVL3zJSQBjf?=
 =?us-ascii?Q?Ldu8qKD3mSgQcpGRVkA7kbVoZprb5sPlSNSkfeG2IZdqx6Y/c3+0j0Q/8a0I?=
 =?us-ascii?Q?oeGAjrSxgkLvzV/GqIsZp4mYp1KuhTbp3FA8fGauHSeac4QCzykJYOcy6GlE?=
 =?us-ascii?Q?S7GQAHalvo+WpQ0fsuq4jvTwACS5ScwGx3Rr7PDuaqb5lLPVv3jqu57lb32R?=
 =?us-ascii?Q?T0bQVXk38QTt0L5xIFWIAM9rLCXZv0QpQ/Qid3w4Q0yKGrSu6kusxLJJJ7MI?=
 =?us-ascii?Q?iVvEdloE0YVLOtQ1j8i53d3AXK8tLfVbgUqWevdONjEY7uSJUqVapjfT+2fh?=
 =?us-ascii?Q?7du+VNg3JQBvgZ9reuGwycgli63NlNFOwX08BOmX1G1ywsCJ+ktTa7chbAa2?=
 =?us-ascii?Q?TBLytHgyMSMbopLK3XJTK1qdPh+VeSqN8MC9cDSX7bjfmsWNwSyUayQe2gA4?=
 =?us-ascii?Q?d3QZNhV1WsnDBJ9g1vtrsjP8jZON9ymZdbKYfhu880O5HMp9rnNzwg0LVl7n?=
 =?us-ascii?Q?LTvDYSRmeyHt5CE/Y4KXcQyUrIRK4zwIZk19dX3yIQLkFxu6axCEH8XW595V?=
 =?us-ascii?Q?AXp79oqNzliicuTSjW9Z+jSlnlwrbQrbKSpxNqTwuVm006Ha2KmCFzk5i0FT?=
 =?us-ascii?Q?5WpQY8p5zRUpoF2nZYbE/OPtTEHn3F3EQ/1SzxE95jfRR0Lna4Fxyrq39taU?=
 =?us-ascii?Q?KHFgMfecoU/0X3gsF5us8tx5D2JCS4T7pvCgkERRPBiHti4m0Jz2E+nd0kaN?=
 =?us-ascii?Q?LGMB1GcgcHyA9DNyKEiRX2p97n8LxNeU/wAGl7DDeZNIKSjtJf3tRtkHNo0l?=
 =?us-ascii?Q?/aeXtyqfXA6e4v1lngNkLBLxl4pBP04XsAb4rO1K760qMbh8tg5zCmh+hODL?=
 =?us-ascii?Q?ogk8MZYwWDCQbhEKXkzLGmcfeSTVAt2Lt19uhrHOCQSbf5sC1yeIJin6ag06?=
 =?us-ascii?Q?WoM2cXyVFyUme7iQePnL3sW3PhXo568ydxfJlAId/wFp6jx+hTGG8TRBlX+f?=
 =?us-ascii?Q?/KRORbZbCCQYpx/3xglMjMqYADw1cYwvrd28YXI5CFad/h8yWQqIqku6/U72?=
 =?us-ascii?Q?W6A4ixthORqVU3gShJMGsv96BdN+hUenB0o8TU7R+35+oEXnmi8pj1Bx7rXP?=
 =?us-ascii?Q?DFMh4U6TbXdFf86eIKJpozNOKevqdQzKxdLxlBhdnWEhI82Z/fQnfigcDKTk?=
 =?us-ascii?Q?UewkCCF/owH5TX/XwvbiSCUEjmK76pKSF3fLO9Kx7MMdbFJbjjDVp8OQoMBw?=
 =?us-ascii?Q?MGoCWw162Ls3BTL3kkRJNK03DyWaE8QSoTx82/Hi2eVH1iMkWVkroTUcXXXI?=
 =?us-ascii?Q?MFlQjELL3ytfxfbuaDCRn+F82Q7yNiTjDJYqkNcoXY2OzuZaKvu5d9xWwW6T?=
 =?us-ascii?Q?LDvlQAvIMr1Pv8u3T5Qj2MJZ5mkn6DI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dad713-95cb-4f74-1e00-08de5277eb18
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:53.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L23aa6n9keYthbk/jPgSuVhgdK6+XsWZlRCngcboHNh6vc3ykHYQYMhfDRe9R/AeA7VzdQfsvopIHgvftUKFJI7KPKEvDeWAMvz85vaWo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This adds a print for FW version after FW is downloaded, and a way to
enable chip specific features.

Currently, secure interface feature is enabled for AW693 chipset.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 78a7651d55d6..d2c79c462ebb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -105,6 +105,8 @@
 #define PS_STATE_SLEEP          1
 
 /* NXP Vendor Commands. Refer user manual UM11628 on nxp.com */
+/* Get FW version */
+#define HCI_NXP_GET_FW_VERSION	0xfc0f
 /* Set custom BD Address */
 #define HCI_NXP_SET_BD_ADDR	0xfc22
 /* Set Auto-Sleep mode */
@@ -227,6 +229,7 @@ struct btnxpuart_dev {
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
 	struct hci_uart hu;
+	bool secure_interface;
 	struct btnxpuart_crypto crypto;
 };
 
@@ -1554,6 +1557,47 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static void nxp_handle_chip_specific_features(struct hci_dev *hdev, u8 *version)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+
+	if (!version || strlen(version) == 0)
+		return;
+
+	if (!strncmp(version, "aw693n-V1", strlen("aw693n-V1")))
+		nxpdev->secure_interface = true;
+}
+
+static void nxp_get_fw_version(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 version[100] = {0};
+	u8 cmd = 0;
+	u8 *status;
+
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_GET_FW_VERSION, 1, &cmd, true);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to get firmware version (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	status = skb_pull_data(skb, 1);
+	if (status) {
+		if (*status) {
+			bt_dev_err(hdev, "Error get FW version: %d", *status);
+		} else if (skb->len < 10 || skb->len >= 100) {
+			bt_dev_err(hdev, "Invalid FW version");
+		} else {
+			memcpy(version, skb->data, skb->len);
+			bt_dev_info(hdev, "FW Version: %s", version);
+			nxp_handle_chip_specific_features(hdev, version);
+		}
+	}
+
+	kfree_skb(skb);
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1583,6 +1627,8 @@ static int nxp_setup(struct hci_dev *hdev)
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
+	nxp_get_fw_version(hdev);
+
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
-- 
2.43.0

