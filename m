Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE72C07545
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 10:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjJXK6D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjJXK6C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 06:58:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629512C
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 03:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye2XZUp0mYlKhxH3kquy2GrK0mpHDcNo3yOl5mNXO7PhbOMfbA34+wcqMkttuLaYz/n4I4FR2Xb5FAaHnRQEoIc36brCKiTD9bK36/HZtNaY9IyH8b68QpQEzSkRq4aM6HJugvTC5s+A99szRqexzYdIZypsHWK0PfOxUmbsL5yFhbkbfvlA2DCYIu2hkSE11z223LlH+lJbkrQaKKLFxr3PMBT2Ja7gXqqTHmH3KWkPlSgFso+tnHUm1GUubReEJtAo8gPVmxUjnLU//lAeSyJ6QN6At6r5RcAx7uxUeFgNrgZxC+aKrUaPFsP9EZUWN08IY2hWmFNmgZhEbQXgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWGKnhLseu1Kt52KH5dYY39yjWLAi46tawfqRQPPln4=;
 b=Xp3/FeDnxa6OZX1RMawjtfzjvd5iwAgyG0o2pQtw5LXirDoFVeoKQOGDYI60d6G4XpO4879mCTDEBndKxr1e2Qhji//MzHbWnOAQXY7KENsW+3VT7aeCalOTzyAqOtA4DzRR00AHcg16WuBJJe2Z8cAy3pkV4KKSlu3B2CXmvLo/YlMGPdxaxw0+F8osLLLT4c9Gs87pdCD6AyHeLVBekjXNrYNtqo7kwIT5Hxlz0YQR8jLR4jVv01/+oMSR0jeZBvzlIIzcBBHksI+A71EK0F9FnT1jQ9ykIaGocCudwvGogUI3b5iBhmahSAGFTnNAwDK4uO8PtpnTDKf5GvGetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWGKnhLseu1Kt52KH5dYY39yjWLAi46tawfqRQPPln4=;
 b=Sejo79mrE4vooPh5OTKUu0VsAZ+xc/QYCJ4b6tMZbJG9UkOCYdpgpaTlcfZzukvtVGwgV+FyRTBCYxfwLBr4Y5EGMsEkrBuESuvIL2obw9RNyooVrwSiqiC5TQg8GrtGSaFEFLr5UZk7J4UA4PffTinB5Dcbbd6+jXXh9ZqCx0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9458.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 10:57:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 10:57:58 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Tue, 24 Oct 2023 13:57:35 +0300
