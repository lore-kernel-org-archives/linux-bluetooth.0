Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FB19E971
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098394; cv=fail; b=az38p25akPuQ/HX6U+EYUtcomjiUvfWMDblxc6fJmUu2zlTO12FiNTl5tMaIHSLGsOTqriXNgtVB8WphZ7g4YeL2zPTlaZBmlhCw9CQE+UdMaEiVoFMC5tjNm9OUyO2qk49P8PFDsaC14EU4sH/jG+6gggqrkJqI5zwj+07aTbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098394; c=relaxed/simple;
	bh=OGFlKRLdMFvT6jb44gBgMXr6Yu8dyb0wc+oLzc2qb/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaCLr5AoTas9BIgAh3QbBVing+WGl8I1o93foZYD5Hf/8NSBfCnTd8NLlJtsVTV2LxsLEjWobeNjPWQP+UxX/20Ts2mB217XYnlxG2wwlZ2bpeIcYLzD9gUSqVv6Qfpxnp8ef6aX/Cin+l+uH09F/UkgDgXHr8lhr4AJLrICycQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O1UzB7/C; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O1UzB7/C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAZ+C4yI6cx5DwddrRMDYV11zY5SzprzpQl0Ki3TDXTwoCq2oBiFa42Z6mRzN3Ejw/lvVWEDgtVEuWW0eTYhT5nOefmuMikrFOq1RhM2lAOI1ajUp0IzP4HsCNEW8UpLSvC0N+wviGDP+qUrl+3CJxF5claviE9S4MVnVjXOPEDk2WtmCRnzakoFaY/awC/OOntCPywHJVjceHIw9NR/MMJYshx4tr6HLS9kDBTVrxpxg1cLBreONwWAngOZ7NXpCdi3CdFQ6er2dy+1wyrs23PEaIAOWUOdaHRbTYLWFO84wdkS9TcLZV7Grmom7qLlNXfeaLHLetAcTPUYFTSX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzKNjZnmRPRC+eGHldCkm1pl1dB2je8+8EBJzdzgk6I=;
 b=l0M4UjzLeYgCPkhyvrm/+wnaZpxvgeshrZXr9oDGFUh5Al652H3Rf9iPPMH13eKrG9jj15Rl3xuB7d2N3eW+fOD/CUl4ReKD43Rs90IAKPJ8CmMz5poVz78+BNNCYnLBR8M4xGbUZszjBfUwphz9UHCYmxfuRURCxB/iHkeg0XCEuXFns71qGDIOdn98myS/3QjeW3En2vMB7lGIVvIB5XY9rBKv4xh3E9Pn3Cw0t+K6Z/xpFFeVnUQ+rNnNoip0HTBrgnfpzSzDIdVV9gdE7enWaweWMI5Og+nwjKfvrNVL9UMYIwMrCAF/7eYsE9r5e0xRyHOxNX8V9rq2z5Hokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzKNjZnmRPRC+eGHldCkm1pl1dB2je8+8EBJzdzgk6I=;
 b=O1UzB7/Cd3OacJ09zV2GHr/kjSiKvYoP+y8UGPhm2ciIomgRkdMH61EbbtDtuoBvlXT7EZbMnfGpKYeAfkQtMuHJ1Vit1bDwViLs0PiMnO5tstb3FWpjBnkqgM4rtae/WJ+uiuh4v/VdZhZlkpsMmn3gg+rBb2uTOpavDfHREgPP+0wV88p7zSoRDoNOM7tYOWLGfaxq15f16T1NfiOrbWiQIsaO2XE72IbIRcEyjASun4nHb/gyXGrQ6MhPBaVbQeNq+gv1TGEm+GQUHgOGmlVUFBCQfztppRY5a6CpWHoxEI3ZbXvz6jYHidQRnhLIDgVRgUFxzNTCBuVC0vqdVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10389.eurprd04.prod.outlook.com (2603:10a6:800:217::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:26:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 5/7] bass: Rework Scan Delegator to handle BAP streams
