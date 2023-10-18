Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5155CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjJROgu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjJROgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:36:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6551BDA
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1RjgEhrvrry4PRbx+Q91smjea8slyYmLj7QUV0oUj23WNK/IJUPAGocIDzM5AJbw4NQNSbpfUs8TJFoI3BSvkwHkwU0GJSSH2SsbCXJ74QJtw8giAAhV9eq5b6EqMGaYJwxN3ThZCcbVJU4Pu+Lv7y2iOlRhbF5SBnhLnH2nPlJ5HkrHsoVu1VMjDiDQOY8Amu6lxX1F53K+yV90be8BO5FSoWNuqZekFhbmyTfCDiwuAulteCLsXRHsGzQ51UKSCR0SgPqFpeECi1iAFF+LnujscVs7MU/xOBJkB+XQp3zYEzJ6cfZIx2HGgTILA0wGOXMJM1lKsgRJ652P4av/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr7Ys5/HIpmalturwR0Pu2tiM+sb042lMc7L2dnrHMQ=;
 b=aBy0oahXGbUOW/KClIspzL96qH4CI9bGAkGDCOKT+Hs+LpYlARh5CPbo3jFFIf9hNkDNf/expT9iYjtblDjPYQf2AljS85y7QEr6JyIhS9LhTB4nCbbJ/xT9od/SsTTw953BZUPAeiOvAAvCRtbKRXkZNRmYgvG4HgzDfZ/tpJceI25hNw8xSZYcwltIlLIBixmf4v5qKfqogUmsRct57+CLwcd6idEpgt54Ex9yqiiB5iN0HwfJZHln+QMQ3Nw1awdiFtQPjf//foFy3GE2SZBQk9o5DV9ag+b0Go/qhw30MxO2XDXW/7EkCZ2tnuyDuhVv9MWRXg+OuBlIXoWV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr7Ys5/HIpmalturwR0Pu2tiM+sb042lMc7L2dnrHMQ=;
 b=ImEo4Dz3PkzfjjHMN/Zt9hTpVCimAxjpyNzTq1jYFxOyQ8QweC2cePbTjRFTwbRSHGiXnENGQJwHxu259jYCzTNlthXgXhjo7ACgMM7vm4Uc09gsh6dA721SOaDe6UMYAiiOcDcNsT32QNEIHiL21P1+G3x+l0OX9C7tVQszDnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Wed, 18 Oct
 2023 14:34:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:34:42 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Wed, 18 Oct 2023 17:34:34 +0300
