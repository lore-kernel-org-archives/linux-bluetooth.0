Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJ3PjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJ3PjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:39:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F4B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1J2iAKksTS0ToF5LzWW3DR9gCcBO74pAIOOeobDtrHk/31r+2ASkw8vL/rj6l95t2/SxZaEoFtthZG5gchtAAnWDOJEUsrla2lHl8XbvC/kMtVCnkjKXtuXgokdZWMaFd/M+xKM9wOb3RQY3GxRtrl9pVM2gsI31y5L3m29oMqGWZENPiVfD6TaH2P8sCZdY0LqWWq4FP9G82Yg38MCg/x4xzqJQnGRlcKjshtijmbnnChqmS3Y+YnqPGwxyev559dhzkPcGfGXf6eWQjOj5XLYaXVGuadtl/DLxddrvv56CSnIaFAEQEaCqOdMC2xvECtum0hJ019PKocCL5eM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VKR/Sk9xdw6ZSVXXLlnRdsbNLY5BFP6g9iZ+ZskSL4=;
 b=Tba36R4hYaMfY2soz8QtOcr91HD5AyVMfOsRtCWB4wJ7Q4EntwQTVv17qsGDGlBCjhzZsG9DTZBKWGa3uj9QMtl5VytWaOL/H55X3GLgRY8kFORUTRexnnBO2LqJqxpl/7FDF/5nac05hyKeRoAclU7UgBqhKsuDNQfHx8eqBNjDoixmVMlyIvNl7ZQw4uwA/pZ6vQq7QdXOUVEkco/gXamsS0Q/8iUVMsw8v68phlQBLt5VZeM7/AaLk1wvJsUa5+u3GAPeATfO71I5LmaFR1aKTin13UlQtxTK1ULIBOFeHR7RuSZsOGaKfes2UB2vZgCyzaXHW0NbKKBMeju6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VKR/Sk9xdw6ZSVXXLlnRdsbNLY5BFP6g9iZ+ZskSL4=;
 b=LLZwDgawv3G9BtgutPwBB5qjuRSWruccYmdbZ6ZN4bwU7mknH5pQW3mrS4hkTi0gCIOu66vX8cpKFUv9TiuDs2EOxOhDCDKgTrJO8Ly5ebmmVv7a5/kLaE5r+FViuUBObbViPNIJvAp1o0dcnGM8rI3tBheVPrblq/fxx4QbM3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 15:39:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:39:11 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bass: Move io handling out of src/shared
