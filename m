Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9213B7AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032251; cv=fail; b=muVpAu5MeqeA5E2VmSxo1aUa6L4GMlbf63jDasKQP/Mvq1agGpNAVQe0hjhBpyGl4FegbUycGuHXx5AO00T5tAClRIqMnMpFBvW0dGZ4bZ6nPcRjSXu8lAptqmc0YCBpkCsxyzioEBunH1YqwjgvDHLsKpuJpxKdsdVbJt97+Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032251; c=relaxed/simple;
	bh=CQuEZfzeX/7i++k6b+51kZsiB+lT9viCeqO3UeglZJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3NOsNavrld8Z1oSkDFcMIXbQkQ3z4PbjJcKcz+DZagGDQl33WNyvu/6PsWzKgSSFjfw5vM3vMBTvP68SnNmYUVRbr/MA6b3Sh/1pptQuLDCCgiNrgboHuW84UcVZhR/fbOdOOGHx8uCIiPh5roZ5XdDkMinsCBCL0ABONgypQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pomrf6Z5; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pomrf6Z5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1afoYgtPWaXlRbMVNXxQkKEwTPoSqnRryzhG2tLlmj3kxFNiVvwRBrRU5TlDvd+sDEoxqjOmfIvbTSW4BQKiZ96+UyA4WUbo4jcOPXR7ZycNhy8DtcEEeJ91UcCP7XLFnHh3ywLZUh+ydcr8DNiKDl2yhg5jYUaXPjxcvEHUoHHuRQ/yJlCiX3UwmnT8H4vnAU9CMXQV+HcQlffH7K+ck0mVtH/OId9HJC3/n+ts1wA6sH1sJ9vzXiRuY13C/V7L22dlF9sjJFNDl1JhLHvRL5QGDwMiz0gRsoUUI4SsST4TPSojdNDVRAZb7VyyM6V60+O/pJDcqpuyonUeHiAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzejN/d5rVJlgsEvWR4ctMLH1jEm0TmgBUt+ckCX6Ow=;
 b=IAOIukepp8TzqlfgWREQP2+2CBjJXK8m4hYXt0yxyRH2FSM63QB0LIUBS/kbx4mf04NiZHo0TJvlTK8FPAHzvwciVb5cX1ZgDQ4qZb4HVhMBVEIg4ej8/e9hI905sdGsYohFUcdQ7y2r3XiFAB+rvGCt3Gwhg/Qy0DkMrmhOLThKAhANY9PCY7XUPELKjj1RVAdr0H1MnEDR/8n6fMhIufBR0aU06nHJf8ndhCqc7QNRtVisMv0NX5HMh8kJsQYuYp8Kw+2GqFkafglHB+tCFKvM3iG2UldEhqQHgf/CDJI7Cc3U42EaaYcGQreCahMyIrpQLpQv7VTFHtfLyb2HGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzejN/d5rVJlgsEvWR4ctMLH1jEm0TmgBUt+ckCX6Ow=;
 b=Pomrf6Z5/3rdm03v47LvLokpIN1n+dOfHhiIFXZEvr+Jxb1tKqjA9GAwdTdKP3URBeGmaKqPy2h2FyrPKvTG/tiwZy4JewJ1vZ4wXDXnTPfkLYKWstgzLEWgPPZrL5VOofXMUBg7v6jGbhIZVj/0YK9Jv2W4xcspADTI05Bsz4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:07 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:06 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 2/7] bap: Split bap_state and bap_connecting in two functions
