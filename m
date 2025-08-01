Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21207202F9C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032198; cv=fail; b=EBBnZzB2KzySMaBhEXoodKSsn0IoPU//9Tn1DLnPREXjW0wYb2OYfkM2/THkMvQEjHnLlx+VImQV57PX/Jla6W7Fb3oYJNvcXCCyf2ushM88KdqN0IW2swYCcDjpU4R2L5nYU+4Ghgp1ttGJcq7op5zoFH7+Y8sEHltzsF0jve0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032198; c=relaxed/simple;
	bh=8HJDNOC6JXHP1+n7GXvRGyJwNhoDpch3JAT4OtphYhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGraTAINBD6BMCGvRyxQWxeFxsq3IFYCRdzmitI0eYhELjELxz6oPZPxKkdFsan0FbXZVlN6lk7A4CzR+Gt5UxYbLTcILm3rb6fhAYqCfMdLOUBIhbD/7FM3+b/14+znPvQQh4HMbz3xAGdb/hcAYSzk08C/VMBKgjuaMQJSPrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f4uNQGou; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f4uNQGou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOsBV7xElrl2OP1kxwfhzYGOpWpbpKgyXCEIrYPXs5XQChkg/4w/5yTTJGyJKLHabr6lFav+yXB23Vx/v0FO73gh9Hfyd5J0xNrd67fIwJvEcXJuZg1/gZcPIl7TMM3w+kuAwO9Z9XI27ud/nR10lGmBGFkNVKfdKv7Dr7P76JniZQYjuhsf6NrGudUetYBLhXwpf1s/k+ngUOAUSLHXC/8ZqtaKFsd4G53k20narLGV3Q/KtB1qN6GAXpDmZEHlvxBsR82rhzN93Cpb6pcbm8Pqh1ibe1veE5zLAPmNJVWc9DfsqlYFkwbjz+K/u9EDqtChftNM/jtRe9cFimyewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDl3h39kQL7nDp4ey+LDyE/hpkgHZ5O/f7EYPUTZSoY=;
 b=MNySHRV6yPHhf1m1AjsjuDUZb5jkNe40w5KYwYlINnu2y2Ca5KtierFJtwkD+NrERu1KDsUqRJF+aDb6jjuFDlErCYx7p/16rM/2cEkw/zYgU+45+EMmFl5LYqgvxkcWyLl8x/MlLCdKXcLT9b8r+K/VmtApXLyGLmdVXP576ltvABLbWslhw6lRnU2fAIHBS4HHRVUeIs8I9kCJLmo4ehPmqBa6rSlRkh/ttKCS1yflDT2Hywk/5kvw4QLPqk95D7dsxBZjY1f4cVA74C6Ojc3itBIA4NRL4z0j/hv21+IKwFOu6OQUBlAxO3gM/u6ScspQ8o943LHpxn6SzYe4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDl3h39kQL7nDp4ey+LDyE/hpkgHZ5O/f7EYPUTZSoY=;
 b=f4uNQGouuFV6UqLYjI3Pkf3B0w6kp5w92yqEvGfexeaLfgrlwC+r2uuk6z3F+JuyzN/uUUU67qE0Ds6j9kWwVowqmDP0sF71+Pz2s2KofMwXEMni1zAsNxtkDkL7uBRrudJxJjHqfUfDhIMMFhMq0z3nJob3YtehXP+0g86EO4C9aUXDlArmRO8lmy5B2+1OYYY4q2Ld/I5Vb0zhXHBJ7LX9YQEdtDGUInNwGTJkEsLO/td32SE1vUWgW5VSV7egyVhtKTLOEyA7w/WxXceNZ4FU0Lp2jrFbVpQ0cg+E0UPSY8mbBIs/zS9UGtfq87pbgC7QDqqZ6oupDHMCXIg7hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 07:09:53 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%6]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 07:09:53 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v2 1/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Fri,  1 Aug 2025 10:09:09 +0300