Date:   Mon, 30 Oct 2023 17:39:03 +0200
Message-Id: <20231030153903.4248-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030153903.4248-1-iulia.tanasescu@nxp.com>
References: <20231030153903.4248-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0179.eurprd09.prod.outlook.com
 (2603:10a6:800:120::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e31dc26-91df-4f54-b0a8-08dbd95e5d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3BrpYxgEPNkb+W1RLgNeixzAQps/Ie27aiqMcTOR7QnCF2jBdfgsivs64MnX/yf5QzTLDEFvpy9oRbIs4xczOTD4MeMr6Nz4e8okBv7sZjnv1X064DHiNEmikQt3afUE0T8KL0bKHpmlrLKnwMm499o/OeX27e0GuTU3HB6huCW5ElgPvtOgRUrJhAkNNSkcHWqqOEvKPQ0MSBdPKWXpLnJfiDcELKo+PdVLbjyNcc0rHdc5lJVq/05JQ/bYuQhldZi8LZVirHZrmOMKjbc3i3lAEJbV6eyl7bnCT3lIDsDbkFl+8dr9pdksXtjaREFPteW0KVovARwtlR9zT12HivnXVKUttGqvKmN/sgs6PDyJLd0mZ3qza4pDd1/k7pfkc0auMP+iIBugzmkFn/bPtCY4+GwXrvo25X4RA+10dIxrF0LRlYrOsMlv8YVJhAiQms6Xq0NZrlOkJVtiaqoEC4/v2VAFWWgZIh9++W/qTIRlWzTptFDqdIeJkEY4ostwQRjmYq6GJIDezaR9+PHCKpnbC7LLABmw036JscIInPOQZr15/4c+2jgKG7N+PKP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(30864003)(2906002)(38100700002)(8936002)(41300700001)(36756003)(4326008)(8676002)(44832011)(5660300002)(6916009)(66476007)(66556008)(6486002)(316002)(2616005)(86362001)(6666004)(6512007)(66946007)(1076003)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5iAyAIj+e+SyhpXxLyQfMaUfkgBJCojDVqsap19TkVCHvFKO9ZGlvuJWU29Q?=
 =?us-ascii?Q?hjqKQEpdwwPgxTVpfppqxcTnYDfJVMep+J32yN4UlTYSVnThIlqnWiX7gbAC?=
 =?us-ascii?Q?ewEPQ+V/AnXlKxqaW/w12B6i8qR9wx8cIhjG5bY5Oe6N2yTstS46xHZb28rE?=
 =?us-ascii?Q?te7+tQxpLJny0Urdz5fk2W9fDmwaw26n/TmUZb8bo9zJD0+FX0X+nVvwJkZN?=
 =?us-ascii?Q?KmnHl2s5mSX183nOcq7bjteDRzmdALYCpcNufZ0H3w5WPeMnpb0Efo18wJCI?=
 =?us-ascii?Q?Wi1VbJESmLzdudfctMgCfq/6oxOGIEs833VV8kT9lkhi3PmsJfeh49823/Lk?=
 =?us-ascii?Q?fCy7JF6pSbe9mJe+inw/Bjfbbbn5u+FwRjzyVepjQACRvNKTkBg3aWNsrpvc?=
 =?us-ascii?Q?BefXv/IXVePB1PeYd+koCm2TGbNHmWxHXKlI6cyvWsCt4OWc8OuycuwGvyJF?=
 =?us-ascii?Q?Fd+lI85NtcPsVhgJEawKyPRUrX0VIdW0nReFJSujWa3jmvUpjH40jBTpX+Mm?=
 =?us-ascii?Q?ZafpBsc2G9VfwFqFbnExNuwTRjxlMa9tjrdgO5z0MAX33P1uVD3Wq5KrtV8p?=
 =?us-ascii?Q?KHjjQJazrRWae8sGJojQeIDUAGwob/o0et4B9nRegV200M43SYHTmqInC22O?=
 =?us-ascii?Q?kviTpaoYjVX5CqVCMe41K8t0kK4d5ffk4lycWdfe5oSuFgwKWfC4JQ/v8qwg?=
 =?us-ascii?Q?A7MqsevGRv/Q9Q/ICbn3uovVxIaow4Cc6WWBmIdBRzm0ELtP5qQFgZadT2fP?=
 =?us-ascii?Q?HVDlz5p2ZFscK9khWIs8XwSJxnLnUG20HuTzn9B8fQ2lQZ/0nT2uidorlshH?=
 =?us-ascii?Q?KPK7Hz0fpyOQpWZgZnAvzAbhaiIeJbAYJKNvBQIqU4x4Ha+2gdPrIiH3kh7B?=
 =?us-ascii?Q?D52to7lP5MCHwAhiLTR+X24rD6Vs7bSgfspjFYSRBBDjs1HwSfojrQC86Pk6?=
 =?us-ascii?Q?TlAWstn4u3ELun8cozxztveA9TFqU/fkyzck5KpeB1O+5p4330Y1h4D/Ifo2?=
 =?us-ascii?Q?w6QWukHxaXuVvIxCjkAw+Qs3ktnDRXr3Zsq67NH+mQ7MjjMzMx0Z1d5ONVcb?=
 =?us-ascii?Q?cQBB8tNdexhgeFuyRVfeeRd1KdFWgfaQw0VvVFFEm82KRWrYn3lFR9GHtQmN?=
 =?us-ascii?Q?wsPJ3/eJMZOuvfGZ97eEx51gR011Y++o0QtxnIXmLtKQAYPitWt/bvrkpyVt?=
 =?us-ascii?Q?PoHlg5nLuBgIt1NXDL4uPKytkAekRaAowlFfznDblTW1hchI9lc6C/bKeDSt?=
 =?us-ascii?Q?wvPElaGCG6ImWcjQLZAwsb2AoPwQczPyPrBwTjw0W8cCWO1lo23goC66U+fU?=
 =?us-ascii?Q?lF+V35DeMGI6/UivAn2YScB6IE0QvcDbzKfzY+pf/XSqOeQUFW39qyDTPtUL?=
 =?us-ascii?Q?r/PBDfj/lilnzMNOMKqc5qKN/puWyUnN7sNn6PllehIFgpgHWiMhNYJVYASb?=
 =?us-ascii?Q?cpwbX61YC46ifGPhTgwtQRfZhIPMtMJ/gVAsfNxeGhy6g8ng8Ka9R3nqE2tX?=
 =?us-ascii?Q?RhGkxQY58BYjurHFFQUHX395V3f17XSxdbQMeRkDqgmNdnjOSIH1r4+TawrD?=
 =?us-ascii?Q?MZVa7NIXK099jbnOYq04J8EFdR/wC6BBuJmhg9xBwynnmgeRDE2KbyOHBpMy?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31dc26-91df-4f54-b0a8-08dbd95e5d32
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:39:11.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6xqGsHhMBAr1S/DOcQYqCDxaUizJHwIzhlCySNL31h1/vmJBEG+2SBKHSZgJU0/jenAAB/ftjXoD/Un4fdltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves IO handling from src/shared/bass.c to profiles/audio/bass.c.

The profiles/audio module registers io callbacks for listen and accept
with src/shared. These callbacks will be used to perform PA/BIG sync
and they will notify the result back to src/shared.

---
 profiles/audio/bass.c | 397 ++++++++++++++++++++++++++++++++++++++
 src/shared/bass.c     | 435 ++++++++++++++++--------------------------
 src/shared/bass.h     |  23 ++-
 3 files changed, 583 insertions(+), 272 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 7952105c5..3984fca59 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -22,6 +22,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <poll.h>
 
 #include <glib.h>
 
@@ -29,6 +30,9 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
+
+#include "btio/btio.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -54,10 +58,51 @@ struct bass_data {
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_bass *bass;
+
+	unsigned int io_cb_id;
 };
 
 static struct queue *sessions;
 
+struct bt_bass_io {
+	GIOChannel *listen;
+	guint listen_io_id;
+	GIOChannel *pa;
+	guint pa_io_id;
+	struct queue *bises;
+};
+
+#define MAX_BIS_BITMASK_IDX		31
+
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_factor		= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -148,6 +193,350 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
 	bass_data_remove(data);
 }
 