Date: Thu, 15 Feb 2024 23:23:51 +0200
Message-Id: <20240215212356.310301-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:208:14::21) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eae22b6-4da6-487d-5a43-08dc2e6c7106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sd2QYfqjldewgilbw8grBUB0czp595I1ZgDFNsBgPadYgvZuvqVKWCZP55ONipbcY6p3bri5SbJMPcPbyANo4YcJ1SjA8HR6T3vNNPRH+ULrjgqfnsfMEe7PNOANTsIApCXEPixDlH1StHFFGhMg90AynEMRISgJgnxvKzucievWxAEDAV3wFY26iIqZQil5CW7s+LkAIVY+mXht4D54ZbPJ2iYseQjgDGcT+7jF89IJ/2KoAgZRkSY5UTLB5EIxdPdZVH9ZqFt0+ZHgjDmgRQ95tCQiRM7oKLrS8GobOGgEgkSNIqvoAtATcxP6xhqTpZAzg52m+qnVVtGLfZ1bazgW+TRwpChGF/tBbJm6aGtxT6m7CXsoSj1f5N/rmEcI0pxtVk+fG3RPDEA37smSIJtgjtNS77yvi+2QsGDu+2/mJbxt1FZYdXuP99iVFOJyyh8wbYazdmW8FxaCeZbTMHgXg+RjK0DSP63ZeVw+Q4998R1dMmv9+UtjzyRL4xrP3D9Qnbo17rSu2oIE2T0Bw5cAEQRVwXThcfgCrVLjdCEPwWpJNclOKYHgm5LLsgU3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5OTOZLH937qV2W/pqoOdUmHwABrtPDB+8REQDwKIbdsju3JHxO0Q7PPqLijO?=
 =?us-ascii?Q?3DfM48ZOcOZ3ZqD9zt7N4hB+Ht0VaMd694IL4Mb+w3VUbApClMEWO3WNmPSM?=
 =?us-ascii?Q?Ac1ieoCq0HY1Y8FnND/qmC+rvufaiVf4dcnHbcoyjDmxgKZMDAq3B5YK4uMQ?=
 =?us-ascii?Q?SMY381/Pf3bMPKqIB9BWbKW8Pe/I+0womTVctq1dIAMLWNTv5kguasUxMN/f?=
 =?us-ascii?Q?6I8sdo3URa8tqdFIGC5k9dmv4gqSestmMCrX0EuG4aCrpESwpp94g2o2yutC?=
 =?us-ascii?Q?6kU9U5YfbXBWqCXskUB0rCfKNzbNYthSqGTJzAszAXE3+B9/rG57YUAtLAqt?=
 =?us-ascii?Q?gimlt7RdijauQGTSUaQVOqajYZNRFTdouIsN8rjKex9fQ2jcvqu6eY9d/unn?=
 =?us-ascii?Q?YVjRCk4Pysl3MAFYgHvgy5a5eocFM29dkCk1pZIornXHgJEBG1Eqzo4xpu9m?=
 =?us-ascii?Q?qEtD/ak8Xfeehdn1wDx15G0R0b3xIFEdNJkt9ff3SflI2V7oymqzTX7d+zDI?=
 =?us-ascii?Q?X9u28qhTZfJTjpzpvPM4zDsITqxWJfVZabYV6JO8fV/URiXTOfrJxzXDgOnN?=
 =?us-ascii?Q?3fYhZZ2V8vImMc81VjvsO6zd1SjlpIAFWST3LLGUC2g9bpPS4CtMu84kERvE?=
 =?us-ascii?Q?xbjLL4Pai4s14OpenxjShIrSe08x6456X3pmeDQ3C1s6A9PztF8+jiGGdVDO?=
 =?us-ascii?Q?LayOyDT/UFCxUcagtm5LoUHSBiwYAM+Ih1Jjz8RzM1GQvcxgTSoT9ZFuUeed?=
 =?us-ascii?Q?8wDK3GgcvpKsIP3mISdHcsEMRZctxehAkZGWWDS4w9tUS3bctzKDFccXNXxT?=
 =?us-ascii?Q?j52g1MAyEIT4/TiBfF0yLGArblSYq/E+ZEenyEj2q7bUtw2V4vDi03mqJntv?=
 =?us-ascii?Q?fGoQi7IYVHobVwXKt9HVxcMJpA4RHPv50f/ZNJeHdt6HolziVIn28Aat00Ck?=
 =?us-ascii?Q?hcs1s2fI4ZGzZjlUoauSxFNnMsaC6wPCzwVkpr/nVBU7p88Gtgrmy0Y6xNVY?=
 =?us-ascii?Q?sTvXOwvN2FgN4M5wZTzApdUpkFOX3+IHGX24O68aMydZcdHBBnjxT4P6PD6Q?=
 =?us-ascii?Q?oiGGln8AfK7eCvMhD9ATnPIhGu1EDIIiedDOjr6ylbuERqbrE6bf0puMXtHq?=
 =?us-ascii?Q?9gcExF/XdwbMoVKOCDtmmSmqO06knYxrSve7dXmwWaovICoHUOst0s0O0vBQ?=
 =?us-ascii?Q?833+7UdEHzjg170V+bkhG6Aw2CJMrv6fnzInOprvGYC9pLkpxNssJ1tZ3Z72?=
 =?us-ascii?Q?GqsL/LNWixLyZ9fWqrQW0mXjhmNynDxx4klMQCC2c8RbbR1yZe5VoQbIGW3v?=
 =?us-ascii?Q?oyx1XcVDS37PXACTCspc36uGbgQhs2ydHqD9pn5FEozOJ1ifZzkpbnxEwOLF?=
 =?us-ascii?Q?AmN57Y0q6A+E/boiW0ag7wCUIIgBbOY8DlzPD6p66UE+YpBnArH1raldbYA9?=
 =?us-ascii?Q?ycDNbKXn++2/4/StbH95ziLchBfno8a2SF2CyrZTChvO5jK3Yd0oJWCiVqK9?=
 =?us-ascii?Q?dterD5EvFbqc2qq4/sJrmJTZxp8rHYyxsnZuCjTNKeKJDhPuMytGru55PRm4?=
 =?us-ascii?Q?2BibAxszUvT7Gb9NPKRhWb328Sf+6j/Pr0JLWwDBOW3kicPf8j0IIvnHb0Ai?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eae22b6-4da6-487d-5a43-08dc2e6c7106
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:06.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBmtyg73AnJIJBs2qnDdoREwsjPKOzxvDEIzSCDNwfauNnF3PUHDu7tD4KP7BLZyyASRpMeFlqk8U1TiyWX8h+TvK/frDvT6OZdVA+Sj6b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

