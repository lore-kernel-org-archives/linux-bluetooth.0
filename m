Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2278ACDB482
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjJROgv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbjJROgh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:36:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7D1BE4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JquHwv4otipxjfG5znAgGxDqLxpe2teQyAWGJnBLpOuxBxC4HLTcheh8ToDuEP5LrhhmoS5mynKP/I0jdIlpNPD7krxrLOi5bgEkbgDxeiZq8iAprYVL5Bqd6OIwZ42xcLD+nJ0lIFVx2sBt/zaPkASrYZ4Y99EAbOusXN1dto8CR0EAf1EmPMwQ/f2nNZ5iKX/bK2bL8sOlcdFRbOzTSOyXO87UFAhJRkT83yCaquQ97NsIjQR2m+pZhfhwg2hZNerXSfUgRQbM/3tZ43rZ1lnxwRlixiHa/0K+0IkzpiB97CkXDxbMzwoL8vSioh8L89ansP8UOKW1Em27ZRGUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFkr+pPiyeqZAkLDBvthNj+ogr7ZqLB68pfSKy/Prpc=;
 b=OEAIYDBkTGQse62Ea+yta/Gujs9bPd55pqtwgCVyH14TFFW+md0ASFe3jSzmr6j0vDlEfJRHGFVmMLV5RzWg8TYy62X2qFXBInPF78EAOLuks7dDSwxcwNtQa+XZ6kWBj6lH2QuI2zSOjDm5RMHJ1qxGDjPnCSjVsLM9bO1v+VBE5c63yw95XjjMv66l2Pb+w2J45nGbte7O1PSmbtsG83nWkNoUah4oYv+I5pytWXN5C45lNCR75SO+jup4eNyJbM0MCyI42RFdtTdnbtwqSd3l/g+qm5c2/Nles5Lc4dJMbXdWaeIY1uYSithVL4ULrscKuWdYGzSl2wgCGalfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFkr+pPiyeqZAkLDBvthNj+ogr7ZqLB68pfSKy/Prpc=;
 b=I8xdnPIBPFh17sMqgjK7tUKucIOylbEJdOWCXbWO6lM/0rJ0UQp1IVVA5uPAge35XeiNmIZpC3HXMEpKPUgis39KE7MdLBdcYBcqdQYDTW8+4vL0g6auKyjdekc8nol8jCIvzHJgNm1GixRtTSj32idkiTcSnnGVghRuDqdkP2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Wed, 18 Oct
 2023 14:34:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:34:47 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Wed, 18 Oct 2023 17:34:35 +0300
