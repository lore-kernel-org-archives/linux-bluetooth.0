Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F683C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjCaPj7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjCaPjx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 11:39:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A642033A
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 08:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcdBt7bOnHNyqxWoDm6gRM7SA1QsBqekN+sRPjKJUm4tlhTiiUdVOxo3ojpX5R98xuX9gDfwalrib3RwT5NoD5Lds4QR3EE10nVBC+cZHxWY6NT8JZ5bZU6SJouIaLRvfwKdd5D8NZtrV9PvL93MlTliBHHnd11AbyhNKBzL+EiTUOPO1OWFlg8xvcBf+IwYMUaBTlP1jXJZgQ+9dRIwNKT068C0PSZr6vuVuWHDzIPoXnk2xI+HahdCjhpAY/lxi4ic8SS0ZlC5Wp4NwGSv9mnlPuSiKXLQFmAA8sSovThBe2L43oFruXjUN3RbZ3uMezc8P9qdlDwOsIqoiWBIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOprMKaou2mzzOnocLcGg9DalcmeauoHH0HVgUr7a28=;
 b=UR9lLwsG/wosp1VfCZ7HS2VFfZmCHZzBu6DUdjpcA6GtQBYpG3/PRNdSN2dklfJIVlPyZQfeAPX66+jTc5/PPtwwZrpiaC8JitsHCExYzTr1i+8UgUoPONfF9xbKkfOQpDM5Eb9t6lcyHQd32CyveQvAonuSTCeN3M5uGZej93F0h7Uf2O9qyWgdH3dVsKwMk20AhLUkJjvjUN9obL7uHVKeKMxRo7FnpIks0P+fpjqlrTcv+wN7b2MrPXbsL0mf13oVsOGZgijniFxUWBX87xJDHpKIOtUgavhvAT7s/i35vTrct1+vvXR+3gytIKqmfZjLmFjBWRBuWcnIDbY+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOprMKaou2mzzOnocLcGg9DalcmeauoHH0HVgUr7a28=;
 b=XqToAoM6CT/Kx6vf3XyJZMzs8nkaCGKJyia47uH+VTciFpI85Dhkb0BlQSGZ5j2BBG2narDEHiL7YUHWv8GWhvNHrFXVR3FtfUYHp5OTraGccW4bKtOsgr5sRh5pVg5sXvt0BbrVx2xMJ7AS3+yvt3HE5KnIG1fNBqOmKrAU2xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 15:39:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:39:45 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v3 1/1] Split bt_iso_qos into dedicated structures
