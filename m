Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105815B110
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801335; cv=fail; b=asTGinmNZcLHUkD81ghD4nqKwRbsYAUvDFEGGQlJbGt4Q8X6Gx8xiYg9FMuqbSEKdfM01P7r1kFW27NeU3o3+blp5jxgb1NKSfD8q6LUgLN3KyZcTmF26+SveDECnPItJupPEzLhmuECuetXaNZ83vEZfvHAuyxKexII4AUrUyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801335; c=relaxed/simple;
	bh=2+rnxZS5GAbHXvmsMT7aTo2xah1MLOHPkv9IU8guoqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMK2OQ+p3PMz6dfzHezICfYq0Z+c+6AcA+TysgZICV7U8DV35Yyq6++6lcqG4mT8I3Mn+U3NfN1+7p4p70sYCxZa8FVwYn1iu25vlLKvURE5iZ7DkrNyHe8A0TAos4r85Ql6bqdSQWMCh1wQeRXZ5lZCwreVn/ctCnQC/ct/BrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oyxj5OUj; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oyxj5OUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHW7bNqvBqz3N5ZIgHwc8y0pfHpTnOHDLtiPEfhyM5XkVEeQ8M3eESKkfzBdbJizMTCUmufN4g3rca37j1T4Xvjs4r+VCLAkmRpew/YAeruVj3psa7uQlk+X3S3LRZl7XBxNEahCPWrvUfhWbRqpROCtMPCxODNOVVdz8um3fJrlSNPqZF4sU11t18nWq/aFq3iTsh+VMCoAJC5ZP8WbrFJCJazrfbgwgcCqSMxgzzRuMmTO4obqyaQVGk/ejAjNK1g5KYuv9pQDSLXK8yoe1pdxJ7u0M4giIVFEgpSPogRbHlNfKK17UMjkM9uToqwAz4ojqX5kkcVtO0JwTw6P3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlBl5FkjzHqZrIjpRfWCN1ec8DZjoWESmbYhsbwfsVc=;
 b=FgFat9iZ9qHwPAoFyDsXidwZOoA20A5oZPm/WfrjwLNTqW4CCxNvxBimFhh63/Yd3u/f6hvFgslEIdS2HFYEjsPXafQDWqRJEJf3tewJyzeC6ApTPG+qptlOuRc3K/XXY6FuV4IfxmSVJCeJJKBqvH8ly9/GSTkdosTYCWziZTlZtZw+rIrFn09L8bfXP/2wdyGWa+vNgyn+qqJVDq/7uBUmJeXic0YlmlZhC4zP6R299YzVIi6LuNHAMGtMXSlNX/CSmCd7/jFWMCALAWVyhdltbVsOsZeQ9mGvbaJ6Wh1/+2kjKlCpntQ0rcssdqJXoJnnsmeU6ToXKyFqF2mqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlBl5FkjzHqZrIjpRfWCN1ec8DZjoWESmbYhsbwfsVc=;
 b=Oyxj5OUjoGecBfKRjn2p2h6xXcEkh1/XAa9aL/fZzFCE2C5Hqp/FeX3OnRLkufs4GX+ixOHGEJUrm8ophxPEgxE2zuXvrW6uNjUNlcZxeTPsfCtbrYVvAY3e18xr6G0nLr1qk3eNM4TjB+g2V4Qj0MyOFuuwJNAjk1lZSnhJ3jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:51 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:51 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 4/7] bap: Split bap_state and bap_connecting in two functions
