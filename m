Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdEAv9PY"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037FD2
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxGkXsESdNau4/7nrDPgMpaKbhIBjXtXHepbiVR2BisCSFO2wgLs644bV+yhRCHFUwkL/qzS+8+3wwGkilMR6uc2jDj9DdspD1tszXxePv/oDYdROTld/LrvToL17h8lYONkOSbTk/dGYqRwwLrR1xLnVHYt9uQGxCG3dXtQaPLmbivJq7ywrkqsOPr6J6NZd84fLuNlZ2ShAXKVsHttuqi1CxctvDUNSYeujsQzRjd5ZplxNuUyLCuRl2zh401LjQwGyof21LRnIuqc0DRXjs/homcP1WTwXoYlJ/x00C0x/+YAqCqzcOJPgc1P5Kd1qFtU/5leuxVrkEOLZrEu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+D0w+eY1khjEqDJ+HkFzvTjEdjr0ddXMEKVUHpZeBs=;
 b=fAYl5KC3mQdcIryTTGaUlMNwQUhecwoN7Had3c6W5/UHDmhjDDp7ub+W4nbW0Jwc1Z4bO+1vgLeZhgRtLNsx3Yb8de/KVltwkZzvxqiRUxljWToLwDZJZwjRhINEnHasbPSX2gSaF+J+QqtJtA5ve9JSnLNE54gf6POnDeNMmrjbMwoMB6IP/mQql0koBbFU6dOFcuH9NjYBvhk/fxw2jY5NCEuYLdrRjqvRsmSaLMaLOcb97nJCVp0L3xfxZiCTzhqB+n4tgRyRnWiW629ANK5MPuwqA3XCJ1rF1DPA0mUsXDcRdDWEUVhUOtave1bOuU8dOli/sMZDsg8BAcSSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+D0w+eY1khjEqDJ+HkFzvTjEdjr0ddXMEKVUHpZeBs=;
 b=PdEAv9PYiU+PC8l2xDXsuKTTbPY7nAl7ohZ4DTUnxADk4wBaZ5Nn8+EOKCVIbwFZiejP+5VkRsl53lmnjqd3wT8uIFYqjTG/BKjCLBz8FB3/2KoD5LzdnOrh2emQoKjd+hzq/gmlKDvYRvLC+AU95U052Rlwlp92Xc059wOTfYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:08:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 12:08:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 2/5] audio/bap: Fix source+sink endpoint registration
