Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB816B394
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406669; cv=fail; b=CDMISMSTHo00G8QSYZoSkniHJF0VZn8IDqFWQOsJpKdGu8pnhCucH7sD+vAeF1Vxlm9fR+dgcpIWi1YI2RUZG11BndXl44oC0kmIh6K2pFbW9H4aH1Cbd8mao4MyfjNG20UR1yJgalPIIErnLipSreUg0GN/A/owLlT2b5FTow8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406669; c=relaxed/simple;
	bh=0OtKg5DKlO7t3OWN1Wy3w9oYfi+PgVLMxuusAnfiK/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYqTdBcsBbAPdrZoa13nHjvjlXLkTGKpehnvf/U/ukRqbj3xSr7ykiJpI8uGII9NG9JIO+BVNSUCPNU4TkSEznfZUlphyBYh8yJURcJ6t1CIne533+pSxPLrETTHa0pvKTJxRcKIAldR+iPo+LUGkQDhow77l9mrXPoP/kgsmXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e4b4AJyu; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e4b4AJyu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJmV27eMinuMmUxfbuVIowZ5RmIzojb4pCUG1AsU4adN3p/lHytuvLwlloPx7sNeyUldb5ShYE+Emv3PmwJrj8ki9QUzJ1ZRCBnpbLMMiEVHAmfdwcV7ZP1rcl+jHTCp+Zun3mUPbK0O0zZMsJAzli9+zQp0HA2tWMt50W4ahLaxAeVpC4DadErAl1jn7S67GbjBzcnB1YqDNUV8m/bk5x0jkDP8eDwkBnA206Rm9/bBrEonpKcM2HWKi1LOG5W0Dkxc5ju89y41+B3QCDKgc/PfOEGBoFGHQD2tZgE2Zti33orT1WZN/2/R3mLRd8/V6fJs2Zems+IGqgQbuwcSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71Oc2hhYsm9KaBoSaO5F1WB5GtRf+S3tqkjaXkhnF4Y=;
 b=BJNEn8+VS+ddLXsIFWAa2C+pvc/3BDcHPxQWiOywZduAaKctXlTCEmatshvHDGD9EC2jUOST9vOI/A8Jxr5N2Cg4DMTqAXNzxGJy4nGjW4gtdxYfpEkeDRknRha9EHIHD4IcI+wwvB77Xf3bCPH4e4nAUgtf+TxyjqJLta/y46ZoODB6Fsco8CiRZlrFIzYCiQlFpjsugOt7o3anri7Mnj8XI/5OMNY4vrhAm4tnb719CxjKd6D974yzFaVexKp0kqE7FfHs8nIv4A4QSKPDSoZQ2HqSf66Qgz+xjZLUn1aS4MlK5jNvYIMgbRmwvsMeucX7fapvCLwL8oo3NA8h5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71Oc2hhYsm9KaBoSaO5F1WB5GtRf+S3tqkjaXkhnF4Y=;
 b=e4b4AJyuJUcHrYdDKkCPLAhLW7yCHmalg4gBbP8KymodhswOz78olgwyLWsJ+rx3Ib2nvpSrGakXhjKx0lC05b+b2GqUmtxSiQh29IUBZSwP6DFJ0ERwyEd8HUaVqKYSUvRZrAdhOLzEzccnwsjRh2H6DxbDeLmrsSfC2aBxWjcR3Qu90cubL/JYZ/B2M13/yWGkDuSGsJbtrAfd0DIctokYVveNkQrOh0A92XoNo7CC1dl4R6G6fDwQcLysssytqM61U8Xrv758P3xwF3TEug+wPGBppgsepVhUbmNXqpbamQrkaBWX0OuccidJiknzvlAD+iihvwOyteDDQqqMoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:41 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 6/8] doc/media: Add 'Unselect' method
