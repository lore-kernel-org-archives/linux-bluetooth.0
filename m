Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84912F5A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686765; cv=fail; b=svtYVamPzMhykXcJI7bffU+xplxJvKoSxfPuNmMfpXEr7RWoi5uEGmrvapsQ1sijndvaa3RK8dP2gBIGBXmuFaluGmyXGR0B9pb5/fQykek1kYnSMgxzVi48wNRF2iUYK2x+EZhH70TAoTShiFLlsJdAJnVwy7xzOfIdzmXlxK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686765; c=relaxed/simple;
	bh=AuXAhhZaUgWTaG4OyyPAY6Q5l1tIdVe0fOq7UlBJdIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxW0Rjc/ckl68Vc/mnAEjN2umKrAH62cSEVZHpKU1hnzG6fmG7eOo7syzZt5ePigIUe8oKxLDiEEQAXO7coRsLSQMFcc6sMB2dK7SI5sEQU8WtZ1O7x3rGoo3xl7GKMuWh93mILOERvoDzZSWHi1liY2JsOawOLs03JW4AMAV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLMnRaKC; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLMnRaKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAfBKH6muAn9AOfYkt/L2qtzFHUqAgAKJZJsKF1cqDTVRIePWh7Y/wxyCai+xhNIbXnrhDC55r8NdUJfHfp/B4EQtCbrBxj5nuKoTmw/09otc47bunbHc+nFR02DFZ0OuUAzgz/mzNnVncBoRICr1/9kCb9fdxVj5n69V0ZjAnQjvYtLB+7vDxO8g6TEELvQu8vH3XxqyONcB1UrmjPLEvcqOG1PDxOuBNC1EwTTmKlMD9+4ew6Y0DZDmEvSM2oGiX1cNmFvgQ92u0gw39w/fXQzysLXlVQpoZaJSZWR6Kyr9ekccHF0weZg+gI5e9wYj53U0IXuZh82cFBOczuBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ZkqtllrkAODd7p2UrxVx7FlM4lxG2QgQjtLpurZGI=;
 b=jw35GRlZNWGhodEI4fNtfiuPyGN+8A85yIHnLWieEfKfkUnEx3PrmFZlvtRrQfEz0uoMhhNmkXD/Y7rAV6sdgWs4B0Zocewf9yjzWdGjXh0aPLgcAZYtSDdk798s5FCpKo2jGYYyuS/4m463mW83UxnP11CVUZmnsUyPH83pIfzbvNBlH5ZpZ8aJkUGZLtyhlAo79WP2xkAzXligxonY97Y/dzGFh3uWB8jn8CboK7wgt5JPjI12TO6XWqQ/0ixT6EVX91fUECLo1yGCn1QdWRELIOSkR6auFbjyYh1tfdkpPu1Y1Usy/YVQxWvvVStywgENiwX1b0GpHiLZO8l34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3ZkqtllrkAODd7p2UrxVx7FlM4lxG2QgQjtLpurZGI=;
 b=HLMnRaKCPSjCQwcCsCZLxCr4Eobc4X+gVVtC99sd/oeUTLLZRzMnvyXBssw263nXw2Yh04naCcWlKWwaDEsBjpwKzHjhlNLG0YzUsjaJAvwirISTVpNKos1ZzV/REk1b+Y5HerP4exqQ1ZJiqLeTdBUtN705N0P7wN7yNzKMMVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8618.eurprd04.prod.outlook.com (2603:10a6:20b:439::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:39:20 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 11:39:20 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 1/2] shared/bap: Update stream management to avoid PACs
