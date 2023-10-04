Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619EE7C4CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjJDPcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJDPcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:07 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696D793
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0M/ixVJQhVKDWNc1Z7/5/REsy0p63kOm2PfWlQpEFb5swivEqjmRMPrLjxsl/kF2SBp2JDnNSQVNAHxAshKeTWNZ4Fc6RhemEZWqLhm9zvRO0beAIcYprybUgmCTrN9UkSiUZcxB0w5yMfFW7SBApe5X7BIIbxHm0kM9logTeDFiisv5UmgDtw8w4Flo8crvUv0KCWPqur6i1YeR85YquWn46RofXoULuQU2xW9BqILy6exaZBZGIjiUoyIU+agzuc/qBs/aXCHLlda6cElCCR6RUrXRFb2lJygv+cPSZnk9G7MnTO5FxxF2HSRvz5O/Ml0NH1nCEqEXUGXoegVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUJ9kOAU9zWYRS20f9MpC1mtjSCUB6jkc8ZjGYlPjgo=;
 b=AuSd6apWyAMIYDgSrZOoCvN5wNFSSuyvxTpI3eltKnZv6nf3fFU27pgCtjqCG0Z7LoLmU8IUrzLjv7v2v2XKS7mczDpJgO5lO/glcXelGZxiuGckbr3//+d0qkp8+tW0C3Uyj63CE0tAGeADOBUT5GNZLIK9fIRsvzFhnBgYatYL4rG4N/bynql7I+taN/WWKXSXswzbLPsvYkxZixfyC/Lg5GLKl/PsQZQGbAax4COwAGD7Y24KEYdm1oeRyVpjfJmTbJ4UIGJmIK6X3AsZ5/sgv/OBxZd3puDXX618diD9Ux1UKcG99qSJqwWQf8Cit3uOd4iWMsLIR4ZMJ2zpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUJ9kOAU9zWYRS20f9MpC1mtjSCUB6jkc8ZjGYlPjgo=;
 b=XNBwZWm3mrm0LsZZu/iOnX9+CWg+qPNqxGXt73DcxJ/zQxb8Z1CAYnzjGIMxUPApglmLhF6WBMvE2pdatX3Ic9HeGTiG/pBYHVGraNyODM6QCQY47IT6um6/JblUC4VDRu478ixx+TgTfsgeYjmhl9qPM1wmObDOVZBeIY+52pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 15:32:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:32:00 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] Add BASS unit tests for the SPE suite
