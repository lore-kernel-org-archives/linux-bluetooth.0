Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C96298CC4
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083416; cv=fail; b=VDpF/ZJgn5Za96FDoUaHrWVniDyhmAjSBODVMwrSGvAFn+b+BVxRbPX9taDAu8f98CVre7DVvF04oZJ47ThSJiqI4m4AzNjoO6qQrKfMYUhON0mYH3XlQ+hn5w9Bayso4qmkAwqip0uExJnsbQnZDZmrIcOXmKRzhiakmhcP/ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083416; c=relaxed/simple;
	bh=/Xgwc48cWWFdIE/+t0DFraxtWSuTAqYq8kUVfUDMTqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHLV+tbc4zwEw4ThpmS6zfq/eaIvBeaRzdyxnCzL5p56MLzUkNFAd0Ewufi1Vvo1IhgO9//Z8V/0yQZiAJs/FwOWLTqylzIdnVF19nJtyx4Fbxx5/NVfmLGDuwthmHHWxs15rwYnx+OkaYCiealea6MpbpzuLjWov/uOnL+4a34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahmFcCq1; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahmFcCq1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF1Bfagl2rTxQDdl9oCb9d0qJmedPgJfLdWLI9PZ/al7DD+ztPuSiFbC9BZn6E+fQHyKy96G9Yty/6Oxo0ZGg4sgNWyiqyUrFmypqIOyT+ne2tlnSgqHn2jMxPZcs1iNjEUNluB4DhnWoL2XmDLYRQVekX5V38D0ncVC3jOoYlTuXE8OLB63bnjPbSYjGmgg+aksNbbm+BBO65qAA3nMA9dTI/xrnXHggtruk9VukIbFZbSHcWB7pVbKLRFDreo0Si5FvgA3rdlBmw+ZDX+2VQhdrlB+CnBUElVBFU1A4qISQUD/xSumYj58+1ZGd8t4zilPTdvonhbC0ZftAa0QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfJBrD4X1sO6wCglsnMcBftRQ8eI+k1lNqKjaVWioLQ=;
 b=ZgYgXT9A2VOx4bsTsY0aTJoXMtoIYIJ9w2rSNxK+zZwEHfcdwCaEsnqQM3CF+ohaGd9h3QFTJKXgL6Zp/og9mNLWFFvIybeZYRc2FxwjyKZ2OsGUh2GWlMVibQPoEyhczm5yPJlh+EaQI0CD8qOVfPOdxcfdggav40d82csvqr++9m6gHzcipk+c3s+ogUT72gyAU5ZI+9vTMDevGBm4D4NOUMPqoQtk+4LZg/CX7UmRxABrCi8dE3keczP1h7rVxpVVvWYESrSeOKmDNJ81BYlwiPlDJxgcXAh83ve9ZpmaFuYhYXWxL3uxS3LqWZDdsxhjlbHeQNwJb6qonaEgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfJBrD4X1sO6wCglsnMcBftRQ8eI+k1lNqKjaVWioLQ=;
 b=ahmFcCq1AijUgpuSqIzUff8738aPXFzxBuCUtmE5TPUapuQUsYVs50ipw/acQ7mUkSZZ5cg4uF/JuCD21D4kU0HB0Xm2PLQU1jGTPa0ToOe0Yotl97AZPvrswF2ImPqfw97uWBt9uvMl3qb4+MZSu3aYPgTIbn+iY61peNYeGRp/5IMg8xZiHQjonBh+UylGfRX+JgO7vXu7P0t4hrXqSVAZDJtVcTEX18/XzFvjFyfXRwb1ONMHUYyRlX+U9RTOvJArp5PYHQdZD7D+6UJkrgWxsXTLqIx8EA3HVWkZE6Ml9kNgYRopxr6QIp4+6d977mhxntO7hChri8krli6ekA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by AM0PR04MB6898.eurprd04.prod.outlook.com
 (2603:10a6:208:185::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 14 Feb
 2026 15:36:52 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 15:36:52 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 1/1] bap: Fix use-after-free in broadcast sink cleanup
