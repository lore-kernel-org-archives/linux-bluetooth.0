Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD61FAC34
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917953; cv=fail; b=TYwf3jgkAFOoj9M90DtI/v/vVCFEQZcjq8kN0aIE5Ss42lCeLqaFpbrbUkQQmo9MnX/R4tUCm2eITpxlX/7JRc+C75sh95ai1gFDhK93T0WlyCHeg/uq7vsdEn01gEHUfe2KbNbyBuEVNtnn74xULZq2RDzVV4RaWmINrWUR0xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917953; c=relaxed/simple;
	bh=uXt2/LO/Me+fqen0y6uPxRk8SN9kT4B7lXFBV3g3e4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbPzOCAcfW+P0L2OGCai4avUcK+YatuAuGF3zIAfsmIY1Ay5DuIxCwu6AOUmbTT4kbP4cl2CB0FjkmpoWgS8ne4jg2Lr5OfJpzKHBVAbW0BiShMYQQKMUuzkovl3lyog7eyw8w1FIYjJ0kHY7tNb4AsfguxS0D7s4/+m5hiq0BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1VGtGS/; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1VGtGS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXw5bKHkZiBgbKMtNzP0RzlrWF2+eR63nrbgyN7XGLV0iIaXK9iJIQ9LQ4kP/1VgHImoZ9ZHDK0Rw4PNL1fb6CRAQv8PX34L7UyjwqD1fg9x6s/ohv8fIu1YA5M4jQXlifUHm6szwnO/9CmkBXh/t4s0IaDJZCAJPPUoDUzg0t/FNdRoWOFjgKp0Nu707J3haQZHkoXmtz23+AJrMOheOgrIKz4yiDVbFnzqdweSAnTsIxtWCj8KGGJ5waOJBmw9e40sC2kTw69KZlSsus4zeeEWkALXN/Kia/ZVbZLK8iktN7BRFR1MAEdNouAj7oW4nYwoVPnH0ceqPTnGq6y55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGjt+sz1NmQpVsv8bhlcXsvxirVsvPbANbzVF+RDI1U=;
 b=qME+M72Y5Vp754gSUR15BaJ5xdcjKgs3Ozg5qbDrlJi2kx1Lp3aIP3iEHwkjPOCaGrz6d6ucK04eBJkc6cOlrENF7Xv5F5aNMsMIa0OQrwIBI0oRLJDW8c42bu2m3kLX2IyVK43v0R3KbxoM26L9bQIjMoavBYThQgr4uilFHcqhW7wmXQPMTZfcuq0iZ3B2NESonrICZzcaGuzCBrOtS9MhcU8a3WbV9k3l8ha1VFTJ4WkJsoSFKMSChP/oZiPjjkjH8S2ZLTDnnYWz7WTZdu3IEXkVDJb+bl+qC4+KpW5PVk/AT5rVscx2MiVDXUb1pjClXd8CtVpfcb0RPqTYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGjt+sz1NmQpVsv8bhlcXsvxirVsvPbANbzVF+RDI1U=;
 b=m1VGtGS/qNSsXT7AQ0U3KubbhapAAxRafU5zyZ1DJD/rD8qm8bTHguaFbHC9Db9aijmSKswwH4Zrr5q50JzlfRCN3q8ireOfjc9nvoV39jiODPDiZ/19FgLi48KWTxzO8tkM7KToPWTD9ToWmpLK0YbY1eSa4k7FHUdbV6Vx4XUAGdh0NHfaGYSdg5+a+GfMRcfJcx7H1HoeNmHoMIJV33UFY9qC/tiptUr/J3mynyaTYNPdd1ySC7yZDCMNNPXV9bZainhG2ywXM/oaP61e+PUjMubBcbjgKEXPeRUKuA32TzYP0ZRYQsso74wMG747woUbTMYf2uuQXbZhrqEEyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10542.eurprd04.prod.outlook.com (2603:10a6:800:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:52:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 15:52:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bass: Add support for selecting multiple transports
Date: Tue, 25 Mar 2025 17:52:11 +0200
Message-ID: <20250325155211.18111-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325155211.18111-1-iulia.tanasescu@nxp.com>
References: <20250325155211.18111-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abcbecf-c903-47c5-7dbd-08dd6bb50a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+bUutltUsxpH6DJKYJb65CZ0LbKBsarC0JgWtKWhfeNEur34dXtlrF2ICoM?=
 =?us-ascii?Q?l6xIEuIUisGAU+1ghJmv7zGfUxeEn1oSNZxto8wkrc4vA8e2e4din/ZLZNgS?=
 =?us-ascii?Q?h+i3MCReYD8lM00gV8JTFIcxwt98VwtcwIl1ZGgiFSruTChz8SeE2u0Xz94n?=
 =?us-ascii?Q?e9DrCkssZE5Db4rAyjnREOUa8rBxjDYUCc3M0QBxmZMPOKOQRxRQCwwqaUQZ?=
 =?us-ascii?Q?9nOWIxfkWCaP+VJ8/7SYu+z6GoJ+GiVV4OWC+WEjsSh54jjR064nzKtdYgzq?=
 =?us-ascii?Q?yxid+lGn6dXoUyPbkz50emaKHi9oUPTOYrKAIcWboLOn9FQUQXxZag7Ull3m?=
 =?us-ascii?Q?6lyW10x9Q5IyLc3yWdjbt4ydd/p7x7fLWsF/xndoi1RayRQ32MNiG5zfVHDt?=
 =?us-ascii?Q?BNNSYXQzyyQK9xsPBIX4aca7JeEzxrEF9WJrKdGUEBFUTw6WcopyxSRSjbtG?=
 =?us-ascii?Q?vw7deMGJ4N/2uxQR4/V9G9bvwGFmTY70pQk+YZwm2lwGrtxhmWbDncVK4rpW?=
 =?us-ascii?Q?W6EVv1LVLgOrl5Rw0kO+0p6hJZUDBiKoj7TvYjFK/unPqRbSV+hs1tl9qAAE?=
 =?us-ascii?Q?jaqbbg0RkLBV/p//V+Oj2Lf5Azw73c7ecJg3nFxrUYr+ea/Q8zf2tDcGe2GX?=
 =?us-ascii?Q?XRro1PUULuujgTyGiOnuEsyBUfTYB5k0oIMqAuF5LPj88p7tEQoVbgd9LCbU?=
 =?us-ascii?Q?CX1rvcN3fiJ5Y8aYhvopPjvo/M05TDAIxLyTRGQB1YcF4mAXkOd5GRbhZNUs?=
 =?us-ascii?Q?/8Pi59n+EDlH3zm7OLm+kCETK9sdmoL+sfcCDsSV3CGIhNP/dC2ZpYoeii6G?=
 =?us-ascii?Q?Hs+Vx5lMwfyf+gY1us8syoGWEEQISc55P/YzieAeEU9cYplmCExdDzrSTYkU?=
 =?us-ascii?Q?lYZ85hIONGZID4nM6Jj5h/6zUe0pwazg/DWU18XgUYV9O1vVTgxD2u60IIzT?=
 =?us-ascii?Q?bwVeZLbzkHltGqOlKzy01eBP6QVKG3yej8qPizc9FiGsWsBoovtRqQTneSpN?=
 =?us-ascii?Q?6fIa3S3eWy66NE9R+Ga6jyxGd8OjQpWw0pQgnSWXFwHjeVQwa4dXKR2Nc5BE?=
 =?us-ascii?Q?JxTnkUwMSxlMeDismwfexLDAUEqjMCQNswSsMm6cRe/oBvqX/IJi0Tfhcw1z?=
 =?us-ascii?Q?S9zES0YGTO0NVDWInM/vXS0Mi469P/pjzlFtCDTeqfZyJoTRuzn15Bg8z+G/?=
 =?us-ascii?Q?0m25rigWJUEuX98FKSg0oFL7UTa+VS4pmSUBiLy87d/jPB8OT8rW1jZQrEjC?=
 =?us-ascii?Q?0IZjwd7tztW12PZcU8UQSVSLio1GI/Xa5WQ4IEcqtMWiktORDyHCTv49naau?=
 =?us-ascii?Q?a9Ssx0FvddfKZwbHv/bv9BwCCwHIoCILyftEcUBouxl3M3nq6Qd6A2YuyV+y?=
 =?us-ascii?Q?z4lEVhFGz/FP7GbcQaBxo3DLUEeu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFb982RrmYZkv7WGq1MJajftq1xlp9BZQn23ZV3TNxeOzi9u7Gk9IABFBrx3?=
 =?us-ascii?Q?ekuvZD3Sr9rof1W81SB+/skgHHSqLRtwl1FWH8E92NxJ/yXFf6EZGDSL6HjV?=
 =?us-ascii?Q?kDaZ7pg0ZSsl9/WBGV2TAMSfIqcsdg5Let/mc/MgeFWYLzTXagcVIriqYtkO?=
 =?us-ascii?Q?utMWYFKtdiaNFoQZuK+KMtrlt/0JNe3IFDuBey+kRJZhZc5gfbjgfKLKPnTl?=
 =?us-ascii?Q?NKQR7m8gs9xM+RACiPAyQiU+3KNwg+LjyQ/yZ/nRm3+0iXPMvZRb1dgSUXIs?=
 =?us-ascii?Q?7dVkLtCE2zPGD/v2JHii/UkGAZvo3ao7OKhdwTFOLfsExYiJTdVoOTy2El/E?=
 =?us-ascii?Q?1MC2qFwJGwqmMUxM07ZmEcFeHqLO0dIlYVfGsvBhXZvkEDndjZb396o3la2e?=
 =?us-ascii?Q?aLfZ+k/dFuuN9uyY4iGaPZrxWR3UsmowuWjwM9GZJ+c/tQ0hd/QqJH++7kLq?=
 =?us-ascii?Q?tkl8dMA21BVkyYYE+ubxiSE7guxwZMKL4OAO37YfFkHlZRtnkqvPA1plrSBH?=
 =?us-ascii?Q?bPTRqlj27YZ8c2yCckpCYKNsx5en5WKLPhK6iM+D4GSejLGtYCkR5m65EZvV?=
 =?us-ascii?Q?yA6bqxOAHsSaz0/mog430BjkMtow1mlANKpk1qfpWzO05CMJE4egwxD19/G9?=
 =?us-ascii?Q?QqdcMxX5ClCQM04nV4coAWTOUBQ0nN3GWB9bUnY3nz11x/BxT8Hn/vJHTV6C?=
 =?us-ascii?Q?h73wzekBeN7tHTplkNWBstMGjjJNh8cA6KJ2eAzy7SE3i+rgiaAu0GPcSAzX?=
 =?us-ascii?Q?FRi5E7ljvLsRKeUjlSwcvkG1IeUB+ZWPv7jvFA6Uwzmphayt3uYzIIxpOax3?=
 =?us-ascii?Q?xEJr7IU7iG7/BMCF8Ck05w4kp3rmJWVy9beSLKxQ5ZQItQectH0kYaCc0hTr?=
 =?us-ascii?Q?9hDAvEUOsxA2d4xhHYWF5UG5pVjTg52lrBHlF0V0maF5Ah6C6V+hliZ4n9mG?=
 =?us-ascii?Q?kxn3W4RAum9hI5au2jfAuaN5GALH+lbokwPb7nL7ZLYCZlz1fNQUEZ9iosB5?=
 =?us-ascii?Q?AHz3ohUZC7/XErT6Abid1rPic47dxCzfA46nI9jabZ04Cub730TlqkqfDEOb?=
 =?us-ascii?Q?qYodpnj4YfFaiRj6/MJJlRew+zkPUPYk66P57TqQPbSwvwmMH4duCqqndrmc?=
 =?us-ascii?Q?KkuCwYn06iYS09pZM9b4fxl3GNONkBIZqU562QEKNuizoySh8cH4rGi3obpo?=
 =?us-ascii?Q?or/aBAYdoxQ5AWrHtOfgPymj64IMfFrjs4CG94bgrOn35U5ujgpj9ibdcbeK?=
 =?us-ascii?Q?qkMAJdQzYmOqTcLUKi9LVSGQzs/i3Zj9fhIg2/g5Xz5+P5U+pxkEiAv6/ZPT?=
 =?us-ascii?Q?FvFd8gOsnOVcXiuN8XhmihFNsNdkBCsvFXCac3qn0F9y0Nnhh2StMr6F2wyJ?=
 =?us-ascii?Q?NFgvQHddsFZyx1f9mxVEMyUURYMA0FpgFFRfMoxqSUeEF/ODEkB0oG18NrBF?=
 =?us-ascii?Q?xJGphDwIWCLWW8F2z5MFtjMqE7WrxcsgUGE3TazVSxUx3kQiuiuP0JC9JZMU?=
 =?us-ascii?Q?hlhyKjSZBrR97IsjTKSWCaIl7ZenWsWp7CyPXaY2UBJWak5SltRLEUbp74gk?=
 =?us-ascii?Q?B7TToAwvsrHjsdFPn9InlyxirqmeKiK5G6MM6yHqbyAWh9hqIccN4Cwxl8p4?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abcbecf-c903-47c5-7dbd-08dd6bb50a32
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:52:26.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcZYlZwOK0iuI/XE9UMGbFsCQ/Ahgz0qoOiuskHyKSUsEJnoeDW8tOZB0EZ7ZnbeuNl57UX5qRgnKdw0RBp/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10542

This adds support for the BAP Scan Delegator to select multiple transports
added by a Broadcast Assistant and to acquire them one by one to receive
the streams.

Fixes: https://github.com/bluez/bluez/issues/1139
---
 profiles/audio/bass.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d299791c8..c36f43277 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -297,25 +297,15 @@ static bool link_io_unset(const void *data, const void *match_data)
 	return !bt_bap_stream_get_io(link);
 }
 
