Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F113B797
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032267; cv=fail; b=TXXQ0M3DzdCyA3dk6EeT03CheeZ7NtxmM0PLrR3RWS06Niau2xtsZGvc9RlRtAzp5n4kkriqNJDn2jD66jpC9AX8IBtU1rUMh3HDbVSgpp82f+0h8Q647/nyh1gPVlWaZ8AoIY0gwEnjzWy9ztjBgdfwErD2c66FFGyxyQv35zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032267; c=relaxed/simple;
	bh=S3NgYAYWSH4jUus3GVUCs4NAH9loNLYAAZuoLBY+mIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LaJTnE4cw/n/j1dhzCDiYugamH1D2hgcKNGrk6aLg6x5pus9xJTOkAnx1xTxWb908dEATSJ0IwzjzSqxwH9i+4CvoqsR603gpYeALbam+v7pO8LnA6yJX82xQ7ZQu7RN1Lc9if32gMddmaj6KCGAJPo2CykeFl3qw40+5+IPYW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JwAxzPhl; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JwAxzPhl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyHeD0PFHhfFW1qbw/dHOzTsTHcNRVErYcjt3dNkL9P+4/NVF9g3VGZr/DY/Q/XVapTzCBdSZtLrzlBSkl4ymUGNVRAUl7REEFzyCk+ppWtSsLcd2dw+4o99SAue/ywuvrn1nYt2AOF7bOMWLYmEU4vN8Sm7a6LcLswwbfPHqtcMb9zQ08sAn9a8spfig/SJYmkK4oWUDy0kIV2HVnUqF5hLigJUa4/oSpXFW/wLk9qNgvladO6mrNtIfTUh26YZFUfAWeX/q/M9QNNe0u7lu9sBJjabyPNyou8ciG72GhMmCgbse8RUkSXLGHlgM3KIm+fiYrfacB2L0nQCacxIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7Q6DvTpWtVEAiw+hB+abya7gumyH2qfZneiv9NJ24s=;
 b=ZfOQgHsiOyJ7RvNy+p+8WkXMPeiJkPwDZcgX77eRx9cH4x0bp0ErP04adDi0yFm6j2bopzBq32n9god1dkPxcSADb9L90JpNlg2QMLtvlPo9piLfaHwAvPKrszCnlFmNOb8YTi4pY733GRXGqRmUN/37Rgn88RlglmgZRPA6PVYbw8Vvl1WVKinY/3nGvPkB2fQOoY8D6mzGLjmPGIRR6a7xlgs/HXBctfnS3LpC9DGwqB/rotTE8PYI2uNQKzT9fJOBH7fbpNAT7nBwnGxWibwrV8eJ7oce7VUXDYieqqtLQc2GRmuzkeWU80P3z/MzqH1GNjkd93WVcq2gtq5O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7Q6DvTpWtVEAiw+hB+abya7gumyH2qfZneiv9NJ24s=;
 b=JwAxzPhldXJcVXRy3yMnmJ/TYjyPYxpRYTIueM0ocpW/kls0g+96+/Fr1QjkyiGfx6wxI0Hfjk5hzIK1pzmD/sVra1soxF/o1/loxKReDs7GBn/Oo3vRAnxZJuvdMCk9bk2iPxNyyLodogGbrTZxyubcATEg8UtvIEymwG2Guxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 21:24:21 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:21 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 7/7] bap: Set generated BASE on all setups from the same BIG
