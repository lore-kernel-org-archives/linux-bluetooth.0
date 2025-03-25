Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED302566DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898508; cv=fail; b=uctNLH5gAZRaQbaLrDLjnOYr7MjuRnTQfHALV8ifuW2059XmmyQFZIsKeQjpV7sHXv6wBn/iT1K06BLcNiteN+h+4doyb+ZwOTZKquqFz/p27mX2DZlUBAWofv3N78oRpUT1IqXsTE7Xe5yB87MB44H85W2mH+UHh/6gyP6BlNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898508; c=relaxed/simple;
	bh=IScJRuetzxj0udSvuDzAboeEmo9PW0cevQDZ5CAYGXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuvq44RipsAQzfIknbTpzfsO6ZCMQHf1LH2J5VbBswY8MeZ07qceNYuQQAw7DbISpn+9WaAIhEursrRVOsxgBM+EE8DhBrc8jxdWZ8UoYizRW03XCezf+gjKASqMrmY1Q+FOt+fHy+dj8XKTnU0GM0ZpfIJSlrzLo9ndjqBQ1kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=m23gdDHl; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="m23gdDHl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2/G7ZDpurTREKSdmwj1ALs4JfbU8aYA1vyVhL67ltCehWsaQI4tkV8G6csz7s+cSjGCrPCSkwzAbAgUUPD+48/Zm2S8vzkOmYWaxmEO2IAMU8/PXRJRyAeirfI+Hp9mEaMITukygn1SKVoCILB6NKCpNPA7YVdSSVtTRDLbpWzJDTKBB7VW9EoDERzmTIYDMdvGLi81+rqT9jRl0q4DHyjGKw8C6wcdN3rzw+rWvk6dEcAoUZxpTV9VJWzTq5+JZ/uAa3e8Indp7cbmHAEaBy5U4jkDhxPl8xVUK1i6PXVkX3Te5QKlbhYvoMKt+WY2BULoJ3vfxi3Als7YebwEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSyGZ6YNlrK/zV+siFkVV5fIYuH6dymUr13FVaAsDdI=;
 b=H64Z1eVhot8casEbLEltCjaXI7W99LeGsOrETHdrUZ5Ng8lnU8S0L+NOsTXhIB7KCzY1BAXkS6POX98qAXErXRUw73gASCin0axr7IARujVys0lwJMr2mGQx4lkcZq2YUq8lqtQG8rvJ6wgBKfSaYErbx3FjX2LlwYTFPn7wEONOGF2Wqa9aC/sDRmeedLGaQ6cAVERbb9LQWTYUUF+bHokA/WvBMa3G1MmPgJ8wdmJ3DOsf65edM26dkxbLx6rxSOqwZKplp+4zU3K95zHuxPLI2WnBPAPRl4CS0ZgCQU80aEAlOV7j9eqK8TWNLJjCHSzuOEcvOT21EB3GAWen6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSyGZ6YNlrK/zV+siFkVV5fIYuH6dymUr13FVaAsDdI=;
 b=m23gdDHlJTlzddUMGB0X5Vt2BhqGLfWynW1vc1U83DfVNwFBTi72ESk8MSW5IcA/dwIBhSIXXQZ2eHrTnSVFK2UyL0KtCQg6gPb1KMU8IK28lxcKpJ9vdrFdPxSPRIAm16fjEUgVag9zEexFx/PTDcP0SAX/TaFAu/zZUSXkq8g=
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by PAWPR03MB9713.eurprd03.prod.outlook.com
 (2603:10a6:102:2eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:28:19 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::2) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 10:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 10:28:19 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 25 Mar
 2025 11:28:18 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, Yao Zi <ziyao@disroot.org>