Date:   Fri, 31 Mar 2023 18:39:27 +0300
Message-Id: <20230331153927.35411-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331153927.35411-1-iulia.tanasescu@nxp.com>
References: <20230331153927.35411-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: d006a803-f361-4473-6c2f-08db31fe273c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J9T2jRtbs/PIe4NdpPx02+IfHRbmBqKtDBIlB7g+9VDWQTAe27UR+NIKYROrpu73EYa8ra9VKnRyMGGTqepjmZz7K9n8pPJbYc0yXLw7H2DMBvdswBtsRYs75NTPycbQBiCudYv+aW9r+Elu7zaQkFZ9pNWUMxVjv4kGRp1+0nFWuX2yx5Nq2FblMz1eUPDHB/PyWiDXMX2XYBQz8Qexk7IKGsuuUgtgyMZ+YfPXDTM0x4pubvJMghVBIpV/WiMxFMQ5IcwXfiCQzzUGRthSNb7V+QnqS5csf+ZxUQFC39QiHwAe9tqMBzmy77SkRq9QfTT7WOguZcsCOduhWn0xv4Hiw3ez3B/X1xQCv/QTc/3VRaviW71Wtzz4kfmL/8AUj3u6FIpZcS6xi5F+JTjJOW+QBV6Pjn6Wg0OOeLE0fn/uzxYdyoWrrOVTrbfvw2WHnepQSMLTKYtN6Cu38MxrovPUTCT8m4LyHobprQPTBEoQpnClZtbEEXVXAnoc20hOmffsLcWmp8k/Tw5qoR1xhIwTwbLekcNET4y9yfL1FPDsSBcF4k1VHOQBK6G4Y8QBgk2weghqmTT+LwR09kwV0WFKPsMIuqD666yTBAnwEwlHvHj8/FZQQCOab6qTFVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(2616005)(52116002)(6486002)(6512007)(26005)(36756003)(478600001)(6506007)(1076003)(55236004)(186003)(6666004)(41300700001)(6916009)(66476007)(66556008)(4326008)(8676002)(44832011)(5660300002)(38100700002)(8936002)(30864003)(316002)(83380400001)(86362001)(66946007)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJ1Y13Lh9+T8jSMgvKHoAp8kKb+K4873ewlWgjcnKA3wEQTRYIXvisBtDAYV?=
 =?us-ascii?Q?ObuT6QSuoZEoGUIhszM9FT/2H6hV1eOKEMXi2oKNolxTOyjOrYMSyNluxUvu?=
 =?us-ascii?Q?bFX9QCxLo551nvtUuDu1fr5ByafXj6yEroj1iu4ZPqw9HqhXg47iTNDhbOL5?=
 =?us-ascii?Q?VxIDyDXRpzxkpio3NeX/ltRQkLsOZhDH04/jnkneXIxXnguKmfya0czJp4wu?=
 =?us-ascii?Q?8+9kmY/mIjn2NkY1/HfYkkIy3gyog75GhnDtLKPdg7CVqo2o6pY3Iraeos2f?=
 =?us-ascii?Q?i3mjy9laOxBb7msMgZ06dT/0RG2LTzCFLooqJ0ZMqgTzu9m/xydYawUrsWRQ?=
 =?us-ascii?Q?5LPqraC6K3eMqtSmZ2IWCsZBVDfzgunKhChZckZhfMJo9myMkKz2XXTuDnER?=
 =?us-ascii?Q?gxzz/iHhVTXMkMzvLFJD2RcVdhISzJQkY2gUZbLYEgaRkXp2/Uuo9hgZD4n1?=
 =?us-ascii?Q?9HLu/rFBRCbcTyd0Q29+Q3vOB2euEwdy6S7M31/akYXAVar4ye4mXEWJwQiW?=
 =?us-ascii?Q?L/br722cKpSoPKcBjEttjvSx8RcWo0xyUu5TpZ4dtWpwSI9n7xFFnUFM5+rR?=
 =?us-ascii?Q?jnV+MMM9CxtOZ38l2G+TvV9cs1hDkiFZvCz6ujegc8FEZWVVSwC16i1iBkIz?=
 =?us-ascii?Q?Qaj7EZKSYDzQVtyf6fRXP32JT+IhfV4bvZaApHGCztTLW50vGs8/U3ZTpZF+?=
 =?us-ascii?Q?sbrPOgMeHAsJZLjw6RtAFas1oGQ5jezXTt6Bf38ICKO17f8PznbETLlEEyzt?=
 =?us-ascii?Q?zmF2rRpotVmShiq8qc5LI+ByY2salcd0e03TWfQ/G86xypM86n6tkdx0EewR?=
 =?us-ascii?Q?cz7DYt+VaZMqrWTouDphkBuDunuKPOO5piiszdpLSRgRfc3wj5wSMMOwdVtp?=
 =?us-ascii?Q?37sUQJ+ITegtFWUCnff/8otg84D13wTiV8ykjGi/41eU3UODuGlXwHRAM6su?=
 =?us-ascii?Q?ClGDSzq6HNXAnWN+PBoAz/vr75+9Km7k3sP3lT71ndpCo7K/KDX2p/BxqkHS?=
 =?us-ascii?Q?e4gAe/F/GxbSva7iP/vlwhcVhhhTsaw/P2iAcDDgAx+CqpsuwnGSXiQKKgrK?=
 =?us-ascii?Q?dhquP7UvIuTU0kOQe2V7Ik8TPNwWmOO9U+LAesu5ysR0EX+thEmWKWBaz23n?=
 =?us-ascii?Q?0lomjvFlAsp7G2OtArx/A2dmyTragdsPTyWeQhU7GwgVGTJoQIqAMFNRtYuS?=
 =?us-ascii?Q?wdStWaC7Xr59L817zC18MCTAbnJ1ET6aJnkjM7msDbMxNU7orVXzr18c9QqF?=
 =?us-ascii?Q?m05Lfw/NTSSITttHrUcyDW3Fkn9vaTND/0yqGXLA0s+/WU1WidAfPLt3VN2N?=
 =?us-ascii?Q?AxwiW1RzTXEGNYBDFiY1kQ/6hKT9iHMTdEMvPBYDj72L6zOyMXd0Pw77CcOO?=
 =?us-ascii?Q?MM5NeG2pSF4zyBUagiSBK26WSnNtjDwEnyu/FDzypK7cdJn4Z4Yug6u2FL4+?=
 =?us-ascii?Q?8mwDV0T8By5jtImklfTg2XzJDjWygvJDnHVlSJ49PZPu71A4QEwB9uc/VxRm?=
 =?us-ascii?Q?FNtNfR4x1jJMD8mjbYWY9Lz3smd69VUQsHHmH0wUBpBerSiW5VKl5cLNbepO?=
 =?us-ascii?Q?4yoGLBFpw09JbKh2tHmPM3fYjvv/DJeO7ePDPspWksxc1HMK+oRG5fidv1k4?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d006a803-f361-4473-6c2f-08db31fe273c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:39:45.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PYxfvraJHyn7HAnJfz6leHiV5Sw500yReEQUsJZ/tA6y0PEOjHCLCbn7Ss4fADC2ej59JWlw4XRUWmWjyX9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Split bt_iso_qos into dedicated unicast and broadcast
structures and add additional broadcast parameters.

