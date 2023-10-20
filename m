Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DAECDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 09:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbjJTJiC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 05:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376896AbjJTJhv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 05:37:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731C1705
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 02:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3MI0Hs/pvyVnZzxmIMcEu2TQK529JPzsOLE78mGJasLWV3NNw9U7FwU1QJs2TVHcJD1neN3M+yb0f7uCL2dsR4lW9D7Pj+fGZV0HbbR6Rlm95uiQ9i59qqWPlSkkYU4WCoWDZKYAt/Y9MLIrb7ZCWAPTxRya+gAnhaXn3CTxwOgE9BEazO8c9IV1S66ABkhazj7XNonihQzaVjPi7SSUWUEhDUd4m8VEr7Xh1UM43MIu9takGbgeON6PBivvlwov9LFO+1t7YlquLqHF3oJWBnRx78EGAUk3TOelFSfLrYN1BsHMos+MOx4jDNo228Z0WYH0iEXhuLr88HiTQKvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXTt+y8q3Uil4nH88XcesJUy0gE2UwTIRw8dtc1oXbI=;
 b=j1B3EAucMe24E6a7HD4vxFJMIzUtRRoARcVt7lVWMORnlM75FPSAkm0+lKyHtu3vJuAxS2YGAEmlBl5PH/LrakGnV3Ve/fDDLUyWVY9kye8/NqABYt6/WbMA3qSYil3Ph2hSkAbCKlzLXkKRb68LlZ6UJRfjVlsHiVloYpwSL+7SB2ZXrsewon84u+af86Eih2VnLQrXcIWuD2GjJ+/yqWksYZpXq1L1mm5D/23df6YszDOblmn/D6ne3WPL99ZtFAsAvGLR9ald0QxZWeaXllTWYpsHEpTPNS1yKUUY0RgadeWGpMfJxMFitYipqlKamujkplwnNTTOU9A6I5hZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXTt+y8q3Uil4nH88XcesJUy0gE2UwTIRw8dtc1oXbI=;
 b=CZV2EuZJEl25VgBLDKq9aBzV/zAuprFdjeB0DZf/njGJ0a/kyO67HcfXtexlpPFqFyO8Ye4gguBbhCl9UClr75EsN6+exsrA0jGPbs1QCAGyLVTmNSjiIIC7RofFYAeCldNfFrAtIUHYJod6vqir+FTViWheIJJFcNQC5SBbpTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 09:37:37 +0000
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28]) by PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28%7]) with mapi id 15.20.6933.008; Fri, 20 Oct 2023
 09:37:37 +0000
From:   Purendra Singh <purendra.singh@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, nitin.jadhav@nxp.com,
        luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, purendra.singh@nxp.com
