Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46130217F;
	Fri, 28 Nov 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321338; cv=fail; b=B6fbvCYUMUwbC/N1QAwALHO41KJq8XjWY90JWO+OKO2T9C8WijhVdncFbqJfuQe70LVLc3unuk7erytpquLR4Ff87qM3sSv87ZKELKKZ6OnYjm2fZ7BZVye5DIYPL9NlUniDvk3SBgpU2kLKHWhNwniLSatmCHMmRkvK/QyQt1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321338; c=relaxed/simple;
	bh=jqzynD18vV/wXRhzRSmQBPYiCC+Ze0gsPQ8LS9o1Aa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nz5RDRroPxZqVpHqtTVhIave5rOITltV1tl0zY7wZHbWjDqIL17hSc4ENQNCEXc28Nel1pLzMzzSvy12XhdhqJqCe3HqmH7ArA+bfA4dZxg92jRhJ3g3GgSyVjtCtLfLLZrexxFGchFrYgWCewTamOaP5k7xkwtUn/zBl83LStM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E+N4+boO; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E+N4+boO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kke8t7QnXU0vERTBWeVpX4eVDz+PRdHwIVnY0Rdy6+T1udM2RkPtRpEMF7dwN8BiM964pcNAK96ePt+MuPusWPF3UNebWTFEVbbiOzuPFF+02tvRhFmur4GyvyNsxqabs4rxPdLGJ3ag6JUosKnmNCYBBne0v+w7aOJCPqog2pt4tWt3VRvL4oaeQvq42u5CBcNpWVGTOkvN0XZMHCqRX2LgoDcotnR0gWhU81RM2NRfUH4cuxEDyr1rjClFB+WdlJ9C733C5sGNqEyY+fF9gquBpeCqvS6h3xr9O4AVhQkrjRdPOtkCbBl3UcLmpxZqCQ0CR/o6EQrpmyBjTaIYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7McIxIWnUD2IYBKCvgtzIQ3QckPbhWiYEoP6n59s0GQ=;
 b=qQcQ9eRsBd+ooVEiWOLosFJS/SOjmHTsA2kwfHdS9FtBWRFokn+AiI03sqdrYN6jKDqb5cbMlZxHOTsEycKwQ9DGWNepM2V3GBY+EwqcYysDt9eS/ba7MwzQ64TizARoNpdrRlEB4yrGJ9DtqNA/5GQvS5CzvTmuPR5Pfbm6XDNPu/Ky0ojFwwTnMA+5fDPRM0xZmK9rBewSNW9BNbMLMZmwZmcWpTUfkbB1tdbALj6MBlQ7AIBUR3TVpa0ye0OyVZsgxETzJ0GnvkI0edS85eUr3ysRIpyQGmEZIEzs7QOlUH0VcCBdB/GijHltHoqP00MqYrCsZIa4HjqVnBRwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7McIxIWnUD2IYBKCvgtzIQ3QckPbhWiYEoP6n59s0GQ=;
 b=E+N4+boOvCswZQedFYAK39NSVKrn3LAamB5flTZ/4dlNrkT04wjUpYTJOO1VNMyO7vuBq168bruzP+vwow7CJLl6m7aHzhgMV4tyfwQfWFAZLldjC8x8OlxmsUudhByhSe+YXMQLSX3iRO+Bo+B7kwwfCFCphPz62BkfU+h+6wIggxg5i+OQ/lgNSe/elUrLZU5Qlm2h5sxTejOytnmziudGdFvIK5AWfyf5UA/W74YA9IK3tEAF2nhUainQ0i7w1L6Bp62cIu1zLOBvdUJLZsMwSsMSH9AC+Yiu1NKySWtzf8OWcs378NcgqJbFLrt6V+WOyIPpdGAY4KSIah668g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:32 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:32 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 02/11] Bluetooth: btnxpuart: Print FW version and enable chip specific features
