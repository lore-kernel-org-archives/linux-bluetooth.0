Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA4E7F14E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 13:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjI0NaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI0NaL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 09:30:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8345126
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 06:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhWIMy6IKy74LXXCreNgwh3H2lYQE02Hu3rXXKzlfN99lVlfAGQrv3JBvQ1acX6tligSMpToSY/7435lH73apYCYHR2BQAgyaQwdnP6bzkEfHZyui0oYV5zjQ6/FbFQHO/XjCuWNM1OKBrfPZQadnOmaQB8ku/nZeHnl9wjZx0fExQljjm+GzvoQCRL0RgLZbbb0GvopzsR7jEdFkWxP/RohnFH67LViGM3r+0wTklyCPBc1gGt5w3Gkz414BM98EkTR8yKjNuPHDkTYgDK1OTBdEdiHCCMSQIigZM0E2q9eO2zB5ClPahf8m2Rdaz847VkeXmBNNH8AWaB/z3okMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4kxkbiA1P8RApEctRA9+r0VtLfWKEj2k6WAE6pMMdw=;
 b=BGUAuta1BjALmvUt+jsuqtTfZF9mYv+IT2QAWHblzNLN9oeKwoanzBFD9qqknrUJJ2gLS3do8qu5+aDjLOIQyK5ye6Lp79wXEr5kKMnIRER2IPy6WK/SBpr2i5eKUThUbvErtF8DHEr03Zxbduxe2VVQmj5zS35YqNoHNC9Y6bhzB+ahK/uubmUpn8fsjvbaiBEfGoyS4sW4Z8aQY0+YUb4nD4o0BEP1RdROLdEI+EaJZN+9LCQUSsaQJfz4r/x8J53CAAWQOq7kWmG18UKYpv87h9FDymm0y8QnbHzbUzc/V9juWgMALQVVzxCFktAUCCfVMmMNsbqV/GOjoCl0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4kxkbiA1P8RApEctRA9+r0VtLfWKEj2k6WAE6pMMdw=;
 b=F1YWK9PYAJOzHt7q3ZXUpzVL0XP0u84QSGbST6ZMTnmGLI74Oi8SlLqb6Sye8YY2Kk4z0cS4mCoL+aXscF4wCDs5TdRAJsGPXj7ka2Lmu+ueCfPKOcDvVmt1cVvYq9JHiKSBuvun/GBoWpS2rOegW6JYqDasGEljXQ8ELrXOfks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 13:30:06 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 13:30:06 +0000
