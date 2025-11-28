Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF1303A05;
	Fri, 28 Nov 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321363; cv=fail; b=nnD5Ue3kyqEBIJTfGG+nCmhvSaVphdkRriyC3fcXuq0M/V//8aScvzxmWZInwngIwSeDLnUieV3xp8PtlEZWkjSEInqRCooEm7JttwHU5WU4Z1/em2b9iX0driSwycW/UG0TpPzPefDgX2/67A2zDUuYcFidfgDxeWJ7+LkM2e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321363; c=relaxed/simple;
	bh=km4rF4bUyuzo0BOALXZNdiZPw+ibd8um95ktiwdxCBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CihifRICMThHMbZdaCz0ZBD64Yhx4p6gtIPsRTB/CrPWNh8gyQSmPkF+EEha2hvQH9U0XVntODMA1/wQA1cZfKSuqaweeTEB3H93JEgXOzRPdBqibWDhljDu21LC/IlSCbRqqG5C5UmQKnyQzfTaeJc+rKXFa1VyJHvKdn1WdNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOXJwAxM; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOXJwAxM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjSwdCQ8tUgTUl5RU4FQCxs9P4rmrAlvvPh6nDjwOXbsBHrVb84+X3+XQbJdOxfzZjHF3XRmeI5br++RjX8G5jgBZ4Th8h3OkBZf6yLexQaiDVtgJnvgv9Yl+fvCiBJx8cRxEfOpn5VWhn1kOFXs1VB7r/f5Vt3X8+E6E+uY1zXir9I8OUrP9lhisy/OzdFucHIA4Pmn5vPvv91g5pdGDyOkEpca6qory6LE1cb/ltZSe4VSDmxABMZEeojJiiEcawj2NZSPb/UoVyzKpt1EJGyi5p7veiSpw20asF+ahP7giDgMMKnI/qcyl8JUw69oh8BJUqfcDkKA8MT5go48aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=xRYMX9DoP1UCrkcPJ2nlVGgltZO4YZv5sffZRFmkPZtXfUY6Il7e0Xsb+wFz0QOv3s38tcuPmt3a1ci7rqht25IImGlOMdccwmkilZUESDmf7KBKorUi0xJPnb13sMl3Qj2dqO910iMuDMSK9c1KmC8unJwt2uu2fwJK6GYmDwKrS1ghIsKjfcZzNsLr3RIJMIza2CxuYYwhQBu8U3xsF4vU+tYxSpV9gAeA5jVOZqq25xy3tOUaOJu4bX/AYjmN0j67Wb/ZU1y1tlV1UcLTqXUDQdiwewze/NICkScAlNFfP+Nsm7gi9srZg/5NeOA8sSdT0wcd8gpfZzPrIR/doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=oOXJwAxMYsiiZIjUMJGSUB22yl8+UvJIofM69CAdp3VGE/8kE/X+0FcyQM+nts/Jmyp34GrfncuVs9rm7rwdLs+1nDalRrQgOi8U8dBqAxT4fN0k4bnlsjhWrVdXcTYVjj5V3tk2BoThROwaFiOmyT3T9W6WGk1rmw8OrZ8PYcUuptu9BkhbagaTv/GaefSvmPwuUAH0XoGF0biCGiAIWs+4vxf1UhWfR+GDsOQ3RS8iuVKDFUeNiDB6gepuquP+sxhiCnv/C/3Qx+ol37e1gU8PhNHeKU8MY6aHND4F5qsE8M273nPs3dd7dYW/4uf89W8bqUq2OEBgzKy8cmm7SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:16:00 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:16:00 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 11/11] Bluetooth: btnxpuart: Select crypto algorithms for secure interface
