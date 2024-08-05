Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AA156F37
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859486; cv=fail; b=jVL+llIwInbC9mNdcB4vX4hxLbKvIcFCUGKpZBQOgeks+SO97DExaghgBd7r+Y0nWgJUOnXgnBqwqLxf8N1VM95VehBAjppfug24KqAvdauQrLgJeuShdp5HNsPNwX7bO1JyGi/o6SetZe+zElSm21HilQj57vabablwyXXVATY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859486; c=relaxed/simple;
	bh=TnAeWgDBmNzggLQvmiET41tVW25Dfronvkn2/sdGRog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPX3W6pugrtdJyvjYctcURagVAbUbweuTsHZLPlEZQzQvZD4+gxhOlwI+LKrTd/zHNCICII8Zmh78TRtEaODluUb45nWwfumZprLZEbLexszhjW5c0HZZ7vuIdQ1M25N1rnjAcC8JQBLdqdi1F8REwSrPb8HtQNp/zfuUTqPmsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WBwWBaHp; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WBwWBaHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIyW43NIfJSKrtQNNo3y1jGzpt27IqXYWmykS6EHca3NM9qBg+MWO7b9lvAoh3HSSA0Ud33TAdE1vGhmDCA3eeTZH8uOGXLJUIzLeRTkGF1P3HtKddzrlamVR+OcybXxhZPwS854uV8QqsoOSNqvlZGqq9vhsCkNXIHJMTRws0oqROoLyjwOHJ6U/71nh2W0voWm4Zge9I44etApqvhSS84HIyfCG+68BJe63Jc0E05Gbngq0O9Anaenxo9hC2u7dmPu6cQqLAMoeyCAX2AzXnch0wtTeamPd4FTeMxm+qhr0DEzStL++4njnmZwmlPHhArtyGf14vS/w6eFNlCXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPxi3BWbCSoTNTrb5HY2wFmx/1sJ2a1EVXyQS2VPzoE=;
 b=KOMYPC1FP3oKN7RrrMmPBE2S7lS7wISKRyrDxuD0/SJMS0TTnFEoeXBhEbSzB7WvzkqapQ91vUfv1MtCVyXj2/mlOFx7qelaSgW0GRNTZk7yyEP4Nw7b+no2ZoGgAMbtWtTgj2SETwzFK0Z1PO2C5UrB9ypKufvvJKnmR5JgYw22Y1xP4CSYRt+IVyyCqFvZtdSKZjI6q/JGlI6EWOvp1f4ml2xTg8RcAOs1P+1F6TZjwjIMmARIk4DSj4kyjlVrz0fTlr5EC4jvAWv48hnotMxZv53mPB4+oM6sNh49u3aCuK3DPx4dHFgPJuOh0taS+KjdfPmU1nh1VclqgCe9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPxi3BWbCSoTNTrb5HY2wFmx/1sJ2a1EVXyQS2VPzoE=;
 b=WBwWBaHpypUOdHjpR3fySdE/Jr7AclO6jhIjYww16eiMMjVte6TStQ+y0YABhTKfBtSFckFIlPnIhzUl+gHjEFLk4UPdtY7zyGqhAKYzimKj3QJrHYCGO2ndWa2brQOcuCwRNpjHSexlgpKIPnDik8asc2jKr/4LCOKNyulriGpgZ9+LUYY3UF5CNyoR8GwMqsKHGLtCsRleVIgqQyrB6+87r6UYQ1tMxxGqj9b5hwLp9JJ8kNYIsQ0TbLMgrou2VqhYaZqeS/ccFGhfKcA40MagoWn1pUQBKcp8BErltOk2uFegMpIYFjqj+OyauYTYEX9u46GpMl3OR6SzCVOnow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/7] device: Add support to iterate through service data
