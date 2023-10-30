Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CFAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJ3PtX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjJ3PtW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:49:22 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58402C5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSiRmcN6dgVsKWg7j2B/gQV+wkT9NnQz/x4EoB/FvSdSJfR/imSOqBfADJLwYgRCPjhfhlQm53yail5FjD5RmakFH8+c6Xc8NmI9e1CckT6xEiU66pEZV0QzQc9ftCWp298SJoZQNb4E9145tncx2RzqsgTH+jIWnwRJS24PuriPyxHSjMCz4SiycYyD0pRjW7hNLA9rFcJyDEMk+l3O3SbGZNPrc+gMytq02zYJKHERLYvWfRyg7euqB5rXOql1pgH13VT7fKUoK85wYo8y1wIj0bPAsPnds2ZVtl8guNrrQqnvPo/f+3Acfgn4aal1mc29mKTQU0zXsuh23TnToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=hmBhmO3t/trUlTe1S4Gl+E+2F8OgZykrswSOF0aZdp7me7Vu6Euj47V8jq+lga+NXNn0gL+EARZ5ujGR00TEI3RT6kd8pZSI3aC3qtxFjQW+EdViHMZvm92BYOMohZyH6XfEWATTqbUkSljgq9S0p6KClgBSJWEc8cnZSh0Jujlqs1uWC5HZ/kFQOXEa78/crDxyWPWtV+fLaMvocbvQiC1mfAsLkBczFZ1N/v8OAfFDfAcLIp7ef3afzjiIgYbtpnzMPIZ+zxBxVjL76TCIKEgZcCzE5axc3pIguz+LjdTJA5ab+tpU5cWi5fUzkiw13A2tmcOZyYRqExGPOvW3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=PMw2QZL2vP7+p6jVEkf8d7SG8aojnQ2/zKK7E7eUFHaweyabGC+43aRiHEI7/ogguNFpRO4Ddqs8jwpT5XR/m1XehFufOwZszrE4294tqNC4jO/3ru2R6woXFfP4PSPyv9r9sgOUYOIkCdChlS6NSGNDWbUAWmUFSm2XxZJRAVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Mon, 30 Oct
 2023 15:49:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:49:16 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 reconnect
