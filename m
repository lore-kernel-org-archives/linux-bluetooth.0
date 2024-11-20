Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8919ABA3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098384; cv=fail; b=rMi2NBLJJiDO9LRhz/lkD9l1gEeVsytXnb4T6bcXgyMm/oDtOgFAHqPHqXa5zg04X/K6yM0GdQhvXNFl91+qRDO9QQChQF9T516n6EWNXWIEP6v81VE2kHCj1tGMT9OpJ0DFP0Wc42XRdqY3/TQS+WY/P3x6glYly9TA+ModQXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098384; c=relaxed/simple;
	bh=OOqmAF8Deik0zNLaQrUFgCc3EHiKXm6NQy7IHLYgHpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tz1OWxVKMDvTRnI5u/C14E98Ky7qjGerF+PMdOaC6s0XNwfz5OxjjPQPGDZPaAqhibn6OhcDiu+1o7n+doXi091/xyk+/9Vc0OHypRUsXI74qI/MbCRZqhnwBCpBKv0My5odwig3caLex23CZeSCishTA5sULvfibakMbQWbkXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2427rK7; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2427rK7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3rkabF8hVgTjbjlwrhh6FJS0Js7rV6JNchtJU029BBNVcYjbDfsdiATzUa6HAWOCOI2g+NiQSJv/JtMMZ5jOFIXzYGKsw5/bykXujsGXhD8nMMVRgtAaxtHjykZqZscj8O/s1tUxpgJ3psaD9Ccaab4ntWismFTC7pqVWKEPkpzE5ddeO4TsEvESlz9IrwSzue3usB7Xs8n51+Q9sgi1EBZAdExi924F5QowRI5dWZ0hReFNMZYeI/pDEW0GUIvdkhJ5xcvSz0HQHGzuzaHuCYrRN49CUnNS0Bj3ij/rOdoTlIqkqnF2uArCtvTQUQ9pk/wmcmHryRATpwJTFRCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yv+iviCXdxM/4XPlJW6QWcbAojIy5C6JsDiZEIIpnX4=;
 b=uJbGn7LjPcX1nRXJtRr5YVcM/K+A6asb6gPZych7R/Nu6vglGIURNiPlsQD01+ujKorEGrNxF9rrakQ/HpxyvMZoxomgedES1Hc5BbTrGg4p7NHGcuRRqxrzP3W8KuLzvH8FBQYRxb1m3Fne69MVeGCviqTTVzU2R2u3iZOLk1n7y01a0f7AhfRgbcq8RJsVama/HrYYe/77o4wLZbTa2TNVYXIlihB7n2js7mgQaUn28jqAGPDrDxYpG2yCPz1EhpagKh3m0Besr8nROJNWS1N2sTH6dVdCVvAA0oyV01+BLlvmFNcBBz9zda23svfZNZayU8SUnzCkdNuL503aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv+iviCXdxM/4XPlJW6QWcbAojIy5C6JsDiZEIIpnX4=;
 b=f2427rK71VCX1OOUd2VQGquM9e9JPwojeyGlG/0gMdIF1z/nohRlYlpeGV/57geEI5e2QpbQpsuzrmV4fyAoyyTFISmhAJhErJEPEFXNMtf/DnGOlC8J841Wd41IwQHqCOqs2gjbMuOLm4lP2yNTa/gFjXV9a1EDTY4kj/HCZn0/zsCX4Xtut7RM8C99Aj7iboEw//hyycJNWJDB1ahWWFEyOHRwOSPWQETUdHwA3hBYMlFe3zcasyeDG+Fmz7slShX/+dalilA5ccMNKYeLhFLRB87L5ipL7/nG+zpcvQDGuIf6A5a8AC42rkVZ41JfBraX//pluws+1IatYWMYng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 10:26:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/7] shared/bap: Add helper to parse BASE
