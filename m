Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB4EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjF2II3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:08:29 -0400
Received: from mail-he1eur01on2048.outbound.protection.outlook.com ([40.107.13.48]:45537
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232489AbjF2IIF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuoqrxYqKdsGqsn+gWkPt2cOjBSWQZav7b4ID+ff9HCsFvS63yNfa8Uo3nM3E72jpRg0/J3u010KZOnTKF2z8ixLeXjJyOAdwzT/iUuRBeWUDRx9buInit1zxRg2ZY4Xi2U2EKfMBAFmEBdDrCHoVCLvDeIMYzhQAwODCGfs5tQp/WvwXyFq2NxRW84aYH38+2jIt4HMbF1US0eYIneS/F7e7Py2TsrIprl3XYLElU+sjxyK+QzJjHiczK29LezrV6KhxliT8N8xEubxpvKf3QTGSxTbIRXBSwtBSgjf/56OyPGR510ksNNUeimcrNdNT64nZ+752Xl9rs0tEz2FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+d8UFXIA0I9DsaiP0Bw9RqQAqj2m7Kfr5V2JKyyaZE=;
 b=d3C0VDFCWf2JLfgxCEVnT43W1TYMfvmpWPcw6MxK3jv0lnxuiOq4VTs8zkqyMxAlWsSYVoxRBwoM4amJ/drIzIPRBJnpvzuPZSjypLoiJ8tmRbkU/73Q06jieNpCfI+cq5kG5wUUi6GC7ZEAnezQIXpzaXCG1YwbiRTdfcUnxmCXf2dxAE+CTbBLSVJ4hzKX1vkgYW9X5t8g2sDw6JuQshXQfL5CqoQ63eHced0YfwId6aFu74T0RATtc6DJrK2qp6WxpGpDJsEoWhNpuILdbHrGb0nYRygNeGiWAQhu3dUvkku4dRheMRi0fFcmt08drxOttIDPgNXvULZhv0NcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+d8UFXIA0I9DsaiP0Bw9RqQAqj2m7Kfr5V2JKyyaZE=;
 b=JOumddVNIdDS7gan+vmmtideg8aj1aef3pZESTVk1ZFoeJ/PoluD0Jr6vaNiVU70hv2DzZwV3cGDUbY2LabYcw9m9vfOX8iv0AMffFfYxIWaIQrJAWxwW4F4i0fpJYAGHRib1CF/GcEoMJIfusSZXBv5Ijws6iUQtj/c/fWdRnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 08:08:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:08:02 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v3 0/2] shared/bass: Introduce Add Source opcode handler
