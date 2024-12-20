Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE74216E2C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705098; cv=fail; b=Y5iwoS+EB5Zhl5nk8rIDEwkBheDCnfD3T4LjRKQ3wcqcbS0t7VPnGchUQGF+g+T3/zE6GpK6J07S9+eceqOHS1CWaw3DZA1mXiklB+LhnarRkrk6Th0zqNPpbcWKDzxW7XBJAKEQ5d06IXSNDZmvyvXxd47nm+bAnB9E0MozWPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705098; c=relaxed/simple;
	bh=qwf+WIGIYpwhFBA2PRia7eS7uhmuOnBDxx2y7J/C8Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgue1igBEdjQWNAycbjWB5Zr+mWZ9VMUpaqYjKFCMsx+KizCKrb2ikP/e4ShEPIp/yFAYYl3CP9vwORCCSjJQk6OUT74XdIO4k8XW7/HDTI4XmuDuykgyqUU+VGqlj/mONB2wTsUr3WPRo2SQPoZmL4xdoiLT8yFUwVAoRa5zVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HRkGzVf0; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRkGzVf0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHsf3SyCiEjY/J1B1idusTYpZeYF9YPBN49N099vRNf7HcoJhf9YMBQpzqGO3Hwb5gpva2Hee7KHsF8tG7X3JUXOZ3P2QZ65jYcqoBN0Epwblos461W7ptpp04tpOR9TionxYi5W75Dv8x99NNy6ZkWppJ4P37RrVqbOhl3pStoXf+A+L+YDjb4ca/yIfgJBOgIoV+KxCTcd1osoR/x79L5pbI+ob/+B4AGjEJtW1pz1uo0Vr9AbGeDgX7J7dh+LFEq8iUGu4fDk9P1u7IyKYocx/Gmadm9Ny8xw5McpKbvZQe9a3Hvjt2KeohINk9cQPFTn0bgGGxUzCMW2zIjlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVwyTsU0FSft2xFXcUgCTO3i+y5LW+mKpMN30vs46wU=;
 b=YlRoo8CeUqD/L2emRPZz2oHXFmkE7JBRBHy5LoKbh6YrirRk1EBg71RsgJrm/ezgAV1WCE/udwMGWcNERWqD1I3/zUMBymidE/VtSoBQGruVykmLJNnh/HEbYjqRbHxDqZfXzyvmKXROwnwdYF75ddKpGg+oQflQA1ApdONWPqZ4Coq6pOYgh1nvGfrqeo1C1PQWIa7cWmgewwBscs3WZyAFJZRLFr4iEdtozaTrHUPe0qzG+VJobDwhXAni1tIBjVsZ7EzDKk5rBT/Ma8JcWDZfo2oXuks/HIP+CoHm/brYEeTcoDSG2H8eYqrkuW8W6aYNzWE4b6ziPiZiqyBV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVwyTsU0FSft2xFXcUgCTO3i+y5LW+mKpMN30vs46wU=;
 b=HRkGzVf0ZYx3neZZmKZGdKiEp5yn/KHZrye8w2hTx0vz7GF1VP118pE1qYSt3hLIYL9QviKdV7QHOpqSdUPkmocy6jJmTYrtmcEa++n5lCR72KR+J7cMfhmccydFxqI6iLSwKLON3pJFOekrK5Y1n25ySS3/c5jveNm1l3OC/wHqAeRj6lECE2+mBoIPgJyipUH5/E/ZNtR2E8BZcbTknbLPUqDyjmpNTdK2HVwPvWVrWw1Ht94kItv82cKDNeY5+3+lFnM9lO/aAfgMe1bUkUdgne3qyxBHPNu++Y69ZeMm3dbOS9tTxDxtJ4iR3wSrBSIbeNA/l4qEj24McKK9aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:34 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/6] bass: Create setups for all BISes in BASE
