Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CD13B795
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032258; cv=fail; b=V492acok5WvR3/mpQw/jEsSwOpmLOq24vsq2WY4i89xd3vXLWK3Oz9Jj6LfkWty1ZTUIctJPf0RiGhgIVvJphXSpVexVqplhl+Uf+5AmNJ5i/eV8r92D/JhMm7iQLlzl1MmGGVyQ98Bwa/eeR5QF88ySocu52PdWIyMZ/4blmgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032258; c=relaxed/simple;
	bh=Fqu+6fGJfDrDZJAqjYWxft7xn/tmm3KcoJ5IaSPyypY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQp7VSBBRQuFDL9ShWP67qspuIXxHuGI5GJMVGbsUDinQKo172NcrCwLYyhDUPPceflQfdgzG2WVFry/i+Z31mxl894c6IIVwQftKy+raEUdnscpEye9sV2f4skWillEhNfIMwbnwgZ46Loun/RlnlRg7PUDsodXhW84mXOFmeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VceSSMks; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VceSSMks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDDcknXlgJPWQfQ095Pxno7UrO5N0TuakZTobzpEsSjgCtkKjVJ4RSEjNpvCGLFSoPXdz1VKyi300Qn63Y8kuEurZkuI/RUoYQfmk6XoqfeDWcEhP/TBw97Ar/bVG+bosF0V8YC524uZtj8Ncv5rKaAlm1Rv3QTGjfyNCzRpXbQ3XBwoJSTZutCNw4fd9rpX4Tu9AjDU64kNLJMS9HMbFXhOC55ScTPU5eay+IFdJMWV8QAlZNDCcS9ucSMso2fV3qTd3rgrtHvgRmeeWakZf18AksEU7QzFrbdRb8soB8J4W8osDmpsloYARZLg0KYRLmlFoCIQui6RfMZsGNRuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjCxE2VAeAS66NRczCu/XlzAnSq83fX93NJ8stVuZ5Q=;
 b=obUoJv0Bp5zpRM437axBU6Eis4kwaftQXNQFBTY+qrMvzL9XwRQfcYv3tgkipMZ0I8/Dibm7MCoGa16c7ozCIVey900sPwea0zQKldMQCNL2HHeRBdcg3PFk+FnGfFDlyi90v+eH5DH1ULjOIxghZcGW9Hyxpvj5YWcjkPcD/GmZBMyN8Ak6sRsNN0xzVnnKBYjUoHBx3MjbUTjoQaf8riIiP/BC4Tz0m/T82pOQQnCivcKssmKJc2JCaIcwzGat5YY2qJovw/48YZCdVjbfMg42pViytLGj2xlufYgMnB7A2ZDeTWN78ctCH9aoX6RLxQysfRA8iIBF0JHfZaAN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjCxE2VAeAS66NRczCu/XlzAnSq83fX93NJ8stVuZ5Q=;
 b=VceSSMksQ3DhV1HliGtQS6EC4jqH+McnQzLj4icktgrTTMXB20cS5oV2j8gsQ/FB4jlC+/rOgYULA9hY1zFXITwS6TCyFFjCUOK/fiyAViICM3PG6KN8LChy4VdLLJhxmY/BOhAjd87bL5cylocfypEReKnV0MCBWgkneFZVg1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:13 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:13 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 4/7] shared/bap: Add state in stream struct for bcast source