Date: Thu, 15 Feb 2024 23:23:56 +0200
Message-Id: <20240215212356.310301-8-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: ad53f06f-5310-4a18-ed1f-08dc2e6c79a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EPP8mSNQ6PK3hSrCeGYhS+nXEt0sxG8nUA1ZA/BOjB5BhJrFznFDcrWJu8Bkprai6GBeR95KyQVfgkrDk3vc2YYZbBBUiBvkDKCGeorDpw3BlE8IJk1tlzbZf9WlfdbEC6w+JcrFABhD97CLmFzUbNCXKnVS8RRDWP3A/IQN9CjcPveKDAb37tTmF99CMpUwHk9Tkku/s7khoH9YuB067ThX8+KrLoYvJ8e0Fq652OsC7Otjc1s4fdsTLLYdgzct/ASvd9Uouyw4RqbBNep2CKQbhYPnBjhl4lOjYrIIbNi8EQZf/A1gusXzw7IjnhDVxKWkdrkdABlue0/vQP3gBZyFqmcawMsUuo0HZ/MJrcI33WmaL9kjB5cBClJrgCpQergJzjEYgk2zLLYTu3fHQGeaFD+cNcUCQ+zedlYYStKujRFYpnmQDwaBZ7D3yp0xMzGXCXqbjsjtGXFHHJH/FXtyFa4DKlhs4APyF9JZBMrlWFBBIZaEtOorJju533NNlZ4sb6dBEc3hQ4oGfgnazisEMG6Nvum/00bbRDhXYP8hSPczsPpxjYgloWUyL/k1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(1076003)(2616005)(26005)(316002)(6666004)(41300700001)(6486002)(6506007)(6512007)(5660300002)(66556008)(66476007)(66946007)(4326008)(8936002)(6916009)(8676002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppUCoZuvcvIqL/n/JuvlDN/zkAl/rBW3EqY5Oy54fFYylNBi9Q3P03GTC8QR?=
 =?us-ascii?Q?JAVND7IVDmu2vZwlK1mYvOnoOOkGFxNAThD4mxcxSkrp9jIeSCXnsCgdYR8e?=
 =?us-ascii?Q?JpuDtKqOB6Ta6bfZLszixtnE8tqiFLoDfdH4x1wjqS0RNw2t7aM/zbL85lSv?=
 =?us-ascii?Q?Qhw5ux2CAaHjubev4ba8zY1iM2Lulo/xQSmknGTtVuPOAscuaUzwC/5if8hH?=
 =?us-ascii?Q?bQWpnXuDEQL6WvIzthIwfbaR0YLog+H/aYrpZ9Pz0xvG1LTWpkdAbrFAtvkk?=
 =?us-ascii?Q?Lw+9J1gWVVHUK0e1OrUvihATLzZrRVIR3VlbSjJYZxNTgsS44qmZyKGJmwUe?=
 =?us-ascii?Q?eaOfRiTa5rhMDX2Q++q8uDwPH79q6HygYlCrfHzSVMo/hodbxiGl/y0a71eU?=
 =?us-ascii?Q?PxoiXyY2mV3j6DW7r02D/AnPdbJl1TntsPdTCwqIFL71sNd3S91M6flmaeTf?=
 =?us-ascii?Q?+oNb83vR6b3WBKMDwa/wN5mCsRHVXE5jncBenXy9gk0KMyBz6Qgy28NBodTq?=
 =?us-ascii?Q?Q7T73RlPis70nCkYG3Yhe7NJ8cVec/YWxFj2i2bozrhgdkQHFD0Nwmgf0P/Y?=
 =?us-ascii?Q?M2lq872NytlVQsrHHcNjFAFZmD7ec6ABnxGJww76qb9UizMXuzWZA/jR7stg?=
 =?us-ascii?Q?xJsr6pi7b+lDYl6WvoBDnSKSNAklAEsb139O4p+bbUtEcwb140YVOU213ylP?=
 =?us-ascii?Q?iOqT4g+70y5N3I/6ItodcEXozTUIKM4G3qldjehBUhVpE+KuAzhvX/H9+q+4?=
 =?us-ascii?Q?wvdImlcJULyXvjmMj82XWqmMz4doNyYNHM9vNqUOtauak5VsgaIyoiiBO87C?=
 =?us-ascii?Q?DOEPQ7aQw9R9ZyZHt8iMk8rn/zIMsEHkrtuzmsCbxe2Db3iiP25VzS9dDJ6t?=
 =?us-ascii?Q?merlQbX3WC38QRFDmdutFz9cbpT9t4hdc3XmySeFXNO/a6F3qQHfVMOQlLsj?=
 =?us-ascii?Q?S88GG6pg+BZozzrJJr8MJNb7FW8J3WQiBs0l2bbFQO+1AdHSNVCK2vPBdB5p?=
 =?us-ascii?Q?uvwkiLwMd91lAE2UjY9t0bf6up7VxUm1g9l+3nQ+aIwf49fThd6lCi9szxAr?=
 =?us-ascii?Q?K0FS0mPDFWV+K2X+rzp7rl5x2sO6P5FnXvy+531XHu8YXj+LMvTbgcbYfcfJ?=
 =?us-ascii?Q?rDP2z4Z9vJQFEAVL1sJCR1R/rrm9Oh99+F93lXbNRLc/TyPglefBsBuxMVgo?=
 =?us-ascii?Q?PNFPy3QU0N9XLKgtWkfmdSyju/jpRFjp1oduyZH9Sm7X+ztyynnRMzCxjR1L?=
 =?us-ascii?Q?Mq/NK37UZ+HLhRkYVfuwG0JOsE/93Pzx67TlX8XxAbPKzyYblxoM4zyGQM92?=
 =?us-ascii?Q?Pax31FoWmxV7X7usnf7x2jcVkzRKXAVyaYylGifseRYe1ha3vEm6Qe+w1Z7B?=
 =?us-ascii?Q?txOXe12llQoHO/lcorfv3dJf81yLeTyX3ltFxcvGK8PzCTHWtMmqYQechDbh?=
 =?us-ascii?Q?LzE/TPQEtB2CB49vjHAu1OS1frEccnRpRoc+fobZydpltTNVDbroTUe8XRFR?=
 =?us-ascii?Q?umYdi9PKthRBtdgKIE65lKB9lg33D69+upFXYw8DFhr7DzRYT++rDy4mUXEx?=
 =?us-ascii?Q?NslhfLgnfhtsWvoKpRThjjO0b1HB90DRy4ao+eaQaERIaOoOAjwmx2X3y1DP?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad53f06f-5310-4a18-ed1f-08dc2e6c79a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:21.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oromHn8pi5VGIzaYrkXM/HoJ10U5k8YHSFkr5X3StAlG8DQo63jU0vPnqzyugI9TtkEk6CAdV3zKX9tarkcRvYjd/0FtmIszeerhhFjPr+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

Set the BASE generated in BlueZ on all setups from the same BIG,
and use defer to inform the kernel when to create the BIG.

---
 profiles/audio/bap.c | 160 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 144 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b4acdd9ef..def5e1432 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -943,8 +943,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	/* Disconnect IOs if connecting since QoS is going to be reconfigured */
-	ep_close(ep);
+	/* Broadcast source supports multiple setups, each setup will be BIS
+	 * and will be configured with the set_configuration command
+	 * TO DO reconfiguration of a BIS.
+	 */
+	if (bt_bap_pac_get_type(ep->lpac) != BT_BAP_BCAST_SOURCE)
+		ep_close(ep);
 
 	setup = setup_new(ep);
 
@@ -980,7 +984,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
 			setup->msg = dbus_message_ref(msg);
 		else {
-			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
 		}
 
@@ -1846,7 +1849,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1883,7 +1886,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -2012,9 +2015,6 @@ static void setup_create_bcast_io(struct bap_data *data,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = setup->qos.bcast.big;
 	iso_qos.bcast.bis = setup->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
@@ -2031,9 +2031,10 @@ static void setup_create_bcast_io(struct bap_data *data,
 	iso_qos.bcast.timeout = setup->qos.bcast.timeout;
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
-		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
+		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
+			defer);
 	else
 		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
 }
@@ -2121,11 +2122,77 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+/* This function will call setup_create_io on all BISes from a BIG.
+ * The defer parameter will be set on true on all but the last one.
+ */
+static bool create_io_bises(struct bap_setup *setup,
+				uint8_t nb_bises, struct bap_data *data)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+	bool defer = true;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.big !=
+				bt_bap_stream_get_qos(setup->stream)->bcast.big)
+			continue;
+
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.bis ==
+				nb_bises)
+			defer = false;
+
+		setup_create_io(data, ent_setup, ent_setup->stream, defer);
+		if (!ent_setup->io) {
+			error("Unable to create io");
+			goto fail;
+		}
+	}
+
+	return true;
+
+fail:
+	/* Clear the io of the created sockets if one
+	 * socket creation fails.
+	 */
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.big !=
+				bt_bap_stream_get_qos(setup->stream)->bcast.big)
+			continue;
+
+		if (setup->io)
+			g_io_channel_unref(setup->io);
+	}
+	return false;
+}
+
+static void iterate_setup_update_base(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct bap_setup *data_setup = user_data;
+
+	if ((setup->stream != data_setup->stream) &&
+		(setup->qos.bcast.big == data_setup->qos.bcast.big)) {
+
+		if (setup->base)
+			util_iov_free(setup->base, 1);
+
+		setup->base = util_iov_dup(data_setup->base, 1);
+	}
+}
+
 static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
 	struct bap_setup *setup;
