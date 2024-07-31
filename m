Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D816B394
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406673; cv=fail; b=TAkrAQxjIcig5P8rXNy1S9KLMBVTBneA25Y34YXcZpCFnInMtm8WfwRcwx1XzWRFE2K5ZO9LBITjLwceeed1OhF9y/xzUEzSj7Cez7GQROWT4xo34T/f/vMVTneeda+2qwdOcFi28vDFurMPtZB5X9dHMvVpwwXaJ/5TZgYuTyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406673; c=relaxed/simple;
	bh=wctYOOFByP1zBmtDbh/IAmK+R7qJU2gIXS0KnxGAFiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZWyYlAKApo2PrGRUwcnWCDGqQMEMMjPkQlsmg6dx9pvWTO04ZxYwNkoIzyR1tjawOqc8ZC4p2nYzwj3j2zJVVDlXZV2xiNpCKi3w7JSQQRGvGLRbnp+sBM8eLikdkKZJx37gKkanzoVJEjLgKW41Jq+Boc76nyg0EoFro6woBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZgT32qj0; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZgT32qj0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ8e/wznFTEHBy6yebiSRfAyvHj/El63+TH1A2Rx1AniwgzFlHwfHdW8WCoMGXz3wM1r7bMEB/yBTjd/bBP6tsUPvsxbsbSs9W1HWlqRypFsmyypQWuwo//ZWf/UlXJQmigmNI+IegBzOX7fwkQ4WlvzITGC5qHKR+4snQSDe/dDF2fRszQ3E6oKIHy0FfaqAxc6rEiPNjrFL1krEsxzqjlFCWpFHtA0zbsVzryd9/nMq0Txo3+eVu8JQmtlIP7zmZgrYX/jT+a7ZeNw7y8QKzs5hxlrAE6pisXMb2fyL6JpfhixmIkqAHnqD34zZ4DdErSwEb5xFNNZsY7L6wJ/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2qaBaK7SAZl884s4a1hcIYXHJNSyVZ7fa2FBzFNFIc=;
 b=TMvz4Fre+XM9zUhTo4MrZyktuXBO6wbYveJZsHJK6pg1++S2t0DDAwMzbbCl6SY31exeGflQhPnX3GwSKKlV5QxV/bPIWvkmiL8x1T2GWBtjl0e6Ew3Mm32pZnwgGiEBNL6UIsKTgFyBUhXOMJPT1Gr7hfeHyK8sAz2Uh6IQAyd0XJAN4KIh58cLAezDYl8s3JSnY3hmkzL9ze3kZcF6Oje5E+YjQ9tNrE+thjyDe8zLtDFdEa2X6qfy3/pspL3wNSmR0lAQ+WOcsqZm2DFCgOwjgZx29iAizycDUmfhMYPhvqcoIf0xK3yRYhaOc4DnJae47J1BhgW0GJ51hKgp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2qaBaK7SAZl884s4a1hcIYXHJNSyVZ7fa2FBzFNFIc=;
 b=ZgT32qj0jVNEramxqsjVLYsNc7iwHnP93FElz0oPOyEZiYs8ZeqbBGqXnJAsrpNwkX2yHkH4jJdvf9jEwC8nu48MyZ5WBueWvbVyq5Xqj3NDcCAC2IdlmfFQgngegdVYKVO4/0BaM4GKchrIErS50b05B/LABDAmk0BWp59SvNAPhWzswjKyqroe0u5EaHwRkZNDmvQ3vXghAkMiUMFKuLSL+40ETulo4RCAY5PQFRf22ZHIkz9pwSpo6cAww44Tk26pBNWRisKJiypt1BbgewNCiVtk/WI19Xin58WYBMn4niw2A4j94kALdPJmeTWkMziu1x3i/+vKyzRljLPLbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:44 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:44 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 8/8] client/player: Expose transport 'Unselect' method to the user