Date: Thu, 15 Feb 2024 23:23:53 +0200
Message-Id: <20240215212356.310301-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:208:14::22) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a536c5-e261-4681-df41-08dc2e6c74c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QeOpbJ5ipIWQ2iRuQerUMwtCl2XadfJOQAnehGbHVh1WhZjPB/U4qrfD395S3vDSdCs6d3pnIObEh0AquPRn6kLq8M5a+Zu9RjCOX+RMsziIVtuaR3t6hdy+aHd2HXoL+kQnMXWBLupAvaPaosTnYJgvfHCp2VSdocOlKZtaoaq8tPYe9+8PvMyIcLlxNrhEQfmHAFShb8INvx6JxTSsKEgMThmUCNqjoiMQFuUEdQoyHfn60CloM9fgUS7olCnSz5xlK2HgVIjFTY+eLjac+cJR1HIHS5jsT+D0XtiiAWacx/kry+77a8ZATheojywdL9MQqvr7XRbIolmVh/DouytaQOb76JNYtkqt9NMXkvGC5oKMxnwB5ybKf2iytzAz3rtTQUbONounYtKyQUN3tiYRaeS91KRefYH9TJcCTnCHUGtZb5HKrEUn3Jl5KihH18+D17rcxiaDBiQL8Bdg6Xp4EQkZ10PcxAc/ljjEGRFARzrIhYA0P+PIzVI3O1JmuvKtV/+F8bccBX5gIxIwMQBalaM0+il79AA5AMszlEEak8GopFnrx4vukvTf+2Rx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCrXL4MnawwYTbBTGECnnmeHvlop9RmT/5Pj8+oKpeMcW4PtNuoDkvDw0hcl?=
 =?us-ascii?Q?3Kqnv3rL008G+O3HoNyg0zsmOtgt5FUkKNiSr72ELII05/F2fsbJNf1qh0cJ?=
 =?us-ascii?Q?GB9fu0tMb5WNG1DYrN6wyMovsRbJTFyR2Kk3fj2y+BL4PHg6wxTwWgdWWnJr?=
 =?us-ascii?Q?bdul024piD+Ez73cD7rO8P2iPj4rrPl9gRuZVrW2IS5xVjr2tGo6vuS/CSgE?=
 =?us-ascii?Q?TNkXnEOLJ8lPup+JZ/0nUmc5s5PT2kSpJ2gwsajUhYmRdQIjrLC1gv3mbX6K?=
 =?us-ascii?Q?bDgvVITStoOdCmCucUEyu5OAFnoGar0V5H+0eBUdgW7qDPR1sov/S32Z2J26?=
 =?us-ascii?Q?9Z5qpH1DwXHTRSJKmTx/SD2ami0cJCO6EsCJL+NON5rERKkk15LDzZcXhSYp?=
 =?us-ascii?Q?J8eatQeh3lAKNqkvS+b6G6zpMedsRsId3LqvInX6dJUerDjy1PHS/xsevXDM?=
 =?us-ascii?Q?3VRtU5Pt6ibIxixo0c6ct3z+rv16SofTV1UMyzq35+ZaWmOUGqGFNm5ubHWX?=
 =?us-ascii?Q?rYgLbLwtZEs1mxTFuFqHzMr69iiDJS5WLFbHMENrRLGMbafAc1JoutHGbX9z?=
 =?us-ascii?Q?qbaw++Y8EQTb3urjUljNwSZ8oEOaInrMFz+DJZdZ6ODb6QBrlJyphi5my2se?=
 =?us-ascii?Q?EKE39yEpwl5WXy1DmT+lhS0TeONEWhQfmmP9Lw2+vaRdShrm7nx4ruz56J2g?=
 =?us-ascii?Q?w9h5VP3RWdSb8AIlW1an7sK7Z6ekZh5lHOlw3c94KgoxKZleV1QPfl+4ERXk?=
 =?us-ascii?Q?NYPwdmR5AePx0pXh9oOpmW0tZ65PBjCCK0ctvdcTwoBUKmS4Ddsd/b6Xtb3c?=
 =?us-ascii?Q?QAt/pkgtNClWynMiKT0gomYV/HPMBl2JeiYoN7gOjkPRoyfqid0LmhVBamFd?=
 =?us-ascii?Q?50bzdk3TDbRx0oMvmxz++U8jKL076/OL1u8H0S0/16+MNXPwmTLDGkMTYKro?=
 =?us-ascii?Q?+mdcUasEg4xbnqnQBkGUKRaZbZ/h5I0ojgocnDxOyS2fJbjSKbX26p4bHeIO?=
 =?us-ascii?Q?NERCKRJuWqWgYsrccGU0tzTkQhtQ7RAeCh3MLaTqrCBYc4n5kNZQPABDl48Q?=
 =?us-ascii?Q?cmPiS4k+5alZtId34le4wT3IM9LfS3DnD5wdj3x2dkbiqok0l3EZjecDrIFx?=
 =?us-ascii?Q?ZnKbxLp2VXY0j8lZr8bl21kJsxDy5bdmU7NUPv/9NPhyYVdw48Q36tk1+wRa?=
 =?us-ascii?Q?8fKBZMU0FXPMtuJ/22Hq4XCBvHN6YvGZ8NLlVYJIRrvCbLE1OoTzBx2Xv1L9?=
 =?us-ascii?Q?4zgRoId7+4vkdLeRX6xkKHrEQqHATuanRK9m+4bONuqKlYt2QdQjPoqZRcrN?=
 =?us-ascii?Q?WQ32zFIexJIDx983amXY9ethxfcsLlFtMKQSoME21cTSgGzJJIRjW9c/0az1?=
 =?us-ascii?Q?hQY45xP599kjNjF4c0WyGnOdt5ykewZXRMDqi2w4jCoBzC8b+WBvku8vYGna?=
 =?us-ascii?Q?Ly4HvcBkJAkXEljGZuCKh1IRoigfTNp6qlJ4CcYjwQB8XmkNWQnOeC0Cw/TK?=
 =?us-ascii?Q?KupvtKEbu+/+efcipIfNS6r5SucAseflNVSEL91TDr3jDyqHxYASxO1pFQMk?=
 =?us-ascii?Q?o/OvI4TVXhDfOFbs3kctqdIoAf6cah1ujq5tlOpI9zZnNwUWRCWCGlaiOFkA?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a536c5-e261-4681-df41-08dc2e6c74c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:13.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwYLX0U9dbqBMe/CM2gMys5JsUshg71ulOCi2uhglscwX/SpSF9OtBt8TQpt8GjM6Z4dwnGnhEsvop6j9buF6tC8jJKot2+34n7TpbBLc6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

