Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE97170A3A;
	Thu, 26 Sep 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323629; cv=fail; b=QWjkNvEbdtdVim9w1aEp6yjimA35ISYek5hPsHJscuZWCT4j6UA2mO2payzeNqZX07hoo9i9Ynt66uWdiiLUsoOFQLN9zubhS3dcTK2U+9Xa4A5dBW4OJoAeyCfT2vm3rLA32riIBMVUD+kY88TOdkAiqBQ7IfWNGssWCGwuouQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323629; c=relaxed/simple;
	bh=0yRwUiQPyep2SSyGnOhngMifAmHmqAcp109vRpJOS2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssOP2VpcwJa20hCKSlgZ5sHMCfSTj7EWn/k0dABGPIrlLjGSqz9dY5Uws5EmeCBUNOW9/+pzq+bgYrlBBsWTgxRC7fTBgj9cKdin2e7H5nMc91/nw06ejsqEWlD+Dr4In73FiEZG7kVVdsnDfYOLNmfgS9Ij+6W3ygbflhVhcLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fc5q5YtK; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fc5q5YtK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJtlNwiICtcct74xgM3wmtzh6axthEricY7QUrhucvCrcvGM0kEkzRgDTGWawe0zXaqdGC6OqjEx+KEBFXkAX1haMeHRJd9t5IXWJaBpqDe5TwgfPFynK/AV9YPGNLCZt8hBNaRFdv4oleKHpzdIkBs6LQvHjsC0qBD7M+Bzs7MEmuOaeYIoTEew9IoabiSZh6+Zr+shTUVRQ1ZPr3bfJyyJaiprYXvky0xAtmbF6oTvEZMOAv67E4Bp/RZ85wIlioUdkbLW9qIItEOBR62nHb4o1UyoZgfs3iDy86+SAbZJac3d2jJifelIJWFRFlf5h3iGPCnzfLzoW0py08eIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fvBEHIGnHyxuoSzJ77vyossG+kCCO4KO1+nL+ZZQY0=;
 b=MGZZD+8/ic0yHw1eVpOe7QO5V1SzLbDbnWyLaZ9fdhQGulAPne4qyT8VtV6jmV2vkMeW8PIuXYxtVXy6gMZQkPhFMdE0fJb1LYpCnGxMY2r8qGPI0HrGw41U5vjPyIbyvsc6mb7AmA6UdhvnHjxa/IyKBO54lH1FMlZAEymtYL5GdqC7uX1W6lrtmDhC6MrNHqnS5Pem1BbWrhRivfvvhZvROKTNXeAWGVB8SyUWmdY3zNb95qgK/mM2mePTB/kKOUIbqTRjtEoMpLcK5MotztQZPqkuUJeLaZ0vGXHbbq3vHrk5VhTQxipsXETVMNt4Eh5GyeGAPlzRqktARZsAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fvBEHIGnHyxuoSzJ77vyossG+kCCO4KO1+nL+ZZQY0=;
 b=Fc5q5YtKh7wseVj13u0DNbhIeTusVaiZoEluh1KURPoDjsJbLNqiTJAccLAxMXpNoL8lovzwgi6v5oWt4rSbtZxQLLMBeCHbtnGZUXomIt+QIYV9v5sBDp/E9XBdurDuGiNbKYj3qg47T/ve+S+iBIh+I+9OUrgh58E9zMGYJm28+2hW5CxOqzebp0AX/9dqTwMRIpqOIpJYdZvROd+xT9GTyx/JZKuUfOkozGtv498FwUKibVyBYieQYucDKHerYd2hd/xC3qb/huGvjOmumekTKzpSY5+Ays136sZtQP5OXN5FDS0pWJ35Gmq5kWvw1F9wF8DXjxR0QFOWneQRcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by VE1PR04MB7392.eurprd04.prod.outlook.com (2603:10a6:800:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 26 Sep
 2024 04:07:00 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 04:07:00 +0000
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
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Rename IW615 to IW610
Date: Thu, 26 Sep 2024 09:37:57 +0530
Message-Id: <20240926040757.375999-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926040757.375999-1-neeraj.sanjaykale@nxp.com>
References: <20240926040757.375999-1-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8764ceb1-d9d4-4b58-9363-08dcdde0ab6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yM2ViqJjiXap6/aa+VjYZTRfj/lt/am5U8JqcERcELRYGW1VIB52yYJwpa6x?=
 =?us-ascii?Q?vNL8lwEYwPpo3wbcbDN8gbXaKcfVobR7YlusYS+st48PnF4ZwaxMUjZ+Stgs?=
 =?us-ascii?Q?D0FE6W97OgyhxRiDe1KSMGIYMJ4uEmZ53INyJK/UnB+sR/eXpdwUQRx0EPjY?=
 =?us-ascii?Q?EIIqmGq8XWNPk3gQQMiCFfN180Sbt8EwIRXlkwbgzOFZtxnNWyCCba6Hajvq?=
 =?us-ascii?Q?evetkiL1+1LZaAdQwuXFl4FIMyLRPNc4EPLbrypjpUwdrkBV73ia6A+QOrC+?=
 =?us-ascii?Q?YM09wetcfON2G2GXzlBdOEvfZIKJ/SBnyjowVoX4pOXJe2EKCrg2Vm+XjeTT?=
 =?us-ascii?Q?/dpYqtYEzwgAQAVyeQI6g9CNwQEvFyb7XK80/gsKRS/IJN++XciUmDfquE+5?=
 =?us-ascii?Q?quPF09ib7cXsQRDBUOAKCw7jGsF2jw8SmW/piMUDuI4Z1UEaJRghMW3ehpLm?=
 =?us-ascii?Q?J7YzMzrV2t5evQL5kqgwavfFtbdyIxoBfQKUQtRW89tBJEJ4Ft+Z/k7q0ydn?=
 =?us-ascii?Q?oSuMG0PSLBuP6SW50o6vA+AhB7zaW7Y8CcoyaP/F8Pc1ehK+jOYep1wf28YM?=
 =?us-ascii?Q?mW7b/7SnZuTl5PX5lVJdLY6rIEcTgESPlsyjO/0e9chBwwGVgTA3cteVz2mc?=
 =?us-ascii?Q?5uywWKGsINFEqxqIusuGjEIq4CsKM7Y6LWRFOfc7OVeD4T0nOLigBGtdyDpy?=
 =?us-ascii?Q?0WLtTQmzE5VJiBfzKWDW2wuDLxoNavH56ll6GQbMk+1A/nd1Vaze3EK4w3Fe?=
 =?us-ascii?Q?YUl0IdE0MAVDrxuAr06p1J9RTk95SxbiSRmZDs76JwgpJvW9D1pFWc9r96yy?=
 =?us-ascii?Q?n51lIqI7OSSlFcyHq1K0JNEUX9TsahMc0oTclz1M0VCiD+96ANYxy0xZ/uTd?=
 =?us-ascii?Q?OBZsIlX1Do+gElVK+iXGtgvjXy8YaQen94I7eS3xDMn4DZin/PT5ss0/yduQ?=
 =?us-ascii?Q?64sjHeAl8pFtrHwnE1E1mVUWSR2FsEciNH4Txh4FknyqofDnWeEOxBbp+Z6i?=
 =?us-ascii?Q?a2f/wU4/EhpDXD2B3E2UIZZftus4QD9u3uRKm30aUJcdL8KNKjKdZRUG11lc?=
 =?us-ascii?Q?+xOCqxrr5WDp4jc/F6NuvR1dRqpXR1UjxKoyn9BaVhTNgREkNJb1WMYgxGje?=
 =?us-ascii?Q?ECWzDfREgcdha53nXxZH6GlW9jW3i2gquJSv0VuWTdnAzh3EFt3cMG4CFdmH?=
 =?us-ascii?Q?3UN+WagdnpXXReGa4eY2Or/dn77+s22kcPfqr4KUqeGWEH4l+dXmfpB0Lbo2?=
 =?us-ascii?Q?pSs4pKAy0WpTwrkNSQvIc7QuOh4rpws5rO9LJFYPMbYq+H5eKy2+e2EBGoWK?=
 =?us-ascii?Q?20G5ggPGQgnUbe926FFfo1t25U2Tv5gRemN7Ovhv4EXgX9gCINo6A1H1SK4z?=
 =?us-ascii?Q?wsEwm8sgVIOVUMjp4Ecn0qNcZRoMJj6NYo7sk2By4FmtSso3Nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdZzLB0rrEKBt2ubnRrezbq8eDx8LYnuUDjHM90qhPBa8it0qpz5BZ1RwYEI?=
 =?us-ascii?Q?ULYSvf5qAUBD4yMgBnz2+rqoWWSECJdiwZoXEWT7pM68+pgW01iKQ67WqI8B?=
 =?us-ascii?Q?luAaCGjGP5lkJYlHNuC6+DCAOTHqIE6KdXLPUPlNUyiFNI+FoFgZ5wYBHx/T?=
 =?us-ascii?Q?dllzDwKRRGprXlboR+b9AcCdr5Gkd22brfS+2cNFZcl+L6mSJW8q862N1Az3?=
 =?us-ascii?Q?zGOakXnBXb7pOQkemom+AUJ8vyLZMIFIP/pRNEWjCjmb14k6yUuIliaLFNqe?=
 =?us-ascii?Q?NjPpJY1BAtLET8S5Bm2ThnGIraFwN3+MepM9zuCA60deKY+p3CYmJA2lWvAq?=
 =?us-ascii?Q?d4Gy6aa3jCLdI+UuV1hFeCghyOIl+TcW3u54xqowGaKMXVt34mDM4jabe6aH?=
 =?us-ascii?Q?xTutbYDMFtXcxTzOAdSWZ4qyW6gQF1Pe9vs1ArXtLgJzEqu98T8iDWlYi75Y?=
 =?us-ascii?Q?DxtOTpYNY+q9iyRfms03UPy8uoAuwAkVfEBeebbX5kw69T4kfwGWUC7EPR5t?=
 =?us-ascii?Q?QgBKpdAfzGv4qpSp5JEgXazH4nVLCPANXhP9RlWfe48uOcGMAKQd0Weplr2x?=
 =?us-ascii?Q?5/3VeDR7L/DqYTVnT8yoKv6JzZhEaN0RynAuwA00wwkGTKEex/aP9Vk1NJvU?=
 =?us-ascii?Q?NjM0Ilq4KVB5b4LKKBBwrsPKcxGx+qUcJU5p9kEVSuewRk1oUhhNYgpdWI0k?=
 =?us-ascii?Q?rffSr4XG8Xt9OUaM2afuSvFgCmEkyZRUuowJUyKx5I7d92RlV7yi2L5BPG2n?=
 =?us-ascii?Q?eOmGO3IY3NlgSF8bs8H7jhEa/146InZC5p9/SPxW5l9AS2OWofzK+FOF2dp1?=
 =?us-ascii?Q?hwsqgrNMV3ba7ld78xJly/1Tp+rsrabiLQROn/4RnDWaM2BppTlaBPH+F/Li?=
 =?us-ascii?Q?NSrq6qHwhj3o0nnbOF9+drrkNP/iGjdF5eUWQWw2pvryx6JLiWVCYwiXHBXL?=
 =?us-ascii?Q?UYgDjJVEIztYzLvtyunRRZrRwtzmmXC14BhwmdAeoQ+KSRrosfh2eLrXgM2Z?=
 =?us-ascii?Q?jNBpHP1Kj4I5k/pyDBjhU8P0cdWLey3CoT8YDLWngBNxN23j3u8i7OWFPdvi?=
 =?us-ascii?Q?f0klb3RU+Ezoc1e9+ga3te3jIUx50b9w+/ME/VLfGv67KT9jt7/XCKVBufM/?=
 =?us-ascii?Q?3R4wWq4T5amBBkNvCl2LPQJLxPp+jGr/7M5Fdhy9sc5z+muadZthy05XLuvD?=
 =?us-ascii?Q?gsAdAuSIOFbZZUnQd6zNKr5aXmDqdGSkf5cFeyE4njS1gE8LE/r6vCPO/feM?=
 =?us-ascii?Q?c1jg7DTZBEebASPvzVeJXHcK92dP1XHDM+8ewOLJvmAkkeHwECQ5+fqO7oB9?=
 =?us-ascii?Q?pKA4IIVJ87d4pXqSjXBlOyWXd7ic00/2nX78yrR+VMmLwwbx4aO+oDM58BFX?=
 =?us-ascii?Q?O/NVetfR81Tc+SXRZ2qFq7nqwyt9s3t5yq+QS4q3JlisLc416yzprG/gsOTl?=
 =?us-ascii?Q?MOukii5o2jOkTZ4PKeH8nL+oRgCf1V0RtV2ltgNo+BXL7TKICA2TPhqrE9yO?=
 =?us-ascii?Q?3Yja+bVXJDIjio+K7sUV9oInBqdKjL+XFdpET5dapBjjNU8S9NIHD4me7WSX?=
 =?us-ascii?Q?4tRqgYRNaLxGpvLGrkY0YFIrZYiodbGrwg3YSFuOVoFtcNIUqAaD0X/6YCPo?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8764ceb1-d9d4-4b58-9363-08dcdde0ab6a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:06:59.9570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpsczczEbIO8gWyZTFlHhtCfr+1lrRjIEeE8kRFp25hKDnSZIAkwfG2roMspJAowN96x+VF5qFmUgfseDHdI6OdyqyJoHunVSoTZkphq0xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7392

This changes the chip name of IW615 to IW610.

IW610 (formerly called IW615) is yet to be released to broad market,
hence there is no issue of backward compatibility.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 19ab468498ac..2b8a07c745c9 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -43,8 +43,8 @@
 #define FIRMWARE_IW416		"uartiw416_bt.bin"
 #define FIRMWARE_IW416_OLD	"uartiw416_bt_v0.bin"
 #define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
-#define FIRMWARE_IW615		"uartspi_iw610.bin"
-#define FIRMWARE_SECURE_IW615	"uartspi_iw610.bin.se"
+#define FIRMWARE_IW610		"uartspi_iw610.bin"
+#define FIRMWARE_SECURE_IW610	"uartspi_iw610.bin.se"
 #define FIRMWARE_IW624		"uartiw624_bt.bin"
 #define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
 #define FIRMWARE_AW693		"uartaw693_bt.bin"
@@ -60,8 +60,8 @@
 #define CHIP_ID_IW624c		0x8001
 #define CHIP_ID_AW693a0		0x8200
 #define CHIP_ID_AW693a1		0x8201
-#define CHIP_ID_IW615a0		0x8800
-#define CHIP_ID_IW615a1		0x8801
+#define CHIP_ID_IW610a0		0x8800
+#define CHIP_ID_IW610a1		0x8801
 
 #define FW_SECURE_MASK		0xc0
 #define FW_OPEN			0x00
@@ -947,12 +947,12 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 		else
 			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
 		break;
-	case CHIP_ID_IW615a0:
-	case CHIP_ID_IW615a1:
+	case CHIP_ID_IW610a0:
+	case CHIP_ID_IW610a1:
 		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
-			fw_name = FIRMWARE_IW615;
+			fw_name = FIRMWARE_IW610;
 		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
-			fw_name = FIRMWARE_SECURE_IW615;
+			fw_name = FIRMWARE_SECURE_IW610;
 		else
 			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
 		break;
-- 
2.25.1

