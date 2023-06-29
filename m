Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB7EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjF2Iwf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:52:35 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:50784
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231838AbjF2IwA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iphnbJHFt7dHGUGkat2qaC1YPXxYPnbsu5S9viaLlkeYlaVWDZL1ym2bxuQyb1B3aUzSH4isv57xKubhKiPLGZrb1hTU3uvwrqQT0cpCCEtbSYfmocfhfCE52nsSUa60V/je09HqXSOXw14rnz8wPkcGpJH2+u/y0RT8HEUARGfbIuIXdb8a3LOxzKW37ZIvQDQeB6UuAaR7fQP0FTDXzlbY3ZKFQT5blSAmS+6vvtUVzLplhdGDxVulzdZ9z65yisXSHtnKDCVwome00JXP+1lg02JEyfHhe/CgLnOCGGi8n0+LwxTln6y2tU879XMi1EXRq6eAbrcLiFNsW7CO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1NQOGc7o2c1vezgQnxmIFOR/bU08vK8Gs4+KAdNfGk=;
 b=kPMaaGkEBZuW+PUQN8DITyiS9+VJIrhUmQqTKywT1rEJWWlEwi79CqujQN/s/QYgnQ+ppM457JtboudD877Kgncqatu24lZL87OYxvmFqr90deGDHSQxg5kSUVFPkBoMAX0xztXAqjFkA19fAxaG5nKkGEqvdTOEXjzzELovLTisk/u1CRXTpAf+9F5829Cl89K0zGCje5VtnnuLmlrzodmr3j+3yhpWX2HWnZTDzv0X8m/ZYfFGmv9tfiAXLxKj24Ixytr66Ajp5PRNL3hun0Vx5IFCsM1ONIfzJik9nEZmY7Irz+IP7iY8vTO51X7weDcUOZEm0KXRaE71MT3+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1NQOGc7o2c1vezgQnxmIFOR/bU08vK8Gs4+KAdNfGk=;
 b=N2maqQlJaFfWid9OifG6CoN3HUPQU9vN3WrJjPWJjPGkSrsipFxuobRqSAh/6Am2G1SsJJzimHtgtaluY0Y5sshz+FxbClArWwIHXlJHlnMGru1KUsNJyT0ncSHvjkAVavnrlLRY9bRTXgF41yf0qSBfTmk8GIgkqVf6dLbJ5pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 08:51:58 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:51:58 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
