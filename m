Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C841D5ADE;
	Thu, 26 Sep 2024 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323627; cv=fail; b=sXYJ+rtw5gXv/uLizXKebzGr0K0DeFnGoAJoNCrJGAi/L0L1NJlQpOvsPZXUYZvf9N90iISl+ZplevB/iJSolN7QvUuce1j7508asyLAJUw2sk246tOG+wwWr6Cj6v8Hk7nKl2Dmbqni45ip6ZGAPC4e/ayVHAOg4gMzXfw7g48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323627; c=relaxed/simple;
	bh=4Mlgv93H5SUJxlojkN4Ml/YX+WUpEVq/Wmn8toGRO7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UVE6fQfOci5FgqfheBfRTTy66R8SUYtwqcWLYClSSQ8SlSW//FdxC5db5Sjg4PyIbJ4dB3IK+RRT8P14drgYoIWN/JPfL4+lZPaGcSMxWnkXF0VFuPj5nJvNXyqHE2Cp4CoIRrybFxQkOTERjlho6G+BrppbPLPr7ysIT7hULuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ODlqdAon; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ODlqdAon"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkX6mulEHovbQ25Ezwreid9FbWCELkjFfU/N0Nv+VJQjZG/1kQFtN97IWGFzrXev80f31atDkAybkidLWU1mgXPDS1N09pfmLsnuYBv/3Q5kojy+AqhRlXHzAqkt2iarzy+W5slnUMyEuWS+rymTNfIQw+ynabFAF5HqhCfWQ4pkxAG53X1oA7+sJSmhc3XdPzrL4hY8LOl0OMlpq59kq3koOq83ZsPqZ9H8ulDBSDZ4fSNK5FA1Be0u5R3Ws7E5dbnQxK7phx/pmANskGHDqH2Gr+su8jQSzsB4AzZ5g3ChONNaHfY/ghHq+LP4Cz1iKdzQvPAwasr7JKGsBTEdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju1WeKtg5l7okRqOJlSeh7BVQkCDysc9jzWbSTQE9sA=;
 b=ji8YHqy0ZoSrbbmnGlniS5eSNlZzjSeLYV+vrooAwOuZau/SEcH4dfEM8vIBgKbGF57bE9STGhABM25qR4pqHBtDJAKctIJzs3K6rQwtdiJXsh455L51qLUZbBdKxKAlG2hF4UYmi4XN3U4+7+L7UKLfc5I2RwnNWfx3pQXW6d8jZi70PZggSmsiV2TGQ7yhtvP0aGAfPN1M5fV5Pxvi6G9pyZC6ToET8aLcnJckWHj1J/22gZ9omuxczdUpdaD8M2I/zfvEKtMY5NbRUwxHcm7KXmp4u00MmWaON0hPv9TcXvy1feAelTecscAnuyv3WhExMiF5cEq9eJL1xWQ9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju1WeKtg5l7okRqOJlSeh7BVQkCDysc9jzWbSTQE9sA=;
 b=ODlqdAoni+948FhMQVObtK1aEsSaAsryk446UAbw3fED4n8RciXs51jPKacjq7JvbPsmYEq+Qgvy9TMwpmzxtQqbDe5fu0xZDJWR0AbqV0egtR8PMtZe8t7oNUAEYX3HUIufHf/iVxGD2lrd7/ncKnYNiu1Ct+cC32NaNPh8KbhDjo3TXXLgOwbzt0MaNhZwyflE6H/d0fvHs5VCTKOGTcwHKIo5sBER8BB8kuFIaX76VxQHdLgNhuNdDGY4LE/ztCB9fYqoxlSELXhdAJcCfIzTDTwdtMVyQ7qbt90rMov/EN3dSx/d1WShFNhh0NOipEpMh4LRVSzL44heh3uZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 26 Sep
 2024 04:06:56 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 04:06:56 +0000
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
Subject: [PATCH v2 1/2] Bluetooth: btnxpuart: Drop _v0 suffix from FW names
Date: Thu, 26 Sep 2024 09:37:56 +0530
Message-Id: <20240926040757.375999-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|VE1PR04MB7392:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd2370b-9199-43e9-3014-08dcdde0a962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lc2F/7iL+S39KTK8Y3KW7TYfT72Cb76yawP1VVPvXr4NcgvnkTvOhU1JCad9?=
 =?us-ascii?Q?h20PZD0keonTDuRGzWMbbLCSKJlang/59rC85MDoaAfiSnVRj01C9qUnDcB1?=
 =?us-ascii?Q?wR/2y7wSydhvme6SD1YixDe+6OYWaR7FHc0FDSbFeFEVen1DXLvPXj4oXgPf?=
 =?us-ascii?Q?sEAN9vfjqCS7I/kAuLwHqEGHguwMWi1nBF+kdjf1GOaOwHI8TOIrtAWC18tF?=
 =?us-ascii?Q?u4Al3jSak8zbt135+uNMtTPzpAnAIfZQ1mzmr7vuRH1WmMxWBu/18KPE2Z2a?=
 =?us-ascii?Q?AG2ixFbrDYtUfEsJCeQp0hqMN3dgNa2MIsbgo+BWNW/Piez9Ca7s2a62sS9w?=
 =?us-ascii?Q?R71eKggZM0fJte3T8dPev/e9iBveWrebtdzKmUv2ezyZXssjrESWi+0q/AqY?=
 =?us-ascii?Q?19Z7r8kTyaNjqlEJAgRE860sMvcs4a71ZvrFmA2kEqzqNvxPXRduKpMeZU7T?=
 =?us-ascii?Q?H4LGLk9sJ0CnH1HlJfkcb4voivumHETTek7VuU4T3doSaMTk5MftzIBynqt4?=
 =?us-ascii?Q?lr5GHx+RaMv1tKr45btIeisFNocTjpJDuiGiiWmSz1x42YKHyTh99QGdWwD9?=
 =?us-ascii?Q?UO+wP6OEH5saqMPiaxH/WwMbmcga1Ygv2Nkclhw1U/alG6XmOk+NybG5m7zh?=
 =?us-ascii?Q?hRVmrAUBBcM1bb1ZkBvsT+UXB96gYP8oF5cFFOdDV77Kk62wyadbR6+HcR0K?=
 =?us-ascii?Q?nTj0wNIbEkh1rDuxT3bSVQiSpLg4OOahlTp8XO1+DRWUMdC/lf2Fj1UMsF6c?=
 =?us-ascii?Q?E0EzYC8g8K6ZH07lGa4s37i95ucjkSsGpaC7GfEZaVZAJxcSI0RlB6aucYTD?=
 =?us-ascii?Q?DJLcaP6TS8TMRtcTJB/Fdu68XBV9ffHdQuiIuZl4ip9QYEN8vsmLhtyZlwvM?=
 =?us-ascii?Q?LcsJuvewssQnX4HphHJp5L2ff/9ObUfVaOvzGlJL12QC0npJpqc070TVqOhi?=
 =?us-ascii?Q?OmWB8QjdaNfm2RB6LnCZvRfyHehbxucy1fJJola7cADdT3wuEJX7Xvru9+Va?=
 =?us-ascii?Q?/jMJU/BnrFkIWKHULYLePOgN7YawnGREjSYPK992hCIYdcl9lFO0H7CWn4xL?=
 =?us-ascii?Q?axxnHJbuhee/V7/UuoJCoiZpMRFFRN3xvwx9PHinSsipkeMABxZkRS7jbeGt?=
 =?us-ascii?Q?kxPF7yZrWsZnniL+ce1TSWGhE/nbekjuv/1+AAKZ6syOtnkAJqPkjVB4eiAu?=
 =?us-ascii?Q?HQWS4xaR2IwOCTXdsP+hsmj9mEEzOZlFKHlose0sqdS0UZbsmCwbgwO2EUeq?=
 =?us-ascii?Q?nRKXs4+LICNTdFbvAjajGsUee2CMrMQWCswzQaS/ll6n0kkSd7qk4e/WhTl7?=
 =?us-ascii?Q?K2B0r1IRUKSKg78544IQ/2roM+9aHK/hgSUbvE+pWpHmk2FiGb1j3ZLVfF6L?=
 =?us-ascii?Q?0j89EoW/4AsghksqRqxoaY+mJ3YCt6jH2WVyZIeq/Brqd7hZ+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lsUZT2AMbdgXCzn573kxlqinoeZP/lOtstEmVJ8H6Wop71QXmIg+oFBdsOTr?=
 =?us-ascii?Q?wnQ6A0YMHyjvGC6JKegXfxjc97zCAV2cxhh/eoVGIDmHe5oE9zrOktWO1cpB?=
 =?us-ascii?Q?8Q6+WmHOnXYmwYp59+Px0eT1M7sR0zmvrHgEmC4pEJeii9Hzrc3vcCTHuiUg?=
 =?us-ascii?Q?C1erOu4CIA8yA8VURwBNxOJ6bVU439qVTKFzuAeddjUBskzrrbHe+lYIaaLg?=
 =?us-ascii?Q?ctvBtLt9kKdDLtGjaQlnOmqozz5X7q6+GXpOV1fqa+r7iyXaB9ESCrItjl1v?=
 =?us-ascii?Q?9TvApn5si3/MV3lzAqMBtmBhYKl6pyR9QOMLOgvY8LcIQBaqkvf/s1+NlC9W?=
 =?us-ascii?Q?aaUjQEFGc01TN1LfL6Oj/NJh/4XKjE7G7BgBMO+TP83V0CT36yC7NpGnCYXV?=
 =?us-ascii?Q?6+STxjcVZp7RoB/etYdyDJQ0zwnCc5INYy4/ryoLT/62beYZeCXf156eYeFp?=
 =?us-ascii?Q?nInCzAzzTdS/qkTuCvgjA3Fm1ByP6Kbud9NC17+ovYiWBt3RJhnbkU8vaoE2?=
 =?us-ascii?Q?Cu/IkiAnOyypINl8XyPRN4BnIBmUNLRYIPh3eXAVJKKV6o5PsyLESKDURg1i?=
 =?us-ascii?Q?3PbQnOQsABInsTq+6t9BBVh1ENKLqZ0pCriNqFSaZb1+sYHBoAGLjBoBQUaX?=
 =?us-ascii?Q?dcyPBaPL2PgbJRpCShAH5w1C6TCgkGn2fJDH3W0c95ztSVfrpoNFfgpT+pe0?=
 =?us-ascii?Q?ua1w0JYUmpEISz1rcXCZEPQ+jkd55zwiSeHGvbzjSHla192xIULDcmu0C0/Q?=
 =?us-ascii?Q?ZNd//oSMTZFRT3atbym7QKtyEiuR/YcEeTI4x9EPKE0iTWnbV0n/+4dsgfg8?=
 =?us-ascii?Q?Ka3J8Mt3Un/Ay1O8Rqf9A5o3+cNZOqF/oU4dE2Y30ZebGbjZIc/X4p4pXloK?=
 =?us-ascii?Q?HgzxjtQ0DY0eZLQpWaX5B16goNXqhfQx3EpPjwp7yYTyzunace5bIRtWNGAc?=
 =?us-ascii?Q?Kj2RxXjG0jCXTm90AnYAOenngswg+CgL+SSCWZketSvYp566UI4PX1qRp5zD?=
 =?us-ascii?Q?1r0Uo8yTs5/Fwpv6X9iBWdmOVJNkbkedPxqAsPpTAot8y/PUt4SVNU9h3NCK?=
 =?us-ascii?Q?L5KkdAXWnZadLPPaDTkWD929IiRlyVcfSsak6yg9KOq+rRJbeE5/zLCDUM3x?=
 =?us-ascii?Q?3AaOKTFnALxH9HUAOcIEpNvHPTXQz3+yuZNU5MVGGCoTVOqLcywtRz53zrBl?=
 =?us-ascii?Q?7LKwWMs6bfG3w5HuAW6SwD+qUkVBcnyc00sc+FOiGh3I5+B1OMNQXVgTBkuE?=
 =?us-ascii?Q?WLRhLLXSMN9MX+OX5mTH8Qoss4QWJ4KFtNTB9mUMianIEdh2N3wR9u+5+5Yf?=
 =?us-ascii?Q?fw2YZ94j+9169jOozfplAdE+G6FfXjGMq2I1+hAV4ptaZyjTBpP5dvzH2/Ea?=
 =?us-ascii?Q?/f6tIyfawBiJ5CwKU3Wp5qL6Vd/jsmL5N/azsmo21DKWBYw+vauoaW0vtmhu?=
 =?us-ascii?Q?VgTd1ecCtoM2rZl5S/SAL9CFznB8Yeq5tu5Z+1NN4ZyhSUtdxAmJ4VJRCxWG?=
 =?us-ascii?Q?G1z0z8vNXv8EAneaNoEyAhII/YA3PIwDVqIwuXAFJUa1j2NmAdnzvXK1LzDd?=
 =?us-ascii?Q?NDhyGK2dOOoP0LfaEIodA7a2VtdfiTbq9btdARAYCXg+RjVupRuTXF20fqG7?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd2370b-9199-43e9-3014-08dcdde0a962
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:06:56.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXpdTLkjJHslj3rlxppyFqH/VEEt7+r73HbjQjy2GHrh2MgtMAQNLmcyRpIZ7fB6yTEntfPB2KYVSHkisc0jhCcPkOxVLr+essS1JiaooG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392

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
v2: Add a change for renaming IW615 to IW610 as a patch series.
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

