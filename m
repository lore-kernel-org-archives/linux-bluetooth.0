Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAD15B984
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801340; cv=fail; b=hmMJ9+/iLokKMLp3MLx1TCQvNWBjJm9JNIoV5vLMtCG6DHcdjggpxgT/DMxW8mQmZRMEGJcqro99OTstj/hsKxdxvGE1Bi5LPrF0gNyi//q9A73/lmNo52kBuU+iftfsk638gAktnPOLn7aybwhst35pRi3fO8edQSfouRJXP7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801340; c=relaxed/simple;
	bh=4lLcQqRFVm3PM7nbl723fnrK+wQJ1SLeSGLzhGmkCjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLoyV0kcVDNTJ8+mtzFTHldn8s/VEoeFeoZjSk2Tia6+D67Mcyw4cJmPAn6NHwOKFFkGHpE4/dwFSKEa2mx/K5fhzi6bgOiC6ehElV0DJFB98tcxhr5UUasEI0/FraY9bznjqYU7qEdG9bt8WOIrXGMBWX4TdTTMgrju6O49b6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CL4Yp6ei; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CL4Yp6ei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaKQ4m4aBjWL4OoEiGy4c42vG6X+DFiUri0kGamTbhD4h05PYVeoRL8SdkjBngLMkaw+Xu66/PtkLqOToWabcNtYbFkrrV3Rbci2kirotLH+pgwYLGOT1zWDJaiil6TKfdmFs4UDDg5gsdkua8ERc+ebvLAT0oOu1/w6mWCZdY2Liin0iRd66LpuivVh38g/ZPK8MLAkE6+H+ATwR+2Fz9Unwn+Ofa+cBpj1FwXYk+5XQn7beovRRr2vKHe50K6CgWQYG0LOWCYvhzUvnUT1cepV3iyqAUwKhoWRhLIYawIMt3YHxKOzyfRw/de+eUEdA32wZFhS7hYjLKVgKxkDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKUWxnow+inp9KOweGFU9AJ/Sga5RGhZn7SfuY3jOwc=;
 b=lUe1i8PkQgJ9MkGYM990hz4MYrxc1nN/X5bduQruwr4/VnB9pF+avEf6E4YAkO1u3co0wjPaWWt1ufCvfz4pA4YAHK5W+yz7oHgrVFPhYYsCwByEEr4hT1WNaZmST3CviYTizJ5oXvwf99k/FOg58Be3WMSvRPwdwc5hkdUwcteAicagAfqF/UxkW+rg0GSaHZZW9EuFkU7TMGsiP3XeVVKK2HBIFneU6RVHH2qoQuuvotWtlbkqoRULeLh4tEBnOxdzSZlu/yccepnT+EpJXbC/RwgArR5LlBNEaH6PqNKQjXcuP2VcV9d0H2aR76/s0KNOgOaxM6ryPWzvSw5p+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKUWxnow+inp9KOweGFU9AJ/Sga5RGhZn7SfuY3jOwc=;
 b=CL4Yp6eiyaPfzBywdCoS4MY4iGqYuctC8hdXxOOtfL0RpJwC8+pWMDzomRwtPdImrjAby6Jk2Uez7aj79JxuLrRs9LHhnjPTlasctRf1mpUcm6vKkhFdQdbfWWVHlTQrmbMuqBxkcztGGDj+UStyZ9AT63QciWS/mkzeoDiiRes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:55 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:55 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 6/7] bap: Set the generated BASE on all setups from the same BIG
