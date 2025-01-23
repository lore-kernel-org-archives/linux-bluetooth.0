Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34D20F96E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638637; cv=fail; b=O/zm0epuAjYCpqUqDGp/g+pW+Rnlod/j46KzVupvg32qvP+cDXhk9/b5gt7Y/w1W1y/x27Kr63jQDonN3EZteY/qHtOyUbLlP8wcY39Psk0gXhsbGD5XdBSNFcalu0G7MhSQNIUrMX2LXIF2+3fGPLEd5WNEg1WVUF/N553S4xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638637; c=relaxed/simple;
	bh=ieBRXarXJMM1kFGAP+BTAoEjvli3yka0kpJp99JirWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1HF24GdzhtxBlBLfaMQBhI68/tUPWWiqqQYw0EUgo9RqtdOcEtcsQ++XACigGE61g9wyR6tpoGs6nChzYqvzwvehonpirHsvblGIuPdd2v2NiDbJywNzFIh5RJVNC82bCEThxhDIz/xCaRABADNtlc0HU8mQuOXTC/qqRfZWHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/6JGl1G; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/6JGl1G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTtCBAqmCOxKNHvchmgEZUixtESLaCIetOmx4uxzOgEYKSDAvQ223HcJMZE6O1PsQBthFBKTCrIzUIES8L7SLVLLpL/Qyb9ZgmTIhAlhCfBqDFNcoaVHYDU6DDUZDPvYc7YOzKHr0cCTF5YSG5E53WIQgktXXgmEelQ+P0l4ZLByDZyuAM8Uqp9tznTprloLg3IjillqxFajnBL+53q0RBC8/pK1uVyiEtKzvvIxrqzLWyNMLmPud0dOIzkVwvNwAa/LaEMhjMQQfdCWlwkFf82LWpD53BF1F1c95yufy2jRxkglpYhterGcZVZmf04tWYnW8ZhfTlQbvf3eIzWf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfNL6Ngjmc2vFthg5Qvp3IEV3p+MLcnBwp2m5yxOpd0=;
 b=HnsAhQZPbvwfcLDaSDzR+a49HLqCtVTifBIsmz/XVw3mjZFVk1Y3yfs2jYirnPCBMU7nd2dAdN/0Wizbv9Oc+X3TYbCeNH/2ENFpWx6XHhumRdWtGcWBsBHhGwWkAqUKAwkpEFBclmv6ah7A8FL8dgp7WVs/EBIDbizCYXt7AEtfv7DBvvAEIUKbnXHl9d/ohhP6DW64FJXqx4M83VANFCHn451IjWiz/1FRH4NbwipAc/5Mda8yyWO/yAb0FUSRhklrS+H7YjrL1iHsJbH0D1/YYim6bY91H0qxTLVcpFSte8tB2x0cKJrJmbXSEqd+UQf7gcVdUxYC1Cot1ccr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfNL6Ngjmc2vFthg5Qvp3IEV3p+MLcnBwp2m5yxOpd0=;
 b=c/6JGl1GO1FviCjAKahgygXMFbcedOteNvG3tJhzjbxt671Rb0Ldv/SvOyuYMBg3jV2GPAuPdMsOMxaMtKHMdc5u+SrmrwJLyXNb7fihDxBWhxwCvnUFC8t1f/Cm1Pkk3u36PpXb8ntNnE8jKBrgUP4Itg5uBBcGTRPYGUUBpMST48m5ZEemFlDQKH60KIvOqabHjisnj/JYIIqwc71yynmGjzZDRQxDBcHd7H4Q2ruq5S59Ce51EtpRCtAjMGZ8OtRk7rvGTg426Rs0yb2Ev5RDSvS2pbjzWdUqlsG3yRMKJA2sl7PO9r2cqwTejvOEjG6rY2D5payw2sS3uQ7q6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 13:23:52 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 13:23:52 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Rework transport.select
