Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585A1BC20
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050300; cv=fail; b=EToWuRxAKO87FDwBe9vyTJzLl15pEPcyXNtM1QrkimKwFWqjciHXj9fhj2RNSAaraGQf0Sx5NDhCS30zgu0zRPTrU3tzl0kO5U+Cvj/+cYlmhEAEcWNiIeQM1ACsCqmzsrjrW90lF/qWEkbAg8eZ41tkUGKckcCFmNequmKmrk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050300; c=relaxed/simple;
	bh=qJSOmY4aUhQJ19OvboNzEcElZ/pTY6zu0AP/+bzABLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukefbUGCD3ThRLaW6jbt0XhG51gQB9lU2lsf7kLVdMSJz6VS4aGhFcelZloezNVugiNfYFo9qrWtcx+3w+DAZUC1efGtRrn2vwebAgzS8D9TGSlTjM3uwgdDi12c22BNHfHk4JvI4AkqBMxKp1+4yskQspEwhx3CFV0m/tA0aXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f0hSUZox; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f0hSUZox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0hCAqZtUOOnlrmdXUVseqb55clRNjAVvWvD/Y4eyJIg1Og4IunIoFNkA+Ka8GhCDE+DXQpzutL4FDBz14gUnJCC6uFMU7jgCyvFS1svxZzQJTo14EeW886aTA6ljJMGwD70tdE4mGh99hqkYg1Di+iLrJijl9ZqgUuWqEG+WBe36JhoGSp0PwjM63v3FGP37Uw0gv89bEaP2SnLkgLV31xAUyd7iUHNIWfo5kp5mLXbjUtNoQxLk9YvTRvd0HeDI3DxC1j6JigVtKgK2kMSQHJxzlp/mcPOXUa73TdI7/Umg7qnAGYPnp3GjT1oHblcE7a13B8gsoAM+DXzosjlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7qPHL5CyHCux+GIbeFAV0JSzlmOqUQZoe+M5eIEDWs=;
 b=iFBqEyumfsTri0BF3ZFut276WvxVUZvfaX/2q6Impj3yFk1DiJLo9x4N3gMwc+GZlzXAOlWab8FGJg8Cs5CIHErjJqHHiOIvrXUSXQdpYdjY5zgSzpLLyQlEn95cq0wZq1xIZHeFsEJ8Ydn5+h2nUJLaBIdpUpYgYzclTT688I+TxqJVtqiGR22I54WVXCXQPA/A0dcVeMCs2VQESEWTA6e2yCgr1S/DKe2K3u28n2I2oNao0D+KnEUVrF2BWMzlKWQGnXVTHrfSEckL/sLfpP7QngwQgYjLNWb4V2VkH0CPU+KVTkVhzoRRHnn/+wdyebl9dioRt3MsMSJll84HEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7qPHL5CyHCux+GIbeFAV0JSzlmOqUQZoe+M5eIEDWs=;
 b=f0hSUZoxkI46gIQSbExmhhmw8wsTBFvWGpVekkOrIIAFqZTd0HQO4TNxRNzwZdM8sXUyCspUT+yEG7iwNIZTBymB6Q8yGlXCGCHdRf4Jr4EC2EfbAvlcRSS5HSmtP1NdXlWWujG7EZicRPZvYFl3rXIrBiNESIa2u+jnKGKGEXkiN7KK5RtF6kkKAVPOA6/3TBuCdTXGyQIUzcu+G1IKlEK93vd1D/qz0zht57Vzw/X7aMp/L2AVj7yhoHAXXNgOFWHwIG/Apvf2rQLPCg6VLvMwmBfCK9rFejWkRlujgWh8o8Xe6cTIqVH1DvPnU7OOk6lOwQ+BL2gGgv9M0B5tNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 14:24:51 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 14:24:51 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v1 1/1] HID device not connecting issue fixed.
