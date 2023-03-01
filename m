Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B419C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 13:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCANmZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCANmY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 08:42:24 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E203E09E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 05:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzxMoE+/VKJu5mF5kZHR9HWKSCXTNvWGioqaquI5ZgfFduTyPlK9kO2vrJ5B0gF+JuGaDo7eZ6kHaYzKV15/SPWHZWYK+hZtwTSxfVnEXHIgO0yOPFNXlJdOvHlP54+MucE4y/iufUIOwxaPwticFHayg3Ks8+5nxGMlH3HFJU3BMXuagY+6J3rapiRzHqCGsXnQqzqXOFZO2cmjilyzYHBzrWAI4HKyhJvsNDQS6mJsbhqnljG2mRlJ/JZeoUJU3Nq4Vxl/D6bPMweRZDsrbEq0U0mK3UCZ7iSiYSOYkD04pawnh2rWNJnPH68RJurq26Dpk08Rc2XSxlV3U05eEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfwIRcoNvzK4ZcdSVWZmP1O0CuMwQI+34DDIzRqWH68=;
 b=EqDHmGUtuLA3JVw5/X0gYWozlBDXkELgGGT9Jug4S8A2ypX4RIOvA0c3e/t8V9RxW4nb9OizuCMbpzJkm1c/VY1eM9dQtgEACdl50NdsHTbY6zcwSpBFxxG/naBIP0WQij10n74n0WCMNsd4LV1lxAITe6oZd3Dgwx6x5ftHOel3SNeeLcXBIwwJxwsGlucWmYTTXYd6+eoVIAvJ+0dT/qgORiUhraqvwpmQyNsQWmlfjKeSDZkb7vD+9FzsjmmDr3KO6+Uq7p3EoOMKn+9P2rKZRAyOIc5WavKboeawVZCekvrY0mGi/2BFro9p3pLO6IQlhgUImamq3/BIUqsZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfwIRcoNvzK4ZcdSVWZmP1O0CuMwQI+34DDIzRqWH68=;
 b=MgNIRADPVRfjjqpGNN3SquViFJqH+5lABRfV9Uo8yMzBmMMAuDNRl54kbCuMBRQIgcx6H6x92NC4GaW86aoo1YscslT5SUMInVotDlld2+U1E6bSBiLzKbFdnSwe7YcU7G1tu3wTnYTU7J5m8k+g6wm+EA4jF6HVCgeLWg02DM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 13:42:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 13:42:20 +0000
