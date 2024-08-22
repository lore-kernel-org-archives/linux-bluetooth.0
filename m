Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7F1C9ECF
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332388; cv=fail; b=ErbFsHMcxv3hexEoLkOjo/QekHT4eMgWsmp56vwTEh73ts3MExObyNra+G6eoSqS93WECFVNotsJeOLsPLxZlETLG1gWAjNM/WL1Evg5Pv06oD3MA8fbs24Gy627iTfem+sollv6O3dggJSaFzt/2TbQqD6740Pp5VR7xqvaO/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332388; c=relaxed/simple;
	bh=kVnrkynjB0RwXkt9+ekJSFGmiJTCkqkdP8ubjuKdzzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGAp9vcq4knRrTXpfFqQ2EQer62szLLJjA1DoupkyAPXs1HeVMdEvC783W/kU5xDi9i3JAO2B2ZG3rFqza1KxRjV98OQHVQbE3JCmoWxMV3CsVBRTDT8sQdyCoJWJLIZUxSKKWKvAAYSI4Y6pkqhiklb7Ah0zheYAcf3x3gifTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKCxh9Fw; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKCxh9Fw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMYsmipzCrhm/NMtXY1UVGmUodJnFJntGFdZox4ZkYrv8BRLHVPKrCI7AdVLk7RzOuCf22KsKzbjo/m3SiBIZyoFAJ9CLIwtLocwvMtkXPXQe1it4VtjIdqZhsf/dz0qMazCuwyVATZn/EzfSCB66Z3ZVudjOvO9G6uVzLQpBaUms4zSv3U6WxSWMKpTj7PC0pEAqDzYakPrtbm7PBPh2HasE7ZVcE067DLakWwDfClr38zLHTwkCsulk/ohbzjxWfQ86lvhVsY8nGJ+I68QkY72m3IutNCNzhFLgkKvHQQsST1oDd2ziaoHnIMX+uQit8Tt04ss0BMd8Z5ksvdxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8czvwetVNcxQZXV0c0IdS3aq7DZRQ1v48PiQCmkttvc=;
 b=KqE/IPHEDIbrXygXz6QAshj+H4TXsKSM3WAs4vElr/EPCcfcBxFkG3VrLpIrZOha9sTXBjOYmml1Ey9wCaq9iQHsfsQMcB4veEtOrPCx09sdrMoBklzm5bWrj0HRMCZB9igo8AC4XGjdBkAhkC2JjlbGyCIrZOBTX3wVcMqH0GEe9GSGTUybeZAMx/q0Sj96D13P0oX6IOY0hHfrbX+WhE8a5oItcC/NjllrMs48VS1fW/bfOk1MvFvWiakuNKHgAtXSwRkHwW2Nz/AbyZUlw9OZBrV2YVxx+spDaLjfyprZ/KuGsfZy57xTOgpsuWvFd+cJ1zFqQMSKZNe5tA1Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8czvwetVNcxQZXV0c0IdS3aq7DZRQ1v48PiQCmkttvc=;
 b=QKCxh9FwQIhUoNklkfs5H4dKthzdsaWIiSzmSd/Cwp/HEIY2J1CD4hB9+IC+Wf4vfq8uy+XsfJIWa5y6hsKxnWCof9QWXdS7fXAixPweDEdCXU9IWPto6cFIYygnk54K9K3xwYbLnZf8SXcIcHeTJ5GaxBFERqbht3+rb7xxSxsDO+DYYgcqWegjnLRu+2vQ69UTdzvozCMQ6WI9/FVxUTKnmueKR6ywXodwH3cpWG+gbxCZln+9WHP44z2aUfgttK3c7ydMebxDyX/Yg37alqjsE+XVXhk2OS5udOffYSW/bWfwuTQFym1hs40mNZUMM0t0LtFtbaS59LvyJQJO5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:13:01 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:13:01 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 5/8] transport: Add set_bcast_qos method
