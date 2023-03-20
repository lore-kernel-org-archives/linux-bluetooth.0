Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7827DC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjCTOh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCTOhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:37:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FE24702
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhBx5mrRhNpdOaqJawpZw+iWEkvp63OZYm7Y3QKr/yJnPkQgW66pBIl2ogkxSrXq3RCbGaDXju5CU4SCNSuuMeTtk7wo9vrZe4HJg9PWXLphmnaMuSV1cgihBiQGXcW64sCkUBuGklOOeAzAOT47RE0l1qk1dfb5Y7uatflq701RT/z1nqxbvWY5i+gTx+qUnyrfZtWjElzk5ZYkJcERGQIiQdMJvhFZAq/0K2EfvH+t1E6L3aUunkMg0GzfAr4kr7qgTogPZ4kWq4S3SwBVslD86vwy42nvzRrC82FFh+gM2bwYV6aKFRQObJbm+9Y0L182w1w/+uGz/PrcCrWiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMH5s/YzW8GEYCfSUEJEcnrSGLJ83b1So6Hl2u8/q5g=;
 b=mIV0tMeQ6nGVluG2fbuRAVekbY+WsQR09O2ffmKtv7HiiR+Bg0abYpuPUV/1yq915zX/X4s5eOttxpHzRgZOERPxljBk7o4N0tLjO/2Rd/WlaHhUyogret3svR6e/+VoLvf2RvRTLJ8L0SQN8XBFHOoJY5Gyh08rnALm4Ml12cDNdtb0yE5bERaRqSb9GeTu8OtqrG/vApO9cy1/8yFC1mEvkDYNQtFzyzWk/b2Mc1XWq7Tds6tcMtM1q30ttWlzdi6chZxVXRsHk6b3zdj5MmTee41j7PeAig/3vq8PH96l2nq4x4VADVq3CqS/zKzE1IQFxlTgB3SSKJIYCq7omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMH5s/YzW8GEYCfSUEJEcnrSGLJ83b1So6Hl2u8/q5g=;
 b=reZfB5Xuzc6Fm4czdR65HAbmlAcS0pcK+jPvLm99H2nk/kRED9KZ1mW+u5r3sjpORZKBuYMYtHoSQGUvt/SAAShxn2kk1EzldBBeTVzWN/B1fjJhIQ7Cb57MK4MPKqy74tUUJIdnlrgREAucYyDgugZ32zBc8qshnnS36+2F6Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/8] Split bt_iso_qos into dedicated structures