Date: Sat, 14 Feb 2026 21:06:15 +0530
Message-ID: <20260214153616.655-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260214153616.655-1-sarveshwar.bajaj@nxp.com>
References: <20260214153616.655-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|AM0PR04MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a13963-498d-473c-013b-08de6bdee074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUQCZb7ZTTdU8AqYULZuTpCb082KQN0TM/AMGfTNQV7khyjO4ZxwHNt2/Z4c?=
 =?us-ascii?Q?7F6phF5y1WofpHLhHpjL3jc1W6pQ7E5jdgyIrUQFs3Orr/gafNPo33AbI7Ru?=
 =?us-ascii?Q?y0TIcGCL+5FXy947icPE5GleZMVDTwXbkU4luashQ3sHk6TDH9MGis5y5WNT?=
 =?us-ascii?Q?/j0hVce+6ULTdpqX1cbh1PlT8zTogzorHQeAEQS6frsQuAFW91VQ8z+9R2rl?=
 =?us-ascii?Q?gNMzRTcZCgSgclVrejZbA+L2uZnsINbMplyTutCcin/a8VljQLZNNwKIeGto?=
 =?us-ascii?Q?cD8XtNb6W5TbOzGspr/L4EYbp/qqhW5xrOCH9YvlkV57sROAwtdZYXggwcmU?=
 =?us-ascii?Q?aLXR1ig/eZROvpVg4TWubhV4cTQNh6KpqgDy03E0i2uIHGJIIvwZVS0ihILr?=
 =?us-ascii?Q?fuHn0B9WIbGgFeSxy6ksfgaBFfRRBDeX9MsdV/314ACgtDBMJFCfIflJbZq+?=
 =?us-ascii?Q?0xI1uwm8lkE+MJfL3HtoxYifIMlWcsDXBhfcxc7uxFV/NIFY+d1abcD8Lm6i?=
 =?us-ascii?Q?1bfpi3LC84fvGjLImT4JP06mfloZwoThPuKEF6s16sMEnU/g63mNaRuWHHhQ?=
 =?us-ascii?Q?0X1Pz1KNM2x1s9wAznzsPKozi7336q6m301jt+SkwwJCzGJDpkAxpVhZqiHa?=
 =?us-ascii?Q?x228hfpbPeTGrcbi8hTi0E61UIt0dwNX75/hVBQA0z4DM9YN9NQkZpiOrXrs?=
 =?us-ascii?Q?gncsIJ/49KDcOZc5BcA6ZBuremiiT2BoYLN57KfXodxeWapNGUr2qwYddIdG?=
 =?us-ascii?Q?ivUwbFpHL/Aad6BL/UJU8tHy/gr1dZW7X11CGcVUTFY6KPgZs4Jcw3goGQBC?=
 =?us-ascii?Q?fPwskJiWyaGm6hcSDdVmTgZcwBZJQPRkKc0hOvNJ34lDkIabzOeTnQ6bmBSf?=
 =?us-ascii?Q?4k0twBDX5Ys0/kIlr/5M64cdinhk7i6B6dXqJudyWf+W+TnPmyBw6x5uAUAG?=
 =?us-ascii?Q?fuogKCzTenTJ3U+FEOAG0/0rbgb5lFG47DsYcpUOxGMdOwotVhNXWkz7NGor?=
 =?us-ascii?Q?GE+1cuAO5Pf9WOZplCkamKr7FWQjJw/EvtE60UR/Qgw4ITeM/OV8MX79KHp0?=
 =?us-ascii?Q?SmbklFdahZ38MW4WGcV8guETAqBMnzeN5NkZwJVx5vgzLYhYB3UpZZ5SmDqB?=
 =?us-ascii?Q?0ED+L6KfcQo5PDi9y3zT4K+ThseWn6/hrjb4jhYn/k+l4kCdgL32gLqtlAY7?=
 =?us-ascii?Q?3fq5ypI6ZW8CHPrvsnTwKYMcq6kdA+S4yoscqQPTkLmjU142qtUxyGTDkWAC?=
 =?us-ascii?Q?0yvctVbtbg1qGIYye2rHPQYFJFn3C+Y9yHLOstCrLJSBZ5QoZyft9RV0Tdtr?=
 =?us-ascii?Q?2LEtlOv4JWHBC9KmnrMGRYoPYdJCe4NnEfGeWCFVlZbrBiwha+pYwxoqA76E?=
 =?us-ascii?Q?D8RFx0uDJeGRKgl17rqlo9o/D9m557vNPHslD0oWkxw5s1PQ3qmvbQs5VIoH?=
 =?us-ascii?Q?Lf68lJvouTowV41M78vkygGzZ5+Dow4p1MkXLFVFbwUAqH3MHyffX2Rn5tWJ?=
 =?us-ascii?Q?NZYL12sK7+Ter7iEXUaV15fsvbmMNZfzIjxqWeTHtxKEI5Ni40rO/Ou8ekuv?=
 =?us-ascii?Q?PpMSh8r4wEIQ1ijhbc62HxWoE5wvZ03BxE+Jrs8In+w3zGgDKR2RgH5OYdR8?=
 =?us-ascii?Q?ibB5vTwI1UFFhbvROebgn+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StMnY5zGjhN2tR9/4MJoK2Jl+vf0imx7PiwyUIsotQNXNl7ov0ZdmdH5i+Rz?=
 =?us-ascii?Q?py2sse+jCr0Qk4vnusjK3F9LY2BASmQ0y4SgzbmkIbvugMctWR9ps9OE1+3A?=
 =?us-ascii?Q?sUDKJSLWyHzbKRxfhOtg9JKAZcCFLWAn9Ok1hJQZ6pa0IDd5tknAiPpcj0rZ?=
 =?us-ascii?Q?Qx5hGeeAUBWkqmChvIb5CyX9iXM6R4F3yhGvr7LlhnmpD2AosoDhbP+TFW2E?=
 =?us-ascii?Q?vC7ynM2DNfBRMV6AD9AfG7ns1klHVOD8HoJFA20T6XvMJ1p/biTaDHqyvM4Z?=
 =?us-ascii?Q?lMDHDkzSdzijJ/yLCn/cAadkctJSkS6sxx6uw43K1RkgI4F70YVVpqP2cUvk?=
 =?us-ascii?Q?9GYm79rvhITZOVU9X/v94X0RZFbCwxihN/KaWUA1l/zDl7y038VHPALrl1GH?=
 =?us-ascii?Q?4EpfO0vzhcnJS12OA8XtXnsidW7L5P8jv5MzBSje+lN/GLkdTUzDu+9UEQ2N?=
 =?us-ascii?Q?zILXiw/P4BowgwwdKb8yV7lbYJugouTL+5j8xQqVhg3i5LIvF2vh/ssyzvdb?=
 =?us-ascii?Q?+rjomYGjisAe+NbWDCznldfuQA94UaadmyeA06T1NHdpxtgc18YBirYpnJD5?=
 =?us-ascii?Q?II6tp7BxICY4oSDTUDvE9xYmEoApm036A43tkWagn1a62+iEvTqkzTEAz/Dt?=
 =?us-ascii?Q?K9uBDpJujPqD8DKIg21iK9npg+Zjnez5ZNVjuG4F3uaDNl3yKOAi0oIISc6L?=
 =?us-ascii?Q?M8h2is+c8IaLsU4Qp8pPp538vHJuvwzhMVLKa1n40MG4pLL3SDUdimvYBFFC?=
 =?us-ascii?Q?O/Kn1/sFX5re9XeoLGuMlCm+Qts4eunG45ZSeR4XE61gUjTI9sWib9ssnp6S?=
 =?us-ascii?Q?dI7XiA4as37atdjCdcqOzEdI1A231K5R0l34sBb4Zbege3CDbnor2KkIV3Kz?=
 =?us-ascii?Q?01otDHOf+4RqsRg3iJMXVKiw7Y/k2N1sJZWe5RbbEbZBogxUEW5tIsg7rqOe?=
 =?us-ascii?Q?A/cnmtptZ9ijQVOYmFVkXdOMN5zGk+c5vMGnp8N4njdoIE//9Mz6z5H1bGYc?=
 =?us-ascii?Q?/c+DvhRluYaIAVPx0X4AYzXC16QUQ5tzX9xMt5WmbxObBBKMGYTE/nU22+/T?=
 =?us-ascii?Q?/7USEwUAGf6T/wNkpGRneFOV1LqctQFyt3Sc1HdG06HBnpL52F1MwuLB8of1?=
 =?us-ascii?Q?qTNKqO9y1iHGSN6bPoFfaGOYGVMgmsiHxLdw3afpTrF+QROX0Sro9hJZlZ24?=
 =?us-ascii?Q?AovgO1B5ObBaV/DQKYJEH0u2kC1h0c8JREp6wMVhmeR9WrhToPBXUxELUmgF?=
 =?us-ascii?Q?HdJuyvPRjZKdupr4UPZjHsIdxaG/Mkrg6KxZoDekJ1ZepFW0MxXQqjM7T2M4?=
 =?us-ascii?Q?0KRkbq3cGTOKLGZPtRbK9NuaIK7ZITXhUFx21uI0jUdbKqrbZxHpvFlrelIW?=
 =?us-ascii?Q?w8VnSGXI6W8wTspWVoeitJ0McIeN+nqCABQHIBbtvW9+jumkj5pNL3dD8UKo?=
 =?us-ascii?Q?z82DnSXtMJpQpLry9zzCsEbh28htB/SWCzc9AxgXJCL21sGV+mbVJwk4eeG0?=
 =?us-ascii?Q?4ZJXile66q+rk8TuKmgLLKHOuKTHzekEbV3Aou55exrpZ4xeZzVVymk0LVmG?=
 =?us-ascii?Q?0SLS9tniviL9pxwIybJ4kv1b41bxGoRwR2Ar6K9LmacvYbsCIxxK7EJDXwTl?=
 =?us-ascii?Q?0nKpauzdm68J72OvFfqamMfdX3R3M4Mdy4HflWV49K4LWLEQ6x1mB/MDlJku?=
 =?us-ascii?Q?UriyVSyDN6Wu4OFs7J+cbiLOco6nT8VdGGiSsg15J1PLZbQAyjoHnKluutNL?=
 =?us-ascii?Q?syP4xDzvMLvz8BARutzKRiX9A4SVmy4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a13963-498d-473c-013b-08de6bdee074
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 15:36:52.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvXsnKlirjBXXDibWEwAqgOZZwguTt86Fci3YjQG9lq12MNAu5Icgk0PeK3CAYgS//rAy5/Jg4VVqXhu0fiBRiaAFj9wD6A4bPTlkzsCooA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898

