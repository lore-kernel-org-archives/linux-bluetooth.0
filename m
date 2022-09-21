Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD53ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 08:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiIUIkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIUIkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2034.outbound.protection.outlook.com [40.92.89.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCBF696D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 01:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww0NCLrTt0Pxp2v/PrHg7q1jkWVvPsd9d3jBrRbVWhi0hsDVkIuehCopKBqrLPjwDfXIKvtR237q3WbpKtFv86kQTM1bjqyFLbfCHmCFwjM5Mv3JGtgjVoWlpCht0evMpzQwKFvbf1dcXwAvbXfUpefzetrnuuHV7f7DWrOsgskr7ngopKzjF8SBMNVlOMJkdiYXZxytJ7jxtOQS7eCqFCbiUnL8ofA0A+/SMQUMuZbXgPhDA1kreRfimyYHcO9+uqzSGj2uih4xt7Z9frzODQZO6+A7efU6BJWCrMdlOTh18uJD6hkRvdQUq5Q45Sqi/8GZsC2M3gf2nAjpgsHCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un/6I1sRvo0IXfChoTh3yl4ieXK02BsG7ppods++toE=;
 b=YM7IcsJNMYEDb7GLZGp0VobXPzINnntqlgMaC+jwTjy0d3GehDwpL6DNYAAU8oHQ9NtOq4BoKVnVn/Y82koBx038lexj9OTh7IWUODqZVTna/ll6usviTNLcgZR2snSiqcysPGIZbYoBy7NoAkvNS26T7M9e7zPs+1DLELbYpbOnnrwqZVJjpTLxhTGNyoSvL6emSWLDqF4iqksqHSYOEwwtq137CpSOqMq/YDMrnzWYGCJGrfGj4C5mwMTZBsYfuOYmR1uTp7qU1X/i/UxBsoMMd6pNy3eVbDUD+ksNbkkC0veGz106Tms1r14KXYDDi+QUleOrElz7RqT/00WYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un/6I1sRvo0IXfChoTh3yl4ieXK02BsG7ppods++toE=;
 b=gtzb5TWhRDWjx4gVOFKjUDYOx61E0CmFjp0RYnqHS60O2Afwv6wpGtaUxDUvwm3NN/l2sA5FZ4D/fY0jctRqD+a1XPvByRPiM2Qv0UuO0GpYiI34OGWjVwEv7+S3rcWtLoCfG/EdCJKaT8utu9AgPmFd1Cc97v28unoXEwpfCZNoyD87R/LN0bJqXCR8rMaO2qkXHXCt7asK4tmRn50KbaG37q6x/6vGNw2bAmb4bxWjat7kh0oxaTmT0UGrDnCEgC+71NtnJgYYt+rvqkd7jz/QgCFsWQCuY8+FUYU4h1C52RzC9ao8278LvXOn+hhDwsUuBXVRNUDKjyCVk+l7NA==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by DU0PR09MB5693.eurprd09.prod.outlook.com (2603:10a6:10:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 08:40:30 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 08:40:30 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 1/3] mesh: Add interface output filter
Date:   Wed, 21 Sep 2022 10:39:39 +0200
Message-ID: <VI1PR09MB4239AE3033F3ACDF7CFFDAAFE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921083941.8461-1-isak.westin@hotmail.com>
References: <20220921083941.8461-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1ihb61WIv7VrE2i9Sdq7jI91vEfMEoNV]
X-ClientProxiedBy: ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::18) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921083941.8461-2-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|DU0PR09MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b54d40-629b-4eff-f267-08da9bacf091
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4vrkncgELSGOl+nsBWSpgF0aUWAm9RHfFnKkBoweprBXRfAR4Sw8neEjjxbQWZ8wq1dv2N28OweOpxqncPBkibsXhSGbO34O4C+P/GhK6UJQiQBgVsn3Gaq+BWCZhOn9QI5r/LnBXPWUSk7HtNDPJbm6cpWj40D1RRgnXns4c/Jm/BgL7On1tDYN/1hAdUXckdFSq5D1MYqvs+lVbHfXDI1bUAGcZhQFE836IUXXM1cJE2RKiJdA1VN6qo641mfFac/+74nX19J+mujclCWTsUwHXvVG3MyOiklquFrJjGtZByMpkeuMYZi6dg3wj98lDQMYXQI4E0UStRrVAIjqZcI+BKHS1i9vIeh9lNROFFv3aIINqr12LPPaWDs/ShAhh8lcdua2+DMeycrlxtOWIv9n8bYlbl5WKe20hhO+Sduolb41ga3kZa8yEs0T21vbq9rlxVwmYxzrinEhZBmfSUg/D8rDqm5oS+l4aBQ6usUzUbf5jA2RqmDl2s+pmd+Lqk5G+8YPirf1z+kqHMRL5gGxi4/kNF3lQ2XxLjy5/NjMmtQ7UADsTpfoHORcnIZh5nwc+b1+95fQ1FxntCCQsXGRtsYtaI/VM1P7/2rMWh9A9wBkthuMUIN6fj+pc8OcaFdnodPk9wFyw/nlzaY8xTK7z/qOuY/u5TpCVFtA2X0qXykBJnM5QpDnWE3BYGiHcYOm5cYgIF2UuusJUOqMfhaTmpOYFg3Leqcvw1GMoaB2tX/txDU0MEiWwvNAn1a1q
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBbn+PKpApo1QdbVi9H9aMDBWxlIgJP/U+sSO3BcwwVl4gC+rGLwbVEq44YN7COKIkcQdWY7x1JwuCuYxOsUSt7CT9t6Xnx2/QJHkH/0CE5rxB57iNbAuuuaJBUEPgAYDfpRqDbKoe83LouKIBXz0uOzh8tzuEfohWkIgowvqhlBEFhq5CGhFOOyv8WtiKva6d78pnmYAMBx0vXVS8eTwOkbZiDfs/3SyvbmZ4OCnwAlx2gfSAlZF39TZNtdirtQzDSAQoef+4TXO6AIdAzKomAZAsORhAjBLy5ueRoCoRIJ5sIquS4pjQ8b9ggihtmIlK4PTu1t7P/8uWWA9eGI9IPZypWhG1SI8QaUuO7PkyAXChZJKhur/i3R6XiXCbCut3gO9ZtvG4I8cEapStC3+K0o6EvYmXDTQsJ3Pm/uMLerZD/w1LKHfSWIqruDF9QBnrwTSKMVzpt6k/D6m0Blb//DYRIFs2zi0rbLVKexALgNPzCp7Xs90lbz579Hr8WatF/4tSWETxcARB0Bl0kow91xGmzBqTm2bjh/TjqM4DUS2ZKMlhDTQgdUUkk9A2EWTRp0LMjAjYuP1Lg4ov6t0lf+k0sBHtwNQ7tHeWYN8/yzcC8O4cM6fiDKBZ/Zs46OdRrVZkVW03Vq53FeyweaGg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOucNtS/XKktZZUx3NgCoiiXYm0W0vvqC/89Azd5tlGXpE/Yor88QnJpzqSN?=
 =?us-ascii?Q?9+h3yhgqo5SJDTvAmNB7GpSCE48puZD5fLVZMP1noPn0wO68jSuqSC8sPkqP?=
 =?us-ascii?Q?aqDX94lxJMIzCL5uS/UFo49rV1ZXQvc4HJCqP99juQJckoHoym8i7WKVePtg?=
 =?us-ascii?Q?bl4IXsc5eY45qRv2ABb6R2BFVWn7QR5/YMQVx80JvERRNxyLygKve03FDQXv?=
 =?us-ascii?Q?Wk/fT5JvwzjRSHFlR9miU0wFivMJH7tr4xhEIv4Jnmn2smcitU/av0ih0aLw?=
 =?us-ascii?Q?fCblphO4m1YgORGMdEPjU1v3pipRHkrGtIwbwRYi7M3o+jvuLPEde0VsGgOV?=
 =?us-ascii?Q?rTmmlE6TRpFdGHU+Ec6b/uqYyEDZPuFMMpgUdi6wtorxF8KTVjqU8e4VELIy?=
 =?us-ascii?Q?rG/8Qehg8icoMmB0TM804Hw7ZogkzjVdzM17njW2pgH8MFtgIpl22ylzgYuo?=
 =?us-ascii?Q?9gpj3DN+zHwvFOeWnqYMFl0EDzke1ec8HG310p1lcacZE+eODwTXl5KcXyNu?=
 =?us-ascii?Q?XJrZvRHr1mcUyQc0bbH0XCKlnNIImsRcS3jMr4kUjSZh/TG0qKXOLg2a3i0V?=
 =?us-ascii?Q?y3uuGUslzeJen8eDl5beFzY3x4GONTc2XFdzNbsnyRLvXzeiaJybGfBLO/MB?=
 =?us-ascii?Q?3jUq8EeHkVeDeJZDmjrh2wjtD3b8gippK3UZOciuVK9wdwf1g+p99TOalhy8?=
 =?us-ascii?Q?TSYzFB34b6YA189HZrc4yd7e5DKHHX6LzAakaB6lnOZUMijw5mlffWcl8PxV?=
 =?us-ascii?Q?L0QDt/lx3F5+3/xT/OwfLTYc2Lp7/E3QajLLSgrS3yOWy0CZb4TQo07patQt?=
 =?us-ascii?Q?o10BlPNH2Hg6xJRD0QEQnU5zUo7c+TmgH8esChlQznf+aQA8wU8yk6EZGGta?=
 =?us-ascii?Q?HTF+ugaAUSvFFj0h4pTcmUctpe12GoMXcBZnW268h3+rnPhyF9TnRZzUv6u/?=
 =?us-ascii?Q?hJKX3vUfTkRO68oIyetAo8fnboR8wig5FT2OvfmLo3hXjdbpO08j8uTRzzwN?=
 =?us-ascii?Q?xXfYt9csXLQ2/6PO+2yWtgAfWho3vYDxLbRzIDVhV8+WNN7mg/xoCMO5KxXo?=
 =?us-ascii?Q?xqNuRoJr56CyMJD6DRXAjOIAzaZwKQAXXKMC78USc2xTnm56L0744pyWgzMG?=
 =?us-ascii?Q?qa1eUnvzir1e616KKEqkxepNfeDRs2vZpcqtQ1Ld0x911oNEMdqq6wawaEwO?=
 =?us-ascii?Q?LrPS4HQGnXFrf4H5rFzesjxlXkHyxQ2urjr77iBX1ZtBWYBd5SrwgRGa9IVZ?=
 =?us-ascii?Q?+yxGOCcRQ5GuGu4KhvsBsXcmj868Q1Jm64dDT67YEQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b54d40-629b-4eff-f267-08da9bacf091
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:40:30.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5693
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

