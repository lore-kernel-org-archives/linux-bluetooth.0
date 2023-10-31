Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbjJaPzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjJaPzo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:55:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BBAF7
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0wGbmUMHld6rEbweI7BHcyFUZ53z8J+R2EhzYAfmFQb6ojA4LzlM0hIBaatv8Q/SHCG8SlVz9mjdLbtB1fzdIaTbxh8qpM1O8foXJFCmD0J+pGpDsWujm3JjSvxs7irZO1BRK5eWaQOM7Fr6JZsYU003LiCCx7sGYB9Fcz5AE8ZPAZG/D9dFCRaZcyDDArdTWjVz+IDecb7jlLP3vIFbMgIiscUQ+ZPuJ6J+N9GvKgL1c6dZg3moX1WUZ8TdWMRqntEGXQO6TRx4ASd4IN1PpAQSgbBq5nREAHZk8cFm01EMl5ncP7MQ+85btCA+Pqukj/BBHPVsI31RsVWvppazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp6wuEuXmm7Gjj5fthKxXcgAIKmvOP4T4Rqdxb1npHM=;
 b=SKK0cGBiI6xQusZJHFhJhbBag0mxsyi56gbzYDOIo3X5QcmLI88ZLPzHe4MMAmAFYuXJQ4YOwZPoWpl0zDOna41dDll5v+GAe6UK26uTDPpFJta7Q1aBPdPLLXPj4Gu23Z7IsZRnHxcrmahkiFylkCPYQAf+PfDFbO5TzHWft3A2WQg3+AeHRPlOfpBREbFfkebX/vJI10HHJj+IW+fjPw0fISKeQrpOpMtaGLcdKeVDuLQofir76FoFIZX9QwYO/LuDqhQrJr4VSZJGTY5BQCKp7HuO8FyKC1/G1k3grKGlS9IpKXcd+EaOPbLOVqOoOe1+LaM9z+Yd4RMvI1bmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp6wuEuXmm7Gjj5fthKxXcgAIKmvOP4T4Rqdxb1npHM=;
 b=n23TYRQ2eFrLqWB2kRO1R2MMw290NDpO4lNeGSSvW5wEygw3Gwp1ohlDRaX95hSt0AIDook4ky0eepAzru5nyJ33xm+maeU9RHYpCaYunZT+6BOHpwFW4UbD/YlUzGfk+PTb6nlluXTwPQup0nXcxBjpQATd9WkNsoPvQ0jEsRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 15:55:39 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:39 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 0/5] Add support for bcast multiple BISes
