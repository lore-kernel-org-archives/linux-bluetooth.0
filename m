Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB94778E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949319; cv=fail; b=Dz7YK0JVWGjo9NDqLt6Q7NJhDWb5ONhwiRk67PEPE1PivnGf8IFDhkvROA91/3KgU8mCdHMRlQcFjZSryVzrrsz0YQfn44dU+di1RWmWwBDl1vTALWX4S1f9iegdl97RTrjzXilgE2k13dbyRIyYabJcdCHyEMmhMf1lOmKVDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949319; c=relaxed/simple;
	bh=qAvax0zB9j2L4+i/TgbnL//3KZDco5Yz+PYZIf7JBRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRpaOdFw0LzcUqqW9wC0DLEvsgQmvXdyBRdolCGed4GLRAgAowWSE7f2BopPiTiiGxfmb6Gao6hl8+VfV8QAEXlM8Dirusj3CxNntSx0cm34xtc3vWIPDnbkzAW+srhrfJ8SSESBHO9uQShzZkMIReTmd5apSQki4Y2ckRAwidw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bzmyyeK6; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzmyyeK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRqknCrsTLVWQY/gX54Sd3uYNUVGLg6VcyY+JgME1RWFw/ic+9ZUr2Md6En4s8t56odih4JrDUmXW314tc/caa+xfTxV1IprRKIKdCpQAIZS8iwtZMNbdpZADBuP8LkmIBcpAk0F5rDlun3KXVK20QhqwG2fnh3RxGTaxeNc9jc7KQEWDmmcGIg5dhwaC6xnHli28exJF1jvxxOBjjd2BEhuEVJjKfJmfPjcdaA+dlThwRVfCGQoLpvhIZsXOqBF+J77zAg9k4mEzguV80Ue2eV7J2kZ/HioZIuI2NwZuVhlGSwoQiEUBk/SWKru+kz1iwia4nDPtYATRddYeeI4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IvHQ5wdcDziVYYnY2bELUDP4mnMsFwYmrWMcffc0yw=;
 b=SWaf7VGt7+kLuS75SJBF1OClez1xlhKR4xFntIqiyh0ZiX20YUyzG5EzzS7/eBh7EGItMpUpttKiHZWRlE2MjTU2D3JY+g4a2B53q132YCPaT6warhO6gyl3tdhqFolFNe1F+puj+9jnxiXSwWwXhMrJARXB6K1lDfjDiH3lEvpHLq5lB4vTFWPlzQCkLvDpwLAAQ1xkj8Owlmd8TGtTyh9MUVwFY9x6ZqBjGwCfgLBznkhsh2JhMkXH7C9M3+acdtIHPfnQfAFf2HDsjU4WaaX/b1SiLidRPmmz35J+bi9NJseGrPVWaSPrzXRWgvBy54CBInN6uJVVYLm+YWyk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IvHQ5wdcDziVYYnY2bELUDP4mnMsFwYmrWMcffc0yw=;
 b=bzmyyeK6dbZSoAPLr1+b+IJNnQb0zUV0WXZ8hLFeEf5CeDyYKAycI48FNKLt0yY8h6SscNCCr1L3ylBfkWAlntXOM2V9Qo2XkHVO7JQifEstCyUoDQeWkxiFNQiQFb1H3Y6QOQynZkqP1H34Ub0Zr38CMuOhF5CVuWPd41Z/XE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8934.eurprd04.prod.outlook.com (2603:10a6:10:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 12:35:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/5] shared/bap: Add detach stream op