+static gboolean check_io_err(GIOChannel *io)
+{
+	struct pollfd fds;
+
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = g_io_channel_unix_get_fd(io);
+	fds.events = POLLERR;
+
+	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR))
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean pa_io_disconnect_cb(GIOChannel *io, GIOCondition cond,
+			gpointer data)
+{
+	struct bt_bcast_src *bcast_src = data;
+
+	DBG("PA sync io has been disconnected");
+
+	bcast_src->io->pa_io_id = 0;
+	g_io_channel_unref(bcast_src->io->pa);
+	bcast_src->io->pa = NULL;
+
+	return FALSE;
+}
+
+static void confirm_cb(GIOChannel *io, gpointer user_data)
+{
+	struct bt_bcast_src *bcast_src = user_data;
+	int sk, err;
+	socklen_t len;
+	struct bt_iso_qos qos;
+
+	if (!bcast_src || !bcast_src->bass)
+		return;
+
+	if (check_io_err(io)) {
+		DBG("PA sync failed");
+
+		/* Mark PA sync as failed and notify client */
+		bcast_src->sync_state = BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA;
+		goto notify;
+	}
+
+	bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
+	bcast_src->io->pa = io;
+	g_io_channel_ref(bcast_src->io->pa);
+
+	bcast_src->io->pa_io_id = g_io_add_watch(io, G_IO_ERR |
+					G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) pa_io_disconnect_cb,
+					bcast_src);
+
+	len = sizeof(qos);
+	memset(&qos, 0, len);
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	if (err < 0) {
+		DBG("Failed to get iso qos");
+		return;
+	}
+
+	if (!qos.bcast.encryption)
+		/* BIG is not encrypted. Try to synchronize */
+		bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
+	else
+		/* BIG is encrypted. Wait for Client to provide the
+		 * Broadcast_Code
+		 */
+		bcast_src->enc = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
+
+notify:
+	if (bcast_src->confirm_cb)
+		bcast_src->confirm_cb(bcast_src);
+}
+
+static gboolean listen_io_disconnect_cb(GIOChannel *io, GIOCondition cond,
+			gpointer data)
+{
+	struct bt_bcast_src *bcast_src = data;
+
+	DBG("Listen io has been disconnected");
+
+	bcast_src->io->listen_io_id = 0;
+	g_io_channel_unref(bcast_src->io->listen);
+	bcast_src->io->listen = NULL;
+
+	return FALSE;
+}
+
+static int bass_io_listen(struct bt_bcast_src *bcast_src,
+				const bdaddr_t *src)
+{
+	uint8_t addr_type;
+	GError *err = NULL;
+	struct bt_iso_qos iso_qos = default_qos;
+	uint8_t num_bis = 0;
+	uint8_t bis[ISO_MAX_NUM_BIS];
+
+	if (!bcast_src)
+		return -1;
+
+	if (!bcast_src->io) {
+		bcast_src->io = malloc(sizeof(*bcast_src->io));
+		if (!bcast_src->io)
+			return -1;
+
+		memset(bcast_src->io, 0, sizeof(*bcast_src->io));
+	}
+
+	memset(bis, 0, ISO_MAX_NUM_BIS);
+
+	for (int i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+
+		if (data->pending_bis_sync != BIS_SYNC_NO_PREF)
+			/* Iterate through the bis sync bitmask written
+			 * by the client and store the bis indexes that
+			 * the BASS server will try to synchronize to
+			 */
+			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
+				if (data->pending_bis_sync & (1 << bis_idx)) {
+					bis[num_bis] = bis_idx + 1;
+					num_bis++;
+				}
+			}
+	}
+
+	/* Convert to three-value type */
+	if (bcast_src->addr_type)
+		addr_type = BDADDR_LE_RANDOM;
+	else
+		addr_type = BDADDR_LE_PUBLIC;
+
+	/* Try to synchronize to the source */
+	bcast_src->io->listen = bt_io_listen(NULL, confirm_cb,
+				bcast_src, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				src,
+				BT_IO_OPT_DEST_BDADDR,
+				&bcast_src->addr,
+				BT_IO_OPT_DEST_TYPE,
+				addr_type,
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, &iso_qos,
+				BT_IO_OPT_ISO_BC_SID, bcast_src->sid,
+				BT_IO_OPT_ISO_BC_NUM_BIS, num_bis,
+				BT_IO_OPT_ISO_BC_BIS, bis,
+				BT_IO_OPT_INVALID);
+
+	if (!bcast_src->io->listen) {
+		DBG("%s", err->message);
+		g_error_free(err);
+		return -1;
+	}
+
+	g_io_channel_ref(bcast_src->io->listen);
+
+	bcast_src->io->listen_io_id = g_io_add_watch(bcast_src->io->listen,
+					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc)listen_io_disconnect_cb,
+					bcast_src);
+
+	if (num_bis > 0 && !bcast_src->io->bises)
+		bcast_src->io->bises = queue_new();
+
+	return 0;
+}
+
+static void bass_bis_unref(void *data)
+{
+	GIOChannel *io = data;
+
+	g_io_channel_unref(io);
+}
+
+static void connect_cb(GIOChannel *io, GError *gerr,
+				gpointer user_data)
+{
+	struct bt_bcast_src *bcast_src = user_data;
+	int bis_idx;
+	int i;
+
+	if (!bcast_src || !bcast_src->bass)
+		return;
+
+	/* Keep io reference */
+	g_io_channel_ref(io);
+	queue_push_tail(bcast_src->io->bises, io);
+
+	for (i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+
+		for (bis_idx = 0; bis_idx < MAX_BIS_BITMASK_IDX; bis_idx++) {
+			if (data->pending_bis_sync & (1 << bis_idx)) {
+				data->bis_sync |= (1 << bis_idx);
+				data->pending_bis_sync &= ~(1 << bis_idx);
+				break;
+			}
+		}
+
+		if (bis_idx < MAX_BIS_BITMASK_IDX)
+			break;
+	}
+
+	for (i = 0; i < bcast_src->num_subgroups; i++) {
+		if (bcast_src->subgroup_data[i].pending_bis_sync)
+			break;
+	}
+
+	/* Wait until all BISes have been connected */
+	if (i != bcast_src->num_subgroups)
+		return;
+
+	if (check_io_err(io)) {
+		DBG("BIG sync failed");
+
+		queue_destroy(bcast_src->io->bises, bass_bis_unref);
+
+		bcast_src->io->bises = NULL;
+
+		/* Close listen io */
+		g_io_channel_shutdown(bcast_src->io->listen, TRUE, NULL);
+		g_io_channel_unref(bcast_src->io->listen);
+
+		bcast_src->io->listen = NULL;
+
+		if (bcast_src->io->listen_io_id > 0) {
+			g_source_remove(bcast_src->io->listen_io_id);
+			bcast_src->io->listen_io_id  = 0;
+		}
+
+		/* Close PA io */
+		g_io_channel_shutdown(bcast_src->io->pa, TRUE, NULL);
+		g_io_channel_unref(bcast_src->io->pa);
+
+		bcast_src->io->pa = NULL;
+
+		if (bcast_src->io->pa_io_id > 0) {
+			g_source_remove(bcast_src->io->pa_io_id);
+			bcast_src->io->pa_io_id  = 0;
+		}
+
+		for (i = 0; i < bcast_src->num_subgroups; i++)
+			bcast_src->subgroup_data[i].bis_sync =
+				BT_BASS_BIG_SYNC_FAILED_BITMASK;
+
+		/* If BIG sync failed because of an incorrect broadcast code,
+		 * inform client
+		 */
+		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
+			bcast_src->enc = BT_BASS_BIG_ENC_STATE_BAD_CODE;
+	} else {
+		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
+			bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
+	}
+
+	if (bcast_src->connect_cb)
+		bcast_src->connect_cb(bcast_src);
+}
+
+static int bass_io_accept(struct bt_bcast_src *bcast_src)
+{
+	int sk, err;
+	socklen_t len;
+	struct bt_iso_qos qos;
+	GError *gerr = NULL;
+
+	if (!bcast_src || !bcast_src->io || !bcast_src->io->pa)
+		return -1;
+
+	if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ) {
+		/* Update socket QoS with Broadcast Code */
+		len = sizeof(qos);
+		memset(&qos, 0, len);
+
+		sk = g_io_channel_unix_get_fd(bcast_src->io->pa);
+
+		err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+		if (err < 0) {
+			DBG("Failed to get iso qos");
+			return -1;
+		}
+
+		memcpy(qos.bcast.bcode, bcast_src->bcode,
+			BT_BASS_BCAST_CODE_SIZE);
+
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+					sizeof(qos)) < 0) {
+			DBG("Failed to set iso qos");
+			return -1;
+		}
+	}
+
+	if (!bt_io_bcast_accept(bcast_src->io->pa,
+		connect_cb, bcast_src, NULL, &gerr,
+		BT_IO_OPT_INVALID)) {
+		DBG("bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void bass_io_destroy(struct bt_bcast_src *bcast_src)
+{
+	if (!bcast_src || !bcast_src->io)
+		return;
+
+	queue_destroy(bcast_src->io->bises, bass_bis_unref);
+	bcast_src->io->bises = NULL;
+
+	if (bcast_src->io->listen) {
+		g_io_channel_shutdown(bcast_src->io->listen, TRUE, NULL);
+		g_io_channel_unref(bcast_src->io->listen);
+		bcast_src->io->listen = NULL;
+	}
+
+	if (bcast_src->io->listen_io_id > 0) {
+		g_source_remove(bcast_src->io->listen_io_id);
+		bcast_src->io->listen_io_id  = 0;
+	}
+
+	if (bcast_src->io->pa) {
+		g_io_channel_shutdown(bcast_src->io->pa, TRUE, NULL);
+		g_io_channel_unref(bcast_src->io->pa);
+		bcast_src->io->pa = NULL;
+	}
+
+	if (bcast_src->io->pa_io_id > 0) {
+		g_source_remove(bcast_src->io->pa_io_id);
+		bcast_src->io->pa_io_id  = 0;
+	}
+
+	free(bcast_src->io);
+}
+
 static void bass_attached(struct bt_bass *bass, void *user_data)
 {
 	struct bass_data *data;
@@ -173,6 +562,10 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 	data = bass_data_new(device);
 	data->bass = bass;
 
+	/* Register io callbacks */
+	data->io_cb_id = bt_bass_io_cb_register(bass, bass_io_listen,
+			bass_io_accept, bass_io_destroy);
+
 	bass_data_add(data);
 }
 
@@ -205,6 +598,10 @@ static int bass_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	/* Register io callbacks */
+	data->io_cb_id = bt_bass_io_cb_register(data->bass, bass_io_listen,
+			bass_io_accept, bass_io_destroy);
+
 	bass_data_add(data);
 	bt_bass_set_user_data(data->bass, service);
 
diff --git a/src/shared/bass.c b/src/shared/bass.c
index ce8b239f3..8e410bf9f 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -14,13 +14,9 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
-#include <poll.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
-#include "lib/iso.h"
-
-#include "btio/btio.h"
 
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
@@ -29,8 +25,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bass.h"
 
-#define MAX_BIS_BITMASK_IDX		31
-
 #define DBG(_bass, fmt, arg...) \
 	bass_debug(_bass, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 
@@ -43,6 +37,13 @@ struct bt_bass_cb {
 	void *user_data;
 };
 
+struct bt_bass_io_cb {
+	unsigned int id;
+	bt_bass_listen_func_t listen;
+	bt_bass_accept_func_t accept;
+	bt_bass_io_destroy_func_t io_destroy;
+};
+
 struct bt_bcast_recv_state {
 	struct bt_bass_db *bdb;
 	struct gatt_db_attribute *attr;
@@ -64,6 +65,7 @@ struct bt_bass {
 	struct bt_bass_db *rdb;
 	struct bt_gatt_client *client;
 	struct bt_att *att;
+	unsigned int disconn_id;
 
 	struct queue *notify;
 
@@ -71,6 +73,8 @@ struct bt_bass {
 	bt_bass_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	struct queue *io_cbs;
+
 	void *user_data;
 };
 
@@ -89,35 +93,6 @@ static struct queue *bass_db;
 static struct queue *bass_cbs;
 static struct queue *sessions;
 
-#define DEFAULT_IO_QOS \
-{ \
-	.interval	= 10000, \
-	.latency	= 10, \
-	.sdu		= 40, \
-	.phy		= 0x02, \
-	.rtn		= 2, \
-}
-
-static struct bt_iso_qos default_qos = {
-	.bcast = {
-		.big			= BT_ISO_QOS_BIG_UNSET,
-		.bis			= BT_ISO_QOS_BIS_UNSET,
-		.sync_factor		= 0x07,
-		.packing		= 0x00,
-		.framing		= 0x00,
-		.in			= DEFAULT_IO_QOS,
-		.out			= DEFAULT_IO_QOS,
-		.encryption		= 0x00,
-		.bcode			= {0x00},
-		.options		= 0x00,
-		.skip			= 0x0000,
-		.sync_timeout		= 0x4000,
-		.sync_cte_type		= 0x00,
-		.mse			= 0x00,
-		.timeout		= 0x4000,
-	}
-};
-
 static void bass_bcast_src_free(void *data);
 
 static void bass_debug(struct bt_bass *bass, const char *format, ...)
@@ -580,102 +555,11 @@ static bool bass_src_attr_match(const void *data, const void *match_data)
 	return (bcast_src->attr == attr);
 }
 
-static gboolean check_io_err(GIOChannel *io)
-{
-	struct pollfd fds;
-
-	memset(&fds, 0, sizeof(fds));
-	fds.fd = g_io_channel_unix_get_fd(io);
-	fds.events = POLLERR;
-
-	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR))
-		return TRUE;
-
-	return FALSE;
-}
-
-static void bass_bis_unref(void *data)
-{
-	GIOChannel *io = data;
-
-	g_io_channel_unref(io);
-}
-
-static void connect_cb(GIOChannel *io, GError *gerr,
-				gpointer user_data)
+static void connect_cb(void *user_data)
 {
 	struct bt_bcast_src *bcast_src = user_data;
 	uint8_t *notify_data;
 	size_t notify_data_len;
-	int bis_idx;
-	int i;
-
-	/* Keep io reference */
-	g_io_channel_ref(io);
-	queue_push_tail(bcast_src->bises, io);
-
-	for (i = 0; i < bcast_src->num_subgroups; i++) {
-		struct bt_bass_subgroup_data *data =
-				&bcast_src->subgroup_data[i];
-
-		for (bis_idx = 0; bis_idx < MAX_BIS_BITMASK_IDX; bis_idx++) {
-			if (data->pending_bis_sync & (1 << bis_idx)) {
-				data->bis_sync |= (1 << bis_idx);
-				data->pending_bis_sync &= ~(1 << bis_idx);
-				break;
-			}
-		}
-
-		if (bis_idx < MAX_BIS_BITMASK_IDX)
-			break;
-	}
-
-	for (i = 0; i < bcast_src->num_subgroups; i++) {
-		if (bcast_src->subgroup_data[i].pending_bis_sync)
-			break;
-	}
-
-	/* If there are still pending bises, wait for their
-	 * notifications also before sending notification to
-	 * client
-	 */
-	if (i != bcast_src->num_subgroups)
-		return;
-
-	/* All connections have been notified */
-	if (check_io_err(io)) {
-		DBG(bcast_src->bass, "BIG sync failed");
-
-		/* Close all connected bises */
-		queue_destroy(bcast_src->bises, bass_bis_unref);
-		bcast_src->bises = NULL;
-
-		/* Close listen io */
-		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->listen_io);
-		bcast_src->listen_io = NULL;
-
-		/* Close pa sync io */
-		if (bcast_src->pa_sync_io) {
-			g_io_channel_shutdown(bcast_src->pa_sync_io,
-					TRUE, NULL);
-			g_io_channel_unref(bcast_src->pa_sync_io);
-			bcast_src->pa_sync_io = NULL;
-		}
-
-		for (i = 0; i < bcast_src->num_subgroups; i++)
-			bcast_src->subgroup_data[i].bis_sync =
-				BT_BASS_BIG_SYNC_FAILED_BITMASK;
-
-		/* If BIG sync failed because of an incorrect broadcast code,
-		 * inform client
-		 */
-		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
-			bcast_src->enc = BT_BASS_BIG_ENC_STATE_BAD_CODE;
-	} else {
-		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
-			bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
-	}
 
 	/* Send notification to client */
 	notify_data = bass_build_notif_from_bcast_src(bcast_src,
@@ -703,62 +587,25 @@ static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
 	return false;
 }
 
-
-static void confirm_cb(GIOChannel *io, gpointer user_data)
+static void confirm_cb(void *user_data)
 {
 	struct bt_bcast_src *bcast_src = user_data;
-	int sk, err;
-	socklen_t len;
-	struct bt_iso_qos qos;
 	uint8_t *notify_data;
 	size_t notify_data_len;
-	GError *gerr = NULL;
-
-	if (check_io_err(io)) {
-		DBG(bcast_src->bass, "PA sync failed");
-
-		/* Mark PA sync as failed and notify client */
-		bcast_src->sync_state = BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA;
-		goto notify;
-	}
-
-	bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
-	bcast_src->pa_sync_io = io;
-	g_io_channel_ref(bcast_src->pa_sync_io);
-
-	len = sizeof(qos);
-	memset(&qos, 0, len);
+	const struct queue_entry *entry;
 
-	sk = g_io_channel_unix_get_fd(io);
+	if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_NO_ENC &&
+		bass_trigger_big_sync(bcast_src)) {
+		for (entry = queue_get_entries(bcast_src->bass->io_cbs);
+						entry; entry = entry->next) {
+			struct bt_bass_io_cb *cb = entry->data;
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
-	if (err < 0) {
-		DBG(bcast_src->bass, "Failed to get iso qos");
-		return;
-	}
-
-	if (!qos.bcast.encryption) {
-		/* BIG is not encrypted. Try to synchronize */
-		bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
-
-		if (bass_trigger_big_sync(bcast_src)) {
-			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-				connect_cb, bcast_src, NULL, &gerr,
-				BT_IO_OPT_INVALID)) {
-				DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
-				gerr->message);
-				g_error_free(gerr);
-			}
-			return;
+			if (cb->accept && (cb->accept(bcast_src) < 0))
+				DBG(bcast_src->bass, "Unable to accept");
 		}
-
-		goto notify;
+		return;
 	}
 
-	/* BIG is encrypted. Wait for Client to provide the Broadcast_Code */
-	bcast_src->enc = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
-
-notify:
 	notify_data = bass_build_notif_from_bcast_src(bcast_src,
 						&notify_data_len);
 
@@ -856,14 +703,9 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	uint8_t src_id = 0;
 	struct gatt_db_attribute *attr;
 	uint8_t *pa_sync;
-	GIOChannel *io;
-	GError *err = NULL;
-	struct bt_iso_qos iso_qos = default_qos;
-	uint8_t num_bis = 0;
-	uint8_t bis[ISO_MAX_NUM_BIS];
 	uint8_t *notify_data;
 	size_t notify_data_len;
-	uint8_t addr_type;
+	const struct queue_entry *entry;
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
@@ -881,7 +723,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
 
 	memset(bcast_src, 0, sizeof(*bcast_src));
-	memset(bis, 0, ISO_MAX_NUM_BIS);
 
 	bcast_src->bass = bass;
 
@@ -968,18 +809,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 		util_iov_pull_le32(iov, &data->pending_bis_sync);
 
-		if (data->pending_bis_sync != BIS_SYNC_NO_PREF)
-			/* Iterate through the bis sync bitmask written
-			 * by the client and store the bis indexes that
-			 * the BASS server will try to synchronize to
-			 */
-			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
-				if (data->pending_bis_sync & (1 << bis_idx)) {
-					bis[num_bis] = bis_idx + 1;
-					num_bis++;
-				}
-			}
-
 		data->meta_len = *(uint8_t *)util_iov_pull_mem(iov,
 						sizeof(data->meta_len));
 		if (!data->meta_len)