Date: Wed, 20 Nov 2024 12:25:55 +0200
Message-ID: <20241120102601.38415-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0179.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: a1184df0-2584-4022-ff51-08dd094dc3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oM+mkTBRYQoRFdlKWCJiJWXDxcymemuUYDOlAtWbhgGx2Mi9HFZB4RxidhgI?=
 =?us-ascii?Q?9HVMhCgWGtXKnjommJ5sFUHXt03ojqDaM7EjVWUJsQ7gkQ+rM3GzsrFSAvKN?=
 =?us-ascii?Q?hBeAjjZF3+LV0pjb3WZWVwHEir+svEDzrSRIm2ElAtYBaxjUVZyzKyERP2Sg?=
 =?us-ascii?Q?obbXLKDt8OLP6rVM3Ta/f/7rSxaSuCbhzENIVgvm6SunqdP2I+yA4oASikrv?=
 =?us-ascii?Q?Kj9N0Io+MrgwSV70mYlcJ8QwCwA6pM5qR2FjYurT6emLCDrSIQHpMXhH3EKh?=
 =?us-ascii?Q?tArWj+KcDtGgG79ngXYjjoeEt37pNjA/Bbg5ROQIXoM4idIO32twmij1t/y6?=
 =?us-ascii?Q?a27WH1c8pQt3YKdu9YfCSJBqrGKIF2L+fYKQ2h7HgTL2l7Bv17DWdjP+/mLu?=
 =?us-ascii?Q?36qzkpAO3EZgU/wH8GWgivOKFIEGA4t/reK2djeMMHWvf6+dBXU8gtsXNYZu?=
 =?us-ascii?Q?EKp8Y6dr0Wpx1KZ6KkZEZpcWbG8KdEDAKBWAm/WaYkFduqpqLgJzEw/pD6ng?=
 =?us-ascii?Q?AcGtm7H3IU6ok0Aa+yvybEk3Po0d5B9Ax2XrKx67pu/EXWXeEW1IYA1+hD0p?=
 =?us-ascii?Q?8L2vZ0ohi/0UQXHbK0FT+JzbnPh23S2oHaTVs1dbxMdKxsvkOWFAzokayCzc?=
 =?us-ascii?Q?3EuNWSAc5XRygLihSapuF3eLwcrbjAjsP1VFsK1ONUwblpXs4GMzrXnbks+F?=
 =?us-ascii?Q?lax0fQvJ06F24dxZKfdGYVYxVUgzC41y1J9Gd3uJLDLyy5EupretoCabfN+U?=
 =?us-ascii?Q?IEysQ0JquDaGq/L7dfw7nB6FyIo4lb14sYypf/SsPfqFJezcq23fhUNebDvR?=
 =?us-ascii?Q?bkiyy51NExuJ/8WVzTDnJFLtP5vWlWk39elzKHm/oMc8uN3Qi3hM+3iLaf+F?=
 =?us-ascii?Q?71nAPfz4OM6+ene/RHfkx6oLtogsERi02imJEOh6J6+ZfyA8TSXcs0xesaZb?=
 =?us-ascii?Q?I9886IJNEcN17AAhUirv4b/w7Vsq+8Hmc4/AhQo5QNpQNzsO1rzcMS/8D+bH?=
 =?us-ascii?Q?3x3nVRraRcfFQCbBuGKQKdJheOECPBGasc5t4V/Wl42y3D/XU0F2sLSVPoaR?=
 =?us-ascii?Q?KPoNAYlAJhRL+KweJETqSUiEH0yW5PuloiiCXxwwC88PEo1+ljE3funWwzEI?=
 =?us-ascii?Q?PuMAzHz74fZOf/hPmYcZ9c972QJVRjZgGv8s/8BzG9fXCaCLWPbM+eXHrMDk?=
 =?us-ascii?Q?6LrG6j5iv4/0SVSO890vAU/Z/yBWRMndIEXP1uqBwgYkeAvuIiqC4tFFI/z/?=
 =?us-ascii?Q?5UETmPy5TytCtGKPCg6XmxSYN7+WIcJ5jgo06U/gHzEt/9tQc8W3q3s44kOH?=
 =?us-ascii?Q?nJiUEvflXdNJpS31VqpXGHnq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJlQ0HE4gKGhXYbG2+GPA1rDcKUNlWowNl9YUG5qu9ybmGdyvaMWr9w0H2zj?=
 =?us-ascii?Q?wfkNkSXE5dLjSvDR3LosaIuoCDj8R+472aVKIm5XDXmNQef3vE9QicS0rW2M?=
 =?us-ascii?Q?H5l+mV4157ZrMwprliyQlr/Gg1K6RYiXr6/W7W5Wc9ahNiHPf10k058yTFOP?=
 =?us-ascii?Q?yX2YFj4VkIUxYSVbgaBnF3vKml3wzGh0tyy8P3KDAZzihY7//InFQ7iNoFeG?=
 =?us-ascii?Q?5bgdGduWvlksgodhS9JomelnCeBwtsXS5bBeK4/ugWK1wiDffjNnAPib0u2v?=
 =?us-ascii?Q?WUJ/sZskaOHX/Z5RZFfJAr1NsJxzEiqZT+bdGqQV36dgqWDMOHXK3Uwb5u9d?=
 =?us-ascii?Q?7lkPN4vXrbHHQh+4tkHbI05SZj56uhjdV6x+hG/e1XKuqpkUXW9DZVETrVVt?=
 =?us-ascii?Q?2bDgTqhaoHKT92cuRKYzB/jhljIFh4m7txkEsBJzDEnskwYqpG+Fs6X/kZ6j?=
 =?us-ascii?Q?eF903RELBaFPikJ1Lt1ZcmTZRAe7ftrHQdcKu7pDwTZ5zzBsShyMH9+SuNg4?=
 =?us-ascii?Q?6IOVNVS0g6Kx7wiA5jxF8aKH9ui1z0V5gNL6EUcUg/fobfZz0nhIfgbtuTye?=
 =?us-ascii?Q?mxythECMT5kveZL+wn95UByslmObZ/LsbBTZs5lLfNk089vXiI2SAO/RkFPT?=
 =?us-ascii?Q?DrU5TzppPjDg81xK7z0PwyujiS9W9a/dRje40ng9qQwwLRuRjxqsC0T9Husl?=
 =?us-ascii?Q?TTbqtVXcG5Z8uu3yiPug3ANSfaF9/g8hd3OITG2OKhomORNr9m+LfO0b1eCV?=
 =?us-ascii?Q?rj3pWzfkJBzEpp+fm56r0sfK0UumhxNI7QJHdQ7dvOSdW2OEcXAeldvQrFWH?=
 =?us-ascii?Q?LMoFcDP+4kR0/KsHw+cbYGts0mn4oqFB2AZE7l2Sj+JxJHT50acPc9PBBr8g?=
 =?us-ascii?Q?XR3uzjSN0j4Gd4k6o/1Hedz4/KtQ0cEC15OBm5ls1ZCa0V1hgQ8vPukhYjGT?=
 =?us-ascii?Q?ljDA6kcW6DpUZ35PIS7B+9l1kQZFB39EYASBcoc+oNL92wEphyR8CKKVzNCl?=
 =?us-ascii?Q?G+madYxRsed2WlYvEpvPSE4g8D/IgIsSLFMzjJu1ICfwLr8BJCs7qvhD8EJS?=
 =?us-ascii?Q?E0fs3XvH6sKGFSMK0RvX59xmhLR7zEJ9KS2Z1rK/Sth+l9HLIYxTQBXtzHLs?=
 =?us-ascii?Q?sNynAs6btNd+07su3fZRmh4O4TbwggH6NTp1X6zXm4I5vRgaFS/7BR56GOKw?=
 =?us-ascii?Q?v/EajsVtOaS0zu9PrFfS3DOCRb2t8OaBCwreu5J9E+hueQKDYyCToMfK7ACJ?=
 =?us-ascii?Q?am8sdcCQ0Ok0omlDs9ff5jBlb9/R9tfrxEKtWWim4exSBvaM/GJzkQz6S+Gv?=
 =?us-ascii?Q?8Gu+YIQW6ttrOtWBay0fT85lGoPaJykSlL1PMxu8N7dY3ywBeNt1QS8iaBWe?=
 =?us-ascii?Q?NKsyZ3pIO8fvQQPrOoIOVJeFJzvqbVDfr67owJlC4CmTQU1KJtyHDEIuyZ1/?=
 =?us-ascii?Q?PB6ZZNiwz3uDH5S+3BRCYYNy4HoF2+wtjPeHe/Dh8weV3sEFVG3b+Ama75XV?=
 =?us-ascii?Q?iciFgJI0yxloV0Eh0ojRavwMRwh8niXu/w3khv46c2ymgO0Ni9rm4KtpainG?=
 =?us-ascii?Q?OBqNn1pIR8X+5hlNIlWYQfg0XYgUo8RWpF7p84s+Hx/uNXytfgIHVKHhM3Sh?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1184df0-2584-4022-ff51-08dd094dc3a2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:15.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0oFyaSFTNb7tlc4T5kyuW8Zz0ejR0x10EC4+qQkOEUwpYe8ofL5y2+k5A0rx6vbdv+c/zwbErZus4VZLWF07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904

