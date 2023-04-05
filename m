Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121AAC7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbjDELUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjDELUL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 07:20:11 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B65FD4
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 04:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XetuDx+jUxU05p2tYGenCV36A2CGhzu4OsEsfXcraU613t3rAbhh1tUJZJMJ/4qlC79BUtqUk1qJETuS209tFCOS0zu4qS7xQRTRJvJn7O+3X1G+hx/9+WwQAVtYQ3rwlxoF7sTwXXla+nQapwR8Xa4xHYPblao5zw58nFhOKHjv5UIEHCAqQKsqKHSqFf/FX2bQkp2Gajf39jXfJKIjREAlNM2ra9MpVBT7+VjK9JgnI0lnhOmvfs3H4VS00mIFGToPY4uipwx/aDHSgt1snW5qxYZxASXQUiyBEdakH4+sat5oHCTZw8AMvS/r4jQtMB6sectjjAnNIL80fLbG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CWC8lnvk6+2NJrqTnq2dvlj1qPRHsk682eKEnicmk4=;
 b=V4WfsCNVK0sM2Ij3HvfG2pyQ3XnlV69nkgUBfCwWYQvUx+u2WBFumo+kImW+Ag9pZOk7pQEUMsAk2lp4yipcnhAYCJFj07H4vu4MnomXpWOHcFibM1Dj7n6Ko8SefEv34X0sdnD6AsuzfK6sfqaUnWOTvyyWUnJFNFJYZJ4eX6llH4Gtv7zOIhKx0hSCGSZDUlxfKdh2JtN1jxWn8zq96ZjIPUTPPMzpuzx6GT8L1tjYgWfIpB3dMlE2K7b7R+K4iAVTpNXPsXSW+Te+ndYlmsx73t+s3Ja9eYRzrmoqTXbB+L5yOPjcyp8dAHFgTGleNRHyML6eXk1vYPYex4O61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CWC8lnvk6+2NJrqTnq2dvlj1qPRHsk682eKEnicmk4=;
 b=k20XymARrA5qZ/NwhFk7CWD5mXxXLultMj/u2JNdCsYTqGbifodAmXbFBzSOUbPmCl+ebjf7Jg0+4DFRVkdGn0VCqwZqV/dOsvYEA6xFh7i9zpWbO1zs9dcjeBahEl8J1gU/h5MEz65jkNNc3FTgPmeIW0k07IxPNl3zfE6fY/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS1PR04MB9631.eurprd04.prod.outlook.com (2603:10a6:20b:476::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 11:19:42 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913%9]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 11:19:42 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 0/1] Set ISO Data Path on broadcast sink
