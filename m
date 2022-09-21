Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF4C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 11:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIULRi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIULRh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 07:17:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2072.outbound.protection.outlook.com [40.92.89.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84C474DF
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRrufS0PwTIxbP+Bne5WHr7UbmMRgt+UG17AVYzqwqsTCZxSSw4C3Po0uv35X16spB9hAnn3ZLFIzZ4tsgUbmCsLU1VqcG63HVRJkhQqvZSPjEdOiHwYbPUAsaEfHEqQuct0kFa+pgPD8/ld2DXbW8SxTwtpNxQD1q5iSKnMMVV6tEoDEF5rCUoViE9TCUGSZVL9H/xV0myiA4EsxUTVwXRaf7jhViQLT4yr6JhHu367C7yRGWQAclCMu7q+UeEtIXRVs6qPJ4BhvihmzwTHH9MmmibG/39PEJMxGMHZPQ7XtV5NSQsGrcyBE4fH5Tgj4VeL0A68qARVjWlMoClamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un/6I1sRvo0IXfChoTh3yl4ieXK02BsG7ppods++toE=;
 b=oAUGaGvj1fNBNw45lWPL119ZdRatFg5f3vjGJ9nXgilqIo/D8ljZUyyvJyfq7mG1hH1kZZBU4E9FxTxJp/QF7ES89lPplIXmgtpzYv6I5hRry3D0hn7t4lcIQ+0gSoNZAx6xBjCNQ5naXX3rtcmRdBMS0Izo69yGHkpTHaBrTNJT3nt9bX+x6vBZ6/RpcfPsr28sMDSPBygQsbhiP4Q2BcI1djqJ3gj64uT5Ic9BvoqKYCj2v3N4ofGttItnCXTw7+1qyEtZTTnFDebXD5gAOKl/IdjcVGqhf0B1b98cNwM0Y6Opg+n9CdgWO9YPgEdAKjnda6+xVkX2IqD7OASqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un/6I1sRvo0IXfChoTh3yl4ieXK02BsG7ppods++toE=;
 b=lw0gnn3wmo0BlvYb8gBOkoblDQyTvMNIj9f9uRtCvNt+EdaF4y3FWPWHsvbSt3US2lvYuBEgXIQVrKlTUHZgF+Isc2Vc3fqqwJtbGVVTP0HrhfC0Jcv7wriO+8f5PSGXsb8NiqdQlr/4h87yteM2udSKUfvpyWVaGsXJ7EtdUa8HrkM9fM2X4eBdkWVnFjdJrwmFa0DRUMJTG0kioJWwqLZfKVVe0TYv2Sx3+8K1xzgHGAJ916H+Rk0Td1uh67PTDpIy1xTymhf+dPWzfyg4Yna/5h5vBK/Zhne6u6ZjKqeKviDnSv4p0YvyvNvyvD5BFk6LHWGMo/KAgX5CREcGqw==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by PR3PR09MB5361.eurprd09.prod.outlook.com (2603:10a6:102:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 11:17:34 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 11:17:34 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ v2 1/3] mesh: Add interface output filter
Date:   Wed, 21 Sep 2022 13:16:28 +0200
Message-ID: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Yqm0oVuzcWaAYLyiIkJlT0Gx/Ae0Wjh1]
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921111630.23589-1-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|PR3PR09MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 60599494-9dd3-4faa-bb7b-08da9bc2e1fb
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4T9kseV1SDoA75ob2ERencravVQwr6+olSKJ23MJOXZJ0b66FXNNpoEUs+fN1kv/rLUFiXylS/EKYTISaRLwAJqKVTuJZ4MItWZDatfyUo/Wr9+AI5TFO9TFJ1Mga+QMERXXpwcW5QId8ZCr45exJYQAey3GhtkRLOaKUyNAqzbdKr4d1WT+xkE7JWw9S8KwyhMNy7KV02WXqcYTIHOm25LI7JE1JpvNMhykG7BNiq11B7M16EFNud6IQ/CBb9Y4ijMzw3VBOMmVwAcRK/d7pydi8rxAb/9wltb8Dyj3HmCWQDvIAvNdezj8jq29/42MrSMO+2f3BoJL0f5xMzOE8F/DdgrnDOx67yyTwSQwpOCk9vGRk2cM8UPFc6QjoRRdk2L8wzPLvCI05jc+w1Pp0KOyih0zvqjM/SVGAnu1zUr4uI6feuv7gwY7MVC3gmHZ6imMn2no/lT0/VdA1lhb7ch0z8tU/e/Hil2/slwR9iHkkpe5Hn6btmfru67B8EVPOTTl3oGH+GSCCSLRpm4fxy0RtRzJQE7+L0tskBbJuen4FyyjA3P+wkIWhLP8BRlposGfPZCfzB2Ik/2ob82EGPaxbDEm4KS6bRp58m8Wnu5A/ycF0LZOmmh+bFQirsVOuN5dldypLICqdEDQfreax0l3aiJRhBwrKbHiUygtx9PcywaHiu66wBRfdrrAUBD8q5HQhzt66pCRWD+T7CZWvCnpYYmN08d+Er2hWgOnyMvHuss+8aFZSgJ6b0I0fTTW/
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP41nbAvmoFxSfvQ9aL4+pcFwju8LdVwPngG6rjLACN4Vx+TnZ6bN2oBboy7BFO3XvzV2QOW8UdqLGdu20okAKSh6H0y32w5Y2X+2FYYhDgWj8SH4nCofXswnQbrkDktQm8jzkRZkh44ZiQIi0UXrk0GCGpbw/RQecRrdsgOixw53YmRBkCAMOBIg1yBuN5PxaZPmu/YRaEpL2QGZ9dkvpYGkWgoJhbjyL8zvFFF/jvi/GfjKNQqBHVzK+MOYFM50sBN+BV8nbR76oBUIj2UnoJzEfc0puJq7WFcg+7AtHPyttoi0HLwOHSpHv0D9cNQa9MCaZH02fR49UO8DDw9awX8rMaqEKbPsVH+t2nQkrefCvn34cSJreTCK1Z9K/oQpLaeEB/Xg3ciu4kE4Q/YnT9ElXJ/rj3iS2lnO5rGFOZMzOAzXVBuI2KsQJT6j6KA/REteOYTzFXkjEfTctdtzrV+k3TY2C4vEuqWAw6Nh+xURauF3Oy7ES7oR6c4+2RJ1SZLzn7xXV4kLIZAFH6sBL2T3kJDpb+h4ufMiCxRrU/jDDDIgx5BXcASc7QP74j+siZgqHXYyWohn1yOtPTv5D29moXzi+6Pi/GWpgY9jghVoOBs2wAFuJAqjaDDkeu1IRrKE/3fIuJ+cOWTuwMEKQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otPLk82a9kcsUjfp5ha3LJj8tl0EEQT5vp8orWhxP68AlD67VtIV4guKF2Ec?=
 =?us-ascii?Q?4my726Jeo9JVdEKCkwuh7QVzc9fb9aTkhMCxUaWMAaZjEo0SW5MTQ5wSiplz?=
 =?us-ascii?Q?1e2tAYVC3dF8KQtEawsR7FJZz3hkeIo+Mtf9ovCE7hj2trhuFvgq6WS9mTon?=
 =?us-ascii?Q?//r0AfeRo4mk1BNkTS2L5dCJReWJDEx0oelDuUjGznjf7WoT4D3ze2qCZol5?=
 =?us-ascii?Q?Bh2eyHuEQYQLou6X83NPVpxNP1hyqRJYFAO3nrONuoGQa86An/y+M3w8hsZh?=
 =?us-ascii?Q?DqdlaUqyqMdXq770McRMPiK4Y3dMBD603KHv12MmS+I79+wkOuHBmyVwCmI9?=
 =?us-ascii?Q?sbBb14rRcS0fThHvZykeu5gcv9LnNIEP47kTyQU73091rNclvQ8RdbErCUvt?=
 =?us-ascii?Q?f9RcUPvjPalYyHQ77s9lxXzm5P2Lh0lL++GQUC9BosmLqDW+aoo/RBC5fxs7?=
 =?us-ascii?Q?eSm6ccuV0aALFIs0J8UTFLQZlDPF2E8H4zoxPjNqxNVUX+uNL6Xc2YLZ7FQV?=
 =?us-ascii?Q?NLK/BjPwokjgYhgWnDC3aJ5Pglm4kaRsszz70FBuG08PwM0bWinzjWPvCksp?=
 =?us-ascii?Q?0ikGmOgvCzNgt3mA1VSDSLPN9u8R+mEn+VjO1AqNkmh9CrxbtuPCC+LovMS5?=
 =?us-ascii?Q?3IZ5sgBohYHq6BonfWQ4JG+NK7kEclHxQEgLGah+JIW2CFAo3s/gJB5Slhxb?=
 =?us-ascii?Q?TdHUmZJYmVtJkVlsJPj931p7pyE5UrCnLlObeVJsWD9HzCODP2KJ4G99FiIT?=
 =?us-ascii?Q?JGK2Q8NmAkG2y6QrVgADfw/qtU2Jw6xcC5lVsmRy3CqWRyUgiXoWHBK9A2RE?=
 =?us-ascii?Q?u+1p2hDK5mkF7KY+V3jcewv+PFXOllZi4eQNO4t2yLJPwtH1LYGjtB3FY4St?=
 =?us-ascii?Q?1Q9vidSTy1gqJmUgl24v7qtSUgOpzryC5LExM/dh+jDNDO1XRAEumUDKwgjQ?=
 =?us-ascii?Q?rRnlHWs6JqBDtkWLFJMcNFoZRUTjH5SSvceP4/iYVupd9LM6krCHONmZZJKa?=
 =?us-ascii?Q?lTNe7XLLy+S1Z7Y4wc65QMQixfMciIhPsAAMGVodYivlHwPoGQAji56BnWNt?=
 =?us-ascii?Q?Z2TAe2QqTpsnpEopDlBtYHD4KpiLr1qHO63fHZOKecJ8+iLTdqHCSmxPIm9u?=
 =?us-ascii?Q?0+lPbkk0IE0OpFeyVI5MhQeZqUhs0vWzBbLzUm+KoSLdHdCT1Ro8tYuNkLj2?=
 =?us-ascii?Q?0EwQV2bVmYmMGEgegn06A1oA81qBh7U+Y+ITP8InZ2/diCwluvzTaoM238nU?=
 =?us-ascii?Q?uGkkIfb5dZLsoDlA9//TACLGT0cJdSuPYgkMKRJ1wA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60599494-9dd3-4faa-bb7b-08da9bc2e1fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:17:34.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5361
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to the mesh profile (3.4.5.2), if TTL is set to 1 for an
outgoing message, that message shall be dropped.
---
 mesh/net.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index e8e6d3a61..699469284 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3067,6 +3067,13 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
 	uint8_t segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
 
