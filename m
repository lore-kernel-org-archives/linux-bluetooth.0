Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021100.outbound.protection.outlook.com [40.107.39.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56C372049;
	Mon, 24 Aug 2026 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538677; cv=fail; b=UY0kjptQm25hOBY+m+ShNlM4UjPIg3FhEjhUjx6X5QXO7zzx/IOwrmfOhA5heIHo4ZnSBN/lkfDXgdYzBj6ZpwzJfb2m3UxNt5cQxewKjlFonGnSWe/S1QGgVXhLl67c9WNaZzpt8OmyKK7vWcZpaZTgLhp3Ok8oWxrKWdNgj/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538677; c=relaxed/simple;
	bh=9Tg1I+vQQ6VOSJFIMU4p5VrOejTEGLMLSJ39GPHS9BI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sv4xGZt92o6jq8mHjc8eOSUw/3TdfxxcnH0jbspOEmZ3m6ODBLT1I3KwEvXqElLHKL6hdUs8H4DnUSpWqhHyeylzqF2Fp0yaMg/+kt76ODcW7jvqWM+RViGYty1QOiQTIMndegX9WfExmfvmEYwEll+zkyLoW8QALO0khob7Pck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (2048-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=YHQZNi9N; arc=fail smtp.client-ip=40.107.39.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="YHQZNi9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQaQtKoO+7pI3ptpUprmJ5vDoDX/dwUNgISaWMXqHPBOO6k9FA4yJfi4xs3lSzfB1IM+9/uWI7xiwbWHvSLFodcyApW2m8B34MnZHnk2WgRhdhYip/SSzYN6YIvDgrc99GgA3rDBevAycav+WVaLiaKeDUdoyjaUIFgQue7pNwq7mJQwjTVC4EBpFuQhzayCug4fQBl7mOzHJhVabaRHPxq1fgiw9RpkR/xaLvvcABF6hDOsgKE1X2pw0yU1B4tGSCep+q5DVKYUMUDprsUq7j//2oXq9JblA7ju6hkMSF+Waxp2jxG0daPYQ46d0078eN1YWimlPV7rRoIQV5J7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVTANmQV4gySPntnUZxReRLfvQKJQUpsyqsVJn81Qg8=;
 b=wxq2cQJIDslGgOcbklSrh66OIKU5E0WANFrqXiUc3Ns23BCvTBotCJBVeCochJx/zYXgnTBTDNEJBDa3sZwJeRleXUP6g9Iq/25SVbfbSFHOnPrZRNEYTXhcjnmgFSJ88KIHdHRmG+/HSOq+qsOY5Pur5LPNAY7WkpU4QK7GRaHHsFRlfUh10J+h9KH93+zhcwqvVAzlnaqcA4DZCM+AOSAvfjuu5hDEJl5PYF8gM9z1Q7ZpshdLa8Hpyb21yU0QttcX9Nb4YXWQeoxZgi/fsKUbOzqZiCYUpJOD2l/NChLb0kuyF599bvWIotOtOS8JlYsZ07vVA5fr+NalIMiVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heitbaum.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVTANmQV4gySPntnUZxReRLfvQKJQUpsyqsVJn81Qg8=;
 b=YHQZNi9NfuHgppexVveG2SCz3rb06HjzmmGLiLKAFFAhG9xz/WU14CusSHiN6gJa2I8t545MbpFUZcJX/1gfXYkCN6G/0ihlKafy4KlAy4gxXGA0voINCE3ENt0nqHHUHJ2l3ARLL/JWRFNMSrzPyZ8yZQ5Kk+RpQe1Or5XJXYarCTE54QHRsiCc9SphnYmtAlgQDOMVRuj1P0kEk2xUxPLiwxw89KPA8T2PqLxMh1Do0q8G5JFTbphb3PAVz3q17JA3TKTLw7L4x40mp9PwL5gpH4ECFp578RZQY7GgLamKiQoKjfH/KRQRGVARfS+vboCDITpEyd99OjTia3dR5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by ME6P282MB6183.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:267::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:31:06 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:31:06 +0000
Date: Mon, 24 Aug 2026 02:30:52 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	rudi@heitbaum.com
Subject: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM4359
Message-ID: <aous3PktDH5KVAZ5@0d3a7a881997>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0072.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f3::23) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|ME6P282MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb3a5cf-0727-4229-8888-08df0187bffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dXszG147gD9+ebs/ZJNme7UkoSlry1n7gA/Vr5ZhFVwGyo4A7z7Rb3SwZKMkU2pF2xO+HqvI+6bMiXPBqDohOMkh0gsTIufIXdukaFNRnoi63ahlSIp0x/RLiSZD4KfkgTYp8IAaYZZAQ7qCkqjiJB+J/leIDsfEMvr3RM6a4EGrnu3REilBFWj+JqROHaMasDCGa6Fv8DUDfMzHKZGvJpiDQxeklqne004p2+d9CE97ldhYZKJPsbzcTUVxnvGufIpnpuSWDvuM9gFwEh0fIxP+yfgbwlA8sTL7raESUskyxs37OJ/VJYaj12oUR8ANSyzh76NSDsVQGZldwl2UeZyIPcqaTigGDNRydH0bsg3/+uiouL6eJO8+tUlTwNWzd7TYwSAxatouVu/jgAzYRcbbfEei6QeltMYsYpXC09zVvOvLV+zA+gPZW4GrEqRcWYoZ9rK9IxuMkTG/jxMYSBiB2+vkNMCAt6700n4H+J0sJ0sFOtyflL9GPzWN3moXoSy/jfxH35K3ymyHGGRPl1Ut3kLYcNIzoWFhRFoAdpIcGs0aZL+wJII1GQgOvmtQJzkjLdulAa1LFv0ccN4L4JjgH+foH0mnS9xBWDV6mJ2l7gjm2ApPuPZ/Sdn1fUlosD1AGZUfz/ovaDBUWewdJqUeruIo+i8cQuKTrNZEJ+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvzypY/75/ub5q3dLB7htM2o5Vd7Ypo1tAYfbJNPVVTIkpiUTcxaR81gGmCN?=
 =?us-ascii?Q?SEbWA7E8UTbVE88RVICRTClhvPqj4PhUZe6WPnxnZS9dnhY051vTH5XE76L0?=
 =?us-ascii?Q?GoaBgSLBloFkLktZnJx3gnvbU1mlViWLJaeQAph/mVHRZjcle3iu31N+UpLR?=
 =?us-ascii?Q?kr79WyE+c/O38BSiGLKqOmETOQtun8ZgJbSfbsXpfw3zsPp2qP7MTnI5t+1Y?=
 =?us-ascii?Q?9ketPadmyKuk9okqsH9b915E3EK8m085nJsK2yMma1eFOEoncbqSf4Fm5/08?=
 =?us-ascii?Q?u3myv/LPcwJIYgGPDorkDRqXI525Ha/8nyrAbLrLCC4oZuIukgQEhQuXIrkb?=
 =?us-ascii?Q?Tg0sxXDPnc3l68TqhuzmeQkRnnL1tWezZKSkNnUvxs1kQVkPE55J6DQ3VxOY?=
 =?us-ascii?Q?kewmxZ8hMDnwg9zqQ/LSlvnHU1I+SSICAQ5NspzlrLaVeg7liU60lfPsebkX?=
 =?us-ascii?Q?vJQbENvN2ifVdDp3l5z7pSBptv+8PaICa6l6aQclewahSESdBlDn1G0s7to8?=
 =?us-ascii?Q?fmtPVfGhgprAzsYGz/0lqxT4rxahJmJe2v6W2hce7dF46kIqxstLRGmdaCOH?=
 =?us-ascii?Q?DIUU6Ow3MgwYQToSYuLkTrlLe9131Y2AvEWBE1TY+AIFaT8bgrMM5fKkGBrE?=
 =?us-ascii?Q?FKRjojxUEprutqRFEdWjP8PtkRqLqCMZVHVcpKTozGrRMA+FNu4Jt8y2X44s?=
 =?us-ascii?Q?zMRmxsjG3lOXod0YE5TkYbyKnTgSRrAmMbFznF2LsnOGhb+u+DfHmTebJTpa?=
 =?us-ascii?Q?zeFwKcJNExGqEywuiO/YQcABMVoA2JAfc6rjhNNN76D/P3VGqQ1hODQr6LBv?=
 =?us-ascii?Q?riHqDqR4+eLQRiAoNtrFbyKYOf+CvIMKrkacRvvvGQrx1Uk014VAwuqQhRhN?=
 =?us-ascii?Q?UpOCgyMJyH+cDsnbcI6M4afDJUb6TQ9Pvs99q9+Ddt5DVhnXNny4Sn1EQ9nl?=
 =?us-ascii?Q?HpWOj208Ddnbrqq1y7l+g5NcGLnvUUrmmQe5A//46oyzAJ3ah1n4RVcDaJ6L?=
 =?us-ascii?Q?F7saZufnfOyiOiCFT97SH7pXXdiME73/aHdTUJgOSy88oId26aywSnvKIUJD?=
 =?us-ascii?Q?/ZG+Nl3DFkzVkF/5dBonQFW0STdLSc3h8yZzBJy9dJMQ5VX1+sPpZKW4Gpu5?=
 =?us-ascii?Q?TWCFQUBViXraMn+BJJ5oAc/KSaQKx4BVOsO521J2LpOcS4FDckgE3lHEK46P?=
 =?us-ascii?Q?0K3zEXXAoKK5WvIVDQ6vEVhaAMDQahaYxY+kKH+MTH6i6n00ZW0UjV7uwu1Y?=
 =?us-ascii?Q?sjb498SF0MgSgxeVzGi8gqpPQ3bTUPKEmXzjNVUwM95+9xoTn0rCHX8+Nal3?=
 =?us-ascii?Q?cdDs94SCtWktBzMDi6ZjydW2Gq0OHV+TtBESmte/6C5vbIsuWqet0I5uIyh7?=
 =?us-ascii?Q?YYkwYDYCak75IF5YUzpshkJbmxbmi9fJry5fqXXqJeBJhHo1aK3I0fRvyYPB?=
 =?us-ascii?Q?LU/gObMXycKUS9VbL4Aqw4ThYxUbpMbOsTNvIq93GkZNXTi2YnkbAXrx9A3a?=
 =?us-ascii?Q?KQbkBHRDkT933EvOQxEBgp2zYpNRgCklyGMkXRrL4sYXygGtU8XkDEfaM+EU?=
 =?us-ascii?Q?oakgf0e5QL/ZlIJDaKujqniu1hj042fseooX/JSzMQ9lq8X5nX4n/Oes/gkj?=
 =?us-ascii?Q?KAiHNvoQULluVJPC8ijzpwLOL3oErFiRncUNnS+Vph5d0IuRnfZgsPpDzXqF?=
 =?us-ascii?Q?yJkXbEtQboOkD3ytlqRvxcr+vqPpbHyLGt2eWnYcgU1Bth8e?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb3a5cf-0727-4229-8888-08df0187bffb
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 02:31:06.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVYA1FyHOt3+rXapjYjmjvUwLn6KJ/2EH2QJ7w8WUMuVA+t4qBBn0+3Mn/07WnxCsKPvqi/mlLKuLrcZHxxVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME6P282MB6183

BCM4359 devices on a non-removable SDIO host use a UART connection
for Bluetooth and the advertised btsdio support as an SDIO function
should be ignored.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 8325655ce6aa..0927f29660bb 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -295,6 +295,7 @@ static int btsdio_probe(struct sdio_func *func,
 		case SDIO_DEVICE_ID_BROADCOM_4345:
 		case SDIO_DEVICE_ID_BROADCOM_43455:
 		case SDIO_DEVICE_ID_BROADCOM_4356:
+		case SDIO_DEVICE_ID_BROADCOM_4359:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 			return -ENODEV;
 		}
-- 
2.53.0