Date: Tue, 14 May 2024 14:39:13 +0300
Message-Id: <20240514113914.21048-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514113914.21048-1-andrei.istodorescu@nxp.com>
References: <20240514113914.21048-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0306.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::15) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b20d4d-16bb-4c0c-29eb-08dc740a7e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSlclWxjQrwNxTdGrlkPr10L4XXHtTSGJIcqbKUxsKH3aqJgxx2KSCXCMvcb?=
 =?us-ascii?Q?gpQqgFmhUJ1HhsxT1QiOiiGtFuS+eTcoAn67VA2dcZCq5ckMypMuI+zaKART?=
 =?us-ascii?Q?zvrPYSZUH6oivWxxfWSSrm518WiAnBhmy0s4HymQ7AdflaxaXABOCP7FwTkq?=
 =?us-ascii?Q?qhMBtSHeOYAcmEP8kD+wESYEqx0etn8Lu9IIyudlgu79Sn3+PRDCbjqEFnzC?=
 =?us-ascii?Q?3gPIExHhkyA/RTnYHZ4abu9nw4r/28SI6/FHoZvXXVc1Mvu3plCc8/M5JGP7?=
 =?us-ascii?Q?pwtAmL2fmHBVOU6LnscWi+j7MuYbnN5OocBz2ltLS9N4LsOREoxxyeZx2NSR?=
 =?us-ascii?Q?0LYdx47X8BaQZ4cCgLAXEV+ftsa/FEutirTx63IL0HUp6t/dOa+eXulYZERl?=
 =?us-ascii?Q?5IWM0gWJb6lVUPCfYX9yxnKnfwo71pzfOdY47xOd4/hjgyOb+FIa7DgZK9+P?=
 =?us-ascii?Q?RDi8kFYXQjdZTgKGPRc6VkgZtLxb+a0iC7n6RVYyb6M4x43QA7b1AxF970i6?=
 =?us-ascii?Q?vsl2DjjFqxbJYis6+v1PAj2epCj2k3xDYQnYQIoGUlzJcVUOUmQigPW09QNm?=
 =?us-ascii?Q?vM+nn0pjqC0vHy8Iq8hdlCTOJTJXMWqZpeMP+J+go0T5Jv7dL5c9Lv/M1jU0?=
 =?us-ascii?Q?X34fmuFpbgLBxIXW0dJTXf1zyoN15hGUExcQOPqmqh6f1DXSpGhJwQwUey3I?=
 =?us-ascii?Q?Mh3t6c4+v0BXjmo/mrKTXSId8obtFKfbeUOW0GghnBqtIdDnvEMgxAaVZlRo?=
 =?us-ascii?Q?T/F4GUcRKi/VBH6mmdNyUJ+HKVZObitv98nEpT5eqzMSW+X6UIkLEsXXuoi9?=
 =?us-ascii?Q?haFnXC7VlI73C6b25087++4rTUDrI5vsNXnpzb/nWXOVakdfW1XCReQslIH4?=
 =?us-ascii?Q?EJl8k0m2z9PcIPXreNgbBjhdm25FjmXAycT4zST4aYcrPZKJXFqrJSR0CN3V?=
 =?us-ascii?Q?vJPSgdll9BE3/dcCHoFscrNH1mkavSkq2jlLppNJ6oa63oZa4y5YPyKnv5S7?=
 =?us-ascii?Q?u1dNy5ghDFqhtiqQEuNcAYx6wH4eC0C7rpW7fEh6HcA5+Vd7DKC9sjR68b4j?=
 =?us-ascii?Q?lw6KI/jdmxx2nbwGfwy64Wjzr+qBWSZ0OCF6I38PW8PHjl89s3CKO668BoM9?=
 =?us-ascii?Q?ROvDu4DuFRJM59DkajzN7WWZ5xTkS5+RY8aYnJoq9xYCIc6ZBk7YjAOyqgL1?=
 =?us-ascii?Q?3o5buTfq3W/UAqQ3l8n4LVKCs3hmMijOVPBMsf6pfrTquhoOV3Cc17pmPHh7?=
 =?us-ascii?Q?8AnoPZhDx+D4dEPzNlTaKg6epUMJ1DmSXAQVJlOrNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIKeLzIWUwMwhHEe51V1BPsE1wge3JpL9KNjWUZeDZiWpohM6pNUVfyzjiNv?=
 =?us-ascii?Q?gLtlgm1lPhugC8klWhSIz5MG9An6ACe0QBOMF7C2/SHDLqP+f/nF1+Ax3Enm?=
 =?us-ascii?Q?FgqBdVQBFlLBxg37nY5s4Hnvr+Tj36pmba07t1j6iqBbMW6yTs9Qm9SKGmZT?=
 =?us-ascii?Q?vTg+qJNXxRXwwObZyWKfHcXpmA8qZIVemHGoGYAGiuOIxBKXLfvq3JGUFc18?=
 =?us-ascii?Q?whJ0SlJi4wPY7DryPjvsqtxOtqi3RNbB3hCJjPbsnITf7hjS+oFg+qnYSuAY?=
 =?us-ascii?Q?ltJZmzcI6KqqETuRJ4kWK4Yu6g4gSSFWA9R72FlK08PLYaVLdRT7Lhncv5vU?=
 =?us-ascii?Q?UM2DxuIMmAnoiVj8HvLaQ/FAoAH2LP3I68gwuhDq4gg455/tN0fes0s0rAMX?=
 =?us-ascii?Q?+GasquyUPXCrm7Q51i6FZUfEU+dTrKlvgP3PgigRUzXBmxx3/RU62kfN9aHG?=
 =?us-ascii?Q?Ll7WXVM8LCFdPyu1S73F5bD+QBn1+0mt0aqBsDNoOVAsQcIEDcoTjXHC3JZh?=
 =?us-ascii?Q?A2h4zJ11/td3ptyL8CuKq2X424/tnfkrvMlcMHhA7rHwCh//sc2nUsjhdbo7?=
 =?us-ascii?Q?lfzBBMw7mX/603TgnxOoUi22iTgbuzIfyD0MmaSvi0x6sdLSoSE6AkALZtGm?=
 =?us-ascii?Q?ai6Y37Z6E/OAEd3sHUnu65JjJ/l5ZuoL7ySRTNUojGwbQ15voI20S9v0MOfQ?=
 =?us-ascii?Q?0V0Je8dDSjISVUV639SiGSrIomo4xs/3UcFTQAMlpPIyYRvjBBcMYm4bjVV5?=
 =?us-ascii?Q?YcRrIgzICt+9MHhPR86noNLh7ls0YxfVk/NkcyXY3ORXPqtmv5XpWlk19sqz?=
 =?us-ascii?Q?MtTCX09QK4N4NV/PIKGZQn+X7WPAR+b0BquvUch46BtHQ6FdNZB/aIyVP2Ph?=
 =?us-ascii?Q?VmRrPdaoGegpxQx0NB8QFbPTjdnIMZt8cawPb22lbb/sArBFTuBHLZvp1A+9?=
 =?us-ascii?Q?k+dspUxbNMrEBKQGAzO9EsAtDgTrr1xwWrsfXo0LSreusHIiM9KX82MRKV64?=
 =?us-ascii?Q?vZB9zlT8cIZIjuZhcwuUKsPN0I2zJyvcCfUf4X9ISM/Y6PJRKLyp/vXpi3ba?=
 =?us-ascii?Q?yRxfYVhXnrPtQWqNffBWL8wZX7KI7/LCo+sCb3fo0wybQWdj0dfEFYuhMzic?=
 =?us-ascii?Q?8QcJdElWFsKJppeZg6slWwqOS4PqJeHXtLdX3nbk9TKkcEM9pDlH0IExoJ9c?=
 =?us-ascii?Q?lc2KiqH4qOFcJQ52C8pYS87HfqmL6ig3SHabJerkiD82zlE/ImbcL85vUUUb?=
 =?us-ascii?Q?XSHuYbW54hc1qXIzG2YtTBEcnugN3+XAi+sPIEp+vFJV28xcXy9I2PbzPW0L?=
 =?us-ascii?Q?Fzooee8R7q9YndwjpuSQvFznzupNS3SUwF9nlq14fb53rs0DrJvD5+juhq2Q?=
 =?us-ascii?Q?wxTqiKakUEAaKTELZ5wbrI+MzEgQwKDS5UaNY3ac0u/T67v6luEV9SN5Z8qs?=
 =?us-ascii?Q?mO8oOve+MO9532fpd/v15oDv3MPVFulfY5XpfiWhElFYCLBkLzDrW/UKkRzr?=
 =?us-ascii?Q?p4FrtSUZPZt8uV6qkq8OYvby3w1PjUKgFv/zajC4NsMuSJiRHMtuGI6yp3wd?=
 =?us-ascii?Q?aZOPgjQfzPsgQ0UrCN8Kyi3qs1sgurJxPSwYZR0BIUDZdIYZB6I26wSsUIgr?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b20d4d-16bb-4c0c-29eb-08dc740a7e95
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:39:20.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQTJcD5K9l2FRGykJ96zMR+/BIhZ+9DG7nS3ukwG2hAN3Z8PxALHrrfaP57O90vol0JBNagl10ZRSTw5yZcsx5IfF6e0/Za0VKCY+NUtdes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8618