Date: Fri, 20 Dec 2024 16:31:04 +0200
Message-ID: <20241220143106.27443-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::39) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b814eb-8886-4aff-ae13-08dd21030108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkCddlEp8gwNT8gZW5+mZzlh7+H0wT6t0o0wp0gnkw3iEqwcCvMoi33ZyYKl?=
 =?us-ascii?Q?3XhxgQZALMNIVL5OqsBYPDyjkUtVmQUbJ60KXjY6jauWssduFMOzI+lG78VG?=
 =?us-ascii?Q?orbG/Ai9l1j4Ukq8ja0UOnMGR91L71Omk3vruZdS7hbJMyk2lWWoRdn/+YNS?=
 =?us-ascii?Q?cgEqIATibcsLhK/77W2f7pdRzWWaY/Cs1CIsysp21UyGJgMVsiQXkzCQ/cRo?=
 =?us-ascii?Q?r181jx4jGfkLJ84FM7Q+jjb/mg9ICWyT0IwiviRdEicHnEcikE5SyQwqqSpW?=
 =?us-ascii?Q?2XEoBWdB67oEcAQUnL1Ru+s0a12yprhCmTtrlACsEwOZUl5nLwBY/Yfjo+sK?=
 =?us-ascii?Q?YPlrt2uLFasmvNiKnaZ+rL3ufcSHVs1If9o1DO58fEGjjSQqn2Kx2LQCoM/U?=
 =?us-ascii?Q?YmjayjZTV4gtv+tZfRrhlM2PsT1kDpkH0Tnb+LoSezcJAod+v24bYthYaYyt?=
 =?us-ascii?Q?ddYTFXBOexZsYLuGklJGaZ0ycUV01pgShMi2Lqj3oykLA3CwQsjDrIpWIz4T?=
 =?us-ascii?Q?OT3mDb/4z6Q63qSyONSDpJ0HtZTIthfBDcFgyd99u16JB346nzSaTBu5wLVk?=
 =?us-ascii?Q?9l89cN75T8o9l/ndcQwHQgvcli8luhPt/u/WQBzewomr8RTV7oV3PZE6hCbx?=
 =?us-ascii?Q?Iwf+utc7iynW17l+xWflVtfvJPb5qYZTJipQUixpq+fnvwXUho/Lzbp60GU+?=
 =?us-ascii?Q?A/YfA2h32uPLvFmenf7rTJKDcA0w+z/08ow/mmu9n+5BPb/VyM97ny9/5P9A?=
 =?us-ascii?Q?lx053DMjbog+GYdnsOmWk2mkQ6JKafAh2VP3+3Fc73RoUY37TbnFn46VYmGI?=
 =?us-ascii?Q?fgEotdwYiQANnNPT6Ili2fqHbUz/qcrwE7CJT2mcUPMDXkNuz0e7e3g/Hg0O?=
 =?us-ascii?Q?XJ8LB3ZndT6WlUc6f+Ci0SZz75LpVtVnTpsROzqi9vReEjYjWv9eXwONPKe3?=
 =?us-ascii?Q?8kDq7R31t/VSlZgJcpY+UTOwDK3tVCufZ9xjggK4i7oO5t9V38fYdRkuS8+0?=
 =?us-ascii?Q?mll3WM9XpB0i0U4VdkcjQum9mApT1XS9dZT1BHrWzdoPK1T0agJidBtZWzSo?=
 =?us-ascii?Q?44yB8Xa+hIWsQ+dnZLd8WNg9H87Gn8meOwXOyaDU9scHc+JQenjtgJpdmh4U?=
 =?us-ascii?Q?F+TfDCHcpxiZKqJEPpwT/F7ZGksdVfP/dSRV3L7k7D6pwZEjD7+HCXdjTG34?=
 =?us-ascii?Q?Rl+/h+WaVv4LGwT3hYtCqYSpjdJbzFErjHJg3vlN0OsEJfciyjKNcOP9MJad?=
 =?us-ascii?Q?Mwy9SLyA7Ykzs8Ga3vpbwgrjWB+CKcpDUDUw0+0UC0CkVgcE0aMqZsVmKCgJ?=
 =?us-ascii?Q?6CCFKl21gfUec8MKtym7eOGh27HDb9c7I8cNFLr53GSKzDvL03vBoTW7k1fI?=
 =?us-ascii?Q?ssQj6JifyRElcVFe/hmhNlh/leou?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DFFfugGRTKJbZHjQUC+BsYiNDeCiVUV6omBQ7eBj3j9ZcLD0zxTTbOVURNp?=
 =?us-ascii?Q?4RZZymqEid9OWlyqeYrsouQKRDKjuZ5wDKgZcVsDS5RgnZHvDDBoobKp9UOS?=
 =?us-ascii?Q?JlhSVyRxQ0rUV1317ve6+RFIkCrCbuXRG1GD3qb0PkpHbX2knAP2R2h94Tpn?=
 =?us-ascii?Q?rOBsDehuQBZn47R/ppphzygcZcQxRbCFDqlfcVBOl++3WUS50WgRxteTiUie?=
 =?us-ascii?Q?U1SfdO7cSGHlAOxvVodx4O73yWrg/VsI5vidSBOWe06x1qgbFxEN9aMsQ0Ez?=
 =?us-ascii?Q?qSLHwFDyEKwYij6gxllwYMXSD2h/Ioq+TMcU89pS94/3h+1x5KsT22urqAQO?=
 =?us-ascii?Q?MUuTUCRSQEW6ysi8hPXLF8U64aCDjseObKRYIsV6/lYx0RzvYgktfERRQX0F?=
 =?us-ascii?Q?YVYegYtVS2b+5TW3b9OxmgAq0T/H9vc8m1+kdrzLJXmN+PXkhJARzlx5l30W?=
 =?us-ascii?Q?U5IIBeqD01jYoLbN77aiNhXr4uOCzEvxWHA09K7A0TjTPfSnk6Pj6Wltmhkn?=
 =?us-ascii?Q?ZNNyLnV219Zv7VjIHtub0SlzNzvY5mL4dj1bHFcGwLK+CqquFWKJ031PLq/+?=
 =?us-ascii?Q?PUg0cMU6kF3f4gVyOn+621iOt4Lot3048mqxRSKJ0+V9y0Be1N5G0+eQYaYv?=
 =?us-ascii?Q?MZ2HZIanZn9hvDfp6Qrg3sXMTc6Cm8tJxmGQJxlweAbC6FRZLsS8jg9F9bfU?=
 =?us-ascii?Q?Hoi9xct0QSM0kyYLNUFCwMPbDvRF6wA/5bQg/TkguOj+8M4XcRAQqylRkI8F?=
 =?us-ascii?Q?sjtjYnYkcVkx4VfPvGIJAh/Ye3BhRSP0+MbpUDbMEtqkx9M2nq1+QCD9RBaG?=
 =?us-ascii?Q?IUZBBd/Ot5/E2KztXRi7gOV4gl3nRNSdArBZkkPWGQrgxRTpR+Mm+TJNNYvC?=
 =?us-ascii?Q?KR/uncvereDw7oqm3ZUtr60ec5rXrRwvl06qv89iTaXK6wnKdvpcEHkIZtmc?=
 =?us-ascii?Q?oEU0/sXlcj6LjmARQzbtaSxm7MCm2W0HwVb7YLAhZtLG1A1qGiJZFaCW20a4?=
 =?us-ascii?Q?1gFI3s/coZYbnHHulsd2CuLAvcF/tUYH2e1QmmtsWih4hOGJZVLlJl3oy6li?=
 =?us-ascii?Q?e8S4IhtxqkXIjRmnJsw1Cszq21CEkbqOxN9/jjrOvxcwgv5YfPQ9oBkxyf6i?=
 =?us-ascii?Q?qqSQDeLeLnBA6TV8oQ2NSLR2OLNNNIVGh7wshoCaFDVLsWxex3tRRhhMvz5/?=
 =?us-ascii?Q?YQYaashJgVZNIaErzPhJSDASJE6IOCRwgxWPclGZrYosHZbhkO8ysq77Hkfp?=
 =?us-ascii?Q?LB5rD6NxKZA840t934p3r/Og1lEAoHYYbLVS3J2FNtQdQ3pukP18d1yqCaRV?=
 =?us-ascii?Q?zUVnaITf3nT/0j9zqn96d/c/erRrXfK7QfeZjQw9VatzERXfRC55z5kaCl7O?=
 =?us-ascii?Q?waQt+zT4K4Htutxn2BPaRTWKc4Fd3uGExSZPuDV/rE4yriz6tmKuKXDXdHkj?=
 =?us-ascii?Q?qwcZlBdQFx5gRQvhdm0KOu5NnRuHqkFWub6KWtNVCkN6cZjHSPLFYImXlIDH?=
 =?us-ascii?Q?VfGw3wbuuJzrBbY21y/j65GRSIMpkbo5y1hlhTqxdj7Ur0pt1qME8g4ptwmZ?=
 =?us-ascii?Q?/RMkDHuvJcoC4Y6FcV72B5KPXW89A8QFsAPTRa3rmWNn+Y0YiZcAFi2YsThG?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b814eb-8886-4aff-ae13-08dd21030108
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:34.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b8q+kWgJEkUDmDXdOCI47t0NhVdOR6q+pt8OeCL0vxIVxqIsbpFE7PLM9XtUpx68dxaPW2gA/hDdQoJoLLIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

