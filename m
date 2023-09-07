Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1255EC873D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjIGPm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbjIGPb7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712B198E
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvPSRpy4JDKYXv0XkyVVKaVpPl3TCMQNzb8BK2IRfmjp8xdGmgRRrH+JO9ADCWAKwgGWgfJksp7v+x7gRVwLbC0OmRn49/ETDTEbXxiZgrE9nZCPJoYj8HChYAQ9vgWWdIehKE1FfnC/Nxbrjnp0pYIFyTI4zA1yzgFWQOfXUvTD02ChkDhuKa4d567S1TKXB3xSU9bUQ1Z1Ob2mnJH7WUGXAj3BYrrcOawO2jcH6v9ChtN3x2YgJMMi/lK0Ak2Cn/DC6k3h2xvK/SN/8/KOcxM/LPjR20q7z2Ye5RBjm6OH0FXIPxeS1P2R2j/2oIbYlV3y80uYUG7YRHlQ2bEtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOsMwqbL1NP64qLKmI0jnf82HtEGaxZJqli8c/gmLcY=;
 b=JRIKaJVUIY0gV7O2/G9HZa/zgyyrMwc1ekzSKrSkbk0/PQ88a0S2+UIQa42eYrVlN6/bF7YpPgf95EzGMDfJr7IgO6VEkzTBiJ89aICB6+vdLyHpxHji62WKjwDqWfCVaRroJEbxq6Gse7u2Ki1xje1cH84N6t/WU078L8lzxycJfnrNoMQBQ/6Q/BGGbAx1T3O9JGkz5V+Ti4lSDEWapgQfcigB7qTHaaRAf12LfzdmKIloiXWt1/n1d4TxfLXwLO+WRXHWh79XkEC38JZzIBPvcy7iqMggBdTlfTWwtgLIwj47hjhgC+aH215aWZp851sTQ6rrqqtLc2hWrgOkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOsMwqbL1NP64qLKmI0jnf82HtEGaxZJqli8c/gmLcY=;
 b=NbQWmEWlGypYHDWy7SwO+gAhy5o5Of63EQ89vuZpqWyCljNDyRtY/h/1BKTbN/QSruKHnLcaRykqs2FNifkW1wINdzFPlpoBHBDkKSWZQxeUBMwUW21cSH7oMpT2G2tzxYV0tBV531omdk05t5eAmbiMvTjBEF55XcQwhmyjXEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 05:48:41 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 05:48:41 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Thu,  7 Sep 2023 08:47:58 +0300
