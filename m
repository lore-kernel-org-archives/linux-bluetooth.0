Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F5EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbjFMOUu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbjFMOUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:20:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4B199
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVBkYBv0tG6G8N8OCDNWuVGIlYmkqS7kq0wiLBVyK9XeAMVnkTPlMB/nhw0Ll7oEkHgaHFysQY7crqYzTyX8rhfAfcaAtE3K4r29epMOjWBYaZW31NK7AH/X285QVMyHx49eArSs8yb/7Kqu9JvffuZr7MMtH81Khq9hCr7zHB+BaNA9e+UcLeRu3OsH7t10OcpJPSg5z0wOLlxAmOdeR1Wd6+M/TMhSv1EUD3ix9VO0xlAXRMS9907jp+FHH2Pt05SfJa4201obyCUb8jho6osDmCR1p+THKkhvZnDsptIdRaRszzuL9yMBRkvKccAfdaVBzk4bVzPk0dbyi8x6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HVTzuHi4zBf62xYFmbyTbFWudmVQaGVcS4YEFo6aEw=;
 b=nKF+yVBldURzfvNlpkjLb2dLotL+L2S3cVy3E33WYpgOCinq4feRN5FqkdNzsJmV2GTKjSjB3PFaxbMgmg4lrc8PxfM136YEM+npT2dRlIFxunbTOA/eAre7jg9MGVUBuoDqck1uzogO9yUzdgq5o0nom+v9eLnCS80w1yCMDBFo+4nXf6yeIgzbaMXe4vjGmZD+BcpiH4FxCdZhTqGycFqtP4nRhDrkkMrPLkjlzOxh8AcS73kpKZQrc7RxliaChBiq+j4sH1rpt5xFaLtO1OrTyhTHY3QptonvisPmOfFsnt/G8eOkpHSiGeZfgSQhFTqTb0Ldq3+LskwTtRnsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HVTzuHi4zBf62xYFmbyTbFWudmVQaGVcS4YEFo6aEw=;
 b=XbBeFJuoA+DrqSldD7Bd1aMZUWj/4PdOXxDRlroLnVX/Qx+RhW9wqSq3+9RhxHl8eym2LqO6NEFKCPXi8NRcPKkstOUS14m82TFVRn+rRijNc3cHXLt13xZgL7RaCfJDBENFBmjEquzGOrTz8p5regBzCfTRp78WwcG8fwl7OOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7076.eurprd04.prod.outlook.com (2603:10a6:208:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 14:20:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:20:37 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        andrei.istodorescu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Support multiple BIGs
Date:   Tue, 13 Jun 2023 17:20:16 +0300
Message-Id: <20230613142017.9337-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9140647c-951e-45a3-66c1-08db6c195bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQ3ubUUDZnNfZktsiJClIYmNnbve9NYCElTSh4p30iH2qwqeqCDFNtkAV3lQV7mGwb6TiieEq13hClzPYKC4e/QmN+tC0or3HWpNZKQ5ffT9Ag2gJF8jeH0Iy570K5b6LTfJSoxo5G58JlAqxAYsZQ5RvfUP0U3ztqiLHtkRyBxKzD2JcMlMgUFH+i+JLFHsVR5kksZJiCJxeCxzP7Bz7JO4uCCVOoe1Sy8ZYCddvUY8lb5n2XO1n9GqFm7wmeuuF5fnjeOgxvcD2NIJPVVJN9+CFSLbiVUMwRwaaAubN7FtiYeDl8r1O7ctX1eCoAYmL16AxKCpXVSiihYrfbWCDSV/K9ct9PStPTioOQipC2XpPZnUbGBP5nzeSBS8p/4HYPNniQ+CcGLA+ve2bO/RRg1mKh8QyOcCK9ttGmgWfypQyaLK9DYbWKXXxWukkSNBOawCsnvRvNmncUEsejynHZjvi/X3Fss2rbxaHeMAMBbdJ8Mk0iMQnge8uKrlI4BqqamOJnHJdF66AyBiQ70uVFnmQNNIdfP5ODmkd2M+tYHv/qiSseVbRPTBYsHVRJKKy3I6yV5zvQ6KGPGjABdFMQtmwQdMplAfYIBpittRKTELU1DeEBNuJqhBA1una536
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(6666004)(52116002)(6486002)(36756003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(6506007)(6512007)(1076003)(26005)(186003)(5660300002)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(2906002)(8936002)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGF3nACb6GChVoXZe55o+xJ3z2VL7e4XkimnZy2dJKTHNmEtmaW3MpQ9rozo?=
 =?us-ascii?Q?FYYrCbBtik41RC3Yg2AHbEbLXmXrYozf56le/eMXQwfRUCJX4IinyzUMxXyv?=
 =?us-ascii?Q?tf0yll7VXRtl7aMoiX4HQNacD+ha03KhnyuqddNnFf1QaWXAdsdqvEY9QTh9?=
 =?us-ascii?Q?Y9K7KlVsNTNsyG0HKYxXTC+oj5Ifcy93NoelnJnhHq29FMIBqaZcFhCeTOND?=
 =?us-ascii?Q?QhTfRJorpcvGCYHYhqWyqls1BU/S884HT9VwXZ7D7oAHGMjKPan3Kr9ZzLCM?=
 =?us-ascii?Q?XcnwOa+1pKr8dhdzWTIGHqLy6JL+CV1eT8E62PyUcHqFAKnzHRN1E5eHNEWh?=
 =?us-ascii?Q?ibjQbBnjA36ZL0Xb+M9DPi71zDCpGWCc/gUz7LlF9jPvvc2rNRDP0jvcB1Hm?=
 =?us-ascii?Q?V9QMOsrylihmOJdLRhKp4CP10zf/A6dqVxLxao6dPsg05txYfQFNqaUcedbm?=
 =?us-ascii?Q?CJDOfPG7oDi23THISjKotlzteFwg8rWM2LnqWTw5i/8Mk9IT0YReQtjTBpOu?=
 =?us-ascii?Q?qZ+Q9ooXcrGDpdYah8DQpNfKbAhwIjPH5rOfUvaE5iR/Sr3jrArsRqVMrTQK?=
 =?us-ascii?Q?fNqGcZXV6HCW+ffJtfaUgDDBCV1A6VMo9d4ho89bJWIMZFsf3oFuhI17iPtZ?=
 =?us-ascii?Q?iFVksqf6vFHq+ZQYt/2SsOVQH135RNlMrKsksBEpynngJMjjwRmmY6jxI877?=
 =?us-ascii?Q?mZApoKugc4EyJK3szIhgjX4yNkzro2bcqsFxG9vYL5Y7XXkUD2KMoUdm+BGb?=
 =?us-ascii?Q?KW8ygG/LTGAbG/J+MkUQLg6/yfnmhCkFlfWzkBwdwVQgCtdCZ4TWBsalseCX?=
 =?us-ascii?Q?iSe6CQ0EdmY3bg6VPhf2P+8GEV/5x3Pvy07yWb0jcMNXlibwdlCYpVZtwhNR?=
 =?us-ascii?Q?4EGUuDrXPifhxsvL2NqODV135C1L0VNPfMsPtofbtY860X7HxLhKgLqrI/GY?=
 =?us-ascii?Q?EYQHINfVvwQzgwSX2JgejWap9h8aVzDahvu8qo9vyKIeMorgV9VnJbNl5AxV?=
 =?us-ascii?Q?7O8iB2q/z8xOF+CwCfTulvGKhmQiI58US06uw9zlv3fjtjALP6XgFsVMWCTV?=
 =?us-ascii?Q?6C8rR6n+to66q4/qEuLSbeoG60lYRSaqUAOJrQl3Me9Ugoe/l5XX81/gpjjG?=
 =?us-ascii?Q?4s2f9lxpcuIoISQ4kAUFhk2lO+IEuKaaW1ulmYnX9cMYjbM6yo+MP9ThqXJw?=
 =?us-ascii?Q?V5rLNTPdacf6zCiDpLNEGPxlD6wZw7FW03fAuMLwOH084zXAKgyaTABWCTOX?=
 =?us-ascii?Q?544ZGvx0UhRjyOFTSCmrR4U7YmgMxgFR0BzuKd4MBiTVezh3eS+HlmggtR8C?=
 =?us-ascii?Q?4qDs+TZIOiRBm3YCyWWnScDx5PswemWjzExFXBHynFCIkgxTZXn7rw+ItEU8?=
 =?us-ascii?Q?jRufqmxMguZPMplw47TpjtI+EwE3ar0Nzv2YJLjE2al4jATmhWDV68xcEX5a?=
 =?us-ascii?Q?OkhpCASODU7rnbOqwfTnPhYj0I5e3ZJcTpkkpQkODDpGPo7DlJ+jYlJEtvnN?=
 =?us-ascii?Q?KpxAK7jfkTtqvluQPeLeONCIu/D8v8WDDHSfoNt2HEW94Iz6iKaDLADNxypX?=
 =?us-ascii?Q?0R0pY05uhq7KckMI24p2tEE/sBZ/a40N4HnphUoR/tC+VHMRPgdis8FItNJ8?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140647c-951e-45a3-66c1-08db6c195bd4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:20:37.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFnTDEjnlGqreJBN0JipS/Di2yxtZFrLHDpsZ0rynktEU08DqzkgVCEom8a4bvlmbpKgtZgvXx6F8JyOqrdFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for creating multiple BIGs. According to
spec, each BIG shall have an unique handle, and each BIG should
be associated with a different advertising handle. Otherwise,
the LE Create BIG command will fail, with error code
Command Disallowed (for reusing a BIG handle), or
Unknown Advertising Identifier (for reusing an advertising
handle).

Currently, if the user tries to connect 2 sockets with the
BIG/BIS QoS fields unset, the kernel will assign the same
BIG handle for every BIG, as seen in the btmon log below:

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x00
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 21
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x00
        BIG Synchronization Delay: 912 us (0x000390)
        Transport Latency: 912 us (0x000390)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
        Handle: 0x00
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Command Disallowed (0x0c)

Iulia Tanasescu (1):
  Bluetooth: ISO: Support multiple BIGs

 include/net/bluetooth/hci_core.h |  6 ++---
 net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
 net/bluetooth/hci_event.c        | 30 ++++++++++++++++++++----
 net/bluetooth/hci_sync.c         |  9 +++++--
 4 files changed, 52 insertions(+), 33 deletions(-)


base-commit: 817efd3cad7481ce2ee25fac5108afecbad56228
-- 
2.34.1