+	/*
+	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
+	 * If TTL is set to 1, message shall be dropped.
+	 */
+	if (ttl == 1)
+		return;
+
 	/* TODO: Only used for current POLLed segments to LPNs */
 
 	l_debug("SEQ: %6.6x", seq + segO);
@@ -3135,6 +3142,13 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 			(dst >= net->src_addr && dst <= net->last_addr))
 		return true;
 
+	/*
+	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
+	 * If TTL is set to 1, message shall be dropped.
+	 */
+	if (ttl == 1)
+		return true;
+
 	/* Setup OTA Network send */
 	payload = mesh_sar_new(msg_len);
 	memcpy(payload->buf, msg, msg_len);
@@ -3206,6 +3220,13 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t pkt_len;
 	uint8_t pkt[30];
 
+	/*
+	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
+	 * If TTL is set to 1, message shall be dropped.
+	 */
+	if (ttl == 1)
+		return;
+
 	hdr = NET_OP_SEG_ACKNOWLEDGE << OPCODE_HDR_SHIFT;
 	hdr |= rly << RELAY_HDR_SHIFT;
 	hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
@@ -3264,6 +3285,13 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 	if (*msg & 0xc0 || (9 + msg_len + 8 > 29))
 		return;
 
+	/*
+	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
+	 * If TTL is set to 1, message shall be dropped.
+	 */
+	if (ttl == 1)
+		return;
+
 	/* Enqueue for Friend if forwardable and from us */
 	if (!net_key_id && src >= net->src_addr && src <= net->last_addr) {
 		uint32_t hdr = msg[0] << OPCODE_HDR_SHIFT;
-- 
2.20.1