This adds a shared/bap helper to parse BASE. Any plugin that wishes to
parse a BASE structure can call this helper and provide a callback to
process each BIS.
---
 src/shared/bap.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  10 ++++
 2 files changed, 135 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 658ee1370..167501282 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7067,3 +7067,128 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 	}
 
 }
+
+bool bt_bap_parse_base(struct iovec *iov,
+			struct bt_bap_qos *qos,
+			util_debug_func_t func,
+			bt_bap_bis_func_t handler,
+			void *user_data)
+{
+	uint32_t delay;
+	uint8_t sgrps;
+	bool ret = true;
+
+	util_debug(func, NULL, "BASE len: %ld", iov->iov_len);
+
+	if (!util_iov_pull_le24(iov, &delay))
+		return false;
+
+	util_debug(func, NULL, "PresentationDelay: %d", delay);
+
+	if (!util_iov_pull_u8(iov, &sgrps))
+		return false;
+
+	util_debug(func, NULL, "Number of Subgroups: %d", sgrps);
+
+	/* Loop subgroups */
+	for (int idx = 0; idx < sgrps; idx++) {
+		uint8_t num_bis;
+		struct bt_bap_codec *codec;
+		struct iovec l2_cc;
+		uint8_t l2_cc_len;
+		struct iovec meta;
+		uint8_t meta_len;
+
+		util_debug(func, NULL, "Subgroup #%d", idx);
+
+		if (!util_iov_pull_u8(iov, &num_bis)) {
+			ret = false;
+			goto done;
+		}
+
+		util_debug(func, NULL, "Number of BISes: %d", num_bis);
+
+		codec = util_iov_pull_mem(iov, sizeof(*codec));
+
+		util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2.2x",
+				codec->id, codec->cid, codec->vid);
+
+		/* Level 2 */
+		/* Read Codec Specific Configuration */
+		if (!util_iov_pull_u8(iov, &l2_cc_len)) {
+			ret = false;
+			goto done;
+		}
+
+		l2_cc.iov_base = util_iov_pull_mem(iov, l2_cc_len);
+		l2_cc.iov_len = l2_cc_len;
+
+		/* Print Codec Specific Configuration */
+		util_debug(func, NULL, "CC len: %ld", l2_cc.iov_len);
+		bt_bap_debug_config(l2_cc.iov_base, l2_cc.iov_len,
+								func, NULL);
+
+		/* Read Metadata */
+		if (!util_iov_pull_u8(iov, &meta_len)) {
+			ret = false;
+			goto done;
+		}
+
+		meta.iov_base = util_iov_pull_mem(iov, meta_len);
+		meta.iov_len = meta_len;
+
+		/* Print Metadata */
+		util_debug(func, NULL, "Metadata len: %i",
+				(uint8_t)meta.iov_len);
+		bt_bap_debug_metadata(meta.iov_base, meta.iov_len,
+							func, NULL);
+
+		/* Level 3 */
+		for (; num_bis; num_bis--) {
+			uint8_t bis_index;
+			struct iovec l3_cc;
+			uint8_t l3_cc_len;
+			struct iovec *bis_cc;
+
+			if (!util_iov_pull_u8(iov, &bis_index)) {
+				ret = false;
+				goto done;
+			}
+
+			util_debug(func, NULL, "BIS #%d", bis_index);
+
+			/* Read Codec Specific Configuration */
+			if (!util_iov_pull_u8(iov, &l3_cc_len)) {
+				ret = false;
+				goto done;
+			}
+
+			l3_cc.iov_base = util_iov_pull_mem(iov,
+							l3_cc_len);
+			l3_cc.iov_len = l3_cc_len;
+
+			/* Print Codec Specific Configuration */
+			util_debug(func, NULL, "CC Len: %d",
+					(uint8_t)l3_cc.iov_len);
+
+			bt_bap_debug_config(l3_cc.iov_base,
+						l3_cc.iov_len,
+						func, NULL);
+
+			bis_cc = bt_bap_merge_caps(&l2_cc, &l3_cc);
+			if (!bis_cc)
+				continue;
+
+			handler(bis_index, idx, bis_cc, &meta,
+				qos, user_data);
+
+			util_iov_free(bis_cc, 1);
+		}
+	}
+
+done:
+	if (!ret)
+		util_debug(func, NULL, "Unable to parse Base");
+
+	return ret;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 126348e81..200dc8f13 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -40,6 +40,10 @@ typedef void (*bt_bap_stream_func_t)(struct bt_bap_stream *stream,
 					void *user_data);
 typedef void (*bt_bap_func_t)(struct bt_bap *bap, void *user_data);
 
+typedef void (*bt_bap_bis_func_t)(uint8_t bis, uint8_t sgrp,
+		struct iovec *caps, struct iovec *meta,
+		struct bt_bap_qos *qos, void *user_data);
+
 /* Local PAC related functions */
 struct bt_bap_pac_qos {
 	uint8_t  framing;
@@ -259,3 +263,9 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct iovec *caps,
 		struct bt_bap_pac **lpac);
 
+bool bt_bap_parse_base(struct iovec *base,
+			struct bt_bap_qos *qos,
+			util_debug_func_t func,
+			bt_bap_bis_func_t handler,
+			void *user_data);
+
-- 
2.43.0