Date: Tue, 24 Dec 2024 16:24:24 +0200
Message-Id: <20241224142424.10572-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224142424.10572-1-mahesh.talewad@nxp.com>
References: <20241224142424.10572-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a0c6f8-7165-4e16-afa8-08dd2426ba77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsjOyBc5ZhRdinGmf/PIKRDL6nXHMoXPHU6Map+1QjM/yQgVu1iCq6IghxNO?=
 =?us-ascii?Q?2OdOAkbiGu+lKNGZjNf3FpRj5ujXf6qjyAlJSdA+xoC/PXn2prZDhN/8w7ta?=
 =?us-ascii?Q?xDRkzTW2FV00j1nRPaqkx7fP5iGjA5oKkJxiimchoi/3aviG5htRNvnLCzU/?=
 =?us-ascii?Q?aNtZhAJ5BXXXdJg5Yb3WnAiTmVuLUZ+KK7t2HHgT6gfwU0Lv8hsSvREpZRLw?=
 =?us-ascii?Q?nken5IWKDnNPtWK3NKleOcQXKTWyyR7721Tr3N6bGfn/QTrq+03ZDK5ai4Ap?=
 =?us-ascii?Q?YNVBmQX1sm3ca+FY/Hl72FCZIa9uI56vr7ujWUm9m//zTeHpMH019iTQ4PLW?=
 =?us-ascii?Q?DPbU7G2SIXcJu/u87fkBFNburwQ5tfkasqaL/NzMOUGWtL0M4xe1L6jdfitt?=
 =?us-ascii?Q?bLgd7DGbclo0tHS0Q+JQ3XQBZJ9RnT317EBY8g2nhwmnF2ydpjQWwScX+lAT?=
 =?us-ascii?Q?IaN7BZa0UWh25ifql+Rde/3DtCH91m86BHA18OGzRbqOss1DvMIzUxM/nFxl?=
 =?us-ascii?Q?aNqlz/ISXGYqc4Wig8Ng7gSuwBgnndz8RfnPrQNrEQyguJRbk+RV909SJuu4?=
 =?us-ascii?Q?agD+gBgS0V7gP1DJINKtUdIMfaqgVbOyg4PLw/gZhIbA3JPLnFLITLd7BLCI?=
 =?us-ascii?Q?EFjMNjTG5nmsV1fRKoQWHhxPaKcAvBhmphEHvwcGC/88IiVhpX8UaBXyNFr5?=
 =?us-ascii?Q?B/A0hTb9fgyo96OiHy7OB6BoktLfLKoQ+MnZ6or2QFvFD2AcaI1/TFew0Nj5?=
 =?us-ascii?Q?ecGBw5g0ZCYV8E51yoNksQ5FOGvzPKHNBcm6YAbP9E5Cjo084Bd0WEaG7sTW?=
 =?us-ascii?Q?8wPsPpW78ywC5c1uepEwjp4SePtIdQmz6OUWEaAol5GhG392DHbiAj0JAnfq?=
 =?us-ascii?Q?BPaSnWJBpDMm1nyNgW7McgPF3X9v9LisMk77q/zF30THKpnuFvqqbXS+kpAv?=
 =?us-ascii?Q?AYQ3AmzoIOv0wWN0lKa8C47ttls/f/Q7Bdf8mBRamvEumMSjTGgn0SLjvm1A?=
 =?us-ascii?Q?CrjnwF0FPoq4Sl7z9A+HD8+TKFCqhSmmau3EsX8h7fo+XH4bzgXbpOdLz1dK?=
 =?us-ascii?Q?lWWBPIgRxFDob8EYCGXMNAE9kGHUGFu/YCED/tWyRYd8d/sLDL0E/e6z9W7x?=
 =?us-ascii?Q?fwDzLR/K8RbTzF7u6bkjlL65JpSzocLDCbO9XNcKfpIm9ZNOa74laSoK2aRd?=
 =?us-ascii?Q?RyPmWnpI8Y+jtgtjDFWdkdmBFj8gptE27HOcM/2uzj4+gIzEtN6zyvfN/SGj?=
 =?us-ascii?Q?azdEK8Jk+31tCM8kJbtLOgYr04PJOuxrKiWWtgIj3iIY44nQT/ivVM4tcZsf?=
 =?us-ascii?Q?ud997VOdkr8vLFbg1ynoN074oYJftaIXLQYCUCcgKTWW8KLu/PDGhqJbVU2x?=
 =?us-ascii?Q?liWwC3R79TX6dE3z4a8rK13XfUUg4LM8YQPFCdmbQs+RL8zhgW+t+RNOsLJT?=
 =?us-ascii?Q?hTaR6ytlIYXueywFnYQZhjUwmrqAZUZY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlk0+3xIlcWfhZeyzjBcgzTUM3XL2l3WA1/lks2Y1B1gQugCobDIpFPwEHY6?=
 =?us-ascii?Q?KxEa5Jm6m5RPWDtcWMMneYC4CyWe1kOi0kmLm42VJpDhiJl0GtG9q4Dwk6u2?=
 =?us-ascii?Q?WY+UeiSV0jkfmn1gfy6FxTce6iX/atWa100z59M94x9QBfe5/QDdMDgl2kIZ?=
 =?us-ascii?Q?TbBIvNeeAEYYBUYpVao/91u1bFa02lZJZqT9lQbnR22XeX1tSejJ4PKeZ0eH?=
 =?us-ascii?Q?Wozh0nlEkhkT33NcVh8sRcdJR6XxxF4fkaWzf1cFllMX4TvSoNeOtbX+7TEM?=
 =?us-ascii?Q?O1MBGFsYj6KJGtmCN9P/+nGGtYrrQYnXL2y0c9x30vgH+tXnaV5cV1X+KM+G?=
 =?us-ascii?Q?peFmWBIxhoqDavLBASjHOJ6I0J8BYFFwDn1dcP2u0NooUN5IztEoDmna7hXY?=
 =?us-ascii?Q?5ONFXgSaoleQns8gNJ8b1XBMFIcfF83gQhi13aEmjrG+lx/YWUU/NRChqXCH?=
 =?us-ascii?Q?5hcZFI2XZsHuq4SlzktADdqgm1d5FQ+PqRjYFrhiOQ4Ksn169NNHcZwB8xrl?=
 =?us-ascii?Q?I1yoT/8pZBkyt2BzGbTuzY8+ENsTs6oaf7iZrha2FFXOKghDdxXGam8QhLqC?=
 =?us-ascii?Q?4tyZGdFvDkNiAMpNe+mdQwpl7j8HAe7SidzOCdDL2n3LYieYYipE1BHdrq/1?=
 =?us-ascii?Q?/R+taPM620Rjrv0gLYdKPhiuwI/3ij4BK7zbGO4eDVwT69KldquQFJs5+CMW?=
 =?us-ascii?Q?LffE/1kY7XD1YzuiTnZNeTc2KbOkPl78//o384FRPtSP1HvcY7M5qsP9qEul?=
 =?us-ascii?Q?2DwfOO9za1xAdPX0lnUr3gDgAlMEG+LcS6b3Cy+tXf9UepHn1f7gZ/0xbZ8u?=
 =?us-ascii?Q?/GyzhU9esKeNDaeh3+tocd5axS3Ngklw0Mm45Rym+6Krdft+kA6mnpIHGttY?=
 =?us-ascii?Q?ykB8x7yADPnS53HuLHEtzB0WQRArdtIPBl/8qPNJAq3AJFjpPT+oJuIfXQ7v?=
 =?us-ascii?Q?iIrNcpwXpXLE4Os7AsmYeNCUuCxZZIpI6PhTnF+yUVnXgOpeQgXQMj55m0c1?=
 =?us-ascii?Q?YILCeidnHuOH/PTSUbtMtucp0UcDw9OYwByUiwJc06oYvgW9Vd69EY8Z2au/?=
 =?us-ascii?Q?cg9gT8SLtHbrBnxRZDO/IfLOAAkaR6Ah2ql1OZMgOtxojXDAaW455X5nPDRJ?=
 =?us-ascii?Q?rCk6JifbaT4b9Sv9vEYe8paXeVzfkfdJX+V5Hkf9+aWXoMGBr7LwTEzecYwZ?=
 =?us-ascii?Q?FOATA3MuunShaMn1ErCwUqQR0gjSTUYyM4NGrm/X2zki5+LAvHrBstPGIaFB?=
 =?us-ascii?Q?YM0WmycFLrCWDlNOL0ckMD6AHvYns8mQCmdFHi72IW5UDM4oOrXsOyBoF/BX?=
 =?us-ascii?Q?XyCElFNrVU8z0plwZ7PSi8ZOyPjIVXtUWgoV6cRFF+e/2Mv9GmhIDPo/uLZQ?=
 =?us-ascii?Q?yYUhkElc914I1T7M5InUQe61OdpCyh8aCwn+ruFXMay087v76FHfEnkdUjzI?=
 =?us-ascii?Q?tDCzxSt2NxQ0rKAmSHSwsSgo/S3bgCyHf+eQ8vopdvUvcZsNAE7NPDa7oSnI?=
 =?us-ascii?Q?JlKeM3ZrIUSdQN/ZwYLcM6T9D+ZsLepBUEtPj/kHHErEQcd2vEIzpsjJyfuS?=
 =?us-ascii?Q?YYIg/JPbZ+FxNY5eaovUyAeAtPibKi/DabBXi+XHzsVhRB7+lblZSoTPVAwB?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a0c6f8-7165-4e16-afa8-08dd2426ba77
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 14:24:51.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFd65120e9QsIBiYEg4180Ek6hLbMMH8tMTVcNxA2gUjIE/2iEDAawCCp1+7tuwmuU/cdsaXkRVjuaevYFe5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

While connecting BT-HID device showing br-profile unavailable
and connection did not happen.
Steps followed:
	1. Pair Ref device
	2. Connect Ref device
With this patch HID device is able to connect and HID traffic
can be observed in btmon.
---
 profiles/input/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8cf8e5ea7..a6047998a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -89,7 +89,7 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
-static uhid_state_t uhid_state = UHID_ENABLED;
+static uhid_state_t uhid_state = UHID_DISABLED;
 static bool classic_bonded_only = true;
 
 void input_set_idle_timeout(int timeout)
-- 
2.34.1