Date: Wed, 31 Jul 2024 09:17:11 +0300
Message-Id: <20240731061713.435586-7-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f51bad-6263-4b20-31ef-08dcb1287b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czMpa33haMD+kGfZFXfNUEd+bgizTHrSe4DfJnKKbreNVvhGJopfd7VD+JPu?=
 =?us-ascii?Q?Hd3YizX7IVrckQrbfwGMICNkxNsHJsRZ0GPnIyheDgeGOddXzTr9jER4e1fA?=
 =?us-ascii?Q?Wa6zK4AO+2iqX2lTJKVecEhfkLUcRBAS1yZwZLSeRLZ1bV5ZwP6ayaLUo2L0?=
 =?us-ascii?Q?1AUgVYL26b+Uu0yLNe3rfX9ytllD+SfwbG3tStpJFyTlrb5WWMgq28qJ20OS?=
 =?us-ascii?Q?dkfeTuH7gNCJBjeBAdB3nINQxQJTu3XjIozLSiJn+HSswy//xj7WQpKFjVPF?=
 =?us-ascii?Q?IN3bKpEpJfNhBKM11ZlNrAvrm62rzj4UNBqHTRHCHayZ2KF9SgIOqW3fxvJ8?=
 =?us-ascii?Q?KcrppH5bfozXAX9oPGk8kSDrj+lrEnJppNyjbewz4lpL0zHihGL75VlkWDwb?=
 =?us-ascii?Q?ARTGkWhKMSryBV4d6nIayMcFUHkIBOR8jwBp1Eqe4GekTuZ4DbAQHUoj2Jd1?=
 =?us-ascii?Q?qSnl07xzEkXL4Tav+4XEhAYPNpn/aHh5GhRqvj1kTteXfwXXszT15Kv/M8S9?=
 =?us-ascii?Q?kUPiFh9s1kVTrzvCitx3x59vzFhCKGmu/1Zhl3+tDBR3pNWDP14FRbmMdNot?=
 =?us-ascii?Q?/AvB70AVH0smvnYPrfsX+sjIPphKOG1Xn6tXQDr3mGGpLetBxjOghBdCGmaP?=
 =?us-ascii?Q?XUNmy2HtXBvomJGpOgN6EWFF8k2B2nkPL0f0X/SI1XU/5RP9RJw3NlUx8oci?=
 =?us-ascii?Q?z3cTP6ust8pLJkazxDVGySSN15XWrQaLz9j3jnXFarpB65WQp3efVEC7oZ6w?=
 =?us-ascii?Q?i02Tp7VyxmjWsa2o7WJUDZiurMfF3PO5pSIPzNecaNZcHc8LIVPsUNCXgfGf?=
 =?us-ascii?Q?gAtcjgp3qtleHBQBJnwm3aGt1nIqCRbEuuGBzcBHEmYN2fuW78FHBdOup/L4?=
 =?us-ascii?Q?2CknUwPDJoU466O2QmC3gVyMO6/6NH3lEUuDWovEZnmRMOTR7Mv55fsq37PW?=
 =?us-ascii?Q?dmEnp4HRwz7tHWxnUakP5BLaBZshgXWUZ+nx1RbV0F5BmdXLC6fVF2Z2jW6O?=
 =?us-ascii?Q?OiZMUgoPKxFSU10OTKIpFEst3tCkDpBDcBmJCf8x/44DS62H8PlobnQz+65U?=
 =?us-ascii?Q?kSLPp+CK5YUN+2Xx2zb+KZixvLiUSKu/Oe5xxuhWlx/j8nciSd4SEmgORyuL?=
 =?us-ascii?Q?FVmnTcKorFu33Q65ChQtXl6+xoxg/8SDyXXx8vC8OZ9fk7dXwxRSMLxK+RHv?=
 =?us-ascii?Q?emZ4v+L3hm6WnvBrmJ/R1ieG6Adjna2MTwDLtVWZ56y2mRbmBr5IB72aVHlO?=
 =?us-ascii?Q?33PzOMJGKj+H7fN8Yl6TvdcWi6eIWmL9Bpjo6++/M7e0zhEeF5tqELz9O3yK?=
 =?us-ascii?Q?gWeMys6qN6sSTbsfLYPzXLNoI7mcAzLWU2IkFz0Ck6/XHojW+x01wM4ScUGb?=
 =?us-ascii?Q?nnUnTw6LoYMS8E2AW+Zp/N2fIBDWYFUeHSGGMSoTdS5SHTmasw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/lxMlwZfbeUS6Ay3HrEm24fvFhQCHJ+4Xc/Ko0nn2lmVT3P0gnKxZ8iX4jKz?=
 =?us-ascii?Q?QT60xZIjunxkzBI7PlqYXSiBBIZ5Qxd+WeIeBJZPSRPxFLKuWLb/pdVmjkOH?=
 =?us-ascii?Q?9laiY9PMz6bnbk4GxJqS1SnuweBB3MPvjZojmadPX5LJ/EB/rWrna/HbR8nv?=
 =?us-ascii?Q?rPE7XJDhnr3m/ltpcVCflY218THGNfAFVay0ZB9oSdAOhEG397/Fp7/Ls/iZ?=
 =?us-ascii?Q?iHz0N1vnUOlfTJO/xlZfp+tY/Byt96x1V7+aFd6Upo/tBBaZoRCW/lNjtlNj?=
 =?us-ascii?Q?FlwkIFD3ZtQOfhXJMD95H8686HNOrpvLracbW3imiFHr1cSaUBrZ79xe5ehb?=
 =?us-ascii?Q?UXc5kq2S4ZiI5Z8X3eeGJ3EKcawTMwk9Bi8AckhyCffTUIUjF7HyZsYHgYyy?=
 =?us-ascii?Q?m+Or/J5Nd8LhHii5i2WAZ6VrTI6KSz/I/S1PcddR250dvST7I0MB2/2xVk5t?=
 =?us-ascii?Q?lR7EIRe8oV9qr4mqcPOPo4qORgdu4LUU6IaoHyUN1qLAh5ViabhuTVYWA9Ms?=
 =?us-ascii?Q?Q8LQy8NO2EdN6YL+IG2rtfTEK46hoE7YOIADo0G2o1A+X8/vL2T9ekNEkIpE?=
 =?us-ascii?Q?OrXW11vBVFZjjNTgSMFY8eed/5oKsMVop5crRK1XYiV0LkmXnIGmW0LXnyf5?=
 =?us-ascii?Q?U3nqrDXCBvs23mzW1m+x0PsUgMPEpLD1/DtIRwi4g0YMHQ2owNtA8q4OEaSd?=
 =?us-ascii?Q?iMFw0+SJoLtc9Abh3ypyyY+VYIpZKA2/nVpsixi/I6avrC8qTWbnk40cJvDq?=
 =?us-ascii?Q?ntBGgL3D8/dOj3Q06I6fbxmmrCEe/cssxLFZy4bnhJBFGBSvqDzl7djyeafM?=
 =?us-ascii?Q?PeeLjD6A2/bBiFtKgliPl661/a/dYEq+MHLzcUPAvRx0VvlOAQqL2mskWSzt?=
 =?us-ascii?Q?aAjbwg6ZV72otWoMB2A9XWNxlvnbTQ4T684JXdK2Fuc2n+MPfR/zY4Fd6d1N?=
 =?us-ascii?Q?2NV7c5KtINLsPGstGN1FmCc7wyOPJCdMhVLHqN24KYbwGRQJYCgyURwF6qmR?=
 =?us-ascii?Q?Lt/mrDDY6PnfQQ929mLW+OJZAI8SSReYg03FceHwYoDc2LvieCzhar+MwsQI?=
 =?us-ascii?Q?AHnWi4kaOpR5EHoqnLWbMDESakNlE6N1xUjGFkfYUOrVPcspYWRFxZzl9C3q?=
 =?us-ascii?Q?Wiy57wnecBS+nUz45vzxtL3M+7n7pD9bbX86j+Tpc3grgIVuxKkrB8pr1NXo?=
 =?us-ascii?Q?8pK11+9rycxRk3F1coO5trT9Yy2d+wph0YLh6ngKCMRaYW8eJgN1IjTIWXgF?=
 =?us-ascii?Q?JdpcCbUfQCVIYE7ri/+V/0HkZPRuULkHTKdeQ8BHVQpNLcbUzB0l0GJE7N65?=
 =?us-ascii?Q?a6FMgl19zVvMwjHRCfA1oC9IwKleNOOb/3pl/lUAQYbBbr6M2VxDkQ2kA5eg?=
 =?us-ascii?Q?mVnQXQpfQyCfZE6+5UZC3N4CnAct4xDqreFYUBbumcNygcUlhWB49It3JjOX?=
 =?us-ascii?Q?ky3dbriCtL++isbAU6F4JmGEhDBSrKskyfHxoEqvYWtEXKiGQ944d5rBrhxa?=
 =?us-ascii?Q?3r6TXVztZs49Y+y8V+0Iui+yMXSmNsiCq+OX/8RPBKtucGg0ijN5L5Bx5q/Q?=
 =?us-ascii?Q?pGX1hphXj95yNsOdk7xlponkxrAGrb6dkP6dUMey?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f51bad-6263-4b20-31ef-08dcb1287b8d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:41.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBjualMP531RbZanESM9NCCeR4g8aL9pIuQ3axNa/q0f4xO3jiNQbpDyhFotmR9/VYzM25ZcsWR77COgYP/zLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This adds the documentation for a new method, exclusive to transports
created by the Broadcast Sink. It would allow the user to terminate the
sync to a BIS, via a 2 step process. The first step is the call to this
method, which changes the transport's state to idle, with the second step
being done by the audio server which detects this change and releases
the transport.
---
 doc/org.bluez.MediaTransport.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index c8aca0223..eb3e04ae2 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -57,7 +57,7 @@ void Select()
 	Applicable only for transports created by a broadcast sink. This moves
 	the transport from 'idle' to 'broadcasting'. This allows the user to
 	select which BISes he wishes to sync to via a 2 step process:
-	1) the user calls this method, changing the transport's state to idle
+	1) the user calls the method, changing the transport's state to broadcasting
 	2) the audio server detects that the transport is in the 'broadcasting'
 	state and automatically acquires it
 
@@ -65,6 +65,19 @@ void Select()
 
 	:org.bluez.Error.NotAuthorized:
 
+void Unselect()
+```````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'broadcasting' or 'active' to 'idle'. This allows the
+	user to terminate the sync to a BIS to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects this event and releases the transport
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
-- 
2.40.1