Date: Fri, 17 May 2024 15:34:33 +0300
Message-Id: <20240517123436.146332-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: d555f04f-dce0-4a26-51af-08dc766dcd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?is5iQuEg28L2PLGlo3DtYMV+3l4M2vTPAANZiXfTcIwx205VF9pSgvtGFg6x?=
 =?us-ascii?Q?u4ac910HuWseTByP+Rypz7uHE85mAQxJ+U0fJiA9M5pjzDPFc5LdipZ3B/v0?=
 =?us-ascii?Q?LJ8+ecNyw/l6M+JPiHPulJmzxEVlF3kUcRnnZI4xziyiZHhcsaTMkEvvWf7B?=
 =?us-ascii?Q?DkzJJWJBG08kYELoBn17Sbrcnm3qFh6r2IyRs+ySDi1W9x1vBRZlM4QOdqAQ?=
 =?us-ascii?Q?O3j4OKOj4Ikkc50z+4a1vO+mudp14mw3+eC8czR9zjrBq6aqT+ivisURdirO?=
 =?us-ascii?Q?u7RWIkO7dztn9SKOoc9gxdUay/e57RT88d+Huxx6K8pGn2ZkOslUX7Nrs4pS?=
 =?us-ascii?Q?9cNTUEmwuO7Qj85TfWGOeTTKEjxEpKdxYh7UMR5KhVBVtny94nF1vvEVZCYN?=
 =?us-ascii?Q?5jxUG/6CDMl235AwxHNMiTBG4mWabKc+SMGebYdZLSUTN02flFBgGD8iEbcY?=
 =?us-ascii?Q?ebQ3Kda/3KZxhtaCw2Vodw5MI0J7TBte1MFxgGWM1UKsEUB01x/hVjL0oZJu?=
 =?us-ascii?Q?TIzc086RGisBK6bwf0vifPUFUfU6mZo/8YhFOoneTD78bAFDS/5+O9SeHcPc?=
 =?us-ascii?Q?lU0FyL6ZY4DSFyHMv0FFltWap1NnHtoeRJ2OsOwUGhc7qMCz0hh2zBvZHiQn?=
 =?us-ascii?Q?MUHXWFY/t/auteyHTiIl3nXn/PJ4tip7dMa7oR2Gpd99EZYbPfco7Ji3WX60?=
 =?us-ascii?Q?E5N7IB/Ei0DvRTNw+KCow5xqGZ6FzTlJ1pveIsCSX5LE0/phyaIJeQ/yDvHt?=
 =?us-ascii?Q?f5jyt80NKVceEtKftVOvV821OoFuIfaSY0hXhWM4j87mEQj+0+acteGBahMK?=
 =?us-ascii?Q?1z3UZimPY7f3GaWUUqGc1P/LQoAr8Bizcr8DDORJ+qOeNReNzpll0+hs+mHK?=
 =?us-ascii?Q?Dt6D8chgMSkqyn1gS0iKMGjyWlhsu4lFYAjkc5KBsk+B5jMGXZAwxMRL2Pm9?=
 =?us-ascii?Q?/oxkGAWY3Ak+aQkxskNverIA+hcITly7betL40yOrgLT94id8ErJH3sv6/UD?=
 =?us-ascii?Q?3vrX0n12YDEVhKC/wFiRN2Trr9ENJlhIp7TnVtSWkKV6FPasrR26R51B9QVx?=
 =?us-ascii?Q?SpvZMvlsgh0N8YYCME5FR2TYtsYh5JNey07GN9/dRm/pg03BsUFqTfjlLVQ4?=
 =?us-ascii?Q?1EWakQPh3mcGlG/JNU6nDO9GAGLI3HEJfNTI4GJ1L1ggim5Myqlz/fruNQSF?=
 =?us-ascii?Q?pYLmqzjdo/WhgiG218brkveVt8T3i5FgZY1l9HxmOoSP5peYQA5sYKwYLMAR?=
 =?us-ascii?Q?y7SoZf5Mf3crklaN6xUwHAHGBUqmVk8mgtOmZ6bxNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9G/arBaZr/jJA8lgG0UWwQUOkMOS2eEI8we6e8DPkrVegI3PW8nxbngvlBzy?=
 =?us-ascii?Q?GdQ8M/ZXSlMNm6VMNVkUVbEh6MUyR5jCRUbEBCZEt9A1042G/qjVyOcrxCPX?=
 =?us-ascii?Q?WWLNOGROdCvgjqsJM+RDGfxsGHgeQf+xnrpnRIFJcMytCxvPcwksiP7d6JaB?=
 =?us-ascii?Q?TPl482c54b8PyBQXCDay5YKDoxIl6vcvp3PUVMkFKL5ELx3Jcqr8Ciu1/azC?=
 =?us-ascii?Q?odwy8sgAx+NTLmoCZA/RtuFfExWfYnQ/Ar/tJsFSo3jn0mnjRUMf/PtG0MbZ?=
 =?us-ascii?Q?hyDR3OweUyDhgYLWua0OnHitmliNPrMq8TWUaChxridvalQHq2/RI5Y01DnP?=
 =?us-ascii?Q?sDEEr+xqqZ1CS+Wtvcu1PYF7PJQSymcpsEO4mYNrNwDyvNVi/KJMwUjKNbpV?=
 =?us-ascii?Q?YrA3K14tQg9tewTmkFZiLNF3d9RYB/02zYy08zD0GVakeo+gxRF2SxMYJ12W?=
 =?us-ascii?Q?kbYKz1Us9GL9OgjWwYK+IheP39vq7nXKZeb7X18smLP1Zm+ThBQPKSCZxUkg?=
 =?us-ascii?Q?yondjVCj37cF/AmZwRIwVgAo1XHRDu2V4FO+T6ZV4vo5XD3dieoyuWJNRg7g?=
 =?us-ascii?Q?QV11FUR0SmlK+B/qVjMBS6Lc5/IoqV30b2h3z/yZtP5eROmfUzvjkIIiHiFs?=
 =?us-ascii?Q?oomnu4dhOV4j5fr9Wq01SHZ1hfvw9asI4rd7aWsu6vJVr2IbPbSdk7YIdNmQ?=
 =?us-ascii?Q?Yv30PZCazwBptZSW43GJ0L2dMaoGelnacdIJetOsPOhr8qf/mv39FZHtJfTl?=
 =?us-ascii?Q?XNMCop0HOMd1YUdA3Cym7Hjq/XfAkxHQLOePYT5YV6gXn9zOwL+fXALj+Ume?=
 =?us-ascii?Q?gLKEQqIIooW9jTIvre1QfhVsyT9bT6sEv3phiG4Zb4Hc3m6MpwofK6juGiEO?=
 =?us-ascii?Q?xTO2XhY2QB3YafOY//6bYE8oB6lnK/aDclMOgd8gf8Syrp8uPPlFWKiLuPix?=
 =?us-ascii?Q?mcyJraavxLLa2qiDpX4qJAjOduOMkCKkWndJFEi21W3+OjiIZgFF8RMCWbrH?=
 =?us-ascii?Q?vKgAxljJ2wmIAMuW2dXSPjkkeI77q46ahSpBOA6HhuTjkFGrHyxhCPlD6IfG?=
 =?us-ascii?Q?sptKuCJ24zUdIv0/tw/hnv+QcC6fX4GLgwepoVT8So7eoNcQnISxXBchEI1I?=
 =?us-ascii?Q?Usksaw78VR397Q6IsrCP4tZt1k9o8fgFHPUv7EUZPEgaw13zBjMhDD1tcuiB?=
 =?us-ascii?Q?fJmHEUxlhLuSYZxgHCASrNoZrVzRF4lcnxaVPCCcV+KExl//nMMK1+HIBmoC?=
 =?us-ascii?Q?bPZR8BybbeCWZK7jiapvS2GMEYzugjKbRvPP0Lh5OKFRCthxTk12Dsx8xPuF?=
 =?us-ascii?Q?OfsdPQ51LknM/zbDjOoVoEzny8RPqKiPjC9/98OKTxBfWAP9fdoypkGRc/g8?=
 =?us-ascii?Q?gKc/H+ZiF0M7zHk8WBS0sWJ6D12/pJf3vjF1LZBYxqbmi9SD/vCRPEKzQtC4?=
 =?us-ascii?Q?b37fWzmbIeHenr6MFZXiQ7BwAH63/BFKIMrWuEtGU0GXHyyRQTTGT01ndNTu?=
 =?us-ascii?Q?yXEtI1BGG0fhM9clapHXW/a4qzzvoHqvIq4hOaDeNJlGCT/hESbaQISZu4g+?=
 =?us-ascii?Q?H1Eqi4jKgcqi97ckr2iWpIyfhN/ZzUlSJAcW+UWAbJu/zFz2vCetayFyBh7/?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d555f04f-dce0-4a26-51af-08dc766dcd9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:15.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMmKUw3YxZDmFyHyt6AtzaZndkbO0GvN3whbt2lSkX6mSW8/ZWrUcWSdYw882qPTDXlBRvSKeBl+1NdXYJORNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8934