Subject: [PATCH BlueZ v2 0/1] Increase default obex timeout: 10 sec to 500 sec
Date:   Fri, 20 Oct 2023 12:37:15 +0300
Message-Id: <20231020093716.9654-1-purendra.singh@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PA4PR04MB8016.eurprd04.prod.outlook.com
 (2603:10a6:102:cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB8016:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb1ae86-68f0-44e2-8527-08dbd150324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJq6kUJEok76nT3ttKnQSV4F1i9F1RWP/mE9yTpmesEDvfPMR7nOO33J44Q1MleqvSNZisZynL3CLIiIL91uEEB7X94PXmMai3FuWSi7bGr44E1/JMlxOC9bjYrAJZWBFr2P7Z1bOAawBDyXZC0PLYgcEfUdYuxRMjFnJwQVG+H1vibj550UNLMf5pLJH5Hztu7po6fE+7FDl/A3EEAXHmVcVfzh8cz4fJVK6IUvyueZkehKqV+AaN0vXqSq3pz57c7cYGwTtc7Rk1Y9CtdGMXJHKRFFxJQETdKIrmhxzp0WdSeBTnmRw9kZt9bGZcN7j7sUcLc5lP1bhmi4sTsPnP865T5BbledfCuOIZcpKKAyTnYFl8FhSyhX1eHAOIZhw0MLWyyJZLxjBHprx4NTX5or+n+TILbVHiaafhN2nrVx6V8CO0sSRJw2zcf2MGuiUHo9dMthzjNksd1k7bVZRR28kjoaCWvlSqg20brco2lGff7WuAuaCus7WgBwQhOqaO24eNQjyaas3Qb5eigcgudO45pHcY2uumjn1wWwIjeYi5bIOmh/xDgX/GylRcrEki2dlH6p1IawU+RseamPbQjaSYd+zNh/8dqMu2twoAMOA1vlBPsDfdhPn9BXv+Ti
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB8016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38350700005)(86362001)(38100700002)(4326008)(2906002)(44832011)(83380400001)(41300700001)(1076003)(6512007)(6506007)(4744005)(26005)(2616005)(52116002)(55236004)(5660300002)(36756003)(478600001)(6486002)(8676002)(8936002)(6666004)(66476007)(66556008)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0esliDgLMlOMpB09x3bYwDvaSNkHoMPoY6vdUJERAXZAg1PEMaMgb/VCpCB?=
 =?us-ascii?Q?b+T3Ypv1b5ZLmpEr2GdD4RRotiYEPR+y4W9BfkhysHRjM8STdap2SIy5dgLh?=
 =?us-ascii?Q?iN+siam4p35YNbf6VrM/FSaLkEhUF5NkUtK4alMOblXzXxOuY8Kql7Z/VQdD?=
 =?us-ascii?Q?dfkBxpiZ5XIw1bP4pY0eorFPp8cFwwPT9CM0ekceYNEP61yy/aHMsQf2BGEq?=
 =?us-ascii?Q?SapUVK//IOAx5J8J67XDymkA37gWPk1kXP1v/8cY0L8twsObjbX61jQBj5no?=
 =?us-ascii?Q?UY20WCV4+R3G4qHTGrebFYFI6uL5LWpwcH64+Czia6wRyep+8H7xGwVfzKjp?=
 =?us-ascii?Q?kHAo6zfn68uSQCHhddKZXf59OoOTDbAzKv3Y8FROZCT8urzuhETI8Od3z1x+?=
 =?us-ascii?Q?MzI8A51dWHNsVcCp39A1xqMrFeswgbmxwByP9v1RI5t5+5XBTVpAh4fbPEEb?=
 =?us-ascii?Q?EsSWsEgoGPwB7/ByW28kX6YN3zG1PffvHHsxuCMi/SxG0tVlriaWqYUQ6Q4s?=
 =?us-ascii?Q?+Nb0AmDLd9iga069V/xgX30U4HlZrBp7JkD4ej+jqQrDU8sjQ1gkEu+t5Z0f?=
 =?us-ascii?Q?K5QfpLBMO/dqyJ55sNdOKj4RFI5kM0h66M7l5hEZUTOxZ0PWAi1TTq9jydbN?=
 =?us-ascii?Q?tSaprWlQD1tk/nYTGYWNnkcsrq8FaSKemRgk9Ynv6GfbxfBoZLSxppAX7JNK?=
 =?us-ascii?Q?gvrzEg/kdLiFCRH+dLNokVRYu2A+GQqb63dzKB/f0tkG/zy6pAWlFcY++IHc?=
 =?us-ascii?Q?+4RRkVou18MUvXKxHLI5bNWSbyqhUnxIG90gl263w5ndGZ/vRCoF6Qm1zWjH?=
 =?us-ascii?Q?rNHvJs/Qht26wnVOKmraHnvc6Nbr27DpIX3n/JLGWTSBgZiiWQmRIRtLcyyS?=
 =?us-ascii?Q?l7HVWEglmG4VH8WDpCicsXRiNdyzEz6vFP8DdwbFyyYWwrzldtwNmv918cWf?=
 =?us-ascii?Q?BFkGEXc6MPbi5xUqk/ge9x4hJ4mm+cCrFqXpkmDbYoqEZokNo4aZzzHTbJ1Y?=
 =?us-ascii?Q?yGHPlVRDNHJg9fMqeNXzm02FQRvJ6s9Dqme8XMgBw7Mv1r8gqjbzHhdSoVk6?=
 =?us-ascii?Q?MDYJQ07ihhi7sRW5gJ75Vlh4DSjogNTTQ3ieTUID8ZSRydlC9u0ypsjeF0Kq?=
 =?us-ascii?Q?ECmkYBkRsulTzxluGOYCXLsHQNUYL0OraeELERuos0xD25SZkxwOPsIHeWIP?=
 =?us-ascii?Q?fGtIeSmHVDaAj9vZHK48sn0Nqg3rU4JHRXDC2s4Wq3thJhLSzU7p2RDR0D91?=
 =?us-ascii?Q?Wb1Nfvf5/PEq/elRvYaFlRnRHxCz+yfVXhix6sJdx3uOhpAZVzRF/2mE1API?=
 =?us-ascii?Q?41ze8i+y464tYPu3tZIcr5zbTwsKU7qXkWcJvAJ+Ea/ckRGW5uK8xC2u0AiX?=
 =?us-ascii?Q?geWU9y7MqGBtgtdpQOILsdDyXPeCGj2YqHV7Iwe70WIou7Mz0ztllA3TwbAr?=
 =?us-ascii?Q?yj3T60cSyOHzFuOmUlWsEAjuPdPqtpcnna/7StF8Gjp6KMfcO6NnG+pHvupM?=
 =?us-ascii?Q?upPnyAKANWOLMqEKayTBJ3Kgn4tHEDgblkyG6/Lu2+sGoq/rN62fduHCewMs?=
 =?us-ascii?Q?FCcINWJDmk/7LPcvy2IypjtOZuApVMlVUY6szsPl8yzNXwa1niAhgYukGd0P?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb1ae86-68f0-44e2-8527-08dbd150324d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB8016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:37:37.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjLSkwQv+y9TBNx7i3YTASEPQz0oTUCjSLzNr1bw6Q09SdGHDotilmmlMrbaVr4E6FKkvxaep2GGOnJL5NxvAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This issue is observed when multiple profiles are active from
multiple connected devices: A2DP + HID + OBex File transfer

File received status of some reference devices is delayed,
that causes timeout and file transfer status error (Variation
of timeout is between ~100 seconds to ~450 seconds).

We tested with Motorola Edge, Samsung M33, OnePlus 6T.

Experimentaly we increased the timeout and at 500 seconds no issue was
observed.

Regards,
Purendra Singh

Purendra Singh (1):
  gobex/gobex.c : Increase default obex timeout from 10 sec to 500 sec

 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

