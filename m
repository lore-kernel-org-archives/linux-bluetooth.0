Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DCEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 13:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGCNoF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGCNoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 09:44:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F82E41
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 06:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ1A//34BHZoqU0hYdinKsoI09RgE//x4UqgMMEwurafmZgdK5mfIH2xHPebPL1/u7fPlFu2x/DwwAnu+iVmNsuqMUmahCk8Hmtg7951O7xeoVvvKXUr9SvBsHNYeLRuqoq7+8BaXhJNq7A9mLYUDzghjw8qsI0h7CsgR7CYox9eZEFSawx1Xv05tX0WV40pGsLjpZWzlplHDAtTWyUv0PSD6ZqPYNMi1WNHZ9J+A48enpqnfwlexx6e4CyU+RqVZgYFjPD1oyWP3hgF+weSzVrH4/pPUf1IlGnp9vTXYbdZHL+uYRHMUjpRAMWfAuGn/35YS1ETZzOjOVIjn9+YXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfr0EAyZUO3lwBz26tEau+VG++wyJGK6/69kguvBhU8=;
 b=h7VUnV7rl8GHV4wtzUa40HR7fJQcWt3wZ+utBiDu0IAYls13ojEh8kJJbdxk/+uCF+jXMACmAAY9oN/DTsQXVpKc/qL0EUBjVap5Q75vHXjQKkLbMNPJGUDEWNS9ychFVwLVit6Pa02B13nu50i5dkxGCqpyjny6/+HPrzXunLUlI1/PAJ321uUJgwethW5ECRIuC4OAa01Qm+zwQr0ENMK6Zm/ygKe2OPHvd43VldrEwnOtdrQ/+n869Utda65grIhjxWbATLMgZ4MT5pcCKatr5C4WSSDmJSgc9E64ccC1RdytdidqMnqQXH5UAAMusZBHXmSSvV6VOoRlAhZ2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfr0EAyZUO3lwBz26tEau+VG++wyJGK6/69kguvBhU8=;
 b=hkCwoRXV6CjrxvTOC8XBHB/DIXChgKYebcOcVvDgLL8SdftoyaJ605bJC18BvI7YoueDOnh67LGsqE8Ik8Xpm/7twad7z4c8EBLqg0d7xF06DetTBCk4X82MhSj1Sx1qOA3dbTRE4tvVz4XCeteG2tNe02VAaIytgvZept0X0Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:44:01 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:44:01 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/1] monitor: Add decoding support for Sync Receiver events
