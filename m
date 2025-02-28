Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC842702B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758228; cv=fail; b=AUdMkIKNKZPxsPS4kM23g644Bp+15uq4/mUkJj8f4qh0OkzUoyCD9ojTxrXuuRas3YJB9Gf8GFo71YY7EBCspsP1u5y/kjo0UBzhDdhw4V+GqYoSe3k2EJYOIbJZ9H3d85GOi15iuTkd2vVJTY5dCgDHUcWeaa/+sy7j4Ffxom4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758228; c=relaxed/simple;
	bh=c8Y08XK2A9+fJYV50GA5uyU5p5BHan2FoXDhuV5zp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bK8ohJVoUy5JzlekvKNYNZFZC6Sp74um+XRcaPW3Ow8rw594fLLSid0w1MUzSHTIf7QlsGMDdtWJGFsmNWJp6ldBD+6dZQjf1kC0gXipT7WWI5N3iiL11RfMEDBzGq9aaAbGI0ZYO53hF5k5gBwa7I0Jn+vqaBKN4+GnYiNghjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fls3CRxW; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fls3CRxW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOlZvbR1NOIDmZikI61HgKphn9z/ZahEhSHfi4855xl99BFhodJpqfgaWmenZwC2DKHBO0AO+eg94SInmfeiqos4M+9N1HmY5pK0xzQbh1xJb+8y954hrAVM3kmiTjO46zEOOtvvj8fmqKp8FS/QP9z4xLT/GStAhbd4HOXLqgDx2zF93i5X+qFDHEswqS7qfRQb2XI2SIV2bWhjd+T3D6YMyLXUVnhBTRi7Eh0+GdAxWTKw/grWTIbrDMB/1YkZn786rlhbAwSubmKwn7VKXEmV8QeyMgRGyEyXIvW2lslkn4YoGvGFnNV9fihtqXXq/xCHou5VktfLuv6vl4gXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YujP6IWmNsc6M23fBzIrgoN22Fo9QTrk98fOz2Jk7U8=;
 b=xo3Rd0mraH0IQ46Hg9AeGtlNm7U0F6eZ56x44DnjeA4cCyUlf0r2XAZgkP8p9bQZFv9WRNrkbbkouyhA9LfG/sAIvXC25fbMqK99ObVFiUIJhWsRThpXZgMNXVeQ4nCZmPNjov/KaRg1pbC4bYEk7aIDU7bn25B/m8tzGSb3GhwV0HU68/uBFpRpssukIeBN4avytczcvPXmv9nkuooIAV5xODlMCrsaDORZFh0OdA2LBczYZ2meuNKdOF6d7cgut+7yDvp8iUOjHuNrOGN/VX8pPRj3cG3k8tybKX7zrAJLru4Kz0Fp02+eq966T2gD3htS9P9l9uLiDUJWjyt74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YujP6IWmNsc6M23fBzIrgoN22Fo9QTrk98fOz2Jk7U8=;
 b=fls3CRxWisMl/Dy5KWwe+DkkN4olwD+nGB16bB07UqX2Yn/Ci/izTMqBB+g61NUVKJOn2GCj/4g0wQnn5SfWm2Aw0471nD9dkDilMfXoVPSUIbFXCWZMNddeXhB0C0CrBRqR3SVW6yyeXIDXnzaVQdlywso4XgvN9pKjRj2bu0KzuFLg0g6Q/CXfz3ryYbipvjhJurJiPzB4Q6FlyfUVaCQWd8zDKr8QyMQqrStRNAC0q7OprJVBJVbqkswcoeCEFJZDBe0TKeyLIkRurt/nvuelkuY/W30I61M9rvB7MIQc0FIrkoy2ZQKDc7P608WQOb37/d2bOZtiBPY1iBN7TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:57:05 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:57:05 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] bass: Register broadcast code request callback