Split bap_state and bap_connecting in two specific functions
for unicast (bap_state, bap_connecting) and broadcast
(bap_state_bcast, bap_connecting_bcast).
---
 profiles/audio/bap.c | 157 +++++++++++++++++++++++++++++--------------
 1 file changed, 107 insertions(+), 50 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 38ee42894..b4acdd9ef 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2098,25 +2098,19 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-			if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
-				/* Wait QoS response to respond */
-				setup->id = bt_bap_stream_qos(stream,
-								&setup->qos,
-								qos_cb,	setup);
-				if (!setup->id) {
-					error("Failed to Configure QoS");
-					bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
+			/* Wait QoS response to respond */
+			setup->id = bt_bap_stream_qos(stream,
+							&setup->qos,
+							qos_cb,	setup);
+			if (!setup->id) {
+				error("Failed to Configure QoS");
+				bt_bap_stream_release(stream,
+							NULL, NULL);
 			}
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
 			setup_create_io(data, setup, stream, true);
-		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (setup)
@@ -2127,6 +2121,45 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	/* Ignore transitions back to same state */
+	if (new_state == old_state)
+		return;
+
+	setup = bap_find_setup_by_stream(data, stream);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Release stream if idle */
+		if (setup)
+			setup_free(setup);
+		else
+			queue_remove(data->streams, stream);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (setup && !setup->id) {
+			setup_create_io(data, setup, stream, true);
+			if (!setup->io) {
+				error("Unable to create io");
+				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream, NULL,
+								NULL);
+				return;
+			}
+		}
+		break;
+	}
+}
+
 static void pac_added(struct bt_bap_pac *pac, void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -2320,45 +2353,69 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	switch (bt_bap_stream_get_type(setup->stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		/* Attempt to get CIG/CIS if they have not been set */
-		if (qos->ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
-				qos->ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
-			struct bt_iso_qos iso_qos;
+	/* Attempt to get CIG/CIS if they have not been set */
+	if (qos->ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+			qos->ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
+		struct bt_iso_qos iso_qos;
 
-			if (!io_get_qos(io, &iso_qos)) {
-				g_io_channel_unref(io);
-				return;
-			}
-
-			qos->ucast.cig_id = iso_qos.ucast.cig;
-			qos->ucast.cis_id = iso_qos.ucast.cis;
+		if (!io_get_qos(io, &iso_qos)) {
+			g_io_channel_unref(io);
+			return;
 		}
 
-		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
-				qos->ucast.cig_id, qos->ucast.cis_id);
-		break;
-	case BT_BAP_STREAM_TYPE_BCAST:
-		/* Attempt to get BIG/BIS if they have not been set */
-		if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
-				setup->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
-			struct bt_iso_qos iso_qos;
+		qos->ucast.cig_id = iso_qos.ucast.cig;
+		qos->ucast.cis_id = iso_qos.ucast.cis;
+	}
 
-			if (!io_get_qos(io, &iso_qos)) {
-				g_io_channel_unref(io);
-				return;
-			}
+	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+			qos->ucast.cig_id, qos->ucast.cis_id);
+}
 
-			qos->bcast.big = iso_qos.bcast.big;
-			qos->bcast.bis = iso_qos.bcast.bis;
-			bt_bap_stream_config(setup->stream, qos, setup->caps,
-								NULL, NULL);
+static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
+							int fd, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+	GIOChannel *io;
+
+	if (!state)
+		return;
+
+	setup = bap_find_setup_by_stream(data, stream);
+	if (!setup)
+		return;
+
+	setup->recreate = false;
+
+	if (!setup->io) {
+		io = g_io_channel_unix_new(fd);
+		setup->io_id = g_io_add_watch(io,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				setup_io_disconnected, setup);
+		setup->io = io;
+	} else
+		io = setup->io;
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	/* Attempt to get BIG/BIS if they have not been set */
+	if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+			setup->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+		struct bt_iso_qos iso_qos;
+
+		if (!io_get_qos(io, &iso_qos)) {
+			g_io_channel_unref(io);
+			return;
 		}
 
-		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-				qos->bcast.big, qos->bcast.bis);
+		setup->qos.bcast.big = iso_qos.bcast.big;
+		setup->qos.bcast.bis = iso_qos.bcast.bis;
+		bt_bap_stream_config(setup->stream, &setup->qos, setup->caps,
+							NULL, NULL);
 	}
+
+	DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+			setup->qos.bcast.big, setup->qos.bcast.bis);
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -2456,10 +2513,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state,
-						bap_connecting, data, NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
-				 pac_removed_broadcast, data, NULL);
+				pac_removed_broadcast, data, NULL);
 
 	bt_bap_set_user_data(data->bap, service);
 
@@ -2611,8 +2668,8 @@ static int bap_adapter_probe(struct btd_profile *p,
 		return -EINVAL;
 	}
 
-	data->state_id = bt_bap_state_register(data->bap, bap_state,
-						bap_connecting, data, NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
 
-- 
2.39.2