Date:   Mon, 20 Mar 2023 16:37:05 +0200
Message-Id: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: b17c45e5-b436-4785-55ca-08db2950a087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUBNnInCFBb2FsWpRZKw1z6kEd9GqWqc5fEx8RHnEIXtuPt03sbQx5AbD7ciC8E6UE5PeMmss0FDUZNFIe4wDkpFO2Dk0ETNvyJ2ZNzljDtENXycu0T84OH6cPjiuYanEwa2KsEhR5YOB3kvgQSZhpnNgFl2MtaFr/JvIBYWtSaNtXFxdiVtKSxrEcmEbb+Cm+YlDhgTNLrV+0c6JkPD77EJGTnzBSg1LmzRJOGYtjoBiS4yBKGwbqmwWRKgBrdBHeY7VIdvdW22c8mUWQjqTp+27GjD2g2TIQzong5uXNpzycdYwudwPA9Fb9q2nppF0xD1CwKzw3QefVWS22M1i4yVg7qlLV3lNG5DXSXbea7ESH6mRTvuoPKzAIoeuG291iJXUm7/HP/Fkf3gAL/aZjty7ZJYhXeny93xFSGCq+kpN4iw7P5dI1sMoMfTyDeImj25dwckLXwmu6TeC7koP7cujvreL31ZLxSYEUrVA7qx+gWSSTKh7IIiAsqFqwy7qOgFy3jMOEs9sYqvZsNobSIQQLJc+X5e+YUlf8i/39ea8qd6tGwPDoZ4WEP3CtquCX/sfays7gfuwLwsJZEWhIcewpIdnUnVFUK3mGAskY0+/t7ckCrTp8DgZ+YnhStWgxwoOQJ544RTsD3S/n8/t3+8Av7Hf1zx5UO1L4wlkJpBqQ7V0WH5SH3B73u4pd+yZ1gn+fXu/1qREzd4lpDXLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwJwcvTMcGXTPCSvJNVF4HfSzuuhlYL5arAhSatv10GkUa0eiMPJdumc71iC?=
 =?us-ascii?Q?nYjMfM+5VFwrhQKKTsqS8rv3O48MIpOrcLSO9PmXUxlt2l+1Z6G1pTiiG8RS?=
 =?us-ascii?Q?cBy18kn7ilRnDt/qz/bUg/CGVhy8DyMJ85Ztd0+z9F83PuqL1doF5qjOemVB?=
 =?us-ascii?Q?TCLE2VbGb0WKnVV++LbWj2/LeuOYbByJjtqEtijP0nPUnFFiGnFRgDOzdVFq?=
 =?us-ascii?Q?3Y66rVeg8XPbZ9Kvr6mIgC367t4Q4WNO0YxRbkGJxXCQEd0jBN39QQQ91V/a?=
 =?us-ascii?Q?ckQk5YTj+gvHo0/uQB6WzW/OM5JpQZFrKtnjzD94rbxxcfJbs+l6Z3LQmSWt?=
 =?us-ascii?Q?h/sB7YJFns/kmJyZnK8etZGZA3L2AxLAuA+aSmicAS282jnRB8knJPuc2CgD?=
 =?us-ascii?Q?+yTBUgMph/Zr7NqsVDF6BRzJE/fXifAHWUVSrKIoKfEOK+zpIYTR+F4i0cH5?=
 =?us-ascii?Q?lsG6DBYMjx+Hq/2ikQKcoUq4EJQajGYCm+wJqy8BVjZbzPVucDRkP0tHm9M2?=
 =?us-ascii?Q?iPgA01HojBjK1lyIp+fj9FEDoKG/T7f9Ckdib9YB1Xig30ni6Yz+oszP4Zvv?=
 =?us-ascii?Q?LlYpDlRQdepS9BZT7Wew7Y2dq3Ut5DsAnM/ZqIiDYtRVA+KPeUMAzQeHJqYb?=
 =?us-ascii?Q?jozKi5yoVMD/3SqFB4Xd5ATtPZDmm7ERZXHKGUlle1GHuMpC/LWsUcH2msUA?=
 =?us-ascii?Q?cst6qn0qs0MiIFbvWp2SOQxgsEnXCvxZvBsjS/vN6/RYEFPaojTdSRiTPCuq?=
 =?us-ascii?Q?FFV+JxQjB4xQBkSclPJ3tpdulHZKTo/0pdPzaMuEQRD0p1Llev6JHupn3foH?=
 =?us-ascii?Q?fMK+m9K3RKpNmHsVpKPeIu3aL5jkNb2cHY6zLPpa++N6VKw8Vd3iOlubzQOQ?=
 =?us-ascii?Q?2NdyczedcbbMUsul0ZtPZn6ksJk/NPtSmgWHqaLhHAa0iQka75py0ebC1Ku+?=
 =?us-ascii?Q?nTi3QvdErb6+K/5mAv0LCYyMgSPQsGNHvvJoVtyYQkLAqzW2HwLhy/921Zr5?=
 =?us-ascii?Q?GgynQXhlm7+Z/NYQZmoKRx6wkFHHiIAwePS4ET+f45Ble4hGqRmutzVZLjIi?=
 =?us-ascii?Q?AxRGVZaVvKqfZthKpoaMHTYdkq/SPLh6qU0WpvEhIYHUeSJPL8KgjWRGxLVp?=
 =?us-ascii?Q?hhSpeAfQ8hQ1poLvJkHihUdw3kwtONiagLtYhIftDbC+AEFBjOUjGviG0S3j?=
 =?us-ascii?Q?BXTCMTFoUooIXUzMaelWTL6GtlGmWw+eySN4pSiFLWUTqKm5XPVhEvhp/RE2?=
 =?us-ascii?Q?lwUAJNlyxwRN1Ea8RRBlAWZKryu64LlnLfcnP8Zf9PKcQ5DgXSrYFB556sAm?=
 =?us-ascii?Q?Q0FbJvnweMaVXiF4IUre36i9pkeG86zzkFo3CH0CLR/Cbkfb5iloqwGvXzbC?=
 =?us-ascii?Q?GfWDTWeXsqt+dkEuUxWdiq9Rk+XtbdamqgawW68URVQYufkifFC/raPFAeSH?=
 =?us-ascii?Q?xZlqQAksatbZrbAeuMVt1ZS20Xrvbue9kDMeE0X8J9khQCx6+G/wToTnY9xa?=
 =?us-ascii?Q?+JpPp7vjvIvoVVbdlIPP16aBpsb1stv9YHmlR7/DR3MRDGxgVk12qJXQsD2/?=
 =?us-ascii?Q?CWuqKe3oo+5XoTV/f8cjaPyuBX4pWz9MGgMpMx5qJ9jNtl5ZYbYWF+P7jZyz?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17c45e5-b436-4785-55ca-08db2950a087
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:27.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +74SeKqbh0L0TDJ9RLXeJDg1LIhfANfCL41LHvqH/gX3uhg2BLv1+KnEuMR62ikOKqAErynGA/G6q4ApJFJtfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series updates the use of the bt_iso_qos structure,
which has been split into dedicated unicast and broadcast structures
as part of the Bluetooth kernel patch:
[PATCH] Split bt_iso_qos into dedicated structures.

This patch series depends on the Bluetooth kernel patch
[PATCH] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (8):
  btio: Use unicast structure for ISO QoS options
  client/player: Use unicast structure for ISO QoS options
  emulator/bthost: pass unicast QoS structure to bthost_set_cig_params
  lib: split bt_iso_qos into dedicated structures
  profiles/audio/bap: Use unicast structure for ISO QoS options
  tools/btiotest: Use unicast QoS structure for ISO io
  tools/isotest: Use dedicated ISO QoS options for unicast and broadcast
  tools/iso-tester: Use dedicated ISO QoS options for unicast and
    broadcast

 btio/btio.c          |  20 ++--
 client/player.c      |  16 +--
 emulator/bthost.c    |   3 +-
 emulator/bthost.h    |   3 +-
 lib/bluetooth.h      |  50 +++++---
 profiles/audio/bap.c |  13 ++-
 tools/btiotest.c     |   5 +-
 tools/iso-tester.c   | 270 ++++++++++++++++++++++++++++++++-----------
 tools/isotest.c      | 159 +++++++++++++++++++------
 9 files changed, 395 insertions(+), 144 deletions(-)


base-commit: 806230e4fda7a2fafeb7f1da3d2f17a1bafb25f8
-- 
2.34.1

