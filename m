Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B939AC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796482; cv=fail; b=ncohE5/OxVG9TMIpH45nag6IwUyR87Ay7oO0YfytA3pwvZko+hh0TuwwfChBT8T2sg0xiJGudgwCSh8DQnGLhi4dMq5R2f5JCgYm3zO4P8Yk5zwhybBy922cGhiq/w2FTdA+XOJof3w4s+KrPez+elprNLR3yONtDq5gVrpGXUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796482; c=relaxed/simple;
	bh=BtJOKrOdqCprj0yovc1LQQfI8uZFVtWs9JZZKBL8qHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHapQ9urWYTodU4ow+BFldjEBmTfeQjim8RMp6/NnHuvGW96p+9kaPa3YkVB+kqtI9Goe70tldwB+JXK4PZxyRGGR3qZKnjzrg9svZQs/FD6iSmlBnWLMEvgZQw3uBVWqM3wC7EOGxWZmbE+93qL3+rASNp6XAMGRLiKFG7YcoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c9BM6hDU; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9BM6hDU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV6pebizoeQO8Gd7bJqh4CTkJCYdqIPyn1SbxoOKEKrTxzDUbT1+nVoglbNKj3167As1ODyK01ln2CkEFTVUS563XTKh3r+5KakvU9iECLyN3M34qgrxUbowByOk+faw86XArlt17pGR9FPN48oZqpYSNSYTzpQRPYuB1LfDjdh6poWiLu0c/YZCveEck9lQn3VGgh2Qh2twkn/+dTyPD5OZtxXUL+Ij/ptc81HvcAdxw74l9FEFYVoWLqeTOqMMp0aDEbBcZn3ss0o4XD1jEB+LVn2v8oc+h2m20fjQXe+DocgOqwliuSx/Cy0NKkWdmfezdvWoPly0kt3JQ9fFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PZVrN6dULAzICf15J50Nc8jByuY0ZPJYaFHhaeT19o=;
 b=YaBG5RUE2GWRbtJkiiwOVmEdfjgseOA8lPQm4S5xgl6jYDaP1GN35YmOOnXXFD15hbF7uEQtK7gy2B0/BypjgYOF7ZWx6uygo/aI6EtVkjgsvhfePVq022ayYaH72n62hv1U0j8kA/O334nXOHAiLkkZNLHSSsyLtOHk85Z7p/Cw9p20OdbXQuSGA44Q4i3dkQlbAQc/sPWLTc/t8YtDeDmb/7hjzBMAWIgXFuwVT795HuQeA5sZB4xiZ3wPZVuQYUGqjntjzmYpa+CzVUEXxgbdCeAti+/9B1fLxT30M1LJMGKgS7Bahg6U/xn1dZ+LF3soPuFLWuSYNEJOjO5+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PZVrN6dULAzICf15J50Nc8jByuY0ZPJYaFHhaeT19o=;
 b=c9BM6hDUQG3wNgeEot6rq5P19XJpTSrXb4RDp2dy8gf3eozTs8kPWrr94k95c74l0I1fPTVPiWKZqXJ3POGsghRf/xSNbwQ8s1kko4oIWeQwMXwjxwPc8CR5FiKB2v5Qxgx5JW9yQVqW2M4QOMdap6pFBfmBBSAIHh1m3si0oUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10726.eurprd04.prod.outlook.com (2603:10a6:150:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:54:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/6] shared/bap: Remove DISABLING case from bcast state cb
