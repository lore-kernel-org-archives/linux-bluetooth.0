Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F351CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjJSOuD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbjJSOtp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:49:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C91B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7oT3gxM/9zKTNSD3/Tn+3DJ5fqp7qxy2Yn4ekz4hpYqV8GsfWZUKxy5tr9mQOhnv9zatujg69i836kcYNFy6V1N/+i/PQ9tAp5VxMfxtExV6P1yE1aLVTE/o+/xs0P7qIaV9bSJYbaVGnlBBbqH/w9TcDEZDX8ypW/jPn3pcZEX/Zi/m2JQsRl8IIP/zzQ+ZHCt32oAYiiQHRmg+NKlNfFN6t0MfmaYPlc7B1D2s8TjxUdhUU3pquFpDPGdx4eIE4NY8mnxUbwwSrHe1L3ifkJz59NKXXvGjLnUpMv+b5kPZgft6vAJPeq8o1uQQfRmf8zYQUPgCMEhlbUw/ftC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWGKnhLseu1Kt52KH5dYY39yjWLAi46tawfqRQPPln4=;
 b=HL3fGNX4WwYWw54DHDIuBGe2IrqAoLoZwZcmyW08UMz4InBJkb1bhibkKKr05c3NDn/smBy9ETMGzdMYevO6K4OkXE3rNlUZUKsXzAs5YM1x1wBB2qJdDpPHqBzr8plqzJ33xK+2K6NY87FVzc2jY4axlbZ3NdBLXW1LhJMovRu/FvXrdyIbcRs7dTLOdKPmDSnZVkEIYq6oNs3g2leNlyoBIBmLIyTiIfbkDPF+vvU/RZ6+mI6F5TTvRVGE8rNpd2uIydlmd2TQOPaqcP+LdHMfQb0nhFXuZ9oFc8mzcVENRm3TWwpNMNx0HG/6Yl+ZzXfvj3LyNxb6D2TqZnZ+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWGKnhLseu1Kt52KH5dYY39yjWLAi46tawfqRQPPln4=;
 b=e8IVoaHBCTGYESiHWlLf4ku7UHnh4SoraFQOaCJXgv2MioKuCmjlyNhVfSY4IQT3Pv/f0V+IbceeCWsl9Jlb2n51Ug289ZCNPmz0qbFfUciD17/NWpJSFjN47dhkQf5jWE3rRWf2UPUXkvqL7f9mElFQA8PMM1Ra0ENMQcRlTJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:49:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:49:35 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Thu, 19 Oct 2023 17:49:22 +0300