Date:   Wed,  5 Apr 2023 14:19:17 +0300
Message-Id: <20230405111918.4885-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS1PR04MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 1389ff00-63d0-4072-c639-08db35c7a701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r22QmxgvkSg4yhLn5SjO5HZQZoDjOOvA2T383edBx4SghB7aAg9IlfYRFiIPqo6K1M8k+nPwZHiw0YXL1YYmsYbahCCoykpWtPCfK7f3X13f+mtwrFqOw19AVDjcQoNVP2SU2ib3txXZTG2Zo/CcxpysqH0GfyFXnvfN8Y4RsNPq8RQlV/SQ1D7LU0ZSE1/gwLckfFyyQJz+nuhc6/Ig1GKcLVRy200sTU8+jgFIg2Fz/ukDYS4mHCBqDZhKll+5E8Sb/qm1dtfHM0rFLi9Poko4IpV63w6wg+szm7h+iVN7HHQ5CUZMNq1DlqwpbtRSmUU8jdH4wviTeFLNp5yWMd0uMSepBRuvQYVzy0as3tNQqZ4ReQ6/+kPs3nf43a+63QHlZpQj44vfh8LGgjPKsDCHrK5PAH0AwWXHmUidtXUjjtCwwysICYRGttMKUHtZS8VlzccoO73/Dzpqi/vnypRzG/adQWmiPXUA+05A6tBH9Psp0M2pG4AsiShqLmThIlNlXWW9B9uRoNghFiEOqhxxNiwAR0R62raA8PcpIyLhEDMZcQdGpzCMdvZkXwJ6NnNGL/8ln1iCjLv0T8obiOf2WZ+ynUTDE67QABCvc0WGAOnwRZDslg4MyzayDign
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(38350700002)(38100700002)(5660300002)(66556008)(66476007)(8936002)(66946007)(4326008)(41300700001)(1076003)(8676002)(6916009)(316002)(36756003)(2616005)(83380400001)(26005)(55236004)(86362001)(6512007)(6666004)(6506007)(186003)(478600001)(558084003)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRA6HGsy0FlnBL/mEobsUlP63diPNDixyMBPycfSndo6MkvVNro6ENpFgmWD?=
 =?us-ascii?Q?2a3h0e7LvZg96oryVmcBp66cBGbJQSlxs0qaaKKywz99xHojmkvl1yk9JMVN?=
 =?us-ascii?Q?4X77jRAGzQfvvwfGjXltxmx87xftL3Q0kiESE5GkI25t+QGP8ZR1bD05FkyX?=
 =?us-ascii?Q?Y+Uv6sDgwIY/REAu6tmaO2aoM/f5ulJEbAnXJdvxZy0lPjEVizNsORRwC90q?=
 =?us-ascii?Q?H6JMbMQoMsrGFYB/fofKXIXmLRvvTPjpExuZW+suc12NJkwGuZQHDEiGIqN7?=
 =?us-ascii?Q?fwK5UFydS7AAkVWkrACyuNH5D2Ho9ZaAvbxkCzWJCJVDtWm1KuZ9rjgU6fOM?=
 =?us-ascii?Q?hcnr+w9wTJqXNwg/hJQOsDcb8n0/74KP9+ePxQ2NFIuVtB5BtcTsaRtsz1gD?=
 =?us-ascii?Q?fCCHtJ+29VlvyZrVWq3fP0UxQAyB5h5fePl3fplLwqCEXBWrGxr1rKiLPt9p?=
 =?us-ascii?Q?gPfLYXIVCZEhfqZwoMuuLkjNrv1o4E9Sj+tU/oCYI6bZuo6+aQ3blbDOjKw6?=
 =?us-ascii?Q?n/ttvw8CPQ/nWhK1sQNAMuMCA0gv0juABx5SGyYcS4p8veYaamuubba03wup?=
 =?us-ascii?Q?zD52JQQ12BXHTnP5R64PEsXbxqwPUPf7CwjhGuQlk/uvm89/uvIVsFcgl1dM?=
 =?us-ascii?Q?JC6kcP2+wiSKA5ZFkfv77fhk77QlR5gsu3unG6TRQEkPGQ6cWm3l6v9Jw3YS?=
 =?us-ascii?Q?ezvDKs+1vMCGb1xN/CKhaG1DPZsNh9DFekgVqaQVz9qFOfB7q7UDR5s7SSVj?=
 =?us-ascii?Q?Zv1i19zWc6yC9HEJele7ptO3EcgOC6GRq9YLmhK3wswBDg1pNHgGWXYWwhkB?=
 =?us-ascii?Q?zOb50fmgBpeLPz/GEYAmQSAVkEFcLeXOL2XCRDVCzs9uv3Rd7byvkFeSkBMp?=
 =?us-ascii?Q?IMfVPHimRa8HjbKGIakkvj+4t7KpaCBTuGRvLnMIqeQCnpJ8lAtumKRTa4mD?=
 =?us-ascii?Q?/fwyjqxdXxrD0frZngPnS4pAX8nwbgGWR8SmqR0krH0nlzhE5ZNxozf2m6rc?=
 =?us-ascii?Q?zQ2fhpL+ARe/FAI/ZcXVYE9lMQrFbM4CJHJ9UVpNjtmOpXugj93LfYBVRTKE?=
 =?us-ascii?Q?D2hJbEm0ql/Nn6+oZAhatL8qEyCC7v9DPYe8g87Qx+zo0t4Y/EpAOr9tgMRz?=
 =?us-ascii?Q?7GtUyOWnqRkdgd//6w+WgH2irMvNYM1cBqDxziWOClaqWFAQMob92GSMQ+nd?=
 =?us-ascii?Q?TdXNfENXn5gDbJfGsi5ymwYMMfX+YgULsYtrMoX4cl0yw5DLi3ca1kImtM6/?=
 =?us-ascii?Q?H0V+0TD6znkRi5Ifq1Ccu40vbgwXWZB+PAocmV1MVT0EiDFOctCFYN7bJgvV?=
 =?us-ascii?Q?6hbMZ5p6YTlz+IQjhX3yWtvz+s+sSFjXfg6pGP6G111CqK1wr1y52kOMVaWB?=
 =?us-ascii?Q?tQXCoGDIclzwxnM+7wvASaKCB0ZJ57rnI819eYFngoTbVxMWEbZP6SLxmPYr?=
 =?us-ascii?Q?p6wcI7AxfmjhBhdw/Nd8cUvRIZdj1JbgGlJItEq6BLQv9gXU3yeG9j61flza?=
 =?us-ascii?Q?z6wA76HIrLLvKQrj1/yJaSxh316KxOZ/808rVqj8iqpIm7B+HHpQ/9KIjIkf?=
 =?us-ascii?Q?nVNIqkrlzJBzXXT1yRQVg9xowqvkI9GKQecv+sRr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1389ff00-63d0-4072-c639-08db35c7a701
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:19:42.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzTiOF5EIIQllTELn6wMRcfxxpK1+xy3RNMhKxAzbRYlo1ffwK+x/Cb+BjVOnHJ0XEduFJlWBRYdE0pfcAbNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9631
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables ISO data rx on broadcast sink.
Claudia Draghicescu (1):
  Set ISO Data Path on broadcast sink

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