From:   Andrei Istodorescu <andrei.istodorescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        iulia.tanasescu@nxp.com, luiz.dentz@gmail.com,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/2] bap: Remove memory leaks and buffer usage after free
Date:   Wed, 27 Sep 2023 16:30:01 +0300
Message-Id: <20230927133001.6639-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0065.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::10) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb2b6a-cf51-4852-dd98-08dbbf5ddcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9HvaeZ+wETPRLqdVh9i7x0Gz2DxXc7v/0kk18qu3zXsEpgzGjyZeGwbYtOo0511jCRcydBIOGo0vLgJD/cOx8v6XYte5B4cILAD+hT/Vey25uMWYCvbhSOUmgesFae1p04boGeGrKK68va8G2IE/9+1MCl75LD8obxvm3xkmI7Y28XNuseyM/R8a9kJDg0JWETsyqpuSXodX085uEy7uVm4EhlhlM08kVsYzCmrjMVKfaWHjDXyHf+Yt7mbUCH70vM1mv6hm/1jlwzyskKf20P9yJ5Yw4u2+cBTobxnVpd7iro5uDQk4QZq0rbu6rsgN2y7K0wRYR+33NW7tGd32yLsrgLp0W8jq7dj0ExD1E4RmeDXjn8I4UJJX3r14SesW0WpyDRh95UuoIVBgwkCOSNaXXC81GVMtBTanorm+jwFxfSuoeAeTlAnNAndgBL5I3J97iW6jsnO5IXloPLWR3Any5T7yyXw02i+MSxRFdUvijzHoL3FpSbKKK6siQBadFX7dmlG37as8kIcrj1Vt77kZ4dFCt3USvni2vYnMVasJkRAYeiNiCB9lzT2Lnnl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(86362001)(5660300002)(6512007)(6506007)(6666004)(36756003)(38100700002)(83380400001)(6486002)(478600001)(4326008)(8936002)(2616005)(41300700001)(1076003)(8676002)(26005)(44832011)(66476007)(66946007)(66556008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4s2YxgdwXfgeKuLCCEeQgVysfspgg/qZUGkjZVU2jhYO0V7uq2VCiRAkA0z?=
 =?us-ascii?Q?3TvROm/Kob7lMdJkGV6ZzHXE64IY+fwuJXWUoBMK31dcw/s/3B9aUjnfjnD5?=
 =?us-ascii?Q?kmJZ2zmbmHTnE2YjqggH3RmawdptbprH6oR4x0j0FJ95KTpdet1+vnbnhFgV?=
 =?us-ascii?Q?FQ67uAtpWxa8EnqWxk2uBZbtzoREuOVvtNARm/o5MiZ0qZ2JdLodq1DFnqiE?=
 =?us-ascii?Q?S2CS/pNKWwqRoRIk5/CVgRyyviA+INOXZ/hGngUPbTwJQPNx2HJXgqd0myJt?=
 =?us-ascii?Q?867wqeK2sgjVZ74Xm6EYUdpcVVA6P+eI9tj3aL1e0/cxhqs3r4GTiOUZeay6?=
 =?us-ascii?Q?EFAl1QRLqkz1ItDeAgyX3etzDFBcb9pHXLevvQu55B7hxvPmmdrJj0Oq6zHv?=
 =?us-ascii?Q?LBr0KH01FMDGeILUqAIMyBkqHh/z0rt05CnNw7ZKnyF8DR2TOViCs61gjTxc?=
 =?us-ascii?Q?nHTpLEJINPX+jhVNKtCucFxrAvrZ4ztgQtEjC409YZAVs8ahHb5fB043hotd?=
 =?us-ascii?Q?dGwU7vD7QVeK1Tjh7NDkE61UwrfVpJnGEX8l34Sz2TTbQGx3pT363cgypX2M?=
 =?us-ascii?Q?ID2X2Cq72PhMghBsAA7ejnWGFGNdbVu/uQajBr9hSNfurCuGj1rpxynvg/sP?=
 =?us-ascii?Q?W3OuohXHq3wVdD1KtwsvW578rZwXR4CxTrROMijn+5ZtxPTlEU1Un5LNCjet?=
 =?us-ascii?Q?ToMIv06Sga6dTEt1U9ulj/mk46PqsTFieclkr/TKLams9tkHOQFsxlF/arb+?=
 =?us-ascii?Q?3Xf5BGyetSMIj9VSyQNHdtl7ZRZePgIZZwxa4B23FziA8nyaBrh14yTisPek?=
 =?us-ascii?Q?eyeT16LU8J3pAJzE2tjbvDFpePtqRmO5P9Mc5yt4bLuCTzgGwsz9nMJQqGym?=
 =?us-ascii?Q?xd7J0Bb6PFd+qplXhUwC5iPRfNbS4OvoMVNW8mZK92Wnocl40yQ73nALwqFf?=
 =?us-ascii?Q?i9mImRNuhKzynl5e+iX12pbOA/XKd9YT85O0ShWPXq6oYL2kHd+QMzMbHGfW?=
 =?us-ascii?Q?9NQoaquItHYMQD24aGIAwNcvQ8whzpGqFE3y0KN5kXoKzQWlMbS+ZDu0w/O2?=
 =?us-ascii?Q?/MDJlV3OaIkiFFXelnkbUj0za01ZMGnCPiAHZl6eR6LH3lXmb7cKcEh1CrAX?=
 =?us-ascii?Q?9WqcYmJJhDOvNUBplCSCF3drDefXC1BfJSafetmqwDP42drQ2NSZFvYedEVc?=
 =?us-ascii?Q?oOBx8qLyLmPHNINerRaSfWdHAYBb5meiyTOkj9ruszfLcz0i2+6ORYdBaPNP?=
 =?us-ascii?Q?1FBTxi4ov+b7vg8f1eTCsBMEJ3Y4uQKhCVT4lIG7imKwNdB+nOq5sl+4tmXr?=
 =?us-ascii?Q?kt2VyQxeTa7UrYPvEP3ZV0pqma4k1Thvo4BrkktiYt8RcMkJ3Ux8sIg5a8Aa?=
 =?us-ascii?Q?QFbeFP+LioWdChVH+ElLzxzKciH4MdOHcxTAzznPXfkmNJTCPjHJXGDNlk+C?=
 =?us-ascii?Q?ZGhvyveDRcsT6nfRlgjcfbXlN7rp6r9qnhzabpkbBj8pEKhqnQu9ddtt75Ij?=
 =?us-ascii?Q?cCWmMrsHCf75mc/4BidXsd61F4DuZw7+Kztuc09zqUXT8B48pIpeEQboUjPC?=
 =?us-ascii?Q?G7w8DK0sQ+DipJQ7TGLaF2vJswnDEyXMYarTTMq5gmQnIB7x3rMGUcwkAQrA?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb2b6a-cf51-4852-dd98-08dbbf5ddcf7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 13:30:06.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icqeamka6fXM8yBXVG6UInCZpEf3yVlDHBTxZFFrm3ya3h+R9+kdqj5WpeD22v7XJscdpNeE+MxBMYB21RE5fJOEPUvNaSXpjITQ+Nhrsc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make sure the endpoint does not contain uninitialized pointers after
creation. Rework parse_base and parse_array. Add missing unregister in
bap_exit.
---
 profiles/audio/bap.c | 66 ++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9812..b164f68d3187 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -278,16 +278,17 @@ static const GDBusPropertyTable ep_properties[] = {
 static int parse_array(DBusMessageIter *iter, struct iovec **iov)
 {
 	DBusMessageIter array;
+	struct iovec tmp_iov = {0};

 	if (!iov)
 		return 0;

-	if (!(*iov))
-		*iov = new0(struct iovec, 1);
-
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
-						(int *)&(*iov)->iov_len);
+	dbus_message_iter_get_fixed_array(&array, &(tmp_iov).iov_base,
+						(int *)&(tmp_iov).iov_len);
+
+	*iov = util_iov_dup(&tmp_iov, 1);
+
 	return 0;
 }

@@ -300,7 +301,8 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 		.iov_base = data,
 		.iov_len = len,
 	};
