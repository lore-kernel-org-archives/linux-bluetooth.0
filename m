Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09450C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjE3OOo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjE3OOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:14:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD8B2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGmilp+xRXepgjH7J9KVXFb+7HSc5ODaHuTu1K+QrSgo714XQufij75qbuMyEMD6qldCyFLg09q2OOKpIik665+s2SQVUTIbaZ8422Gk63KWBxL1olzEBq5nQy4GCPUX1HJIX0oFdhidtGemRCm4rk62Wk+BG6t7cAJE8Hkzewupw/BA2wlFmvjsbqIGBVzaZpG+lmjgRJBRrXQ9QfzYJPsQFzOjRYCKra+/EAqZNKd4RKgc4TLxmJbwZQvHwuGpi8gJMIJ4URnIbVY8phaBRA8DOSlrv3jamAfFq6Nq9SCs1bjz+DLlxSvzK3J3ndTJQdFLEzEtqD4kaS92VpBi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prrtlkswSx20i+y+G07lwbhw7BzF1j1gXQI+XgFfZwI=;
 b=NMoJCye8SxPzqgT1RX73joUTCxrGzPbPRmZLHAUb0+txXzJlFN/QuL5/EtPCXghlADgE89KVaIEO3aWNdQAZyIb8eT19NItAPzlQHJMDKR5umaeM3w0EPo8xPA+ooh7e//fCFiOeFv9gbdxL+/AWqP3e8Apdg1k/DoJ5Zti6/6rPJlqgacUpsr1L8LTg24M7WqogMk/+thGKD6HJ8fJeh79jWSf98v0TCT5ikDLxk4ZKrpDsi/xyUwSqCOWcB26dGJpGD+koBmISViHEmuiC+rCNoytAILJtMnl0f+eveGunjZ4b2dR4z2qVsat9Vs+VhICDCrmhZ7vFPac1IwZVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prrtlkswSx20i+y+G07lwbhw7BzF1j1gXQI+XgFfZwI=;
 b=kTM2u4yPbzttS4mlANqxXfVmiJSJlo0CtRNa68q6a8i9HQPGE1uPItSaqJW21OTk2SZLG9bSvnzJiMNXPKv5fq/9EDISf9WrfXvU7e0ZszWOiDbTpRaZD1WNOeVTOpJwxQVgECGor6tmh0CZqSLMfJOgXsonlJ2754n4s2t8znU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:14:00 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:14:00 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ v3 0/4] Add initial support for BAP broadcast source