Date: Thu,  1 Feb 2024 17:28:32 +0200
Message-Id: <20240201152835.196617-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::23) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ee59a8-8aa3-4749-8dff-08dc233a7df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZISoujeAToMs7r4ddBzBOIpxzQndCMnO1NQqCAkqm3ziO+jyRcdRkRSF0oJSc4vrulnAxuLddVQKrhJM6gshpqOBIXpfyGT62/m64DqFCtHIIX1CLUjcwoKahs1HxVI3GndZ/NFwrRfWCKhcDpYUAbGqwCFiEvU2MqSFQmJCDy58vdJfdiIJXst79wv7xsZyD/REbKPxp+nPysM8wvvECEShSU/EGV/M5+IJIQJ1GnZFbPiSJ2jBS53Y0QJS/gzAt5fGkcjeRVYVjHY2yd9+oRTbki/Yv1QlInTGaMvnKVDjDfUpy6t/XNlJo/54dNmoP8Z7PUOYLdb5f+je+hboQaVg7S3d/HHXkvHhSuZyH9fSe1ACOvJJiOX0v8eSbBPv0x9WLcOskOZ1wRbLsXg0+nT6HSxrXQYsr3ndtwpA6tLv8rI2doKPrymcdGKuNiF3dU7mOgfC+qoUEqxjfSVwzFB/YkTLvjkaqxX8/V5DWUEzEHXR5nCnX0SPJZBY/Zmxy4zayk2SOXeuFUsuNjNBwrWObN3uR53RngbIqlSMiKBYq7Au7u0yVWYE5fX91fj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/C1TBn5jmTt7+tdjokTPrmy0KucuD0RCKZTNcWVfr0ku/y181wIcw+Ppalkn?=
 =?us-ascii?Q?SI78/VrUkBYtuniqP7pEGXS5s8Du55svzHj7LVOEuRKFVkX17GPAJ5sQ4UqY?=
 =?us-ascii?Q?4xfZcH0UzWIO+C5HeqrYf1l6hX0gbwVyrYbC1df8hy4C5nFbQSpMgrcIIUJ1?=
 =?us-ascii?Q?wKIkQ0tSRbQsgGZPjtvEvFR1i/jZ9jTlTd8T7rhSMWq5g6tdxj4jPYSV3Ive?=
 =?us-ascii?Q?/IZFQjRxbvJQko/LsTxJPGA9lVeMGFu3Pi4/vlzC41U+8zbXmMW1eI8a1Twb?=
 =?us-ascii?Q?U0VTMjf5Pc0RwTVC0UtWaW9cMU1BopeWLpWa5jJh+OzPc/qDBD5JEn1V0K1Y?=
 =?us-ascii?Q?JIvUZIpFBuzk8JLjg0JcoyrPTvERv9b2DDKVVDfDoyytHYsgQUwp/hrCMPCu?=
 =?us-ascii?Q?eTrbGNN2PiFydia2ZXOdJBfZxYxVrsYUaDh46ymgt9/o2C605LYaZk4olafm?=
 =?us-ascii?Q?FxAnRbPj6rSFg4pczxNEtYj0exAI6Dd351JGT5hymA1ndHpNNJw0mBAzt/w/?=
 =?us-ascii?Q?ECnhkHGofd4Utv588UTzYqrg6gxaGx0j3YG1WtnlwM7qJXPpKKxyxsOlx+Tb?=
 =?us-ascii?Q?v9OrfXXycdn4SHiJo5fH/aXM4XbDpNEbBprYxFyJfJaeP1sI5EeTVXm2xfib?=
 =?us-ascii?Q?mVoARdvqhp6xnFr2ONIWNyYaPjkqSAAS0R7ca0kE85q0e/VAVWruYObGF5+a?=
 =?us-ascii?Q?kb4Fh8Q7NCdkgvzsMmMsdOnI/JWOrRTUfWfE5Khas6R4VzQNKiEYMHaLriWt?=
 =?us-ascii?Q?7X9jGGDkjyUSSghGh8qkF1GojUzIAaJrGD/GV1eEa/0uGABsUdQgk9pI4GFl?=
 =?us-ascii?Q?z+Phe2B8PNa4niN7t/NfSeAcIDvVKNT++RRoqJ/02tfxMqkTNLEbmTPlPXR5?=
 =?us-ascii?Q?mpz4B30bWwhgks2eq+i1U+dsd4jEGdgBC5HJvTHWFjjMH8b/hXCrfbCRWlQq?=
 =?us-ascii?Q?9jOFXKOkvaNNXzDrZkCnZxeS0bcPgZYdIldeQ85ep0dk/Rcc9a1cnHEVREBx?=
 =?us-ascii?Q?vY+1Vjmpa0dw4bzhE5D+Xf8xeP7N8+BccLzL+rczr+aUAoGMa+ZlCpEWNbft?=
 =?us-ascii?Q?JoRpjWCr+7nflg2UvLvyrJSo4PObf5jU5yj/3PhDnjea+LAgM1GniG2Glc3k?=
 =?us-ascii?Q?X2lCJubwm+VOeY5I84PMLqXAVjKh/d387V0rY4f0PZGIOegevILHjT6SzE2g?=
 =?us-ascii?Q?dnGF5UzQafYkdXVWfxxU7TnU6Re3eJg/YKuGllS0S+Nc4iJwF/n9Hd4766tU?=
 =?us-ascii?Q?Jwn1oMM4iXreiqMAV4zzKqAiDbxcrFoBMzZj7iM3dtWLcDfkd8fQb1+kl6bz?=
 =?us-ascii?Q?CoylC7tcp7w+aRnOh4Js1sa2GYsV1s/u0kNhG4fywbnwMvn/LeSDA2tM6oWb?=
 =?us-ascii?Q?gAaloO2/FdEU/c0Q4rkPJEzysqJMiPfnQ3/CzARFMmwkQkc7HH4Koyzm1ZQl?=
 =?us-ascii?Q?jiIFdqDaesgKvQvzcpES+ArgDIzkQoh1kC5Fu0iMWau7uQ6M0N4A9E+h58+d?=
 =?us-ascii?Q?+jdyfHiOuuTrEe7xkEdS7fcPnATGY4qmuYUTftEgbAGDqVLTWCXN3ghtAfYu?=
 =?us-ascii?Q?oNpzIVVd3Sn2sYLALKche0zCdyw5ARv4lBVJUdcL09x4sx3mWnfe6DIWBUV+?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ee59a8-8aa3-4749-8dff-08dc233a7df5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:50.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX27KroztoYwGQueMYxuVnrlGZiA7z6wiOLizwomhcNuQVX0JkUQtbUOPJGcbG/5xldhymIRyZ5JLAWFePcJ4LL0BLb38Bhwa8X9DKPffpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Split bap_state and bap_connecting in two specific functions