Date:   Thu, 29 Jun 2023 11:37:26 +0300
Message-Id: <20230629083726.8505-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629083726.8505-1-claudia.rosu@nxp.com>
References: <20230629083726.8505-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DBBPR04MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: aafed74f-4581-4909-e972-08db787e18a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEdUWAd5i/umxSnR8MbMsmxfXqctOf7Pa3IAwwURmzok5xb9E3bz0ZDfRqKwyLy2c4a2XZ/Bad98ec2+QCY+TBSJOdCLpr3j3ROIKSjrYSFTwNS9rg9+8IYDASGtpAI3ntM+91dqiydDp6rejZApWAq+k/k19qM9VVCbCNC7t14SkUkVj00jOGu8LfT9cz6QAqAUeWjecmbUTk1w1/D+T1O1wvDCwq1br13/Xw4sPMRFgPvU24WIMVb5LyxCT7JU1lBsuFFQNTDOQ9FovQNWyHyz4Mwikdep3sMoB3/9RktuLllYPgiz4LA8a9L5O3hJK6+j6JT12ATcyqDQKoD8dPYkKv8Imx181w3ergL2MvCRLhQX10IXYVq7QiK1UJH7GWrABWDqMhELBtVvK8svZN4TiUeps3/0tkytyIh7DRoa/goeuWg4roOij3cpFNRRMuFzFhX0PT2ehXAt+KvvXwD7Q8YIajRjnKZBZAozm73wlZQ2uRFYr2R/nPtzRPoczekIv+JPCHRZEDBTqzRl4tlk+Xu+Z2/ARRDk1PT4iqUAYs3Rk7eAMrvmsTGafVqfJjm6gUNxbZ3fJYItwmVZJf7wg1x+ZtgwD4MhwTZFV23KO64oUfqSo/X7tTJTvrGY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(6512007)(2906002)(55236004)(186003)(38350700002)(6486002)(52116002)(2616005)(38100700002)(6506007)(26005)(86362001)(1076003)(4744005)(41300700001)(6666004)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5RQs89AjgBBCKXgvRU+aP713l3Tq2samMg2kDg+arvHFjRIMu0tIufuISRj?=
 =?us-ascii?Q?CJMpVGUyJz7oRQvBGeiWwt1J7jcyJ4UJmzBpGvWiwJb/F3KmH9gc7X2PfH+T?=
 =?us-ascii?Q?exMYNeZgaVa7s2pFazhJLslH3mcOEu15SrSdnL9v2ds5bVkIKNARoL+Qq3ox?=
 =?us-ascii?Q?SeOiQVsUIIhCbmsfqfVHq/3p2Vi1c1Q+ylPdRtbDDNDWt7szM5zZnWwZVRLL?=
 =?us-ascii?Q?UoSkWjsfbxHzjztzjDNxJQbEie972fZRnVkG4YuSf+eT48QEBglsiDRRwww0?=
 =?us-ascii?Q?VN4+YeV/dLuEOYefg0ej7mHU+r7DBuivnDhCU1b2vcHIsd0kE2wYoRXh4dXM?=
 =?us-ascii?Q?bPzrAqI3nSDWffpfeRGe6tH4EgoavkP/ZYFyhuzeID26P6kbmKQUkuObUnUH?=
 =?us-ascii?Q?Z+3sLm2QnCFvAiVuKEuyKZea5L601jj+zNB/+avLL7QTkrB2edaTOgEobTk7?=
 =?us-ascii?Q?zJ1aRZ8bzXoZ1Hru7nnx6AuHPhJytZK8cG7KEq1R6q7PyO+P90LKffQnpWVM?=
 =?us-ascii?Q?Smh3FX5oYlRyo4wctGj8CbqSIZGOwlx0F3sYSfYK9l7O3HM34eXbriYdM0oS?=
 =?us-ascii?Q?N84ifNnwgoRhMqqh09aUxQMHH1RJOW3xQ7tPEMnCYf0FDlpeNxQAeHnY1yvo?=
 =?us-ascii?Q?V5J8jEo1yuwSklgeLno4+AotFzbucXQZ/T2KsEhsPAfFYntWlnyGGp0yRpAM?=
 =?us-ascii?Q?MrJDgRdGFYdMgFDN7txAuh7NlYNOWKmHj7XgHzfHR+XHqeP67XWniVvkrTjx?=
 =?us-ascii?Q?pcn+bkVcWRIdY/BHexkmBg47Dp0mArjewwSW6irJ74wwhGpZJyVcaQuMux50?=
 =?us-ascii?Q?463ORhAkfQYuL8wbL2mnHfqAo2iKn/77P9/kZoh8PbwPa9ALuSy/jzUKg1k0?=
 =?us-ascii?Q?EeySbaSaehDWxc6I2qzArc1wo+YxT2t59VBntnr+UNqCX5bD9YmhJtA1fJUw?=
 =?us-ascii?Q?dNE9mmKZk8NozHsl0owLdiYhzqO5F2ujLEWrkBovPMLNZEtSnDmas/LJWUtw?=
 =?us-ascii?Q?tyjN3tKKRN65frtZlxfFOUaIuw6KBLDDVXoJb9UaYkS3zcfRyGamA7Lj7bgj?=
 =?us-ascii?Q?eNm49QJwvYzRxg5jg72wV3Uze0JsC/2JA4O1r2RNcn8ZKrlnN9vVpRTn1VCz?=
 =?us-ascii?Q?hChyZevSDZEscSGRsDWYkXk9mPPAI7m3q1/1ET17NXpSVTYoOOpaTstGhB5w?=
 =?us-ascii?Q?nY6+zP3JfmCWQNvn9jUs+OA0YqHq/pgUxFYNG9VcdAwYQxSgIyyj04MGzpZu?=
 =?us-ascii?Q?yZJhx8U247O2qGhrXBKq0u5u39SUzAlklVe8n6H/DFlMEKnRDCg486xRk4Nm?=
 =?us-ascii?Q?TzfcY4Qy4dWtTn47zK0X07Cfzq0nC+bhN3GcwMPsFKzTr4wvjSyrrM0Cp1od?=
 =?us-ascii?Q?Ie5esdGa3zd+5O2CcJ/yqnW3pb3Ti98BxFJn4YRvSwf10+0dv0HRsP6nnkOT?=
 =?us-ascii?Q?oy6ew5y6V69JwLJ60Ld1ZR0US28zPSa2QwV4RIaB+xFOuxf1GWwB1dxRvP/D?=
 =?us-ascii?Q?U70JBOCBYUYus/DObnCuRHjanLsk2xEHmD9xdaBOceCdk4oESMNdcVPHXkON?=
 =?us-ascii?Q?NA6QvS4FRTHRvJw+NvjvgiOweWHhf0izBcS6SHDv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafed74f-4581-4909-e972-08db787e18a7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:51:58.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCKi++cJgXJpZdCGyPadHX7FHXTwhqCYygDuqJ1LxIenKskJoghAEwdRVQihlVV4CzMrUSsrIwPAd5ct2R9yqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index afb8e970e62c..73b49d0c1e11 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4135,10 +4135,13 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	}
 
 	if (bis_capable(hdev)) {
+		events[1] |= 0x20;	/* LE PA Report */
+		events[1] |= 0x40;	/* LE PA Sync Established */
 		events[3] |= 0x04;	/* LE Create BIG Complete */
 		events[3] |= 0x08;	/* LE Terminate BIG Complete */
 		events[3] |= 0x10;	/* LE BIG Sync Established */
 		events[3] |= 0x20;	/* LE BIG Sync Loss */
+		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
-- 
2.34.1

