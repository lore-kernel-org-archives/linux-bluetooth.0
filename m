Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA1C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 08:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjE2IsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjE2Ir7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 04:47:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AA180
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 01:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsmz0aNsKWlfBhDlOVMNbrYsgVvj5zeSoXz/T9vPP9x6iBuLwXgtU2ECDMAB9OUWbpoC8cKa4NvCRlNm5HXc6cZlGUOyqBFy/8yE+vSMycgaTESok0qeEapzyK8P84WcPOI8SFgWa0zBOII3KrE7Gh6IAsNq0rWsyRnB7YxOBinKMziLcpeIyBdKoFrjhAU8iWPT3h+vazFbBGIHcsnHhIoGIuoNF+SmwVBW4FSgRq2MtssXqpKJKbmP36zXLtSqQ8Ynf+2PVukEX7IXcBqQqLRrSouLoLnVSrldX8boyNx3vV1/CbyEOhre19QOFvNixbpT0dVwdKX9RO/DhZ+D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/za7zhkH84R6aLt/sHG2Y6Vs75cCTbOd20fwDQwsuM=;
 b=bPiJ07uRH20c86/yJSrAFXCvxvJd4CIScjNFr2BjfzixIEQXEK9aXZrsJE+IDsNzOTT490vNDwjvVFHYg53t8OjIUzVtGzhEjb3CdOdR9FPqJrp4VqeQpCXIQxMY0QmrCb5oNI9vDM8psJhmGQThrthEu6lIjGo4dHHPjOTQ+KG7oet928jzQEpH6681emDafQ+MqYDiqv1PJPZ2tdhdWZ4kAITc8VQFTBHTK+bfZLNotl68tRzTW2K1iQoi/NOBDCKC3h6NCUxaFWNIHQ7Nx0J5IGUA7Q8lrNIRbW2gzJMUQRBC7LrCZlFHQuULGRwhhYTSHAN8FkCmFct8nZJFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/za7zhkH84R6aLt/sHG2Y6Vs75cCTbOd20fwDQwsuM=;
 b=ruy7uPcKIsUktxCanzsaAILYMvatYCAEXVEaeeoXgWOCGrBaJWyHMzTBWZqedbR2uOoKCfgFL2HfP83oJCO5lwehs/Oi4Hrs+uzjzRdy205NTJHB0q9351c1EDdDFdNVSRGuKDjpDfho+URGOuSZcj1M8qvSQpBgjLEjmrKeWMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 08:47:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:47:11 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] unit: Introduce test-bass