@@ -993,39 +822,20 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					data->meta_len), data->meta_len);
 	}
 
-	if (pa_sync != PA_SYNC_NO_SYNC) {
-		/* Convert to three-value type */
-		if (bcast_src->addr_type)
-			addr_type = BDADDR_LE_RANDOM;
-		else
-			addr_type = BDADDR_LE_PUBLIC;
-
-		/* If requested by client, try to synchronize to the source */
-		io = bt_io_listen(NULL, confirm_cb, bcast_src, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR,
-					&bass->ldb->adapter_bdaddr,
-					BT_IO_OPT_DEST_BDADDR,
-					&bcast_src->addr,
-					BT_IO_OPT_DEST_TYPE,
-					addr_type,
-					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-					BT_IO_OPT_QOS, &iso_qos,
-					BT_IO_OPT_ISO_BC_SID, bcast_src->sid,
-					BT_IO_OPT_ISO_BC_NUM_BIS, num_bis,
-					BT_IO_OPT_ISO_BC_BIS, bis,
-					BT_IO_OPT_INVALID);
-
-		if (!io) {
-			DBG(bass, "%s", err->message);
-			g_error_free(err);
-			goto err;
-		}
+	bcast_src->confirm_cb = confirm_cb;
+	bcast_src->connect_cb = connect_cb;
 
-		bcast_src->listen_io = io;
-		g_io_channel_ref(bcast_src->listen_io);
+	if (*pa_sync != PA_SYNC_NO_SYNC) {
+		for (entry = queue_get_entries(bass->io_cbs); entry;
+						entry = entry->next) {
+			struct bt_bass_io_cb *cb = entry->data;
 
-		if (num_bis > 0 && !bcast_src->bises)
-			bcast_src->bises = queue_new();
+			if (cb->listen && (cb->listen(bcast_src,
+				&bass->ldb->adapter_bdaddr) < 0)) {
+				DBG(bass, "Unable to listen for source");
+				goto err;
+			}
+		}
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
@@ -1064,12 +874,9 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 {
 	struct bt_bass_set_bcast_code_params *params;
 	struct bt_bcast_src *bcast_src;
-	int sk, err;
-	socklen_t len;
-	struct bt_iso_qos qos;
-	GError *gerr = NULL;
 	uint8_t *notify_data;
 	size_t notify_data_len;
+	const struct queue_entry *entry;
 
 	/* Get Set Broadcast Code command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
@@ -1086,6 +893,9 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 		return;
 	}
 
+	if (!bcast_src->bass)
+		return;
+
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
 	if (!bass_trigger_big_sync(bcast_src)) {
@@ -1103,36 +913,15 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 		return;
 	}
 
-	/* Try to sync to the source using the
-	 * received broadcast code
-	 */
-	len = sizeof(qos);
-	memset(&qos, 0, len);
-
-	if (!bcast_src->pa_sync_io)
-		return;
+	/* Set Broadcast Code */
+	memcpy(bcast_src->bcode, params->bcast_code, BT_BASS_BCAST_CODE_SIZE);
 
-	sk = g_io_channel_unix_get_fd(bcast_src->pa_sync_io);
+	for (entry = queue_get_entries(bcast_src->bass->io_cbs); entry;
+							entry = entry->next) {
+		struct bt_bass_io_cb *cb = entry->data;
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
-	if (err < 0) {
-		DBG(bcast_src->bass, "Failed to get iso qos");
-		return;
-	}
-
-	/* Update socket QoS with Broadcast Code */
-	memcpy(qos.bcast.bcode, params->bcast_code, BT_BASS_BCAST_CODE_SIZE);
-
-	if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
-				sizeof(qos)) < 0) {
-		DBG(bcast_src->bass, "Failed to set iso qos");
-		return;
-	}
-
-	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
-		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
-		g_error_free(gerr);
+		if (cb->accept && (cb->accept(bcast_src) < 0))
+			DBG(bass, "Unable to accept");
 	}
 }
 
