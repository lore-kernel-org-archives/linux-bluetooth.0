Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D012EE7AD57
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjJCOix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjJCOiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:38:52 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C5AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STG3g21AajKp7jpaTPWzX32qL44OXEXV4MjUzKvBTemwz2dAF8KULTXCwGOCh/TXf+gteqpXFdodGnQAgxyLb9vPY/r2l2frGAt1wd/CUsUE6+aDzsmprBnKCAlFDe5AFoNDM2hQAvVTJo/qLyFZx1Xrm1VsjUSc8Pj5vA6NBcFleUYx+KM/+ks4z4eDUCoIC/qBxzVfhZUQKuJ8y6M8fJ4a+SDTjvdePAVYITx/w79pLgQUCyCfOzhlrIRx7YPl3P/XrFzfOb8xStO+nEtaxfG0RoRzHkJTyEAkRuOP3tMuAAvvqdJRNvXLg6sVsDb9TAMWdCUEivw3VCpEK4dI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXRJDiV2ojde2iOQDQKoUnuxyoqF+I0pQshUmBDQpH8=;
 b=c25BOR4wPU/2Vzpn19JquePbIVFDSDtz2anTbfwCMi3uoDGHiqRRVg3Uw6Yttaxsjqe+Rw8B4/YLXl2PilKuLWGSb5h7fQprji5FCtAVntwdcWBnJxEdTW45SAA/W4QobNv8qqlO/d63JLbMF35Cpc7/4x9QgMFDN4op+nElDSWVDy16llbCCz3Sl1seGdzZCM+6YS8iTWso4WhlUP5qCsTWZknNweFPAqTs532P9/gtIKXGzcDC0BuC5V6AdQUnwNRqZwthGgBOfKd+K/wEzoGhp0SMH7NRv7Uf4Ja2igZilwKnUHjK9rOd2cZfzyFDVBeMtuutfbMKHuogYhAWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXRJDiV2ojde2iOQDQKoUnuxyoqF+I0pQshUmBDQpH8=;
 b=ADHrEnD1YT4JcFSQUFuXKbR0z34nipefADZvUgh3GJCfBP89jtj+DIr6zJsg08y7jxPerMVqxjzVDR/KcDsOY5Ufj3pl2ORiPRc1LB4j9wad+h+ibD8WrdXBws5U6J9P0+ZKO2qsxG9/jbiixKhEMJjYcX3KYjvLrASJ+JEYvoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:38:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:38:46 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 BIS unset