A BAP Scan Delegator (BASS Server) might be instructed by BAP Broadcast
Assistants (BASS Clients) to change sync between streams, via the Modify
Source operation. A Scan Delegator should create setups for all BISes
discovered in the BASE of a Broadcast Source, and create associated
streams based on Add Source/Modify Source commands received from
Assistants.
---
 profiles/audio/bass.c | 49 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 21f708ba6..2984d7697 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -118,9 +118,11 @@ struct bass_delegator {
 struct bass_setup {
 	struct bass_delegator *dg;
 	struct bt_bap_stream *stream;
+	uint8_t bis;
 	struct bt_bap_qos qos;
 	struct iovec *meta;
 	struct iovec *config;
+	struct bt_bap_pac *lpac;
 };
 
 struct bass_bcode_req {
@@ -376,31 +378,47 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static void setup_configure_stream(struct bass_setup *setup)
+{
+	char *path;
+
+	setup->stream = bt_bap_stream_new(setup->dg->bap, setup->lpac, NULL,
+					&setup->qos, setup->config);
+	if (!setup->stream)
+		return;
+
+	if (asprintf(&path, "%s/bis%d",
+			device_get_path(setup->dg->device),
+			setup->bis) < 0)
+		return;
+
+	bt_bap_stream_set_user_data(setup->stream, path);
+
+	bt_bap_stream_config(setup->stream, &setup->qos,
+			setup->config, NULL, NULL);
+	bt_bap_stream_metadata(setup->stream, setup->meta,
+			NULL, NULL);
+}
+
 static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
 	struct bass_delegator *dg = user_data;
 	struct bt_bap_pac *lpac;
-	char *path;
 	struct bass_setup *setup;
 
-	/* Only handle streams required by the Brodcast Assistant. */
-	if (!bt_bass_check_bis(dg->src, bis))
-		return;
-
 	/* Check if this stream caps match any local PAC */
 	bt_bap_verify_bis(dg->bap, bis, caps, &lpac);
 	if (!lpac)
 		return;
 
-	if (asprintf(&path, "%s/bis%d", device_get_path(dg->device), bis) < 0)
-		return;
-
 	setup = new0(struct bass_setup, 1);
 	if (!setup)
 		return;
 
 	setup->dg = dg;
+	setup->bis = bis;
+	setup->lpac = lpac;
 
 	setup->qos = *qos;
 	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
@@ -408,18 +426,13 @@ static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 	setup->meta = util_iov_dup(meta, 1);
 	setup->config = util_iov_dup(caps, 1);
 
-	setup->stream = bt_bap_stream_new(dg->bap, lpac, NULL,
-					&setup->qos, setup->config);
-	if (!setup->stream)
-		return;
+	queue_push_tail(setup->dg->setups, setup);
 
-	queue_push_tail(dg->setups, setup);
+	/* Only handle streams required by the Brodcast Assistant. */
+	if (!bt_bass_check_bis(dg->src, bis))
+		return;
 
-	bt_bap_stream_set_user_data(setup->stream, path);
-	bt_bap_stream_config(setup->stream, &setup->qos,
-			setup->config, NULL, NULL);
-	bt_bap_stream_metadata(setup->stream, setup->meta,
-			NULL, NULL);
+	setup_configure_stream(setup);
 }
 
 static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
-- 
2.43.0

