Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24FEE57EC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjIHKHt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIHKHr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:07:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D10F1FE7
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkgBxpkqMALNYAYCX2VloCPMqRNDVg4rjgpDbjNKXt0BHEEdj967Jcp0KnFIHvh1BAkNvwSd1xr+gczqi2i8PNdGXY5i089wnXZiQiklguFVZMVr/ojFalsb7Y5tk1Y1flYPdIC91Pl75pW+rxiJ9W9hJcKWZO2jVJbaa2X2FYBYvfMRKhaUb5PhOFAw8l78qPuMUMqBeXtatwuANJyX9avfUoF2Tfc/s3BagttKpRtCYGd/8BmEFuLmb+KLk2e5zFzd+IiAOlj5X0o8115eAku8UI24lGsoJpVxUlj+ZnxUpZNkUn+z4oU9YVmsPXQYxwiNsIRYXr0snqFbbJHDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=JE3BepRaLGWRuJpFwlVh7RQU7bKgmjUQ/4vylibZ8rhH4m5b3+7sHPDiqhIWFto6b3H4j4tBSXrbD0mon+VSaqAcOl2bdQcKf8dHyLtcV+2y4VH6MyhMT5cJWaoz1BUud3adVE7yJ1Rkwt4pnPYDHYTEsZ/I4X+a8PFPt+150lVpfmneajWxPD5KFxUxephoohiC3v1ulFS+EqjIHDnPI5bBRV4bvuYIgMeXQlkTE7qIrL412CBuTKVC4uJ2DNsbMxv3ababUttKpLaB/p4Mjbdx9wMpVseYOIiTEABTlctl4jNsgG4IeYnFwoqwVY+NOtrlgsMJDBDS3OjZWq9PQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=VmjQpphU49x34yyJGMMYwyjfM2pRfGPYDOGVm415+Q1bYUq8bdIf9854arIO/Vw0/GXCndEO9pN7Pxu+zJQtfsty7QBOTqX45irE4PhkDE8WF2yS6QYqx2vb0gHHgz5mnh9K2ZB4PKJ7BjGRFr1naChjtY85LuiyImAXU2L3Y7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:06:36 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:06:35 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 13:06:17 +0300
Message-Id: <20230908100618.63986-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::20) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f2473b-a420-40d5-c5f4-08dbb05348fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olVhUmF1a27LYQjNnFTxqd/8br1LRpqPZl1Gn+ooK666CZmzG+foxYZy9tz7kSS0qKLdE+Aq8lnku8vrLScF4Hlmok5GeelySQHIbxxk9GNsRsRwsjQb4PmDQCx4CjvM/atLO2j4MT+Leo/1rE3DdfOIdivOUvMPNeRZ4lJCDgMijlmko+PqABNnfYeNfRY3F+GAI+S8//nA1h4QCsP6EbFPyofrUABH4BcasyD18rEEayFXAv0rYe4gD+yqLiwyMD1ggGTzNvia/StLZ6zzdknG3brlkrb7NkJhKFnXeVbIZlWThwZXreZJ8E/SOrLTEqMYI15/8f/IIp/ZdrGJk2YbXu4cXl8H29tXLRpJ06PqDpFShf8bI//0rg9Zo4R2HBgsBX37SKSjJnh6nI41PTLKi+O9LId7FQSIQUuSHZaZSoYn9nhOEE7MlclYuyr9EV2DXdzQce7qQ4z0con5AGdZbsCackgI49frI/zueZ+80BvgOclCM7rIQ7qwttThmxDq0OxFojS7wJv9eU6anNgT3z7nbWbBRZqlAKa27QDuO8F4Qp/GtvifuwqA8v6SoxsTutuhxZj2wi1MnFsCONPiQe+yYiaT/LpWlQYw9UlA0/2YUIY4KMI+l8/6uJyF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(1800799009)(186009)(451199024)(38100700002)(38350700002)(36756003)(86362001)(6916009)(52116002)(6512007)(26005)(1076003)(316002)(2616005)(5660300002)(44832011)(66556008)(66476007)(6666004)(6506007)(6486002)(4744005)(478600001)(66946007)(2906002)(8936002)(4326008)(41300700001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNLYX81tAqSjnEpN0Bv1NXZRgdUeFqDzav+9p9rfwmspJkyMLoKVXT6SSc29?=
 =?us-ascii?Q?9rKNF4Njz5gz7X5CJfrUpg6GjkAaG7ywZk1PcGAkwuU+lffr9yYrmyh4OyFG?=
 =?us-ascii?Q?OfewbXJrMwY25hfk++SCKaXwO0pFjGJawvVh9zLez/5zXN6mpgXpSzt/2EjY?=
 =?us-ascii?Q?1Fx2jwDaqTICkNdxQD5wsAuanffVJe7jZTP2apNbjUdYtRXaete/rpuKhH4h?=
 =?us-ascii?Q?Z1I8qo//RUSowuZz8/DqWuoZ1iLYU9anhAhc1MLVQUgBJz/Zckf7iVSjtsJx?=
 =?us-ascii?Q?BU7hUr8WlM+n6cT9wF9Uj+dQqov5B5FafAEVj0BuIvQBw9laRYTnq5g19eky?=
 =?us-ascii?Q?vWhpiNfcYZueTPjvwKb9QzOmSqLUqXReUSmC8xZmsYc2TyhNUgeOsqi0IcOp?=
 =?us-ascii?Q?nmOFMGl80YiNItnetTd7zypsykanU8oIyD+vkMk3Nn0r5ObZUL4aSNb/bhm5?=
 =?us-ascii?Q?jDE/NKDCRmygMAynTeR40HmIXSVy+EG1qms73t6VUlW/sXtjsWNw3ELGo+KI?=
 =?us-ascii?Q?YXU9F7m7lLfOMXe44+TeLZOB2qt2rsOyVYQGjYNhbKBbqHBFoix7cfwFivLs?=
 =?us-ascii?Q?8/Le7uzgRdEdaIsZdo1nSJ96ChILnojnCzR1wV8aoi1/cqSkhq5HL3th/q2M?=
 =?us-ascii?Q?oQ3A4jdgXh+NZ/bRm6/lfd8elBKJvOpCkmQtJ28JXzdIquN9A7Xpea6SEf2D?=
 =?us-ascii?Q?MD25V+v0YD73gbozhRRzPy3an5q7dNauZjvBBkRasGrOJ2kukug/NCIXL07p?=
 =?us-ascii?Q?+GHrS7gYxDf+2jGb7ehha7KUfqUpMNf+dQ1bP8Ow8wyFF1taGBQzLSqFVZqE?=
 =?us-ascii?Q?2IiBYvpIGtboSOOC1AZqd7cnViOZ6rAAfW3ICb8tZXS3jL72xh221zz5dcNW?=
 =?us-ascii?Q?epxDhdk9GIpTaibClU1CdPZGB1FIwN4vDMNw6WNXsGYSK0BvfeU/nwMui4E2?=
 =?us-ascii?Q?s/y0mfnVtX4TdCq9SO4VXagriWkhTNuzdzx+Syu26ha0S5J7oz88fjtljEZS?=
 =?us-ascii?Q?OSfx7G+ZCgj+WFBKqk5EkXVLFWBD05MCFJxXwJ+96mCDiu39BWL5Da1TyPHD?=
 =?us-ascii?Q?sjy/7Tpc8Ch0tUZlYNVsIXKL19ei7F2JJwDBoZsPkMK3GUxHUvq/oAcOXzVW?=
 =?us-ascii?Q?ZZoFbSk8xF8n0Xqtt+Ymt6Rw0RDI58Ulks0DxDc9sy4TjzJCj8CddefwdP17?=
 =?us-ascii?Q?BDso0iz/Zmzyyj+1nRt22vXOjo+LIT62m6tK2VjB8Ss3s2U2GviETWnHMJcQ?=
 =?us-ascii?Q?t4XSey00LHYDMswsWx8GDTuzzsKvGwty6nYWNAZixrmIm1Q5fKdZX4lxnvsT?=
 =?us-ascii?Q?FfJoQVYSYqGbo6sutxcp34knWS3GmI/luJUk6U2Df0fXiZPpDiTyxjo5h8Rc?=
 =?us-ascii?Q?EWlcLvIOTLjrSmmxoXEq7x3SFRvGFDEALKex5re1vic+yI9SSj6JOVCUl+tr?=
 =?us-ascii?Q?W6hqAwv3V3vxHuLOrbgpr9Gv+DoA3T3zyZ6F2njeJzq1RAqWG52h9MVw6NyL?=
 =?us-ascii?Q?9OEPan/7w8Hjdb38v4VLNa4oM+aoRZ1XlFdZIr20BOpVA+QwUKHvrHkmU3Oy?=
 =?us-ascii?Q?DgGx1MsFWFmQ4jA7uuvnKl9sO0LbkOILUFt1A6p9P9hrpflQpLQV7lKNzoe6?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f2473b-a420-40d5-c5f4-08dbb05348fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:06:35.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKrk+LKSJc4FuVKNWZc4J5CWBNPcLuHEInbeuBWVCYAlbRdDRF5WbS5aGTG2hx1pCy6NyXwK/o/44WvwdOu8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Vlad Pruteanu (1):
  Bluetooth: ISO: Set CIS bit only for devices with CIS support

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

