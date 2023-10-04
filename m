Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEDE8FDD9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbjJDH5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbjJDH5C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 03:57:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296BEA
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 00:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/zVFADqNUt4o621TXeMO81E5+YyJdfXNvpkLWPlEj/WaQuWtV8FihuCTwAsMIuQaC+QkTD6tRz3G2kNoqLk+Rx5taT+JTAF5c0XmFfDb35jsclvLmSUQ2XsiDXwrMdu6Sb4ZqWj4tPCQVTkDX6FNDQUNy9EyM5BNO8Q4JFG8sLoOv4Z7jdNLbyMeGoG/U0cGsyp935horR6KoxQS4Mvvq0schaTHY3/j61QPMUGf8NRGkuEudBdO8vw4dSLnv9dT8DpYmqxUe+0GtnmJq7GT1igvL/iHAcf5NsMU4wxwmLDCE13e51QDpXDhvrflnfFAb+UYv3G+Zic88b82BUgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=S/XaoTsLoVQy73jiAW6ylijdVrvjxTFGPsslxxxtuBrhPrcvF5ONeTgpAwnePnZuzmw3HstZp0OAKruWxWpbFcZnaDKaTUgAdKj7pWSGilNwA1TRyaKJC4Ytbelu/sTNqWKhEjKhXmg0etJmzJ0veg7i//CSciWL/nc5BsXMAeybKu1vptoFowe/mzxN9agw1IHQKr14HPvQI6x+pCs1s/ardppmzD+tk2vq4h6iwje2NswHCTaI6agQPGNxzggtSH9GRsq9NTJ2RlV1UdnEipx0QfKE9ebquSv4bsqQ5WdFNsv1OzD22SQChmAU9h0O7utJwVLZUwh5wHziLCZxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=oRrJvvsCJ0rI/BCiGwsGKMpff3gKe5iXrN/8ZTqbptKFZNRPVvn+k+D9j4sVKolWDNkdH0xtpLAumKrSdIxZU1JdeKPsPXKXLIWc1a0Tbh0yHeve9ISG7USRTLii/6mr0Dgq15RYFYz3r8DbUBee5yytgPSH8N1feywyV49uJCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DBAPR04MB7239.eurprd04.prod.outlook.com (2603:10a6:10:1a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 07:56:52 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:56:52 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/2] Update transport acquire/release flow BAP bcast source
Date:   Wed,  4 Oct 2023 10:56:44 +0300
Message-Id: <20231004075646.4277-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DBAPR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: efa3f564-3979-4114-976e-08dbc4af782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwRDWiyU2ranXyQtEnaUdgM3KzvZpoWKafuMMmksBi4HnQNv3iP+UQXCNxSTVLnZHRYHbeM+eCaQKG7wZrX0q1KvvpNUDcYCwGETRMW6W/ZjDDAOQ+gZKEqeclMgp9F/aeoqS96XhnyoGpUA8JUWLdNOIKsrbZXS8uFjPEYci7FwHODVQsoSnkspIPshHTs2zeHoTbm8pHkZlOx0HSY3EW6IdfOKrEpnUXdjBF3Wl2OZhcQvXVkhE5xBm2qn33KP/bRm74qGDf/yDW3VwWZ51CvGw81pK8gYqQyaphTJHkEuaIf3A2xl5y8DsvC8h6v5MqVMyPT1rdhGToMKQOAnSXIDDjwmdYbpK3N29qDnrv4tHZvQI6dDFJxDvt5ZoOG1snvuHIUGjs9/dHkbIwG8VJhRA8XswGiHcDOvw7FidOIKEdvN5HoyvQU2cJKmdpDcUg/dUzteD9P8bHIwCIcEA8fs7j2TryB380fjGgmxr1jdRGvxrESxTzmJqDSwdXl97280jt0aElbyXicaFGyzIBaHaXWdruJyGV69DDzcdZAPtOAg9VqvyIiqXzaE99+U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(8676002)(5660300002)(2906002)(41300700001)(4744005)(15650500001)(4326008)(8936002)(66946007)(6486002)(6506007)(6666004)(66556008)(6512007)(316002)(66476007)(478600001)(6916009)(83380400001)(86362001)(38100700002)(36756003)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k31IqzbQVsf6X+y6yJuYlq8S1PW7BsiYErrzKrowZAELml4jNQcUjsTKzroF?=
 =?us-ascii?Q?jrs4ZOBjS4V5afYAcdDaSbA/ccVmo99O47RabS06Jw459eXUGdbzWg03CtN5?=
 =?us-ascii?Q?8cmFiDSacAd4xl38L08zdIcc05FeUN7Z+HIJzlMrJGZa1M/U9omd3V3Qe43P?=
 =?us-ascii?Q?WVtZofJ+24OK0Um6syqlfwP8Sq/J+A4RYa49CpOVLAis5CXysjB1pOTMI5WJ?=
 =?us-ascii?Q?lOgl1Ci8IJxXFFPeMt+FrrUJabYd2lh5XXKnrByp9FOp8S7fCyXgP22e3nNs?=
 =?us-ascii?Q?hjXUMrjHwH4klAqR/XFYOwT9S5uxBVBa7D9zaKN7wqJ3ieKtssdpBM0mCKly?=
 =?us-ascii?Q?M7NZl82vvcbccdJXFiZJ8S+YtJL1e30CED7xQgzC2IZhSk6mLBhaMioOJPJf?=
 =?us-ascii?Q?0IrXOoeZc9Az0HdaME8bDZaCM5yMp1t9TfK9iFzKjIv6NaVclpx/tPdJCL/c?=
 =?us-ascii?Q?CQSTXHxmhFF5rMUvkUIgXtvgy+FvIRWYKOFW91vek5i3Cn5AOa32Jjfyv1VC?=
 =?us-ascii?Q?xPe+g3yA1Q0ps2VsZQRdWJ+MgAon59kEAjGdOepxgw6hFcFEYdLrK+jyGPaQ?=
 =?us-ascii?Q?5TphiOTndFXNDrUftGLwBFezhzanI0QXirpsbe6k7Fh8TXknYsjk7/GoIy4L?=
 =?us-ascii?Q?WluIaG3BMCq5WNkpLWk7hk/Uq+TdnajD4kU2RAG0v1ofeKR13JR4AbtkJvX/?=
 =?us-ascii?Q?1G2stEOeqmLjbXpBb2NZOBMswc3Udrr70IBsxhuSvj5KLKuygZno5B3o844N?=
 =?us-ascii?Q?tAAxvmoMe+fnIP6e7I2+mezK/b7HpKe8MBBfsTQhf1gVUxAZMFtTEKwGMblN?=
 =?us-ascii?Q?fPjuo0gvXbwn1iVGPF3ZwvSROxKhLbfZvAlgGfS+C9khQsz+FEcKj8v3O4TM?=
 =?us-ascii?Q?sVuBzghrwE1m+4kMYS/qLce9qPhicGzzYsdycP/Ykatz/2hSnSVUdH83n4Mc?=
 =?us-ascii?Q?PLSPvYwqJo/uvjK8PqQ/4NfNjxlvKS3pYXkdMUGgOPxBktQkQIKiIp99pzAv?=
 =?us-ascii?Q?/2AWXDIYRA8icc0R7hEmVDucI6wChnK22PhpPGk0YMLcoj37Qfpd/N8R1l4e?=
 =?us-ascii?Q?nLVDwF85eaxrU7jj9Uu7awQlywrzUD/F1nAejTOp7E21GxCAk2gd4qB3f9WY?=
 =?us-ascii?Q?jESLYubnzLIqLuzWMEL9nLT/tcUREEBZuun/UA4TsXFzc6YokyHVo3RfTbBw?=
 =?us-ascii?Q?Yh4kCXRpEPLSKKaklRRxBNbw1LC2H/n+3gizbsdQOuLO6XPJR+niVROEfMFb?=
 =?us-ascii?Q?zB2rlrOWMAo1e+GAmLptxwuF2YQNG2C5E+5GZfZAZNIpMolq/ayWCW9ZJKQX?=
 =?us-ascii?Q?rWHBTKja0Zfp++wP44Zx8Udx27RCeoLgzxWt7hHo7gYkswfB4A+dDXVjlGa7?=
 =?us-ascii?Q?RB7XCMlfW60BeNZBbXOUTGpokTpevxY26Z5+Ehe1ntsxFqLkyQSAqXLBhf/k?=
 =?us-ascii?Q?E697Cl68F7ub4lMBYsf98F2vuxt1v2fErAscqH+xi4K1qe7+RV3szjwJTW3W?=
 =?us-ascii?Q?ayFXY/04gtHMawVWTWo9ZQAwrDHyzqU8Hp49c/iFau4+Wb7ZWADU8KVQjVDP?=
 =?us-ascii?Q?9GvNDr0wEEM0VzGpC20ldvP5/qtTyneJY78sIdUFHnJRBfoETqaI+viiO6+0?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa3f564-3979-4114-976e-08dbc4af782e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:56:52.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgzwsQRHMAQfo8qPCzEoY4VuB22vPHERbsNjQ9DyoizcHMohkITCQprVxTjUzjZrXIcbOZMggc2zaCqAL8VTUxwpYqWncAyngPXL1P1BTP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7239
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP broadcast source to 
fix failure on transport release, and second acquire

Silviu Florian Barbulescu (2):
  transport: Update transport release flow for broadcast source
  bap:Update transport acquire/release flow for bcast source

 profiles/audio/bap.c       | 51 ++++++++++++++++++++++++++----
 profiles/audio/transport.c | 65 ++++++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 34 deletions(-)


base-commit: 7a79ff88fd9576cd9935a8c0bab4906b7c38ea03
-- 
2.39.2