Message-ID: <20250801070909.7890-2-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250801070909.7890-1-adrian-constantin.dudau@nxp.com>
References: <20250801070909.7890-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|PA1PR04MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b844a0-069f-408f-f7d6-08ddd0ca69f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVtkRFTtDeMly89S0HWEubqlqLAuyVLwgrDjriiEKQoHfY59RyaKVtSLMbzZ?=
 =?us-ascii?Q?G+N1tO0BQgLUFlzPcunEqZ1ZQEjJMpS/ZJMEN3V7MjCO6ZvR7ZSSw7cMKVBW?=
 =?us-ascii?Q?h3G0NpOVIsjP3wNmR+ZCgjiqUKza2MJYzGeQ8T+eBNQshqWEBeNACTdxGgaj?=
 =?us-ascii?Q?sThUK9GX3LxhW6HK5PW0PjLNp8Y1i5K+z/Nw66IPzK3dYMYt2aUPZL1h1TJ5?=
 =?us-ascii?Q?fU0AVjsU5s527ZWUfQYJivx1YOAyd3ux1VuyKphZIx+zXskEHkoJfQaPwnOi?=
 =?us-ascii?Q?jl582eWqSSnTQPGPEkvvl+ysnpvJmvv90kF8g9EhdrqHBcfklPt4DealWuoT?=
 =?us-ascii?Q?dM4XKODwgO68zG4XSRQ/hrSPIB4+SGk3Dz9FQt4Ll0BJciD5C35oi9aZ56dR?=
 =?us-ascii?Q?So0+yXr3jNj64CDZOxL7a2ENzJ/K0vvx4XiI5BFpXHad7lid7bYxE4eiQlhK?=
 =?us-ascii?Q?wwqPWqNWQnwbStFCO1mqHV5yne2cKBlRn6jUdIKTuobE58NTmMkl8Ufnxiyv?=
 =?us-ascii?Q?BXHUN+x9Fvq1uxlCCI9BXi+DNKk8P2xFlBOJiSrKbaDeStAIxnlT4PxiF+n5?=
 =?us-ascii?Q?r3BOw+DGofOLN179iHCGcEmyBrEb4b7VOaDY+nN9yPLocmgwkjSd3E2SGhWH?=
 =?us-ascii?Q?nrXKTHGYVYHmViHAZFIkCfEcIXRfCXLQig00apezxjgq2Q6N83hSql12qOIx?=
 =?us-ascii?Q?Rg6wtpp6N1QL0Ncrh8LBVqhlfsUJVZaqUAYbs7u3uOrlmxuf9eQGXLoYtMRu?=
 =?us-ascii?Q?fM6FDQlfwepNJyhiV7NaKpRSQBnF2DKxGtAfRb4nfceRgj13AHoXEWHbY2Qm?=
 =?us-ascii?Q?4/pJdEqxi+a5mZAwYpNY45dA6wVdjIpckVR4MAlvdYKdqn5fdhAeUiJOELQW?=
 =?us-ascii?Q?s1H9wVZnAcsvqk8S1XNabn28uPz7cj24BznLxHbKeFKCxJgn0HixjoozVYuR?=
 =?us-ascii?Q?WIPK+qSzujPLZKleP+3fQ0FHArr0BwlVVdCWoqzwrbIMbn8pSh6WHNgMFI6+?=
 =?us-ascii?Q?bCdnAK+aOtxrdKL3qyryCsS9R84H7fJ0kw17kMHcfDI/JO8AL1jqo+lgzFVt?=
 =?us-ascii?Q?JZ83sggixtjSBq+A6tGX+NhPFXk9UD7sibTBnGBcka2Wj72sLg1QRhay7emc?=
 =?us-ascii?Q?u5/QQ93trtxtEr2TXwDed45mB2gRz8ZKmDYVI4cQGcnPgoX7EYBbM6pxR8W8?=
 =?us-ascii?Q?Glx4F6VlmDScHAPjR0VD27reDzNmvzcm0OwHMpGJIu7Gw7fx++/Y07wjojOe?=
 =?us-ascii?Q?R5AbxO8tDGkdwIe73NsMlQnl50umWeVTwdisW36FKSqrXow8Nz8u4e0j1pQZ?=
 =?us-ascii?Q?8gN0Dy3GbtMiE+b3NM590B5eJ95Tuclk92FccpyLWIZsTpvU/TEMqY7NcYob?=
 =?us-ascii?Q?zGXx7k+dk68iVBCJntvyqZ+EiPzJ62mzSymSOzTZWgbh+4QFpQ/S2SrESotv?=
 =?us-ascii?Q?NxqxvSBHyVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krn79BoYRi046xLnDs51CB8IK50/bk2AY7ZZHXpo+i3SHF/9O1jmMdOI9kQu?=
 =?us-ascii?Q?6s74JlvPv8aJhImeqdlJee4BLoLdYladFRLMIVX7rp94/+su++EKI/AIXDV4?=
 =?us-ascii?Q?4lQq7R/rBB1mwR99AYs/qumPRSB7vsipE9Gotw93JAwpepBX0pMwpW+x9AIs?=
 =?us-ascii?Q?c8lbIdMTr3hzQv2qC60qrVq9SJwhE9LvwlKxscXlVOTAR570MW8hrcsQRF8X?=
 =?us-ascii?Q?hCLiDWMHLqA67k6Z8x1wgJcIJsHgI4KxJEhnD6Kg25FECg9piKjyjjHgy/oy?=
 =?us-ascii?Q?MnZi+YHvQeFy2lUAGMSSMLkG9HlP7lr/cYeWpnU7va8B7sUJWdnblYANjTHW?=
 =?us-ascii?Q?VmRmnaZPUrq90wbeAlG7Cp7lKU892DXxWvPYUg2KDN3yV7k7Gu7NbYUXVCDS?=
 =?us-ascii?Q?hPZDRaoe20+G4Ent9LJn0L2AZKsj5SeMzk2bg8TdrMlGH7luYoxvpDlrwWpi?=
 =?us-ascii?Q?4IV1TeiGVGCXXKYKOtd8OTRAlTBKRApKLnSSclq2J4gufNYZaVSjL1SHZDLN?=
 =?us-ascii?Q?3tSfFdsxPuzj8guhmw/sZzFHI7aa2HC33LXb9s3gkk26e9uV7Mkg9psFMgSW?=
 =?us-ascii?Q?PIRQYkH1G1BcNNGbDAuufYJj5TYqsto8K6OwdoAbg3LLVaklsSeSLnoR2592?=
 =?us-ascii?Q?PejNaoR/M0ig90X364wU3U5kjRUzNtTKLg7nOJg7UNXh5UuHVMiyHtIa9oGG?=
 =?us-ascii?Q?idWtKYTKhy8cy7V5HTo5O9UU8kGpiS4c309GQa2MlHccdeKJRGuCejsxpLq/?=
 =?us-ascii?Q?acZ0wHAlQNhg5SE3w07Njs2vwInc5Yb9bAwDRHqsKFVQ9TKDAF7odPTAh+uI?=
 =?us-ascii?Q?b3ixgA4SoZc5+vMozjGHlsVqsPoHrcm4/pg8pjnWKZxBh+5TyBbocPb1uHrw?=
 =?us-ascii?Q?YchbK7r8oxAyvzM6GDubd/yOh7WydB6iD9pGXglPGtH4LOR/4SyL9AnpWfH2?=
 =?us-ascii?Q?ASm7H/IeWE3xgfH3buM9jqk8hG5NQX5Ju0WfuOCTBvHU1kfZ55VL08ySZjEi?=
 =?us-ascii?Q?X26cxbaDED9IBfzIFBsPT4QqM1TmehcIldxYtUQQUb4Q0D1mbpBNCEQxYY3k?=
 =?us-ascii?Q?lCKS5V5qjJ/+Wpe2VeoJmYqy1L2g/kKgI0a9yBD7hAgt4WkkmBGIbH8hIEVj?=
 =?us-ascii?Q?sEJhBj9itm5T/O1A1ch7d9B3VROcTzBM88lUjk7ZJ8pkV/5sWcVtgMGgYzXx?=
 =?us-ascii?Q?+aM/AFegxl1RWRszjz2ypF9/HUzuCbfm3pR+azMgDKY4qLSDjgFBi0rm5yvp?=
 =?us-ascii?Q?pYELkbPG80OSFmiMgTLMppLvX7N6fuv6y7mItbpap4mggTAewogS94XUMHNk?=
 =?us-ascii?Q?AFpsi83n7XOwYLxHY6GzrusndB+xkBwuB/I+8c8EZC/wgHRzUrc+gjQhmmH8?=
 =?us-ascii?Q?oieM4G5s0d643lAC5Hp54yKP+SMU+bfSiLyn1B66IV0x+PYzgU7OB4WbR0wQ?=
 =?us-ascii?Q?XcYsz53lqS1Pw+OuV1nFFLzBNciISzqYpGGkJ+fXZclqz8VTc/bqVKW8HBF2?=
 =?us-ascii?Q?SpeWMq7lzJu5UQB9lZpQ8ykbGB5cmEj31oQ+QKdbmYNOC3qxkPxb5WgMzyEh?=
 =?us-ascii?Q?tEhCgG3pncd7iuvbM/hLvaQxQwS7dCAhBUHHk09egkkq4vPWFn21tkLSSLDD?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b844a0-069f-408f-f7d6-08ddd0ca69f4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:09:53.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlG2LNuLb9kg6BM1Q6lU1hVKZubSm2D8MywmUiI2Mu/TZDn+C8WdxrGhBfUaVk9mTf+Z3UFJ/2GIcoy48tlD5Ekskp1nfuxI8qfrnZ8oqmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