Date: Wed, 20 Nov 2024 12:25:59 +0200
Message-ID: <20241120102601.38415-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcd3974-a967-4d8c-31e2-08dd094dcb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZ1bBK1ULGYO3mc6wCOp12b5TEIJao2iIT07klRNX9YDXiIu8uoHOOhS3eWT?=
 =?us-ascii?Q?jzMBWeuWt3h0iOFlqfSzBIf6ibyhfyxdVGeYvuVLq68Kr//6c3slZrxmloNS?=
 =?us-ascii?Q?0UWN6kFc8MlV8tTOs+vygz5fHc3/GKeiYVso1TIwlADGh8d+YuVo9zYaR0DY?=
 =?us-ascii?Q?jn4Al2f+5GZB9THpWOd0ctyhG7cUhoA02SKpfF6UK3udoLNrlbxCoV2eA3r2?=
 =?us-ascii?Q?4y0k77vrk6DC9jMsEcfeQcHQWmRVpXKgcCtxCC6WAOsxTmEQG5fuzYRDxG4c?=
 =?us-ascii?Q?tRimrekoojiQlTwSB2x77bY12ifBGZtAisylJJ1TsBax6BlfU7dECm0vCzjN?=
 =?us-ascii?Q?bcN8fJvSEf0DewqqLjwkqeiugJ5LHUTQiLePhKLarKyi9eUA+YBF67vk3VYa?=
 =?us-ascii?Q?jv1aizL7Wg9LfcTcfiC9BNG27gZXlQGFjEoWeunz+EHC8/TbFVDSZtgJTio6?=
 =?us-ascii?Q?w5hudilskKEFX4BkCGVqF7sP+o/1f+5Obj35Fv1eQQjn4eG8QhHbhNkryhfS?=
 =?us-ascii?Q?zx4EiZmfz52vdM8frv3TCuhhUrP56XgEqOR90O+ta5qeWs7SSdZ8IH7wUfMy?=
 =?us-ascii?Q?EYAMhUXeppRs6NAcS3rwTmhkX74Txl5Mf+BAEFgyfCpzgDfSab175+Hq5k/e?=
 =?us-ascii?Q?ZhNjPAEt45KDlwU3tJ5DmZFnuF/5zj73TUNbryfldyKPAvLWjhepmsQ9RLpp?=
 =?us-ascii?Q?K7HW0I1nM1VCAD0RqAZ7j/1V3j01I5CVN3nanjgBI1AtLSWAUa+Zvm8zlCzv?=
 =?us-ascii?Q?jZ7sZ+a+1H4nHvilYUq31BUDn7hfRchr+yF/aXx7EH8RMrClle0Dz+bJJRmV?=
 =?us-ascii?Q?fJbE8pPhvVlkwTZ+fNl3PWAqbrFezDG/xkgrCaIzXSR9rpqgtrlPhBxnDDG4?=
 =?us-ascii?Q?DewYCqbHKoEZRQvWW7pAwbwip8JTljtvQNg0JoMYBA4fPZjJ7NyMhtoDMu+x?=
 =?us-ascii?Q?fXIPAPA9UIK/oIKzZdFbBS879ibEN2GdAZmOfv6EcjCrZrUD7h6C3hScpcxJ?=
 =?us-ascii?Q?gjX8L8XjS0FB49JfCD9rb9KgNHVhbTXMNT+c7t92kNsz9YTU8fYAWN7i+UF1?=
 =?us-ascii?Q?bNxjeLAsa5kah27rnDgLnoWSf6RVZwt4hyoMV/qchl/RtQfbV7dx/vAOVkxQ?=
 =?us-ascii?Q?V4g/Gd8TTyan1pLw3lSHWw8jjGkPLjy33vDilLWhhG/70khTuMhNMEonHMjD?=
 =?us-ascii?Q?d5WoBpD7zQCzN6tYatcii6XUZ89WPEgiXFLAXtuqLWfb4EjMZ9JmFZgv1RO4?=
 =?us-ascii?Q?t5WajimQEC9AMMqNP1W7A0l1LwH7AXFunOM3wCulLDZ+/zMwLYaIAYvLrMhN?=
 =?us-ascii?Q?6VQgkChm2MqZcgyrThH0a5qG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvpEyLt9RwJ14Q7gXwCoY/87jHeB7vdgcign7NB4VMmGG1cUQKJF3A2a2Zeg?=
 =?us-ascii?Q?GRv+wi+XYVpMGeOKvbECHt8R5kbXXaAvisys2p+UESnioeHULk6CnE8qAhv8?=
 =?us-ascii?Q?dghloLqNG6ohgBSzeNmoFxYJZNK7u2zATPUnnnctDWMTB91Uc841OBLMZjUu?=
 =?us-ascii?Q?EuwEkgjsA477tM4CpXOE0OmgrHbB0jJnfZ6FJ8yGS71j1dgetqANyOUcDqwb?=
 =?us-ascii?Q?yzavzTZq5Ghs67sbFmOy16GCNb77WTZ1ZyIHbUFqi+WetVYpoG7mk2YlfTo4?=
 =?us-ascii?Q?4+l4+Y6hyT8mre6ieZY48IHD1H3yAC2MMadAOS/RRT1YTm8Ql7lt70OtcyOf?=
 =?us-ascii?Q?nwwSCrjJdXfUIgMQvBr0mRjpUiT0BKhfUdU3vfDHmYNhn4ZeCYVA+tjHZJNT?=
 =?us-ascii?Q?TfPyQ6jmmYmxvv7TGR7dbBeOx3GXa27jtp055RP3zd1XI4BQs/y0BZg4ceiJ?=
 =?us-ascii?Q?Hn0UAMWGvqf3mu6a6sBexdcIwhjpB4P5b17UlcHbX9IZbAucl2UstRx2Wb6V?=
 =?us-ascii?Q?Qv3vqMlFFrqty51z0fmkoGKZy67FkZxnSrWQdgpVmfzSRqFH0VYYdgF7ZSTV?=
 =?us-ascii?Q?Oqpf7jwo8v5GWKhRzUVpMegZlvnbMnM/YM4MLuYWGQ+XeteeEXqWnk9s8H5Z?=
 =?us-ascii?Q?nfTxB+akycVheSM/MnpNUHfXlhvyENix+iDZal/xbDPCwrVUtlAi8JAdODKQ?=
 =?us-ascii?Q?9L7NZOsz8jfVEhSPmFeesT3/PR4WfqA1zS4QnqzUt7Gc9c9kcpHgB9FQuakf?=
 =?us-ascii?Q?mqPN+B8Dpvefd/kKawA6hwsNi3JCCCKVOq7d9fKOHsungNWJHZXq7FvMArSY?=
 =?us-ascii?Q?p0CaQf0iB8EUlOrNbe7LkoSFoqXQY84QDsN44+NNpChijsxWjGAAOLh+GfUQ?=
 =?us-ascii?Q?FiSmG6YumsvejqZf/Z7DOBfcRyrYcPR23JMSu7pld8a+goTu5RtgGNb2JEKy?=
 =?us-ascii?Q?HkotCYHmQWR1wwdL2UnGkzqQ4iyzNjOiKLIEhg7wEDR3n7njvkMnkphTj62i?=
 =?us-ascii?Q?fW5ySKHfnIZ+AsX8/kG+A5V4C4tEdJI6CQymr+ar6AzDMeBSrrM8YD2F8IoU?=
 =?us-ascii?Q?k0ViJgWN7c2Dh7ZxOXO1hS0APV7SxwG60JCst0yp6PXeaavQxgy3XfGVIDbM?=
 =?us-ascii?Q?T8yVQtDm2C/2LE4tsBMc6v1X0JtxCiKHGkm1RW7gDDFyMoCJGPGHmh/JSWf4?=
 =?us-ascii?Q?XQAiYIrILYJnE6W3YFfqKMmaMPO9g3udVHePrwebj0Hb09i2uWXuUiJHfitg?=
 =?us-ascii?Q?/XEbGPLBpp87GIdcyQJVKAfbmL/T69G9BUIUE6Wc3PYgrBy6VKWCY5eE4dIS?=
 =?us-ascii?Q?DyGGz5sLHFvx0K2RFOuBSsMffXjY63iQpJ1+pYjYxA1MFdbqCeQ2YaXpIowP?=
 =?us-ascii?Q?Y9bnR2xuFRFA54otCK4cp9s1pdczYLbmx4EY3fhjw6DUQGBrQF7Fbq6i4U8x?=
 =?us-ascii?Q?oIPb/ibvLSpPJjN2EpjJjItEbG1zvGjxAV9/hIr8PCFXFn/6zly0kreOiKhL?=
 =?us-ascii?Q?QR+bykbFEYWlwdEYkbs5ijx4gNlBa8YinfBHx5fNWfwZsQplqcrMa4QzNbEL?=
 =?us-ascii?Q?KK2gyaMvrcXcCMnYXqFmtNwP/F3grswJxp4W/Folry85PLG02gK5wpnowxfr?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcd3974-a967-4d8c-31e2-08dd094dcb28
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:28.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISFHeT5DTNj+VEMFPwh1TykhmTSaAhTzunAgcJ/pn3dAkWRLbqvZCLtAfcFCAPTUWI6j5TrpHwB8gPGJcRQTaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10389

