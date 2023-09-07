Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892CEC873D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjIGPmT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjIGPXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D2CA
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7S6OMPo6jqPbKvRCbYfzO5tvj08xtfwEU2oMUamA9e3JfDgJDoJ0iWJ2+IdQOXzJDF9JtLYST57ZwOV0/7eF+EVR+xOOoilIEXgMmId1PEXcNtbZ3t3ExRw4Kr3epQe4mWQ5JwDK8C5ADS0poSeoMd+ZZWYgsbpVogNUaI7a6E19g++NmUwhqa2UrpWI2KQWr0NVJstNGhEGhy84HaHm4C9iL33IV1xf6lirNnAVc825e+TEROwV+u3Mb6RLSVTvnyCkmFNgj445Ex4AakU0JbgNLdWQgn6VYe5BhctitGQx7ZtIc2+zYnECi8fpZGphabsPKw55p4VxIu1sZVoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bygBYp04AEMoMwx3cGrAkgGhk741sForvgCb2CfcWJY=;
 b=iWwIqdQn0Q+4jiSlwJktTJQdkg+HUC6UV6y4CT5+qJ59ekJQ0K6cj8T+mpgpCp5fxf/vMQznU5RjJFuS1fYxIqg7fWnGLFwccgpnxmhwkP4mhW7lnTESO/607T+tTYtapGSbNGdEwtAdw74TYN6m571mF21LANhOulXnJvU157hLS1U5ffNISq1/uwB/4eaHbrmEvUUOgOl6MfuSXaTP7ofEnNdPxGKO07MVoabrjHecPGZQ9OnSyqtXwrbJsOZpY5aznVRR/ZWrD5sGGBdn18MAki463tQPoo5lHQ5ESij9W3VD4OuZiPdRoCdRxaUNYBXC1ntdALVsgn1wZQgYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bygBYp04AEMoMwx3cGrAkgGhk741sForvgCb2CfcWJY=;
 b=FzoJmcaw5hHBlfdb7J2sGCK5Wyhvh0PwoiFSHIBQ78DDKkyT+jiU4cxUzgyT7SNzo6ZSgS/5AAd/ennC+oHhxRnOkC08V02+SO/tVLIvKGC0pzMIqM70wdViGwKJIDU5H138PMQMX8LnCfAkBz05lRkOzwVZy8VeesURJM4aE88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by PAXPR04MB9140.eurprd04.prod.outlook.com (2603:10a6:102:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 09:31:03 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 09:31:03 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Thu,  7 Sep 2023 12:30:05 +0300
Message-Id: <20230907093005.58439-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907093005.58439-1-vlad.pruteanu@nxp.com>
References: <20230907093005.58439-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::19) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|PAXPR04MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c51549-2ce9-4e30-5f87-08dbaf8527b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLQw4RkEV2vJ0pxRJSntluhSqJU7zNAULm1++72OXryITf/8eEOnclaFA2czQJT8PPtsIV0Fb0izDw5fwsQKKXNpxadocXCJaN6XxvcGtM+eAmMy/v3NrLCqv8d94tm6YDSAR9pVHNlvckfKHVaIfQYceuB+0XtGn++sB52Q3FtNQ+Qaf/x5MoqTv5Uq7/fb/9jNccAZRFW4o95r8GVJpoBJo2mbdhux34UGrZFwkAXxTQhg7WPVRsHfPFu5wXBArQronUGoHP2A7/Fb5CEzzS0f3BXZh8Cmhn591B612qJWCK9RCReZJcqZXvr5bHDly2O01gDi4unaQMkTS1w7XX/jLomKAxvv5Yb6mQFyGEOE1IzqJ/+mo1LuaBrP1wKm8ZPalzLOrdjeVXQD0IpGk7uXjceDseKyhrGbwQb8owychfbb923aqXjajfaTFaWJF/cnaZ1T8zbM6KltPAt2/aji/NwOZHwKWhMPEDlSPgNHT7DykPsUQvlCOoSH3vxwVIBU0cBKNkPrJBIAhTO1sHTHMojlNEOSyBZBJbK8wmslJrVeOOv3nuIqsgLYD97CxWFE58R+ZxMG29kGEHwS4jnnocCI3wIxl9b08jpnINvafkkPdZASkSPOxoD1kyj0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(4744005)(41300700001)(44832011)(5660300002)(86362001)(478600001)(4326008)(2906002)(8936002)(8676002)(66556008)(6916009)(316002)(66476007)(66946007)(1076003)(26005)(6486002)(6506007)(52116002)(2616005)(38350700002)(38100700002)(36756003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovDCpaGF6Uikca8lcx1dmYv3bBWE9RR3/0E3qrT3Zc890ssVputs57kMEdw7?=
 =?us-ascii?Q?mdgdU+RmOhNTU3ca0jY3IpBAgsAtOjIII2mZfkrz8AQ1hta+iNRMvA1+NldS?=
 =?us-ascii?Q?8LzRcomiaeXQeumGZwxvOML04imia2AAbag2I1xZQaZ6BQTfK3DqA6tfy32i?=
 =?us-ascii?Q?1w8DLefmCrYLsWBbBBR2rCoYlsK4WRnQM50tM9vgyA6H2TpVn3jyQtG1YaAA?=
 =?us-ascii?Q?ibYykGspJQLKWPH1yle+0jQTQtlQt4Le/7KpES47wfUyH0xseJiYq7vEyFXG?=
 =?us-ascii?Q?SNXtDRd2Ut7bnV3UfgWB+viUWnlxjgecnGvQwvvsHAJ1ciuzQLjZaUnXjbIo?=
 =?us-ascii?Q?rUrYf6tLy0Y7Ek1goiM8vGumcBSuliUsGu3BmxWt8JAywhz6cxDivSrA1kaT?=
 =?us-ascii?Q?x/zRpQlL+bsFtgUpKB7e3rNeAC8H+1JIkilrFsT6p5kk4SIItkiCS0TDSbrs?=
 =?us-ascii?Q?yhqfQSkwLr8hqnnllEzcpi+jfPPQxl9z876Pj8Rwd7MjCUWAz2nd9FyFt8k7?=
 =?us-ascii?Q?Hvqybta1qQXCllGNlPqT2Holre4OitcLIB7JwSYJF5jtF4R/dp32YUDjW9M3?=
 =?us-ascii?Q?T+WpFV2NP2BYgKVL+Q5vwOR8xvzMVt01VCFT4gZl8iF7YNOPp6fvwAfVEM/W?=
 =?us-ascii?Q?10r6l22UEUQ7DluZ3UWu2tgUTXlJqGHIYSIR7U2c282llzDuxN6yAZ0nJ1oH?=
 =?us-ascii?Q?e7y4PGS92uGszbuF8y5Qs5hnevIj+vgA/+LUa2sVffwgzzyL6Ul3zyG1juUe?=
 =?us-ascii?Q?DlofxVqT4JzYkpd4ZjfRZNxVbCu5oB+nPOJGSGi98WMyCfa5tN/5yISruCl3?=
 =?us-ascii?Q?8VCbvsKKhxc5xSjGVveAIk5/HJGA6lGxoaH7su/smEvaGqzFbloHj2TxCR6A?=
 =?us-ascii?Q?QfHZzsUV3/oWaYycn2QiEomcRzR9yKC12yZ1Q1c1p353FIBSj9pyVuT4pWp9?=
 =?us-ascii?Q?HZLPD/JETlTNGExfI269k9CJfnhnCtfLB7dal21em7Cb/iDhOX+DiS2lvOuN?=
 =?us-ascii?Q?TsYObcz7Y0b528NYPuRNLrxYJu7ZXuBwbhi/IDn/a0VOJxwvn6063MF47XW4?=
 =?us-ascii?Q?N+Bnai+0lHdHXtZqm30HKTUPffAjJg/mOEf6G1jCBmrFue0P8rY2H7WFo/C7?=
 =?us-ascii?Q?13FCsaucZywH+9QEXmdw7mWTuI8JczPhQ2aNB/+IU8nqb8ZFmv0iVpKJth3U?=
 =?us-ascii?Q?2Z6tx2V7YISipFe2ZSuOoGMobDGBO/SJ980crgPhGO5axhx7AGefuS5O3+1Q?=
 =?us-ascii?Q?SKVAAWQetB1QNBC+OE8x8LqCBLOCnVQP1CGwRHSEfGPjIEkHDI0q+I9La7WY?=
 =?us-ascii?Q?ABgn5T3mhhUwo5ltO13Npr1FgWpl7vWIedMCtDyBqUYQJe6//7csO04Z3Qjr?=
 =?us-ascii?Q?6gO+/n09bDjUyD+5SK2vwmjh7b3i/asvmPpIa//wBWnVRJofhB4cG2OR2sUb?=
 =?us-ascii?Q?CwmevM6MjtSOj3ImCHMA7Xz9V/nyQkQLa3KcRjMpzuU4DdJzTP/xOFZ7Zj6R?=
 =?us-ascii?Q?+oQ50JPaDvRXAMfopNQ9uHQhHsIbP9QtdjKT2vYsn7WD1i+ABXqqR3tROY9X?=
 =?us-ascii?Q?8HIp7VJRzQVGTI5A08eyzwETC6+knq/pBWCvQ6xK7C/XpoHSCWWLEet7nrBI?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c51549-2ce9-4e30-5f87-08dbaf8527b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 09:31:03.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+gI8c6juGbEh6YKYEZXR/PIbGSKx6a4aHcCJmoeE+q5OiijxSbE/VzEiXrX7K/2E4Rf9A5CZNzHnTkCTfSmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9140
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ec4dfc4c5749..f09c5812c247 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4264,7 +4264,7 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.34.1