Since a Broadcast Sink stream is not attached to an endpoint,
bap_stream_detach must be adapted accordingly.

This splits bap_stream_detach into dedicated stream op functions
for ucast, bcast source and bcast sink.
---
 src/shared/bap.c | 55 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 40ce16d75..6572ef1d1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -250,6 +250,7 @@ struct bt_bap_stream_ops {
 	unsigned int (*get_loc)(struct bt_bap_stream *stream);
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
+	void (*detach)(struct bt_bap_stream *stream);
 };
 
 struct bt_bap_stream {
@@ -1171,7 +1172,7 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
 }
 
-static void bap_stream_detach(struct bt_bap_stream *stream)
+static void bap_ucast_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 
@@ -1190,6 +1191,34 @@ static void bap_stream_detach(struct bt_bap_stream *stream)
 	bap_stream_free(stream);
 }
 
+static void bap_bcast_src_detach(struct bt_bap_stream *stream)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+
+	if (!ep)
+		return;
+
+	DBG(stream->bap, "stream %p ep %p", stream, ep);
+
+	queue_remove(stream->bap->streams, stream);
+	bap_stream_clear_cfm(stream);
+
+	stream->ep = NULL;
+	ep->stream = NULL;
+
+	bap_stream_free(stream);
+}
+
+static void bap_bcast_sink_detach(struct bt_bap_stream *stream)
+{
+	DBG(stream->bap, "stream %p", stream);
+
+	queue_remove(stream->bap->streams, stream);
+	bap_stream_clear_cfm(stream);
+
+	bap_stream_free(stream);
+}
+
 static bool bap_stream_io_link(const void *data, const void *user_data)
 {
 	struct bt_bap_stream *stream = (void *)data;
@@ -1285,7 +1314,10 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bap_req_complete(bap->req, NULL);
 			bap->req = NULL;
 		}