CC: Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH BlueZ] client/gatt: Fix pointer assigned with character literal
Date: Tue, 25 Mar 2025 11:28:18 +0100
Message-ID: <2168523.9o76ZdvQCi@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250325083546.31597-2-ziyao@disroot.org>
References: <20250325083546.31597-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|PAWPR03MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fcb787-39e1-4407-756c-08dd6b87c313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P5SKVk30SRS4zrrVEr6kHXUdjlgGySLD3QseIc14Z4TL73vg79e7XpFUuLCE?=
 =?us-ascii?Q?cYrP2HQEJY90HperJMF1w+PIog5z7/0k1heXeK+Xtc1zWlbkLkVfeFi+li1M?=
 =?us-ascii?Q?CzlC0o9M1gqYfn3SH0jmB6koJILGv1Sg92vIHf0WKZf7w86MyIWYwQ8A8ZiF?=
 =?us-ascii?Q?p0RqLMnEdioODKFSHl11SXz8jOqU9JYoIaeUQ9VMcFZ72GuDaTPI5ZdFrCF2?=
 =?us-ascii?Q?hgCRO9XgPIQZKN/LJJ0AKQqO8uTgSFkFGWdF0zANCfsgSKdLT7RIEJ2RMjco?=
 =?us-ascii?Q?doMVu8waUvnz3OsAuiWvWOsUDGAJuUFdXEqfZ9UFIHm1x5UErhxgdp+vQnFp?=
 =?us-ascii?Q?cC+Tag/WMXxCc74tveD83JkQZJHBanDarugRl8+P1BimKNNITS8qYozhNrWp?=
 =?us-ascii?Q?IlmMzuYj7cqzPOwas0XjpqX6hBx49m119XmbyHC4yRlqqp6OAJDIyHzWLJ9G?=
 =?us-ascii?Q?HXWPEPyaQC3WaYWg1ji6a2F8tCOuQhrnsI+LJdueSX790bFiVA7rA9qH/PmQ?=
 =?us-ascii?Q?YJBcHkn9+sZZfSn0Aa4PULDDMnFcCprq3gowK1YERJKqxWDB0O4Ek7Bb2e4Z?=
 =?us-ascii?Q?UR05QEcAMvIQx61E4V1T79n7FNYfcGVTNXO5tvN1lQLQ6jUy0tpHrLlGk0ps?=
 =?us-ascii?Q?oeYNgAHwIIPWw/QA4Jd37eNPH1x2Ocjvh+5hMGT/HI2/DnMSu/37KOgaEi1a?=
 =?us-ascii?Q?3k+7cqL6wmtOk33brseFpJUIH0GGDdU/bI3LAqbjm6t47aZYgcI76PSpggBF?=
 =?us-ascii?Q?qf2qSPwABeGqY8lEIIGPn8yju5myWqF6ioJ1dUCyER1y6N6w5uB9vtgX6z9f?=
 =?us-ascii?Q?bjViRSdT69rPDcd3eSXcLa7GE2mTzJTwUUA/4xYbtus82WGLyLSxVq7KYUGF?=
 =?us-ascii?Q?bOs7BO+1Wh398byFEJkwI2VhM6mr5tZMJ/v82lOlNnaTJf3PhTDt1uApVp16?=
 =?us-ascii?Q?ycnCV95X9wNZpNI+z9FlPdeIoYsSOacvvpvOvtBhnrtF6qEi3hfVVztP1sJv?=
 =?us-ascii?Q?c6upSk00mShAZvdAPzVA6P+cHZAfEsHWAknU0DijJ7cENriKErEt3Jc46xGx?=
 =?us-ascii?Q?OqxkTWTvWOGlGhnVFi6Ub2Sfgwt7TsgpxuS3jdRohMWaENO7sjib1k4jTQw3?=
 =?us-ascii?Q?b2LDkOxraS3gMIk2LMInd2FggkcRVSXe5Uu4jjj4p681Z3SswrkobXO1OqRZ?=
 =?us-ascii?Q?xmvwSZKyYNdf+znvfeBmClKD+neplU6PIdrP7+YfMFui6UePbj8Uh0Lz4jXM?=
 =?us-ascii?Q?rk2Zscp1A9jVHcuOmO9p0fGAUk01uxgknSZ1TBvIhfzhQF2ItYmCFt0Uuiqp?=
 =?us-ascii?Q?k5RBw4nqKJhl1jVDXONYJIZ1yf3Q8AJGouq+5NEX8o3Gs6tqA5WE6jqoopqJ?=
 =?us-ascii?Q?BlXhH40moLUUnsFnew8mynRKvNrom2LiipuKMaHkgC6pKMJki7G/r3CVZCB6?=
 =?us-ascii?Q?kpkb5lhYG/+WIAMuQSPRSJBhRWxEV6qiDqHWiZg9Y4R7Oae8jMYVvFYZVI9b?=
 =?us-ascii?Q?1Z3CtfPdhTbl1QzPKxpHfzubj0bCi1zNFP9N?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:28:19.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fcb787-39e1-4407-756c-08dd6b87c313
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9713

On Tuesday, 25 March 2025, 09:35:47 CET, Yao Zi wrote:
> A character literl, '\0', is assigned to the pointer. The corresponding
> comment doesn't make any sense, since '\0' represents zero and this
> statement does the same thing as assigning value with NULL.
> 
> Initializing value with NULL (or zero) is safe and correct here: the
> only case that the initial value of the pointer is passed to
> write_value() is that the if branch isn't executed, where len keeps its
> initial value, zero, as well. With src_len equal to zero, write_value()
> will bail out and src_val won't be dereferenced.
> 
> Let's clean up the misleading comment and change right side of the
> assignment to fix compiler warnings about the wrong type,
> 
> Fixes: ee750bbaf68c ("client/gatt: proxy_property_changed: check for NULL iterator")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

After reading my own commit message, assigning "value = '\0'" absolutely makes
no sense in this context. Actually my intention was only checking for iter != NULL.

Acked-by: Christian Eggers <ceggers@arri.de>

> ---
>  client/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/client/gatt.c b/client/gatt.c
> index 4dac88590..b18186518 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -3207,7 +3207,7 @@ static void proxy_property_changed(GDBusProxy *proxy, const char *name,
>  			chrc->path, bt_uuidstr_to_str(chrc->uuid), name);
>  
>  	if (!strcmp(name, "Value")) {
> -		uint8_t *value = '\0';  /* don't pass NULL to write_value() */
> +		uint8_t *value = NULL;
>  		int len = 0;
>  
>  		if (iter && dbus_message_iter_get_arg_type(iter) ==
> 