Date: Thu, 23 Jan 2025 15:23:31 +0200
Message-ID: <20250123132331.27435-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123132331.27435-1-iulia.tanasescu@nxp.com>
References: <20250123132331.27435-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8e1fb6-6727-41e2-3ef5-08dd3bb12e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hf/skYl8AFa+LHoQot6VRbqrv4wy93CMyx31a9pqukqb3R7+b3TiPlBCTnZr?=
 =?us-ascii?Q?HQjGpndDERaUX4TxUJ2nBD2qZmToMZ4kRJdTbXyXzEPIqgLX67OEBGRVNshx?=
 =?us-ascii?Q?4KFybsCRX2q9ZkyPSHC4GA7DlMcbr3+mnvPtGy/SepFOVr+dGJrSC9bQHXgV?=
 =?us-ascii?Q?XnlSP7xbWJA4p8OtmtWS8UTRZ6nbslvV2WT8pxIw+I29gnbZBQ19TfVL6ECt?=
 =?us-ascii?Q?WiuLkbTSGU86qUMsMlrlnKlxUdZgFgmdkAymF4S9Zpg47yidkdibBPlAAgls?=
 =?us-ascii?Q?Ey9+gj1E4/RSSMIcN2fdkWI7TYTLxhyf38HUfmidGsjcNvw1AoeZKZLdCs9E?=
 =?us-ascii?Q?s1YNxcqFi2GeuixSujl85AergFmja38/FSV5wVsYrOcOvlmmrGfnOA0Iu+5v?=
 =?us-ascii?Q?qtzO7Vb3wdKJlw2sz+ldMo8d1k32nAseo0C6l4e20B/066Q7EEwGmCeM1H0o?=
 =?us-ascii?Q?0SfKsKvoVwvPSwunfEeUFGrESGPImlOAIRNI1ToZfvLQ7zwD1uUqnDPVKmqT?=
 =?us-ascii?Q?eT9Kur7yJGcPAehBBS+yskVDALQfTAI3fgZ23LqpxWjmgFw9yf+tQRWlPRoh?=
 =?us-ascii?Q?FJ7NC1NHjtTqBozFDu0/jQlcIcS89a+aZXCU0URu5psDEKSEpKXO7Cn34FcM?=
 =?us-ascii?Q?32Zhb5AvdZyNwZbsNmepzA3ij2fDKFoTzaFJltqwSVfOUcKENHCLwA/WxPnc?=
 =?us-ascii?Q?rde6RtpoErtw4Z09zP4rXMm6U5H8HruvTn+xqy3pH5KeuJ4K7AeqPyIin+KD?=
 =?us-ascii?Q?eMOVfUqbtrRZaM2yXRs+rldoGLrWrvwHqmJd5d4JGxDV53C3SQiFTUx+7DIP?=
 =?us-ascii?Q?LzH4kZrtMwLl2byt6ENMoAI3O7nImNJ5SQYD9rmNk17miJkz9fAnS0A72y8Q?=
 =?us-ascii?Q?yGkYikSQtc/67/rKuk3gtNRFkWOHARAmxrhaw42rwqUUrZp65A5fCthctasC?=
 =?us-ascii?Q?Don2lUCmUvXmnTHo1gANEmlde+65/ldsulo/7u5dsGI3QsOUg32YsHVvIv+X?=
 =?us-ascii?Q?z0eXKMJgwIa9rCv/TDqP89iof7g6By7DTPTulCmwVPjcAQ7stdaJUxh71c9l?=
 =?us-ascii?Q?OmGwuGyV7Upr4lePVzVF9dLOtCDWoACJFbBkRALZ8Ni/tAtB0NHpVCTZZTn6?=
 =?us-ascii?Q?wYDqBTcwb3a3eBkOHl4+v8wT5N0KqJFcxGgR+yTFAPdNyxnSoX59/SjCFOLi?=
 =?us-ascii?Q?U98s4FqtpUpXjYfYqFZT33cTDXiBS/U7/IJHp+p5IXuhs7PJO8O0CsNAdt9q?=
 =?us-ascii?Q?WbqwvhBxWD7K/yY777G1xt34D7lelGIR0F928G6j+D7JJof4V5exXbnKzTaB?=
 =?us-ascii?Q?CzAts/HHGLRHOZvYtWlzTP5nKhEvV6BGdKXIkmt7hZd3mBvWRVgss/pvqAFD?=
 =?us-ascii?Q?9DtWMpYO0yppIgoc5ZXqTpb1Cjaj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZRutJqbgqB4rQ1rAJYvii4X0TeFPcjaDdTXuH4pZP6Bkidm5VW1doi+Y4Mp?=
 =?us-ascii?Q?qATebxoFC1cxKUopMkKsyQmfHfoQ/U2NjfFKaWdfUZQT7E1S7Se+7OTdY9d4?=
 =?us-ascii?Q?mx25NKtu+v2mp+sfuYE/22kwM3hL/NcLCg7y2hm01a8C1ycL/zFf+pL6WNUh?=
 =?us-ascii?Q?iJ2RYz9UZcY9Veio6O8k0b9a//jt5xgBS3qqRsKDNbJtA0/RANtClLDAsz1p?=
 =?us-ascii?Q?1R6Me4YzTPJNHAt3yQUq60BFNUqofeXqH5yLGkb4fMNzsqUUa4H8waaQDFms?=
 =?us-ascii?Q?KeYHsdX0eVMVbKsGffZkyLLk9wndYAVKM6kPmpCI9mpQtaSUI/LD+024AZqa?=
 =?us-ascii?Q?DTRXW1/n6lSSYBcExVTGwSzO6X551RMyU9tiZaEIpfkoqceUjlFdQDfVh7GA?=
 =?us-ascii?Q?oqPxmBTjYmWW022DkKQQIeiJ+RdXUYOOlQBZNyNlBQLJdcPUoo4rNY0XEqfz?=
 =?us-ascii?Q?PvCCZ4yFrnFMoDWXK0xqKzCMDEctlbDpxmiQh4k5kYZ4stExqfh/gBVPZbbb?=
 =?us-ascii?Q?JHYyJvwURLWxetPoQYklUyC5SxQt5hb73vwaHjK9y/2QHupCxdnOCoO+cnMc?=
 =?us-ascii?Q?7tRerC5h16ljyRBVf7vWId3Vm0yBzkWIX70Z2e8kRqgBr77UY22SwTTm74IL?=
 =?us-ascii?Q?Jvkb/qnlP4hLqKPYuBd3qCUXgDtthY+rfSpNNH47tK7b3VW11T+M0DYLyceP?=
 =?us-ascii?Q?855ee4hBXRx2Dor9lsyNI9bms3hR5YL1iVQX+8yiJ0o9bI25cRQpez10Ice1?=
 =?us-ascii?Q?nNUe6Sw20h0w3B3q4/4gluQSNgTbWBVYCPlPmCi8LsyT3pSpFCriXhBwhPi0?=
 =?us-ascii?Q?wwA4JFviWmyemL6X6ipBHKIFEI8JPxZgi+xKqesEzvpqPn/mSiEZDLr9Srrd?=
 =?us-ascii?Q?vnczS29gF88J54I9EwHPWrabhte8pUHuyoR4TZ3J1bkA9buQwq678hMoKmwN?=
 =?us-ascii?Q?VagmwP3C1aj/jw9PCHXn+2jAsvKMz/R03ds7VWlAqvWTDXhWZc3d0wTkM3xu?=
 =?us-ascii?Q?Ybg53qRIwzfLce5DJfgGIsnVg4e0jZgcDjmN/SgZgQPpaGKY6cHvjm58S3yv?=
 =?us-ascii?Q?O8o+wTzUyo2hFoQk0doyj8RCqk6vGAtxrJ36T/0bH829jgSP+Kmj82ppv6yo?=
 =?us-ascii?Q?UjeD92YqyJZuQScaOobioPjPnp7aTZi8aaHOrlP07Yc5B6gwystBMCxY3V14?=
 =?us-ascii?Q?Z7yLb6QwZ753fQh9O6rSCFPBpMVGQ4N5dKeIbhWFZ8qX2ujVqPcVNv20AutL?=
 =?us-ascii?Q?s8INDVVqeb8AezhKg/N3EV5gvFXhdkj0J60zzNffVBmg+MRsxoVL5L2f5gc1?=
 =?us-ascii?Q?/kS6jYI+Zd2uFPAAPj6JSe9wjvNAPQqGwNj4Gg3HvzXhyWknwgKNxhX9C9nY?=
 =?us-ascii?Q?oFch7+/3SncAz41FZg26GFsNmyJP9Lcq31pcPhCEIXd8FrhlRKpu9zU+VxZX?=
 =?us-ascii?Q?5EsReQusjnY6JB2Ns4oIsoO2kBgcwZiu4Q3gov8dwWHGBY/8X+OC7/ikBq3C?=
 =?us-ascii?Q?8NwWEUe7e9iFe7qxkU4gEzviGvpbek216/Nz6paz8HPL1+VgO0HwhJxJTEPK?=
 =?us-ascii?Q?t0882cESF4JKsiD8pZKQcdY0fDigdHS+e6ZyB7l4befjyAfGKhjFbArbzZgR?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8e1fb6-6727-41e2-3ef5-08dd3bb12e24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:23:52.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akf8fG3viRsa+7cW+yMIy3PyCER6O9zTX2zIUo6rk5uQ6BN7N1IwdIwBSQo0yaetxlLNL7M5+hFCxcAVsbAcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783

