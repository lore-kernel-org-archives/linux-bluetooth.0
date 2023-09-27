Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB5E810D2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjI0Lh7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 07:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjI0Lh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 07:37:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C1F3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 04:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA3/eCgvpmC9W0VXVfOPlH6GUqbCqSOau6PzJ7n+NN8ArVWIUCluct8aN4KmCksKssJJr7RPeX5ekZ6WKktKh9RB4wz/YwhkQinEPaRv19rk11jUymHoZY3RcL63EE1As/raV7gm3shdRu7cAipX6ZpEj+j3K57jmoTEGszBo+nG8pR31xi8cZrD/SG7r9T/g9OuSXWanDs5s6yFQrZ3+9DN3mMhtDrxIc7VeUN5hiJjB1RHr9GGtq92K8bzIfHsOr3f1qHqFgB0w5PHcCSCXat6LvdUUm1kIoTGMs3VpK1gKsNYZWsOwpj76+ofCb915u34whqQz/7wKSPljih/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw1W/Nv+5twNQhityYGHTW0iIOuRUEnUR/rXhvX8pGc=;
 b=J20b6HvDwbzz+Ab3LZ5H7NmjVycwGfv3Q+rW7ihL8Mgzc4S6k8rPdzHsmCSa5xZnY4DekckrA6t8/FoXAAPJc/Fe8N9zsi+pprPpmKwY5gp3H74kzGmOkNw+lV6G+SOOqzjjXAit+BeGWuqZuSj1XyAzo6sX/FURTT9VmwjK20cxJQ0uNld9e0T6EDDG0dAmStqWWNWv4mJu5Lkp9F03x+fBzEX+lN4hlmfsnbLHkBG/bYmQGlkOQ2w2PBrEFchZVecm2LCIQxgZhHwQHLn6H3YScCv06oUEaKKMtfGdfEEls5YJcxGZ328D7Qvv2A0oi82/IqvQvRd6KLia2izjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw1W/Nv+5twNQhityYGHTW0iIOuRUEnUR/rXhvX8pGc=;
 b=HAkGd4eMRXvVVSGbcU1wss64GUjTLVwUA7WiuH8RKQqgW6dRi6cYqsks5b7NgHxtLuZMYsTkXZKxkkW7XOotRnkB46zEWDJ8Rc4qGTMDCnSGxe69KgLP8QgPKwh3aroMLi1AEVWCzpXmiyQKv36B6LdyscX0RJND0RmTwaYU3x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7826.eurprd04.prod.outlook.com (2603:10a6:20b:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 11:37:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 11:37:53 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Fix invalid context error
Date:   Wed, 27 Sep 2023 14:37:38 +0300
Message-Id: <20230927113739.3332-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d6f77-615b-4df0-9f0e-08dbbf4e2fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LucXmxG/pNQRpxgVBsTLnWsQ/qO3yHBLENwh6zanK2R6Z4L6a6IqRw0dJo3XqUtHeB6YUrFYWLtXd3sPTUwGx+MOl6/NyATHbcBX6oe/WADKYXFCSutb5IbpBcJ9rnN+DyyBBvHWe7+2BmN8pV1r8Cpw/HiCNR6BdVDHeZc3GT2W/tsfuqTcDch2n5R03fiEW+gKelz6MQhECNOBKOC1bdmgXXWmiCksV5rMqj2mU2nJN0Jz6Jnkc2C9w4wnb7IipIDtgdp7TKlN4v2mgnoePRF4JT8GoRJMKc+OV28y+VTP/99hs6wUWSnDHXlvy6v6+UGWjg8Mndg6HJw8HRlM8+qqmVcoMKCDwvYXCStaDmsrV89s9sMLtRU2BPLMo3NWPpsv5cFPU2KBTUTcioBYECqPoSJIZkZD/3cQmw1A7nj6jll5fdc2zycjBuFYM6SRNwInImoaR7eqm27fcC0rhbIcNYT9eA7c0k+VjnXHtxnhWbVV59J0jgYhxut4CpVTUHjwaQ2kGoAL0cglSecJPv1kYcw6JC8KUMVx3p8bPtMG9wlL/ClwqoluS4zC2RvW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(6486002)(6506007)(38100700002)(83380400001)(36756003)(2906002)(86362001)(26005)(4744005)(6512007)(478600001)(66946007)(6666004)(1076003)(8676002)(2616005)(4326008)(8936002)(5660300002)(66476007)(66556008)(6916009)(44832011)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFfiUuit3lq9l8v2yHngH36JB9r5y6wkVLZJhOai8QQ/elf9mmnN2ZOxqbKc?=
 =?us-ascii?Q?zM+uScTRqtRkI384oCx1WSUej4Fg5P7MGMR07TzG8RrezYeHc0QKK1W7w+Os?=
 =?us-ascii?Q?0pbDdyIZXSlFNonFkAIfeqk9fS9azlDkPhW6PXsm1KG2tXBOxIqvDfg5XA/Q?=
 =?us-ascii?Q?83VkXWmzhNCuJIP5Igg7gr/SCEA1jaIXtSR7sKuWSGndhWys0JQddKuBUD4T?=
 =?us-ascii?Q?zz3+Fn7nDcvodA2d4v7eFwyEhY8GkZLissDtievCZuwFIjjlf7L5CqqTZlN/?=
 =?us-ascii?Q?GXWd04o/2Gy8N+jLENhyWsI8DR3EyaU6VjKFXxYaIlD8CgvWoEdyLXKqg5ix?=
 =?us-ascii?Q?ET1oLfyk/fBJZ0tE5omOI+MYpzNFc5AIaqOOEaoKGktobQ2Xk0ja2VBXSV8v?=
 =?us-ascii?Q?TxGBeK9I9DrqdWb7oMQdQz++Ow+YPiXeKIUKQSMUKitcyp839AxOMPqX0xNS?=
 =?us-ascii?Q?A88eDbbMEFb8XzxZCXmDqfTMoeSCv3Elzbzmp9afPUCKOhG582XApMGi3UVN?=
 =?us-ascii?Q?DcNXf/jsO5QulH6lNuu2Epx8/m0WZgCXEdmq6lgC3YCUnjFSfPNytf7kX6tm?=
 =?us-ascii?Q?N2Eq5QTyMn1+iiZKcCf12JwuHLBIyHwMP3AqW5BcZUuuIWW6HOCdYc58rPri?=
 =?us-ascii?Q?RVvxeLFJb16lHJeqpVJUwwWR7QpvLDjVr1iVh/XCqfgqjm2U5TBTEdn6gQqC?=
 =?us-ascii?Q?n+url1kTBbN6t0GmHODAdCW1Ew32spiJwUdj2JKOXA9onh77HYXuK39cOt2Q?=
 =?us-ascii?Q?JzTolHbjhsnUPsX5lY4UrnN6IavvK5xvr9hyahn0HrE2Pe9wDFp7Rsbn9Jmu?=
 =?us-ascii?Q?gWhDZXHnD9pzjfu4Wfs+hRE6j3Tn+DU6fOOVDFWwz9Xac75sbvncJNbsNTPU?=
 =?us-ascii?Q?HfBKoHgqZAOVyoXhDy9Oi0MokLQHJfYiCJzVZwC1qlHPkN6+NPGLyFcadKGf?=
 =?us-ascii?Q?4Rk/71RMqerJf5QUfesnCY20o8n2wA5QFWK7Je5SFxCzDP12064FfOCnK7kU?=
 =?us-ascii?Q?AKf/1ZrH7dok7vnPHRcaMjDGLIpBg2tYSYxS9sJW4qndv4ou2LxX2sAWcgXA?=
 =?us-ascii?Q?EmOV2Hw4Rpc6UlvdjiHL68UHjgPKbqo+M6yCDo3FUWPyKaoORFwGVhL5g2SQ?=
 =?us-ascii?Q?hIKEwMp6cUGrVBw0xU1eEZ2PQSDg47YUcl+uWNmU7+C2o+pgElDbDqzE7wwA?=
 =?us-ascii?Q?t+f8FIHwTEOvlJacbl42GYvXI7ap6Ih1N5X7X80b1v3LcTibfOAZScEX/LZF?=
 =?us-ascii?Q?Yy9cMJf2uGfonFsbvk3Ap06Wnoqqn1qIrbmmfSh/p6/nNv7lUK7k+mqMZD6G?=
 =?us-ascii?Q?zqqGXrk4E6oQwdrVxvn94HEkKB2kXsFlnbCMKNcJSWBvSNsNdwGkLGaNoGM1?=
 =?us-ascii?Q?yBW1AhEzFFxhzVGBO0u7lW9jd5/nwJGCQNLJjke+LEoS4N2qWl/yX9aBuHGx?=
 =?us-ascii?Q?Qwa0VjUQuo8oLppEbkBrc5YURbYStKCrkQ43IfsdoQs5GUbFtwFQGsuORZ/v?=
 =?us-ascii?Q?ma6s/SlaT+WoZySs30KQNf9yVuYLTxpN/9xfdoBADNbqMdrdjV6BDBtu9rWG?=
 =?us-ascii?Q?alV1P9iY7FkcQ+vlRZ7FJlSRz92/dLWc3eiFmLI31eDsML8yUckgtIu55bQg?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d6f77-615b-4df0-9f0e-08dbbf4e2fe0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 11:37:53.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBTIhFj5+ptPoT5pwDXmZFgrof2cKpPJaOaUNtuAHnUtAMJaPpD22yrq7V3RcSrnzj/gp1dEFB39JZdL8vOqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7826
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the error introduced by commit a0bfde167b50
("Bluetooth: ISO: Add support for connecting multiple BISes"):

BUG: sleeping function called from invalid context in __hci_cmd_sync_sk

When handling the Create BIG Complete event, in case no bound BISes
have been found for the BIG handle, the hci_le_terminate_big_sync
call should be made from the cmd_sync_work, not from the rx_work.

Iulia Tanasescu (1):
  Bluetooth: ISO: Fix invalid context error

 net/bluetooth/hci_event.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

