Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04E626B5
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801331; cv=fail; b=Bnu2AxjevRe72MvkbANNvty9m0YoQbPnnat9Zn35clAvsY/fBSuNn+1FZmbmyNbwXirqkoqW4bewRbcLxWq1HgKw3wbSFFFYlTqhZOaSkY8lGqEfEUJqJJT9mTDuIZF9FFu6wPkwcgMt16n0bLEAsFReawqX7Hdc1z0E8MiR70E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801331; c=relaxed/simple;
	bh=DzYScYs5CwiCjM1lmpfstQ5fMbl1LyupE6olmMckZdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lo/llMrAmjmpPTepvYjEQQc21Sg3iQELUQZseRdTClgdnu3UKXY0741ivA8GwUeaDw/z1kOUCCKAwcMtJftcy+/hrdxvVAKNIvRWVRp6R1GpaGGXbaKWZFSEKrctxmkRlj1dx52nGcdxfGq7A1em4BqMyyAbgAkBcE9d/Y80af0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oxcQ0k8O; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oxcQ0k8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afb+/JcOHUsjmwLN2CxLhVbzMBx+a5pjkSCShgHS3rRkwCZYcC4tCrN++1EsZUb8NcbgXvof3UZapmgQOwF+BDz20ncwx5vcdQWIkoIX/xlenDh+3vlAwHTUPHZsNMkg6IkOAMhMtUDSDrz4g744ka6PwpsWqHmKExktvLwRp76JAGJWkCh/iL279Ca9vjo4hhzJBsZCQjX6cJJE8nEVSxdWYVxQEqYB9OZ+itbIudkHv4KiRPJewbWJAidaVBej1CUtUMAVhiB/xbCabFXWsL4GPzPQMFBxYrHCC+pfL/nl8DismHz46PJZ3lwhhXPe3zLjLm3iZ4JDwvuZuAO/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGbWGgkwWR63iLlImqRYYfSQ++iMxnFJJbOJGFWTREc=;
 b=m/8110aMj8h11njqiSaToZTUXB/KX1G0n6i7jNVAGTOb5w9q2rFXV5wDQLLs3YNWwrwEFJwhNg26YBqBGG835YK80vQN+6gyhr6t85h0qnnX3mrJL6L3lS7LHvIax/E7zD7X0Ar20D4dGlTafxMxJ1S2nUIcq7g7vmcnEPSGsp6CSVAhl5lzdu3zJ0zGYvQ1CxjsomEQQgdq8J3f7htZo27TI5LBnRKFFV44kVhlnaEM/PxRoCcMheyLxPGReT7Libg9FuDSyZXll3wYJfDjyoNioqvkeD647Qi5W2oaSGyvR9n0IYJJNynb8Nm9cZqJPVIDmLoxamXwZnaahwsVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGbWGgkwWR63iLlImqRYYfSQ++iMxnFJJbOJGFWTREc=;
 b=oxcQ0k8OAlLIx1OEkWmoE+kpt2l9puI6mCydkjzLWXLQY5FxWlXkINNlnEr9ZpJQRhA4Mvk1wFyq1lNHsz5ZUWLEcxktWTj0urv3RQt0Vo9LBzqdPY/NNgniewwG9lwp1Aa2ip5/QuDTISzaoDo811OKRO1fyWAUE/UB8JIwIz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:46 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:46 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 2/7] shared/bap: Add support to create multiple streams for the same pac
