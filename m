Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409F38DD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667121; cv=fail; b=oPmf3Ahfl3ttnCrD0KsJXxBv5W2mhzD0nK3T+zHdtLhLgFfDRiek++ZumzXj2jFH5EGRZVL9DrIEB8QYHxVpMaROapRmOEgQaJKzEogcxkGN+gV6X8Zq6pijJPNdBCxGhPglbZ5rKBjktzvrZ8WMOan1rirqOQkdjedKl8kUH8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667121; c=relaxed/simple;
	bh=m28VM6DA+DilLnVF6Lk6E9AEeQHfliCXjOU7SrY7JEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jD4u+Iusp5WIQLQg5iUjhM/+vxYVHBb0y2bxDRXAfTtFLJLMUv0qOheH6UJM22W3UxC9ZIxQa0PYTjYiab38zGk04mk0UnuFOMMTqpjwhpQvVtgp8gGblfv3G/4S6X0A5pkd3BJodIgzhhYKyXd9bQxieADlKlFE6cycXWwfs3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/POaCuj; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/POaCuj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qtb2yEP8tRI5FWMcHITaThdoLOPZ5rX+Z9aGFkjtAYhBOyEjPHpazzWdZRp0DfCrthK8EnKz1iW7tHepJpQi6kF3tfdZwstAR+Pr8KwHb1uJCzy8X2iLBsrQZTIVfeiqnFkdTmoJRhlMjw2UOXl6mcGexRYXQ9pk2IUDoOY2c7OkwAPdnLxNyMv5quQlvDF2DAbHEq0wKE4rzUUboqowv2XzGzlgNAQl+R2bQFZ2CSmQSPtN6C46OqW7rZbCZTS7K9laX2BWq7w1Oi64vjbPadWg8lkLOURNGq/EbDOn/q7bRCdEKm62nmsO+gjY4ZmXbZzaWdDQQ6L7l8bKigEzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e6yq9wTQl0b4bwm84/QNH7vvqpqKKqo/ggy/t5EbRA=;
 b=nZJBKj9JPvWVUYd7wm/VXV3LWSLBtEvPq5AcYFR05Uky7jN1mWGC9SIZ9XYNMs6I8G9fDKcPBxX5Nwq8e50xfdob64FyeLeBgMBJ0XStRNpLFM2pUlYzdodOGD6dbcKNfZCjsN7NqswiHZMgHZCIeeyQFDTFWJ8joJVQHFmP5xcygMD+GqEER4mMfZcCCEpNspKrIoKrcQxuOkQAFOSrKLBMTWu95KanKlMazJD4n4r+Aqpkc3v9RG1EJ/Z/eosDQ3p58wTYbpLm3zpM0wBloQ+d80OdIeR4YPu1VRRTE7NXS5+IU167LvrsI+g0S/w9RdjTZNT0QVirzV/VLWlp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e6yq9wTQl0b4bwm84/QNH7vvqpqKKqo/ggy/t5EbRA=;
 b=c/POaCujHMUrm2CLPgWyJ9yJGqjeFiw08n5THF0n8Imv03g8wOLTcZhejDe7e06MzchvyqLz/VNyEFZcw8ON6VVfbJyH2M0g8gDbJv8POAtTo82s78JyQ6KJ/TmRSuozYvGxV3IaFD9Dd8H0H1AtLSzDBgSsg2xJmCTVdvOk477ybJRiRTMYFPxmA1JGYOY/93kWqNBYi1dCXRWJ41H7LV/JF2d0fYQMfCd4f6zuHu7doVbF4zPDd5Y3i1ZWKvn6F/ugv0OcBK4pfzfkFc76KXReVc57M1kvHumSUMoe/FbjljO5gnYJoKqgEd6YpIACP5DCTscWgJtA3Dv121xPGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:38:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/6] bap: Rework parse_base