Date:   Thu, 29 Jun 2023 11:07:33 +0300
Message-Id: <20230629080735.525650-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0049.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::22) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: f0591749-d131-4c82-4079-08db7877f5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfaFF3M48aTCqvvYO3+L7owcgv46FJEtDc5Wyesj+1ZP3Cs/dEMw//4w0Z3OFt8wXpbMCvnAhbxIQe1JZIW4A8xfkfuJzPma3zlqsQBLDCdmSKPONMmCiz8zKOBtD+k3p8KN9vs/FK/ISyIf6utchukJdsDW5T0WaHIrdxEX7IqgqXd2rOaZ9iatcTO9Hg8chvgig5ADOe1A+m6ePaIUc2cS8Fr5wvwj/SktOwnEIBTPfzDMO5q+/HY4uGnfGyca1G6SBIID/izTU0kN3bUi12GTTfAqjBT+DaCffidXhimnfuv2T2unJMhNlbtN3ldt/h0AH5J+SWwP6SCoI9Zt4N5NXO7nKO7DI+PQboHqKbxWxD59n2AIrY8x5nVEsq6tJrjBsxBw9CyEcVcT4h07nE+K9MqteQdU1eZnvVS2PmmcjImnnhwmcMo1S0y8VFtTjUNBb3YfJWjEoLGfEzB++VtbX3FEpqMtoespIr/pzRg+SJBFZ91PyLUXHQy/AlRZvyIKWXylOYMMd6y9sSJf8EByeHM/RacK9zZcXLl423HSm4am0q9cH01fTBr9bUnTuW+uJr3EmWGWu3ulzOdEN8wnBUNdwKmC6uOMU3bUeQyA/lvc/0hn/eu6WMgAnFeKO/L10IxmkVFxMhKBuZXcikP6FGREMelcD0T22gCFPhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(52116002)(41300700001)(6512007)(316002)(83380400001)(86362001)(55236004)(186003)(44832011)(6506007)(26005)(1076003)(2616005)(2906002)(38100700002)(38350700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(4326008)(66556008)(66476007)(66946007)(6486002)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpCDqyn9Gv2rRtcAq82MTxh1ccf9R5UZ6rQ6ObJ9r1sbg3PzXHE4eZqylq7U?=
 =?us-ascii?Q?mcgEy9cDIvRNCLqagbmAeXMgUgu7ruEz10ksFT2In0lTdgjKMm2f+VAysZDn?=
 =?us-ascii?Q?vhkQzCJV/92GpnKPo5I/dmCYOwcdESkPSNtJcpG6a9+EiA3RUp/tt/1tqiRR?=
 =?us-ascii?Q?zENRrGCXULvVIG0WzleNIlrec9tT3EGr4POELDhN5rr3W65qBnbCBS2r5DDp?=
 =?us-ascii?Q?JdlvQauX48Uyf04S036eFF8S3jxYrl936HLHTzeLLKnx1aSedIx8I25EjuaK?=
 =?us-ascii?Q?p/kp4Hws5msEZAMhLVBoNysbhcRIH13cghtrTGDfjbF/T6y0D2r3oERcg53Z?=
 =?us-ascii?Q?eKPTmiuMW/Q6xGsQlWAcNRxppWRLJTomicmT1KHXx5zuYKxUIWw70sL44PGr?=
 =?us-ascii?Q?tnIwz+Fn+0QP+zqfRKW8VBGe/yBmxPoJfJB4rbX2hIh6BtaLrIj2jiEIeTot?=
 =?us-ascii?Q?GP94VNImqAqVV6P03nx0y7kCM/3PEkaGOOPtnIUzLc/blLle8g0zd/Z4HZq9?=
 =?us-ascii?Q?TzmUjiFPYYZW5C8PZB682zyWWH1umkJxkpDHsUxukAYstQ2FLKKcQhTpYgbR?=
 =?us-ascii?Q?d+SZHWEQpy18kyIuwNk7+oXdH0+juK/ttSiVrhMooLcyqabhafWJFT1qdGCe?=
 =?us-ascii?Q?ZbriLuBw+hLRKH4gGlhqU/eIA95fOQ68IcfXtveXfKU9b8C5KGu+JlZVm6YJ?=
 =?us-ascii?Q?GrD/dr+5Vmg6z7eqMD8BIq17R3QksQqWGSri9+FN5ElYfTJWfD3b2i88249Y?=
 =?us-ascii?Q?YebNklGu/tdqKBeKkIjx6KSGWgA885kd3lBm3EicyRY0CTR3tpYbTrC+CR9t?=
 =?us-ascii?Q?0a9Uq+dsLVZ1Kxn4u06Rcr16YXHsO4mZ6dFKLR2CdzSU02qljpoNPhk7DHfx?=
 =?us-ascii?Q?Uktk70gBT0okc/LKEKWhR7H50SBwuGx9e4qFQH1sFwHcgEM9HWLS9sx4mqLb?=
 =?us-ascii?Q?sEximgl3TzLt/H7lHdkSbxIHwFEKABeOA74mSjwBBH6Mk42XNGHm09Kdg3xf?=
 =?us-ascii?Q?OsV79xBhbDFjv+JGG3lHMT/gjrCJnAobrBpe0gKREPO6t7HitA43swZZzmRn?=
 =?us-ascii?Q?03Y2bDVGSSKRgOVuz9C2EJgBrSjKx9+tVCV9NkkaF2J/HuN27Hw9uBXujz6K?=
 =?us-ascii?Q?5Y5QVlPMVsldB3LSU7GR6xzMsjIYZ+SYsg1vt8BJ4h7Z1LYf27LeB+pDboM1?=
 =?us-ascii?Q?N3+q/21UDagecm/eESlmb2UoZSIhOYmxOkKvLMoDkyYjlwjXSzdm7CsTMgQ2?=
 =?us-ascii?Q?l8ps8lLeJOIRAZP3ECMak0k/T50Bc32bkKUQLQubX7xYz1Gm8N1VSxMfCI/9?=
 =?us-ascii?Q?Ar8VasXh3JsyJKirxRTm+TsY2d9uWGQHJ/dnTNkBam497NsFua32hnG1ktvR?=
 =?us-ascii?Q?qpN8TIXgh83LPPg672C45Dtua+4hewsetrilsG5BAMUtw5lybq0xH7S04pYK?=
 =?us-ascii?Q?JE+NlJuiaJA3D2Mie7G/RilG2M9TihqSOoIZV7T/8KDzkYWGj7yreeGZRa/5?=
 =?us-ascii?Q?LUqqYLj8VbGKeH8aE7YqGuNwghBPLD7rB/v25U0wT0VThBXnf9LBoaIP2CGL?=
 =?us-ascii?Q?9/TXOtKRXgQAteQsIhwubNcwuyCenPUzckmdG9xIWU8lCiTmvMqkp6MMgpyv?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0591749-d131-4c82-4079-08db7877f5ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:08:02.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbOobN7uZ1EjzjSPMCHGbdZiK0/liexhT+GWmo6yJI07ODw81+AxEoOh1wObEDWYZAaEJOBwExgnq5xvyCEXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds the BASS control point handler
for the Add Source operation.

If instructed by a Client through the Add Source opcode,
the BASS Server attempts to synchronize to a Broadcast
Source, by opening a btio channel.

Some additional btio options have been added,
to allow binding a socket to a broadcast address.

The BASS adapter_probe callback has been implemented,
in order to automatically configure BASS into the adapter
database. The adapter bdaddr is also stored along with the
BASS database configuration, and this address will be used
as the source address when binding the btio channel.

This patch version fixes the compilation errors from
the previous version.

Iulia Tanasescu (2):
  btio: Add option for binding iso broadcast address
  shared/bass: Introduce Add Source opcode handler

 Makefile.am           |   2 +-
 btio/btio.c           |  76 +++++++-
 btio/btio.h           |   5 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 427 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 7 files changed, 523 insertions(+), 29 deletions(-)


base-commit: d6bfbd28420edf91382635b229b9f8b2f94dc060
-- 
2.34.1

