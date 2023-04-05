Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE069C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbjDELUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbjDELUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 07:20:21 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8215D35BE
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 04:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmSg0cV0ZhvT8hTaAOgMVyDiRtre9J7cySNb6+oyFB2APCYxJZ4nk/3b7M+MHnAPidbkWaE2uKkN7Z5SMmKEtCn+xt45PrBre0JQOkJ7LL89dvr8rpQN7tX8TckwuPdK2app9GKAl2nLnDegS0NPRGxHcFwUJFPhDDYESy3zBG+C+sYnI4I6iFw/WwDDtzrdInNWWlihINNEGOdwWgyb6cmoHjWf7aMvNG+mpR5O4/nVpNw1hG+rlMwlV+YJkBXPkudWvMEsmftuElursR6U4S03nsvtHTzYH7PyWuXOfCeKsanrB2nu3ehM7Q7dDKqTDfEVF7C9EIOohHpbtfEnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2kujT8oEiPyF/rNCbxIg5yxjBhbsfnXZh55Vf/Tg54=;
 b=Rm5ZFKQ95Q6V7giOIM2o/rv9ecImSFl0v1fgQZr1vVh2dD6bNAkoSu4cRJf9LTEJQCsAW5K5SxQ0fy7cZOEUIcgZmlCMKFeJKDBAXCWdrDmgvbyrUMiZlehP7O7/D/B0kpfOx7OisKphnOtGA8cd/xFRmeMBlt2I+cgLr1wBpiOE5f0GL8CgOx4OcY/pw+MIm8iIgTGNPbsOtkWM9GMLnQG2rBTaqEOaQJH84HVZxjSVtvzcshweC8dM43VVqARxr4iTj4663X+kyt78K9meR0OFvyVxiZ6RA1Db9Y9+0ULUEsZ/7FiMMvzxvgCYh80ngf1NLaKXZm5J/vgf+so9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2kujT8oEiPyF/rNCbxIg5yxjBhbsfnXZh55Vf/Tg54=;
 b=pqPNH0pT208DsQ5A8/LkUZouUyPPAePduGm/NBywDPgXX0CvRwxRCKfd2mWTyXB8t6z10NdIJlhiQr7kjxSUj/gA4wGhlnfeRilr7Bi+SKmucukkS2qTNVaYAbECTTxSytrZYY4xhTDdSZ6My35czEANsfxJIxHqK7vg8X55jEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS1PR04MB9631.eurprd04.prod.outlook.com (2603:10a6:20b:476::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 11:19:45 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::851f:231:cfbb:3913%9]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 11:19:45 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: Set ISO Data Path on broadcast sink