Message-Id: <20231018143435.3388-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018143435.3388-1-iulia.tanasescu@nxp.com>
References: <20231018143435.3388-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0046.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: cc18ddc8-a66c-432b-816b-08dbcfe760dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NF+vzHpXTuf1p6hWpYX4TsgA4/LUv8MpsRIaBi/F29M7/8h/oqxPNPmKree7ntBF8RqJk/3aHL23ywNcdkWvcta0yeQW2TecnX1MHqYZLcTqGHFPhh6g//tg7GzKiDA6sUaMXDN7wy7u53drk/MwzKBJodJR44ZurNc+PsjpfSNGmlJ++OWYRockfEGuvtQAxqLO5A3zWbV97vOfCkKdPwMNHXhuYMEP+XoUOUXqXtQ5MORRZ6AjbOgDEoakVx6Cwu4ZjPK6y3qvZC4M3Nj9q6bFm3dDGUbuNxuA338bbwuTQSc9LrwmSBLCRfwGzPHuiqY3vilebYbjaIiN2yyUbWXKP8krcVwrelf755ix40ydY7Bhd05qHobRAQ78H4OPBSRqIUZUs0OPIJ7G3btfGHAkl9fdoL1ahQjOb9ofXGZXn3ODokgOjjD3OUGQgsJIrP/n4dGyQ44ZpMqgp2C5a+VUEc7F4Rto5a2tQRecB0+W8FNaDEzAIF1nAPcoVO+KnGJsBllt7BBOzFL0Mxkzz5/FXodPEzZZ4mQWt6DY4ATqqmxe2l7rJfbIAfkSpVvE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(8676002)(4326008)(83380400001)(38100700002)(26005)(1076003)(2616005)(6506007)(6666004)(316002)(478600001)(6916009)(6512007)(6486002)(66476007)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yVeNaB0gSIGaaVzp1yPMYLSohPKnBnpuavxxIGk7g5AIOXQ2W/4pYv5C1/WJ?=
 =?us-ascii?Q?ujWlgngSrfBy5ZG7HLEOkBLBTxfHcV+KO/V0qy4iOYBeXZj6Ct2SZGVGJV/b?=
 =?us-ascii?Q?okibM5J8n+9NdZnyppplShr6He5MgGibMNV/ah412knkI5/do/CeNF0XRIrx?=
 =?us-ascii?Q?qLAjX3TrkI8q37Au43ZlhPsCsx38bdNfnY1SrRf+wCWtRGErqh/7pYurwc34?=
 =?us-ascii?Q?NzsyX5RAC3voVxzA+QBQOympqbza3oJ9HmWGXEe7lRwi2jpgVQwl3VZEzBXu?=
 =?us-ascii?Q?koPQ2OX9wDENw4NuSYxhusaciY6PMQydnQMexKsvRb2b+G1KgOZLJnetbGS3?=
 =?us-ascii?Q?oLjYnaKAWvfSoC1HSgVf50LFkbpf7nknbiLiHFxdRNWr9cOH2xlTGyGOYzX5?=
 =?us-ascii?Q?txd3vD/r6wM82AneyK2I1mfb6LZEC0CvGDfn4cPPx1I2+qRYZ2ZSI1PBqh9Y?=
 =?us-ascii?Q?v8zh/0pjQW4dugleVqa8AsurdGdYav4APo0dpL+JDJ5oGiXAU02DxMiXMz/g?=
 =?us-ascii?Q?/0KZ97vl5Oq+lzKb7++QsgdmcCLTgMk7g8RSh1a5X/h26HvhLm1pip3x9EtF?=
 =?us-ascii?Q?p8kQnbZGvZxxRTfV5UtcGChctE7rtf21rw2qSkjna2n421XsUs6ccZDGgZNg?=
 =?us-ascii?Q?xyeXD+76KY73pNKnxk6IQ08j5ybj0z7gk5avXKbbT7VutFvGSZn24MKsrzsv?=
 =?us-ascii?Q?71ffYAa0lYhmKWVMYhbm7SnG7vumPXUHghqazRG4SK0v3c+H6zfy05J0Co3G?=
 =?us-ascii?Q?a4Ipyu+feb8rL7esNVKKLxd0iv3yG+OL91BD05bvi3v//m7yGBFvKtLfp7rH?=
 =?us-ascii?Q?JZMNvBkoR6bUA5D80vDxqmURef5Gt8/Zyw8/1/drmLCjtlI0pwWVoin/6dnX?=
 =?us-ascii?Q?aUQgjvvyWIBdakkyFaPdtHVluFcP6DxG6QB1fLB42t5KtP2pG9uk6D+AHgkc?=
 =?us-ascii?Q?w+oTjJp1rg/y4YqRQRGJiWPlvPEG9QU8ymfGLfo6GjVvy8SuvhYQ9Q2kUlPX?=
 =?us-ascii?Q?X6AtAlf5Xn+mwrhl+ocSm0iAv3zxmqOFLH5fewZ5Cu19M+5nskPXs8zAl+UQ?=
 =?us-ascii?Q?JBSOU5oEtk4ZsBBYWKFaQfsGO4NSYLQzY/x3Otg+HA9zxCKZsx5rpeLfs3L0?=
 =?us-ascii?Q?9rUOUwbw5PLlAO/mmVlmxBV0cycVyWcNxZEkMRhxNMrxvozDXAuLE3FcosTb?=
 =?us-ascii?Q?HQYKcFdaXpU3VVgbv8AynIemA1hGyWwfH0skhILWcmYtGiqr0YrlIY/pUqrf?=
 =?us-ascii?Q?cLkRI7D83ntM0lLc1McRz0BMhhzyrYaGnVSH7G6eV9mE1oR0bz+E/3rgIv/e?=
 =?us-ascii?Q?QLiEENxq1QvQoKBJHJ0Bc+NQmi/o8gLV1fHWc0fcxSIc9RHlhYzUQm1LOyeS?=
 =?us-ascii?Q?CQYehOy0sJWeERpLlFrfLQ2r73wwLbtjVHT/PQ+JeHqxEg9OTPJFZ+C0x6sD?=
 =?us-ascii?Q?GzXC2Geq8fQkIMd/t+h+ofplYhfqBvcPXi3wYZ9yws5EjdEkjU8u+uDh6rtx?=
 =?us-ascii?Q?2QniR1PRaD2Xnjn36fP4pDASa6kKGwBeeQ9hDFZdAUSm5S3WLdjQxhuw9+22?=
 =?us-ascii?Q?QPRyGrG/8ZTwhCI/WA0UuHIPX1zogTfVWMF9V0ZX71kM83Hfa/M1hps7i67/?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc18ddc8-a66c-432b-816b-08dbcfe760dc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:34:47.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBS5tIesXzKIT0/RZp5TvXHLaFuYNkus+bRe5hjbx+8o6+Y+IEoLP47VdnGa6/A3QKOtjYWgh+XT9Qzjc+DBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This makes it possible to bind a PA sync socket to a number of BISes
before issuing the BIG Create Sync command.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 07b80e97aead..f20238c4702f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -813,6 +813,37 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
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
+	if (addr_len <= sizeof(*sa)) {
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
@@ -828,6 +859,15 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
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