for unicast (bap_state, bap_connecting) and broadcast
(bap_state_bcast, bap_connecting_bcast).

---
 profiles/audio/bap.c | 159 +++++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 50 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9300e98ec..7d7a3ce02 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2099,25 +2099,19 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -2128,6 +2122,45 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -2321,45 +2354,71 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
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
+
+static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
+							int fd, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+	struct bt_bap_qos *qos;
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
+	qos = &setup->qos;
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
 
-			qos->bcast.big = iso_qos.bcast.big;
-			qos->bcast.bis = iso_qos.bcast.bis;
-			bt_bap_stream_config(setup->stream, qos, setup->caps,
-								NULL, NULL);
+		if (!io_get_qos(io, &iso_qos)) {
+			g_io_channel_unref(io);
+			return;
 		}
 
-		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-				qos->bcast.big, qos->bcast.bis);
+		qos->bcast.big = iso_qos.bcast.big;
+		qos->bcast.bis = iso_qos.bcast.bis;
+		bt_bap_stream_config(setup->stream, qos, setup->caps,
+							NULL, NULL);
 	}
+
+	DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+			qos->bcast.big, qos->bcast.bis);
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -2452,10 +2511,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
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
 
@@ -2607,8 +2666,8 @@ static int bap_adapter_probe(struct btd_profile *p,
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