Date:   Wed,  4 Oct 2023 18:31:46 +0300
Message-Id: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:1::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 855e2b99-4ade-4faa-3f7e-08dbc4ef0d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehmtRgr2ij3drI6dcKOAu4BN0jh/3ZUV27zNeRNiZV1WDA+wWhOSqRGyOv66YH1LjoydxtBD+79LFZg97N5c4owk8jmlEus1q94sjfR/QDuhZmjLzPyD98Q2zFmUXjPOAhIjgOuGfbaz1qAxbEevFR3u6CvhxYsVfT5vFDc9bsLRQb0Piv1RiXEL6rs/d3ECcyC4wJXCd0e5kOGqh/B8JLSN+/KS4PxBc/e1R0HFZjZ3DL5jZQ3hTZw+td+c4bidnxp5sbGjJ3AFF2RUAzwhBhAQj50+tKaAcUsPLGsKFGok1XXs46NJyh6BOqMcZZ+mVVanGJtWtmn4NF7CkrAVnuioRIjfsVBB8eKh0CqvMzOsLNsRdsdLEMG6Dt5suBEhA5aEvRFk+IDAEDBUxIY2qO1ZhKtIPkGsktfCno5cbdiEWXCVg31VuCVbZf2eFbWQ4vVV68bn7aXv1N6OHEVdst465jMipOZST1Ut+JpWgHAQPd/9riBYsGKFQBkeu5DHZQa54yqChMubNSIn6dTAK8FQFyletTg5C2m1Fk/69MIAG/WZju6WmQWW42Fs0brD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(6512007)(6506007)(478600001)(6666004)(38100700002)(86362001)(4744005)(66476007)(2906002)(6916009)(4326008)(83380400001)(2616005)(26005)(1076003)(41300700001)(36756003)(66556008)(66946007)(8936002)(44832011)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3dBq7KQVdSeVwu359R5zxbM4E/OB4WjE5FUt7VH52NxowtkpuBEtF19gXEw?=
 =?us-ascii?Q?bEgC92CjEU30itY2IOFaFW8rylt/1XB9h9DqKw+97A+ToU6NYVvVRi/FUsAN?=
 =?us-ascii?Q?XJfE9bxpHDlXuq1Ri3EceE0iWg6npMSBZmYy0yft5I8iY4G6uEDKDr/Tyqsw?=
 =?us-ascii?Q?RNLPNmbEqO8lssuy0XovqqvtbPvD4uXAIsVqr83oIKOEpjGGfs/a2ozuF9H+?=
 =?us-ascii?Q?pvEhKpO8Cts2BM07LoQnF2mb4ZfliDgcAgmv/56SBMzxa1W8XSYGSXvLO97x?=
 =?us-ascii?Q?1HhHl2NxCzd557xSrixhwuN55Egk+XaPB+pvVepqPC3zm5vYLq6MQl5ZRV9Y?=
 =?us-ascii?Q?E7rWWHZcQQiQyinixoWqXixB21C/duMBblkffQ2H9qcoYJx3c/sLJKRg2LqI?=
 =?us-ascii?Q?te+FpIVgcKSzLu+LR8ugFyciVrzJlkmvc7LDxl5/tQO2o9EtwqujX9WQJGd7?=
 =?us-ascii?Q?h179aKo9op6fDPfrpXGAdvFf8TbNoCPQpj6QqAL91y9cV0aWieiasc9ntkFG?=
 =?us-ascii?Q?w7wiqHF0004Pl0wV06/xNmtb8PecdsPvdZk2NNHpkd1//X7MnKSk0+tgqrkZ?=
 =?us-ascii?Q?xjsbIfvHWKPGhLj3xBYq+jAHXDOgh6VntEsBS6JKsGLRmcgG9oMTRtS7WoEt?=
 =?us-ascii?Q?0iCW+3ktfulIEOiVdNjRFQf7THGCiChOfQxx71OaroJEdP+P6d2xqdik9U/E?=
 =?us-ascii?Q?+G9GdANcrhdFYFq+RsDTlUkChoCuZlXJpW4PsnK53hwdU3NY5y7/mt/yHGmp?=
 =?us-ascii?Q?go/vt1tfjhWCzxKlPURhtv1+2vKW4JLb2whAdoaMuyyJvNA8uG1VOhuRxArx?=
 =?us-ascii?Q?mPxoOrI3L6hI0hCcvaiyuVsgIIaeWoQ+UTggcYNdBjx8+QmjVQncZAMhT/ae?=
 =?us-ascii?Q?1c/LOO/t/N1NB1uoIXh0CyuM0kxUSZupVcB/9F/Mr7yM/jGC+Bt3EAmVktRp?=
 =?us-ascii?Q?Kas0G+KhpKhqP3w6R/JXu7JR+MIyRM+TwLhoLd8wr/w3RFatGKCcHWs24811?=
 =?us-ascii?Q?xFoUWa4WsYkvq/eUBPIOyl6WRM2pQCsfn8hSKnNk3FujaMQQVFuIo2f3uGPa?=
 =?us-ascii?Q?8e5F3KD9s2S0x3DD8fljtDrFwZ5CYzimNQB+RVSSJr8+riXM+3AradGldbo7?=
 =?us-ascii?Q?drDLL0+96Mvz2GgFG1WzPmm+HK0ebrZqtDWjKTYy1fCVn4ljjU7Xt8wmpL4K?=
 =?us-ascii?Q?qT1FaD9UBUqWsg7io3ghuidPJtR50H7xmM2sTYgyFs1shACf02xJFHsUK+mM?=
 =?us-ascii?Q?OpqK003/uBM63grNkMrMA8M5h1xKbOfGSn1Bg7UTSRI6UgJU9sGxpeShFDbk?=
 =?us-ascii?Q?sdT5VsM3b9pIC6S+0J0EefXy18Pykhn4uePrfxDMEkvJMHTaYGdQLzXREo7s?=
 =?us-ascii?Q?DC+9En5UIDg0WFgySaxU/yPt0rnQqc1hIIKpjZjQgwczIYJvCvExhXglP1a5?=
 =?us-ascii?Q?08K/MRL0cYFxHBYrI17zkpmBgYQ/3afInrbekGFq7ad1A03xC8KJ+nfG3/Gb?=
 =?us-ascii?Q?L+ASahCZYN065cxT3JFC6kFU7xvHXd4sAS1mE9+WYhZpmfVbkK2us9vxKtau?=
 =?us-ascii?Q?q4bVB+8JAFjE8i0OWoY0QQ693xDgI8jYEyys1gAl4TXwfmTNFEP2e4dDcz6f?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e2b99-4ade-4faa-3f7e-08dbc4ef0d66
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:32:00.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jN1+F/RzOmNOX+39QWbfqkQgV84qz2nUsb9/D36zQHcRkB58C/AEIHfF6smhT/3vpKtd+kafvE2pEW5fnbROIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds BASS unit tests for the Service Procedures Error
Handling suite.

Some unit tests require the BASS Server to synchronize to a broadcast
source, as instructed by a BASS Client. For this, a testing framework
was added similar to the one used by iso-tester, to emulate hardware.

Iulia Tanasescu (4):
  btio: Bind listener to bcaster addr based on dst opt
  hciemu: Add support for setting emulator bdaddr
  shared/bass: Add miscellaneous fixes
  test-bass: Add unit tests for the SPE suite

 Makefile.am          |   7 +-
 btio/btio.c          |  24 +-
 emulator/hciemu.c    |   9 +
 emulator/hciemu.h    |   2 +
 profiles/audio/bap.c |   4 +-
 src/shared/bass.c    | 179 +++++++---
 src/shared/bass.h    |   1 +
 unit/test-bass.c     | 781 ++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 942 insertions(+), 65 deletions(-)


base-commit: 5ab5352531a9cc7058cce569607f3a6831464443
-- 
2.39.2