Date: Fri, 28 Feb 2025 17:56:33 +0200
Message-ID: <20250228155634.57979-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
References: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0095.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 977ed1cb-b649-4b79-64c8-08dd58108c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUu0YsAeQOoYZL2G7VJQPLB4/iPxAoDBrdPy+gygdAUGWoleZHWK74G3YPvA?=
 =?us-ascii?Q?qUh7PC+0LYCd0Y7vCvZDZZ+q1gXDR4joxGJnAFajIftWzaRXfibG+aWqs+47?=
 =?us-ascii?Q?KE2D2AvhHSweXcm26r5R36jLBvt1+8RQLxsn365MMd+ZVpu+viVEP3h+LTsI?=
 =?us-ascii?Q?dOZZuPjZ9WbBSOwDa0NNBHfcLOm7ailWuh7FgGHtnC9qqWMktILHFx06HLHu?=
 =?us-ascii?Q?NZGEllzwryczcs27tZORN0Nen4JLUsxlZY3AUQFNdqto4C8fQTK7gG4CG5Po?=
 =?us-ascii?Q?ZKJImqBD1yR+G1hboF8eSK9MxLskpKx7j/EY3Py3ykMOUCbprPiJ+ACT0Dat?=
 =?us-ascii?Q?kvyV/HQbziyRjfLDLdNjgS2Y6d7ruTTubHxS2z5oLVATfCX7t2eRvqPw+3Lc?=
 =?us-ascii?Q?a18kmTsplnWmHyNj7vga64NkbvUrchEMQj+fY2Or/QabS/rebOQUq8jI9nks?=
 =?us-ascii?Q?2hgMoHj/0STu0EmxiN40urlGv3BdW2LQglctqv1o6Qbgm9ya48oGVL27+HLz?=
 =?us-ascii?Q?qSb9LOLCvuSG3SETdh1EL3Ybw4b/H8j21/9MusYTV+lLb/fsQY7JlEDS9P7w?=
 =?us-ascii?Q?DkBlQTkpneKq5I9QnXBi21Tu9VwHyQjOLZCIAoImajddt7zLJFiSqfhyR/2x?=
 =?us-ascii?Q?2Z7AMwAVg7Go2VX8zaFvLqC8WTG8CW80xl4MYXtClZbcKtslJzlwOTcTSXmr?=
 =?us-ascii?Q?llzGcOsDVneY/xXXkrvASRhBeXagyR+Koklf1T+FKS/HsnqikM39S4SYa/up?=
 =?us-ascii?Q?eBRRCZnhML+XqF+/NdTVgO1xQRx80ynAoxwtabhpf+m+ihslQEBjUuuE291o?=
 =?us-ascii?Q?WAdwtkJIJ/zkQVuGMa4yU6+RJgaaAXVAii4sC+uHo7pKFA4iSZ9ebYqOVw+r?=
 =?us-ascii?Q?zQTmPwlRQs+k9X5K/4NgoVMA4Qn61u7uyODaLeS7P+MOIAxX8VobEvPFOKTT?=
 =?us-ascii?Q?2qA+rjadg82FS1KKMHJOM5oFl3qMPqh1ZlZRRX9W+1f0Yap/PuWgIZ2hy6Qu?=
 =?us-ascii?Q?JPsLbBErudWeu+vE/cb35dga5TAcjad3tuCkEYcQ3SW31BXEyfY5YeQcTLiZ?=
 =?us-ascii?Q?CsISVvGvsjYSapPjnbAhS5VwbL8e+a0MqRpZvVUanKsln11Egq6B9kh6rV1c?=
 =?us-ascii?Q?n5w9DdOzYGBryB8nP6GH7cbBJ91F0VV8SXzuFf2nns3+mmBISo3r4izf0DGV?=
 =?us-ascii?Q?aJAhmngE91eaDJE+aBfj87nxlWf35dndIEawIctkTCWXNFCa8c8/kopL53gA?=
 =?us-ascii?Q?uX7EGaFUmRgqBMZj0OOmX1F0K7A+5+jXoKwWgHooB8RjgInABaCmZNEidsH3?=
 =?us-ascii?Q?v9kB3o9Kw2ln7DgCoZgaMk6fQZeFmPcxew93wEvCVhOWKjfKW4ora80sXbNT?=
 =?us-ascii?Q?YeLv8gXkvlcYyxgnNWeuSr2wLqUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhnSA0fRufcEkY0oyHNJaoG40U72EBMVWGxwXKURtjpn5k/6lsiGmb1eohAg?=
 =?us-ascii?Q?m1gZ9Tyd5HIjafa9fr/qNc8kr8AOv0tU/iZEh5FpmoB53i201WlxP7wUAnf7?=
 =?us-ascii?Q?xJz4ND7LuNy/PxDFZvNgjyXKJwvAYN4c6YFIE8r55cCDsyHDbwMFaIlHcYBi?=
 =?us-ascii?Q?sywKyOPsEx73urQ3eZlpGRDOZ6pXohWSFqfS6o78a5JzN+hienE/FUyXEWNU?=
 =?us-ascii?Q?/u82VbuKRhHDznmMNbe2FWUoek2csv7t1/7Mniz+VFbVU47zb0cbQjfVS5fK?=
 =?us-ascii?Q?trjR1nql+2L2pFeJv0KD4khU8boiJP028p/HXKO8NQUTWZXS2o+zoeT9yRHf?=
 =?us-ascii?Q?gJChEhnGKDWM2MOkoaqRUhhScTf0TEATGcESaon7RtYYeOlSLYgDb7RwhjRb?=
 =?us-ascii?Q?BHOMGLlLIMJ1d/WYcvxOQTViMynuLvEPRP7cimV8cBDu4/kWdCMwerFUs0Wm?=
 =?us-ascii?Q?6Gie4B3PiM08colDuHnhZgxejzbOmwbhAEYt/Ggb2us+CHKxZRaWkimdpr05?=
 =?us-ascii?Q?xeRZSYPv63P3hz0mOVResqhZAc21vaYaM9k9Mut9DEt5NUK+d2YPsragtBlc?=
 =?us-ascii?Q?T3j0CsFDCm09TJlXv5HTVdyMfK2UzS8K/JBolVBuYU8QMaMunTKTO9ncCDFx?=
 =?us-ascii?Q?/lmsotVowQSUASPeHpx8qtjePFNvjnBjwKXdyRqBBikY3Vef8bt4bScjg6rp?=
 =?us-ascii?Q?nuw5lCzBaz2K+RO//0wtsNwrcTT+Ym/l5PHjRXZsDprVlCysMrN1hKxALptz?=
 =?us-ascii?Q?O+dmtPfNSwYLbz9UuL7uP912Z6jGnXyYSZDnH+d8B++MNrgp49njJF2hclYH?=
 =?us-ascii?Q?dDe4f7Xnk88mlXqswyaLL9zMQGzFzNyR+it8irRV2UIhWPNjzr4OC3ViEKcW?=
 =?us-ascii?Q?k1gUxXqfK3EM1S4QUzDAnjkotQHgETefUELVdYAbSyADP3wUuPjk9WdGIpdi?=
 =?us-ascii?Q?XdbWYQof8p2KMuu4ntgHbXf1PUoMFU1fTv07eWwBE7yRh7rGG3hYGT+vcGWJ?=
 =?us-ascii?Q?ssPebunvMuz2D9Yg5AvrntWFHMhYBvIJY8+0jZfWcbjS73UFUI7xAnc4KkqP?=
 =?us-ascii?Q?gg3kD+Pm4NNZtJUFuW7nNM35mCXq3DtW1bKHuQuKD5JS5T+CpR9WYQE7z5rT?=
 =?us-ascii?Q?FR95L1sApdAjIUeYSV6Bz82PtwIz2UNUF/KQaf7Od9MgOhg4dUV5eZJ9aEfs?=
 =?us-ascii?Q?WGybWA6HoVVMhyeQmHp54577pelcynzSoYGNObTdWVXALMI5uip8qptWzk8j?=
 =?us-ascii?Q?XtK1phlKPSsZLCcfRofbRrpOxIyOCRFLEKV7C12sg8KRXyk1oCw6rgIvzUft?=
 =?us-ascii?Q?HOT4B/PeShorHToRgW+yrWZzWNnEhxaK3xT7dw4KKyXfiCheeQfKHyZkYK8O?=
 =?us-ascii?Q?NgX4Wn2QQEGaIVvOXHn8DIU7ZNZMELes5Tn5z0J5kDSHI6A02Vji/if7afh5?=
 =?us-ascii?Q?4rWj/pY4WDQF2WH5wkxQP9IFFA2GqH/KIoEVb17X6RCQWmCYRKW1bZ4RAUL9?=
 =?us-ascii?Q?bxeJZDQIF+bMHRMuXmw0LthndMw06luVQl/AhDMHepDJb9iTY7q8/9CAF+P3?=
 =?us-ascii?Q?4JJblz4CVxIzgCUv+B+Imvx8YWhSwsS91pKUZk0mBp8dhMsc+up8g34SFJWO?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977ed1cb-b649-4b79-64c8-08dd58108c2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:57:05.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0P4CnLOTMLZqq2I5hLSR6yA3VOOQv7tNT+S0q8HoVJTNnrpgo12EFFCNdOe/tUwZy2BTj+Z74v2YURrHorAxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This updates BASS to register Broadcast Code request callback with