Date:   Tue, 30 May 2023 17:13:35 +0300
Message-Id: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: a6161edb-a064-4906-9a82-08db61181d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PFc2Q4KtT0f/p6kdNAtmqD2MZNg2iRnbAbReU6uviTcuMCdSqQCZqMaB5vdLpWs/cRSO96YpGSnHepUM5+flSvpUh3vY4Codvv7729NvT3NcIrhkqVYkjxeUT60FMhBk1+0GZ+Yqv1cNp3g9RpuZKaOodDfVpaDgxb8Y4gK7ADzc/t2fIcjdcQq4jYkbNvZJ/ASZqNpxCsgRHWEwbxDcmmww6gYymgGi6EUWGkQH/rJd+ZGQSUvaQxcisgEgQ/MR5dmxhTxy1Pif2HihoHCfVnJWWz7tlbaPtMkxZJ+tpoCeSn02PxzW1VyBN3p1l2m3vhKyXM/ZnCucvI/IIHne1XLqAmHTqNAILWXNxNSp7nSgERtBAqPCKlTKrjeP1FCwQopugb/1TWOcjKK+9A+kiwnekOT+s17mGnA05ZpLUCNSMmOSf6uXdeEC5/AuBLbHQV4nRTjVWEDUGYlQ/SgQH1VzuZbfBwcDT4bYFmHpq8OZ5GGvyo5SSDckTZqlVJB1lmN/kro1eGBWSc3tYLcaEy4pYtM3m8WErvGWvfwvE7BMJ5kr128jBnhrR4itait+vOoyq49XhJ29KjOSIb0ehBLnZZsm82aYCdA7LL7Kz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(41300700001)(52116002)(6486002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(1076003)(186003)(6512007)(6506007)(83380400001)(4326008)(6916009)(316002)(6666004)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nm2e6SVN6eE2xSjH2AovBCgeBfhCph/AJknxp3ZNTnI/ZyYRCSp6j3AlH6l0?=
 =?us-ascii?Q?jUJ9EY3BA7WyR3fo4njFs2NOZMGgU8t2lJ8CU+fuNj9dFO0fxwa6b1jysVVB?=
 =?us-ascii?Q?J/m00o1hrcUWLggJjf8VQ6WE8Li5CA0mPAxa71DBcXue/as38FWn98qZg/CY?=
 =?us-ascii?Q?rP1JEA//rKl2AZloT71Q7RuhD+eBkAU8LVhyy3VulPXyxZ4x4ahng3n7Gm/a?=
 =?us-ascii?Q?pUTsJSVTB933X25bHk75c47knudYV2Lsv1rzGZ/U7Ceun+i/4/U3IxOvtlBq?=
 =?us-ascii?Q?7roToxoAoi7VKqa7y42hM/GfK+yAw1+zxMTdRnWt9UvG7kixnil+6pKp/DVt?=
 =?us-ascii?Q?J1sAo5YFM3FaoQR5mDJbmWkYMv+wiOxr0FGzMvTiO8P1kZ5sCyZWHO73Vtxz?=
 =?us-ascii?Q?gRgBRO5Qf6KtfFtPE+6F3RHJMWa0RIMMVWVDlU/1JeDdfyljOWe+l8aVFCGH?=
 =?us-ascii?Q?B6yUr9KDytpYekVUserp37v2JyY8gOlWzZAyGjDt0mJr9THWYH7/AAhwgEp9?=
 =?us-ascii?Q?1c2XYVNC980CJmICXmxM3WkRAalq9KjCiqYwHvrGFb77QUElUZwvsXqGOk3J?=
 =?us-ascii?Q?0rmmnWH7CgCSHdrtHAfFDczn6P4ozO5v2NWi9EHuiXf0Ac8SXVaiMOiOI822?=
 =?us-ascii?Q?vtc7ETLiVXdjVtx5Ai9xH32lBZ7V2n9ObwexZHFoch3cl/0rO9++dcQeIni7?=
 =?us-ascii?Q?4HnKuTH4/epHs4g6qaHBUoVGmf/dopCj8dcXeeFUjRTyRp+Se+Kw2XgAySp0?=
 =?us-ascii?Q?c3DtIvp7y42/trBVXryqoMlIPvZQrhaTIep2fnQr4Eh7bq0ygUxIHldPEwan?=
 =?us-ascii?Q?xBh0MPfYowiC/lXZLUqpzIx9+7DS0CAVtzqbmAsbMl6kSgExSt7moKDEK9pJ?=
 =?us-ascii?Q?NlxOMhCOR/urPapvnHDp7CCwEY+EEVtrVEOJWJu7eHZ9WeHCAbjdk7g4u/9V?=
 =?us-ascii?Q?raMygu21q55FaJBrVyTjtxrQB42AxEq8IiD8ZKmUY222FpEZFS7ggeNUhQkH?=
 =?us-ascii?Q?D3fS1EPceU190h1NvgsdgJxZmN0oxBNCSrgm1wpKGAk7j+XiFkxpUCKixxsa?=
 =?us-ascii?Q?7f48BWc71S7zT6jTJwV3n7HVpfM8bIgRJFkmF6gaVnmpk0HmwViDPBK3wPEZ?=
 =?us-ascii?Q?b2yFXkm7dOhTOSILP4U9KIQ5BjP9m2x8GRKvhNQYAyD725xmthF9C+WudRpJ?=
 =?us-ascii?Q?1KmzXTvZjx+ILCA42A31DKNatvatiBTALc557ybbecSw5O+Wm+dUQ32Bfmis?=
 =?us-ascii?Q?5iNX+J97mRgjhR9XMXbAm9qhxyBmB9UDX8BQGXpsML4sVJJWifaR3JqRJHz9?=
 =?us-ascii?Q?4qpnffVUCOU0xn/fYzNT2k4uvGRL9bK8d0A1FQ78rcyCWQDDLKYgeOyaAik4?=
 =?us-ascii?Q?a9y1D2bp55eMrzuYBW+h5xMTdQIYS0AH9SQ1N2bYIdR9S+O2csOPvI8hfZ/p?=
 =?us-ascii?Q?OdkC59Z9i1rjxYVOgMnXsoIyWIuLqWnZZw2ELfXAhR5nRbfS+HVCb3ZMYHR8?=
 =?us-ascii?Q?favtmIbTkhLTwrWL4xGWqzORMbIbrMTL6EYLXUHTsmYm5t+0/Ya2lrQIfrV+?=
 =?us-ascii?Q?xX3a4vn30FHxxB0eaW7Lr0jLuIaFeQK5oitiP2WtQltB+E6PQohisEyLrcUC?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6161edb-a064-4906-9a82-08db61181d21
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:14:00.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNmcI7OS6vlTWeYcWolWmjPVxYNSZ2Hdqa5OWLtCDG0zdwE0MTKCrpb7rO3Ge5Aq3LTuyyaDOVfbdXvuMng4YITFOb+ivAE+yCL0HsqFdnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds initial support for BAP broadcast source.

The current implementation allows BAP source endpoint registration,
media transport creation, transport acquiring and sending broadcast ISO data.

Currently, one BIG containing one BIS is supported.

To test the current implementation use bluetoothctl with the following commands:
# endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
# transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0
# transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 <file.wav>

The curent implementation checks that ISO_BROADCASTER is suported on the board so
"Check for ISO support in controller" patch is required
(https://patchwork.kernel.org/project/bluetooth/patch/20230510134557.11486-2-claudia.rosu@nxp.com/)

Silviu Florian Barbulescu (4):
  Split bt_bap_qos structure into unicast and broadcast structures
  Update bluetoothctl with support for broadcast source
  This adds the initial code for BAP broadcast source
  Update BAP plugin with broadcast source support

 client/player.c            | 223 +++++++++++++++--
 profiles/audio/bap.c       | 478 ++++++++++++++++++++++++++++++++-----
 profiles/audio/media.c     | 142 +++++++++--
 profiles/audio/transport.c |  57 +++--
 src/shared/bap.c           | 370 ++++++++++++++++++++++------
 src/shared/bap.h           |  80 +++++--
 unit/test-bap.c            |  75 +++---
 7 files changed, 1168 insertions(+), 257 deletions(-)


base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
-- 
2.34.1