bap_data_free() was calling bt_bap_detach() before destroying
bcast_snks queue. bt_bap_detach() frees all streams but broadcast
sink setups in bcast_snks queue were still holding pointers to these
streams. When queue_destroy() calls setup_free() as its destructor,
it attempts to access these already-freed stream pointers, causing
a use-after-free.

Fix this by destroying the bcast_snks queue before calling
bt_bap_detach() and ensuring stream references are released
while the streams are still valid.

Used safe cleanup pattern to avoid nested queue operations during
destruction as setup_free()may attempt to remove items from queue
being destroyed.

Crash trace:
  AddressSanitizer: heap-use-after-free
  #0 bt_bap_stream_unlock src/shared/bap.c:6384
  #1 setup_free profiles/audio/bap.c:1123
  #2 queue_destroy src/shared/queue.c:60
  #3 bap_data_free profiles/audio/bap.c:210

https://github.com/bluez/bluez/issues/1866
---
 profiles/audio/bap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 90a978667..375026440 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3808,6 +3808,7 @@ static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
+	struct queue *bcast_snks;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -3822,6 +3823,13 @@ static void bap_bcast_remove(struct btd_service *service)
 		return;
 	}
 
+	/* Clean up before bis_remove and data_remove */
+	if (data->bcast_snks) {
+		bcast_snks = data->bcast_snks;
+		data->bcast_snks = NULL;
+		queue_destroy(bcast_snks, setup_free);
+	}
+
 	bt_bap_bis_remove(data->bap);
 
 	bap_data_remove(data);
@@ -3929,6 +3937,7 @@ static int bap_disconnect(struct btd_service *service)
 static int bap_bcast_disconnect(struct btd_service *service)
 {
 	struct bap_data *data;
+	struct queue *bcast_snks;
 
 	/* Lookup the bap session for this service since in case of
 	 * bass_delegator its user data is set by bass plugin.
@@ -3938,6 +3947,12 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+	/* Clean up broadcast sinks before detach (like unicast does) */
+	if (data->bcast_snks) {
+		bcast_snks = data->bcast_snks;
+		data->bcast_snks = NULL;
+		queue_destroy(bcast_snks, setup_free);
+	}
 
 	bt_bap_detach(data->bap);
 
-- 
2.51.0