+	bool defer = false;
+	uint8_t nb_bises = 0;
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
@@ -2146,14 +2213,75 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
+		if (!setup || setup->id)
+			break;
+		/* If the stream is attached to a
+		 * broadcast sink endpoint.
+		 */
+		if (bt_bap_stream_io_dir(stream) ==
+				BT_BAP_BCAST_SOURCE) {
+			setup_create_io(data, setup, stream, defer);
 			if (!setup->io) {
 				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
+				if (old_state !=
+					BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream,
+							NULL, NULL);
+			}
+		} else {
+			/* If the stream attached to a broadcast
+			 * source endpoint generate the base.
+			 */
+			if (setup->base == NULL) {
+				setup->base = bt_bap_stream_get_base(
+						setup->stream);
+				/* Set the generated BASE on all setups
+				 * from the same BIG.
+				 */
+				queue_foreach(setup->ep->setups,
+					iterate_setup_update_base, setup);
+			}
+			/* If there is only one BIS create the io
+			 * with defer false
+			 */
+			if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET) {
+				setup_create_io(data, setup,
+					stream, defer);
+				if (!setup->io) {
+					error("Unable to create io");
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+								NULL, NULL);
+				}
+			} else {
+				/* The kernel has 2 requirements when handling
+				 * multiple BIS connections for the same BIG:
+				 * 1 - setup_create_io for all but the last BIS
+				 * must be with defer true so we can inform the
+				 * kernel when to start the BIG.
+				 * 2 - The order in which the setup_create_io
+				 * are called must be in the order of BIS
+				 * indexes in BASE from first to last.
+				 * To address this requirement we will call
+				 * setup_create_io on all BISes only when all
+				 * transport acquire have been received and will
+				 * send it in the order of the BIS index
+				 * from BASE.
+				 */
+				nb_bises = bt_bap_get_streams_by_state(
+					setup->stream,
+					BT_BAP_STREAM_STATE_CONFIG);
+
+				if (!nb_bises)
+					break;
+
+				if (!create_io_bises(setup, nb_bises, data)) {
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+							NULL, NULL);
+				}
 			}
 		}
 		break;
-- 
2.39.2