Date: Fri, 15 Nov 2024 12:38:19 +0200
Message-ID: <20241115103825.19761-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0181.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f013da-519c-4546-6d0e-08dd0561a917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?90IlWOk+6wnhVZE/2cmiiYpmZzVezxdJP30nJmeYheEHtnEkWI7M7kGCrYiR?=
 =?us-ascii?Q?0762GJRvrIUKLKhLhroKN3Qa32XPfivVR4ejQz+Szh2RzlE/ZeYyqrPdjicn?=
 =?us-ascii?Q?KRJHOCJ+OacJyvgO3kR2bGgKHqKlBEWHuyAl1XoDiebeykqmX91eV6/gDk+e?=
 =?us-ascii?Q?+3IVbERCfOc2XBrFgRW965qr/S3WyGupp0X280JqKcfjASLL9qHQP7p8Zwc9?=
 =?us-ascii?Q?XYBRDMOa53zUC9UwRXY25TE8BElHhaqUfvZsZisTD6OQNUwomYPwwezfyWLD?=
 =?us-ascii?Q?hnMuUDJvO88kWWtT6HvnxewFchbX8tVIyKO76Jh8W3nTDn+4GGWDehYepZZo?=
 =?us-ascii?Q?Ih+d/kjMGUCACbEVzB3J/2fld7aC9/CxQU1lmAjYwI2tscc+mvETM/Ht1+r5?=
 =?us-ascii?Q?WU7lzYcfJCfPwUN6Pz/fVN/76tF6nLBWKNDPi1OgHoXGkbKA7GdmgvbfUMKR?=
 =?us-ascii?Q?3LEG3NeUXqyzGfq4g1A/JYJhhG0wLRcWLtQXMuWECDWWrXBZTHKCEVZi6LKh?=
 =?us-ascii?Q?SBPXh9c7YbnQhb3pOWkgpTZ7bZStxY+UQ+D8xSX297xQc/z5O+8m9LhVZyr3?=
 =?us-ascii?Q?sjPswVaCWeHEEV0uVlXN9S+vz4j5THWOaR5N018qTUROCmfhV7BkjPbxNaOc?=
 =?us-ascii?Q?LPRdA2NBgpGKdwP/FHS3zV/P2hPl52T29XVe6PwyPsih/QxajRzF94iIluIO?=
 =?us-ascii?Q?zB8ybRlx3IO2CgC6u+nGaPDtUtlvplfkT1/8R7zGix1Wt64YnZGVMwi6Kf3B?=
 =?us-ascii?Q?yI31ogpgefeUkPLwAWjQnBXfwhtjSPutDTWdQeCGFxuyIcRNgsSWRV8fQ425?=
 =?us-ascii?Q?77Uwlue6Z9l7imJ0LAUMeJnUnwYKIBRNSrktyEc02c5bmPMKCgA8eIC+tBqQ?=
 =?us-ascii?Q?YNzZJVD+LE/HNFCJBi2sFEbGqgZyEqM6hrvtxyackVvVmenl0/3GL4xoACxh?=
 =?us-ascii?Q?UmDqaDuHyU6FwFlpodne7HksdGHPSioeRZpKYnbHIynOZaF5p2oCXtA2ZpmH?=
 =?us-ascii?Q?zt/MrjGXGsRI7yTjy1lJ19whwoBHxNHVGjCNzDBmbH0iAteCeot+d7NJkmRO?=
 =?us-ascii?Q?PJzX5TEpZ1kLDiQmOvnFtWpHCSRPlcUhutje/jMyrZmLnsV1PYfRg021+Ivp?=
 =?us-ascii?Q?CmcHTh7HeBdE282mgWt2ZvlJh2Ti5tIt7NPLtBh47gM6acdZn452ANoVTvqR?=
 =?us-ascii?Q?JZd7X1wdLDxKJjvYsTza5pTHn9jjh6NJ3pLvSOUAcAzd+IactrJ2OvhQayaO?=
 =?us-ascii?Q?2ZQ6ZY2sdq+j/J+vOIuOCa/FqmLevZbpybKFdidF+amHL4upJ8FAFFsA4wbf?=
 =?us-ascii?Q?gBr+owc2wMJJdx3UjN6sq2td?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x1LFwky0jrWUmY/vS6qbuFVc6JCtzZuVIFs8yWeCJRz1P7kLWuCiT38fvtWE?=
 =?us-ascii?Q?jUIQpK572qkRGEougaCu8GCcv0BpHRQOoTd4Nr/rxyH7TE2EQ1k0RDyfWtln?=
 =?us-ascii?Q?qcsjECk4WSj0B2CXBT2g/3pouqdWTgw0gBWXyUJ5BjG9BRybWp2fSm6aZUAY?=
 =?us-ascii?Q?9+Nwkw4ALcHeFKCmrVMJTiUgfdRqYbwvcU9unPDIG52AjyObwnA7npX5WJfW?=
 =?us-ascii?Q?MS/RrMOXqdS9knbUwcgt5xgwdfrieUfYeSLC176Imici3gucv9Nya6Ak8suK?=
 =?us-ascii?Q?0tHBUYvqNucnu86S9cQZl20CsJOGfJ0urfHFE9AJv/93YwFB4fW2zL6pfAGV?=
 =?us-ascii?Q?BV8rsIFgZvzxQNfRXXsSWZ8WvRapaNSlCaJbLaL8iGuNWU9vKuIiyOJ2BoS/?=
 =?us-ascii?Q?Om4w9bnbUFgcqnXZJT/KVB0zsmpqTS+OtpQ+yNYIC4uhqTps8iJBxFxlL6xa?=
 =?us-ascii?Q?4e0rHmAOra/jVNsTMxElvpoEt642+ltIDdeTDQUEifhJDOJDSMqPm8ZqWaeP?=
 =?us-ascii?Q?/uPMdhuCRYEJRrtAWU/n/1AJBu7JSyLil3u9kUuxithHhjh2M6yVMnTd3IXx?=
 =?us-ascii?Q?Wpabkj12PrGvR9vIlnObKpqnlXdEV74ZeJ6ZBVSUpm/WVldGfYdmFOdLgcqH?=
 =?us-ascii?Q?XmnmgTbZuhmXZc7bKEh997nO3nVARsEBwg5O0fmtM3ytCMoRMT3UIq/qbXtB?=
 =?us-ascii?Q?xVNUJfOxS6V9vzyiEE/4I/7tHG0W6q7afVQTx+NAZAxIrfU0nlgdjwoA2vTf?=
 =?us-ascii?Q?aS0bc9nBgJsMec6zffbhiTKkpPw2TDmwMjKusfilT0Py6q6QA1irhAuaPHOu?=
 =?us-ascii?Q?WxwWirP5hrzmFuJqyvpxXEv9+a7g9MJ08pqEvsWmwi5bEibW2ykCZoJJBouB?=
 =?us-ascii?Q?R+VE/gxXPqwf9ugvyEIKxUdM7t2slKGiAwznperr2opi0ua2VDvfWZ165Y1b?=
 =?us-ascii?Q?LIY7KJqgFJNhNms70SXcCu5qNNUgg6mzW3XMBsiZ0bMmiqD8aSEuA999DThl?=
 =?us-ascii?Q?zLS9sPJdzIOgLxoR7YwSxCOuW8l+N2yw7ylDVephzNd9b6hQ1RFVDDxPIvKR?=
 =?us-ascii?Q?QSLS/5HfIoVgytvCfpT/OX0thAocZ18lxx7H/J+QxWWlj2YzzZf/aySv3l74?=
 =?us-ascii?Q?3vzy//5ewHIRbwz+YtB15kiawNfEQ5ZIVauiiOuSwrgRqoigttZNxIGlpLEA?=
 =?us-ascii?Q?fTir3X6qVmoYYQxTYdhkvnc/0kS2Ipnhyt/lSfKi4RosNuNXMQ74MXvjHAx1?=
 =?us-ascii?Q?tQGuncXfOkeq2bx9rEqm2UehPLNmPqfyxbZF8NvY4LV+yAOyTZeS8dbiZ657?=
 =?us-ascii?Q?c1/NvZnFB5toOoxmwXxusDY6rBfHBHP7NL90lk+ssnISXAVoIkoexFjSRYv7?=
 =?us-ascii?Q?CINOWZEhpb05i7xBTwfs7ySo44Kr1bGkQCAGg/e3NSHys2f3s+JEYfyzYTGj?=
 =?us-ascii?Q?NB44RrcNbbfBUt8jmzdFAWhmhGGPIRTMbC8+LOcMHIKWoSKobMba5Kb6xQT5?=
 =?us-ascii?Q?uEnrTvGrGKmcO59sV9qlgzkTGOQzJ3Gp4iDHdX7lxmKMXQDylUNEj+dbfw8A?=
 =?us-ascii?Q?xWi/Sgfw2W+ERhSQ3f1CTJl5KS/kQa6nw3iigTDlfJhE/DYOiuKgg9H/nQ5i?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f013da-519c-4546-6d0e-08dd0561a917
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:36.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scBuPT8umGHTS39Uahb/yGi91M2Up6V8PGRewNsOvWe276v4waNADpqC29qLF7i9LFCSzf3qHIA6pUpIEwmtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