---
 btio/btio.c          |   7 +-
 client/player.c      |   7 +-
 emulator/bthost.c    |  31 ++++---
 lib/bluetooth.h      |  46 +++++++---
 profiles/audio/bap.c |  19 +++--
 tools/btiotest.c     |  17 ++--
 tools/iso-tester.c   | 199 +++++++++++++++++++++++++++++++++++++------
 tools/isotest.c      | 157 +++++++++++++++++++++++-----------
 8 files changed, 359 insertions(+), 124 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 1ad42728d..6f6d76dc8 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -1608,13 +1609,13 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			*(va_arg(args, uint8_t *)) = dst.iso_bdaddr_type;
 			break;
 		case BT_IO_OPT_MTU:
-			*(va_arg(args, uint16_t *)) = qos.out.sdu;
+			*(va_arg(args, uint16_t *)) = qos.ucast.out.sdu;
 			break;
 		case BT_IO_OPT_IMTU:
-			*(va_arg(args, uint16_t *)) = qos.in.sdu;
+			*(va_arg(args, uint16_t *)) = qos.ucast.in.sdu;
 			break;
 		case BT_IO_OPT_OMTU:
-			*(va_arg(args, uint16_t *)) = qos.out.sdu;
+			*(va_arg(args, uint16_t *)) = qos.ucast.out.sdu;
 			break;
 		case BT_IO_OPT_PHY:
 			if (get_phy(sock, &phy) < 0) {
diff --git a/client/player.c b/client/player.c
index 63e11db09..5572cc566 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -3534,7 +3535,7 @@ static bool transport_timer_read(struct io *io, void *user_data)
 	}
 
 	/* num of packets = latency (ms) / interval (us) */