-static bool setup_find_enabling(const void *data, const void *match_data)
-{
-	const struct bass_setup *setup = data;
-
-	return (bt_bap_stream_get_state(setup->stream) ==
-				BT_BAP_STREAM_STATE_ENABLING);
-}
-
 static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bass_delegator *dg = user_data;
-	struct bass_setup *setup;
+	struct bass_setup *setup = user_data;
 	struct bt_bap_stream *stream;
 	struct queue *links;
 	int fd;
 
 	DBG("");
 
-	setup = queue_find(dg->setups, setup_find_enabling, NULL);
 	if (!setup || !setup->stream)
 		return;
 
@@ -333,6 +323,15 @@ static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 	}
 }
 
+static bool link_enabled(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+	uint8_t state = bt_bap_stream_get_state(stream);
+
+	return ((state == BT_BAP_STREAM_STATE_ENABLING) ||
+			bt_bap_stream_get_io(stream));
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -358,6 +357,23 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_ENABLING:
+		links = bt_bap_stream_io_get_links(stream);
+
+		if (bt_bap_stream_get_io(stream) ||
+			queue_find(links, link_enabled, NULL))
+			/* The first enabled link will create and set fds
+			 * for all links.
+			 *
+			 * If the stream io has already been set, the stream
+			 * will automatically be started once all state_changed
+			 * callbacks are notified.
+			 *
+			 * If there is any other linked stream that has already
+			 * been enabled, the stream fd will be set once it is
+			 * notified from kernel and the stream will be started.
+			 */
+			break;
+
 		iso_bc_addr.bc_bdaddr_type =
 				btd_device_get_bdaddr_type(dg->device);
 		memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(dg->device),
@@ -365,8 +381,6 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 
 		append_stream(stream, &iso_bc_addr);
 
-		links = bt_bap_stream_io_get_links(stream);
-
 		queue_foreach(links, append_stream, &iso_bc_addr);
 
 		bt_bap_qos_to_iso_qos(bap_qos, &qos);
@@ -380,7 +394,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 
 		if (!bt_io_bcast_accept(dg->io,
-				connect_cb, dg, NULL, &gerr,
+				connect_cb, setup, NULL, &gerr,
 				BT_IO_OPT_ISO_BC_NUM_BIS,
 				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
 				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
-- 
2.43.0