Date: Fri, 28 Nov 2025 14:44:43 +0530
Message-ID: <20251128091443.2797316-12-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef9499bf-7edc-4427-a3f9-08de2e5ebed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWtmfEk2yAL5HX9KTBHXU3JBFg3f9kQr1xgR8EICiuuto3L6B62sTUxxToeu?=
 =?us-ascii?Q?qXWkP4XKRhdrA5V5YAxsR1rVg6gp8A3QJCBnycGSvHzhD9Xcz6x0BX8Tmc+e?=
 =?us-ascii?Q?gIFMlWyvIetYlxewoe+Ztgvc7WF3heS2PUz3/LCOC8VSbt53daX8w2+hMsIy?=
 =?us-ascii?Q?otIm0N5Jc+YAfls0xw4Ch0b98acsLxm3zJvglzLv6LxZdFb6VPNAoLfF83ds?=
 =?us-ascii?Q?xG70QoMRkH7Cjta8LbxdQtlKnoG93WaK+cPPZZa6p0+3TMICRjFOT/b8XOmM?=
 =?us-ascii?Q?2vl7A01idwM5IYazSRZCL/NQaMFOoywPXJ1iniaJKvjgFtlcxGAcsVADvRxo?=
 =?us-ascii?Q?psR8Sh2VMz2sm8riTkjrNR/hKzv+LRuTsTulv5aHMOQLgJWBC3ZIqJjj79ny?=
 =?us-ascii?Q?3/Pilu2jEGra0YHClR9HtF11oXhAWUQa6kblsRAOIdp7Zwz++zOfLvNv99p1?=
 =?us-ascii?Q?69vhyqJE0N3blBDbuMDzknwhf7ulBReNm9yyXWAkVjNGPupU1c4QzbzGZVH7?=
 =?us-ascii?Q?LIvzUjvj14uwp4dDJW22EaeduXUe1sc3oOeX8ZWUo8fPq0ursNZZX/pM7HOd?=
 =?us-ascii?Q?1jemsZus5EIeOmhpznTw5yyb95Zu44rzGTQwXm2/DEbRbYY9ZD83WK5xkN36?=
 =?us-ascii?Q?xFUWFw7Igq+8pAyKFntVsi+/8fHGbpiliAT8XVrCYvtMq2Fs/mSnYB9EFwOR?=
 =?us-ascii?Q?h95Gux5DedGbzYtMoV2Qrr5A4p5GMsrADBvqJVZa52KFN7go5RZnV6CCILq4?=
 =?us-ascii?Q?uUAdiUetQivgvanLB7vdjPMvuES+RefPX4O0dLAvC590Su8xzvm/edp6V51H?=
 =?us-ascii?Q?wmbDdI5E9C8Q+2bnrWXgZKwtbEhYLGYqu/We2S74Pi+6HI1LY4p+UNUN7wSB?=
 =?us-ascii?Q?zTxgQCqD+9MLYQy3cayzY9nnbp9cA5Z1ooVa1BJGI79FIMeM6dh+mrbeob42?=
 =?us-ascii?Q?5R8PwjVo0kiFzR+Nedc0Oez0mh+j91Paw71fkAT/Q9V7rlmOZ3dobH/JdZBG?=
 =?us-ascii?Q?tbtOpUhGZ6wSHkzc3oOnf0ULQhF/agodZSmjyUZrFmT54qbHNhj9bhI+kW9U?=
 =?us-ascii?Q?NckRLt4M94L+AkZhclqe2lDngxqM4dDsNZW0QlnaN8UTcWzEvTDpBOysYI3n?=
 =?us-ascii?Q?Tr/65GqD+KD8zzOxE9eAKAynrzb5V91IsIoAnEKgv/ImQdyGP0I5gHgnZH5Z?=
 =?us-ascii?Q?p3WnFR6tbPwIVPmR3HfuuZRexNIB7QURiJ8wXn4Hw+P0UjUbCUOKr7fqapmQ?=
 =?us-ascii?Q?3rMlytvR6IQeqFupDq1aLLd3S9U28btYec1o4jpl9V2hbDkzlnq66uw12aYF?=
 =?us-ascii?Q?2Jplc2rj1oxwYPiN+0FuTrmeHmske9i9MHvxJ42KZSmZ/fhWGAt9URk1DaZj?=
 =?us-ascii?Q?D7lSzFP2ueRXE/1uTarnKvVB4KF6q/Mm67sdOz67GYWfGOBT65ceEtQuzLUp?=
 =?us-ascii?Q?2Z6CRxC7BUoWmTUy/9xAf/IwhScT8RrsLvYj7gyjpZsAlyq7RefscdCVFOvO?=
 =?us-ascii?Q?BO1AHLkL3AOaa3kbH2jMnGkK3pKH1ap7ycoO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OeGyefYHUMk21YiImpwOX3bBwaFRRoSr9PXuQV0C3W8uzhLJw4tOQETBIfRs?=
 =?us-ascii?Q?mPN9M7kXkmClwlMqIDXAC2OdRZpdCK9NVvrHR/av2JH6qwc4MiISUH8rBCQb?=
 =?us-ascii?Q?1EXgzVj2TLhuAmBd6AeojJZVxD7HbrMsDM1diWMN4b49jIeC7hX7OcbQtyr5?=
 =?us-ascii?Q?KQgt6yl71KP2yyJn7JDRLAJwJsfp1dEMs1lD17P3trD0yufmrWImiGQ2Lm18?=
 =?us-ascii?Q?7jX9mvr13+DpWlNCYnJCDoVawquvK+tFPxII/xmkoLgKqcq2rBkX8E411rFl?=
 =?us-ascii?Q?hwl3YDHguxLumsPi2eiwHCpV02ItZlIZWBOxY8gemQIYKZoveVXbcBGHK6gI?=
 =?us-ascii?Q?+xZmWFyFqxwWSfh963BygZ7rW8h5A4fNByCeiXFIVFv9+Voi4aBjS9VcEPKa?=
 =?us-ascii?Q?1czE2WMQccDQwZ3tVZJ29aLZnVHPZaeYtKgw6H07VUiBLjxH/13tRqes+Uhx?=
 =?us-ascii?Q?lpJSIS1UIF6CRhqTlh9To0YkaAHHtgdZsZw/VNRPQMt0zF1WNaFhElDXf9sl?=
 =?us-ascii?Q?BntM7LS8DMMYcbspM+JWViNcX/CHoMnFGGDx0dsFJy3HQt7x/9b82XWi4l0g?=
 =?us-ascii?Q?dSSUJ0wfkYpuqEbRbvj8JU9xyDWYubrs0sA6TAcw1LiZCvc+s/HD589dHPoZ?=
 =?us-ascii?Q?gVY4GNT7z3CmKLEJ7LxbWBD6Id6kKX+m66bhTtDDqQIBctlcHd3qrWxI4nWH?=
 =?us-ascii?Q?Iqcxbt9yhKEmy+QFQxkkrSjREIuT8lvgigClJwW27DQdA5XXDF/OSN0o5bt2?=
 =?us-ascii?Q?aoUQ7ybuiXtjFDNgGNnmbt6rsVDZ+thX4aTtyfebtl9mvihmiVkWNTsaK+Aj?=
 =?us-ascii?Q?N+06lvz1/bmwTt9cQIUcYmzi/NrsWgf2P828Ldi46r/Z2zjOvaDSvayOTfAP?=
 =?us-ascii?Q?MbITHu8OVeQPqtxD+l3P56iXw3dtLpPxhEXArRwcV/F+cEYqd2TCXjCTiHuU?=
 =?us-ascii?Q?gn6kUwP071BeBwYserYd3oOwfxV+D8wz8hLVH2U1oxk9RDUhhc1ownXUBcFD?=
 =?us-ascii?Q?LpOsDmXZ8LRPstd637tcVhonLfm2XTuh/vOXuDPjEDfiqCbUXKnLSLJCMRR2?=
 =?us-ascii?Q?xNWkDHXBJfwoyQa3KTyblj/kf5bTI8kCkmo2TLBlPjSge/nhUjzCW6uNIMpB?=
 =?us-ascii?Q?oc1LqGVS2oJQtZGJNZbgQtL30o+FAc91FA9QgKnSRM0cJDdUSDvE10WNUvFp?=
 =?us-ascii?Q?K+HaFs2SJAUiKJfpKx0WOVlKVwznPY+yC3ibqGlr2v2STMpWs2saAO1goKdw?=
 =?us-ascii?Q?uzlm9WWw9D1u5eBuniNwgI/kS6n9G3JW4fG0wfFpQwmrUF0CrdGWkMBNCAb7?=
 =?us-ascii?Q?i8exrDDwSntkRX+/AKXqK3axljgrpjB490ZSaquPgXaLfiAMGpcWG2feZjO0?=
 =?us-ascii?Q?1nS7Zhbjlhq/vEEkquSFI/gi3mtrhBtBMe/tLL3vQfoC3sQr47NVAjv+TcCQ?=
 =?us-ascii?Q?jQxZ7NR1HHdpS4bW4dqZ0p8zzzQlbcmvZ+jvUsI70E5ykqsfnu9EIDao4iFw?=
 =?us-ascii?Q?cNy2SeMUYkSQpma0BpXRsgydwOwDfr9r7cyvIEB8UuNsgf1/reDA/E3/9bWw?=
 =?us-ascii?Q?xxaaV9UCAPvdxNjhQVWPTqFeaLiU6mfj+WhBpexTJ+V5Mp9WnXY/lEFb5Nyo?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9499bf-7edc-4427-a3f9-08de2e5ebed7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:16:00.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNVcFE6brZqb2nNjzoEHZgCHQzUre6K1nOoFKcLaMkxz/TIo8vn6WcPRDLMBI4vFH90Pu7LOo2ezPAB2q13g7p1aKoKThstmdFyV7csHgx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This adds crypto dependencies (ECDSA, ECDH, AES-GCM, SHA256, HMAC)
needed for TLS-based secure host interface authentication and
encryption.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c5d45cf91f88..ccbd2e13977e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -493,6 +493,13 @@ config BT_NXPUART
 	select BT_HCIUART_H4
 	select CRC32
 	select CRC8
+	select CRYPTO
+	select CRYPTO_ECDSA
+	select CRYPTO_ECDH
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_SHA256
+	select CRYPTO_HMAC
 	help
 	  NXP is serial driver required for NXP Bluetooth
 	  devices with UART interface.
-- 
2.43.0

