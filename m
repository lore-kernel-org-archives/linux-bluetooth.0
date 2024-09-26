Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13551F61C;
	Thu, 26 Sep 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321831; cv=fail; b=bohHdjGnurEHt0eFnK3RjRGarjQko0dVnEdTKNUdcF0BN6NcDXf0iZarQckTzA+OGg8k/h//7uu4V+eVyDxCpQmUT8a/PmTlYYeo5wny0eciMmTgLO8pV1KDHqPAv2n6D1lg1Vn2mcThaOEYdnzyV/nhZEJ47P0pVp6MlpY7Ng4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321831; c=relaxed/simple;
	bh=j96wQEHyWt0ftpgq3sGgREu0hDQi2lGOF0BUYBD1u8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=An0NtYA/RvONNZPq7kOzmY9kxZ9CTVjk1lT95TvUzwWCzDUfAcn/En+8/vt/OPKDInLC2n8bp/46IajOCssZO3XS2ynWUCcdntgIAJLCIDTLkEb2vknkAxSZjdDwBl5JLGRaRaSu6OvmbKZk5MlOTKoVaD2+5FdYAoykFr3MpQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kDxx3GV2; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kDxx3GV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCw5e1ZSWo+15kf059Gi1VRJFVpEFbHRPFHQOGMMoD/b45dgusb7kvak0HUSgHNWCQssqN44ah5nLTJbb7fpxpfKQEPvTGVhJdYiKa6b++Wa1vFS7d5XXt2jH5td8x35kizFA2tYdP07EGRSsWhf36cFC6ILhTRDsdFfakq0MKyZ4ERJU8/nGKwF0ETj9GjQJ+8W9gA12nVr0dIjfkxw7GOO5D7iGU9f02oRiktaM/kSps5hIjbVZMVg4KcaxTVJKeB2DoJ0Sg0e6LjxId0H4ePfZ2/GowhvgeEoFkSTeQshZ7JGMcC6QZPtIHZsc5mBKwCn9ZKdjrFbVGX3B15zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmUUI+xjy0wy2AebJ/A5IH8UxNNdHDzMAn185J7pPNk=;
 b=R4o4yNYklNqR1ilxo8KNWMizvv2/tRxX3r1AIet9nGNIKt/l4NLT2HIPpCRbNtc2xlFgT+pTP+VfO+iJdTj/nI8xDG4XZahcoaG4AlfZ23QUa/1EvvLeC+licTP5CPr1UnB7OkPJZSMxMMI3+1jWyzfBOnbr2bQkokqMn1Qyh+vkQ+d2UfxQl+qwgqElFZ+Z3imBuVA/oMZpb503ls7BrgshW8fuLZAvOHN5wQTQPZHWnPNnLjchYDe/J+bKxSWvD2pWH0fmpOyVPa3AXJBJ/VaxRRMBUWtlMcjhOxAjx4aQuZ563cCcEiCUyoNNxRO4ZNCZOFiClPrIAMLZajb21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmUUI+xjy0wy2AebJ/A5IH8UxNNdHDzMAn185J7pPNk=;
 b=kDxx3GV2SxYA0sytpd/SzcZDeA8E86rttks7l/NtIugsZ1IdVmjExpT+zO+U6oaSGEB8k+NOPoJ4y/FUD4S/WH9eha6rQ1knY1AthoquZZ2YUG++9x8BSdulzbM3PmSWv3zBJzN86SkLji+e641cspxByaM8xTTFky1FKhEkgahW00vfbOgI1jYfMXo7hPmsR9hGmBb+yGzfnEzteTk1oxQcXu0kYstR8zAyt0gsl2pCTquvkWnI7xAwT/8hka1m1WCkxgIenUX6zzjOV3Ykngk7ic94QAHSpWFYQZ2/UG3yS2UXTB9BQlr178PoDPbC2uoF7UVDFel6rW1hwTvxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by PAXPR04MB9303.eurprd04.prod.outlook.com (2603:10a6:102:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 03:37:01 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:37:01 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	yuzhi.jin@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Drop _v0 suffix from FW names
Date: Thu, 26 Sep 2024 09:08:04 +0530
Message-Id: <20240926033804.367472-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|PAXPR04MB9303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8a5d2c-e35e-4325-ef88-08dcdddc7b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+XYiV5MCGj9e3ENSEq7qfLTZ5bk5qW9OHrTeMejpeDAigr/GC7YPjtY8s4e?=
 =?us-ascii?Q?Ww+sXFWyzJfzA1Eg93WnJ5+7AGxit43NhgS9GztJpFTB2UVddb85J5tCWXuv?=
 =?us-ascii?Q?wmbQJO+qCZN6mw0NqD9Tvg1mU3U3bmrbZX/o08RSPmuiyXl+xlomupqkXI1U?=
 =?us-ascii?Q?qZYF+njO/vO5hPYL4dBeeu5VUHp/pBHbt1bfDwPgW9fElgrz9wXkuf8JRPLt?=
 =?us-ascii?Q?74nLcoSp6ShrxLFCQ9lZze0wIbNcvLjtyOEmoOhFmJlkIrPyDKt8KBZ4/0kC?=
 =?us-ascii?Q?kvUa229gcgh4lmBeX1890PZ0NeJ24UCwQ7yz+wt40EYBAOY/uAjH/gSsNha6?=
 =?us-ascii?Q?SyUByHaYjXLjRjnxSJ/P61ht/rmrw7V5dS1z7XgrGQfSeD60ox7CJaGWI1pn?=
 =?us-ascii?Q?xErxqR1w2I4wyPLCNXSeH0JYYuTJINEagAaAEN7pJovh/g3qtD9U4UY+UA0D?=
 =?us-ascii?Q?uth/ItJ3LICpXIgB+an4COz0mlYNP314mtAR1/acIB8hUDhX0pOvdtCLH0wM?=
 =?us-ascii?Q?al8RkkpaSIMOrwXFeFCP/7nu4gINNwZat0y3Mp2V8T7himzDokhlAbsMmIOW?=
 =?us-ascii?Q?FQO67WRdMNDzwX8xwGNPbPKBRZzKNUev3cKCKlEBCuilbBnubux1x5xBUnH2?=
 =?us-ascii?Q?vsNq9ZAZ0F3hrPvAlVEkZZpILtdhjfVzE+PZHBHyMUG14RcOvS5eVgXUo6iu?=
 =?us-ascii?Q?A7syhRPmkKP4rz3zuiabipDDnrGRzUijp/zG1MnQkXkwVz/HoOs39F+AO33r?=
 =?us-ascii?Q?jUc6EggOQ0fG8Sl5gzsBPVIGyGQlvBNh1rZzSYjn01po6KlDGoscvDED8mEY?=
 =?us-ascii?Q?ij9emyC9whGrrL7qG/qGdDvUoqDk0tThth0vNu4gwyLT9L2bZcWot9CFmjqL?=
 =?us-ascii?Q?Ua5iuIYpb0Hla6GkhJ58tUCTZm57LLqWnBg89+oC4gffJ6Ty3/9hgDeXd8Y9?=
 =?us-ascii?Q?vrcHUi8FKGBhniN2w+eELJk10xdxVQFJQ3tXbDaMTbU+eM2MTa32garz7QKc?=
 =?us-ascii?Q?zs6myvPxExiDnHt/YHnVVdwmRFi34bu0XpOXufqNtg5rWQNmIHfxeJr8L5rF?=
 =?us-ascii?Q?kXntvpGU/fWTY+Y2K7daXT960r3i8bRSyEgSgp11mtgBUxvk+JQW0Cy8Y8TC?=
 =?us-ascii?Q?8MKw9B4rjxIgkOYssWP+jWu6TgbAs7MadAU1kQ+W1scwX0CwpcBQrlU/Lv8P?=
 =?us-ascii?Q?ZEID6tUs3ZlzetOi9K+pNRCEUhpRPDPmxHZRLdJ66oUZcgjrkLDI6cohEUjc?=
 =?us-ascii?Q?aEvfoG0UTz33buX86bmBtd1uavET2/E6Fs4CDjH5P7Vq7CsNpPUvgdgTtrUn?=
 =?us-ascii?Q?vf5+K/jGQG/L/GgztL5wQzGKn4T5N+M4Vt/WlLu3VTFvVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rf5RU/JsDdeg+0adzA5lbsfOwGZ5RMZ3K+NzMT7cdYCjJz5UNfepYzsDviGX?=
 =?us-ascii?Q?+P+VcWcBja+WFxsculvTrG+DaTORfl8xXKJiDElodkZmRfPgNDz0kl01Y/GN?=
 =?us-ascii?Q?+HlPYNa7E8QeyTEB6hJmngdCar7nu/B/6NVGlHUGcv5jzW+tN6w4E0R3rjCn?=
 =?us-ascii?Q?zXFPxcPGm+L0U2m4u75UB3mRT7Q6SgS8bed0ThKVC0EzV6r3lmJfJJIyuT87?=
 =?us-ascii?Q?mL5RY28op69yl6hi2ziL3PgKzGZAvkIl52sL+ITGF8mN+5NjUUL309itpykK?=
 =?us-ascii?Q?zLH2Y7F82cUi8kK4f4OlQH+Amwb0aC3QI3NdeaEXOqkgxSkjOPpQj6SQFwdA?=
 =?us-ascii?Q?OTaLHAI5iKtroePQYrCvyPuOXNdqa5G3Xykn9kYhf4c9XoEY0uwAouF8JHi+?=
 =?us-ascii?Q?CMD9/kZkTPhEfEJieK+tMH73ceiwsUOSNUK+1ng4O2axIPVrQFU1IX6XiU/Q?=
 =?us-ascii?Q?v3ip5wgpdVyJx6pH7E7sT7YgZBwmXWixDL3HVlLMVhdXcWu8KI3mWH/2XIut?=
 =?us-ascii?Q?gn+zbbDyMIIMpXgOApF/fmTAcsbJTV0va8d6ZwaRvtKahfv3kpLBD7s1f2Hq?=
 =?us-ascii?Q?IBDJURcds/OhNvGQmwm/nrcG+txHrGF4NQPp0/RRKKP0WAuFwUmjHlJVuuyo?=
 =?us-ascii?Q?gbqO8xsG/M4ez1SgaXNfWW2VflWEm46GAYrcVkyayLfXDtUsc0k45FMV0t1O?=
 =?us-ascii?Q?n/H+Ejc9L1kRMC3yysiLxCelWGCaKK3/YpctDy0lU7R+7+lh5pBFmFmNjVNT?=
 =?us-ascii?Q?wDrcCaBA+6QgsZNvAizkxUz4fx82VoAUqYa/U/6+9Z4KZ0KeHhZPva4PZXxv?=
 =?us-ascii?Q?J3I5dj9OkMGlRB1A8OnM5gjAW8iTNtjt1oxsSfVwpTDdOE4gGEADEDYRaQjJ?=
 =?us-ascii?Q?uC5cGpMoP9WiIF9RQts3yOc1Aq0wJu4we/e3UtxyCrJf7VRI7mhe73goCMSL?=
 =?us-ascii?Q?vWc8vVHgQCzGODnBqv52p927IxmS5Uuj2oXkZsMOxn6uLKLZFbvjsAwQuDn1?=
 =?us-ascii?Q?j6OrMh45e0/qWnjpPAComik1QzkwfScg58ZgwPadEnaKserdlT73rgvaEqOi?=
 =?us-ascii?Q?dHtIqwl79kj02w2qxqIjDCVXzLWDf3EOAaUDHt6SpAPK8Ku8vnJ2psIV7OXa?=
 =?us-ascii?Q?RvPCBMf66SX3k736X0+BmGFREsKn5A0tuK7BSEU+Yo5mc1u4cUAeGvrHJyp2?=
 =?us-ascii?Q?Uxs9UWIqDyxVcgfEi1ODFVJfmJ0bA1e8TED+2gOlFr2xH/AJblrG031QCz3I?=
 =?us-ascii?Q?ii4XhYgi/xsXF/OPctHtqrmtfcZyYMf+4K/hqM/nequ/bmgvLxKY82QGC0rk?=
 =?us-ascii?Q?j5Wq7PV052PhwXjy7juNJV5DtstIy9IJgOaSc525nk+QJEYGnvlrpQe6KN8x?=
 =?us-ascii?Q?f7BJyxLEnHlvQzdXflskp6KJ/UTEMC4s2m065gXS+CuWgqj5eyII5A/9pXXs?=
 =?us-ascii?Q?0E/Q+6yLJSS+qBMSlIYP+WrvY04nuTfOgzv2/+gN3Paaz3VNuX6CZLioC8UX?=
 =?us-ascii?Q?boOljlnwLMk9AyUi/nJQRoi12cQvJT5tvmr6Q39kfYVq9ARLiBDP75X0VFSI?=
 =?us-ascii?Q?urRCj8nIu1s72Chj2JX/KAy+Rp7GazxIx/5Zvgkjd14UlhrYDmBQOprsxZnz?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a5d2c-e35e-4325-ef88-08dcdddc7b87
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:37:01.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlRnnzhMtAkXZwUkFMTi/GJM3SExRl95pPzN0iyzOg+4omjCluXWOySKuVNGK3mxSG+PEC8su6TU0DSRLJ9CxFFfKzGhcGeXQOqHcDHdWnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9303

This updates all FW names by dropping the _v0 suffix.
Its been decided that all NXP BT/ WiFi FW names won't support _v0 suffix.
The suffix would be kept for next HW versions such as v1, v2 and so on,
which do not have backward compatible FW.

This change affects W8987, IW416 and IW615 chipsets, out of which new FW
files for W8987 and IW615 are yet to be released to broad market.

For IW416, old and new FW names are added to maintain backward
compatibility for existing customers.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7c2030cec10e..19ab468498ac 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -34,16 +34,17 @@
 /* NXP HW err codes */
 #define BTNXPUART_IR_HW_ERR		0xb0
 
-#define FIRMWARE_W8987		"uart8987_bt_v0.bin"
+#define FIRMWARE_W8987		"uart8987_bt.bin"
 #define FIRMWARE_W8987_OLD	"uartuart8987_bt.bin"
 #define FIRMWARE_W8997		"uart8997_bt_v4.bin"
 #define FIRMWARE_W8997_OLD	"uartuart8997_bt_v4.bin"
 #define FIRMWARE_W9098		"uart9098_bt_v1.bin"
 #define FIRMWARE_W9098_OLD	"uartuart9098_bt_v1.bin"
-#define FIRMWARE_IW416		"uartiw416_bt_v0.bin"
+#define FIRMWARE_IW416		"uartiw416_bt.bin"
+#define FIRMWARE_IW416_OLD	"uartiw416_bt_v0.bin"
 #define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
-#define FIRMWARE_IW615		"uartspi_iw610_v0.bin"
-#define FIRMWARE_SECURE_IW615	"uartspi_iw610_v0.bin.se"
+#define FIRMWARE_IW615		"uartspi_iw610.bin"
+#define FIRMWARE_SECURE_IW615	"uartspi_iw610.bin.se"
 #define FIRMWARE_IW624		"uartiw624_bt.bin"
 #define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
 #define FIRMWARE_AW693		"uartaw693_bt.bin"
@@ -971,6 +972,9 @@ static char *nxp_get_old_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 	case CHIP_ID_W9098:
 		fw_name_old = FIRMWARE_W9098_OLD;
 		break;
+	case CHIP_ID_IW416:
+		fw_name_old = FIRMWARE_IW416_OLD;
+		break;
 	}
 	return fw_name_old;
 }
-- 
2.25.1