Date: Wed, 31 Jul 2024 09:17:13 +0300
Message-Id: <20240731061713.435586-9-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: adf9c9ca-35ba-48da-2433-08dcb1287dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYbFSMybFK2RqOZl/tpzpdiM1KsOqAG/e243IV12kiVHUH/xwBIJ++Qa/oP8?=
 =?us-ascii?Q?3QoRqDJ3d0q7xiesiVUb3taafXdRPk10+RM1vbWsvTKF9b0vpz+/jo0fHvIE?=
 =?us-ascii?Q?j2uWJRFbIkeRbw5h9CCPLQPwBgtSuxPwms43o5skGjnAjFPTNdtm9vdWIOJz?=
 =?us-ascii?Q?qGmfv8oAmJnFtBZRZmi7l/lDblSCEp7SVEgRk1US0FXc5ZWabs/ScsLs5gII?=
 =?us-ascii?Q?8AzUUgCalsOiXthAqNL0XasveEH/MoyuvkWSUCFEbwUyekQdGejRy4QTXSgK?=
 =?us-ascii?Q?egy80Z5qOyH/bLHDsliXI2K3v428BkEneqOkfVKSNv7GS5E6GFsRSCAtbw9X?=
 =?us-ascii?Q?hP0rZZ79nY26fN96almhdNzAUdWaf4cjwzpGfbOin3pqhgglhE+gKeYpEibI?=
 =?us-ascii?Q?1TDDT2XfnHqMebpxkXq76tasLzvPg9AiSY06CYwbbITS1tyfquXQq4uImYIC?=
 =?us-ascii?Q?HP9JkI2MTJHTUNC9IMbL0iAAUJ/B8oCYo1Hpc99Ngp+Q3eTirP+f/xHYCTJw?=
 =?us-ascii?Q?qJS57+C5V7BC+8SFEzx/aHpzTZpYE7+6NGuGMgvLtKpxj57oszQXiA9dbWV/?=
 =?us-ascii?Q?3B7Y5HdXcd0ashQ2FgfyKNa8j/+lmypFpsBHXJmgw/eMhNvAx1k5N45xSWsr?=
 =?us-ascii?Q?C2jLnbH4Z5dPhAi6qyin2VwxUQBQn7z0hNE2G5ZFmoYJvlXN4phyPU1S5d6F?=
 =?us-ascii?Q?Yw2xA9aVRObKcSnKVrFDExjdjr15zOwaxaRLPgS0k4/xbFOAEPB+UCtCP7Um?=
 =?us-ascii?Q?Bge7b8pUzR5ifuL+uJSFLzAWPGU1BPTCCs2q69ORVrRNPpQWx9PySVkGOYe0?=
 =?us-ascii?Q?XtxYMqadoEGNa4O6fqI0PJGOYTCAGt5bfxnCnrklcQeMcUVYCcZEkfkC9t3g?=
 =?us-ascii?Q?azPRZOBr4dT2ezE1QIzHfYJ0rezft7U5CnLbzEoHw6jv1YTm51Ne+9NCrJtZ?=
 =?us-ascii?Q?g3XbTKZPoBzr85j7cmDYKYAnCI4aOra8kfe3pYX/VmtmZYrAg3Mr/lUS7JYX?=
 =?us-ascii?Q?rBALQW3zzaw0ZZVzJ3bcaTXQU2OsOavCtRILqmpWLB93kCN8rLvbHDgm8nK+?=
 =?us-ascii?Q?QzuaqHyNWDKNVYifYODq7bF3GxuKiiIQW3Uij32CDYkliiNDd7627f5uR4Fn?=
 =?us-ascii?Q?3f7ENqpXlQ0QW5pEC0WHqTaAD/EBF/I2NIjOw4CEjac2//bxBH9BhZBISBaU?=
 =?us-ascii?Q?hGrXyCHOgTP7zzfBUPCPuUsmTvMIONt2aa4PMyPwGbuJrHTLkmbd1rN/119E?=
 =?us-ascii?Q?rX7Nl2bFkF1MpofFR/fkSl+Sv11Mvefg2fHTAnBForp40MYs6uQA81pyICBJ?=
 =?us-ascii?Q?XX4VsvalikRaWNsZhLbXu0vB7jm05f8TxlOvgoP2iCDFOpxGVYy/Q6w00piB?=
 =?us-ascii?Q?qnj1DHpXa/keqAJXWr89Tk8yRr5Ddv7xvvTMfQvlEQG0tyL6Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vrzj/nWknKvc9yKpPYJPBk9yWecx+41gA8aeWhdQJlHfjBfutw8xq8NqiF4u?=
 =?us-ascii?Q?YvZ/lTA7VOE9XUP8x/ItOFrAW4pq4XMtMKWFalRWBLwrKTe9rKn8SSVZp8jj?=
 =?us-ascii?Q?pr3PyFbfXhqJb+tsdqAIY8fFohMm+8om1J9VGwnBRvkXJng3AMAXpyXuY0I3?=
 =?us-ascii?Q?1GHbwVKJpn9uTGvBiNydDFxyS47BW6zuC9owxGRvHJ8jl8v5DOTR9ggmGmSd?=
 =?us-ascii?Q?S6x8Uj3DiF90LbJzeEer5xV0Luj7glGUHJsJvDHy4d4m3khEdLni6GT5Es03?=
 =?us-ascii?Q?tVY7ASPEKarGom3nHBMsh8IWRG1hJzWopDDqMaw7RGyzk4PJ6hXraPlFKjxk?=
 =?us-ascii?Q?qwipa9jLrLqR/Nfdg0jQfU5NINGYT0MBDrs7ycPrp0P1bstKKBD5XyFgT6sp?=
 =?us-ascii?Q?STUB3sFJfYUl/jUM9bFWD7l940aXqD8DfseNMJbSC8fhRvCISUYFKVqIWnhD?=
 =?us-ascii?Q?PZPaKGHxDc+LopdDYpKiCGGJz8hb219tdRwOYp3wQn/lee1slHaXtJGDlTpv?=
 =?us-ascii?Q?hg8vQXL0zY3PuY9F3wDhAczAQBIUD49sUxFshE4swUbfuWzyOHKrXjbGkrOP?=
 =?us-ascii?Q?3YyaJJYH+dmpJ3aptaz5S1KfciHqlKhGDFmsOsBlokc5TP+Yy5aABWuOW+kc?=
 =?us-ascii?Q?/jcx/uAlPqd2XUc9k4NUOlV8kw3k+9TvYXmr8mJXuVL8YatNKx5iRYb277oH?=
 =?us-ascii?Q?xAuJ8U1QHFp9085cySKEUuZTK4BaG7SQytKOzB7R2KNfKmAqDHnzTIN2H3R2?=
 =?us-ascii?Q?kNczispfuQzZoAV4sOC7E89WIVmuuv5FTChJFaEr47iLbLgZIA5SSWId4X0P?=
 =?us-ascii?Q?viTkobZn0mSiKPAsLQqFgxaalhar3xZi48bc0oqsVYxXldvslUBY1ul+UeKZ?=
 =?us-ascii?Q?pSSZK3Qgzr8u9KWP40bHprWvjoOQwpYdS+MaoWIPHFEZ4xBQ5Gwh1+voDIWo?=
 =?us-ascii?Q?JdGViqXd6pAV1iL+a57tp3rJZw2SMR09YoEHRN+Q9V9Yl+cpNy1pfgXs6q2v?=
 =?us-ascii?Q?lAnGR55QaqWeHuBWZL+D8bc19+3LPG57eY9Z6srrlc0hbXfiAb9hPixIfpO0?=
 =?us-ascii?Q?Bh2QBNuF2w1kXdCv6VqAWvgEnwN+3/P3S1mwNCzyO5C25pbwxz7OFJRmhH7I?=
 =?us-ascii?Q?KoTBJ0wQL8urV0ZR86b8BYs804pN5hXKCWFSAOzL9Fk4mJx2n7CK0DctlK0Z?=
 =?us-ascii?Q?FtiW5xCqfsI2XcajhfgUVq9DSFGcWq2VYU1FLXETltOaP3r6Vin3bwT0FR/t?=
 =?us-ascii?Q?o98JWBfP1qq8ykNTRgKWNk2Yr4P36AynFPkSGVoMAaceRNQYxEYJdWLafMEd?=
 =?us-ascii?Q?UKzpyZN8GGWPr+HG28h4dkRRZ/HtF3epXGX8SPsBMcJHRwvdccJQvxbhXZjY?=
 =?us-ascii?Q?RhTMueiRazjaZnUB0g4SH5uhomryVgtXA+WQ6ycZ8anHA/J2QadQt94SLXtl?=
 =?us-ascii?Q?8QkrM/mvP/UBp+5tdnGrPVnABts9rtKnnVXyRMgM/ep6U4xC+hPrrGMo7dS1?=
 =?us-ascii?Q?cOXGXIIP8G9Q02GUP/7dy1aBKKV2Gw87ReedqoA6CZO66AQEh+2+q33vyLtL?=
 =?us-ascii?Q?Kbypl129weAxWwtRuvo00gte5YaajSu5vy2VBtRD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf9c9ca-35ba-48da-2433-08dcb1287dad
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:44.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfH94K0IPqTqEkkjLqorhGAuQkrLaCVZAIz3dDU2YeY+OpYkpsCJ/yqN2epBiO0NgUgIQDx76HyhqVYT2XYKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This exposes the 'Unselect' method for Broadcast transports. This
allows the user to terminate the sync to a specific BIS, via a 2
step process. The first step is the call to this method, which
changes the transport's state to idle, with the second step being
done by the audio server which detects this change and releases
the transport.
---
 client/player.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/client/player.c b/client/player.c
