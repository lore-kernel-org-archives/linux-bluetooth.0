Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F7CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjILGSr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjILGSq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:18:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913CE77
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzmSJ41rB9Wa8h71964BpCZngrFGCBqvGNQbRhcsfIZIb9HoarRKFyjrmyT4gtSCS1e8g6mxkjhnEs15VT5fgx++ytwyGSsEm+LL6uZdR2toL72qRnCf2it61Rnci/RfGnj8oqUqI/F6OmCw67AwKQIXJ+8RFWScTWKqEI1I0zFD17F3goLkfu89EFeAB1JEVZQnMaY5co5c+2KoeRUDUMdsaKKRvT6vUPD0ggNFvp/x2Rq6eM6JIy3unehZQmOSyHH//KJPnBQILG6qnEyLZsenGNKdakzPQQeQfZnOO0SB5qCEy14cBbXciFQcyXAIp7MZ+GT6Zhik6qwkKwaDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kwo73fs8cXDkr1wk/SpKplhq+0CSnmgxVn/ZMsUUns=;
 b=guQHBHUGsdINuCuEM9WNfxIBmCzZmw3KK/Y9f1zyRE19jmH0t9tbStXKaeVCkKaOkmY4AyOMyHBVJLyS8m42ga2u5AKtn41CSnI9LWS3+PRu+nzFsOy0OLsb/Or/4lTsdKTBaq7LD9JENmtmW+g+h/azHSvbm6v+10GvY6Up6OkRtHaJkdvDKtLl2+3FKf4bBmxX3Gffk9bM2gA979bLjWLGt0nt3bHK6SQ4iPxo8m5K+D0D1hPIUgG76zJ2FMrlNMTilU8WrnZGHsVBcHiKpKOhT6n0T0xtsXxOCC4/jsveLW7AXHnQNZGMImuARel0yj3Ja0r8lf4ZteXkTxaPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kwo73fs8cXDkr1wk/SpKplhq+0CSnmgxVn/ZMsUUns=;
 b=HliAFoCWl5pDgFTjFK6hv/5BPvyHL1GzEDiBRrS6pwpsHbwg4Sd9Qn2icsMkzszA9eVo5t+BmhHW+7XxpWDsDAf7EUfH0jyfC3O6CThe4JhVMHCOMt5cZHLEAdB+gF0agIgwm4gzi5Z2Oyd/oekt64UJIheW1VqrxPJNgc3kR3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 06:18:40 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:18:40 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Tue, 12 Sep 2023 09:17:36 +0300