-
+	struct iovec *csc_iov = NULL;
+	struct iovec *meta_iov = NULL;
 	uint8_t capsLen, metaLen;
 	uint8_t *hexstream;

@@ -330,22 +332,21 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 				"Codec", codec->id, codec->cid, codec->vid);
 	}

+	/* Fetch Codec Specific Configuration */
 	if (!util_iov_pull_u8(&iov, &capsLen))
 		return false;
 	util_debug(func, NULL, "CC Len %d", capsLen);

 	if (!capsLen)
 		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}

+	csc_iov = new0(struct iovec, 1);
+	util_iov_memcpy(csc_iov, iov.iov_base, capsLen);
+
+	/* Print Codec Specific Configuration */
 	for (int i = 0; capsLen > 1; i++) {
 		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+		uint8_t *csc;

 		if (!ltv) {
 			util_debug(func, NULL, "Unable to parse %s",
@@ -356,35 +357,46 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 		util_debug(func, NULL, "%s #%u: len %u type %u",
 					"CC", i, ltv->len, ltv->type);

-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
+		csc = util_iov_pull_mem(&iov, ltv->len - 1);
+		if (!csc) {
 			util_debug(func, NULL, "Unable to parse %s",
 								"CC");
 			return false;
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_hexdump(' ', csc, ltv->len - 1, func, NULL);

 		capsLen -= (ltv->len + 1);
 	}

+	/* Fetch Metadata */
 	if (!util_iov_pull_u8(&iov, &metaLen))
 		return false;
 	util_debug(func, NULL, "Metadata Len %d", metaLen);

 	if (!metaLen)
 		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+
+	meta_iov = new0(struct iovec, 1);
+	util_iov_memcpy(meta_iov, iov.iov_base, metaLen);

 	hexstream = util_iov_pull_mem(&iov, metaLen);
 	if (!hexstream)
 		return false;
 	util_hexdump(' ', hexstream, metaLen, func, NULL);

+	/* Update caps and meta with received Codec Specific Configuration and Metadata */
+	if (caps) {
+		if (*caps)
+			util_iov_free(*caps, 1);
+		*caps = csc_iov;
+	}
+
+	if (meta) {
+		if (*meta)
+			util_iov_free(*meta, 1);
+		*meta = meta_iov;
+	}
+
 	return true;
 }

@@ -780,7 +792,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	char address[18];
 	struct bap_ep *ep;
 	int fd;
-	struct iovec *base_io;
 	uint32_t presDelay;
 	uint8_t numSubgroups;
 	uint8_t numBis;
@@ -807,12 +818,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	if (!ep)
 		return;

+	/* Update endpoint with the values of the peer's (BAP source) QOS */
 	update_bcast_qos(&qos, &ep->qos);

-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
+	/* Update endpoint with the value received from the peer's (BAP source) BASE */
+	parse_base(base.base, base.base_len, bap_debug,
 			&presDelay, &numSubgroups, &numBis,
 			&codec, &ep->caps, &ep->metadata);

@@ -917,6 +927,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		return ep;

 	ep = new0(struct bap_ep, 1);
+	memset(ep, 0, sizeof(struct bap_ep));
 	ep->data = data;
 	ep->lpac = lpac;
 	ep->rpac = rpac;
@@ -2288,6 +2299,7 @@ static int bap_init(void)
 static void bap_exit(void)
 {
 	btd_profile_unregister(&bap_profile);
+	btd_profile_unregister(&bap_bcast_profile);
 	bt_bap_unregister(bap_id);
 }

--
2.39.2