Date: Thu, 22 Aug 2024 16:12:29 +0300
Message-Id: <20240822131232.531952-6-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ec0b91-75d4-4eb1-249a-08dcc2ac263f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEDbEppjvjVjdinTCgtCjLY9RDGqe7cps/vk4TCH9FF8YnyerM1svJnHjZ5V?=
 =?us-ascii?Q?K9LjxEk882/SeFDpx8iFE+SiqFmfOIkI5JFrHTxM6zk41hqj2PDkBtcaDdTC?=
 =?us-ascii?Q?0x+GqHgtFD/C3Or/ljCFpwGQmtayoBKvRzOCz8baDQU02S/f6OXdfZj+Ubf5?=
 =?us-ascii?Q?RfUErDqVHNwO4ZCjM9dGEQWrYOxnMzW78+xxuBH6fvGX6Tsu+bYzEC8+D5LB?=
 =?us-ascii?Q?t/Yx/Sc8U10jZsJkKNGl0ZoXxelE1WwtFpVNSTRJj9j15nZ3aUWMgjz+DSpJ?=
 =?us-ascii?Q?6Zq+uabYc01TWoE3TEoTmAT3kOANZ9FX4rFUEa5g6nsYxm7RqVMR05M3dqa0?=
 =?us-ascii?Q?UkGfPpQzGAUtqIkrppZQ2MSfh8Yq/30aq7LjLuUJeA0Zhy2oETonzf3+PInU?=
 =?us-ascii?Q?nvSw03hrbg/BO3iHrspayZWjaAP08efO2nX/ctnxCDWnKBtLhgpCl+mk+IDw?=
 =?us-ascii?Q?C2WPEjGNqIbSPl47sffyuMdCOvSni3SIeZvNCskyHxbq+JliUPt27F6BRQNz?=
 =?us-ascii?Q?7plcMxPMwZgCo/q3rp7eWyYtk+45LPY6Z5vP3+Y6+oct5A1+h6F996RDM0Sx?=
 =?us-ascii?Q?s+eTZlXOPCdYnp8JHJtymqajdNaKPa71X2Hzte7V+gzktlvZiU/Gncap1hx1?=
 =?us-ascii?Q?btrdTk8FR4SXBJXzHmN+FSKzyYA/NEdJqMJLMrU456eIb2Byb3D4pbkXGxlw?=
 =?us-ascii?Q?y/Wke89yyxSyWTHxhQfXlXfI5r+osAo+TtDiGOEKED9hR3aNzvRAFOfQjnvL?=
 =?us-ascii?Q?rcJK52+ganVBR0sOspqLR/PkmKsQFGVX1DqipP71Xh7xerews0DcHcO+fvhT?=
 =?us-ascii?Q?eV/KzV/sQY3bC1bWOoSzy6VVcc8NUDjLMWJPSy8VRyQPh7xn97Fv6TGBQPWu?=
 =?us-ascii?Q?FaJuaBekoShyS6RMYTWf/vZ8+irmJd67OL3MP3V48MmpXj4wByNAnYS9O5xZ?=
 =?us-ascii?Q?c9Bh6OLKmlp421sz7SFiYQNezZuHSMpUvx4a0iLKh97PI3ENcenLsSd7v490?=
 =?us-ascii?Q?cEjJiPCkRdblPVLRByLe0kXa7QPc7dzOtlkjQEZvnMrW8pUF/Svcc0x7Awfe?=
 =?us-ascii?Q?+ur/4/KUGDx75oow9lKFjxDb87tHInBxXgxMsbYNze3gFQ50H3580p8LsIZl?=
 =?us-ascii?Q?twBsgVwZ05ETs7o/5NLnLRH6MIRLLM0NXb24Snp4R2OljQzUyumnYuIIdWiP?=
 =?us-ascii?Q?kX99F5D6rnu3+/0V/5mDnR98losndiHh+Yhq2Gv1NI+9TNvBqH+mCte0nqxR?=
 =?us-ascii?Q?Km5FAUeILvNle58wriBcfVWcoDKPkgWVPP8ypUI1wEPN1RKWSc2OAMwg4qpV?=
 =?us-ascii?Q?aMOIjFZE5D4iDgg8UOAYjKhb9PO3wXQRYYlkyHEDKjpvmjoh8TyB/Zr25nbk?=
 =?us-ascii?Q?DeYOeytr5oB1Zy2kK54UvKQJcpWb57aavkb0jmUUCVVLsnwGww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbTqWSOt1W56dW7aDaDtqOq+6gAFg9SeKsfKy7RbV76ElbD8gFOSi/9gAbT4?=
 =?us-ascii?Q?p2EKeAMZFiF9BMoM8PV7IrpcHvCrU4RXkaLavoySz0BlYWy67cAOcuQoXK0B?=
 =?us-ascii?Q?dlFL4gChHaoxjcOmejms5RGEVsKcnPJ3jNxDLrtmAkDZeE5yWLgkl9ply79q?=
 =?us-ascii?Q?+sck23CU/e/FsFBS3CW1X2ggPURBihIPzeS0RI0LOHLOO6yueIWZWKKUjujz?=
 =?us-ascii?Q?M6devkS84ziEacH7Q0gMoGDTAw2UzXqzVK6E+nH2ZicH/8uarTjwmgXVBtVH?=
 =?us-ascii?Q?IAmhUoT8i+XzRpfhJ3T6QgpWxTlqK/WdmP7wiBqUYq2Uui6W2JAbro4bk1ZO?=
 =?us-ascii?Q?X2yy/e+pE2qPXo0lTNIYO7AFUX2AFYEqSBRCRobELYKeJmZSLVloFadHNzuD?=
 =?us-ascii?Q?FmSPKd1l4OQqDIQGWDw/9qSe0YL55qWKnIuneSPA4DOFLO60IMjU4SvUM6/E?=
 =?us-ascii?Q?ap2sZSvQ5cb056bcwIsOMmXoxCYYUSaBM7AA0Jwwy9YRuXub/T58BF0BcXLf?=
 =?us-ascii?Q?EktPk6/gBa5fcDY7e2tJWHWyVFdPE40caZXPvN0Dxk0wJ6hbic2mFzlZi5Yn?=
 =?us-ascii?Q?3gGPQSpacF1ExZ3KnMJN7jiWc5z43n0GHUQajLRiJlzX5Uz6BzGgV/2Ezcsm?=
 =?us-ascii?Q?RY9Ss14wiWJ1hRAeGr9ShMjsb909YHlEcLGXoPyVj2cyRRnmQTsrW2iiFeWn?=
 =?us-ascii?Q?9OhUn3wu6bbqEkosWV569vYSDYKba73FDKwF7Udn3vywQX0quUUYo+Zm7vdS?=
 =?us-ascii?Q?zS1osFMH2luLQ4ecyTExrvjpvv/IskUtheB7LaxO6JVd7BzKNX9Ivfof3je4?=
 =?us-ascii?Q?CA+zWQHFTENZi3IfHTPslA3IsCcNzt+p8esSextGpMgIoe8954N+Gr8SElfm?=
 =?us-ascii?Q?Qik/Aimz2UCHdewjBCJOErbnUTX1Vb7vJY/0X+jOdXawllenG2h+636hPZiF?=
 =?us-ascii?Q?GPlz3D0QdsYnPiSH9JotFaX/K5YItapNJDi8SLXx1rxDtGepPuhlHXPbtACx?=
 =?us-ascii?Q?EbPldljvJc/a4ZQxYvYDVLoAWdyMRukKcev8W3IpWurt8anvnr7hHWsiHvhD?=
 =?us-ascii?Q?F1fVeB8OKjUi/0BQc+3L5biKkN8OjFhQHpNRvg3r5j5tZgo0Jth5ZTA++4Es?=
 =?us-ascii?Q?0VtygPBmCCAQ+qjUE6B6resBTRvI//Vo8Wa0fBSaeXd1et5uvw8Hf8P6QI/4?=
 =?us-ascii?Q?JsUz+okHZT3GfKe4v1wTrds13Jdja3XkFOwgKn4HbLtNQL7H4sf1P5J0u7Rl?=
 =?us-ascii?Q?nuEiRODpbQJoZBOID5UVlaL+V9sqLJSe/WYy4xjbAV2XOaM6wT5sL+VO8aHt?=
 =?us-ascii?Q?GfmMo8h1I77IFmy1gasoUC/n0Ahx6KYKfVmsZRFxYVFQfqQZNdIiNG+E03B0?=
 =?us-ascii?Q?XX1A18NNP/8Q3S/+qiDHMNc7qXhLmtEr+jUYWxuqgbrFvaoFBkdrYQMZdsRd?=
 =?us-ascii?Q?TigcT3lFn3tffdLPPVVGRvaQ9FbCT7EF51ZPr1NmOJVqqeaeNa7SJ9IzwVur?=
 =?us-ascii?Q?uPcbHZPY9BYBrspn1vYQ7m59/bEeXX/resnILWw9t0lSEjczt6Jlte42Zjdy?=
 =?us-ascii?Q?bDbxOVqhhRESLMXFkmXrhL0bVBQK2U/ciQsgiGkN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ec0b91-75d4-4eb1-249a-08dcc2ac263f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:13:01.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h3JWopbWG7k/GrdSONZmBEwDe1xQdW9aaBl4RuSKOzAuFTsuqFO+BgXQ9hrEa5za5EUEBHWHLiL0q9u/r82hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This adds a set method for the QoS property of bcast transports.