-	num = (qos.out.latency * 1000 / qos.out.interval);
+	num = (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
 
 	ret = transport_send_seq(transport, transport->fd, num);
 	if (ret < 0) {
@@ -3570,8 +3571,8 @@ static int transport_send(struct transport *transport, int fd,
 		return -errno;
 
 	memset(&ts, 0, sizeof(ts));
-	ts.it_value.tv_nsec = qos->out.latency * 1000000;
-	ts.it_interval.tv_nsec = qos->out.latency * 1000000;
+	ts.it_value.tv_nsec = qos->ucast.out.latency * 1000000;
+	ts.it_interval.tv_nsec = qos->ucast.out.latency * 1000000;
 
 	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
 		return -errno;
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 4671fe17d..8cdfa0c06 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -3178,22 +3179,24 @@ void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
 	cp = malloc(sizeof(*cp) + sizeof(*cp->cis));
 	memset(cp, 0, sizeof(*cp) + sizeof(*cp->cis));
 	cp->cig_id = cig_id;
-	put_le24(qos->in.interval ? qos->in.interval : qos->out.interval,
-							cp->c_interval);
-	put_le24(qos->out.interval ? qos->out.interval : qos->in.interval,
-							cp->p_interval);
-	cp->c_latency = cpu_to_le16(qos->in.latency ? qos->in.latency :
-							qos->out.latency);
-	cp->p_latency = cpu_to_le16(qos->out.latency ? qos->out.latency :
-							qos->in.latency);
+	put_le24(qos->ucast.in.interval ? qos->ucast.in.interval :
+				qos->ucast.out.interval, cp->c_interval);
+	put_le24(qos->ucast.out.interval ? qos->ucast.out.interval :
+				qos->ucast.in.interval, cp->p_interval);
+	cp->c_latency = cpu_to_le16(qos->ucast.in.latency ?
+				qos->ucast.in.latency : qos->ucast.out.latency);
+	cp->p_latency = cpu_to_le16(qos->ucast.out.latency ?
+				qos->ucast.out.latency : qos->ucast.in.latency);
 	cp->num_cis = 0x01;
 	cp->cis[0].cis_id = cis_id;
-	cp->cis[0].c_sdu = qos->in.sdu;
-	cp->cis[0].p_sdu = qos->out.sdu;
-	cp->cis[0].c_phy = qos->in.phy ? qos->in.phy : qos->out.phy;
-	cp->cis[0].p_phy = qos->out.phy ? qos->out.phy : qos->in.phy;
-	cp->cis[0].c_rtn = qos->in.rtn;
-	cp->cis[0].p_rtn = qos->out.rtn;
+	cp->cis[0].c_sdu = qos->ucast.in.sdu;
+	cp->cis[0].p_sdu = qos->ucast.out.sdu;
+	cp->cis[0].c_phy = qos->ucast.in.phy ? qos->ucast.in.phy :
+							qos->ucast.out.phy;
+	cp->cis[0].p_phy = qos->ucast.out.phy ? qos->ucast.out.phy :
+							qos->ucast.in.phy;
+	cp->cis[0].c_rtn = qos->ucast.in.rtn;
+	cp->cis[0].p_rtn = qos->ucast.out.rtn;
 
 	send_command(bthost, BT_HCI_CMD_LE_SET_CIG_PARAMS, cp,
 				sizeof(*cp) + sizeof(*cp->cis));
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index af5fbcfbc..b4bb6748f 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -6,6 +6,7 @@
  *  Copyright (C) 2000-2001  Qualcomm Incorporated
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -146,6 +147,9 @@ struct bt_voice {
 #define BT_ISO_QOS_CIG_UNSET	0xff
 #define BT_ISO_QOS_CIS_UNSET	0xff
 
+#define BT_ISO_QOS_BIG_UNSET	0xff
+#define BT_ISO_QOS_BIS_UNSET	0xff
+
 struct bt_iso_io_qos {
 	uint32_t interval;
 	uint16_t latency;
@@ -154,25 +158,41 @@ struct bt_iso_io_qos {
 	uint8_t  rtn;
 };
 
-struct bt_iso_qos {
-	union {
-		uint8_t  cig;
-		uint8_t  big;
-	};
-	union {
-		uint8_t  cis;
-		uint8_t  bis;
-	};
-	union {
-		uint8_t  sca;
-		uint8_t  sync_interval;
-	};
+struct bt_iso_ucast_qos {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  sca;
 	uint8_t  packing;
 	uint8_t  framing;
 	struct bt_iso_io_qos in;
 	struct bt_iso_io_qos out;
 };
 
+struct bt_iso_bcast_qos {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_interval;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos in;
+	struct bt_iso_io_qos out;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  mse;
+	uint16_t timeout;
+};
+
+struct bt_iso_qos {
+	union {
+		struct bt_iso_ucast_qos ucast;
+		struct bt_iso_bcast_qos bcast;
+	};
+};
+
 #define BT_CODEC		19
 struct bt_codec {
 	uint8_t id;
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cfe685466..a5e253577 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -748,10 +749,10 @@ static bool match_stream_qos(const void *data, const void *user_data)
 
 	qos = bt_bap_stream_get_qos((void *)stream);
 
-	if (iso_qos->cig != qos->cig_id)
+	if (iso_qos->ucast.cig != qos->cig_id)
 		return false;
 
-	return iso_qos->cis == qos->cis_id;
+	return iso_qos->ucast.cis == qos->cis_id;
 }
 
 static void iso_confirm_cb(GIOChannel *io, void *user_data)
@@ -773,7 +774,7 @@ static void iso_confirm_cb(GIOChannel *io, void *user_data)
 	}
 
 	DBG("ISO: incoming connect from %s (CIG 0x%02x CIS 0x%02x)",
-					address, qos.cig, qos.cis);
+					address, qos.ucast.cig, qos.ucast.cis);
 
 	stream = queue_remove_if(data->streams, match_stream_qos, &qos);
 	if (!stream) {
@@ -992,11 +993,11 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	}
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
-	iso_qos.cig = qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
-	iso_qos.cis = qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
+	iso_qos.ucast.cig = qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
+	iso_qos.ucast.cis = qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
 
-	bap_iso_qos(qos[0], &iso_qos.in);
-	bap_iso_qos(qos[1], &iso_qos.out);
+	bap_iso_qos(qos[0], &iso_qos.ucast.in);
+	bap_iso_qos(qos[1], &iso_qos.ucast.out);
 
 	if (ep)
 		bap_connect_io(data, ep, stream, &iso_qos, defer);
@@ -1191,8 +1192,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 			return;
 		}
 
-		ep->qos.cig_id = qos.cig;
-		ep->qos.cis_id = qos.cis;
+		ep->qos.cig_id = qos.ucast.cig;
+		ep->qos.cis_id = qos.ucast.cis;
 	}
 
 	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
diff --git a/tools/btiotest.c b/tools/btiotest.c
index 193e1395b..75af90543 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -39,13 +40,15 @@ static int opt_update_sec = 0;
 }
 
 struct bt_iso_qos qos = {
-	.cig = BT_ISO_QOS_CIG_UNSET,
-	.cis = BT_ISO_QOS_CIG_UNSET,
-	.sca = 0x07,
-	.packing = 0x00,
-	.framing = 0x00,
-	.in = DEFAULT_IO_QOS,
-	.out = DEFAULT_IO_QOS,
+	.ucast = {
+		.cig = BT_ISO_QOS_CIG_UNSET,
+		.cis = BT_ISO_QOS_CIG_UNSET,
+		.sca = 0x07,
+		.packing = 0x00,
+		.framing = 0x00,
+		.in = DEFAULT_IO_QOS,
+		.out = DEFAULT_IO_QOS,
+	},
 };
 
 struct io_data {
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index e4582573a..0f10f8940 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -42,13 +43,15 @@
 
 #define QOS_FULL(_cig, _cis, _in, _out) \
 { \
-	.cig = _cig, \
-	.cis = _cis, \
-	.sca = 0x07, \
-	.packing = 0x00, \
-	.framing = 0x00, \
-	.in = _in, \
-	.out = _out, \
+	.ucast = { \
+		.cig = _cig, \
+		.cis = _cis, \
+		.sca = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.in = _in, \
+		.out = _out, \
+	},\
 }
 
 #define QOS(_interval, _latency, _sdu, _phy, _rtn) \
@@ -119,10 +122,47 @@
 #define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
 #define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
 
-#define QOS_OUT_16_2_1 QOS_OUT(10000, 10, 40, 0x02, 2)
-#define QOS_OUT_1_16_2_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
-#define QOS_OUT_1_1_16_2_1 QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
-#define QOS_IN_16_2_1 QOS_IN(10000, 10, 40, 0x02, 2)
+#define QOS_BCAST_FULL(_big, _bis, _in, _out) \
+{ \
+	.bcast = { \
+		.big = _big, \
+		.bis = _bis, \
+		.sync_interval = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.in = _in, \
+		.out = _out, \
+		.encryption = 0x00, \
+		.bcode = {0}, \
+		.options = 0x00, \
+		.skip = 0x0000, \
+		.sync_timeout = 0x4000, \
+		.sync_cte_type = 0x00, \
+		.mse = 0x00, \
+		.timeout = 0x4000, \
+	}, \
+}
+
+#define BCAST_QOS_OUT(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_OUT_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(0x01, BT_ISO_QOS_BIS_UNSET, \
+		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_OUT_1_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(0x01, 0x01, \
+		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_IN(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+
+#define QOS_OUT_16_2_1 BCAST_QOS_OUT(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_1_16_2_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_1_1_16_2_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
 
 struct test_data {
 	const void *test_data;
@@ -670,6 +710,7 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.expect_err = 0,
 	.recv = &send_16_2_1,
 	.bcast = true,
+	.server = true,
 };
 
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
@@ -1080,43 +1121,43 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 	return true;
 }
 
-static bool check_qos(const struct bt_iso_qos *qos1,
+static bool check_ucast_qos(const struct bt_iso_qos *qos1,
 				const struct bt_iso_qos *qos2)
 {
-	if (qos1->cig != BT_ISO_QOS_CIG_UNSET &&
-			qos2->cig != BT_ISO_QOS_CIG_UNSET &&
-			qos1->cig != qos2->cig) {
+	if (qos1->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
+			qos2->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
+			qos1->ucast.cig != qos2->ucast.cig) {
 		tester_warn("Unexpected CIG ID: 0x%02x != 0x%02x",
-				qos1->cig, qos2->cig);
+				qos1->ucast.cig, qos2->ucast.cig);
 		return false;
 	}
 
-	if (qos1->cis != BT_ISO_QOS_CIS_UNSET &&
-			qos2->cis != BT_ISO_QOS_CIS_UNSET &&
-			qos1->cis != qos2->cis) {
+	if (qos1->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
+			qos2->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
+			qos1->ucast.cis != qos2->ucast.cis) {
 		tester_warn("Unexpected CIS ID: 0x%02x != 0x%02x",
-				qos1->cis, qos2->cis);
+				qos1->ucast.cis, qos2->ucast.cis);
 		return false;
 	}
 
-	if (qos1->packing != qos2->packing) {
+	if (qos1->ucast.packing != qos2->ucast.packing) {
 		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
-				qos1->packing, qos2->packing);
+				qos1->ucast.packing, qos2->ucast.packing);
 		return false;
 	}
 
-	if (qos1->framing != qos2->framing) {
+	if (qos1->ucast.framing != qos2->ucast.framing) {
 		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
-				qos1->framing, qos2->framing);
+				qos1->ucast.framing, qos2->ucast.framing);
 		return false;
 	}
 
-	if (!check_io_qos(&qos1->in, &qos2->in)) {
+	if (!check_io_qos(&qos1->ucast.in, &qos2->ucast.in)) {
 		tester_warn("Unexpected Input QoS");
 		return false;
 	}
 
-	if (!check_io_qos(&qos1->out, &qos2->out)) {
+	if (!check_io_qos(&qos1->ucast.out, &qos2->ucast.out)) {
 		tester_warn("Unexpected Output QoS");
 		return false;
 	}
@@ -1124,6 +1165,104 @@ static bool check_qos(const struct bt_iso_qos *qos1,
 	return true;
 }
 
+static bool check_bcast_qos(const struct bt_iso_qos *qos1,
+				const struct bt_iso_qos *qos2)
+{
+	if (qos1->bcast.big != BT_ISO_QOS_BIG_UNSET &&
+			qos2->bcast.big != BT_ISO_QOS_BIG_UNSET &&
+			qos1->bcast.big != qos2->bcast.big) {
+		tester_warn("Unexpected BIG ID: 0x%02x != 0x%02x",
+				qos1->bcast.big, qos2->bcast.big);
+		return false;
+	}
+
+	if (qos1->bcast.bis != BT_ISO_QOS_BIS_UNSET &&
+			qos2->bcast.bis != BT_ISO_QOS_BIS_UNSET &&
+			qos1->bcast.bis != qos2->bcast.bis) {
+		tester_warn("Unexpected BIS ID: 0x%02x != 0x%02x",
+				qos1->bcast.bis, qos2->bcast.bis);
+		return false;
+	}
+
+	if (qos1->bcast.sync_interval != qos2->bcast.sync_interval) {
+		tester_warn("Unexpected QoS sync interval: 0x%02x != 0x%02x",
+			qos1->bcast.sync_interval, qos2->bcast.sync_interval);
+		return false;
+	}
+
+	if (qos1->bcast.packing != qos2->bcast.packing) {
+		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
+				qos1->bcast.packing, qos2->bcast.packing);
+		return false;
+	}
+
+	if (qos1->bcast.framing != qos2->bcast.framing) {
+		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
+				qos1->bcast.framing, qos2->bcast.framing);
+		return false;
+	}
+
+	if (!check_io_qos(&qos1->ucast.in, &qos2->ucast.in)) {
+		tester_warn("Unexpected Input QoS");
+		return false;
+	}
+
+	if (!check_io_qos(&qos1->ucast.out, &qos2->ucast.out)) {
+		tester_warn("Unexpected Output QoS");
+		return false;
+	}
+
+	if (qos1->bcast.encryption != qos2->bcast.encryption) {
+		tester_warn("Unexpected QoS encryption: 0x%02x != 0x%02x",
+				qos1->bcast.encryption, qos2->bcast.encryption);
+		return false;
+	}
+
+	if (memcmp(qos1->bcast.bcode, qos2->bcast.bcode,
+				sizeof(qos1->bcast.bcode))) {
+		tester_warn("Unexpected QoS Broadcast Code");
+		return false;
+	}
+
+	if (qos1->bcast.options != qos2->bcast.options) {
+		tester_warn("Unexpected QoS options: 0x%02x != 0x%02x",
+				qos1->bcast.options, qos2->bcast.options);
+		return false;
+	}
+
+	if (qos1->bcast.skip != qos2->bcast.skip) {
+		tester_warn("Unexpected QoS skip: 0x%04x != 0x%04x",
+				qos1->bcast.skip, qos2->bcast.skip);
+		return false;
+	}
+
+	if (qos1->bcast.sync_timeout != qos2->bcast.sync_timeout) {
+		tester_warn("Unexpected QoS sync timeout: 0x%04x != 0x%04x",
+			qos1->bcast.sync_timeout, qos2->bcast.sync_timeout);
+		return false;
+	}
+
+	if (qos1->bcast.sync_cte_type != qos2->bcast.sync_cte_type) {
+		tester_warn("Unexpected QoS sync cte type: 0x%02x != 0x%02x",
+			qos1->bcast.sync_cte_type, qos2->bcast.sync_cte_type);
+		return false;
+	}
+
+	if (qos1->bcast.mse != qos2->bcast.mse) {
+		tester_warn("Unexpected QoS MSE: 0x%02x != 0x%02x",
+				qos1->bcast.mse, qos2->bcast.mse);
+		return false;
+	}
+
+	if (qos1->bcast.timeout != qos2->bcast.timeout) {
+		tester_warn("Unexpected QoS MSE: 0x%04x != 0x%04x",
+				qos1->bcast.timeout, qos2->bcast.timeout);
+		return false;
+	}
+
+	return true;
+}
+
 static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1250,6 +1389,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	int err, sk_err, sk;
 	socklen_t len;
 	struct bt_iso_qos qos;
+	bool ret = true;
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -1264,7 +1404,12 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!check_qos(&qos, &isodata->qos)) {
+	if (!isodata->bcast)
+		ret = check_ucast_qos(&qos, &isodata->qos);
+	else if (!isodata->server)
+		ret = check_bcast_qos(&qos, &isodata->qos);
+
+	if (!ret) {
 		tester_warn("Unexpected QoS parameter");
 		tester_test_failed();
 		return FALSE;
diff --git a/tools/isotest.c b/tools/isotest.c
index 2b5f164de..cd7094b1c 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -239,7 +240,7 @@ fail:
 	return err < 0 ? err : 0;
 }
 
-static void print_qos(int sk, struct sockaddr_iso *addr)
+static void print_ucast_qos(int sk)
 {
 	struct bt_iso_qos qos;
 	socklen_t len;
@@ -254,21 +255,63 @@ static void print_qos(int sk, struct sockaddr_iso *addr)
 		return;
 	}
 
-	if (!bacmp(&addr->iso_bdaddr, BDADDR_ANY)) {
-		syslog(LOG_INFO, "QoS BIG 0x%02x BIS 0x%02x Packing 0x%02x "
-			"Framing 0x%02x]", qos.big, qos.bis, qos.packing,
-			qos.framing);
-	} else {
-		syslog(LOG_INFO, "QoS CIG 0x%02x CIS 0x%02x Packing 0x%02x "
-			"Framing 0x%02x]", qos.cig, qos.cis, qos.packing,
-			qos.framing);
-		syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
-			"ms SDU %u PHY 0x%02x RTN %u]", qos.in.interval,
-			qos.in.latency, qos.in.sdu, qos.in.phy, qos.in.rtn);
+	syslog(LOG_INFO, "QoS CIG 0x%02x CIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x]", qos.ucast.cig, qos.ucast.cis,
+		qos.ucast.packing, qos.ucast.framing);
+
+	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.ucast.in.interval,
+		qos.ucast.in.latency, qos.ucast.in.sdu, qos.ucast.in.phy,
+		qos.ucast.in.rtn);
+
+	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.ucast.out.interval,
+		qos.ucast.out.latency, qos.ucast.out.sdu, qos.ucast.out.phy,
+		qos.ucast.out.rtn);
+}
+
+static void print_bcast_qos(int sk)
+{
+	struct bt_iso_qos qos;
+	socklen_t len;
+
+	/* Read Out QOS */
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		return;
 	}