Remove PAC logic for BAP Broadcast Sink stream creation.
---
 src/shared/bap.c | 63 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1316d7c73d02..919ecbb6a016 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2005,10 +2005,7 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
-	else
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -5287,7 +5284,6 @@ void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
@@ -5298,71 +5294,24 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 	if (!bap)
 		return NULL;
 
-	if (!rpac && (lpac->type != BT_BAP_BCAST_SOURCE)
-		&& queue_isempty(bap->remote_eps))
-		return NULL;
-
-	if (lpac && rpac) {
-		if ((rpac->type != BT_BAP_BCAST_SOURCE)
-			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
-			return NULL;
-	} else {
-		uint8_t type;
-
+	if (lpac->type == BT_BAP_BCAST_SOURCE) {
 		match.lpac = lpac;
-		match.rpac = rpac;
+		match.rpac = NULL;
 		memset(&match.codec, 0, sizeof(match.codec));
 
-		if (rpac)
-			type = rpac->type;
-		else if (lpac) {
-			switch (lpac->type) {
-			case BT_BAP_BCAST_SOURCE:
-				type = BT_BAP_BCAST_SINK;
-				break;
-			case BT_BAP_BCAST_SINK:
-				type = BT_BAP_BCAST_SOURCE;
-				break;
-			default:
-				return NULL;
-			}
-		} else
-			return NULL;
-
-		bt_bap_foreach_pac(bap, type, match_pac, &match);
+		bt_bap_foreach_pac(bap, BT_BAP_BCAST_SINK, match_pac, &match);
 		if ((!match.lpac) || (!lpac))
 			return NULL;
-		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
-			return NULL;
 
 		lpac = match.lpac;
-		rpac = match.rpac;
-	}
 
-	match.lpac = lpac;
-	match.rpac = rpac;
-
-	if (lpac->type != BT_BAP_BCAST_SOURCE) {
-		/* Check for existing stream */
-		ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
-		if (!ep) {
-			/* Check for unused ASE */
-			ep = queue_find(bap->remote_eps, find_ep_unused,
-					&match);
-			if (!ep) {
-				DBG(bap, "Unable to find unused ASE");
-				return NULL;
-			}
-		}
-		stream = ep->stream;
-	} else {
 		ep = queue_find(bap->remote_eps, find_ep_source, NULL);
 		if (!ep)
 			return NULL;
 	}
 
 	if (!stream)
-		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
+		stream = bap_stream_new(bap, ep, lpac, NULL, data, true);
 
 	return stream;
 }
@@ -5415,7 +5364,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (bt_bap_get_att(bap))
 		return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
 
-	return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
+	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
-- 
2.40.1