From:   iulia-tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Add initial BASS support
Date:   Wed,  1 Mar 2023 15:42:05 +0200
Message-Id: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6029b3-6148-45bd-acec-08db1a5ac7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2xt+GhFuOYhdtgbuGhkpJ+vD9OjzQflc3zGUW+qS4C66NeFaiB6MIHl9DZJ3UQTUzHCkbgkd4pCYWVPBdxfPtwcX+I/bomTxLr4hSv/ahe2M2U1GITVYFhvClikvLUt2pTDt1Hu1ZWQ6/K4SqU1X/8BFu/lAmvtWrSJon4+8dr30u2mhuPcKsAseSt+kx3agDSt3yf7fR3DKtjeRFXcXSHoNEKUTnNe07DpE5SzVdtVq+1XjpH+oZ/XomFXRxe3NCfXi5GX9iUmsuwSERkkrIRmwmflC7YyyxT5pE8ddIwqgdXLbJxWxv3VYC3fXSoxhExbeHWoI9E9ARGcxlPL2V+aIxLXJ2rGGP6g3e0WkYXZtnOgvbl/z/CJLXkc5sTBlmwol7hnHfousSpN3hipu5BFPvC5ZTiZCZwYRqVE3fz8l1E3MlajgDBinSfLgUivJsHAZiYo2qVNKElx6b8ZJStjTT0zWhkeMc9Aqwf10RaTsIraNravlWUtrVP1HeJmw+VY6arDwtPtAisycC3OGS13ypsFy7su04sf3OCo9N99Ot36wqYjmcZAlaMWNu5w7SKjeN8OpQelaXmBmU6JvqV6oGUIErGfydTG2g7iqC0J/MNfFcBfOIZhtSg9fF5t2aWRPVgE0z5w+d5NMpIn62BbulxlGu8uKrDtAtNECob8bbRKUNtl13OqqX7G4nbBHKt3NbwCZXp8tx87qYkSkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199018)(38100700002)(2906002)(38350700002)(4744005)(5660300002)(8936002)(1076003)(2616005)(66946007)(66556008)(6486002)(86362001)(66476007)(52116002)(316002)(55236004)(6512007)(8676002)(26005)(6506007)(41300700001)(478600001)(4326008)(6916009)(186003)(6666004)(36756003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJ2Jg8ASRSBkBqNAQ3l+iRg1LQc4TBo1Fe4xl4xzjo9DVUiWCtBtdaOv7FLm?=
 =?us-ascii?Q?qxs5LuxBsM5gpVHo1Qqhqux1FgBDzaiDLl1lfaYj1n8+piSJT9GuKPHlmYf3?=
 =?us-ascii?Q?RTbEc91leuDG2ftg4Yci26xNw2vEPRPb3co2V7mt5nkKGHAWXbbn4t68/qsq?=
 =?us-ascii?Q?dpG1TGG4k+Ud2NhMiK4M+X5uDkA3/K9AGUzPUVer6cxyFLSV5qL97n8UjwRo?=
 =?us-ascii?Q?x42n5KJlpUDPhbk83sQ1I+BeVTFv73ubU9uJGV5zBblOmcReEcuIjDFVLGrz?=
 =?us-ascii?Q?NxRGahEihN8LP9+DKHNMKb7lFsGwOrD/iKxGTePkFRWisQSX4ZI2WbfGY3Dr?=
 =?us-ascii?Q?ut5rd4zK43h2tDgBeRFxk0b9RPd5EVPq8HwgErHqV8Zgyh2Oc6fI2YWo72zu?=
 =?us-ascii?Q?vWu99LKfxzDpwMoq1lhUuowJ5oV5pyavn16h+YJHcwB++mw10T3W1/vWquCV?=
 =?us-ascii?Q?eXFVcA77+qYIsl6V3eajUJ9ZMFBlbAK301SR3Qawm++tochz5R6JA/PrVXSf?=
 =?us-ascii?Q?FuZtkGMUXUHn90MRkXfpahB0BC4QxsQnxqy/2RbF+5ascrwnontPq197nsLh?=
 =?us-ascii?Q?mmrA+jHnmV02FPZ/8I2NM93yw+lrBAk1Xdyt8p05SoIbpYEzPq+0y9BeHDmW?=
 =?us-ascii?Q?HU4N+Nf3dAPQEPm9O+jMZzrM7euv6kFJf2DXGaOsz2lcVkXrHquyyz9qy4EG?=
 =?us-ascii?Q?tVMYw9frOnIQPieLsn9KYuoqFjJwPT1wT9OstVaqCyvjcO/pLztj54qZxAKR?=
 =?us-ascii?Q?A9+kja/x9cb8QdwDUrLprNesd2kTGBxMIdl6IeolTZ4s01LXRTle20JbSh8E?=
 =?us-ascii?Q?Wp0qeH+kQs/h50XCaYlHT9kli11/mJI/VUHnhyXJQpfAdExTlXICw4FV2ONl?=
 =?us-ascii?Q?b7mGQeJbfHE2srDupfWLurciz9OseLAt8N4qulaM0pzwb5eOVGB/G0nXOgBT?=
 =?us-ascii?Q?bRbRNAno0pkhOO1xbKeBC9VmrTSQ8oUoY5SNL+G62XWo7X1dW+fYPbntndrZ?=
 =?us-ascii?Q?p/izPtQ50z7hOOoAOgyBY9xrm4IwOPIP0r9xOppE7dU6sN1M+hx4/IUXAJlI?=
 =?us-ascii?Q?zfOyLL4qo3Fv/518mRA3nZ9vGDWy/h8turTdRlC3f64ZUX3gPxY0BZeSp7Nj?=
 =?us-ascii?Q?CXVx+TtrW3Wd8lQHvox6tt+tFICSEfmnGbGoLXwc3mp00oZ0gr9Kn92EBeyZ?=
 =?us-ascii?Q?Reb1XWSlofeRcoi71iZK9xNgNQ8AMBq++Vb/kiR1fwFtQ/uL0Os3+dFR3NtB?=
 =?us-ascii?Q?UpObGZd5KRBIpbjDn31euyiYf6HpO2dxwU/g5Wn5ZT3Jbe1aMqHsCD0oWYih?=
 =?us-ascii?Q?B064nGdtRxvMobck2JQJc3qzYbGhpcx1IP3gVJi/2iLzQ9yxCUWUdH/DfkoK?=
 =?us-ascii?Q?YVWvwg8hVSNaCI+Z/Nba6B2rO+yWTi+4G6DFeUO1fuRo07K816fdn57gRiuc?=
 =?us-ascii?Q?T+b80vGhrAERJe43zkejIeK/Wsz0gatm1+vD7m3FNb/XyRRsmpOHP+KYM1nL?=
 =?us-ascii?Q?IQ4lAVHaQqbXvRPsgoHwpmMYB9swSx4tOHD66Qz+aF7IlJubx/UcZmDyiWRD?=
 =?us-ascii?Q?FAYvjPyKiKba0EkzP3ICf+y/iGQ34sR1HJz6Or4mMiFm/irCJo4jgdrRU1qV?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6029b3-6148-45bd-acec-08db1a5ac7bc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:42:20.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8Upg74Jm2gnUu6UxyQQH2Q+cnYVg3aQlSH2X12cOjDiRDG3FFk/T9tGSvI3lRy3lV9ExFOMqPMuNqIus7vAIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds an initial support for the
Broadcast Audio Scan Service.

*** BLURB HERE ***

iulia-tanasescu (2):
  lib: Add BASS UUIDs and auxiliary defines
  shared: Add initial BASS code

 lib/hci.h              |    2 +
 lib/uuid.h             |    7 +
 src/shared/att-types.h |    1 +
 src/shared/bap.c       | 1064 ++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h       |   25 +
 src/shared/bass.h      |   42 ++
 6 files changed, 1141 insertions(+)
 create mode 100644 src/shared/bass.h

-- 
2.34.1