+
+	syslog(LOG_INFO, "QoS BIG 0x%02x BIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x]", qos.bcast.big, qos.bcast.bis,
+		qos.bcast.packing, qos.bcast.framing);
+
+	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.bcast.in.interval,
+		qos.bcast.in.latency, qos.bcast.in.sdu,
+		qos.bcast.in.phy, qos.bcast.in.rtn);
+
 	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
-		"ms SDU %u PHY 0x%02x RTN %u]", qos.out.interval,
-		qos.out.latency, qos.out.sdu, qos.out.phy, qos.out.rtn);
+		"ms SDU %u PHY 0x%02x RTN %u]", qos.bcast.out.interval,
+		qos.bcast.out.latency, qos.bcast.out.sdu,
+		qos.bcast.out.phy, qos.bcast.out.rtn);
+}
+
+static void convert_ucast_qos_to_bcast(struct bt_iso_qos *qos)
+{
+	iso_qos->bcast.in.phy = 0x00;
+	iso_qos->bcast.in.sdu = 0;
+	qos->bcast.encryption = 0x00;
+	memset(qos->bcast.bcode, 0, sizeof(qos->bcast.bcode));
+	qos->bcast.options = 0x00;
+	qos->bcast.skip = 0x0000;
+	qos->bcast.sync_timeout = 0x4000;
+	qos->bcast.sync_cte_type = 0x00;
+	qos->bcast.mse = 0x00;
+	qos->bcast.timeout = 0x4000;
 }
 
 static int do_connect(char *peer)