Message-Id: <20230907054758.4893-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907054758.4893-1-claudia.rosu@nxp.com>
References: <20230907054758.4893-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ec089a-dcdb-4cb0-f46a-08dbaf661714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zC4dav+WLYSlYMxDhDawzF1nVdssZVaO37h6z84WCnP12PJMlL7f/nAxx0SeRda6H6lZ3VK5RRG9bpGL9tZUp6P1tUecevJOTzllN8iq5FGmdXV9SBxDafa9m1qn3km4DQ8wPwavqV7fMHa2vbCzDjP1p/Nsyl/GpFy/SesklcVU7OySipfqYrKTVQ2jHO4dZJTUgB3OkTlqxf26TAf4cnor5qVhhcUvQbBl2MKf48bWCGidTrQ+MOVq7SxAOn/BhNkuNfXHEItJG+K147Kr6WgyGMyrP85Uqfm20AMkF1R2wfED7wJGfumX95LfAx8L5yk+nHo2+xlq/a4QIKfpUxM5QOB3vXSpDJwF2otKmljYRMT/jutwB9AZBac9rsGnXPQQ24bRHRD+ljTj12/6rPKmbcg2H9dwo3TrXGIiAs4HQ5i3bM+1ArQAtK750EtBFtC7rFUL7VqcvcsKdwj1rQXNqKrkx/23H5M19coqmEbO6BEYuLIddGhfvvXNzisOD1zJGKwYXsTFS3Aw6d35e3jxMeKDdlWXDwbkuYLvPi4EoJGiqfzDo15/ewyOLWNm/jpe5lThUp6uoxHOs9vd8KNBn1MSXCPP+zduGM8iKMgVe4+AGE7+oSC55QMZZBgbOm45YqelyYIcEt3aRuSWs4Q78T7ZEr7q0QKrxdzvh3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(36756003)(316002)(38350700002)(2906002)(52116002)(41300700001)(86362001)(38100700002)(5660300002)(2616005)(8936002)(4326008)(8676002)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(6666004)(478600001)(66946007)(6916009)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZXs0x+cn6zS0oj5J3eOFfv1ndb0U8S7Inv9RiqEu5BgfeeWyBHdYSLP22co?=
 =?us-ascii?Q?Ppg1gu7k2ZVI6M64N047ICEluS8kRsmC0l5XmlM3T3A2/QFMwoYoz96dNkPA?=
 =?us-ascii?Q?/J/s6uZn0AcGSqIeg3feB13aV/vCg4eZY/9A4DgppyhF8rlYpxH6m85bK48D?=
 =?us-ascii?Q?e2YBQfazp+hYtm0ZVAuNVkVvQUzDYGjwiuFjMZPmCB/nBbNbERvnkufSGBR4?=
 =?us-ascii?Q?Wez6wuArLuqAsaWD/Dbou2H/t6tsSkjBOaeV9EqmRd4FWExYlz/A2Bm/PloL?=
 =?us-ascii?Q?oBk0w5h74Tj1bwvVHCGH3T8x9qW0uDHHFBS7kGyvQHAgqUEpGrq4Qe9g8C4q?=
 =?us-ascii?Q?EbK3lSqrQACXNok0Lf4lQSmWRCROBHIbTCSBlUS4Tux0SzOrf47EBs61HCd0?=
 =?us-ascii?Q?7SOsTFk/3FYbtlf5kuXKNfY3ELAkASB+41URtP0P/JHDJhvlPJa0lekOvemP?=
 =?us-ascii?Q?b50PJYgjG+L2ZcUMI1jt6J7pdPAH2pEjO8kIUQgK7gLYeCD5HiRYgh3dMQQ8?=
 =?us-ascii?Q?LIpJ92Db82c2G9lDUlaUGaOKKBLFObzcFc8CklC8KpvP+6Aw8KQ1RanFXqF8?=
 =?us-ascii?Q?836G7pqAjT2k+BWuLT4g6ZfDs0D38tqHeWc7hlf9FOrMgFowPVjpwl/FdWtM?=
 =?us-ascii?Q?QNTU9KxBZKccm6+U222jd7s+mh2MmkpUc7uv6s98v4+eZ9lCgbhRcOvrM2G8?=
 =?us-ascii?Q?iZYd7JWb7+rFNMBwS0yzkKklMU5rFNKvBOGFTjFBO6xYoBwCgHC363CjMQuM?=
 =?us-ascii?Q?3sRXcnNQgD6CsJmvku1yr5TmvCy2Fd2P4d6Pu4LAZzMt9rC7Txxg6GP/6Cp/?=
 =?us-ascii?Q?gia1qeOimU5OZEMMqf/n1Rw9MP70MIS0sgly+zdl5baoCEL5SCJUcqnoPqPw?=
 =?us-ascii?Q?vYirKbdoIP50uGG2HU9uCUf6+Koh4iV469Nu02pcRq75D36RANUi9t/ILNpm?=
 =?us-ascii?Q?+lhEggyg/urfOBOZyotk4bld7CnsWb03YruChKKsrEXLtixO1gFjx4k9ydWK?=
 =?us-ascii?Q?6s1EvHEooc1DYaMGSLFj6433jh7jPEbbd2dxolUbdhd8MWCipAISr0z+KVFt?=
 =?us-ascii?Q?Hk/vdUkHh8LakethjjobaEkNNBNkWdbk4xg1N6aRDzCBtYi2hgTuoeA8GNPh?=
 =?us-ascii?Q?F4D2G+D3Wut1RzPyG6b03wIYAqCRjZk1RC4JtYotw7vfyh0ejbkGCKdJE7Qg?=
 =?us-ascii?Q?rSR0RoeCrV9faNa5rpoVGWq0wXRrRNY6YhtzUX0hWa/lhu0N1OxadjRn/Tm7?=
 =?us-ascii?Q?WKy440Fj02kk5lpCK/el6Oo/1Y1XRRKw2Lc7JCDbA+rdiCWqwcfNnO++QlPq?=
 =?us-ascii?Q?iAd+yx9mK02O+YEKaMeZfstrfqd55nyDtewfOxArADcT24OLerhu29455qZr?=
 =?us-ascii?Q?aqDkvuwrJe8+LwIiY5vzNnikoPYGa1FTyxAZQ2IAbNOFoe34yJbirWPiRG1f?=
 =?us-ascii?Q?gegpTjeJkEVe5L9hIC72kgYy4klDmqrSUi+BtV71d3Vx4LlMwBwv5+cPDESE?=
 =?us-ascii?Q?jOHv19zqGL9HUeVY+sGwPWLnszU4Kh7m/S+4Ygd6Y4wMhDu7VrgsyTe7RHSn?=
 =?us-ascii?Q?RJemxzTrXxb3IA+HHyZ1psmqwPz0OCduMXG22JLy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ec089a-dcdb-4cb0-f46a-08dbaf661714
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 05:48:41.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8MsQs0QTf210R7lLtRekNq8qGN4fnzfY+x6Mo+oOp+ElcSsBOvm8YcIJmTgjit8b4P2zRfqxtStP8+lIGj4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 net/bluetooth/iso.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 16da946f5881..33ce9df7f65d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
+#include "eir.h"
 
 static const struct proto_ops iso_sock_ops;
 
@@ -47,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1458,7 +1460,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		len = min_t(unsigned int, len, base_len);
 		if (copy_to_user(optval, base, len))
 			err = -EFAULT;
-
+		*optlen = len;
 		break;
 
 	default:
@@ -1648,7 +1650,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (ev2 && !ev2->status) {
-			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1771,13 +1772,20 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base) {
+			if (sk) {
+				memcpy(iso_pi(sk)->base, base, base_len);
+				iso_pi(sk)->base_len = base_len;
+			}
 		}
+
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
 	}
-- 
2.34.1

