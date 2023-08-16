Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804CFC04FE0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjHPQrA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjHPQq3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:29 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054232D40
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RULo2dKDLTxwzmTISJd41uK7L9xniTUNZHPzlAzeo4LMRh3M3VKSVruk8MXD9xbHPi01aZiZ4+djtCojlDkVSPDgN8LgMWwkRHv1taz0XbqkqJj6uGGgdIqUMRKCyjVVtKJhtka4PaI+DsVfvZvGxdSBcj8ZAzURfgsm7R78TfhVNT1pCtYlK02M8L5pM3FvKJjPz522GCXuznOJOoZJqNpxRbel5M6oS2C1Jpi8fVIfvTuSgvK6L6CFVyUdy57MbVO+SmSjTYntDayAxu8OSaOKTAhD7mO7nXNgCa22imSYGX12RFXJ3r/8DXi/l8MpptQRtRmXCUN4gm0LT0FWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB7Lp7kKiyR6ev9+AbF+zX/i6OoL2QxYMBxWBmUwNpA=;
 b=iC429Gwbat9FuZfWVBmeXgsNYnkt6sL3G6vqtqiEJwMXzeE+pW7DZRvsd/PlAHDtp9EFILlq8rEA3SARTMJ0Q8lwRp7FRTiA1ARdlOKjnU9orlHd4Dc5Ep1nTZQWNVrq/VNd3GuaDcFrTOn8xi4TUnYK+BSNf+gmvcOKUQFQTCApEDHOrmsGAPZFeZ0yq9zutVHdUlbbDcQc4xB1ystHDO3p7OyJrxBGjaKeUg4+z0I4phTo3OsXHbZ/UyU3nq0XJh2Nq+uZSuQBVdGiNBpIoqTou4PTypHXbmB8uFXhBbiRic9Dfqn5Mkfi67WmxUO8cG9tzPNUT6Sp3iO4GKtA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB7Lp7kKiyR6ev9+AbF+zX/i6OoL2QxYMBxWBmUwNpA=;
 b=NOjwwz1wDSbIsAlQAYVpV3i6IiHrAYwyNA4GX+KS5WkKGRoE2uJhmdE1b0OmJNspqe0EGiWzq3kdYzyZgzTcdFOad6scqWXiFzg3Ywfc4wQCY920Q2hfY7E7ejSCBQYsAzz5XMXzHKX85HhmWPmNDjJIBCeADvM6JTPeP4b14mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB7107.eurprd04.prod.outlook.com (2603:10a6:208:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:28 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:28 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 7/7] device: Set as non-temporary device that has matching profiles