@@ -301,9 +344,13 @@ static int do_connect(char *peer)
 
 	/* Set QoS if available */
 	if (iso_qos) {
-		if (!inout || !strcmp(peer, "00:00:00:00:00:00")) {
-			iso_qos->in.phy = 0x00;
-			iso_qos->in.sdu = 0;
+		if (!strcmp(peer, "00:00:00:00:00:00")) {
+			convert_ucast_qos_to_bcast(iso_qos);
+		} else {
+			if (!inout) {
+				iso_qos->ucast.in.phy = 0x00;
+				iso_qos->ucast.in.sdu = 0;
+			}
 		}
 
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, iso_qos,
@@ -338,7 +385,10 @@ static int do_connect(char *peer)
 
 	syslog(LOG_INFO, "Connected [%s]", peer);
 
-	print_qos(sk, &addr);
+	if (!strcmp(peer, "00:00:00:00:00:00"))
+		print_bcast_qos(sk);
+	else
+		print_ucast_qos(sk);
 
 	return sk;
 
@@ -441,7 +491,10 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 		ba2str(&addr->iso_bdaddr, ba);
 		syslog(LOG_INFO, "Connected [%s]", ba);
 
-		print_qos(nsk, addr);
+		if (peer)
+			print_bcast_qos(nsk);
+		else
+			print_ucast_qos(nsk);
 
 		/* Handle deferred setup */
 		if (defer_setup) {
@@ -648,7 +701,7 @@ static int read_file(int fd, ssize_t count, bool rewind)
 	return len;
 }
 
-static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
+static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
 		    bool repeat)
 {
 	uint32_t seq;
@@ -662,14 +715,14 @@ static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
 
 	for (seq = 0; ; seq++) {
 		if (fd >= 0) {
-			len = read_file(fd, qos->out.sdu, repeat);
+			len = read_file(fd, out->sdu, repeat);
 			if (len < 0) {
 				syslog(LOG_ERR, "read failed: %s (%d)",
 						strerror(-len), -len);
 				exit(1);
 			}
 		} else
-			len = qos->out.sdu;
+			len = out->sdu;
 
 		len = send(sk, buf, len, 0);
 		if (len <= 0) {
@@ -686,7 +739,7 @@ static void do_send(int sk, int fd, struct bt_iso_qos *qos, uint32_t num,
 				seq, len, used / len, used);
 
 		if (seq && !((seq + 1) % num))
-			send_wait(&t_start, num * qos->out.interval);
+			send_wait(&t_start, num * out->interval);
 	}
 }
 
@@ -696,6 +749,7 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 	socklen_t len;
 	int sk, fd = -1;
 	uint32_t num;
+	struct bt_iso_io_qos *out;
 
 	if (filename) {
 		char altername[PATH_MAX];
@@ -728,16 +782,21 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 	syslog(LOG_INFO, "Sending ...");
 
 	/* Read QoS */
+	if (!strcmp(peer, "00:00:00:00:00:00"))
+		out = &qos.bcast.out;
+	else
+		out = &qos.ucast.out;
+
 	memset(&qos, 0, sizeof(qos));
 	len = sizeof(qos);
 	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
 		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
 				strerror(errno), errno);
-		qos.out.sdu = ISO_DEFAULT_MTU;
+		out->sdu = ISO_DEFAULT_MTU;
 	}
 
 	/* num of packets = latency (ms) / interval (us) */
-	num = (qos.out.latency * 1000 / qos.out.interval);
+	num = (out->latency * 1000 / out->interval);
 
 	syslog(LOG_INFO, "Number of packets: %d", num);
 
@@ -746,8 +805,8 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		 * latency:
 		 * jitter buffer = 2 * (SDU * subevents)
 		 */
-		sndbuf = 2 * ((qos.out.latency * 1000 / qos.out.interval) *
-							qos.out.sdu);
+		sndbuf = 2 * ((out->latency * 1000 / out->interval) *
+							out->sdu);
 
 	len = sizeof(sndbuf);
 	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len) < 0) {
@@ -768,10 +827,10 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		}
 	}
 