Date: Mon,  5 Aug 2024 15:04:24 +0300
Message-Id: <20240805120429.67606-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c18427-a4d7-45a4-9447-08dcb546c936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MKF1y5bx3WayHwdhdpKseHO9CvNonge7Nl0i6y7ryhmbtPpqtJboxc7R/jXg?=
 =?us-ascii?Q?qSXQNOdY9/XeQ49xxtFXxjtpIOJbo/bnCphsjKg8rDiShY+Dr9K09wFnliFc?=
 =?us-ascii?Q?tU2vtPMsdo61XCGQbU2Pa2Pd6NpAnWE0MjRBFR1Hwxk+LjKK5VGTIe9ySdG9?=
 =?us-ascii?Q?ZGgwZOd8eq+2wRaoBiZamwYXzs8B9AzrrvQ0i+c/9mWhIo1LyQXl8zAi73sg?=
 =?us-ascii?Q?xBMXnWvlY8qTyD8bt1O2nohWAqw6AZwg9Hq5/cFBP9iBF8js2syU5KQjBhGb?=
 =?us-ascii?Q?wnOM3qUR57C/JmTPSx1LDc5ylTa77fFkRJHk+3a84e/o1pYiFDKqhH5oRns9?=
 =?us-ascii?Q?+Em+E/SorKMhzwiFAN/FkXPLPRWpIxjH7RMsEbqD+W5J80m8aII8VpHKhxoW?=
 =?us-ascii?Q?rWhJOUbsJYhbMWeAd2gadP5bzEhIGA4y1BxjOH89RZJNIgTlw5Uwv61EE6Xd?=
 =?us-ascii?Q?Grb7c+EGQ9rn/5jPEojoJM1ys7LADP7DQ/aOmtehrMGa7wPBBeBJyh3dnZ/g?=
 =?us-ascii?Q?VHXL1O53NR2cxe1vL0/54JUYNq953gNG/HpWsXZEyVuHZrrv9vozixay5ryU?=
 =?us-ascii?Q?vIKJdswh/GjBxLGoq7yKoFZcTsVnbYsUW+lmFpFWLCI8lsjDQ04PWR11M/py?=
 =?us-ascii?Q?fB1fy5zBMxIS5+HpSS8FsUvhtdDxUFXV28+2t4TyiBbyV3bqcmSLQ3zY4pQS?=
 =?us-ascii?Q?DCkSpyO8LJfcS/9+NbR9pAjsFQrG1XRUlRgjkGkoLsHj/5mtWuLXX4UG2wiM?=
 =?us-ascii?Q?wdlT/n5MtUofvsS5P1hi0qI/OBMTx2GByz8SSAWqtp3FLbecYpybyLjcZrer?=
 =?us-ascii?Q?yGUGZwIsUQLi0bglWBbkXJ8SBBiBxaayizm42BR8YIaW5x5oaapticbkKb1n?=
 =?us-ascii?Q?8AEedv30C+ILTgg0TutGy7gOW1uLX2oX+LHSvvxWLvY+qzqXH6Daw8lNfr/U?=
 =?us-ascii?Q?Kfaj+fcmr1GmGqtd+GnUk3TL1eZ/kzz9sDPZ+0u7LOz3ENYFYfHA13UTFmyZ?=
 =?us-ascii?Q?+L7m/hHV74bOgEbKphzAbhjYeJ9kcwua08gX7zCODbxCypHS3oR3+JILioh0?=
 =?us-ascii?Q?NS/JKTUw9C9a3lkPKuzMRIJAfLt75OiGlRmp8UEh5NDKhoxrJAzf6IC+Ff0V?=
 =?us-ascii?Q?iT5REmI6f1pNW2IM2O/IbW+aQYjf9OIAQe5nlCpjPqBnesFQkFW8EsbcQQAd?=
 =?us-ascii?Q?fC5uGvWJ8PURdpZSIHN/HX0OurYHhiOmn/K0eBFTpLEL+abeaGA4qdwzpFwI?=
 =?us-ascii?Q?f/0z6mqKsbPtGaZaWaIvaOcQm6hyec1pZB9ZikhSsBMgeUjdu/xT1HvziiGU?=
 =?us-ascii?Q?Keek7AZuCeSlBIAUM7aE8R5EKBW9x4URRI9+laV/13e4Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUrqQharIPZJq/rzuO4rMxIRdXTsifHqQz9K9SjuF8bJ+rUnVt4Zsa+SDtZj?=
 =?us-ascii?Q?2PwKhztznX7dYtmP/3ubpXjQy7VIgTlJWBI7De4hP9phExF10CglY9br3YOo?=
 =?us-ascii?Q?BVofLvFkrRcrfNCAUmlNJZ+lQtf+66RRNbMonoqxQ4WF1/Jfu7n3pvvk/8Uo?=
 =?us-ascii?Q?9BgM3AIyI+4E+OYOxtrcZ3rZg9ZWNl1SrK4g/ouu1oYWcAylVxzMyJ9Quhbw?=
 =?us-ascii?Q?2nTPgH6S+OreyTuXEZluJXhuBqQpFIaTmB9XXTMcxVn2viritfOqii2UmuOQ?=
 =?us-ascii?Q?wsFFlGOOdBRmanezYHS06SEY2XSdvlDKCmjyNHXizT15Y9kA28WtLjHrIAm+?=
 =?us-ascii?Q?y56iKQBNBhI3PGxYTSIJcAxKVlrMRqQ//NNNRX5nnhYJU7bt0ixwnXlDT/Sh?=
 =?us-ascii?Q?wGueYaJY7uuOSFRcYr6dHV/Z7LRLaIzOMJUsySxtIJ+hxZpJTk20+t7xBeA4?=
 =?us-ascii?Q?zfG311l+ldfB48bSDjieIaACj5B8bHDM5rX7cf7zh+g9J8YDE2JTNXV13KYt?=
 =?us-ascii?Q?s5tSvemAQ7tDO3CVKBKOXG5+9O106nbAPMja/4yrzBfaOA/KU67T/gAfst2K?=
 =?us-ascii?Q?DvODPeGjNBjc0YR/YhYOcA6/PI9r4ckkvACcseAVtnfEx4Aur9cQUlLkFo6u?=
 =?us-ascii?Q?54vxBrrVcvd+rTyBuOsdYkxssMBOfnxiB0VKEXkkjpi+cQJMvn5PNfAtGzih?=
 =?us-ascii?Q?qlQQBzba2X16uUSmbU9f7nmFAqXaX/vrS4+CnrzAtqnULw2D+77UQE7ZAX35?=
 =?us-ascii?Q?tR3HBuTleN+LxDeJbps4MFwRBuZOEaXv+7/1Gg1/rRNcQZ2EakE80BaVs7OQ?=
 =?us-ascii?Q?NAUbeNYXwS2ITJCUnGMAhunnK6sqCIHGo46O5ROmkUuVVGESGH/7GZjsf+yK?=
 =?us-ascii?Q?mS94/LnoBO936/uGSd+a8d9WapC9/3HILtkVypKYQFqMyKZrhkISsG4phtHH?=
 =?us-ascii?Q?hy3ypMEH61jt/oP5u3CqITp43cTDwsMTpjyr7O2Kff1d9rqbxxOVQYSiN+bo?=
 =?us-ascii?Q?eemjaar6bTD9Pw1KRgr1V1HZIvE8S+MWZiLlnpQ1RSUPA5FQTOzaQOPNZN9D?=
 =?us-ascii?Q?i25zubyl8O/6FxXlhC1TUeVudmYKji6nz7PNtgtZ8WkrzR2pNvHS5xKpFgQp?=
 =?us-ascii?Q?NS555fRUioANslilt8DG36D/BjtKcofGfRJ4j9z48JOuac5a8QTQ6r+zN/OY?=
 =?us-ascii?Q?nWH+q0LxV75eBOq0z0C2sNUyBI+A31/FDHf96FWmp6LUrAGOwWXbcyXyIlKv?=
 =?us-ascii?Q?axreBO7pBmlsueTraYOIkji/c7UcKTQch5R/za/SdRr1RzXg1JwXi9An3Pwy?=
 =?us-ascii?Q?2KtA4bvml4m7GCztPKcYDcieMOVx3GdcC1ASOC5cBxlRpAXvPf4oBUdnqS4p?=
 =?us-ascii?Q?1eF8h28UQy7wnXw00H9xp0lBQPwRI6THxfTl+krI2xLUrg6W3FYi2Yr1hr27?=
 =?us-ascii?Q?WrbpVJ3nbCizABQICNTjGHJwsLPhXfJpW6gxZsp8o2l89oVMvECQppzMrUhU?=
 =?us-ascii?Q?tm5C+aFUWGJgwmDzS060BMIY6T2nHdc25Z6M/vKfvhaCLCU1vQ85q/NcSpO4?=
 =?us-ascii?Q?4DYtpgB7VKd1jGHUWWsKTogMKQFSamOaulMYvykUMGBpWMsfAjY3pWZsvvDd?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c18427-a4d7-45a4-9447-08dcb546c936
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:40.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWXKjJjB2oM/+DNkltYphVhaICkLDtCyEJw92cCQ7QwT3611ptB15Bc9S6oSzPPBTAbqiPXaLYT2O2ZZgXbOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