index cc30022e1..51b9eeea5 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4651,6 +4651,24 @@ static void select_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void unselect_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to unselect: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Select successful");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+
 static void prompt_acquire(const char *input, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -4881,6 +4899,16 @@ static void transport_select(GDBusProxy *proxy, bool prompt)
 	}
 }
 
+static void transport_unselect(GDBusProxy *proxy, bool prompt)
+{
+	if (!g_dbus_proxy_method_call(proxy, "Unselect", NULL,
+					unselect_reply, proxy, NULL)) {
+		bt_shell_printf("Failed unselect transport\n");
+		return;
+	}
+}
+
+
 static void cmd_select_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -4904,6 +4932,23 @@ static void cmd_select_transport(int argc, char *argv[])
 	}
 }
 
+static void cmd_unselect_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Transport %s not found\n", argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		transport_unselect(proxy, false);
+	}
+}
+
 static void release_reply(DBusMessage *message, void *user_data)
 {
 	struct transport *transport = user_data;
@@ -5335,6 +5380,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "select",      "<transport> [transport1...]", cmd_select_transport,
 						"Select Transport",
 						transport_generator },
+	{ "unselect",    "<transport> [transport1...]", cmd_unselect_transport,
+						"Unselect Transport",
+						transport_generator },
 	{} },
 };
 
-- 
2.40.1