-	for (i = 6; i < qos.out.sdu; i++)
+	for (i = 6; i < out->sdu; i++)
 		buf[i] = 0x7f;
 
-	do_send(sk, fd, &qos, num, repeat);
+	do_send(sk, fd, out, num, repeat);
 }
 
 static void reconnect_mode(char *peer)
@@ -826,12 +885,14 @@ static void multy_connect_mode(char *peer)
 
 #define QOS(_interval, _latency, _sdu, _phy, _rtn) \
 { \
-	.cig = BT_ISO_QOS_CIG_UNSET, \
-	.cis = BT_ISO_QOS_CIS_UNSET, \
-	.sca = 0x07, \
-	.packing = 0x00, \
-	.framing = 0x00, \
-	.out = QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+	.ucast = { \
+		.cig = BT_ISO_QOS_CIG_UNSET, \
+		.cis = BT_ISO_QOS_CIS_UNSET, \
+		.sca = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.out = QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+	}, \
 }
 
 #define QOS_PRESET(_name, _inout, _interval, _latency, _sdu, _phy, _rtn) \
@@ -1057,43 +1118,43 @@ int main(int argc, char *argv[])
 
 		case 'M':
 			if (optarg)
-				iso_qos->out.sdu = atoi(optarg);
+				iso_qos->ucast.out.sdu = atoi(optarg);
 			break;
 
 		case 'S':
 			if (optarg)