This updates the Scan Delegator implementation to be handled internally in
BASS: The BASS Server is responsible to handle Write Commands for the Add
Source operation by creating long-lived PA sync, parsing the BASE,
creating and configuring BAP streams, as well as enabling them.
---
 profiles/audio/bap.c  |  18 +--
 profiles/audio/bass.c | 332 ++++++++++++++++++++++++++++++++++++------
 profiles/audio/bass.h |   4 +-
 3 files changed, 297 insertions(+), 57 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 675c33c6d..a1cb3aeae 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1119,14 +1119,6 @@ static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 
 	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
 
-	if (!bass_check_bis(data->device, bis))
-		/* If this Broadcast Sink is acting as a Scan
-		 * Delegator, only attempt to create streams
-		 * for the BISes required by the peer Broadcast
-		 * Assistant.
-		 */
-		return;
-
 	/* Check if this BIS matches any local PAC */
 	bt_bap_verify_bis(data->bap, bis,
 			caps, &lpac);
@@ -1186,9 +1178,6 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		g_io_channel_shutdown(io, TRUE, NULL);
 	}
 
-	/* Notify the BASS plugin about the session. */
-	bass_bcast_probe(data->device, data->bap);
-
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -2598,6 +2587,8 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 		return;
 
 	setup = bap_find_setup_by_stream(data, stream);