Date: Thu,  1 Feb 2024 17:28:34 +0200
Message-Id: <20240201152835.196617-7-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:208:1::48) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b07651-ef21-4151-b401-08dc233a80b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1FbH8w9eMK8WnkpONyX6uLUKUAKs0ySfm0QM/UaQWe4crlEjQZ8qv7ThBsZsKrOKJNYmYCEcaTsiq2dfYHQvh3j7NqbZhBfIXPhB+qPCYe7TDm9iC0c/lc7N+VaAk6Lo5bRIS2KdXFAm6VO2yV0RM59wRX6ar0a705x+ewtqXkJtd7L2Hx4hNBmlf3uPcsRjjA8hNYsXAO7V5XtaG/gNs+kNwpAP6iAeRYcm4MXUic0H6mnQQ3DbUe4UBXYKBLtJaCgpBgev1GJSUMtFVMvDKFhmBYaffoG7T9VYFmiw//lvr+cFKA21+0wrgwgMd/NEOgHW870Zs6y7k1xo7cqliH5jccoiJ6pGCMmdPSned5nlxxttdTtMdUwaVxuSSIHXbjhIRx0hcfx5trGjPQxBxpwVlyCvsin0maBbqmTtuhjmYf0C3okOrXaltnZc4mrKgMmYzcNLvpAqsv8/vRicTEGeSclrqWF5WmSHCn+7/Y1esFKpVhfxUlIv3FgAU14PKEoi7mZL2ppGbzKL8CUkW/sC4jVqf7eX6Oq6qt6/FFI87239GhQeuNUJF+GNT2/W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JA4SbNLdyPrcz0b1MGb/4K+fA+cYN3lQT6u54PnP4zgqh9AvkbI3jFS3ZF/0?=
 =?us-ascii?Q?fed3jGOPcEnhwlc0fwi5JiDoHw1+PRd/b5Pjbs1ENw9bRBzSBn6YzRDCzMpp?=
 =?us-ascii?Q?BXYLt5NjXFxaBa50S4NNm4zDF38a5vdZxfO/0jZm58dFB0kXgGWpUvWSzbAr?=
 =?us-ascii?Q?ZUCn+CThUSVPw0Kp05/70H9R0+D5eIwCigfkaaAz9sEs+S6JxfDXuhSkskNN?=
 =?us-ascii?Q?twzLHgemBSz0SfrYSqBGjgAORD8ky1Uns14JJ/nL8PsN1RhSpdIJmBHnLy6C?=
 =?us-ascii?Q?sC4CBcVO0wxETWVxqquBmyOvEI1kJIn8xaoj8xyQbop/XKNgIA+op6W+BuB0?=
 =?us-ascii?Q?q0yWJ3Awm7klyrfFs26KvirEquhOe/sJhVOM/zcP7FSxEQENSeTdntLhYwRC?=
 =?us-ascii?Q?dopthF1hxTRCWNR699JY931A+ykCC9OXRRMrI4jTSvfiI0EmPfXTcKTLmeQT?=
 =?us-ascii?Q?1/4rqgEOJoU0tvapEnCJbfk7pCsiC2CY3/16nk+53wFZbmg/bGczuMyD0D4E?=
 =?us-ascii?Q?rHpvzziiyBXuQHz+5eMGlY4neT9yg58gVFpiNaY/ZJ5TIBF4QeOe8XAsrkoL?=
 =?us-ascii?Q?74WH6FmqgNa3rO7z2a3pqO0l63GU+pf6NIEQjmZt0IFfq+icGnW4NNg+r+zN?=
 =?us-ascii?Q?tR1ZZnvJK5gFvIH3oZ/10SB+KjoG2VdMM6Oy0pBCBPtmsEb8tf6M2NtZWOfi?=
 =?us-ascii?Q?GETDi5A3EUt8guhUlBtCrma1L2lZjD/EXiOJjGrRO8YYCC3XbpVlDDo2z4WA?=
 =?us-ascii?Q?d7rk8beZot4wdr98JDbAmBYxIxQXNvnSIoXsd5mQepfkHCFct4hllzQPrOsX?=
 =?us-ascii?Q?hSszGCJSLrLSOHaSh25vcfwbxUvB9jUBEmT1XAFM9zlaSc7vv55X1OzDa2yV?=
 =?us-ascii?Q?v+XyHcu1/FTizy829mL4OAkfA1fl7Cr0lC19bli4uY/JWhAfww6A2ybAm3G4?=
 =?us-ascii?Q?sN//2mFR7u7dD8t6YVPcdXyS7NTCo2xG6DzF5vZopbDIH6o1SkfWtxp2Yto6?=
 =?us-ascii?Q?nWZ0c882iNURwlY6DNcQ87akp1I7AprPT/H9UGDm+mFe5/2GAqA9H7g9uL/v?=
 =?us-ascii?Q?57qy9CsMxExTpxwjCzAR+K3bUGDhHrXEtu+pVpQLSwI7NJrYXEC6g+40+Jgn?=
 =?us-ascii?Q?ETPxu4p6Gck+GjpZEfOa6s72C/7+cpoWT7HFjduoOkA/RKwiuh1bAL6GU8wX?=
 =?us-ascii?Q?nHP//CvV+8Wow3OCPkdIXL1pVo5vgmMsu3tMi892tqDIPnqydNvave/8E8V4?=
 =?us-ascii?Q?NvXlC47dkSN3WFr9OkHCKpYX0QoWWtsr0OcMjS+zKduTJlxprzG62nKeelyE?=
 =?us-ascii?Q?Gjj/e7cFmiPILKTsFU9yIG8FiRJ/ar4GY6Zl7vhIw4TpA64dAPcRlz3ydlaj?=
 =?us-ascii?Q?i7YNzKRZLlQ62H+0Ca3Z5x67RhSRM8AXzbK3b7aYyvI5VfMITOoj7MnwqMBq?=
 =?us-ascii?Q?WDMqUzhyXmgfWqttIfRTmPwehyYsyL6Wv+GgYVDNekVUuR3rQQuteqT5Lko0?=
 =?us-ascii?Q?WQkitu+2GrOyQuyssqeFdYiwAoyarIFGea2q6B6VdXLkqCkTt5fx0jueyIzh?=
 =?us-ascii?Q?Rw8qICs2LVM6tV5C7CSkjGcfsOnhg6BJNdrzWZ9b9XVyjTWYbBI1lFuRLiXu?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b07651-ef21-4151-b401-08dc233a80b4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:55.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhH47dmQg0w7MKeBrB9egpHY2gXCRz8MQMqzC6HkGUqFBR0fnn3WJn1cLetXMPDYruHJKjm8gca6OoerohUrjPUS5IMge/LoOBMMRnFzSgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Set the BASE generated in BlueZ on all setups from the same BIG,