@@ -1308,23 +1097,24 @@ static void bass_new(struct bt_bass_db *bdb)
 static void bass_bcast_src_free(void *data)
 {
 	struct bt_bcast_src *bcast_src = data;
+	const struct queue_entry *entry;
+
+	if (!bcast_src)
+		return;
 
 	for (int i = 0; i < bcast_src->num_subgroups; i++)
 		free(bcast_src->subgroup_data[i].meta);
 
 	free(bcast_src->subgroup_data);
 
-	if (bcast_src->listen_io) {
-		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->listen_io);
-	}
-
-	if (bcast_src->pa_sync_io) {
-		g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->pa_sync_io);
-	}
+	if (bcast_src->bass)
+		for (entry = queue_get_entries(bcast_src->bass->io_cbs);
+						entry; entry = entry->next) {
+			struct bt_bass_io_cb *cb = entry->data;
 
-	queue_destroy(bcast_src->bises, bass_bis_unref);
+			if (cb->io_destroy)
+				cb->io_destroy(bcast_src);
+		}
 
 	free(bcast_src);
 }
@@ -1335,6 +1125,9 @@ static void read_bcast_recv_state(bool success, uint8_t att_ecode,
 {
 	struct bt_bcast_src *bcast_src = user_data;
 
+	if (!bcast_src || !bcast_src->bass)
+		return;
+
 	if (!success) {
 		DBG(bcast_src->bass, "Unable to read "
 			"Broadcast Receive State: error 0x%02x",
@@ -1522,6 +1315,30 @@ static void bass_attached(void *data, void *user_data)
 	cb->attached(bass, cb->user_data);
 }
 
+static void bass_disconnected(int err, void *user_data)
+{
+	struct bt_bass *bass = user_data;
+
+	bass->disconn_id = 0;
+
+	DBG(bass, "bass %p disconnected err %d", bass, err);
+
+	bt_bass_detach(bass);
+}
+
+static void bass_attach_att(struct bt_bass *bass, struct bt_att *att)
+{
+	if (bass->disconn_id) {
+		if (att == bt_bass_get_att(bass))
+			return;
+		bt_att_unregister_disconnect(att, bass->disconn_id);
+	}
+
+	bass->disconn_id = bt_att_register_disconnect(att,
+							bass_disconnected,
+							bass, NULL);
+}
+
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -1533,8 +1350,10 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	queue_foreach(bass_cbs, bass_attached, bass);
 
-	if (!client)
+	if (!client) {
+		bass_attach_att(bass, bass->att);
 		return true;
+	}
 
 	if (bass->client)
 		return false;
@@ -1543,6 +1362,8 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 	if (!bass->client)
 		return false;
 
+	bass_attach_att(bass, bt_gatt_client_get_att(client));
+
 	bt_uuid16_create(&uuid, BASS_UUID);
 	gatt_db_foreach_service(bass->rdb->db, &uuid, foreach_bass_service,
 				bass);
@@ -1572,8 +1393,16 @@ void bt_bass_detach(struct bt_bass *bass)
 	if (!queue_remove(sessions, bass))
 		return;
 
-	bt_gatt_client_unref(bass->client);
-	bass->client = NULL;
+	if (bass->client) {
+		bt_att_unregister_disconnect(
+				bt_gatt_client_get_att(bass->client),
+				bass->disconn_id);
+		bt_gatt_client_unref(bass->client);
+		bass->client = NULL;
+	} else {
+		bt_att_unregister_disconnect(bass->att, bass->disconn_id);
+		bass->att = NULL;
+	}
 
 	queue_foreach(bass_cbs, bass_detached, bass);
 }
@@ -1591,13 +1420,32 @@ static void bass_db_free(void *data)
 	free(bdb);
 }
 
+static void bass_io_cb_free(void *data)
+{
+	struct bt_bass_io_cb *cb = data;
+
+	free(cb);
+}
+
 static void bass_free(void *data)
 {
 	struct bt_bass *bass = data;
+	const struct queue_entry *entry;
 
 	bt_bass_detach(bass);
 	bass_db_free(bass->rdb);
+
+	if (bass->ldb)
+		for (entry = queue_get_entries(bass->ldb->bcast_srcs);
+						entry; entry = entry->next) {
+			struct bt_bcast_src *bcast_src = entry->data;
+
+			if (bcast_src && bcast_src->bass == bass)
+				bcast_src->bass = NULL;
+		}
+
 	queue_destroy(bass->notify, NULL);
+	queue_destroy(bass->io_cbs, bass_io_cb_free);
 
 	free(bass);
 }
@@ -1692,6 +1540,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 	bass = new0(struct bt_bass, 1);
 	bass->ldb = db;
 	bass->notify = queue_new();
+	bass->io_cbs = queue_new();
 
 	if (!rdb)
 		goto done;
@@ -1782,3 +1631,51 @@ void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr)
 {
 	bass_db_new(db, adapter_bdaddr);
 }