shared/bap instead of having a public API, to avoid making direct calls
between plugins. The registered handler will be called from the transport
plugin via shared/bap.
---
 profiles/audio/bass.c      | 29 +++++++++++++++++++----------
 profiles/audio/bass.h      |  5 -----
 profiles/audio/transport.c |  4 ++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index f5fe60652..ec5b88ff3 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -108,6 +108,7 @@ struct bass_delegator {
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
 	unsigned int state_id;
+	unsigned int bcode_id;
 	uint8_t *bcode;
 	unsigned int timeout;
 	struct queue *bcode_reqs;
@@ -128,7 +129,7 @@ struct bass_setup {
 
 struct bass_bcode_req {
 	struct bass_setup *setup;
-	bt_bass_bcode_func_t cb;
+	bt_bap_bcode_reply_t cb;
 	void *user_data;
 };
 
@@ -180,7 +181,7 @@ static bool delegator_match_bap(const void *data, const void *match_data)
 }
 
 static void setup_set_bcode(uint8_t *bcode, struct bass_setup *setup,
-				bt_bass_bcode_func_t cb, void *user_data)
+				bt_bap_bcode_reply_t cb, void *user_data)
 {
 	struct bt_bap_qos *qos = bt_bap_stream_get_qos(setup->stream);
 
@@ -203,9 +204,9 @@ static bool match_setup_stream(const void *data, const void *user_data)
 	return setup->stream == stream;
 }
 