Message-Id: <20231018143435.3388-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:803:14::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1162ef8c-0c02-4440-3084-08dbcfe75e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLtp9GBV8483CxfzPpPrkNklfMn7PROXQ0zDg2wGnzEGfcEANVvu4tvWdDLpnRJzNxanMBdXWO+O1L4Zv/djj1/zftFF2aVf7Xp0v/pL+6pAxaoC1lA1kfnsuOnXDe/bSNvojeo4LIxRp0Gb1YboNZJhBEWvMIi7BIKOkGEki/Hh8wwRfyZz8I/ONb2AZ2fbMfDPAWZqn0xNuaMgN+bA6N569hrAQpH32bHYCAOP9JdnbIL0jL+sKWbF4oBSIkTixf/Cy0jAXERWq87BOlDgLI5dOjAEwsKGJAkvqn3tUbidhSDBKogZh3/fXYeVJ8zGDLRGytxHZIkVBLSNs6rsDhY8FytMKYczNJ5vexTRgMInwf+y5qZiTKF870+ilPLEa4SaUwNt6E/KaaSk2GSIkdZuc0k6GxYqii/r9TnMsDXPRW/sIZ3sYwK3Kn7GQbYB5rUgfFPglHbuSuh7U4jDptRCCSzE32Clr17K7f2VAeuMhQF3ypqKkqQ76QR4FIeZW1TDDWERejbmXNBTVuVYGFTvcrxpbnuVYhx7Bn301M0ZY10pA1X+YIBv97Umkfvv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(4744005)(44832011)(5660300002)(36756003)(8936002)(86362001)(8676002)(4326008)(38100700002)(26005)(1076003)(2616005)(6506007)(6666004)(316002)(478600001)(6916009)(6512007)(6486002)(66476007)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWu+d3o0J7Vql7tAuD9nsu+h8fxhDdHIPGXPI1wD9aQbpmDxtyA3w7/ipjys?=
 =?us-ascii?Q?x0S2pbpIfR3SqusxGcZtNDpU/NHsn0e+zVIGib7FjjK6CXU7bRWu5vd68S1i?=
 =?us-ascii?Q?8BU7xQOsbZQjPi8jr3qNCjmZNrBAPEuNLaT/FHl5JzUaBypxL+lWQkL/fyhA?=
 =?us-ascii?Q?IOKVdSi1c5HW/madY3JLSs/sFj1M3V+ibpoPRADUXxVTjBVlLbC1nR7Pf9Jb?=
 =?us-ascii?Q?roScwBRmvHWxt6mPjTKle8V6XKy6Irh1q6ac2vD/MW6xu/I+66kUUwoaLeiC?=
 =?us-ascii?Q?6xthE8uanhan3Ml4gk4rCalzNO4f28QaoBnIowBbI1gFtSzH/aMQYDVsRxas?=
 =?us-ascii?Q?oZ560gIy9MC9WUO4NKbLQgE1f7uN985m6gHj5wBCCLlLZ41P5H7D+hLflTmy?=
 =?us-ascii?Q?GsxnhSIS+89XeFj6kPYZjKPJqHlOzCb2rl2B2eTs+F3IbZUBMLvZo5qdHPPu?=
 =?us-ascii?Q?sIStL8F7T19WjgwuNUAGKh7XOvWh1omqceF6DnOoEiGMBrS3CSGUXyjB4tZs?=
 =?us-ascii?Q?4C22/OgAPQsEr2lRHP1ucqZuGoaRLSPuuF1pUSrXDWbv87kGg8wdtYhDs/or?=
 =?us-ascii?Q?eWbCI5rM8UP6B5kDSKVRx5tS55bjWFm2RXCPnJGDaDFcLTaGjHEIkKkT8cEf?=
 =?us-ascii?Q?isrugDL3wGHKQv1XiG9iKqwKohkyWp4NQXCoaxknV8QY24We1Ij5Px/4Lgiw?=
 =?us-ascii?Q?u8+wCgR2FY9iCReySRJashFwd/BnxEdNYyTJh+36nuflng5q7nfiW8p1Si/a?=
 =?us-ascii?Q?BGVJW2w07dEP3oQfIuxadJTTywNObB7Xm0/WiSxZ6nE2guis6nBEpOXA5NUj?=
 =?us-ascii?Q?rsyW778eVF7022ANnsJxJG/ZP91SlCiXkdrJE7jSYlqd+Oq66ISwFiGl9KRV?=
 =?us-ascii?Q?q4d/8FzGqLX87USB00xQRsxefSi18b5zuhGBGdHnt4JHsdsHx+QSd4Wdoqc5?=
 =?us-ascii?Q?70Sw3BpUlZ/ue3tnzPdRNLik02QPyXacNlQlJbs4DAC06dDOvPUlRkjK3tsE?=
 =?us-ascii?Q?8RVCCkgw1S7NKzZ2YWQ2O+YlKiJLFqN/l1rTqu/P8kbpSI5MBBxv8kLj0My2?=
 =?us-ascii?Q?a6VvHDnlAcOawcZesJzxiEtgPK6nJWuAFXZVYz+QFZ43/ZoiHHKXvetBMRE/?=
 =?us-ascii?Q?pc8K6Jxg21IgnMEsUcnpKb92saTiHsvljtfHK8nxAM2Ta/YWWkBxiEe2pb5q?=
 =?us-ascii?Q?DQOUy4pCwzIK+CvEk8ZahOfHQoz+h1y2OFi76mo12XhK07TvNzhxNXiYK4eZ?=
 =?us-ascii?Q?v5cFdb6Osog0lPgtuZ/aD3V3q9nvKUpRp7B++G+8MpTuMcN1RKot3UvDoE00?=
 =?us-ascii?Q?UDDoWL+S+nC7RmLzWFbPTeNhxWwzRrE+7eSUynpDjD9g28lP+67jkluHbTVI?=
 =?us-ascii?Q?A/hJrnHe342Mzvwfz7wd+Pn5x7qenOUaEfbvqyrLPgI3I5rLNmh6zS+JKeKe?=
 =?us-ascii?Q?7hrI6hgtffy6I9BQsc1X+pxKtQbI13Lxp1Pv7s7MFfanm2Ml9p4PpEWVhS64?=
 =?us-ascii?Q?RRWmzyIcfOcNXwUhYwqj4LGwkZpNNa4+5nc2u32qOHgQBPNJVygNIJKhjU+f?=
 =?us-ascii?Q?vSG558nlzv8s/GF1Wffb+yTdSW9z2Ci41EE2W8S+HUNqQDGZxu4Z22yd7+uj?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1162ef8c-0c02-4440-3084-08dbcfe75e30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:34:42.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL/elI+aQr3kK5b2X+vcBbn4fEwmXEiskpATpqWJ4NPvgpDoS5f2u7mItbhBeaS3AxRHdOBzSj2lPUaB4VMong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A Broadcast Sink has no way to know how many BISes are available for
sync or their indexes, before establishing PA sync and reading the base
struct.

PA sync is established by calling listen with DEFER_SETUP and accepting
a PA sync socket.

This patch makes it possible to bind a PA sync socket to a number of
BISes before issuing the BIG Create Sync command.

This patch version fixes review comments.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a PA sync socket

 net/bluetooth/iso.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)


base-commit: 2fddfadb0478a11952d4a3d543273f28d2c23c03
-- 
2.39.2

