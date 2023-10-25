Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E8C07545
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 14:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjJYOyX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjJYOyW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 10:54:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ECA189
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 07:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WivckbYD6MTpOQHclATkV4nObPXHTzQ29J7q22XEWS+6xAMyyRzbnJa4gisHfjmNxxcpMcHCB+ZrYdEcLqQ6rVKlpWCf/0caEA4TpD3wTSqdAG9xs4vfcHzE+fssB+5ZMVbw+oo3QWrab0O6dAETMAbqjwLllpxs3GhLvLG545i7CSUcQY1RFCt4TrJBl9VWGxNj+DxOh1EOJHMr80yJPf1T1HmeojD5IHWSSK7jlZTWGt8bUBZYrYgaazlsrxEVd2xDM3b56HmgOw7gzSAVVoGaGAH0elZWm2WH8GDNLbOaaRcxQ4Ke9uJzJsTA3BVzzYo+Og1QfdJWpjl7dX8WCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJpU9bfiDUD4ZV4NsAi3KH2NwzwlzYu6WlrUSte6VNU=;
 b=lCjGaoN0o8E0rjHa8pm3xHyxr73HyIo+R8V6iqI6GkMIrYlGTNKD/72TRIs4oIEfUvymqM367pse3y67y1gVc/RCQtDvmRg0JEH4pLE55uEzMfNl9gLTYvTDKNr6LzCwPOZUaAP2Gb1ZDwJ5q0pROPx/+wjUVGD1MSUXUtRbEELnmVMSALHzfRyQ1+6f2+d4tu3PCQgH1gZ19XN4y5wEkkKFZ/pkVVCdbEt53glq/Pe1qTNAMcN/JTA4R8aFd2uuA89tEw1e5dtjkjJMiIfzRNd+U/1RiHNsYjRboZEyjXrGgE/6+SgU5v8PIO60m/3xrIj57BCe1iPr7I0OsjebAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJpU9bfiDUD4ZV4NsAi3KH2NwzwlzYu6WlrUSte6VNU=;
 b=PmXHVbnHv6d7jzEyLO711NCkMtQu8Nh73qehDZ1fRh+cHG/rZRa3TZ+Z/2hN9Ggw2cbR0uY+uVIQjSk28+uzQMpm8RH2PmxYVm9BPnoxuOxP5/qVcsoWUIePNv/UUyYRXxj4m6t29QZsppeX3HfowOcDWxikzt7Z1/kb913UeNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 14:54:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 14:54:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bass: Move io handling out of src/shared