-void bass_req_bcode(struct bt_bap_stream *stream,
-				bt_bass_bcode_func_t cb,
-				void *user_data)
+static void bass_req_bcode(struct bt_bap_stream *stream,
+	bt_bap_bcode_reply_t reply, void *reply_data,
+	void *user_data)
 {
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
 	struct bass_delegator *dg;
@@ -214,19 +215,19 @@ void bass_req_bcode(struct bt_bap_stream *stream,
 
 	dg = queue_find(delegators, delegator_match_bap, bap);
 	if (!dg) {
-		cb(user_data, -EINVAL);
+		reply(reply_data, -EINVAL);
 		return;
 	}
 
 	setup = queue_find(dg->setups, match_setup_stream, stream);
 	if (!setup) {
-		cb(user_data, -EINVAL);
+		reply(reply_data, -EINVAL);
 		return;
 	}
 
 	if (dg->bcode) {
 		/* Broadcast Code has already been received before. */
-		setup_set_bcode(dg->bcode, setup, cb, user_data);
+		setup_set_bcode(dg->bcode, setup, reply, reply_data);
 		return;
 	}
 
@@ -239,8 +240,8 @@ void bass_req_bcode(struct bt_bap_stream *stream,
 		return;
 
 	req->setup = setup;
-	req->cb = cb;
-	req->user_data = user_data;
+	req->cb = reply;
+	req->user_data = reply_data;
 
 	queue_push_tail(dg->bcode_reqs, req);
 
@@ -564,6 +565,12 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 	dg->state_id = bt_bap_state_register(dg->bap, bap_state_changed,
 			NULL, dg, NULL);
 
+	/* Register callback to handle Broadcast Code requests from
+	 * upper layers.
+	 */
+	dg->bcode_id = bt_bap_bcode_cb_register(dg->bap, bass_req_bcode,
+							NULL, NULL);
+
 	dg->io_id = g_io_add_watch(io, G_IO_OUT, big_info_cb, dg);
 }
 
@@ -716,6 +723,8 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	/* Unregister BAP stream state changed callback. */
 	bt_bap_state_unregister(dg->bap, dg->state_id);
 
+	bt_bap_bcode_cb_unregister(dg->bap, dg->bcode_id);
+
 	if (dg->timeout)
 		g_source_remove(dg->timeout);
 
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 42a2c047f..32c7e4def 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -7,8 +7,3 @@
  *
  */
 
-typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
-
-void bass_req_bcode(struct bt_bap_stream *stream,
-				bt_bass_bcode_func_t cb,
-				void *user_data);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f3ac1a251..bc7ee6e45 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  *
  */
@@ -1537,7 +1537,7 @@ static void set_bcast_qos(const GDBusPropertyTable *property,
 			 * for the encrypted stream, request the code from
 			 * Broadcast Assistants, if any are available.
 			 */
-			bass_req_bcode(bap->stream, bcast_qos_set,
+			bt_bap_req_bcode(bap->stream, bcast_qos_set,
 						GUINT_TO_POINTER(id));
 			return;
 		}
-- 
2.43.0