+	if (!setup)
+		return;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
@@ -3145,6 +3136,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct bap_bcast_pa_req *req;
 	uint8_t type = BAP_PA_LONG_REQ;
 	struct bap_data *data;
+	int ret = 0;
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
 		error("BAP requires ISO Socket which is not enabled");
@@ -3198,6 +3190,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
+	if (bass_bcast_probe(service, &ret))
+		/* Return if probed device was handled inside BASS. */
+		return ret;
+
 	/* Start the PA timer if it hasn't been started yet */
 	if (data->adapter->pa_timer_id == 0)
 		data->adapter->pa_timer_id = g_timeout_add_seconds(
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d3b35f62a..21f708ba6 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -29,6 +29,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -42,6 +43,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/ad.h"
 
+#include "btio/btio.h"
 #include "src/plugin.h"
 #include "src/gatt-database.h"
 #include "src/device.h"
@@ -101,16 +103,28 @@ struct bass_assistant {
 
 struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
+	struct btd_service *service;
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
 	unsigned int state_id;
 	uint8_t *bcode;
 	unsigned int timeout;
 	struct queue *bcode_reqs;
+	struct queue *setups;
+	unsigned int io_id;
+	GIOChannel *io;
 };
 
-struct bass_bcode_req {
+struct bass_setup {
+	struct bass_delegator *dg;
 	struct bt_bap_stream *stream;
+	struct bt_bap_qos qos;
+	struct iovec *meta;
+	struct iovec *config;
+};
+
+struct bass_bcode_req {
+	struct bass_setup *setup;
 	bt_bass_bcode_func_t cb;
 	void *user_data;
 };
@@ -153,18 +167,30 @@ static bool delegator_match_bap(const void *data, const void *match_data)
 	return dg->bap == bap;
 }
 
-static void stream_set_bcode(uint8_t *bcode, struct bt_bap_stream *stream,
+static void setup_set_bcode(uint8_t *bcode, struct bass_setup *setup,
 				bt_bass_bcode_func_t cb, void *user_data)
 {
-	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(setup->stream);
+
+	/* Allocate Broadcast Code inside setup QoS */
+	util_iov_free(setup->qos.bcast.bcode, 1);
+	setup->qos.bcast.bcode = util_iov_new(bcode, BT_BASS_BCAST_CODE_SIZE);
 
-	/* Allocate Broadcast Code inside stream QoS */
-	qos->bcast.bcode = util_iov_new(bcode, BT_BASS_BCAST_CODE_SIZE);
+	/* Refresh stream bcode */
+	qos->bcast.bcode = setup->qos.bcast.bcode;
 
 	if (cb)
 		cb(user_data, 0);
 }
 
+static bool match_setup_stream(const void *data, const void *user_data)
+{
+	const struct bass_setup *setup = data;
+	const struct bt_bap_stream *stream = user_data;
+
+	return setup->stream == stream;
+}
+
 void bass_req_bcode(struct bt_bap_stream *stream,
 				bt_bass_bcode_func_t cb,
 				void *user_data)
@@ -172,6 +198,7 @@ void bass_req_bcode(struct bt_bap_stream *stream,
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
 	struct bass_delegator *dg;
 	struct bass_bcode_req *req;
+	struct bass_setup *setup;
 
 	dg = queue_find(delegators, delegator_match_bap, bap);
 	if (!dg) {
@@ -179,9 +206,15 @@ void bass_req_bcode(struct bt_bap_stream *stream,
 		return;
 	}
 
+	setup = queue_find(dg->setups, match_setup_stream, stream);
+	if (!setup) {
+		cb(user_data, -EINVAL);
+		return;
+	}
+
 	if (dg->bcode) {
 		/* Broadcast Code has already been received before. */
-		stream_set_bcode(dg->bcode, stream, cb, user_data);
+		setup_set_bcode(dg->bcode, setup, cb, user_data);
 		return;
 	}
 
@@ -193,7 +226,7 @@ void bass_req_bcode(struct bt_bap_stream *stream,
 	if (!req)
 		return;
 
-	req->stream = stream;
+	req->setup = setup;
 	req->cb = cb;
 	req->user_data = user_data;
 
@@ -218,18 +251,58 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
-bool bass_check_bis(struct btd_device *device, uint8_t bis)
+static int stream_get_bis(struct bt_bap_stream *stream)
 {
-	struct bass_delegator *dg;
+	char *path = bt_bap_stream_get_user_data(stream);
+	const char *strbis;
+	int bis;
 
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		return true;
+	strbis = strstr(path, "/bis");
+	if (!strbis)
+		return 0;
 
-	if (!bt_bass_check_bis(dg->src, bis))
-		return false;
+	if (sscanf(strbis, "/bis%d", &bis) < 0)
+		return 0;
 
-	return true;
+	return bis;
+}
+
+static void append_stream(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct sockaddr_iso_bc *addr = user_data;
+	uint8_t bis = stream_get_bis(stream);
+
+	DBG("%d", bis);
+
+	addr->bc_bis[addr->bc_num_bis] = bis;
+	addr->bc_num_bis++;
+}
+
+static bool link_io_unset(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *link = (struct bt_bap_stream *)data;
+
+	return !bt_bap_stream_get_io(link);
+}
+
+static void connect_cb(GIOChannel *io, GError *err, void *user_data)
+{
+	struct bt_bap_stream *stream = user_data;
+	struct queue *links = bt_bap_stream_io_get_links(stream);
+	int fd;
+
+	DBG("");
+
+	/* Set fds for the stream and all its links. */
+	if (bt_bap_stream_get_io(stream))
+		stream = queue_find(links, link_io_unset, NULL);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	if (bt_bap_stream_set_io(stream, fd)) {
+		g_io_channel_set_close_on_unref(io, FALSE);
+	}
 }
 
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
@@ -237,31 +310,54 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 {
 	struct bass_delegator *dg = user_data;
 	int bis;
-	char *path = bt_bap_stream_get_user_data(stream);
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
-	const char *strbis;
-	int err;
+	struct sockaddr_iso_bc iso_bc_addr = {0};
+	struct queue *links;
+	GError *gerr = NULL;
+	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(stream);
+	struct bt_iso_qos qos;
 
 	if (dg->bap != bap)
 		return;
 
-	strbis = strstr(path, "/bis");
-	if (strbis == NULL) {
-		DBG("bis index cannot be found");
-		return;
-	}
-
-	err = sscanf(strbis, "/bis%d", &bis);
-	if (err < 0) {
-		DBG("sscanf error");
-		return;
-	}
+	bis = stream_get_bis(stream);
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
 			bt_bap_stream_statestr(new_state), new_state);
 
 	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		iso_bc_addr.bc_bdaddr_type =
+				btd_device_get_bdaddr_type(dg->device);
+		memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(dg->device),
+				sizeof(bdaddr_t));
+
+		append_stream(stream, &iso_bc_addr);
+
+		links = bt_bap_stream_io_get_links(stream);
+
+		queue_foreach(links, append_stream, &iso_bc_addr);
+
+		bap_qos_to_iso_qos(bap_qos, &qos);
+
+		if (!bt_io_set(dg->io, &gerr,
+				BT_IO_OPT_QOS, &qos,
+				BT_IO_OPT_INVALID)) {
+			error("bt_io_set: %s", gerr->message);
+			g_error_free(gerr);
+			break;
+		}
+
+		if (!bt_io_bcast_accept(dg->io,
+				connect_cb, stream, NULL, &gerr,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+			error("bt_io_bcast_accept: %s", gerr->message);
+			g_error_free(gerr);
+		}
+		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		/* BAP stream was started. Mark BIS index as synced inside the
 		 * Broadcast Receive State characteristic and notify peers about
@@ -280,17 +376,99 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
-bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
+static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
-	struct bass_delegator *dg;
+	struct bass_delegator *dg = user_data;
+	struct bt_bap_pac *lpac;
+	char *path;
+	struct bass_setup *setup;
 
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		return false;
+	/* Only handle streams required by the Brodcast Assistant. */
+	if (!bt_bass_check_bis(dg->src, bis))
+		return;
 
-	DBG("%p", dg);
+	/* Check if this stream caps match any local PAC */
+	bt_bap_verify_bis(dg->bap, bis, caps, &lpac);
+	if (!lpac)
+		return;
+
+	if (asprintf(&path, "%s/bis%d", device_get_path(dg->device), bis) < 0)
+		return;
+
+	setup = new0(struct bass_setup, 1);
+	if (!setup)
+		return;
+
+	setup->dg = dg;
+
+	setup->qos = *qos;
+	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+
+	setup->meta = util_iov_dup(meta, 1);
+	setup->config = util_iov_dup(caps, 1);
+
+	setup->stream = bt_bap_stream_new(dg->bap, lpac, NULL,
+					&setup->qos, setup->config);
+	if (!setup->stream)
+		return;
+
+	queue_push_tail(dg->setups, setup);
+
+	bt_bap_stream_set_user_data(setup->stream, path);
+	bt_bap_stream_config(setup->stream, &setup->qos,
+			setup->config, NULL, NULL);
+	bt_bap_stream_metadata(setup->stream, setup->meta,
+			NULL, NULL);
+}
+
+static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bass_delegator *dg = user_data;
+	GError *err = NULL;
+	struct bt_iso_base base;
+	struct bt_iso_qos qos;
+	struct iovec iov;
+	struct bt_bap_qos bap_qos = {0};
+
+	dg->io_id = 0;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return FALSE;
+	}
+
+	iov.iov_base = base.base;
+	iov.iov_len = base.base_len;
+
+	/* Create BAP QoS structure */
+	bap_iso_qos_to_bap_qos(&qos, &bap_qos);
+
+	bt_bap_parse_base(&iov, &bap_qos, bass_debug, bis_handler, dg);
+
+	util_iov_free(bap_qos.bcast.bcode, 1);
+
+	return FALSE;
+}
 
-	dg->bap = bap;
+static void confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bass_delegator *dg = user_data;
+
+	DBG("");
+
+	/* Close the listen io */
+	g_io_channel_shutdown(dg->io, TRUE, NULL);
+	g_io_channel_unref(dg->io);
+
+	g_io_channel_ref(io);
+	dg->io = io;
 
 	/* Update Broadcast Receive State characteristic value and notify
 	 * peers.
@@ -298,15 +476,70 @@ bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
-	/* Register BAP stream state changed callback, to keep up to
-	 * date with BIG/PA sync state.
-	 */
-	dg->state_id = bt_bap_state_register(bap, bap_state_changed,
+	/* Register BAP stream state changed callback. */
+	dg->state_id = bt_bap_state_register(dg->bap, bap_state_changed,
 			NULL, dg, NULL);
 
+	dg->io_id = g_io_add_watch(io, G_IO_OUT, big_info_cb, dg);
+}
+
+bool bass_bcast_probe(struct btd_service *service, int *ret)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bass_delegator *dg;
+	GError *err = NULL;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		/* Only probe devices added via Broadcast Assistants */
+		return false;
+
+	if (dg->service) {
+		/* Service has already been probed */
+		*ret = -EINVAL;
+		return true;
+	}
+
+	dg->service = service;
+	dg->bap = bap_get_session(device);
+
+	dg->io = bt_io_listen(NULL, confirm_cb, dg,
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(adapter),
+		BT_IO_OPT_SOURCE_TYPE,
+		btd_adapter_get_address_type(adapter),
+		BT_IO_OPT_DEST_BDADDR,
+		device_get_address(device),
+		BT_IO_OPT_DEST_TYPE,
+		btd_device_get_bdaddr_type(device),
+		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_INVALID);
+	if (!dg->io) {
+		error("%s", err->message);
+		*ret = -err->code;
+		g_error_free(err);
+	}
+
 	return true;
 }
 
+static void setup_free(void *data)
+{
+	struct bass_setup *setup = data;
+
+	DBG("setup %p", setup);
+
+	util_iov_free(setup->qos.bcast.bcode, 1);
+	util_iov_free(setup->meta, 1);
+	util_iov_free(setup->config, 1);
+
+	bt_bass_clear_bis_sync(setup->dg->src,
+					stream_get_bis(setup->stream));
+}
+
 bool bass_bcast_remove(struct btd_device *device)
 {
 	struct bass_delegator *dg;
@@ -317,6 +550,16 @@ bool bass_bcast_remove(struct btd_device *device)
 
 	DBG("%p", dg);
 
+	if (dg->io_id)
+		g_source_remove(dg->io_id);
+
+	if (dg->io) {
+		g_io_channel_shutdown(dg->io, TRUE, NULL);
+		g_io_channel_unref(dg->io);
+	}
+
+	queue_destroy(dg->setups, setup_free);
+
 	/* Update Broadcast Receive State characteristic value and notify
 	 * peers.
 	 */
@@ -904,6 +1147,7 @@ probe:
 	dg->device = device;
 	dg->src = bcast_src;
 	dg->bcode_reqs = queue_new();
+	dg->setups = queue_new();
 
 	if (!delegators)
 		delegators = queue_new();
@@ -912,8 +1156,10 @@ probe:
 
 	DBG("delegator %p", dg);
 
-	/* Probe device with BAP. */
-	bap_scan_delegator_probe(device);
+	/* Add Broadcast Audio Announcement Service UUID
+	 * to device and probe service.
+	 */
+	btd_device_add_uuid(device, BCAAS_UUID_STR);
 
 	return 0;
 }
@@ -947,7 +1193,7 @@ static int handle_set_bcode_req(struct bt_bcast_src *bcast_src,
 
 	/* Set the Broadcast Code for each stream that required it. */
 	while ((req = queue_pop_head(dg->bcode_reqs))) {
-		stream_set_bcode(dg->bcode, req->stream, req->cb,
+		setup_set_bcode(dg->bcode, req->setup, req->cb,
 							req->user_data);
 		free(req);
 	}
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 845949117..678532168 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -12,11 +12,9 @@ void bass_add_stream(struct btd_device *device, struct iovec *meta,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
 
-bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
+bool bass_bcast_probe(struct btd_service *service, int *ret);
 bool bass_bcast_remove(struct btd_device *device);
 
-bool bass_check_bis(struct btd_device *device, uint8_t bis);
-
 typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
 
 void bass_req_bcode(struct bt_bap_stream *stream,
-- 
2.43.0