Date:   Mon, 30 Oct 2023 17:49:12 +0200
Message-Id: <20231030154913.4442-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdd5de1-0748-4300-8a87-08dbd95fc59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoeQYTqJbYkEjUm6RxeT3BbS5PPb8vldXKRlnqKwBjLMROchcBvatRRjaRvJYQW1oYG1WR8tldMyNrMyTeBzE7Z6EnYRnD7a176wGaH6Wun/CAsJ+ccql1WZjF0EGv5fOUxFIlCXKusYPjpkMshAthklmvM1Vdw3BHa9XsjYRnJBcgCGf5n+lBLh4veq6tpXvqRIVcSxP7eOEHR6J/5edRUsA1ANGbkzkLLMl83QTD48b7t/O+QZNjF0zgYoViyfJ3+Bf1XVqdU7nCQBVlS2cxsI7H1v4nMo4Oob5Ysz5EcI1dIiCb1p/BBwu667LGCKqIz1SpMBe5Rw+A/Delc76LJVjNj1ugbpjBLRFY6ME3jMPhYVOqQbYTeq/al9+mM3yHi0Tnes3VQ+80kYhykCFODJGpgTN0Z5YJw2iL+uYw/DFTDRmF7kbkf4l/rVy/o0NqUvn5ge+TX6yD28M8hvZZeyBiMLqerfur1rIMPnO+fFVy+i94qelZty1UBF1707DdNpelS1dy5jsdt90iedqkaSPF8bhaUip/G3AG7BHoRdxSDwAXSqvgkUtKGVfrIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(83380400001)(2906002)(478600001)(66556008)(6512007)(41300700001)(6486002)(8936002)(5660300002)(316002)(6916009)(6506007)(86362001)(66946007)(66476007)(8676002)(36756003)(4744005)(4326008)(38100700002)(44832011)(2616005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDZgFj7eJdUrHQMP3OlNdP146wbgmYLiyMjn1dognncaJpngAL6oxMVLV4zb?=
 =?us-ascii?Q?nFj1sgl+Ny2wHb4BD5J95xg8yuJZpQHMGjVBwcwdiSHsIzcgSSidnvWvfmwF?=
 =?us-ascii?Q?GwBo54W2SBAZMVGqXUjg+oDsY3QlWD97Io+uoJaoD+AydJn8GU1nG+U8fp5Y?=
 =?us-ascii?Q?8r0dbmtBsVC6LM8an4ivLfFrQ2IjteUsKi82Cb1S5ngUxMhkl5WgB5TIGxN7?=
 =?us-ascii?Q?3MWRR5C2j9B/pNb9DTbRRY0ydkQXl16vyYyUkeXlNKadwsvZESI6poL2pCQI?=
 =?us-ascii?Q?92WQ/RuQgAx3cxkNJW4VFzd+tTYcF1NqXdHFZu/5LeH30nCPawRYZY0S8zm0?=
 =?us-ascii?Q?gbB349WBToYbzZn0Mh+ATr83Zved+kPV2FPe6j5ashWr0MlueGAYzEcBAt8h?=
 =?us-ascii?Q?iEYYq65QYAvwS5Bz6GQQLqDnmJ9B0cfdyyOgi5Gw5Ix4XOK97Xnb8T+SgP7x?=
 =?us-ascii?Q?QccirfD0NeRXKXO2ICnfLKFYNTX6gI7DMRYxhDQO32arxH1shMB0ymaKLGpg?=
 =?us-ascii?Q?+2KQmraJjFXRMXNLeEHevEWa/ivMwI6GVZG6l6pxQiFIH7BdEYNV5hWwB9ii?=
 =?us-ascii?Q?6bFulnkAApD5K9tDC1DeWtrOvwFzAqHC8Lv0wcRZGd0QbeWLHqBebei+O69J?=
 =?us-ascii?Q?GORrcLkSEQXVzUairbOjxbOdKQ1wm3Au7BZ2iH+gM7b2A3dL+ELrH4cHsSC5?=
 =?us-ascii?Q?Mkgr29k7DXyF9rhT7sv+re6ZyE6DUhj8sbqkcjWg3pA2tIvJbdiFIAofmR1t?=
 =?us-ascii?Q?vaE/EDA69u0pIojI6YcYq4I+P/YzxSG3pQ0nSD4ws4oTQCVZLcdkmPnOOGf2?=
 =?us-ascii?Q?3AUEEu4K78cGfUoHKt/4bb7JN5gvxIk9DT1z3BC73t0bcYG5PoOlfipvl8QX?=
 =?us-ascii?Q?Uk9MNPF6slkuYZxXAKIGDzTEd3L8IZMv6I2oJau5fHCFEORfu9DaUvM4kAGm?=
 =?us-ascii?Q?gztIPg4esBMIjohuMQYTO3esy0rtqIIzSkn71+iGsXErnzKux1DlHqOqr046?=
 =?us-ascii?Q?91uYWrvLzh+fZppEmNwGCJ6BQ/Dj0M4slLtBU+oMqaQickRLQcOSuao/H2Jy?=
 =?us-ascii?Q?5CIn10J0RgOYHNwRO7YSnrCkhvTG7kB42FFZawjtWKH4cepaNj2aehc55ljR?=
 =?us-ascii?Q?xaFrqOcRyZk/8QFgn4MFGoIHX+pMMCRalY/ljsfnwlNOgQTtwiZiaw7wbcR/?=
 =?us-ascii?Q?ivLReORt6tTODQqnNe6Zjkwh4xivJ+EYBWSx+fbaV+3xSiCZIkkSZgt0FnwN?=
 =?us-ascii?Q?JobIuMeQCtPz3WBlDNe7VBywVvwTpmxlRHwYpae27Q9Yu0Iv4UnCphcxG7b7?=
 =?us-ascii?Q?NW6smMypqrJLdKAPNYisikkBbpfF4V6JCEix3tBHuBKom/PqTECLtwp9IJNE?=
 =?us-ascii?Q?UTiNcR6D19uyk9gDScQZQUZfYDUKXK7QPsh3EHgk382Ahod8/bVXjm5QW/tB?=
 =?us-ascii?Q?zP6t7+hoJzLf1vUkXlQd0QdqlAYWV80LZh7VfvTcqliVi6mF2ptuhH3GJYrJ?=
 =?us-ascii?Q?5xKsZyCcWLn/RhL0VR9hcTqFuJcmtpPbfmU73rpELc6QSlEH0HTnXXLlS/sK?=
 =?us-ascii?Q?ya8qMTZY5IdUnHisBN5AOjkOROWXZVYqIU7DTP90hHW7V3jVYZEm+MqasYP3?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdd5de1-0748-4300-8a87-08dbd95fc59f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:49:16.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTMvHijNP2glSdxqjo0eENyAtRHzDLCIk4s57HC0rtjij4bjFIamFgqjODNcdKpn6ILkkmDUBgmqO2JEBpYw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for the Broadcast AC 13 reconnect scenario: 2 BIS
sockets are connected, one of them is closed and then reopened, and
it is reassociated with the free BIS hcon inside the kernel space.

This depends on the kernel support added by patch
Bluetooth: ISO: Reassociate a socket with an active BIS.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast AC 13 reconnect

 tools/iso-tester.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