Date: Fri, 28 Nov 2025 14:44:34 +0530
Message-ID: <20251128091443.2797316-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b73e9c-de57-4834-7a06-08de2e5eae97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/MfMiU4aOiODKrmRWg5ALoUgnt7izdVa97zLj6r5yUgBqwO61p38hkkYk6U?=
 =?us-ascii?Q?xoSaXrQ8oP0Rh9/qZkmkSZcZJZEVveddtA04KCQZFBwcoMtlE9X9wAK4qaeX?=
 =?us-ascii?Q?TsPVVHIoyExBoAeZNFRJ4EN2TXyOsoWQ5eEHNmCKuPdeloxtdQgYC3JUGttA?=
 =?us-ascii?Q?ixv0/yR3iJ74hpn6sW0S4gB8OoJ4IeUYUZrTemNfRlqAab+yyAhM2o4UnX1l?=
 =?us-ascii?Q?ckt5DSFHWz79NgwKgPm1Tpv4g6uHVr4y8VvA7tSQaHNG31TcaprFN2/XvZp+?=
 =?us-ascii?Q?VqQ9bd5LvIfGxRz+u/r01ms8TyC1E7uRZenwkfGaBJFXtl558XCAUdEsVKpq?=
 =?us-ascii?Q?wC7BUs31bOYCrtYEc5n4YwaSKmPb6lALZ+gC1oJLliamLTi+fA5dF8W5BiTO?=
 =?us-ascii?Q?VeefNlX0Eg5zXroX2+FZE+CZVp4aMWfCFuMagiuRbkZy9vd92PjFG3/bQUGF?=
 =?us-ascii?Q?GRBPpv8PN7W++t0e2oHjb3gNXgPhwNjhmu+YHZXOszbajdFipDgwwZDVnPBW?=
 =?us-ascii?Q?NecPlJURBG5++pLczshq8g5+FTFWy8B+HZI3Q7ePtZyjKwuuSibQ2Ggz2cCB?=
 =?us-ascii?Q?zUD9ClX96Fw5I43jQyoPvtCqmRhl3SNZLv5wzTtmtirhqB5NPNQfAT2an2dO?=
 =?us-ascii?Q?44kblMlzLGc+bPnuD+W/LkwyqwAzF595oH/dfVtPCgQLLaNt77xl3shn4+Ph?=
 =?us-ascii?Q?fpbxKPIUZrfpkt0xjIIHlxMy/rs13GmdGCSJ+pwqxupPuU7fLf5PiROQZdAr?=
 =?us-ascii?Q?FNG6HCJoHzvIqn/9AgOr/eEv4LwrX3+JYse7LveHIOcbmoMCOx5XMCqp934K?=
 =?us-ascii?Q?bSOR3OyfOOXQIVnAz+KHAAkaDnPbm0gbVsYCAqmiYMMwPuAe/KQrcGXGlTlp?=
 =?us-ascii?Q?8pGJ2ema46zgZ7CTEromDRnYVth+LaqSkmZri0ctAxtjumph/LoVUqDzwxSV?=
 =?us-ascii?Q?8Z8d6l+dRAzXIJAoXbhmvMZTH6BUXR1gvlZjKFbSl1gkq8VIWC929ePOkYz9?=
 =?us-ascii?Q?epYhbh64xhf4b5ToChc+4sajs3vz52/LNhKIER6TynM2+vlO9wjHNdF2LnS1?=
 =?us-ascii?Q?HA4GtXkTEYs9wbvFxGym1KFu9taGUjlFTco3OsCchBK+ZC7v0lkmWEHkjWI7?=
 =?us-ascii?Q?q6pZmusfvlDDFpsgUsDqfjqfDu+/UdfAnLVbRiYQY+zKZm0I4Rja7lPzRpfJ?=
 =?us-ascii?Q?IF+1OK6WZOnsOVcLTTzY+oGSNBvohCAlojTx3S2BOymPEC1sLYd5b/BIZ6vF?=
 =?us-ascii?Q?81hL4ydakmEAdKKslUPhlFmJqc5lCh17yr4dP4pe8tdNJ3g5Zn6RQOmzTOEK?=
 =?us-ascii?Q?ztO3fmjFcYau+3mcIMFFpSYWXgyWF0HL1kCUaheLYs//N9SESGzz28CLmRJl?=
 =?us-ascii?Q?VKFiiA7WgeRa8Km/O1wO/bp1gxUj3AUs6P1iQpDphNNYJy3qHhyu/pAs7hHQ?=
 =?us-ascii?Q?QYjT5FnpPA8iGIXEl3AW+4r/yC+fG9tMg39VKjr/07KIDeM9RttqAQuZzMoW?=
 =?us-ascii?Q?cntmlglCOIGAyXGAgA1s0Q0BQh3Iq5khcgHx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWAYCSUVIZm5OSOIGaC3LidB/p+ENDtzL+WnwqDTcKZU8onO4oyC+ZXYL0g+?=
 =?us-ascii?Q?EAVZLsQ/ANdDYqxayju9/FHMChV6+P05K72cdnR/0DSAKooVUum8kOKl0b6A?=
 =?us-ascii?Q?BmZhib/HdqMB0o9LOAm0TWGGXYkZ3Qh11cmAf/Fs2/rS7/zVawJsMv8KxNFW?=
 =?us-ascii?Q?+Tu6GXThd4rUT4UTlipZudOMu05/Tinl+AU8g9XzJcSQjYs7h9DQnNo8xMEx?=
 =?us-ascii?Q?cTP5Vb1xn4s1z8J2v+WrD0WHgkZMi54IEQcZ7JsW2u/vLl58RV/eOHSGfJ32?=
 =?us-ascii?Q?Ki5dWdaLHHMAaQi5lLEQ7zH6MsMQ3maUU/GZ6CldF0GfisG4P8D/FSriY2yH?=
 =?us-ascii?Q?GeOVCyPXx2HvL1h1Y17p9PS9BSqlJNboqec6W36oelwHAytJUuOnzhkQcCZK?=
 =?us-ascii?Q?UbHeKMY4eHsX2TWOpJ04xzNcMxEXppe7dVYFeuSUiLmTYhuGM3ME6HJm5nLT?=
 =?us-ascii?Q?VtsBOkPSFivkahvd7BZmv3CuTvrwoxiuF9YkPvf6b24wQcAM1PGPlR5DtrMw?=
 =?us-ascii?Q?CKWbMPJp/EDQ33aN5CjFuh3P7k9OTpCQTVUqA7UaAf+lGEpLkehrbR75T00F?=
 =?us-ascii?Q?1Egrt8ZlZ1zSVYM5R8MtM78oOJ5NRa5/fKK5vK/yxmBc3QW/IzZLGzaNrJjs?=
 =?us-ascii?Q?pHMhQ3qNrZ8Wn4PWsW4/NMK3hWtaxoYngH6sDS/dYV44fGV45oTSGB4yCs1R?=
 =?us-ascii?Q?S5l0hUh1eyC766EZd8ZI/xSMue+Nj/WA9voq5+Ygb4lr567bZXoSztH3Pirj?=
 =?us-ascii?Q?Ter/R6sfOGl3kJgb0eWJIAjASFMcTfA1iAaV2auxMHqx7wP7InZWHNbYbAmp?=
 =?us-ascii?Q?62oUcgKozwQqEMnMkG4c+vfVNCwp9TphL279+Wid/VhihWCYoD8SplYeMmlr?=
 =?us-ascii?Q?ojpvQUVTRYfIG+d2IU+ZCaFM4Al0NO9g11MhoPcW3n5gP8bNAB0Hql4j6Ads?=
 =?us-ascii?Q?wWH5E7SMT7DpNepmV2Pa3f5NIECl3RAtjsJxqrd7qR86krKYMJLl2DUhBeqj?=
 =?us-ascii?Q?A6CPqtmoF9wFFMMipnDvEteeS+D42l9n12B8kr+VlnjSHkgWfcbqaeNbMLux?=
 =?us-ascii?Q?dOn0VifSZY8onU5BiMg4oduM8IhTEWoFNDUozx18tYJmlUI66cVgFo9x6rqS?=
 =?us-ascii?Q?ArVi1MyP/syYnOB/33hQE33orsbtozZ2WqFAqtxvJQSYnB7q2d0Q9xcB3Pqo?=
 =?us-ascii?Q?i6JipeD37TPhIJw8AMIxL6Jo+q9l9Vx0nUlEVAKZ92M3oIBJZHAHU3XAiXOC?=
 =?us-ascii?Q?6HUuRN5EgZP/sPEBVvyzXkuBxVJ4iruL9ytS5Rfq8T3SboK5UqwWL+Ce6X3R?=
 =?us-ascii?Q?vtWkmfRPFCtrjDfE95KCX0kagCQlM9DWq1QtlZZ0/kFMMHQMmHSkOCsW5ajh?=
 =?us-ascii?Q?ZbTE76kpaEfViZajf9Q6yp99QDIaH7i19ZeKsgbUPFLavraSsGd3liK8o+Ln?=
 =?us-ascii?Q?8dDNyYXqdaxgCNRILecuN7IbkFAeEVVhHlEkjUTeg+xJ74LGi687jBEJEXhD?=
 =?us-ascii?Q?1Iwe+LmXLLAs0JwrO9l0HqAWnYfdWiRADmDjnAJ4sh6T63Nv5Tf3faqYTGev?=
 =?us-ascii?Q?z93yeMMpO3O4ONrBnxf2G+ieGuxwfFHD25HKhE66uBbNEoePKsJ/pfasHEQS?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b73e9c-de57-4834-7a06-08de2e5eae97
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:32.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q88TRQi3R+1AoKoJXumkEY41qhY985johz2SwvIznajlNAJqVR8D4eNRd3OrMQaLqwcAzmovBsw4OdTljm3IwGbra54cSRZSgc174KCDOVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

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