Date:   Tue, 31 Oct 2023 17:55:30 +0200
Message-Id: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0213.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::34) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: ba610d1b-44e3-46ba-292e-08dbda29d458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8hE55Hh2m31nNecknfxJiWxA1N9FKRLsignGGrBLO4TT7202QWcW7nx3ft5eJfSng1LQzswNDLWUp1cEC+ePfCYGZdhvTbbhnoI195QTABBX+dOEQwur9A/hYOiA6+jjo9xYNJ+sJJmuOHSo+Z5bPFdlmH3DFZ9hTkSxekoYDw8ScXWd3rhuemGeGVLLtQyNFCmMiQHBPYCtCyQAZe6YTO/BgaF2GkSP66X7hTpYvsuAb2gpida7UsGFOiPnEnr3QJ3b6GnWtzxjAGQPkn8eu1OjlIbZrzt/nAxYaB+st+p81Bh9ePOTwCw3SVdO5t7WtM0HZTiGm7QM3RlRBUrSCGNOow5GKEpfxH9COCNv/UmIlTw+lNorFHE0P1rdutrVXlqKzN7n1PTiC0bsgDiZoN3bI7l6VziJIjITKqsxKatg21GuZKOTvaSWDs2lcHRQZUotcZXGe0SQ/W1jvPhaTd9olYXmsZLC3COZojy14SqyXPwRRWmJ/o5nUZ6Y7yZ8cMWxE/b9ta6gTZyWCin02K0YSaNbuzmIH4/iLKeDxdNNksWDe5OyIhvyIaPn1tF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38100700002)(5660300002)(86362001)(2616005)(1076003)(26005)(83380400001)(478600001)(36756003)(6506007)(6666004)(6512007)(6486002)(2906002)(66556008)(66946007)(66476007)(41300700001)(8676002)(8936002)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vn4JtP1cPMXvQjLWJk4UOgpusYGhw51OU43OqFnj6KQjVFHz3191vNXNLbnM?=
 =?us-ascii?Q?9hwbAZosV7iWnmwMqODnzPuublfr5cPiHar9cDBi+sPOnUh+CvWivzszgN5v?=
 =?us-ascii?Q?iJkNc5i3fkgtZ3AXCknVVfNL7gmOKVPfHoTGoVAPRdiTdubADhwPeSqUO2Xy?=
 =?us-ascii?Q?T3IPJMYNNcNCShCMlrtz/qbVaZ1WlcvR6ZbvayQqSvONQKGwa2x4s1st+sUF?=
 =?us-ascii?Q?osvl+wN3l3Oufk3NUkVmFCqLZw4hqmKDIztC+E7hbjG1lR92AUzdtAJ5JQPH?=
 =?us-ascii?Q?GAjRWVmcHnXquLPvXJTi6Qeyhpm2Nrz9H3Uxs4Im1wElp+x0TENjllOub6Y8?=
 =?us-ascii?Q?SSfcMUSw/mf7EL5eMMd5ct1gqYUQhBzLQbEgGEOCJtoLkqcqI2CfBgBJcUC8?=
 =?us-ascii?Q?GCNAX5SxNehq26OGkWygZFlbDoSDUHz77JMvnKEGAX+uZqnHWSTEswt4pxUx?=
 =?us-ascii?Q?4b0zuDg8MpqZQ9CEX0SCk+IbGFXje4uWSN0cZBg15i2F38FC74t3iLMxJLlT?=
 =?us-ascii?Q?ina7qaV1qC0gyYNy0WSgAnQze/05hhfFZhqvBWyAj7uVkUPSI0wmlB3+6Ppv?=
 =?us-ascii?Q?Yrr73vFv4EZDAB0sBZLXgDhiVk5L7RdlsJWRv4QPOoomKotzSVnxEwKwBlYw?=
 =?us-ascii?Q?p4tT1dvBdFOlpSiWO6k14x461NmL4Vv9Z8wAtKzwj7L2GIr0sjTiNq7zOQXJ?=
 =?us-ascii?Q?S5Sz/QE9mgmv6lWRdldCapMdXd+Bx6+pGss4eAIuc8sXg+wmHGmWoeR0XeHU?=
 =?us-ascii?Q?Y3hvIC2zNr9pDe8xT5IEhAKeIO5/2G8mePMXmQM9j4qwHLaAnpqLwA5xjGFZ?=
 =?us-ascii?Q?YeXq9+L8MvBh9EUD8ZNLZtjD36MvyuIZXwHZZwyvKfnFh2tf07N4ndBnPQ+Z?=
 =?us-ascii?Q?QJpq/6F2dTlGzE6+YRg9yuSHWRCQr733Nqkln9o2tu77J6PLIl1DU7zAM6O9?=
 =?us-ascii?Q?9KnOL9Pu5XeCsk2twP+QaP0yjwh2vmnKqEGheYb8mp9OZvAs5qGXB4im2JzA?=
 =?us-ascii?Q?lRYsQEF9kFw60MlNj1XyolcT2aFKlXHLa2TbDdmp9jhgXzQ1nd6yoBaUWqfm?=
 =?us-ascii?Q?KkXhh8u5E45dqDlJqgTuohZiecnfWe+8809d/NZ1kTMxUBE41BE2w3kzM756?=
 =?us-ascii?Q?MKByHbCsIMh5bb5Lb6JGBRdfQ1+dB0Z8Nav2ilUpkrav9hwNtQUyRHtUZupj?=
 =?us-ascii?Q?5/uYQuec7yV3egiqGfatkygzP5P9TEEtaLQO6V0sALArzL4LGDMqv5UAg/Pe?=
 =?us-ascii?Q?2/evKyEL7EbrnlehN7Fhz9sDoZ8nJMFe1Rix0+4G8lhlm0RIKVmBzOFFIYq7?=
 =?us-ascii?Q?o9B+XEsCi56GElchJaE6OskED3m4pIFK4uWC+21FH1BFIE+6xwiV+P7kf0Vm?=
 =?us-ascii?Q?PlZLIdHiHs3mnETsYpIeLRyrY5XBp3uVVDT2nAd+zydiANc5jDqd0XaJyBrl?=
 =?us-ascii?Q?wOtD2eyR+yLdgkBE2ms0St30jJzIHM+TDOj5bSJxdGeUpyS6ej1/HVwMzhqJ?=
 =?us-ascii?Q?4NLnFyVBmDpDwk/6tT+Cy+n1k+cQrs5DaZqapqMACHFB1Ij8g/4t9oUCa5Jb?=
 =?us-ascii?Q?60/sqLnLVvHteCcso+sC8ShhiMOqN5xuMxUguM5knoQD8SeXWg7tbeFszg1L?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba610d1b-44e3-46ba-292e-08dbda29d458
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:39.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yWtdJ6YzyTa9lNEe+2d/nKsoWfzh4Wyj/Wlt5rxyN3UKcupALG0ws6mZtxpUw3yy1UDrWVhNENXLLzC2P0l4s08dKaBOaPt4HC40R9gYgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for multiple BISes
Register the broadcast source endpoint
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
After registration a new remote endpoint is created
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 1
Based on the number of BISes seted in the base_lc3_16_2_1 more
remote endoints wil be created (If more then one bis is setted)
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 2
Use the endpoint config command to configure all the BISes
After all BISes are configured, use the transports to send data

Claudia Draghicescu (2):
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

Silviu Florian Barbulescu (3):
  Add support for multiple BISes
  profiles/audio/transport.c: Add support for multiple BISes
  client/player.c: Add support for multiple BISes

 client/player.c            |  45 +++-
 profiles/audio/bap.c       | 537 ++++++++++++++++++++++++++-----------
 profiles/audio/transport.c |  59 ++--
 src/shared/bap.c           | 291 ++++++++++++++------
 src/shared/bap.h           |  35 ++-
 unit/test-bap.c            |  12 +-
 6 files changed, 728 insertions(+), 251 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