Date:   Wed, 25 Oct 2023 17:54:10 +0300
Message-Id: <20231025145411.2923-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:802:2::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: d56af5b5-f032-4862-acbb-08dbd56a4308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8On0qZ4RkLcVVD4OTq9H4p123gQlw9eE0V6DrqsvD8gtQI+XmfKJ09Pg05HiQUPKKUuR5P3LchIuf5pzB6xpyHq+V0yEGu9JHCisp4j4iX3pkmOw34jU49/iNAH+dmh7l4yzq/fJeQxSovUygnarvB9IgDUJHpgWvuF3nd5Fe3tLna2uru1l54M3fdur2p/OApofy2Rg2QrU1GmhjCxVUgqZdZF+bnCcIO5sZ+3NSJ5FtOoySMwKDXF0Vn5HJvtkkE1ChmGQTvv5wUsxrtK6kTYZ7d37UZvAX7nhJ/FwqPFfdR2h3JN8s1JgVf2+SSKTqj+OYt+1/2g+H0e588s6sTBJpfct6lgpcCqR/pY9rB48C47EmVhGhw+qPJhaeK3pxvJno4QVeya9hQXQbrZ96IQGA5jTKpovHd/Elb9PouHHMuFI6BGuUk8gF6r5bpc2amoN8bBUGx0AYYoZ0W9TQQQKFG6DShkk4QMlompej0kkAHZgfsRe29R7c3Qtqz547mUaJB/3WGuWhrMO1JHs7DLwUAbOeJxt8vKRQy9KJIYgHTulQg8T2LmJcfTNZ50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6916009)(4744005)(2906002)(5660300002)(4326008)(44832011)(36756003)(8676002)(8936002)(66476007)(41300700001)(66556008)(38100700002)(86362001)(478600001)(66946007)(6506007)(6512007)(6486002)(2616005)(316002)(26005)(1076003)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7w2ga/hnvnMVhMVF0tr9tJURZ9pccrLzergEfv+O7o0E/w4PLV3R8kpbzHhW?=
 =?us-ascii?Q?261Ql5yMpFjZ02BuOgmn+zB2NxgP6DVHgcDjNpURwhHzihdQ+tA5zEt/F263?=
 =?us-ascii?Q?CGnbLXcykEpDqNSrJTr74DB9wXgwU50qAjO0zzjbnPRGDkxuFymEjshgtrH/?=
 =?us-ascii?Q?J0qezUPoO0H7Ezv4ByMboyqOsOYFbhuawSbMrq0wWr7LfUphF08wD+x7TTKW?=
 =?us-ascii?Q?BV8z5u43wMY62lSTsgIt7lZssd5CJn+KJTQP7/4MaLBeGhNOMVFEEu1JzMwT?=
 =?us-ascii?Q?96TXBJNuSoIqpejbWchI57VgKligxFqh3R9KvMaIrv4XesCNhBOiIleAVKVs?=
 =?us-ascii?Q?mnVC4OOqW7362K3hEfX/Bj/i98H98Ho3uHZoT0aKvIomqcA7XwKZwywBZ0za?=
 =?us-ascii?Q?E0q0G8nd7dnH+ODU8Fca35JeLb4m1homHPXexqEKmYuAWuUfiUTB7LsdIgr2?=
 =?us-ascii?Q?jq49zT1Sa0hojj6DsKouOIkgFJhoqgHSJmjYagcJ8V1HBBgIjCHubqA0xGt0?=
 =?us-ascii?Q?m7L1HpWDCzzIXaGIhF1YXNqqtVUvV15+Klyc0WTswo0K635ZsLtPRQF6xYiV?=
 =?us-ascii?Q?eKP0TVN5Jg6WhQFkijrF/cmC7N3kScGqB0yQzLHdmtxjFUjrPEhCzxU9s8XX?=
 =?us-ascii?Q?B9SjZ2s5lKWkrfxBAihnhwerWjRE2jK1dJ3qhxpbMYibZU20MggAIg/NVjFg?=
 =?us-ascii?Q?N3g22ij8lBUQesblo/LDmAueH0bnUEgNB3WjODyPRaGFWUM/kY1g4iyhX+WR?=
 =?us-ascii?Q?Gyue3wdnAVTsCLQDeKpaj/0yndG2U/lKOnRIacf9XHwFbtIoit4sWdHK5w/x?=
 =?us-ascii?Q?qdsZaDFh+kqC+/5BcgXX1X0aWUmdomNZaY2tDDAkWrXIfVUXdLLEt8GQikrY?=
 =?us-ascii?Q?SknUCsUFq6fptpxGjlGOx00gaM7oRozps/+LScVqVg3LufdO6yAPNauUhbbM?=
 =?us-ascii?Q?mexp+qSNUBPclUh2xWMnIwS3i5SxrtUaepKM7gl0y/DmoV0/lrDd4Np0NVHD?=
 =?us-ascii?Q?cfB/snvdowc6Qfy8U2JpzItJN7KkKbRsf8vYJpuPBt/EBsL3PjF/2o7scVhy?=
 =?us-ascii?Q?ORoKxJ3tMqBpXlrezAOecuGgJkiaboSzTg/rj5k7NkTmmDt/EdiK6QDPdNxE?=
 =?us-ascii?Q?wL//6A9nJWhHaAN+bbGiekAdsz2GydQPHBWm6r8jLU1n3BAgXHlZOnfBFyIO?=
 =?us-ascii?Q?zvjwDus0I1SxGbb0xvL/2Cbr3TKMW6FMcZ7Z1r9dnVCF71vo9NTPF6d4WMJq?=
 =?us-ascii?Q?YTaQ0v42HFQKIgircoSMkaMCdGLxz4UiG/oiWN3RBOvvfUz7owmv4XT9EUKl?=
 =?us-ascii?Q?t/juE6MHf5sO+eYoSD6iGcy4B2413GZLIkS9XcgmJPctYUHd997yAwN91Y6v?=
 =?us-ascii?Q?H879nxgm5yPgb/+O3+HAySvNoArG7IIlGEtOmL3mdi5k48Jofxgld7Zsy5nB?=
 =?us-ascii?Q?JxcFL8GpYGSyhtnUzoRSpypMkpcJOwi/szYFPDT5fxOl0Z0EJKHKqE+N2ajC?=
 =?us-ascii?Q?MZcNmU7LufM0tCHB1Tef7hVQQUtLGOnBTo0MTD6pVCofMWlHAl6q4OiuuAF9?=
 =?us-ascii?Q?cgmJvBlxwFUXVdycqj2bRvN1HAUuLslC0qxprQBIOqXzEeBf7/ABVXNvjeLf?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56af5b5-f032-4862-acbb-08dbd56a4308
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:54:17.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwjOxM0YIKD7QzgVAwgXaAloDfI+6k++I6VknWP9WmwXKFnD4W6AWpzedNA4knXr8yllMSnzhcfXWn5oIO+iTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch moves IO handling from src/shared/bass.c to
profiles/audio/bass.c

The profiles/audio module registers io callbacks for listen and
accept with src/shared. These callbacks will be used to perform
PA/BIG sync and they will notify the result back to src/shared.

Iulia Tanasescu (1):
  bass: Move io handling out of src/shared

 profiles/audio/bass.c | 397 ++++++++++++++++++++++++++++++++++++++
 src/shared/bass.c     | 435 ++++++++++++++++--------------------------
 src/shared/bass.h     |  23 ++-
 3 files changed, 583 insertions(+), 272 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