Date:   Mon,  3 Jul 2023 16:43:40 +0300
Message-Id: <20230703134341.13312-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:205:1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 739c0641-e57c-4e10-a6f0-08db7bcb8eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMDooMKXlvFGzOpGK2gZyK6+z2YyNaxNSbd5frpmomb9tcpv2zS/jpoQfmGTHsetyFbzJyZTBOdtt0tRaimHroyLCo4LThJdjN/pXUJn6n0QKajmW2ebaWTUh8yVtqsfjunTsgOFsSRlQE3SLuxR/Qp0lEjXAqtIq5P5ibLToWPL/pBeil+yxu4qp3x6Rz28RjZpLBZpCpcvpK7slCuxJ94Tm9AFplwBP2PXMjMnryuHW+PoCVBtjcjxEzFn0js61jj4T+G97T3MjQ/N+NjdaJ7BcCD5c5md8k2ZIq5CkCpRxdfPt//GaQCINzjkYp0T+ZrDoh7DXb9QjHnQerSwPshdV2e3nUP7FF23/ExnhEYDMM0/XzvHi/9sFhYfbKz3tT4qCu22Mj6qfXbB07UL9tS74NRbU67nalWecUMPzKwjlDVNfQHE+Q3wYc5BFdKgUM/BpnfC4ia9Bu4cpemwBmIgh12YbXdaiCKqFxhRcg0MRP46ee1vjT2HzIFKDHVo6hahaykMSCpQizNsWFzvxMrWZTk1P+GZTUPcT2nq7ZDSqAlXj/Ki7kRy8HmxI8SQPI2MTdGHO5yNe9/MG23bxK5qJ98RTQcPR1LbAbvAUX7PiVfn9+dRE1LtXaqcLARG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(478600001)(6666004)(5660300002)(4744005)(8936002)(2906002)(36756003)(8676002)(86362001)(38100700002)(38350700002)(66946007)(66476007)(66556008)(6916009)(4326008)(316002)(41300700001)(55236004)(26005)(1076003)(2616005)(6506007)(186003)(6512007)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbD70ublGayW9t8TBxyAElKW6ABZT7gx7uB794tyrDUEcWmcCXt84Aensk1P?=
 =?us-ascii?Q?OIAbkbRoCFYlGf7jSV6YfAxjXXcxrnJEfbrayD1M4F/nztvYkN7JgNMzfR/P?=
 =?us-ascii?Q?tn8fL8OBGc3ELOVxyTIiuDtC9yJZ/QPk/gYqUZ2FWvwYj2Z+7tres5earY6s?=
 =?us-ascii?Q?GeMonKr+Y66YEacuEt3+rWIHvgQXIPKphqcVppcQC1fY1Akw5lib1Pmxt20x?=
 =?us-ascii?Q?3ukni2TabHDo1Ev5AnVf6g77H6/57TZZ+LEovVCrnPc7RLaC8DWTtih6wlpy?=
 =?us-ascii?Q?NEpcvT9La61+QMAchiiAHtjBn8Oga4GCyHONubGunepu0w6bTfedXOlp9cit?=
 =?us-ascii?Q?eTxq4addIoIQDE2DTn1uKHRelUfBltuhLNU9tD/1F2lapoha2ew6xVQS+Caf?=
 =?us-ascii?Q?CWE9XwKPIm+X3px6GI/EoUgOIF3kaKuW4a2H8mf6Z24kHyuQzHzqHtWvtdPK?=
 =?us-ascii?Q?cU2YRo7UMgwSJEqoYdoI2FP0BvtCxsmuwjUCt4uBR+Y28YbRYnyh9TpwGwJA?=
 =?us-ascii?Q?iDImt2LVkKBy0UHX443d8SIoKeiP7zdYeQt/delqZ5TjxoV3wTH4vK8yzXPN?=
 =?us-ascii?Q?/1pVDKR9TADG9KtwCA5rgr/rJw5VFVMoZFw5erRBcXRsTW8gyLbezd+JLr7j?=
 =?us-ascii?Q?ZtreEHhgw5v1iDb1NZf9pGv99l88xj1RCV8rWxaLngNf3Ry+CxuVSrWJA7+v?=
 =?us-ascii?Q?saqzwk7eU3Voqgc1SYg21yT+6qqlauM+Ryb+DI3tD3VzP8C54nx5Kzq0cmHD?=
 =?us-ascii?Q?qvHx0LUPloT+UijdkR9fwQTgMQ9enPY8QBSYNe2uge/vpWtDRnJxbtie+ZjD?=
 =?us-ascii?Q?JNt1r9DEht/ueX1KAgDJBgX4rzG+FcHOYtaYwdh4bDiym2W9UPB3hGsYjJZa?=
 =?us-ascii?Q?+9xb2YL/1KZGDoW2GuozL23POF3rqgMLSVljQ3VXjteulapCx34QExUZwWIt?=
 =?us-ascii?Q?yCND+fD1K+4xZ/4hNHQx/lfHszN+EWiwOHq9o042a/iIZjoXAG6I1Ff9lVd5?=
 =?us-ascii?Q?o6pQB9XElwXxtGe5SFJTtH2yQq8h5W3p45jJgp1VpW1OckXtzVUnAQlgLXo9?=
 =?us-ascii?Q?ll+ywtdQwKdAJPUQGvsqkxvFBNvD+DZbLvx4AnXgu3YEA29nZiTBYJ50aull?=
 =?us-ascii?Q?5/dIkok/mpQhQSEvB9cNvLpN7HB1iC8nyPNHxGQ7oQKuKKdsjK+twKN3OSCr?=
 =?us-ascii?Q?/HBpl2v5JSwnrDENqbw64wvw0bPre2VGPDt+bv96+4Urv1e/yoTY7jzcVRmC?=
 =?us-ascii?Q?5d/qo6Fmkt7ItA01+EgJSHtdaiqBbSg4Dr2LV+Qn2G+Dy4HaZL+XhaO2BeFh?=
 =?us-ascii?Q?HCMNChixTbNcYdJ5qV1ZFvNkMnQlNwJdbunxvSZFOwPuXx365R6QL+4hY5jA?=
 =?us-ascii?Q?ZH2PEObh6Ew+Ee5E+uqgBvJO36kei+Fqc12zK8ctyryeEraRj6dIxwACxBjg?=
 =?us-ascii?Q?saT97UWo8aBKvmXivUnOYVcD6y1NM9bhO9/CKIWgDXixu87eiUWnF1XrYkgt?=
 =?us-ascii?Q?MiSZJIXvH64YfDPtT5XisnEqVqk1RvmhrX6rFxl7122Ucs8oYBOhAXROUvHL?=
 =?us-ascii?Q?WUhdsGSzmayr+XMhsJqaEiUHT2orEtvLcGrHGghM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739c0641-e57c-4e10-a6f0-08db7bcb8eed
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:44:01.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJA2fOFqxyAet6QxRV8TAqM0vhro0lJS7CSn8g8qg+90qxr0pb/MMiAKrUFr5CHvGB1yZYhQYWXAeHwpJ+IA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds decoding support for PA Sync Established, 
BIG Sync Established and BIG Sync Lost events.

Claudia Draghicescu (1):
  Add decoding support for PA Sync Established, 
  BIG Sync Established and BIG Sync Lost events.

 lib/mgmt.h       | 3 +++
 monitor/packet.c | 5 +++++
 2 files changed, 8 insertions(+)

-- 
2.34.1