Message-Id: <20231019144922.4700-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019144922.4700-1-iulia.tanasescu@nxp.com>
References: <20231019144922.4700-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:803:50::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2ff723-a453-444b-ee81-08dbd0b29c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59OaYktJU+mixs6kkFc6D2ijA5pu20B6NvHu4Z4G7/UDelohZ/6lP5xKgmIbJ0ri3+wjPjXscBGlg+Wxe+ePZN1MmGOpaQyXMnBkh0QFZriL7dsmjrQHaaqmALF9Q4dU+neu42ZZmptpXqvb3QszLqwYwrTF+EoeoI051PO5uEdZN2yjPGhkyKBYXDgQh3e4Y20F7uIHpO5r+JWek+yY4+bN1aUhjLtyMmMw3ME3YxQtw6SVS+iNhJ8ltlZL+LLqA8i+JGZD+5EoxwY1RSwJFTblq60CykYG6WVDMqePp0d+P5eTMKNU02WytQKodARr1PLeWzD3R2UxHv8AjwypGnQjDmU3PARbdzdIJi0Z0WJvWedroyfeCsR+7a4ZEQESeqya5+wWgn42I/CUYVXFhxeZKug6+7WzuBVo/y1GdWz820TNl6Bht/0lbYF3nUR8ySJe/ZGhplH5/Drixjh+SANoe9/pfhWjsC/asR/AtPGSDxZEiBfmR22O3qQtkHgxo3c7heJEMVydT5i/Onfr06MP0Vvs71+fH5Aux0JKdisqHBir/y5T69aV5D+dIy4d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(44832011)(66946007)(66476007)(478600001)(6512007)(41300700001)(6916009)(86362001)(6486002)(66556008)(316002)(6506007)(6666004)(36756003)(8936002)(4326008)(26005)(2906002)(8676002)(38100700002)(2616005)(5660300002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lmN0xKQBzaIZ23Z4pUk/8faCDAzbi/Qe434p6eYzn6+eeTrNUhpoTUcN202?=
 =?us-ascii?Q?3JXZsgQWY4xeCYKWQkWWPBSVTMsiX6IEA1/3qBr1v/UzFpJV0pPrOB7ND3Vi?=
 =?us-ascii?Q?9VjGrnYpxKvRVgutEE3hqogifRCC+5B/VIltb5NYbYqtcSpl6IzRP8mpm4K0?=
 =?us-ascii?Q?6COHFCm149rft69FkZlctIErc3KhBX3mu6olQTCs3CqNBuchRIfvfphjAOvz?=
 =?us-ascii?Q?zIKaJJ5tlcGtNEqCoSbZMxAYoh54EbTX/M7ntpoqlXQFzZ+0lG/HntMy6UfY?=
 =?us-ascii?Q?36SEHz5WRBCTOCBLSIRhGbbPZbSoU2SEkpjdYb+Nww9OhJ2+ujbt2pUBshCh?=
 =?us-ascii?Q?umZDamuvTtpM6AnQbTUe7xQ026Eb09ADx1vC2nDGG7RrFVc8Fk2aRfDrtNQB?=
 =?us-ascii?Q?MwZ/KKQNX6NwzmJlLjp5rpX3wNKx+Yr0aj+FqjSKGhnoQ24LPcHyxk0WdE22?=
 =?us-ascii?Q?9qVWXBSXF2NSrkn5RVthuo+Xl10S4VzMgA1IT4k4n5z/5FWRLEBECd50ywRs?=
 =?us-ascii?Q?Me6iL/6+tOaKSt0driySx7qvn2AoiP9iPfV5V97+NoWi5gWeOjYJKsVFXkfT?=
 =?us-ascii?Q?HkY2Puq19Y6XtKIOOYAD46shUVmpnqEDDHr4Bf5NtuaKgHOdU8StCEXwe70m?=
 =?us-ascii?Q?SmffFAK96ALeTQQG5lOiDqVv1dD4MI2AtnEjY/0dokrtM7eVTnzVo5z5YNpC?=
 =?us-ascii?Q?JxpM00yIGl2i5HTVhXM4QB4ieIbs+6FiBP9fHQHZtwUnmKUWvZ7yI2At2AC/?=
 =?us-ascii?Q?uS/Bx75ujGMtTul5IRRUJKksmTf711Sq1JsSOeNw5i95SBJcufS6eBN47EGt?=
 =?us-ascii?Q?Yem7SV/Z2sUWVZrbasbxg1kw7c9pSxEETHxPi6fxOci5ZLSoI0zIwuvh9VKK?=
 =?us-ascii?Q?vELC8+WzVnuUulmlTJ2/eYgDZwiGF7AQhEtouAmACAVkvV++tkqLxx42drbP?=
 =?us-ascii?Q?NwflC5tTlbBuwG7T5y3m8O/X5RRFe/9lYVMmNfmlcc10jhjHAtL/GdY9WLEM?=
 =?us-ascii?Q?1/V0naD3G1d4Q18yxrbVPH+EUnwz+b4VU38nYHhlLJGesliro1ESmFjXgynV?=
 =?us-ascii?Q?rCe9E2u+h7QuMVNntQ5oVvcC7UQcRduCkTzp3V4HyUONRuZxecHkTpIB5Xbm?=
 =?us-ascii?Q?HwVa8kN5TFIZH5SV3t3qCCGRyvwMKYGVcqVoJOb0mNHdP0RyZujlq/OEvBqi?=
 =?us-ascii?Q?I7iaqlGvoNqOeyWrrkrACj6zlE73BmvL0aTOMtGu5XbXnqvU56EUk3qGXRfk?=
 =?us-ascii?Q?ULqE2T4wr/1gP77N2TfPhiH02LPn3xxGyhjD8pw3ppcsSgUZrU+nGW3n+M/2?=
 =?us-ascii?Q?O2vqO0o65PXWwtR7HJlygkBhYI8yCdZssNj08KYahwxVz5WzW+ENnmVY7Csx?=
 =?us-ascii?Q?+HX8Q2LC9SNvdHacTXda1WYltwxPsRzb28qR2whkRRfRo6l5pGdbwcom3xCW?=
 =?us-ascii?Q?j0tqQn7LgPweJ8YxUa5rAIkh7gjYUx42joynnGLh+vCBUIwH0FTpxt5FZGL1?=
 =?us-ascii?Q?5W9mQxeEp3YaJFSavZScffPnqIBV6TjvrBFFIzKjL5IDO/Lq316+q1rnZ4bL?=
 =?us-ascii?Q?sh52sG9SUNlxSRL4WV26XMiI2KXxhKizwnsoDQabvU++lvYXqqpJ+9LE1lwC?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2ff723-a453-444b-ee81-08dbd0b29c62
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:49:35.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGFn5O9fGCLroOo1iqDXHg/W7Qzgx0MPuhqvFuGTmIFPydrjQRifPrxmSNZtFCsHCc0/WkcdKLrjuApwyxx0Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964
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