Date: Mon, 20 Nov 2023 14:08:28 +0200
Message-Id: <20231120120831.5353-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
References: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 581668d8-f038-4e87-1030-08dbe9c16ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lrr6tjtw76apKKvmeACnNQF9nSWlMvNwtlvdEepxq3lbCH7TgvGtcB9oEt9mYhxaqHEhDli41KoGEzuQqlRNDExpcx685OCMayOuxXtosmdrsVzlJEoEI2MbGqFIFavGRR4KRivzYAiTpu3811GESDvxM5ElTTdeXsCpeTP3aOmraBKNCq0bccsbBEmVPnPv3Cdgq3akoF7GunYxxMCNRCrDJcO7mLWsmTeLBuj/moQH03riug+Yah43u6n3szZrqlpPlc9PgoJrUt/MITw3E3d62lyqEUwtSKXgqYGfM6kLSToYnWnuKPCrZ7Hk0Yw/EswcW6iOFt8TMvUmtl73vquIG+ZFMTRGNNQDBz32oXUK1Zil5CZZYgTa3Lh0wVtuLQDGeBQjLYTOwisd1aRyH+sTaGu8X8Qc2NXQSQfTtKKkgFU4lKiDy61s/V2Y1qfUKa/VAkI8X7A7PnDykVkZrU5Psc4OxKA2/dzsTeN0A9UOndc+tOScJzoAysLI3tQMDOFv1Te49cJG3MIjd4tPjF3Bn71jT+yLuRpx2BPdSvQUXqDc9Gzh4n114/1Y2Ej6aQUSg7lKcVaiV+VE/dBV7ZlAlDm/M18OwyGA9DFgMn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6512007)(36756003)(6506007)(6666004)(86362001)(2013699003)(6486002)(478600001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zkC1AOAFlruWvnMxmn0Wkhm8zP1bp3QyBeUvjLFayWat5aqrStQIX04TaxS?=
 =?us-ascii?Q?t1A0WpKhCqd7OocgP0/pc50T/1nzRceuu2CdkQbEjYiEAptfS6P0qn35/GvU?=
 =?us-ascii?Q?s9CKC94OQC1VsiyVsj1kvHeOFLCN37RSJsx7W9fN4O9b/nwIdtbEy3qPK4z7?=
 =?us-ascii?Q?fTI5IYwlCxst2cZpNIVKvt9EYKJ5L8M3e2baVi9giW58wSXsGZGtpMLQ4gi5?=
 =?us-ascii?Q?5csLnlAOZ3o3TkR5L9JAetGEgM6z3MWFLbBxBALvcmaBrRoaKS16aZT7E6dp?=
 =?us-ascii?Q?FbkPxEXfRquwTzsOGA2xeO8wzAJb1vxzSfWV52AZzHSBM/zAQI+Gumtoqru+?=
 =?us-ascii?Q?L5zaDeJaWjfB48jww6ErQy9T+vasMmhjEnlw37Kq64CGJuRYhG4XBi87+CRI?=
 =?us-ascii?Q?jGT56ALBcEhYvdHzv6nlq3bm6yz61DFpBYVSFlMdO6B6o2J5d/5PM6XnNW0Y?=
 =?us-ascii?Q?bUjUynQjO3TqYDTggwLDQDSrabTPcwsAPdeatbPtjAbL94DK70VWG+Leg2DM?=
 =?us-ascii?Q?3uKlH9/GeLguCxp4jz8uNwuJAoCUYLXGz5AQaKiRdpv4u+EjhoYw4TueXaac?=
 =?us-ascii?Q?/CsgCXuirsmwSP4nt1bDMFL3vKd4B5QZmNlrl2ieau238DtwnnoNgb1Qlgls?=
 =?us-ascii?Q?JDGMffRQvieUG6XZzf0Jze5Fuh8rVpP4WgoBMWS6xIHpV0hwsxeoz+NiB6fY?=
 =?us-ascii?Q?pzunFKfiF62HE/eCWKmlCX1YNg4ilDm+anx6biu7rH15UWWC5Lm3rOYgCKIu?=
 =?us-ascii?Q?CUYyRJM4G/kd6dX4ShKKCY7hI8nO3kZTmVRNbn8QZAk+mf+MS6g3ezytUxp7?=
 =?us-ascii?Q?uwC72bOAky5z2/+7LFN774+c4rZwdoiuwY3aj3W0E9Fg8yepZlstnSLhNIKZ?=
 =?us-ascii?Q?32seUodNi9XnuhG0uvPuiC90BeY1ESRthIPd26qDYlA5bdBli8GV/o1A6ubt?=
 =?us-ascii?Q?u/f2LgnN38tP8d2Pz7kgwvS4W0ImTtemDtBSe2F4LgYc7tiU0DBetlHRc/IZ?=
 =?us-ascii?Q?GeCAtczZIG35Xi/AmW3RinKTeQkJcOvkvJuwOqAyjeLJSOwN3mFDpA0kKdER?=
 =?us-ascii?Q?JfobbfdsVSQjnMGtFGAlmhM1jds3dVSecjNHJYne6WKsvGafdoCHMl5Kj0dG?=
 =?us-ascii?Q?/KRPj2q4Tbii67mrt6saHb9Qpin1DTH2gp5vpnJWN5D6XH9Oq1HiFe0NqeB+?=
 =?us-ascii?Q?EFVxhrT6IjJ5sEiLDNTvQN7yywxKfeJjxkDDY8wQie1lyDdD4QbEWvuk/fbL?=
 =?us-ascii?Q?//8lHID1FXX35KGQfhliaN/t7dzwbKQz0pDXAXDeLT2F4umwxEHs5jWn1RvK?=
 =?us-ascii?Q?cFstOjD8V5sAloQgSqrjo4XL92zitYkkYlxedMfeKmqzM9cHUokwLH4IRSge?=
 =?us-ascii?Q?5dNeilS4crUU6JC+U4d5VncZVpDrBgdIBC0K5IOaEljJcOCtq0B2EfYwYdeh?=
 =?us-ascii?Q?VnzxAWRC9gH3Zzlz7o3TvFYd4jpamSTgcbEi1NgwVKY0K4+XcsOhRQOR9Uw9?=
 =?us-ascii?Q?g/OxKXCvNgunXzKuXdeTCmIxkSqaOBuaQJPnTW3RhzMkGVPOeuYP/nKI0REF?=
 =?us-ascii?Q?iBN5fu+FcYfhRGt3Z/dX3eiudXPpk1XfmekvSX8E80uXRfzdEraXTD707PxB?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581668d8-f038-4e87-1030-08dbe9c16ef5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:08:40.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axh47OJrt7+TxAUgspTP4X6XmcoyF2VFZ9JzEPg/9wptgyCuAjV5XoEeQnbMzGUzLTkjcO0L4hML3P8vt7UUrkpPghNE3SHHejtXvY9wWVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

From: Claudia Draghicescu <claudia.rosu@nxp.com>

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source

---
 profiles/audio/bap.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 780dff412..44061aa16 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
-	switch (bt_bap_pac_get_type(rpac)) {
+	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
@@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	if (device)
 		ep->data->device = device;
 
-	switch (bt_bap_pac_get_type(rpac)) {
-	case BT_BAP_BCAST_SINK:
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
 		break;
-	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1101,7 +1101,17 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		ep_free(ep);
 		return NULL;
 	}
-	bt_bap_pac_set_user_data(rpac, ep->path);
+
+	/*
+	 * The broadcast source remote endpoint
+	 * has rpac and lpac.
+	 * The broadcast sink remote endpoint requires
+	 * only lpac.
+	 */
+	if (rpac)
+		bt_bap_pac_set_user_data(rpac, ep->path);
+	else
+		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
@@ -1792,7 +1802,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1962,12 +1972,18 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	/*
+	 * If pac type is BT_BAP_BCAST_SOURCE locally create an endpoint
+	 * without a remote pac.
+	 * If pac type is BT_BAP_BCAST_SOURCE and remote then look for a
+	 * local broadcast sink pac locally before creating an endpoint.
+	 */
+	if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
+		(bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE))
+		pac_found_bcast(pac, NULL, user_data);
+	else
+		bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+					pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

