Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BFECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 11:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIULRq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIULRp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 07:17:45 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-oln040092069090.outbound.protection.outlook.com [40.92.69.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EF77E80
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCJrRDcUzvgcVOQ5SpTxHAXnCJE7GC4it+lToKjjR3GPjA3W5hxZFAKjTgL4mCBUk7K6290Y4mrfK6oJdMabR9OTG2CykP9K+h6vqUYzL4PqNscOK1XbpnsfHclv1vWMQWctzPl+FzE/LQl9sB/dCEBJs2fxauHvL/xye5RbhUiTc4e+L+dXn3k/IgysHO26ocHwlPbkxjX0ep3vJVoID0toY/4qu1vfU5ZnMAAqg9wwoTfhzef+dQzLbOTdv1UdDCiF6ZdsCBh7Sowev90e0vx0HoOKw2/O66K/TQ4wn8yc9t5CcWQYA7YIq9txZ48B7s4Y9OPGu1rzysYKavViDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VIr6BOpjtw6XqA5OXgagef97VCTzltc8YjKGmXE9do=;
 b=gZhWbCTFZfDgHJpRDmlsCZ69+oKNTCbjVXP/y1zLYchGOwlDImbniUgvB5bd4ShtAkTjYNrUfcqPC06QoUW+BoOxnBteTHvh3cTa32vMsvPWV+NqogNZmscJEZT1WZVDtIdiqwmy4LBP7V0XL+1OQoast0mfyX91YLKPExEdVbba6fp+LO2qS5jujk2p/3F+bdFCq2eShVMx/dP2clzc+66ghiCaEihEtgkG41KhqU7BtGMQmnXNdJJxEx675HcZfpuIA69Ohsfgqk1Y/BX1CpZ+X8vD2Mf7jf4/ZaiQx4hTiwrz1xy79HUh7K/L1G8KODegkO/ZIK0Reig9xPyj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VIr6BOpjtw6XqA5OXgagef97VCTzltc8YjKGmXE9do=;
 b=kdbu3kCVrCE6OkBkwt02C2MG2cV+WclauPTmMshEIJNL6tqo8PSbK7EVnsQEZBluL/s1m0zoDuSPiNsWN7BGe0E5lMn4nTgNeptrsrlq8G1xlXdqGhEX0/YtRSEwD9v2jg8sa2a6SBXCutV36LWt/hofrtcmqmFFbEQ8aOuhX45pBFmd7/VT7wofXcW5CBuDCeVfqXMF79YWo1sKKhSKqPsCCGUECHfQuS0z5iQ8DcJp0N17L6qfok6COt3MBNP1lSWzxlXpt6lLlSQOuEd50MQBke3nIDZVCx6YZGa6cXCYVpiY5C3R4F8goVET+rsCBRG7abo/pHh5aBr3YV4qOw==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by AS2PR09MB6342.eurprd09.prod.outlook.com (2603:10a6:20b:579::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 11:17:42 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 11:17:42 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ v2 3/3] mesh: Remove RFU check for publication set
Date:   Wed, 21 Sep 2022 13:16:30 +0200
Message-ID: <VI1PR09MB423910EF058411F1DF17F85EE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921111630.23589-1-isak.westin@hotmail.com>
References: <20220921111630.23589-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PAhrjtARE4Q2MIuCt2aIWBPoqNGmZN46]
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921111630.23589-3-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|AS2PR09MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2fad3f-34b2-425a-6289-08da9bc2e685
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4ha4fJmX2XaPwTe2qpKbyg5BCDSg0rnf9gzoz+OyfhrUiE/vbxftLEwoz+oNVgmR+jHqxMLesyzdZ/n66my6WjMudvmx8amWLMnTmwJU0ns3QIw4yxGHucu37YLl1T38hPWarBXDJYMkgbsNn6dXyCaYbibSdxsvDMz5lGeXr19UwB+UJpby2QhshqmJ5oMu9ma2pK/XMxaq7hq8DZnwsk+ToKeueOaUGeaA/88l0g0kwP4tq3ZcHEqxipyDpllaNhWkC3uSFE6q5kaTg4d52sid9AjSs2ipgrl69f+KHcFpVROswGXSCNjMzyjmu/p1GUOVkb7XAIUhx32haVdLIx1k0VHUw3jTypN3dmzTrKXAQeqR7sfF8ERwCpZNM/8bD9GH/5s6akDxvlXRCSYjKwkqB9BOEzxWBS/An8yPf7Zs8cYTySe0He8th73fe2nrjXrUdzhgC1Qatb+LG9vrX/WVKn18hJFxA8AC8XYfct3sfyzkwoXsFRW/6Duxzpe9PxE4ASMa4DGtjAkANfKaT156qN5tkgWHsRlffIys9ckzsKEZFgTFChkcyGt7WqGGVp6uiufWCsfNd2Pkt084eFumom/dCkHsCifFMtkVJiRnKzx5A5kUM03mIODF+43yG4MrgFpPcxx0ZZz2L4nE7JlTDwVB0Mvd9zYY3B2ZAFzK1gz8zbjVRhPkgjbA7aqghZDkNP0RhUXV6YO6MsekMkFImoY8FrldJNxdv+44afnIbjrNQ6TlOs2BkmvIZBXe8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNv4bgNIjN1BFqkkXZDFGaEAnA+z9tQFQjT5XRiahygBVdMeTDUCqoBZ7z/pftSk6hKLMS6DLdgkhrV5WdJl+Z9FChIf7EJ9zaijogg1aCaMIB4nOeboplau9SyFnS+RxMN9MVxKF0eAKuO2ER1lfptgCnAwW2zWJ9ecgUPWvxsjMNlvxPCJqbXOezsomaKwmUXVIsimSwj2cYHHN3IEnUAYJzrJ81I3LauS0vWqSKMkfaFIx31BFtguuu10r9mjak1Eazc0WcdO+gVlpuOyiseTolAEXzaqM/UmmtP2/b5GJ0z1GPk9onhp1ltrRNrw8X8OlrHs0Dtdq4MUkpMXcmkUD30rGjBvLgzACIeU5OUtdOrw6MOImjpqiDX0Qmh0x6d4Eq96FYZ28BlQDKoHrBmH1RhQmaWNNoZOFOK20dt6tjjizhdRj0Yl5LtjzTAYi+UQ7BAWO4sPVDKRE+W93pdjDEXmfwST+U7dz4ujP2vw2mxyhmwtq/xGdqY1JBnQ+qR1h0OW50Mu+m7J1dGxzUrdKKd6zEkdVtV7mfnSbhRpflyvsqT+bhDkXa+MCkcuc+qTgNw4kxS8sn58EbE8xQuKW+DvX0eI0g0qvaT9u2bKjHaB7L4WLrSgYEdCSdRg+y0ynkkiQXF/x+cBSScpIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nlUuri1Ccq9koJDrSj8k/oxcGdhSrEMM8Wn399bsh5TNonKvqU/L4ldJQqTN?=
 =?us-ascii?Q?dGk47F+9GBgy+gQMzHs5MfpGlQWbiTUDz/oGuCpL3NhBb00H01QEtPd8Bylw?=
 =?us-ascii?Q?/IG2JaYHJp2tZOCk0m15UbfZ7os93zrpeJ/ZPCoxEv6l0Aj7uA+VKsGpqWKb?=
 =?us-ascii?Q?vdOr9CtqcpeUVhKnwSjhddOFEy+6zslaJQOPMhJO4+QjISTdIGXxKq/XbUfi?=
 =?us-ascii?Q?QCyyyc6/B2Kd9fzdN0efZcm1d4YUP8RKrHyfZ0jQjCelToA8bEtfoiEhzouN?=
 =?us-ascii?Q?eyPZVX5CF42rsoTV/h1q/TnB3E5S2kVr9Tn/DNsauTSBfVChVy/WUTLSK69n?=
 =?us-ascii?Q?Oy7c090AnGHCn0F00QApLz+02gENN5tb17k5lk6HsN7RNOFzauWsHJ/ptILm?=
 =?us-ascii?Q?IsTroIfwOlTfFxVcLd0JEgDPTqP/XHrfIs4+sdv46LZJZpcWAESXt1XKaK/a?=
 =?us-ascii?Q?zZvXkzhRdR6zdpjV1omgg3tscbJ950Bhs+/SR6Cu0V9vxrtgrlgd23d+02m0?=
 =?us-ascii?Q?PmgpfaceSQ4uT0Fcp4JOe/9ty1/lOrNHdQtx9hGpnguHd6/30QJyeo/6H6UX?=
 =?us-ascii?Q?sC3ilK7IGK3FqcS/dZUE5e2TlPgcn75B+0idPzWC7vSsyAMQzrQYcTIwgmbH?=
 =?us-ascii?Q?jktKS3B5REZyy8lzMksJL1IyPV/9695DsrMaqIhjfIwrBSYTI9/2u7gSWwpM?=
 =?us-ascii?Q?Q3NLEmVnfxQKRFbmGgajVNNGrevfGbIWhySEmRei1l3zzk9xzjVFQli4tHPa?=
 =?us-ascii?Q?eHvPMuyTUMte5EfaBtm9n5ivUjDRDDdAYvGEgizL+yrN8RP9oB7kiST+xvFi?=
 =?us-ascii?Q?TH7TRILjBd7uVwuPz82gjKz0YCovBZTiHfFww2BvbyWzreTUVGZcd1CyLqNq?=
 =?us-ascii?Q?kLLuTzWI3bOY0FuP0FPKjrsP5/L0aeOCr3fMac29Xoes16f3A82/mXndqcwd?=
 =?us-ascii?Q?PcozwmNQfl/kfnIxH1IjHaLrIHo1PwVxwUkHzgZvPufHbIrWemqzX42KCUJf?=
 =?us-ascii?Q?wrRDcyIt6VUxdiETYUwyNHV3+LUKrYezTnpEH9CeobVbEAdVd7mXdUFRA17r?=
 =?us-ascii?Q?mfJxbX4j9RJNJpCxjsBKN9l2RjwTUqvyK9ZHtwVuIw/H1KJEsIQC3PUjkxQx?=
 =?us-ascii?Q?ShKoN+oCeJmSdrN4seulOjuS18bATMAxgCssJL60GXsRNhvJkIOAMtzt2DdU?=
 =?us-ascii?Q?IQ+tQ8Ww5of5S8FPY5/XPAoF8d27dEkpKB7gzRkwHnx/dmUdr9S09E4aDtCD?=
 =?us-ascii?Q?l9odDk+6Wo91qZCA9KJEm3yAFTEvIzP7xhWQ2knnxg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2fad3f-34b2-425a-6289-08da9bc2e685
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:17:42.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is not stated in the mesh profile that the RFU bits in a Model
Publication Set message have to be zero. In fact, PTS test
MESH/NODE/CFG/MP/BV-01-C is sending that command with non-zero RFU and
expects a reply.
---
 mesh/cfgmod-server.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 5eefedc4d..c1e1faa6a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -110,8 +110,6 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 	pkt += (virt ? 14 : 0);
 
 	idx = l_get_le16(pkt + 4);
-	if (idx > CREDFLAG_MASK)
-		return 0;
 
 	cred_flag = !!(CREDFLAG_MASK & idx);
 	idx &= APP_IDX_MASK;
-- 
2.20.1