Message-Id: <20231024105735.3216-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024105735.3216-1-iulia.tanasescu@nxp.com>
References: <20231024105735.3216-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 378083b7-2e37-48b8-3d52-08dbd4801541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEctIM9XRoYsQ3TEvGXL8X6tpNvpvw9ozt3eEL/+Bt3+yr1toh8UP2y4qQwJ3lizXoOd71yk/DYPIl69Gf1BjeckS5ga8sd/BjWXVJzVmE2BwzY+xZNtnlg9osV0hBRPDELWZuhcA1LjqVawe5788G2kkn2XnXzP8yZce7U8JzapCLvg0SfiVtLWY35JsXZAA5uy4e6f64U8pasPTjiyzEHOn9/wjCzcTI/01OqxeV3gvL3zZMKDEI0obYamXfsxVqEVlxUmYlxUJSNkO1ozNg6zYYvwPej8cFXGWfhTmPPcyZqqDRZ/nKGrpQW/BJ6uceHgT54PH4zh7T8tZKx1FOwJuKzMKraDBqePzpzOaaJyZ+aK814mAsVQ6f3Zhu1Ze1tBjP7ixJO1jqiqsFtOmxFHCHXw+By5k+sq9J30G0kziwyEPh9kH+1xWi483zyBSLdcVJHljMHVnLbyJ2YZtHC3Fy9Z9xmKkORe226DNkOM4BJjjsaItWDeRGf9OL/OvF85DYCyExAsVXoJQ36j75DkwkSjGnEYBFXYJ7uSIj2Y7cJddYTwoAkxEwdO5NmA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(6506007)(38100700002)(6666004)(6512007)(66476007)(6916009)(66556008)(66946007)(26005)(2616005)(1076003)(6486002)(478600001)(316002)(8936002)(8676002)(44832011)(2906002)(36756003)(41300700001)(5660300002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70kKZBqr0eRAMb4+PZT81EYBGb3L7QN5cdVcPO5+/KSEzaabamKJzCgmmrcw?=
 =?us-ascii?Q?aYQITkY4ylheCj2eQ1Q7BnCisEHlkWaEPRXy+G+gbIh0CmeG/RpHJYZMs+mh?=
 =?us-ascii?Q?DCcWpI3xBeVEDR+G7q9ImOfdupnKwvsbiDoHQH4C6HqBqy1TXwlJC6hNWwq5?=
 =?us-ascii?Q?QPmAlcP3iBZzOHQb7BE0Dd9HgHNEPwW44G8qbgN/eK0fxtMdNfG1htzI14o9?=
 =?us-ascii?Q?ARZjmarKvwaiPHnr8jNwbDEDESQ/ZnZJAbOpe1sKLo1r7TgaU8Oy8c87PhUY?=
 =?us-ascii?Q?iJGWDKx50L01LoVbJonhpes0vzDrfxIZkO38xssnnq6kbI+UVnirx26zKnzu?=
 =?us-ascii?Q?ljBf/kR1/4psj3Is7UcbjBI+Fe3pqOhFfq9ohYEF2anXRXcw2PvcSrc5ufGw?=
 =?us-ascii?Q?jRHZsMhrSizKNOeYgnat4KBSz+V788MzvzruE7kQssiZwDHb4U4MREAs0Ie3?=
 =?us-ascii?Q?7E/mq4+gj0yaEXkjwO/6oYLUfgtl/CVBeoaub2Yh2mDmdo4EEfxc5T7sRugD?=
 =?us-ascii?Q?85txzGxcPwJkFKbv1xqIV2vtKIIVPFVZtnvz9bH8lkbffF1CAFlR89AcYTs4?=
 =?us-ascii?Q?leeSdTgZ89DcCuQ7CveS1tVRufVN7p8OXbVkRcliTXr7LIW7H9+WbCNqSWuj?=
 =?us-ascii?Q?mGFyAbbCKEMVPt7VN6HI+gUMCQ4VFZIrDkw3UCz+Steoui3JQgoAhZIDaRlG?=
 =?us-ascii?Q?4LQOKXRzi9gAuTrXiRmOIgMqnEcsU5cpMPQVRNMLjxXA23YKPpEgrM0Epy8b?=
 =?us-ascii?Q?Ophq/px2CcPFgzYSDvTLTLsDMByyugYvzBo3MuitXqIgQtA1W88fT/2H8nhm?=
 =?us-ascii?Q?QpgTYdYhgRmWeqeXcImmYOE8peMVHiBqyNilqFE9Ie0qQqd3udo+eBFjH2JK?=
 =?us-ascii?Q?DsW4XMLEdVEjLgNNOqC3hyqh5aiXl3ppEA2/CsT7NYikAZkB1Xs4WEQUO4+s?=
 =?us-ascii?Q?xIFR/xZ5B8UUUs8UDhesnQIMgLghZOL6tLLD7uD1yBZVxsKgUI4fKGMNnVou?=
 =?us-ascii?Q?NBsOfxinqyOofNRmypi0/7DzNUNjJGXYOXSblqlqDadBbHzo9lVwdHdWveo0?=
 =?us-ascii?Q?aiDNQZPdSnLx+UuULShxxLUwqQD2nIyB0hBBoj0vcaQcu9jw5wnAmYr8EYo6?=
 =?us-ascii?Q?KYyxbLB25b4IiNUe7uNcES9UQjNhsdE8WV7qLozPE59cxGEz/l83FL1o0Wra?=
 =?us-ascii?Q?oN28EPlQAuy6Xk2l/BQQVYReXssa7LUPQCqciOJNZw0tkSCOAxxS+gtYRbXZ?=
 =?us-ascii?Q?jjts05veoJbaqWKMY9izdr87Q4oZumR+4XcxiAGIn7F2Pui46wpiWLhUj9rP?=
 =?us-ascii?Q?raIBOSUI7i6FOAPeNsGYn6PX2INAWU9LtHdfz2AYzUBbjYWRwoCSJ3whkjlo?=
 =?us-ascii?Q?1CL9yDg3VLx1Aab8hvQDo8g85TVu+vUAhjFPVgWOYm1WQ8CD8d/FwLzOXftC?=
 =?us-ascii?Q?VmOs2lrPdaleeavpaRPRwVKAYBbBB/MS+QamHRhKhnsFb6tlADkwyX1ZFb02?=
 =?us-ascii?Q?pBl0Hx3yfdgAo83FNCINXE/Ys9iUImz5zalXTrNxsVkJMVTsYeWStxNBJLUQ?=
 =?us-ascii?Q?xRFmvQGh7NODGokqcZC8NbDNhmlSKP0fLqTGMeVw/5UYkYBCKIoj1La1q+fF?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378083b7-2e37-48b8-3d52-08dbd4801541
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:57:58.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsHW4NhXLpEXmkDQQqBcQhi3pu4wkMjCetqtoT1OzI6DynP4iElQRm7LDBlamEpYg5rKUM9+EvU6cbWpwVSTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9458
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This makes it possible to bind a PA sync socket to a number of BISes
before issuing the BIG Create Sync command.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 67 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 07b80e97aead..e01b6abe36fb 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -792,27 +792,75 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	BT_DBG("sk %p bc_sid %u bc_num_bis %u", sk, sa->iso_bc->bc_sid,
 	       sa->iso_bc->bc_num_bis);
 
-	if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc))
+	if (addr_len != sizeof(*sa) + sizeof(*sa->iso_bc))
 		return -EINVAL;
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
+
+	/* Check if the address type is of LE type */
+	if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
+		return -EINVAL;
+
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 	iso_pi(sk)->sync_handle = -1;
+
+	if (sa->iso_bc->bc_sid > 0x0f)
+		return -EINVAL;
+
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
+
+	if (sa->iso_bc->bc_num_bis > ISO_MAX_NUM_BIS)
+		return -EINVAL;
+
 	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
 