Date: Thu,  1 Feb 2024 17:28:30 +0200
Message-Id: <20240201152835.196617-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::25) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 8842d0a8-8613-49d2-61cd-08dc233a7b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tx8cDW0yXXlvzw8JxOHoxCqHwDHSDAFa1NOldRuGoKakbLPWf84FNopG8sBRAS0M0rpHFgiWfNeRXrhsx5mGhJgA7NaOBkPJ/TA6n9IOpfS5jTXt2GYuoW15ImsshZcEZEqvhaGlej81vmt5aUEViK+/lfCfg9bPiVOqnEj/7ZEqedNDCyQBKtC6EkIHKLnype+DR1IBRyb5IlCaIBh6bpJBAKNP943m8WoaO8tqXlk4hEZ6aA1Hbd1h3U7lNeDn+h9WWM62rmXTEY07cPhsmqvvWmjsFW2kyLKEBDFzXdyQHClIXr83HlhXdkHaEieHiwhO5Fdr3K0+a5+BSKUoUHDvx1ARhJXxbInpQqUE+elIHCLLZPP9J+I/Y4HrnOJ/eG2UFngy2COHEMO8r7ouW8hYeQNz/4FHR1SpElDTLlNw94ynlKVd17WtMMG7utEBN6bLCEeufcJZmmYQRKUOVsMkN248usD9ENhMDi3EVP25/vFLNzjfIZ+4XJvGZBGrLTq8jiY0044ue3mHTAF0DueBxpYXAfwmf0v7nN7b1bKNwVd0+kgQAQJEVVSOMd3p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSFM1gyjRgG6cEaheG1qJppeBfsw3Vmy/MxENu29oz5D0odh1IF338wxWsPA?=
 =?us-ascii?Q?XStJCI6Mt61/d42nDvopgV2GLpKsut6RTjv0eF1Y+Emhi21d5+LhvHvZLN1q?=
 =?us-ascii?Q?5OVThDBo0Rq3+lxpdfdGLnA5bUPrXLL3/QdPS5CvrPoRpYTcQs8L1+1chUR5?=
 =?us-ascii?Q?BQVImTVffzP9uIltHFwvN6pB7e9vL+QQljSES8QhBFK1AkdGxuqzKksyOqV8?=
 =?us-ascii?Q?3X5t5ZRSyNhn3j8iyhV3pTtdASrLH4gn559uKlNT59+NGgUmsvhc5fGxG16b?=
 =?us-ascii?Q?SUgPUVbDZgQD8suanb8ygu2QSAEt9KNhQ6Xx4mRXzW/KVfDzsVpMRo+m2R+l?=
 =?us-ascii?Q?8U3TPV59IDuMLsSU6PBmm0hDRwnOi0XeCiZcZkJIsftmCQPY/yWpyAd0ozgl?=
 =?us-ascii?Q?dc+zkLngcpmDCfeoF3IFCgPyvO379gg8DBwLHqaq7PL9FJipWMT3NFW+HI5v?=
 =?us-ascii?Q?waqMh69FxdTjJ/Rf0h63nRp5/0B125ZzVp/eU5EJnT+ARLRiD4Uf3OJunWW+?=
 =?us-ascii?Q?09WBZy6JW+T5CR7tQyIduGsONXDp6p/3PCqxShSTwdEpW1rVYQVWS3cBkYId?=
 =?us-ascii?Q?NP1hP6LR3Vg9+aUXcTMPqZwsXnMmlZntgL5IWtBd+xirYWRqT63wpi5wP+CB?=
 =?us-ascii?Q?wHbdPHSwdGrdElyYuwEa1f4iZm3qgfwaqVipLSKTqXXtR7wLhpYxACo/93mJ?=
 =?us-ascii?Q?0wo3gB86SeTDunEOV1BzsOtC35ABLNy1aAPoVIduECZ27/C6mrDsrNS6NQlB?=
 =?us-ascii?Q?m15XkxJuOBUmOeSG0PQoLxQ0yXZnppbxbpk0W55qldKlMPdqf649qcO5X+3d?=
 =?us-ascii?Q?XRS0nEcYagXWeeI4SU1EFyo4xFyUkNLISfeF5vU2F2XKBie3dw2imXo3lL3R?=
 =?us-ascii?Q?0aPEaUf18WxDuzskrgANf4kjOKaJ7cZ8KgTRWGJd2G26PIQOveuDg1f1N9Jc?=
 =?us-ascii?Q?pDzJ68xKLQuQEiWpFPn1m3nRio7qFLp7eFEdEiiF4iK/NyikQTf7z3UMg0J2?=
 =?us-ascii?Q?DnXId3GAbONyc1FR7W+hD0YDjQmtSm+TBVuPxs81bQwTtJZQVU5dh7g6NHz1?=
 =?us-ascii?Q?L+fgF2NilPhfryVydqp/wBZCpIjE4Oc9kOHSipQAHTjy5FTwl5DwPSe3fNbp?=
 =?us-ascii?Q?6CrXY3W7wfyf6Oe8sm7cFFrapOAhnAQerbSK+yVocvghK+v7lKxwQ5aWi1jr?=
 =?us-ascii?Q?kE+rymtfvtkPf7ieToPaTcbLlD2FBGGd2Tv25Xw1IxY5nxez7eaxCkKCJosP?=
 =?us-ascii?Q?ji1c2ZBir19KrdJwsGLGzbJoS8gU15U19qVNQ8PXWMFDLlbnoPjh9oHjCs2z?=
 =?us-ascii?Q?zQLM544G+Yg7D2qoAbraomtRmsmUlf3FleHMUJNP1mlMPiTNJzy+lHnaVRnV?=
 =?us-ascii?Q?SR/oTU5o/xfGPee5x0MEfL02+8U8piZoZtBo8Q96Z6xM+SFci9Fsr9nJyKHm?=
 =?us-ascii?Q?w/2j3WCCPRlhNoa19f+hwKq3E97vTOHk1gQAnYp/k+PRrnWyr02lb7pQkRis?=
 =?us-ascii?Q?WoD3crgSHbDFD2CCuHQ+0Ncz5jCJYzxFrIsFmjKAXZPNXiQ+C0be5RkJ0/jt?=
 =?us-ascii?Q?qfkF0vd0qxtdyX5icxktMCkHtc8kW5FmjXr84u4r/ki9KtxZ8hg5TbFtipQO?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8842d0a8-8613-49d2-61cd-08dc233a7b08
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:46.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz/ucRp4UCPYNqX87CDSsvb7xTZIoQQ4dMSuBoTWyKsdowA0GBozEG64JLEyOS3KOBwkEl422THbI+ogTHs7XhfiIgdMUMZQDgA9/mVS2EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Broadcast source requires to create multiple streams for one pac.
This is required for multiple BISes support.