This is needed so that applications like bluetoothctl are able to
modify the QoS (for example, for setting the broadcast code).
---
 profiles/audio/transport.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e8915490d..c4b6ce7e3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -1208,13 +1208,46 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.bcast.io_qos.phy != 0x00;
 }
 
+static void set_bcast_qos(const GDBusPropertyTable *property,
+			DBusMessageIter *dict, GDBusPendingPropertySet id,
+			void *data)
+{
+	DBusMessageIter array, entry, value;
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(bap->stream);
+	char *key;
+
+	dbus_message_iter_recurse(dict, &array);
+
+	dbus_message_iter_recurse(&array, &entry);
+	dbus_message_iter_get_basic(&entry, &key);
+
+	dbus_message_iter_next(&entry);
+	dbus_message_iter_recurse(&entry, &value);
+
+	if (!strcasecmp(key, "BCode")) {
+		uint8_t *val;
+		int len;
+		DBusMessageIter array;
+
+		dbus_message_iter_recurse(&value, &array);
+		dbus_message_iter_get_fixed_array(&array, &val, &len);
+
+		bap_qos->bcast.bcode = util_iov_new(val, len);
+	}
+
+	bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "QoS", "a{sv}", get_bcast_qos, NULL, qos_bcast_exists },
+	{ "QoS", "a{sv}", get_bcast_qos, set_bcast_qos, qos_bcast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
-- 
2.40.1