-	for (i = 0; i < iso_pi(sk)->bc_num_bis; i++) {
+	for (i = 0; i < iso_pi(sk)->bc_num_bis; i++)
 		if (sa->iso_bc->bc_bis[i] < 0x01 ||
 		    sa->iso_bc->bc_bis[i] > 0x1f)
 			return -EINVAL;
 
-		memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
-		       iso_pi(sk)->bc_num_bis);
-	}
+	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
+	       iso_pi(sk)->bc_num_bis);
 
 	return 0;
 }
 
+static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
+			       int addr_len)
+{
+	int err = 0;
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (addr_len != sizeof(*sa) + sizeof(*sa->iso_bc)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (sa->iso_bc->bc_num_bis > ISO_MAX_NUM_BIS) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
+
+	for (int i = 0; i < iso_pi(sk)->bc_num_bis; i++)
+		if (sa->iso_bc->bc_bis[i] < 0x01 ||
+		    sa->iso_bc->bc_bis[i] > 0x1f) {
+			err = -EINVAL;
+			goto done;
+		}
+
+	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
+	       iso_pi(sk)->bc_num_bis);
+
+done:
+	return err;
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -828,6 +876,15 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
+	/* Allow the user to bind a PA sync socket to a number
+	 * of BISes to sync to.
+	 */
+	if (sk->sk_state == BT_CONNECT2 &&
+	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+		err = iso_sock_bind_pa_sk(sk, sa, addr_len);
+		goto done;
+	}
+
 	if (sk->sk_state != BT_OPEN) {
 		err = -EBADFD;
 		goto done;
-- 
2.39.2