Date:   Wed, 16 Aug 2023 19:44:35 +0300
Message-Id: <20230816164435.5149-8-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2a0a82-71ff-40a7-c851-08db9e783277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 488B7nAObyzBcLvES016xnNq9FFYcUb0eDfynA3JGdgDPRaxICCh9K2IqMzwqhhMaxzDKYIbSSfJwT3VJ/Qka2Jf3Lw83K3Mbd/X/8/Mv7XaONMo4jtT1D0yZFU0ziGdrlQXPQMxhJazdmUgTQV2/qAC45RFXAzIe/dc3o7uT4H8KQBRkw9uf/7dbdBfklNXlUSNSVoNtK0fHRPcHls9AZBnkFwW6hpnVFp0kaYCh20We0Uau7EAFkrSPcEdIc0Yc14ZU7t8C94+wbvWdXdTvl0Ri3zgNtoxd9WTmVPMnNbMsnxdClUKuiD9MqqEJNTYRSQPPxA3jhJA/+oJ8mF832dIN8Ne1Wsnrd75+gBGUyH0REvJ9d69Zh8r3ajIi7sPRs9XGZvV1z7sxmy8w1bm2MqW7PxkQSZBTR237D9nbFGkc6D5BHwusAkkEmvGw42yTY4niRBTIm9mnmv/twREXaYjweDiCiTpyeaBAuPk6ojxKMWBqHAd9oFrma6dJYjJVCW1/Q872RWwfWUBFMTFbGfQRzuNFZMxU46dPfjQkcWmv/4EL3epRTmNHMreVDhOkSF6T0pRx0aQ5V6thr2X5wbDeV72qiob6Dss1kgHEi4iEcFodHQ0MCRfBhQDOF4w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38CBFLwcHHSIs8FjOemgpAn/+0pT6infYPrGpOdOFzLSRU94koPxC+VoTvzt?=
 =?us-ascii?Q?ZHVVj5IFOXlv+/MXkcMpVr/Gu/pnngnS9L1dS3ObQbbNj63damX7DnxFL1qW?=
 =?us-ascii?Q?vlePjc/37xLpiou1z86KCe67CwdQmHRx/kBSAP2wQWqIm0S0xybblea4JZlk?=
 =?us-ascii?Q?igQCVBuWexcQ0htvdyHaoqBgh1Dz6QOaNF2KjG07rpi2PWuVv8kHVjHEOcMS?=
 =?us-ascii?Q?sNhjMStxRwodyJsSxmJo2+5MZOBKHttF1ZNzbKUsyVjvU6TqhyCXm7pRAOgm?=
 =?us-ascii?Q?XLDppGgK+RdTUh7DZAf0mxo1QZpf410Blz9WUU3giz677hQ4eWI5LEAj1pv1?=
 =?us-ascii?Q?03zua29pKhV6yyCwk5Ii7RY8q2SvgGO7HySWxU38VmiPpdvD3qHSQGTm1QvN?=
 =?us-ascii?Q?1hY24ycC5F+Mx2F4uWKbvoHYbTqYRkN4YOrO06YDg07e0ekn8NJb7D6z/2d5?=
 =?us-ascii?Q?qLnLeRQ3NoEmXYEZcxvSQoSkLbkSm67xsKIaGaHwzDsPq3ZtwQMEj25LaKyq?=
 =?us-ascii?Q?8VaI4mnzOuowXTYxAv2+67Zm+rgLlaWzPMrlPCFkzohna0BeQW80ODu5QfjI?=
 =?us-ascii?Q?l5rVbCnH1QA8pbimrbOU7UlNL+0TLw+/8oUZu67BQ9VJDmMZ9Bqn8U7W3Osi?=
 =?us-ascii?Q?7mbvIvgZgnD2tMIBbihrJoTYtuGfCFFZI8CSbHxisOCuosrbZ5lqeViLSJwB?=
 =?us-ascii?Q?eby5/1gfq3OSXnKay7gAf4QxGmxHjySqAOSayLYySbxXyKQ8ATVgcT+63xMA?=
 =?us-ascii?Q?aBeRQnSfz3IrIFdVJf6gnpWQ6Z7g7SOMTGuWAKx+nPyk0wLudUCZOGxpEk5F?=
 =?us-ascii?Q?6Cx/4wYcogTaVSQgb108k9BBZHXDV9y2OihPEVAKj65bPsrpSUn/eHxANBt4?=
 =?us-ascii?Q?PhNry24ZijOK0g/CO/jDJ6zazgxRsHnzjnnxj7J9cyfhMh0Qymublw77CLuZ?=
 =?us-ascii?Q?RT1TC4m9CPYHtrTZnOPzG4qlN1AWoq7sdtFJh3Ms2HICv+3aiBvceXX41CX+?=
 =?us-ascii?Q?1s890aKa/ZHULjm5p375m82ELKnVP2LNoay3qKMUf7v0G8my4Us7b5wpwyVA?=
 =?us-ascii?Q?y6EosC9XDcE6lNE2SDngiB1SBFmsMDKVlLYvC1gVT5nre+IkQPuK9ubp7Qsg?=
 =?us-ascii?Q?Kh4Ip/3UkZ61QUm4YpaY2pa+0BxwEmQYNjdlfA2s73Soo5isHSb9wF0jUTHI?=
 =?us-ascii?Q?gFbXK5E354i0j9fSHFG5KuBVGX8OnSIreVo0viMQVN3kIRZnaIHUXb7qSRUK?=
 =?us-ascii?Q?CUiOHQvlx5oNiuSM4cQu5zLzpW6nadRPCsahUl7H1CHZwWYdfzjqrGVqLyZT?=
 =?us-ascii?Q?e2aWQNWqMkKKbHNRew47cr+Xe1s8BrE2dt0Pbtlbvk9geGQ3u/Dd+IXjeddn?=
 =?us-ascii?Q?YhbqMFyxmM+CBFq8k78YQXBypku+8wkfqAlIQuE8AVHiyJdw5wD9a3IKcX6z?=
 =?us-ascii?Q?NJbH9FcVY8zzAEkbIswAtPjBPgwfBYVyxm6L1abpQJPvMdsQb0/TN2aPAhiW?=
 =?us-ascii?Q?rdZTbzzH/zltAKPig5oLQr+0xFXUv27w7XKULjpFc3SheZ5aNcNd9Uf6JaOQ?=
 =?us-ascii?Q?LYtrXtSKq5cv0gig5iap9fl65UxNDSP8Fouu3yzi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a0a82-71ff-40a7-c851-08db9e783277
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:28.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7zMliF+p8eSxPaMmrQ9mOrs3sVpaDUrrJD6SUxQTbyMtDWwUq5x2QD2896Kr8sxPuO+vUhANoXqC7h6QVm16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7107
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Mark as non-temporary a device that has matching profiles.
For the BAP broadcast case, this fixes the case where the broadcast
source was discovered and the remote endpoint was created and the sync
is performed after the timer for the device expired.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index ecd385cf8..57632b51e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3943,6 +3943,8 @@ static bool device_match_profile(struct btd_device *device,
 							bt_uuid_strcmp) == NULL)
 		return false;
 
+	btd_device_set_temporary(device, false);
+
 	return true;
 }
 
-- 
2.34.1