+
+unsigned int bt_bass_io_cb_register(struct bt_bass *bass,
+				bt_bass_listen_func_t listen,
+				bt_bass_accept_func_t accept,
+				bt_bass_io_destroy_func_t io_destroy)
+{
+	struct bt_bass_io_cb *cb;
+	static unsigned int id;
+
+	if (!bass)
+		return 0;
+
+	cb = new0(struct bt_bass_io_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->listen = listen;
+	cb->accept = accept;
+	cb->io_destroy = io_destroy;
+
+	queue_push_tail(bass->io_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bass_io_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_bass_io_cb_unregister(struct bt_bass *bass,
+				unsigned int id)
+{
+	struct bt_bass_io_cb *cb;
+
+	if (!bass)
+		return false;
+
+	cb = queue_remove_if(bass->io_cbs, match_cb_id,
+						UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	free(cb);
+
+	return true;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index c4b5b76ba..db28628e7 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -8,6 +8,7 @@
  */
 
 struct bt_bass;
+struct bt_bass_io;
 
 #define NUM_BCAST_RECV_STATES				2
 #define BT_BASS_BCAST_CODE_SIZE				16
@@ -32,6 +33,9 @@ struct bt_bass;
 #define BT_BASS_BIG_ENC_STATE_DEC			0x02
 #define BT_BASS_BIG_ENC_STATE_BAD_CODE			0x03
 
+typedef void (*bt_bass_confirm_func_t)(void *user_data);
+typedef void (*bt_bass_connect_func_t)(void *user_data);
+
 /* BASS subgroup field of the Broadcast
  * Receive State characteristic
  */
@@ -53,12 +57,13 @@ struct bt_bcast_src {
 	uint32_t bid;
 	uint8_t sync_state;
 	uint8_t enc;
+	uint8_t bcode[BT_BASS_BCAST_CODE_SIZE];
 	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
 	uint8_t num_subgroups;
 	struct bt_bass_subgroup_data *subgroup_data;
-	GIOChannel *listen_io;
-	GIOChannel *pa_sync_io;
-	struct queue *bises;
+	struct bt_bass_io *io;
+	bt_bass_confirm_func_t confirm_cb;
+	bt_bass_connect_func_t connect_cb;
 };
 
 /* Broadcast Audio Scan Control Point
@@ -120,6 +125,11 @@ typedef void (*bt_bass_func_t)(struct bt_bass *bass, void *user_data);
 typedef void (*bt_bass_destroy_func_t)(void *user_data);
 typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 
+typedef int (*bt_bass_listen_func_t)(struct bt_bcast_src *bcast_src,
+				const bdaddr_t *src);
+typedef int (*bt_bass_accept_func_t)(struct bt_bcast_src *bcast_src);
+typedef void (*bt_bass_io_destroy_func_t)(struct bt_bcast_src *bcast_src);
+
 struct bt_att *bt_bass_get_att(struct bt_bass *bass);
 unsigned int bt_bass_register(bt_bass_func_t attached, bt_bass_func_t detached,
 							void *user_data);
@@ -134,3 +144,10 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
 bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att);
 void bt_bass_detach(struct bt_bass *bass);
 void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
+
+unsigned int bt_bass_io_cb_register(struct bt_bass *bass,
+				bt_bass_listen_func_t listen,
+				bt_bass_accept_func_t accept,
+				bt_bass_io_destroy_func_t io_destroy);
+bool bt_bass_io_cb_unregister(struct bt_bass *bass,
+				unsigned int id);
-- 
2.39.2