Message-Id: <20230912061736.1181699-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912061736.1181699-1-vlad.pruteanu@nxp.com>
References: <20230912061736.1181699-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::6) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 31004178-1754-4974-8311-08dbb3581ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJKSMCEq4HsIOLCCtXPRX9CGB/xa/BhB+vSNXu/mRrwzX9+JFa3eJQhfMmSJ1SEiNIhBqu9cG36+0PFRpl/ov6hxXf/AJCiS44iFBBThOM0P0Zw0iOM355xglMiBJxQnvN28sAo+zt7JubGtfEIJNClgDv1rWXKSO7DAdJBaw5cqppeZxkY+MmsJSHUnRTXm2s5c3vLqVJcc9+XheckmeD5mqUiN0dqsuNtiPzJ7i53ug9rAjjW1jDGukJWHMjQ2pmt34xPT84cTEJHhUNm+GRhZNsgWCbNPcESmNtUQNeFoARVsMgjOq/dGu7K3s2w1T+KtSvPJKgFrZIXJKFIADxzez7MmqTn4KtKdyhaqdEq8TH4SPJhrUxVRZ62N4DBzf5RSytFwAWhSoKI6EKP38/WchBl0Nde1Jbp7RDHNMJQeqG7cfXQKTU3a8r1/WJ/xgi0uG9Tjlyvof4AfiEC1ELqEsYYzX7yYTCEX9uTuluufBRz1dLD+qSr5Sai8DIsmCU3dleed9auYTEucngoaaFt3iZFHJRxTGiqQ3T1IrBUyJkSl06nSrZtCOQtDjQcLeB++WHDutMEs2UcrBIldSKLSjX7dTJI/Vd6y6vCBidmskHyc//rwm7cbXyC+MWfB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(186009)(451199024)(6916009)(66556008)(66946007)(6512007)(66476007)(316002)(4326008)(8676002)(8936002)(41300700001)(36756003)(1076003)(478600001)(2616005)(38100700002)(26005)(6506007)(6486002)(52116002)(38350700002)(6666004)(83380400001)(2906002)(86362001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUXMIFEEBWn4rZ3ZnQsVLFQC2DgdwTftkLfM6rVdigbVe+8pdhthw6zgC0Pj?=
 =?us-ascii?Q?MWZpHRRJXyd2Mr+XkbcE1kKGqLVsK9dlqMl1wSJpaz9A1R+iQQPK1vxaKOXg?=
 =?us-ascii?Q?UMLxYBAjfJDWHA2tSAs5RoZNcb2Vrkiyn2AgvEB7bejKNi68cU8H+GRTtVUW?=
 =?us-ascii?Q?wNJwHnjAmmpHFilfztAlq4pDyVznyt1N58xtq9wyyCLKODi10isCoy+QgO5I?=
 =?us-ascii?Q?ta43ZIhKrF4KXh2NZyotf+2nZCU6GZaaIBjR5Vqs9uGhStUHVY8EyXgpLfcm?=
 =?us-ascii?Q?8ueVqkczRcHLazd1w15umLljn1Ioyj/72zh7IKbe6gIyvDoSmjRFM983Dtxf?=
 =?us-ascii?Q?DObSZzxY2cJqPcO/J8LmvtTGxvo/CzAz+SuVxJENdktdcyQNapVcnCztNA46?=
 =?us-ascii?Q?tbO1+s2LBFE/HxyMaeXC6XIzLKUYxLJ+5y9zb6qL06VIjUY+1UzwG3eik9uj?=
 =?us-ascii?Q?pS6tGoIvTyUsv+hIt9TdVhXNKFBMJU0u6kH+SdVe+koWEuYLCA4vfR1A6+Yk?=
 =?us-ascii?Q?J2tPGvO6xmOCjcTLc/JWoLM6T4OKpMiBGVeKcOu4WLwjzJHNk9v/tecJI5JN?=
 =?us-ascii?Q?kTciFi1hj/QP8eLgOBCrbCnk0Ij7tzcvZh1qfiViFHH6b38r3NVbdw4cOahC?=
 =?us-ascii?Q?GND0i45BhWlP8S1mouq8XRxvAgd9kAtyodC+bId1v3vPsCqqwqV3OrdwHHau?=
 =?us-ascii?Q?tO1u1Q7R7sTCrVtsblf8AUXppPxNLGbG3bvpW25+o37YRZ9mV6GMo6/GrVD5?=
 =?us-ascii?Q?RC8EEzlcE7U7n1lfcBsNv37KusYWo+0C9Q0HtAgD4V8gB2XNBVvSDPHo6Mvk?=
 =?us-ascii?Q?d5KVvOvIXom22tMDuRNrplmN/Q7LfZtT4hwWLjuXT0b3ncHG4paAfn+iMVgE?=
 =?us-ascii?Q?CLBsTTQdF02Q9CrxX2NGreSOdWjX8sDV/Xb/bl5nKPhDT+MbUF1dP9alEBkh?=
 =?us-ascii?Q?NrdEYbdpI55PQHJVhi49QW587xBkPPHJ3cmA5E2F+SFkhJSzWQC1iqYE/yxE?=
 =?us-ascii?Q?b3uaJouf3NIXC0qpnQ6vy8j5Wu2Dg6a43hoMiqoFcZMTAkBTPtLJDyJGWJP2?=
 =?us-ascii?Q?J5a9URR/EIYILzY7Z6FxzloeaCD+x1elNkJ+6FmiWS5JDAk1oUZ3YrPUUG9x?=
 =?us-ascii?Q?B4hnCX9PtoeHdRx8798RhIShlwoU+zCOtDVfqeW3AnlRAZ061ptg8BLmv3kZ?=
 =?us-ascii?Q?BwCLek306qz19QVsE8uhSw+FqeSIA+/lscfo7K1sk1F3POHbqLMLokYiD+3W?=
 =?us-ascii?Q?DGOpzz+lNvhUeS/fuZrps0qdFJuy1p9hQclTlVRf/u6htO/m6clfQsDjFZ3H?=
 =?us-ascii?Q?v1LMAuy2KxxgIju9cGYU9H3EtFyyKq6SWrCkF2Jus3h+QSAermSJJlwY5lsn?=
 =?us-ascii?Q?+Ih73YKaDZFXug4wOu5pJMMCmnNWPgmDLiQXRikO6PLtt8rfztEYVvOSFPtW?=
 =?us-ascii?Q?uWeFETaWfC7exSqnmV0xfz3rc3YzWVTuBqTXs87x6x0eW7+K+AcisNLYMWaa?=
 =?us-ascii?Q?k4A41IH+GHWHSrSS0OsLbR+0r9HXbLTTImo7c3yVipbhCbIJeYHB0Rx1g9jT?=
 =?us-ascii?Q?p/lI6lHr0Qy5n4P3o+9JuoghsTXQJcmEy7bx6/9eHF2Mhz51ZQaUiIuYboj+?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31004178-1754-4974-8311-08dbb3581ba8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:18:40.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQWkyO+QZo6FqyWxJuxW5zdCWAjdnmkSEcFQd5hcACY6hLaOCbChJLihtVX6U/r+DHM5s6ZVcSAP2NEacPvJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As mentioned in the Bluetooth Specification the full name of this bit is
"Connected Isochronous Stream (Host Support)", thus it should be set only
for CIS capable devices. Currently, it is set for any device that has CIS
or BIS support. In reality, devices that support BIS may not allow that 
bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ec4dfc4c5749..1be5763c261c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4264,12 +4264,12 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
 
-	/* Isochronous Channels (Host Support) */
+	/* Connected Isochronous Channels (Host Support) */
 	cp.bit_number = 32;
 	cp.bit_value = 1;
 
-- 
2.34.1