Date: Mon, 27 May 2024 10:54:17 +0300
Message-Id: <20240527075422.18953-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbd82bd-bbed-4468-5d4c-08dc7e223d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bSUOoSf2aG/ATGvDrTnWX3vsxcq9XJirYgOqvsdKu2DOwGoWhqYOcH80ABDj?=
 =?us-ascii?Q?dA+vrz+XKY9k5Oluu2j+L5dYkzbN8gqGXpEq09rl4zg3CUulST3cSz/gYQa8?=
 =?us-ascii?Q?FgdaqknH32CY4M6L3ekAyv/4WPDhq9DS411Aruo0VAZzM5MCVKjX/401kSVQ?=
 =?us-ascii?Q?Vxk1gdviy1mUc5L5h4tovSEs8ijoxAvkDdzpDDvq8s2OkuA7NLNzp5Kt6y0I?=
 =?us-ascii?Q?lVuuE4/Z1Sfz38xr5oBUrAycXN6DAURMP/QBC3cyBJplbYVqGFJEHZaDZEFx?=
 =?us-ascii?Q?f4LCdS0lSE/+U9fCvfPTReVv8OKpPkP+Ob7hTwvF/LQMyuESK12YGTM/B9XL?=
 =?us-ascii?Q?xLsem/8ppvXgDUygRvCoL7gQ/EpaVZQ5rIsB8seK2QS/a8cPaFSp1xoVNXr+?=
 =?us-ascii?Q?bTA84JBe8pCyZC8kAlKBxPoAkna+0JR9rejN7GsgUQcRWi2preVP/1/dGdoK?=
 =?us-ascii?Q?/4tc/tPnfD9O0ZKQ+YiI5wxLN7BFoTYa0Gd4AxXPMDq7o6PnCf06NXrpfUOC?=
 =?us-ascii?Q?sLG38+m2BC+66Xi7F8s0XY0B4o3zfOArJAyfP8m4OtxyxsNEH40ylWPbey/9?=
 =?us-ascii?Q?JRLrJRTdeWw8tU+PFmIwip67MN9CsOQ8EIioYprqskuXDavA2aeSOAm1/lmt?=
 =?us-ascii?Q?kNtvCxUvNLsN04odXYMJyKvEapd5Xoyf3recfh4zc/oiCbHvWDNJ6b24CCib?=
 =?us-ascii?Q?08z+hQqZfuY1tHj4S8haDWA8FoA+sYZsV6N/FEs5Uccpd0yPsixEKLnhhiib?=
 =?us-ascii?Q?syu5frUrHn5Vh+qMbv9u/i5WB+jWCxvA3Mpa5eXT0mMCQTvcHiM/9ebIOPnV?=
 =?us-ascii?Q?QG69eC3Dq3b28S77b2AtE/9ScGg1gNKjIRis/ywMxYhH67fCpzo6UUv5SV8Q?=
 =?us-ascii?Q?Uf1o8bRpqDBgJLv+izuH4W9OMtvw8vmr9zNCh5uJVDLHDho/MChzZPmZZnte?=
 =?us-ascii?Q?H4NU5cYL3TElkVYYRJ0uTRMoYA2WLEjrzgGwEAIouagVlIQwers5eXYrp5Qo?=
 =?us-ascii?Q?8UVLVWh5UzJhoV0eiSYCkbK+fDDQYLK3sh7GFmOIIPKPd6HJR3VVUJfkmxBE?=
 =?us-ascii?Q?F7biLzQEvza1+U7ZnwOoY+9ny3jc+eqsYsqPL8hQ91eEJlEBpSBTPz4FrDqf?=
 =?us-ascii?Q?kUjJxdmsHVrz8DDji5SLSTfgUL0UuWuznFRjycPOwG00RoZHlraMm+xMRUX5?=
 =?us-ascii?Q?LDGext6fyOs8zJe8fO4b3krLcocLPkUur3k7UJJHZmzlmsDSsY1yRp1SsipB?=
 =?us-ascii?Q?Zs7Vi6p+6AW4aegI2seAHXaP0jDO+dCp61Mt7apSjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baFz/z3vPAGgADby/qL3lcLXJv3gVWLZ+hF6hdP9O/OxYBYY8idebzpZ527o?=
 =?us-ascii?Q?UyD9FazhuWI+F84wRdtK0HjKSEWU20giB6LRw3116m/+H4T86uBI6GLOYVAw?=
 =?us-ascii?Q?tyUBb1gIzIzycIatnZVvTPfbV4kylyt5N/xyUsMScSN5wTTuxYJbtbqAyiBl?=
 =?us-ascii?Q?d+ekIhOmIxvA9/eLV5PCsbHie/xSTzoi2RMuV13CXbxS97aw73pIQLH2NM62?=
 =?us-ascii?Q?OEYTDciW5+zil0Vq4wVzJmjh79SE4EvvgabQbexxKErgQdI30D5lPiX7lS+0?=
 =?us-ascii?Q?zEibkVLqf+m/oFkvWh0M6W9R9y9scx3gQCjCnyk+r6PXhIv3tvISNMTZAB2C?=
 =?us-ascii?Q?kZiKBHBbr7KPybdAdNXJi2WPWLp5cZ6pQ20cmllo5fnot4PcP7MoN5wPvUgK?=
 =?us-ascii?Q?dMslUs32/iL1gkReMe7eulTPSxGkaVU4h4cEEt/Ndfbu7ZkOAbrcXnjaV4l9?=
 =?us-ascii?Q?5dwu1/eYxXA3wa9NOEP7KJJWsEZsqyKDR3+tYG8m5DM7gVya6LaYtCSKCDGK?=
 =?us-ascii?Q?AS3q6r5QDkEhQyJ1rrm+i1p3Jw+LSQFoHzz0clGkBeLnSr0wUT12yEpZ0l3G?=
 =?us-ascii?Q?OPp91foQv8t/KnsOheT1Xqpj4jIf8TMmkd5UaqYafOiGPuLOowDHTAFmW/ZS?=
 =?us-ascii?Q?H9IomJsaBjLgDWO3scTglp4Brt235g8v7ojeZkjs3IU8sVG7SaCCG+gvHGRG?=
 =?us-ascii?Q?s4+/nhodSBJylILDEoBROVnJVc7wKeUURg2Os/5lyb2HCzgGBJLEdEmuKefV?=
 =?us-ascii?Q?0gWCritcZ4pq7lcLqtGOm7QdkGByVPYm5R/RoiSkAU7kcL74mOfy7qevwi19?=
 =?us-ascii?Q?wRWeeygJv59wA6qSuLWlshZaxNOoCS6+jY1cQe9WKh+ZaU7czwv9n3i8uzgH?=
 =?us-ascii?Q?5RztBT4vuHPGWtuLemKLrrydYeQRCreoyIDLxT+f25BXl3a1rmo1pcSCvcc4?=
 =?us-ascii?Q?NRGKus/pYXcTgVgI44RRhbaZYIF3PY6L4i90E58lORMReziWTWC9Y6sGVj+9?=
 =?us-ascii?Q?oK/vIymz6zxu+lTzilh1O6Y3QjFQRpI8H1fqIv3ATdw192mi8W9tnGeVoAXt?=
 =?us-ascii?Q?Z6IE25uTOnmfZsggwvONThnC67kqP5/XDyVC9H6kdWpkBJo38tSwJY2dx7VX?=
 =?us-ascii?Q?P0mwwwF5hr0rEfuWIu3znF7Ajw543tLAb+TNFV4migb8g+A8e95lrsxtmtnh?=
 =?us-ascii?Q?/Go98Wid6T+e3Yvv6cxV4VAs617PD9SctywkUUUl7ykSepgThvkTl4CVBZJu?=
 =?us-ascii?Q?RsMPL84U+vgGrqpv4J+BBzTSQMUavfwkNHfn5eGQUlS3iZYNwi7CboHYQNr8?=
 =?us-ascii?Q?82+W4QcnUJJ2HUxU+Wtz9UAtxqGVG1SEkxfwIY7EH7oNLXWDKD39IA7mFrBi?=
 =?us-ascii?Q?npU3Wu+tY06XN5o0Wc98g4utE0ujkz3Cq5XiA/5PbIFMaKVYW8g8y7R9T48m?=
 =?us-ascii?Q?OKfTLEWXVkO5mnTQF15f110xRVM2Rs9ilCwr8Llk7UAxJoCXhibxdmlfy4w9?=
 =?us-ascii?Q?+J6Oe8U/IkwHS9W7XYrCNMZ+8bB7BPQWwX7mpkEwt8yNaRjX/vDD6TBOcgfa?=
 =?us-ascii?Q?ZVdfVFs1Yax7DN3EGpkxurGgE7r6FepnoLFX64eIfvAwnIIE7bD/iXnNaRZt?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd82bd-bbed-4468-5d4c-08dc7e223d8d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:31.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jubit1kqUIlUcu0G6CUM0fI7ToR3bPHtrxbpxWzgWLWWY9cDpxenkKuwOQf4sGyaiLeCJ21ojjSLjQT2uZ4t7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10726

This removes the switch case for the DISABLING state from
bap_bcast_set_state, since this state is not used for broadcast.
---
 src/shared/bap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 639149520..1d9f59f21 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2056,10 +2056,6 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		if (stream->ops && stream->ops->detach)
 			stream->ops->detach(stream);
 		break;
-	case BT_ASCS_ASE_STATE_DISABLING:
-		bap_stream_io_detach(stream);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		bap_stream_io_detach(stream);
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-- 
2.39.2