Some usecases require iterating through the service data structures
advertised by a scanned device - for example, a Broadcast Source
advertises the Broadcast Audio Announcement Service UUID, with the
Broadcast ID as service data. The Broadcast ID is used by audio
profiles to uniquely identify the Broadcast Source.

This adds an API to iterate through the service data advertised by
a device.
---
 src/device.c | 8 +++++++-
 src/device.h | 5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a1dc0750c..cf7264051 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
+ *  Copyright 2024 NXP
  *
  */
 
@@ -7374,3 +7374,9 @@ void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
 					max_interval, latency,
 					timeout);
 }
+
+void btd_device_foreach_service_data(struct btd_device *dev, bt_ad_func_t func,
+							void *data)
+{
+	bt_ad_foreach_service_data(dev->ad, func, data);
+}
diff --git a/src/device.h b/src/device.h
index 3742f6028..97536774e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
+ *  Copyright 2024 NXP
  *
  */
 
@@ -211,3 +211,6 @@ void btd_device_foreach_ad(struct btd_device *dev, bt_device_ad_func_t func,
 void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
 					uint16_t max_interval, uint16_t latency,
 					uint16_t timeout);
+void btd_device_foreach_service_data(struct btd_device *dev,
+					bt_device_ad_func_t func,
+					void *data);
-- 
2.39.2

