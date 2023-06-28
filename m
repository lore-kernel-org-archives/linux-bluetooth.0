Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846BEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjF1PF0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:05:26 -0400
Received: from mail-he1eur04on2043.outbound.protection.outlook.com ([40.107.7.43]:6054
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230073AbjF1PFZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcxz7mH3l6KeTDpbvLz/F1GcZewKp8NXqXP18nSOxExFvrsglNZLFHVjrBjLaQBwcn8uKATzg3jTImz4EEG9ZlUgEz2esRIZ0vCTtwALI+l0fga4Y/KKg49a0vIiqUdpa9g4sQXPjooHPonIOyGi6Tnks4Ig4eyHWDC+mG2jrmdOXqBgzGvZN1XloQFSGTYQSJNTnItDanIw+JDjo3jjAe1uSEK19YZSpJrblKNLeAs9h4ERywIHv4FDipQewWwHnyXXIwcbkoR7bFPGzLNvVkxYTtHKocx1svNoR0ouZuvepjjbGyhuOj3tyzIVfJpwoAFyfgKmhOv1F1hzDw46+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bHsjgkKlOvR0H18TJEoxoRCHQVuB44HpxlKadxq2/E=;
 b=h8f2WbRpRlEgLOn2ryCKqZuiIZc3H65FZc1/XhhSlTQiIj2MewUpR0UuBc7CObBtXZ3JV4xkQ7c0hmJFhXjJ+ztSH6wG6QffNFC+ESlJLdWJ1YX5Xc0MJo4g2mjO/zutPKAb9LhXtXwl61htfQc4mGD3OGFXtdRdy5MHSnJKtpMwaWlpPI5+LC+4nK6+UliJOO8TlzD+ZFBZzNfMZSs/G3nAPww1P+enTsPMaeW/aQwH+ydN8kBImoVLkVzKcDnVJvtzL39iQS8zYf2XTXk64FuC8UiiuxKp4dUvFWiy8+sUGx2wCsl4I5CdWdxJNQL3vA7dA/0Cmrol2SHLbYdrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bHsjgkKlOvR0H18TJEoxoRCHQVuB44HpxlKadxq2/E=;
 b=oEb5TRXtHJkMlsPyDuAcz/1rmDpHFq5DdxB+WXdcq+2lxwds0soswmQVvifLzCf8yTj3CSgDs+QKCC6iVh1imF+XmUd8a2gOENJ6L9GxnseD8Bnm7/l37i8yFGVEa9gIjgjh6ZVNcYzzCtdbnSB7eHmJ89KyN0vcacMzNoU72KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:05:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:05:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Wed, 28 Jun 2023 18:02:31 +0300
Message-Id: <20230628150232.239778-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0060.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350f372-44c3-4873-2d8e-08db77e91836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hl3cR6Gcx7MJeqJTJhn6QIMGlJfvriWPnawYMNUsCOgponmGv72P8N7jc1delOdsAvHZz8duz6yc0VqsO+MJQITUY7GVgjqmgys34vncIYvxWPEuNVHYzO7DfaWvnw2sHap6GcI/ASVVUXcaf1tyPYRv+3fqoJAaSs0AFEh5bWBriUvdSQbwgTSK/J50u2rH0a7sZQ/XipyRLESBwpbj5iFw65S7zG6rCLcVEzW0WSm3dafpMPDexF0ZxDMx1w5wWRQxEUHF4xOVg7pXIPKDr1M3ER89B9xR3ESzpP2Y1UgpFx59LT/fEQeC26t3TWcSXkRJazD2ltR5CG85ogLWCHVZT1Juau+rJNsJhp43J4MrZMN0RrM6uB/jqT0k0LvqiZnAu6FPhNRHctINS7OkxWrmlW+KJAut95SfbSgzuAyWvREnVZGhh42ZoVf3s+YQK/onjx7xZAwyE+J/yORnqzqQj4uW5ZGc+kxvOlkC7fUlC6yLry2Fq6uYhXu/zL0Gm42Bz1kdOmwQHM8zKhg5zT7uOGAy/rmir0wWQoF+eHjHKhtHP0TSIiLnEVrB+qw9IamFaenFCwdUn3g5NmrCWqRtPP8PxKW+nDmpWDu9BeMcR6Hq//jZEcaRxkqeHpXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(26005)(36756003)(44832011)(86362001)(41300700001)(6916009)(66556008)(38350700002)(4326008)(66946007)(66476007)(8936002)(316002)(38100700002)(8676002)(5660300002)(6506007)(6486002)(186003)(83380400001)(1076003)(6666004)(2906002)(52116002)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9seXrhthXRLgLXhqw16yE7Uzmz04QGaBoA9vK6tvqm5SWogLJTrSDEB5fst?=
 =?us-ascii?Q?wpsfw8EDzXkClhdXsVQBQ6QTm08g/T99KEybTv//vqEG+T8xl6XD+r9qGWng?=
 =?us-ascii?Q?EKh1brOHl4AQa8Eeukvulm2I1l/yUt6wEj3zsX81zg5dTzP5vm6BUpnEfZmY?=
 =?us-ascii?Q?1ElYg+YrUzphn+fxsM80RlhBCKsjYN8PP52NwEa/6DscmrZHxZRcmnpaGN3H?=
 =?us-ascii?Q?KIa2zpP+0j/KxqtleWmdrf5ugQViFWF8Okx7adcvdL5A5Opu15TJsf8FGbsj?=
 =?us-ascii?Q?KA+yNvl1kGkkqr7R4QKtckrGNyv0t/V2dI3yxvMVTXU5Bl+3QnWQhLkFk30B?=
 =?us-ascii?Q?ERR8LaYXzgXjjBd0ByoQ0hAntfC1nrWydtas7OI2leoGw/ZAo9nv8rVwUXeV?=
 =?us-ascii?Q?u0/nipIeSKBiJVZheVAc5Sfo6HYCey0LjQ1Boj0CvcIOWxdkNOz9NBsu/utr?=
 =?us-ascii?Q?d5hAMarR7L/GL0Un1xbLi5tZ9GfSSTCYGVbq9P5eiKiHxKMrLvaulXHxkFVz?=
 =?us-ascii?Q?s974u6Krk1FNbKktukXI6TBTAZFitiwJxqgV7P43AbQ79Kk9pZtUEspEhwVq?=
 =?us-ascii?Q?tR0dZQ7qk1Ny5HOqoHgYCOniIn2iWHYQWXuo7JQhJlTxiTNihlYEmbFSua02?=
 =?us-ascii?Q?7ck3GqK4TeOx2CqLP32729ZbjvEUUV3+n86BvM7HaCrKsTe8VZAdg2yDjLIQ?=
 =?us-ascii?Q?vn5OhQmqmnMbNl0W3k6I+tZlIk05hFGkkbreCR5ZRK9SfckWb0KwSA64Bt5B?=
 =?us-ascii?Q?4STc1spNLSGgiNYOglsI/iFuWNZHiDymhJfXHewZMj5OCZFZl90utLEXwxy0?=
 =?us-ascii?Q?pPFwilzRa5adWIT02tJM048g9yLkoR/AvyVdyRvK6T0FZVEDf+CkDEX1+Y6i?=
 =?us-ascii?Q?87dFu82t/rgslaNsbjifMfNAbkV1QfNFAnLXIL2/6D+XsYGjVD4eJ1Nyhx9a?=
 =?us-ascii?Q?sFHjhDNZdFLuAvBn08RGaDDvnnjk3LqA7ZG8nftfVpdsQg5D7Xftg0adYcxQ?=
 =?us-ascii?Q?b2BTO8pDfrPpZ6q4V1imQ1UE3a+NHmAAVnV7I/IjZ5JhjNhi4HsA7ej/qEZF?=
 =?us-ascii?Q?DgQ4uoenDN9U9j7kK0CMF8/wAM49X1RPud8XM9E7J4V87q1oPpewGoZjqs1J?=
 =?us-ascii?Q?C2CabulQ0Zb4jNKE64PdOHpmkMoyYtbzH2sqgTPESx6HquV4hpz5JNYp4jJZ?=
 =?us-ascii?Q?Po0x76zQebH4LcO4W7NuZ4/hVIe0PL2Bkwlnigvr0eXZh6+wOgnP/snVH+S0?=
 =?us-ascii?Q?b93nbeJowW0YUDrqehOU8Rf2503wpS7YCcC3xLWaXBvEhbUC9pos9rLADnPI?=
 =?us-ascii?Q?Qx+YJCGn2NH0b+VWEoGJVkGVuMxhqMbxv+Q18TZWq1OqoQ4D9wpAw556t7+J?=
 =?us-ascii?Q?+NpL2NnA6T3d64XuNNY+7hLIPaF32j/NkBoan/gSspuJSNHYH2oV/8HaRQU6?=
 =?us-ascii?Q?R+uQ5uwCxiZ10JEiyiG3EuhKVY0o/BxZt46YK+wKLHphTcs0RJ8U5wXufSYF?=
 =?us-ascii?Q?YKgXTxoc6XcI6OstuUcChVhaHLyo4wlThgdcuv/Wv/5lroKcDNWgAjxJUe89?=
 =?us-ascii?Q?YCRnav0VJLbB/szdFNgit0eLXh35uX6oT5c2GXHHdG49kFaPxsAHxfC8w3kX?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350f372-44c3-4873-2d8e-08db77e91836
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:05:22.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpvEBc3LwFwaREUcS5tblb9rvVXrGk7/5Qx5fhNfSa+X3AVZ4ws/ljYqiUfcIV5nj7VBhaZ6KgMkSYg8OH7SVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch makes it possible for the user to be informed if BIG sync
has failed.

There are situations when certain procedures must be started in this
case, like it is, for example, when a BASS Server fails to synchronize
to a Broadcast source, as a result of a BASS Client writing the
Add Source opcode to the control point characteristic. The BASS server
should be able to detect if the sync was unsuccessful and it should
send an appropriate GATT notification to the BASS client.

Currently, only successful bis connections are notified to the user,
using the listen and accept socket procedures. This patch proposes
an implementation so that unsuccessful bis connections are also added
in the accept list of a listening socket. The connection error is
marked by setting the sk_err field and generating POLLERR on the child
socket. This way, the user can detect if an incoming connection is
successful or not.

From the previous patch version, the BT_BIG_SYNC_FAILED state has
been replaced with the HCI_CONN_BIG_SYNC_FAILED flag.

The le_bis_cleanup work has also been removed, to avoid potential
issues. Instead, failed bis connections are simply cleaned up by
removing them from the hash list and calling the bis cleanup callback.

Iulia Tanasescu (1):
  Bluetooth: ISO: Notify user space about failed bis connections

 include/net/bluetooth/hci_core.h | 25 ++++++++++++++++
 net/bluetooth/hci_conn.c         | 50 +++++++++++++++++---------------
 net/bluetooth/hci_event.c        | 21 +++++++++++---
 net/bluetooth/iso.c              | 37 ++++++++++++++++-------
 4 files changed, 95 insertions(+), 38 deletions(-)


base-commit: e63d8ed98082395ca509163f386f5b04f53872b3
-- 
2.34.1