Date:   Tue,  3 Oct 2023 17:38:39 +0300
Message-Id: <20231003143840.3009-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:803:1::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7905ff-0fe1-425a-0ccd-08dbc41e72f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYbBFSItfnTOQzJFr1fpUlxfsaPkRsQbVxDQAdrjbmaK+JGtYSexQzNlfMoKRF9rzXwfPCXl4Qz/D4eWJhsaUVHA2y9JHv6c+ZSNdSHSAnI+sSq78ydDH17qplYOhYAT/7PlmKrVFETETLMC2fXdnmtxjUESLr1rW5zdpTCGG4eLhjwNDkXoKMNPcPSFe4mOtpHHZG4Lgbfig5dDzHuAtQcOq/9FYMZgDv7uBwEKq/6f/06L8bGX+KDijf7IXS2gIus+1nU/GFgcQp7c+vmtBpztdCKeVFVzuUXkAcuae2+3ixmsiFENbfiMckpyvzJHmQJFDKffekngJ2530JU68yUzq3I95fm/ad5FGgL/m2CkpdclTsK6kaVixqKZAtMUSdqJAKnqvdu6ejCGYFP1kPw65ESM04kR8NRQJ4tyXw2bVsjXjxR3IVZtGmxSkqtaBQdHJvdJowoOS3exR7X/SSaev7zCGsYhtvofFAOZ1QuYho36AY9BKFkhubFEJht7/vVyOQwj0hUn4oER7cV8rassgxxgLHY9dcKuRwK88+85DWs9RPpIPY2kcycqkRyT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(478600001)(6486002)(6666004)(86362001)(38100700002)(2906002)(6512007)(26005)(1076003)(2616005)(83380400001)(4744005)(36756003)(5660300002)(66946007)(41300700001)(6916009)(316002)(4326008)(44832011)(8676002)(66556008)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2sgbVLCn6mh/2MiqRUwqNC4cq77M42iKghE9TBMOC71xbibPeZDmflUf/z7?=
 =?us-ascii?Q?Ot7LUlGFiouVGQA4r9X8wmIqocVcp/OCuFiewmKbBHuYP44iwpa6/+YF1gBL?=
 =?us-ascii?Q?zf1YNQ8vXZBWezeLFABM4okXWdI++Q3Ffg1GCVshLhng0RBnrOSsF6fGfTb7?=
 =?us-ascii?Q?vuGhmKO2lEg77X1Eazhbw1XNIxQyUe9yZw+6sEBBIXDLcXh0+BquQ/+QjdrE?=
 =?us-ascii?Q?WTP73d6Oau+ebaemaQYkiLVr1i2/h74MqJq6RsURWnQVTej8yviZKdTVZ5AP?=
 =?us-ascii?Q?ZGaVT94ZDI0xFRUgLKE4v3fK1uKRrPVF9RYestVZR6OBPz85tX6BAdvFdF9s?=
 =?us-ascii?Q?eGSopl/paCpMWBJA43V3TXYgRxqmbfSEuAvvmmk3RWCPgKAZD0hBmI1TLx4Y?=
 =?us-ascii?Q?/90Ombg3L+0SbD0kYucnpw2g/UGTTJy85hC+1NzFy63MBOiTlzGQoRq7VtMJ?=
 =?us-ascii?Q?3h6hKbh6IL1NGBGzqA4GPWt06+Z0dfPO9InqDJKKKm1wAqMnvCc0QEnzUBeZ?=
 =?us-ascii?Q?se/3m/ikkSg7Z7IQR6p1Kuw6U0Zq1faIax+zZ4JbZ/Zwf7PUUB90n947hGC7?=
 =?us-ascii?Q?wL5EhJPatKOcqmN23FJWP2oVJ0E8cPybyMldg/eZjuqqH0hzLDko0OsvrDFE?=
 =?us-ascii?Q?TUrcDBwdjCd3IvA0KgfzUHUA8WGt/GuKzPjqT0cUkamOF3zICllu8tyWStZn?=
 =?us-ascii?Q?aCVirw3Aj5W3qTRqpMURjGAmXoR4uiNWOuHzYsju/zg19psDE4gYZn5aL7kv?=
 =?us-ascii?Q?AST6lIzV7I8be5Xuvac8PANBMRxR1WRAmzKIfySR66OsqBM5JL7iZqmy2kMs?=
 =?us-ascii?Q?dmBJ4sZ7gcXmNA0PrQ3avMTnpWQvfXDnEMofWDAlKEZaEC22mvDxy7Ro3FFV?=
 =?us-ascii?Q?CSHT5UaOnSgtly+dX4ANtC/08B5F1NtPzLVeU1GvLifYIbw9w1cE3LUKve5w?=
 =?us-ascii?Q?tjRZshsr+otw8f1gl/9/kK+W2ZfEjivj+09/9armFZzOHeUM+HEl0ui2K2kI?=
 =?us-ascii?Q?85VW8pTUjBh7oAqEeeZZ0Ghfgc2q+uyV/zn+72k+EIcyNCWPMQ8R3DCCx0m4?=
 =?us-ascii?Q?JxhZZ4J2U9h3J0Km2N2UPASJ+6GEItjD6NIBpJ+EJD27sdvymZOlEv+3NAHA?=
 =?us-ascii?Q?D6VTvDblaLa5ahzm0g/S42MSiNSSPgb0mZa9qHVoPyRctow/2bSexLq95al9?=
 =?us-ascii?Q?v8feg9XSs+xz9O6M8UgfZbnTYkEU7mi8If4BXZLoCA+w3frqn9/TLgl3kTi0?=
 =?us-ascii?Q?Jl3p417GGgPN+/kKvuLEUGqXspjS51rmmUpP0HiVTWOOnM7JQpyEU1SFsTle?=
 =?us-ascii?Q?L79UnT92Q06+fDjsntqGhKbIj0aNiK8JoNo+G2gm1sdZFfrUvS+eoVpN5DQE?=
 =?us-ascii?Q?6zlXPk1EHby0FjHuYtpi+LbpA10L5L+fJgS6CBT2vAAfAHGRbWGgDCmHDp1N?=
 =?us-ascii?Q?+tq4RCN2OZnxca2nJZ+8vYf59ATa7gQz671VSN3JNeeU67uy2iDaCTQUjqmZ?=
 =?us-ascii?Q?W1WOLzyipr2fcF9IqvmzBBfFHEj8PTyF0XSPNe7ogiPf7n3AfdClOjNEYIQp?=
 =?us-ascii?Q?KdGgScLNAQ9jraCli1xt6RpGfXUgYerINlvTdyLt/UO3XFo+VV3NAtUMKYgn?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7905ff-0fe1-425a-0ccd-08dbc41e72f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:38:46.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EEoXOoZn/4jvpx5b9LrxJsK6E2XhVG1dPQj+uvvVPh+zw9Ryju9lf4d2X/qmrkm5YtYk8bBQgjfQ9NwJa7ptQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new test for the ISO Broadcast AC 13, when the BIG handle
is set but the advertising handle is unset.

This test depends on the kernel support implemented in
Bluetooth: ISO: Match QoS adv handle with BIG handle

Iulia Tanasescu (1):
  iso-tester: Add test for bcast AC 13 BIS unset

 tools/iso-tester.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)


base-commit: 5ab5352531a9cc7058cce569607f3a6831464443
-- 
2.39.2