---
 tools/btpclient.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 055270edb51b..5d5a7ea4a2ae 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -2510,12 +2510,23 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
 	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct l_dbus_message_iter dict_iter;
+	struct l_dbus_message_iter variant_iter;
+	struct l_dbus_message_iter array_iter;
+	struct btp_device_found_ev *p_ev = NULL;
+	struct btp_device_found_ev *p_ev_temp = NULL;
 	struct btp_device_found_ev ev;
 	struct btp_gap_device_connected_ev ev_conn;
 	const char *str, *addr_str;
 	int16_t rssi;
 	uint8_t address_type;
 	bool connected;
+	uint8_t key = 0U; /* AD Type will be stored here */
+	const uint8_t *data = NULL; /* AD Data will be stored here */
+	uint32_t len = 0U; /* Length of the AD Data buffer */
+	uint32_t eir_counter = 0U; /* Count of AD Type, AD Length, AD Data */
+
+	ev.eir_len = 0U;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
 					str2ba(addr_str, &ev.address) < 0)
@@ -2538,11 +2549,90 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
 
-	/* TODO Add eir to device found event */
-	ev.eir_len = 0;
+	/* dict_iter will contain the variant for AdvertisingData */
+	if (l_dbus_proxy_get_property(proxy,
+					"AdvertisingData",
+					"a{yv}",
+					&dict_iter)) {
+		/* key will contain the AD Type,
+		 * variant_iter will contain the variant
+		 * for the current elem
+		 */
+		while (l_dbus_message_iter_next_entry(&dict_iter,
+							&key,
+							&variant_iter)) {
+			/* Unpack the variant to get the byte array */
+			if (!l_dbus_message_iter_get_variant(&variant_iter,
+								"ay",
+								&array_iter))
+				continue;
+
+			/* data contains AD Data,
+			 * len is the length excluding the AD Type
+			 */
+			if (!l_dbus_message_iter_get_fixed_array(&array_iter,
+									&data,
+									&len))
+				continue;
+
+			if (len <= 0U)
+				continue;
+
+			p_ev_temp = p_ev;
+
+			/* Allocate new buffer, recalculated to sustain new data
+			 * eir_counter length from previous data,
+			 * len is size for new data,
+			 * 2U (1Byte AD Type, 1Byte AD Length)
+			 */
+			p_ev = (struct btp_device_found_ev *)
+				l_malloc(sizeof(*p_ev) +
+				eir_counter + len + 2U);
+
+			if (!p_ev) {
+				p_ev = p_ev_temp;
+				break;
+			}
+
+			/* There is AD data elemets to be moved after resize */
+			if (p_ev_temp && eir_counter != 0U) {
+				memcpy(p_ev, p_ev_temp,
+					sizeof(*p_ev) +
+					eir_counter);
+				l_free(p_ev_temp);
+			} else {
+				memcpy(p_ev, &ev,
+					sizeof(ev));
+			}
+
+			/* Populate buffer with length */
+			p_ev->eir[eir_counter++] = len + 1U;
+			/* Populate buffer with AD Type */
+			p_ev->eir[eir_counter++] = key;
+
+			/* Move the data in the p_ev->eir
+			 * that will be sent via btp
+			 */
+			for (uint32_t i = 0U; i < len; i++)
+				p_ev->eir[eir_counter + i] = data[i];
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
-						sizeof(ev) + ev.eir_len, &ev);
+			eir_counter += len;
+		}
+	}
+
+	if (p_ev) {
+		p_ev->eir_len = eir_counter;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(*p_ev) + eir_counter,
+				p_ev);
+
+		l_free(p_ev);
+	} else {
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(ev) + ev.eir_len,
+				&ev);
+	}
 
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
 								connected) {
-- 
2.45.2