-				iso_qos->sca = atoi(optarg);
+				iso_qos->ucast.sca = atoi(optarg);
 			break;
 
 
 		case 'P':
 			if (optarg)
-				iso_qos->packing = atoi(optarg);
+				iso_qos->ucast.packing = atoi(optarg);
 			break;
 
 		case 'F':
 			if (optarg)
-				iso_qos->framing = atoi(optarg);
+				iso_qos->ucast.framing = atoi(optarg);
 			break;
 
 		case 'I':
 			if (optarg)
-				iso_qos->out.interval = atoi(optarg);
+				iso_qos->ucast.out.interval = atoi(optarg);
 			break;
 
 		case 'L':
 			if (optarg)
-				iso_qos->out.latency = atoi(optarg);
+				iso_qos->ucast.out.latency = atoi(optarg);
 			break;
 
 		case 'Y':
 			if (optarg)
-				iso_qos->out.phy = atoi(optarg);
+				iso_qos->ucast.out.phy = atoi(optarg);
 			break;
 
 		case 'R':
 			if (optarg)
-				iso_qos->out.rtn = atoi(optarg);
+				iso_qos->ucast.out.rtn = atoi(optarg);
 			break;
 
 		case 'B':
@@ -1112,12 +1173,12 @@ int main(int argc, char *argv[])
 
 		case 'G':
 			if (optarg)
-				iso_qos->cig = atoi(optarg);
+				iso_qos->ucast.cig = atoi(optarg);
 			break;
 
 		case 'T':
 			if (optarg)
-				iso_qos->cis = atoi(optarg);
+				iso_qos->ucast.cis = atoi(optarg);
 			break;
 
 		/* fall through */
@@ -1128,11 +1189,11 @@ int main(int argc, char *argv[])
 	}
 
 	if (inout) {
-		iso_qos->in = iso_qos->out;
+		iso_qos->ucast.in = iso_qos->ucast.out;
 	} else {
 		/* Align interval and latency even if is unidirectional */
-		iso_qos->in.interval = iso_qos->out.interval;
-		iso_qos->in.latency = iso_qos->out.latency;
+		iso_qos->ucast.in.interval = iso_qos->ucast.out.interval;
+		iso_qos->ucast.in.latency = iso_qos->ucast.out.latency;
 	}
 
 	buf = malloc(data_size);
-- 
2.34.1