Since the transport.select command should also work for transports
created by audio servers, the transport should not be required to
be associated with a local bluetoothctl endpoint, to avoid errors
like below:

[bluetoothctl]> scan on
[bluetoothctl]> [NEW] Device 1C:F1:FA:E7:B0:3F 1C-F1-FA-E7-B0-3F
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd1
[1C-F1-FA-E7-B0-3F]> transport.select
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd
Local endpoint not found

This reworks transport.select to use a dedicated structure to hold
information about the transport and its links, instead of using the
local endpoint.
---
 client/player.c | 160 +++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 83 deletions(-)

diff --git a/client/player.c b/client/player.c
index 464a9cc14..e58b42bec 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  *
  */
@@ -115,8 +115,6 @@ struct endpoint {
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
-	struct queue *links;
-	struct queue *selecting;
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
@@ -150,8 +148,14 @@ struct transport {
 	int num;
 };
 
-static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy);
-static void transport_select(GDBusProxy *proxy);
+struct transport_select_args {
+	GDBusProxy *proxy;
+	struct queue *links;
+	struct queue *selecting;
+};
+
+static void transport_set_links(struct transport_select_args *args);
+static void transport_select(struct transport_select_args *args);
 
 static void endpoint_unregister(void *data)
 {
@@ -2923,8 +2927,6 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 
 	queue_destroy(ep->acquiring, NULL);
-	queue_destroy(ep->links, NULL);
-	queue_destroy(ep->selecting, NULL);
 	queue_destroy(ep->transports, free);
 
 	g_free(ep->path);
@@ -4891,28 +4893,45 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void free_transport_select_args(struct transport_select_args *args)
+{
+	queue_destroy(args->links, NULL);
+	queue_destroy(args->selecting, NULL);
+	g_free(args);
+}
+
 static void select_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
-	struct endpoint *ep = user_data;
+	struct transport_select_args *args = user_data;
+	GDBusProxy *link;
 
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to select: %s\n", error.name);
 		dbus_error_free(&error);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Select successful\n");
 
-	if (queue_isempty(ep->selecting)) {
+	if (queue_isempty(args->selecting)) {
 		/* All links have been selected */
-		queue_destroy(ep->selecting, NULL);
-		ep->selecting = NULL;
-
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
+
+	/* Select next link */
+	link = queue_pop_head(args->selecting);
+	if (link) {
+		args->proxy = link;
+		transport_select(args);
+	} else {
+		free_transport_select_args(args);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 }
 
 static void unselect_reply(DBusMessage *message, void *user_data)
@@ -5174,22 +5193,23 @@ static void cmd_acquire_transport(int argc, char *argv[])
 
 static void set_bcode_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct transport_select_args *args = user_data;
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set broadcast code: %s\n",
 								error->name);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Setting broadcast code succeeded\n");
 
-	transport_select(proxy);
+	transport_select(args);
 }
 
 static void set_bcode(const char *input, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct transport_select_args *args = user_data;
 	char *bcode;
 
 	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
@@ -5197,47 +5217,39 @@ static void set_bcode(const char *input, void *user_data)
 	else
 		bcode = g_strdup(input);
 
-	if (g_dbus_proxy_set_property_dict(proxy, "QoS",
+	if (g_dbus_proxy_set_property_dict(args->proxy, "QoS",
 				set_bcode_cb, user_data,
 				NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
 				strlen(bcode), bcode, NULL) == FALSE) {
 		bt_shell_printf("Setting broadcast code failed\n");
 		g_free(bcode);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	g_free(bcode);
 }
 
-static void transport_select(GDBusProxy *proxy)
+static void transport_select(struct transport_select_args *args)
 {
-	struct endpoint *ep;
-	GDBusProxy *link;
-
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (!ep)
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-					select_reply, ep, NULL)) {
+	if (!g_dbus_proxy_method_call(args->proxy, "Select", NULL,
+					select_reply, args, NULL)) {
 		bt_shell_printf("Failed select transport\n");
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-
-	/* Select next link */
-	link = queue_pop_head(ep->selecting);
-	if (link)
-		transport_select(link);
 }
 
-static void transport_set_bcode(GDBusProxy *proxy)
+static void transport_set_bcode(struct transport_select_args *args)
 {
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
 
-	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
+	if (g_dbus_proxy_get_property(args->proxy, "QoS", &iter) == FALSE) {
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	dbus_message_iter_recurse(&iter, &array);
 
@@ -5253,7 +5265,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
 			if (encryption == 1) {
 				bt_shell_prompt_input("",
 					"Enter brocast code[value/no]:",
-					set_bcode, proxy);
+					set_bcode, args);
 				return;
 			}
 			break;
@@ -5264,7 +5276,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
 	/* Go straight to selecting transport, if Broadcast Code
 	 * is not required.
 	 */
-	transport_select(proxy);
+	transport_select(args);
 }
 
 static void transport_unselect(GDBusProxy *proxy, bool prompt)
@@ -5278,58 +5290,52 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 
 static void set_links_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
-	const char *path = g_dbus_proxy_get_path(proxy);
-	struct endpoint *ep;
+	struct transport_select_args *args = user_data;
 	GDBusProxy *link;
 
-	ep = find_ep_by_transport(path);
-	if (!ep) {
-		bt_shell_printf("Local endpoint not found\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	link = queue_pop_head(ep->links);
+	link = queue_pop_head(args->links);
 
-	if (queue_isempty(ep->links)) {
-		queue_destroy(ep->links, NULL);
-		ep->links = NULL;
+	if (queue_isempty(args->links)) {
+		queue_destroy(args->links, NULL);
+		args->links = NULL;
 	}
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set link %s: %s\n",
 						g_dbus_proxy_get_path(link),
 						error->name);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Successfully linked transport %s\n",
 						g_dbus_proxy_get_path(link));
 
-	if (!ep->selecting)
-		ep->selecting = queue_new();
+	if (!args->selecting)
+		args->selecting = queue_new();
 
 	/* Enqueue link to mark that it is ready to be selected */
-	queue_push_tail(ep->selecting, link);
+	queue_push_tail(args->selecting, link);
 
 	/* Continue setting the remanining links */
-	transport_set_links(ep, proxy);
+	transport_set_links(args);
 }
 
-static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
+static void transport_set_links(struct transport_select_args *args)
 {
 	GDBusProxy *link;
 	const char *path;
 
-	link = queue_peek_head(ep->links);
+	link = queue_peek_head(args->links);
 	if (link) {
 		path = g_dbus_proxy_get_path(link);
 
-		if (g_dbus_proxy_set_property_array(proxy, "Links",
+		if (g_dbus_proxy_set_property_array(args->proxy, "Links",
 					DBUS_TYPE_OBJECT_PATH,
 					&path, 1, set_links_cb,
-					proxy, NULL) == FALSE) {
+					args, NULL) == FALSE) {
 			bt_shell_printf("Linking transport %s failed\n", path);
+			free_transport_select_args(args);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
@@ -5339,28 +5345,17 @@ static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
 	/* If all links have been set, check is transport requires the
 	 * user to provide a Broadcast Code.
 	 */
-	transport_set_bcode(proxy);
-}
-
-static void endpoint_set_links(struct endpoint *ep)
-{
-	GDBusProxy *proxy = queue_pop_head(ep->links);
-
-	if (!proxy) {
-		bt_shell_printf("No transport to set links for\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	transport_set_links(ep, proxy);
+	transport_set_bcode(args);
 }
 
 static void cmd_select_transport(int argc, char *argv[])
 {
 	GDBusProxy *link = NULL;
-	struct queue *links = queue_new();
-	struct endpoint *ep;
+	struct transport_select_args *args;
 	int i;
 
+	args = g_new0(struct transport_select_args, 1);
+
 	for (i = 1; i < argc; i++) {
 		link = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
@@ -5375,26 +5370,25 @@ static void cmd_select_transport(int argc, char *argv[])
 			goto fail;
 		}
 
-		/* Enqueue all links */
-		queue_push_tail(links, link);
-	}
+		if (!args->proxy) {
+			args->proxy = link;
+			continue;
+		}
 
-	/* Get reference to local endpoint */
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-	if (!ep) {
-		bt_shell_printf("Local endpoint not found\n");
-		goto fail;
-	}
+		if (!args->links)
+			args->links = queue_new();
 
-	ep->links = links;
+		/* Enqueue all links */
+		queue_push_tail(args->links, link);
+	}
 
 	/* Link streams before selecting one by one */
-	endpoint_set_links(ep);
+	transport_set_links(args);
 
 	return;
 
 fail:
-	queue_destroy(links, NULL);
+	free_transport_select_args(args);
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-- 
2.43.0