Date:   Wed,  5 Apr 2023 14:19:18 +0300
Message-Id: <20230405111918.4885-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405111918.4885-1-claudia.rosu@nxp.com>
References: <20230405111918.4885-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS1PR04MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbb2fd6-4f2f-40aa-df16-08db35c7a8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aM2ssauT1clga3uEIj0pYZuzGSE/IuaBOA9L1LBlu5YdWZ8ZZ9yPdS/w8oYBiJikFDKTWUrcudNiArM9Wd8wEli/4ivZesAVNoEuGe5OoycY757R7RyOHGvJQ5SSzoKKHYWuf2nIP8m5D6Vuuc7UQkrkgC0Uoz1nEAKyowQ7DcrS6Qagk9klvjzC2vkxQs0HotBqwQMLFE8hn80IQGiJbVHQeQzzEPWZSF+1fnq4HfU5u6qm5IvalolReENMemDUOFJ86soRpxAj+NaThcx45GfJO7YrF5PzrPrBRTAYDsgtOoDFDqg7KhF0dlmblBL/N8iREfbhH4R7ZdmvFXdHTTlZcxkAgDgyKkI3ytryCfmFsvs3UJBY8bDhVeVhWeRAZJexCM8iPrN4qHpaG88prVupNfK2AZrbleH6iABK3+sYWQHiwJ3rgYslS7eO8B4kgbw/K/ER3NWM2RuH0BZJunnO41wZlW4UStUK2wvCgClZ1zr19tUDHiYvZHkUrhc5BKwS9rlg1veU3m655l/2rDMn6Crb7ttgtvQYYu81lpLp5wRgdXiPrBs2mSY2fJ6tMNdi9eAKpT5k8areIhBJHQUDIWybpzsv34Kcc5bFy0HpsEskGu5Qzy2dpTfel8cv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(4744005)(38350700002)(38100700002)(5660300002)(66556008)(66476007)(8936002)(66946007)(4326008)(41300700001)(1076003)(8676002)(6916009)(316002)(36756003)(2616005)(83380400001)(26005)(55236004)(86362001)(6512007)(6666004)(6506007)(186003)(478600001)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQrNQrXUz41u7iLSLN5DEDiUqL8+W4FNrum6NIBoEq6NVkLZRJCym7d3Umgl?=
 =?us-ascii?Q?R09IuHdsp0LtvLSQydBRFusMgz+DTzcXx3+eOH6oyF7xFM8YFxF7ciDSCzR3?=
 =?us-ascii?Q?Y797h2LcyCVXZLccUhCCW3SUbyZ9KWZNh43IxzLedWNNfveIhDXgQAl4U8su?=
 =?us-ascii?Q?XhojamaC+DpRAufEEJPlSIxX65l3qiPmQ4GiOT9YNlaDn0gVhRjbAxi+j1/F?=
 =?us-ascii?Q?bFonB1R6UOMicD2zR/ICNv7gjH1hhljHrNnY+JgPYzfXU+zI896ojHloHqgk?=
 =?us-ascii?Q?YZMpQoZ9VK4aKbu0EgMbRsG0M2jkRfgk9y0PS1icESfR8vvLWvkqJ88TwXNg?=
 =?us-ascii?Q?FwfvQup70IPjcgno9oAYk6c9SBtCyPs7pjqkssihl/5NCCsyzKGa+ZRWYxcn?=
 =?us-ascii?Q?fJ9yeo8Jt1gCWxzKe/BpxjS1Cyk9MgMnUwJvAF8fYrrWcJlxyvm5GeXcK3os?=
 =?us-ascii?Q?yH+WZL21dJgqnZAuazIV5T0fb60dzJv+JYva+u/qeKtGzLcmwRmWbi579zVe?=
 =?us-ascii?Q?ip7DykNaoy8vHkAPh+S53IvFjekvQ3Y5eiryKA1paIVc+H859Mp2KYkujhGL?=
 =?us-ascii?Q?JXl9E0mla82sGNXG09xatfsQgHbNkmEzdUSiPAD1QfA3QydjObsP/e3FDqME?=
 =?us-ascii?Q?uIG7bFi8eDx1mjCjVQbRdm86YFb4Bt0Ppy0fRYSZlCMOLjbaYc0RHHccUV35?=
 =?us-ascii?Q?B1d+JoBK1bzKBZ+12/W/wzgJCtLkUvJzsNneYQxqGw7u2njY5lOjzh8IyOdf?=
 =?us-ascii?Q?UFZL7OHAaC8qcrcGMUKiYAImKYWl0sGKBXoYsL2YUPYX0eV6rig3Hs/BhEHw?=
 =?us-ascii?Q?aS8Cx5vXrhBkbUcc1W4ARkxljJufiareB2sDIq7CZ6kHfMkcCLNlp7E9Mzjp?=
 =?us-ascii?Q?/wG7aSx5CLZIfFx8zP1YMMsCkopfrJwDzYcxmBSXSJ6ccRgP6dLIHQbIDKTL?=
 =?us-ascii?Q?jDyiAj2UbMT48coix0fzvmXnEOv1A8dGkLZibobdihOyOIPEN+144WaQEz9x?=
 =?us-ascii?Q?tO0AprArT85ui5f9Q5Q6fyYO/uiWiM7JZsFsWfyAuSJ8QTbCC70T7bh7AUTy?=
 =?us-ascii?Q?/UXeiOJUQH/to7XMR8vsQWS4rnPVudyF9/Wp1uxswDdWW3NgX16nof3WhGGk?=
 =?us-ascii?Q?Ckhd1jAN7TEk3FpVgBaqnHvB3yeCj/QG6IhKtJG8F6GpFOs3mklHUR3+wSGo?=
 =?us-ascii?Q?jkZPx6jASBrHP0sliNpzdDRBfkN5zCYSjUf8ne/K4XZtGsOksXtONmmExj/x?=
 =?us-ascii?Q?oZeyZ3YVThrjknIA6XoQHQRP47EAAFcY4e7DbWj/YIfIDs9fntB4YCf3pXNk?=
 =?us-ascii?Q?Bz/VaFyPKwzwgFx6aEMD+PxHCLu1EzL++q4kTlBqNk1ncv6PZlfZbVlbMvF1?=
 =?us-ascii?Q?6X1SAW2ZKXDjGDSiEjid16t0McF5mtYY4+tUNWLqk7I3mhgkH3jTWbcOhzgR?=
 =?us-ascii?Q?7qvrZLhTq9qWJAdTEjhL3BMEbWrJ5LcLOrb5JKahj9qZqoc2e6QgN6D5cYrz?=
 =?us-ascii?Q?7IzbAlBRKBIbPA1+XUhwpCw7mIjGorwU7RHAgCoOeGs2dci5DjdeQ1wktYqj?=
 =?us-ascii?Q?lWwPSbcj6bvVSroHpat+RuLWcnipJnwN9YomjfdR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb2fd6-4f2f-40aa-df16-08db35c7a8e5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:19:45.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhznQPje0OInWQv1Xj/VcTtL4UIxGHrk9N5S9gXuJHNr/75q6f0R+CnA68YKjABm96NSihiw+OKFQhgejGVB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9631
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables ISO data rx on broadcast sink.
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>

---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6cf9ae5b14d3..0e0a93cc1218 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6997,7 +6997,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
-		hci_connect_cfm(bis, ev->status);
+		hci_iso_setup_path(bis);
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.34.1