Date:   Mon, 29 May 2023 11:46:48 +0300
Message-Id: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: f47ece40-9b20-4834-2367-08db60214b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1owolciW2+pDFw69uyvyz9o8o6y/WT6nsuYHO3RdVEebc3OGJu2u8Atoln4V3LpW6sL99vsW0IHJpME1HzBcQ1FZxjTCDrc8rYkRQqnSu7irig5+azrr8YXE3dogchAPcshne/ntia59f6eUvyO/hbHKrwMJ4KVXWCVQw3BKk4m1njD/MeH3gHbchNPWadmhkD3qPqE1BmSxkVqd+1zE1gBL/cDQhOzI2DVumAoGfVnpNJJtf751n+YVrdBfUb4XRUKnQA3Mk+FT3UpRcH1WgipMFyEUXtEuTk2DpNySNUlx5JEOWoKfOrB8ONcppVMIsGjle5P5qJyvXf48YLTZs8H3YXm0nFDjN2Vvc5UxZfdEHQ2OWIRkxFiqGHX92UkmPTChaakrUElPJ1f7IYBrwxcQk6OgBxUCHRqebb3UreorIMWFYGvYh3t+ThHyy0DoSMF2q7jXjkcn8LkHCE18mH7nrCKzOUG376LnsDddTtlfQVJO7HjUq2b4zSTVodTBEeWWOJ65hMKjeqHmAHoqQCDIai4Srm3cSk0AzYnvqlaknTrhMqYlF7kvVhKsufVt9xsDc/dCqe0MRhyDtP6c0J4GLMxMbmqCZTwSYcdJWeBSOj3h6PHkwHICPc/9yW9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(38100700002)(38350700002)(41300700001)(6512007)(316002)(6666004)(6916009)(4326008)(86362001)(52116002)(4744005)(8676002)(8936002)(6486002)(2906002)(2616005)(66946007)(66476007)(66556008)(36756003)(44832011)(6506007)(1076003)(26005)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SbPzFUpROW8VkzD3OCKqEUzNOOzwas7ZKu2nBN4H/NbHI7I/+Ou+e9u0KL8V?=
 =?us-ascii?Q?2SX4JXbKCCXB9MN1BOuOrpvbpwOuk64QogWXwkoQHOEcJMUDlUEnunrchyvd?=
 =?us-ascii?Q?U206nWiMK12Q/O0Qj5dlLBAdu4yBA7CQs/uvAAb3VIh8oUSHzVg/xAZm8u3p?=
 =?us-ascii?Q?FykZcsQ5eRXNRfz9XeI/whj2LzOs5SXpBtw3KvznoZgwaSFvSoLECnYBZUvL?=
 =?us-ascii?Q?3CNkgGBCCF6u6NNQXcyZs6QIZUVU+BlROoXtkpFKSIK+cFRZ49a7lbaed27w?=
 =?us-ascii?Q?8zFO5gkCShY2iAJjeJYMcpP5+RWQ/wD+wAl1UJjoQRiTjrGedmDzsTag7guJ?=
 =?us-ascii?Q?S2aEOAKyfdq6B8fGDHXYxP+c079jzCxGrhdBPuF4MG0k/ROszzjyB06tIo4J?=
 =?us-ascii?Q?e8jMIpS9UmyB6DM7QqXd0UJD6vjmJjKThbwqiY3HKpbRCofwJ6wXsdZzoD+O?=
 =?us-ascii?Q?t9cyrj8709z8s2HQW0Ii3kR0iHdz0saPy9H0OPntPT8So8vLL2knzNFYp8iv?=
 =?us-ascii?Q?Pmwp8ckJdH2HOC+CbGZA8fe86i6jNMnj0gdpzyq7ARO6TFR9ZHb493sIfLi2?=
 =?us-ascii?Q?QV0wN14ipurBohlM+hGzXHXVC2vjhpzbcxhQpBxmiyxLGLMArHHYDdxSaTPH?=
 =?us-ascii?Q?E4X1rKeMvUB/QcE0xFxvbSyFjZQMCy5gTb+wKBXO+RLfWBzJp2uJboaflj4J?=
 =?us-ascii?Q?VIWSIt4meVa01yGkIcsO/NHPxcAEDwV9YBJ0a/PQphoFHyOTMzxVUAglwnFF?=
 =?us-ascii?Q?lQ9o43D25in6dbVlTd06CjFqG3pZ436Q+v3cOlFMP7c6brzFpS0DBqO19kAv?=
 =?us-ascii?Q?JVmtex2C9Sc505Ybdog820iE51FTsR/3v7jEYAVYA9E4lytx4r4ZDIyA23Yh?=
 =?us-ascii?Q?iowwQxO5DhFAOA5MzHSmG990ebbu2sUAbm4G4vQXlS8P3Cool9i6bqf9m1EG?=
 =?us-ascii?Q?bdv8ZzhXlMjKxJOnCH5xzDQZLgQlJ3o2P2KVRwhITIOfie8xMLyLxgHYUEZw?=
 =?us-ascii?Q?scwzmGNdylIA0dhGMAXGpAEyoNSRgh6IVvfnehUAvjdYm9LedZNhcPvYrpgZ?=
 =?us-ascii?Q?BBq6tq0iVCgh77qOEVOuEjm01if5phxNDpQyO9rU3kl8tLADRSJ7xEPomANr?=
 =?us-ascii?Q?4bDcE19+b7PCYBH39yBNpESJVYfovO6DutfBZ6q8jd2jTGtHbt06naoY2t1u?=
 =?us-ascii?Q?Ypp7Ke4B6SINTn95p7UUOBDxnwBOJUSq79+ZdfctaJn5HHMWMLznQpe4PYZO?=
 =?us-ascii?Q?fyQlCHVDe4UWsNLwTJxUJBGQWybpED6bpsS/TAJC2v2apCpFUhQmbAhmPvKg?=
 =?us-ascii?Q?XKY/q6uIPCGrbyW7pan7VogNRDiMSLqpsHwUIrZeAlfuPHJvvMpj5IKayqTs?=
 =?us-ascii?Q?10dhQ78Dm1bg89SVUaNDgcWSc0fnaFiFHnzpM11rVJ/V/YqrXfk5coJ0I5Yd?=
 =?us-ascii?Q?NJTAK0qnU+msz2POQ7blSbDim4lPo/lOgHGKsCvsW6CGK8S40/knuAgtBgeh?=
 =?us-ascii?Q?rohjScwP8iBoGPFLx+ussjrfvglRUppLl9OlYiv80UgYLXjw5Z1wuWBX/0a7?=
 =?us-ascii?Q?E/elO8uaR0Y+FKR9+uyJY5JVtWNiC4FbjTCg4SiqciGMTd2tNBwWcX6PRSis?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ece40-9b20-4834-2367-08db60214b1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 08:47:11.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQyXA1HXyvJsSLrFOAiktctiyGbRveSUcrB1kHxD9IUygFpin04VGdlNKcQhqEQP+WCxfof3XCkJup9JgPbNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds 3 unit tests for BASS server, to simulate the
Generic GATT Integrated Test suite for BASS.

This patch also adds the Write Without Response
property to the Broadcast Audio Scan Control Point
characteristic, which is mandatory according to BASS
specification.

Iulia Tanasescu (2):
  shared/bass: Add Write Without Response property to the CP
    characteristic
  unit: Introduce test-bass

 Makefile.am       |   6 +
 src/shared/bass.c |   3 +-
 unit/test-bass.c  | 397 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-bass.c


base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
-- 
2.34.1