---
 src/shared/bap.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 851d6a5fa..a4c6a1bcd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4739,7 +4739,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct iovec *data)
 {
 	struct bt_bap_stream *stream;
-	struct bt_bap_endpoint *ep;
+	struct bt_bap_endpoint *ep = NULL;
 	struct match_pac match;
 
 	if (!bap)
@@ -4795,12 +4795,32 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	match.lpac = lpac;
 	match.rpac = rpac;
 
-	/* Check for existing stream */
-	ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+	/* Broadcast source supports multiple endpoints (multiple BISes)
+	 * for one pac so allow it to register a new endpoint even if
+	 * others already exist.
+	 */
+	if (lpac->type != BT_BAP_BCAST_SOURCE) {
+		/* Check for existing stream */
+		ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+	}
+
 	if (!ep) {
 		/* Check for unused ASE */
 		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
+		if (!ep && lpac->type == BT_BAP_BCAST_SOURCE) {
+			/* Push a new remote endpoint with direction
+			 * broadcast source
+			 */
+			ep = bap_endpoint_new_broadcast(bap->rdb,
+					BT_BAP_BCAST_SOURCE);
+
+			if (ep)
+				queue_push_tail(bap->remote_eps, ep);
+			else {
+				DBG(bap, "Unable to create endpoint");
+				return NULL;
+			}
+		} else if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
 		}
-- 
2.39.2

