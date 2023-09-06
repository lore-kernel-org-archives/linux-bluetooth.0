Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F069EB8FD2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjIFOB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjIFOB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:01:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8510C6
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agcBIJ2YSz75mCGGe1/0ouNlwA+oHhYfDqbn9+BQDgxS/UX/cdm/RDN/AkdRMFohSjJxP3cXT9PggQkXZu5YPNmWLDyA0MfjRhYQvxfMqxv3la2PQwwNcuGL4xkIOVqdS87bBg/0qioNyJsXEsgEBHjpFc33ank4Ay951ngFke5CaqXtokydEm6OeC+uC6tNpO9p/SbRUvmBwOgrsMuhUVetOwWqmbrwOyicRPH2itNqdxBUgHjijdtb+CaCMzlhg/jY/WVeQWoa87YB0ndGtLqJQF4yEjXd/shi6IwtWEoXyGjYgPTXgeB02WcD6fsfNwVYyQLXQGrpbmC7STGrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAvRVu50ui9wvSGICbgYS+zI/2EAM13IYuBhtJwbECg=;
 b=n4Kjg6TZsT9hizdHY0n20p4B1Vo8O+5ha+L84D7gD9vpd0mq5ZKjsUQQKymgVX5ah1ZypWzp03P3ahgjIncN/xhavYVfxF016PZn5h+AU6UlNVDpiKhXXwRKXhn45OspeinNPy4HzKI2KI+6mTHUdlrHnyyDp2kACuKD/MEj8lx/0yjhvQDCkwRj8m7+XtPJIzIwKH/9JlGrusY2ecGCG0CVR+qBRed1bh0EvyVWjh34N4Ct6YMV80eIKkTjBjSjYLrRC2LaFtBvQAESBCQPZZJCOVOyg6hkrbbbKyFXol/vcIqddW7yo4hjedqi0FytEBLXy24nF6JWk1NPVJomKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAvRVu50ui9wvSGICbgYS+zI/2EAM13IYuBhtJwbECg=;
 b=fdWXp/YpRol/pERads3bQ45Jzbfct9IKnPEscRgfIodumf49dLHuhpljsalNckouxywxqeKKc40sIwW+VlVoUZuJHJHBirCfMWjY2l+a+nqHKR0alpN+D3NnMoSd+wRFWXiOzjASwgXr7xaolrKa8zW5rL2PkC96cy42LJ73P7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8788.eurprd04.prod.outlook.com (2603:10a6:20b:42f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:01:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:01:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Pass BIG encryption info through QoS
Date:   Wed,  6 Sep 2023 17:01:02 +0300
Message-Id: <20230906140103.9183-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0128.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: bd48fb6e-5f29-4a8f-e0ea-08dbaee1c059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7yZzyRkJI2av0k6hGxv40XJsSwl8QNQrW8g6fxT/+blE4OVrd64gE0iTmP5kQGsJEwc4Och777YBjbigJs3SXXpMxF9EGqwElUGFsRLQLcA5gV4wAk35nc6jnjHbCAtjlbLEMMm/ySLhm/3juTSMFcA3n1A7whYLIWrkzTSrlkzrDsleiLSade8aVQfwFCMDNO33RvpZ496l1fj7EbDYYcyKQJLU/CUc/DW5DRc0avlyVPQHwQRZE0SOfoCGlbfX4aBLHKtvebcG8dIPuXzCWdShWkUG9jE0MKLx2uS8LFKB8rorlzgD6E8z98iB7mXhuqhR5Kj3lmjJVAjjqZscn4xDDYkuwzd4ejY58PBEdnQ6huCtwfKwcLYvBXfZvGhz34LBmVpuI9RKrhkU3o3xY2tGkSz/Wa5g3zQGH9uk5DWxlIt+39i0Qv4JXfBb8jvi87WIZnrBf5F9utlqUk1VR4YWf7d9aqY0l/mzeRk9l4WUMlgllp3lDNQs9vy1Cb+9Dk6M2KIrsXQt9oiqh6e1Zr5PfpYFWGF1JmO7b7/+hImH5Uf1F4/MjZhCr+vR3IkfTLo9YweJ5pNvfjPA0LMyQ7GAJp/8p7Hz7d4N5uWRC4Dl/seGY5Y5LmSQi60IH9b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(38350700002)(36756003)(38100700002)(86362001)(6666004)(26005)(478600001)(1076003)(5660300002)(52116002)(44832011)(6486002)(6506007)(55236004)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(8676002)(8936002)(6512007)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1iF99MP+wMQpv7LWA/0BDSa6ww6eG+EZAvpjnDQRFTb+A0xj8zBeAJ7L2pW?=
 =?us-ascii?Q?0wezrIB3mje4KpPXmh2c0mASWW62WGFKDEilEi7XrPMox7VJo2O+OnwvloHQ?=
 =?us-ascii?Q?hzlTSlI/w46ZrANwB+UjjUK70llch2szlfRnn5ahhTxfXxH16U6kz/Btt5ji?=
 =?us-ascii?Q?3a6+2RZH5NaWZNzEZbhjn+DIRbiT20bJDwosh2/6U4r4FCpHCTU7f8kVzN8Y?=
 =?us-ascii?Q?goqQrUV6HHLwYFyeXc9zpYP+isJzkst9Q/FHkAYMNGbhOvQPCEC68xU9SsyL?=
 =?us-ascii?Q?oPZsE+9uOP7w7NmdPBIUUfbLeFkEBX36egGqPrjcgXkwXEP+VR6tzRVIgMvj?=
 =?us-ascii?Q?JfJf5/GKV4wzOZhJxxlPR4MGdQN3BEX28fCS5ewv88G2jRM/LB0Z4dyEPUEM?=
 =?us-ascii?Q?lZtW2Oo69/gXCXCziXqEaXY6kimK+3n+a20WVn5u/7eTlcE/Ez5bqpAQ0Eya?=
 =?us-ascii?Q?dcuI73xsjWPgkonQu33rPve69Y1hkyKPwMNAYDiVWM7K+F61F8v525IJx+VN?=
 =?us-ascii?Q?11w2x2ue4r/9m7jZ+UpuUEM7xS6Mg9mV0ryZmUJgdM3VFTS35zpZN0aaL15H?=
 =?us-ascii?Q?xY1/9jMib+l0xbTtxVWaf8jYfRw14ckmW82KGxI0D4VEjSoUTBO4dfs6CrdP?=
 =?us-ascii?Q?fOXtsImIRLgM+y5vanxiZTqlTLcMdU/Jep9qJzzxJKk162jNqIJ0YkkSV0Y2?=
 =?us-ascii?Q?LLJNcX41Z5YsAZerRrEzodRuSh+E1IDfuh31Di5zfm7pDL2MTfltkafwameh?=
 =?us-ascii?Q?fXXqqkoGj7Pp+jBDLJGOZE45W/uyy3S450OFwOo25/W2HFQtZhlcMBtIyDpY?=
 =?us-ascii?Q?UMbmUuR6nlEJIC8FaNwRvHLGVincpLC9KMBmvno8xIrt3YLBOgFWTmp/yfdH?=
 =?us-ascii?Q?B33XsTLNNkgwg02S4usA6U4N7cNXgFnouRHDPCFruuC/0YqAKss1cCrsF3K9?=
 =?us-ascii?Q?DgAmyg89qrZeDGTo0JamDGvhXW01dLIHWemRBjEZbHZF2mIdokzOll9XgZEX?=
 =?us-ascii?Q?Xph4EwfJPUNxpsDXEVBlPK5fQ81r3iSxR7p66v6yoIHxrN1xAZ9FpbQ9p4dv?=
 =?us-ascii?Q?PnNGrLjZ39P6YDtrarEHuDLXO0/bUax52d3mlbjSygPuhFyMeYVzLR4BX4wh?=
 =?us-ascii?Q?AHDfhsfRiT9xoD9FTMLsrnodSjOc17tnXTmii8xvfw+l2XSFhSVFXwI8gPSV?=
 =?us-ascii?Q?orTW8zJ0FW9WJXvYESVgitd8nbdA42J26sUXvzZp5aB0vsSJbNVKFcI/TDhY?=
 =?us-ascii?Q?M3HZDoyw3Kn7bHEvbvF2ulcJeZa36FAhJy+tgeosv8umUmp/zCFE4AkrvXOB?=
 =?us-ascii?Q?bgmxgBdgRIa0vvnq/pouGrNuoIN/z65vauVrQUIJnZqdCtv26PkRvAFIcVQQ?=
 =?us-ascii?Q?DU2Fk/F0PyY4JyOTfy5wx0zO/5k+eioCwKChNL2WtcL/np4pMx/Vz/13EFey?=
 =?us-ascii?Q?8H2KZyedPbpKt4LYU1WNetIcFaUThosrlK/wmWfpF14NMTbrfwBdcI79pQ2o?=
 =?us-ascii?Q?q74+ulvgBjf8YXIKQnDkZSm9JlS01vWJm7WM/r1Dd7yphCc/vXdh2WiGEqEh?=
 =?us-ascii?Q?LU7+AmzBGWp1VgBdZZ0CHb9w0iNPa8vwksHCRpIpXzEx1QRTuA1DvqlrZlCU?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd48fb6e-5f29-4a8f-e0ea-08dbaee1c059
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:01:22.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utdv4KuDFvHnasrtPBaFeZrw9Am8QvW2RSW8C/Zkjv6o7th4NArs5YqQo0SjFo31nQmrZhRIMVp0L4LUg7ihLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8788
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch enables the ISO layer to set the encryption field of
the broadcast QoS struct, according to a BIGInfo advertising report
received after PA sync establishment.

This is useful for the broadcast sink scenario: the userspace
opens a socket and starts listening for a PA sync connection.
If the PA is associated with an encrypted BIG, the userspace
needs to be informed.

After PA sync has been successfully established and the first
BIGInfo advertising report is received, a new hcon is added and
notified to the ISO layer. The ISO layer sets the encryption
field of the socket and hcon QoS according to the encryption
parameter of the BIGInfo advertising report event.

After that, the userspace is woken up, and the QoS of the new
PA sync socket can be read, to inspect the encryption field
and follow up accordingly.

Iulia Tanasescu (1):
  Bluetooth: ISO: Pass BIG encryption info through QoS

 include/net/bluetooth/hci.h      |  3 ++
 include/net/bluetooth/hci_core.h | 25 ++++++++++++++-
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 54 +++++++++++++++++++++++---------
 net/bluetooth/iso.c              | 19 ++++++++---
 5 files changed, 82 insertions(+), 20 deletions(-)


base-commit: 75d095daab9fa1d299fa79ebc7ab5dfbead877ca
-- 
2.34.1