This makes BAP parse_base public, so other plugins can reuse the logic
(BASS should also parse BASE internally for the Scan Delegator
implementation).

Since different plugins need to handle BISes differently, this commit
also reworks parse_base to receive a BIS handler callback which will be
called for each parsed BIS.
---
 profiles/audio/bap.c | 78 +++++++++++++++++++++++---------------------
 profiles/audio/bap.h |  8 +++++
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index df685c6d3..98b28f15a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1086,8 +1086,42 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 			NULL, NULL);
 }
 
-static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
-		struct bt_iso_qos *qos, util_debug_func_t func)
+static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_iso_qos *qos, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bt_bap_pac *lpac;
+	char *path;
+
+	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
+
+	if (!bass_check_bis(data->device, bis))
+		/* If this Broadcast Sink is acting as a Scan
+		 * Delegator, only attempt to create streams
+		 * for the BISes required by the peer Broadcast
+		 * Assistant.
+		 */
+		return;
+
+	/* Check if this BIS matches any local PAC */
+	bt_bap_verify_bis(data->bap, bis,
+			caps, &lpac);
+
+	if (!lpac)
+		return;
+
+	if (asprintf(&path, "%s/bis%d",
+			device_get_path(data->device),
+			bis) < 0)
+		return;
+
+	create_stream_for_bis(data, lpac, qos,
+			caps, meta, path);
+}
+
+bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
+		util_debug_func_t func, bap_stream_cb_t handler,
+		void *user_data)
 {
 	struct iovec iov = {
 		.iov_base = base->base,
@@ -1167,9 +1201,6 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 			uint8_t bis_index;
 			struct iovec *l3_caps;
 			struct iovec *merged_caps;
-			struct bt_bap_pac *matched_lpac;
-			char *path;
-			int err;
 
 			if (!util_iov_pull_u8(&iov, &bis_index)) {
 				ret = false;
@@ -1177,18 +1208,12 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 			}
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
-			err = asprintf(&path, "%s/bis%d",
-					device_get_path(bap_data->device),
-					bis_index);
-			if (err < 0)
-				continue;
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
 			if (!util_iov_pull_u8(&iov,
 						(void *)&l3_caps->iov_len)) {
 				free(l3_caps);
-				free(path);
 				ret = false;
 				goto group_fail;
 			}
@@ -1206,34 +1231,11 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 					func);
 
 			merged_caps = bt_bap_merge_caps(l2_caps, l3_caps);
-			if (!merged_caps) {
-				free(path);
+			if (!merged_caps)
 				continue;
-			}
-
-			bass_add_stream(bap_data->device, meta, merged_caps,
-						qos, idx, bis_index);
-
-			if (!bass_check_bis(bap_data->device, bis_index)) {
-				/* If this Broadcast Sink is acting as a Scan
-				 * Delegator, only attempt to create streams
-				 * for the BISes required by the peer Broadcast
-				 * Assistant.
-				 */
-				continue;
-			}
-
-			/* Check if this BIS matches any local PAC */
-			bt_bap_verify_bis(bap_data->bap, bis_index,
-					merged_caps, &matched_lpac);
-
-			if (matched_lpac == NULL) {
-				free(path);
-				continue;
-			}
 
-			create_stream_for_bis(bap_data, matched_lpac, qos,
-					merged_caps, meta, path);
+			handler(bis_index, idx, merged_caps, meta,
+							qos, user_data);
 		}
 
 group_fail:
@@ -1299,7 +1301,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data, &base, &qos, bap_debug);
+	parse_base(&base, &qos, bap_debug, bis_handler, data);
 
 	service_set_connecting(req->data.service);
 
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index cfe633311..cf2593db8 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -7,5 +7,13 @@
  *
  */
 
+typedef void (*bap_stream_cb_t)(uint8_t bis, uint8_t sgrp,
+		struct iovec *caps, struct iovec *meta,
+		struct bt_iso_qos *qos, void *user_data);
+
 struct bt_bap *bap_get_session(struct btd_device *device);
 void bap_scan_delegator_probe(struct btd_device *device);
+
+bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
+		util_debug_func_t func, bap_stream_cb_t handler,
+		void *user_data);
-- 
2.43.0