and use defer to inform the kernel when to create the BIG.

---
 profiles/audio/bap.c | 69 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7d7a3ce02..729860fbd 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -916,6 +916,35 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void update_stream(void *data, void *user_data)
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
+static void update_setup(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+	struct bap_setup *setup = user_data;
+
+	queue_foreach(ep->setups, update_stream, setup);
+}
+
+static void update_base(struct bap_setup *setup,
+			struct bap_data *data)
+{
+	queue_foreach(data->bcast, update_setup, setup);
+}
+
 static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac);
@@ -975,6 +1004,10 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 			setup->msg = dbus_message_ref(msg);
 		else {
 			setup->base = bt_bap_stream_get_base(setup->stream);
+			/* Set the generated BASE on all setups
+			 * from the same BIG.
+			 */
+			update_base(setup, ep->data);
 			setup->id = 0;
 			/* Create a new endpoint for a new BIS */
 			if (!ep_register_bcast(ep->data, ep->lpac, ep->rpac))
@@ -1847,7 +1880,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1884,7 +1917,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -2013,9 +2046,6 @@ static void setup_create_bcast_io(struct bap_data *data,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = setup->qos.bcast.big;
 	iso_qos.bcast.bis = setup->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
@@ -2032,9 +2062,10 @@ static void setup_create_bcast_io(struct bap_data *data,
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
@@ -2127,6 +2158,7 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 {
 	struct bap_data *data = user_data;
 	struct bap_setup *setup;
+	bool defer = false;
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
@@ -2148,13 +2180,26 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
+			/* If the BIG ID was explicitly set, keep creating each
+			 * stream io with defer setup until all streams
+			 * belonging to the BIG have been configured
+			 * (i.e. transport acquire received on appropriate
+			 * transport). If the BIG id was left unset, just
+			 * create the io without defer, and a BIG with an
+			 * arbitrary handle will be created in kernel space.
+			 */
+			if (setup->qos.bcast.big != 0xFF)
+				defer = !bt_bap_test_bcast_streams_state(
+						setup->stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+
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
 			}
 		}
 		break;
-- 
2.39.2