-		bap_stream_detach(stream);
+
+		if (stream->ops && stream->ops->detach)
+			stream->ops->detach(stream);
+
 		break;
 	case BT_ASCS_ASE_STATE_QOS:
 		break;
@@ -1311,7 +1343,9 @@ static bool stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 	 */
 	bap = bt_bap_ref_safe(bap);
 	if (!bap) {
-		bap_stream_detach(stream);
+		if (stream->ops && stream->ops->detach)
+			stream->ops->detach(stream);
+
 		return false;
 	}
 
@@ -2018,7 +2052,8 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	/* Post notification updates */
 	switch (stream->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
-		bap_stream_detach(stream);
+		if (stream->ops && stream->ops->detach)
+			stream->ops->detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
 		bap_stream_io_detach(stream);
@@ -2134,7 +2169,8 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 }
 
 #define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
-	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release) \
+	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release, \
+	_detach) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
@@ -2149,6 +2185,7 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.get_dir = _get_dir,\
 	.get_loc = _get_loc, \
 	.release = _release, \
+	.detach = _detach, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
@@ -2158,28 +2195,28 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release),
+			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release),
+			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_sink_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release),
+			bap_bcast_release, bap_bcast_sink_detach),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_src_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release),
+			bap_bcast_release, bap_bcast_src_detach),
 };
 
 static const struct bt_bap_stream_ops *
-- 
2.39.2