Add state support in the stream struct for broadcast source.
---
 src/shared/bap.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a39b95407..524bfa058 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -251,6 +251,8 @@ struct bt_bap_stream {
 	struct bt_bap_stream *link;
 	struct bt_bap_stream_io *io;
 	const struct bt_bap_stream_ops *ops;
+	uint8_t bcast_old_state;
+	uint8_t bcast_state;
 	bool client;
 	void *user_data;
 };
@@ -1271,7 +1273,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
-	struct bt_bap_endpoint *ep = stream->ep;
 	struct bt_bap *bap = stream->bap;
 
 	/* Check if ref_count is already 0 which means detaching is in
@@ -1283,14 +1284,6 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 		return;
 	}
 
-	ep->old_state = ep->state;
-	ep->state = state;
-
-	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
-			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
-
 	if (stream->ops && stream->ops->set_state)
 		stream->ops->set_state(stream, state);
 
@@ -1527,6 +1520,14 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	DBG(stream->bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
 	if (stream->lpac->type == BT_BAP_BCAST_SINK || stream->client)
 		goto done;
 
@@ -1942,22 +1943,25 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
+	stream->bcast_old_state = stream->bcast_state;
+	stream->bcast_state = state;
+
 	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
 			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
+			bt_bap_stream_statestr(stream->bcast_old_state),
+			bt_bap_stream_statestr(stream->bcast_state));
 
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
 
 		if (state->func)
-			state->func(stream, stream->ep->old_state,
-					stream->ep->state, state->data);
+			state->func(stream, stream->bcast_old_state,
+					stream->bcast_state, state->data);
 	}
 
 	/* Post notification updates */
-	switch (stream->ep->state) {
+	switch (stream->bcast_state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		bap_stream_detach(stream);
 		break;
-- 
2.39.2

