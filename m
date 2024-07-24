Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCD15A853
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831723; cv=fail; b=sMaju4YOvAItrxl4JbJORNnUQnJYzAwdggzCEVkww4a1NdpZrQF2iwwYvkYrBWyMZy9LQEbkeeoT1uXRc+PB6ZRcSo25xM/dZuZnwavhrclzF8oyW2gpGQivAb22vMXDcXKGxKkbIrGIcPnWIqkPWvr8TPFPQl5ki6pfCxNsb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831723; c=relaxed/simple;
	bh=CmmC6iFRScey7GGcg8bk+zTx0yNf3xCzVlu0pe4Gbgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dgCOee/JDPCxmayYxPxp/uDO7QP6bDnOXxrvUAHbW9pxd2p4pDN5l0QIQx2i5Hza7H8PiEq/llE7NndaOE++zoJL5yLz9gU8cw/J+koaVJJgNGXsJ4iEJkuQaghJlYW4Pd5mQDzbgI/l/n+ca9EBfRY3h+sDv7oQnxjcWeDAFzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EfcJI0Q+; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EfcJI0Q+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9zqxVe/VJpU8HfUaOyRwr2v1CfvV54fSAymld0fAP+CKntbI6d1J59ueQhdIdKzzg3nqY8Aq4aR2lhIWoXYQ39xqNVGiVRbheNBJDssEo5SKWPT305TLgO7AyyCpn5C4DbfBBOOFT01MdVga/4bLTvtxbCGwVJSfwYc9f7YxtCDyis98Bi0WpxJr+5oXMfH7IIe8KoO5Pd2xDHBeV3wtV3xlx5epo+sbK892++7u2WETim1sA/RnRRtrzHzzuTZ+Aa8/6TA4uB6rHqflKWJtMt5+q4SP3zAaq0piG7oH6drBvvU/oOIfcqSb5wIjKcP2xlVo4LCogoQ+fvSbiHykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAJw/dRco6+vXcKltrgyg5zGhdHLB5te2nNGHf+j2sE=;
 b=gY+lEWUtd+X1hO86OtQDB/by0jgUluoSpy4CjJu1hCVX87BS8M8cviUzDoXnMvuVpQ3T6zr4cACIiTsUmzLAUDHB9BLqPbW8II0ixNTr9JCX+nOA9X8uIX3VzkMZCI215eVD0vU6Rwi3C4l6nYqIur1sTg9Ohu82tuYw7f70QkbSpu5rcmARDb/fsgOiYsWPtAKYpruONhr2lWYmVdOjpUJtFCaQl8/Zj9Cz7aEKe0qPXfELOVBTwISQl4pUoIYfE9GnN+MSTFD3bFq7Arj9hGlsmE1kHLrr46AWtaDj59M+iy4BP9kEZ6/BROXaO1QqT3mFdmU8rpzmi65+JUWjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAJw/dRco6+vXcKltrgyg5zGhdHLB5te2nNGHf+j2sE=;
 b=EfcJI0Q+5QT2mczJjxYim1nFS3ryjqrskxhKefqUdx1ajgR3oJHVEg3+qcdjG/YNpffW6E8BOMWMii9sbruINfayjpOD+1604eayFzvcxE2bhZ0BA8Y1itPJTT5ZMsNrsmJ8SWHoXEvv2Wke8NeHMnRXO502Kpl3TMJKTujFa2UZEvmPXzgTDch8C5guK3jUbnAvR4DRrooAm29xRDhFs5fC3Jqe6c9b9R7pG4QhTXXij0pz01zPbC8Bcots2Q3TbhfksC2FnAvWMNtaC2TgZWOJryrd/AsLK9OlekBWntJP6FtJFYRjZ+mD7rZon5Exg1SOV/ru9tCwl3QfLhbwDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:35:20 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:35:20 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 3/4] client/player: Expose transport "select" method to the user
Date: Wed, 24 Jul 2024 17:34:24 +0300
Message-Id: <20240724143425.165959-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
References: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d62e851-8feb-4ab7-6fc4-08dcabedd806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFVNrzMcdLPT4ttoKL7ooNb3brYWpJY+/s/EghffHHZnhtj0wNmv0jxxSYSL?=
 =?us-ascii?Q?kG/caoSIJ8GC6MZfbsSlkaQk9Y2dAiK503We6BSGupORzeQRDKGyk3hRpyWZ?=
 =?us-ascii?Q?X087yIcfmI4RWVcfOy90EAUlmpMyz4j+mOeIGKHVTxKYyF+s9B8JVXUmViAQ?=
 =?us-ascii?Q?WHH7kYwVR98jaN72lbI2eDPw7VpIo0gQ31N4f7Oru1KJ6s9dHbUE2X9gAtIO?=
 =?us-ascii?Q?7S22YvY31r5550x6PSHaSw95Ublv379eKpEGldeXH56nT7TfaYtYcXeypxC0?=
 =?us-ascii?Q?/bNTVG1WgsF6aHPA4dva/zGKB8kHne2ZpXWiACMkJVxWwffcnUBM0mhgpY4y?=
 =?us-ascii?Q?/BEdUzas3u+dpZobgFw5DrOI/zrG04CkSuEkQAvVenLYehCLa9HYOAz1iYbX?=
 =?us-ascii?Q?ZhdJFMAZ2oZTqhwJ1oUeuVoHXPq8ArmFKPMT6+P/2yK2r37EWq1Eaj0JmeIE?=
 =?us-ascii?Q?MmpERYMHj/WcPD0Zu5qmtk+wiWUB4Aeudglvzr7VStBarB5tsT4YUkQT+3ax?=
 =?us-ascii?Q?NugPrRPz766r2RKuQ4Pf1LGw3YV1vpIoKiKcJfjXGG+tne5uhbyEwlHkEMy0?=
 =?us-ascii?Q?N2XXMTdMd6y3bRzV79cjtbfGnjzONxRNBlERWp4dNaJ/DcltN8naG/oHFCFK?=
 =?us-ascii?Q?7r7rBnL034TZ4VvBxnFzvfNJrOzf4MwKJAL2OIVhpqP2g9x0q07DlOyL1qSH?=
 =?us-ascii?Q?82jjVExACU0lc3twzgz8lja5AIQgAy4/mANooQfI8vJ4CfDO2/kUIWUP1Ev1?=
 =?us-ascii?Q?+D5eKg2pD3PsPxyrku+R4xYTHRVbn8cNdTVMnictATapcFgqy/sqRMKGEWF7?=
 =?us-ascii?Q?ii/Y60CB2Xr5QE+JAGocaxPoAZ1K8pPfMNf/z2dYBNc7csW8LG7E6LtzKwVW?=
 =?us-ascii?Q?0FJKFPFlHn72mYAns9Gsvga7PfwSNJzx32QWTO2IHI4Q5XUcHCBFBvgs0SAg?=
 =?us-ascii?Q?Nmtk2OwrFwQXkBD3ujpor/Yosi8+EUXA7dWhNJ7QodVKSzA7lOcRD66HO2Xd?=
 =?us-ascii?Q?w41bb/5JKa9UGCaR9CTUzoYo13PW+gWT5fJEP60zhzAGyN+Av7sIM4yKXBX4?=
 =?us-ascii?Q?Yxc3441kIsFDSt8QlX+tV6iMDNXU7t9KrDV51PVNlr2K/u7NdNulBcybN8Rv?=
 =?us-ascii?Q?pQlrWUMuVAbnw5B1rAzNQbOOS/G5vZoXiTyRW9s3woqx63fQS7oeRj8EY0ma?=
 =?us-ascii?Q?QFZtgOjueE1oGWE6yjy/4rHJCeyy5ka1ig8wkAR1p0EmrZjoK2+iA9RfrLmy?=
 =?us-ascii?Q?CGkinRFQ4a+54l9HCooHUIA9hObfR+jdYaXiiSvI/eSJbbsTjNerXsKm+JNZ?=
 =?us-ascii?Q?ykiOs6L6O/BqlHeoPhPaR3wCLr8E2Sh7+Yi1t/Q+F++6dilmzj9qMleduJrz?=
 =?us-ascii?Q?wyWe0r6ggZyx5r81RHPoScG6Hmvbr+edaCkcFmqQrnrts+AgwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MoWTI5dyMEYDo5sR1rLs/xXgRYpkp83zPtn/TYX2bhr+WGuvrG5/EKBhup7n?=
 =?us-ascii?Q?R1xJo6PQJXTglUq+nXw/ZKqY7OURCR+uCnshbbiD3hgPNN2qT2+KzseNWSnR?=
 =?us-ascii?Q?Y7NeJ3wMkbKB3GZJKLDKP6qM4qLePVSB8gIg72NsX4le3JFpOodaNrVc1SNw?=
 =?us-ascii?Q?9owLeN0/BkzxGi7ABfOdx4KwCVQ9x4V0BnSwUeBl3rdLVvaey4fYfvlPfdzy?=
 =?us-ascii?Q?7W4CLAhWPsUNS8+9gQiJzoAlJnuAlr8gMiz9MDI84rOIpkel+PHZTx9yv+12?=
 =?us-ascii?Q?jJNdkRoBbyo8jM0f7AK9kPUztZLKnIy7ggPVr5WQyUszXkznYaR1bVoWPfAJ?=
 =?us-ascii?Q?CMOIcoCJyTiXyjPmAXPVTCx6GNnzcR7brLjiARSKr7C35XCTwfgWKTQuIB0Q?=
 =?us-ascii?Q?UoGOcVvj3Qz9Jioc99zAmXY5hjEACR4Cx5dVFDG7Ttb4ejyxZ0tLoFhhBM+l?=
 =?us-ascii?Q?rSQ5SMooLZdP4irP1/TI9Th5XXZqNAmUbGQeaHrsH7UY73BDB+SfDF/rzG20?=
 =?us-ascii?Q?nlL234zeHNpw+xV65Rs2gCoBxaiPbaTgNCejIsQcTQQcLLsO+eTmOuLgx+jz?=
 =?us-ascii?Q?wO0O570eE7fBewcjvJuMiNRJTlgLIFiJ22Y7GlCTX7B0OzwNtCZORU7UrYGd?=
 =?us-ascii?Q?rYOevUlNEQ274eKI0dZtfm5zg8HPAS/5fZEATUXiMMJgOtkEoQalsBfpl5Ux?=
 =?us-ascii?Q?lk2BlsU3dfeS9FuFiXWJyGMZDWEl2/8RkRTpheG/R/2eVLML5QPOqOPhFE7y?=
 =?us-ascii?Q?CW63euj54GMADSFtqXU6hRYAYhR9jVRmJFSun4psOKr5kqgjc98G5Qkq8z8T?=
 =?us-ascii?Q?jyjaNJfEranIYNNd8Z4fwahF7gK9ytcymheWqW2Kic0WniIIXw9/qN9/Yf17?=
 =?us-ascii?Q?JeQNwnAzVK7uMe6xZv//WTne6sJ5pR3LrE+dvq/JRanFzwznw5KAgdbOaWqS?=
 =?us-ascii?Q?9coyVhvUddGGN45o/GKw15/Pq6+QbefEYk2CYFVgtmD5Dg5dnNFaxOszJzIi?=
 =?us-ascii?Q?oi/xEfhG+fu/nq0RAJRspvELRyqKvgGvd5tU84kZ5TSY2Rl4lp17QI/K0i31?=
 =?us-ascii?Q?Md8sbcH51o32u9eyy5uyWc5batBShIT48YE+QS+bA14vGDRJWj5hHK2Njg5x?=
 =?us-ascii?Q?oEPfalreGNP+2Pvog1Qu/pi2MykfzaaPhSokwbzM0dNkzOm+qc8Szwmlakal?=
 =?us-ascii?Q?I4jO8k7K2o4y2mYse0P3HEv2yvqVgNSe/O1oSwj1mVb8ZNzP8o3TgA5z7QSa?=
 =?us-ascii?Q?6tZdH1MuaQbZyaTv5NWqb8un8JmOpAchgnF8sevC59vEny5rS/QhlWN3Sbgr?=
 =?us-ascii?Q?VJCVyA7HxPTjl/Bptf0ILKbZ657M4Kgny/ImBbIRXYnHrWzuVAlg9cXsPHL3?=
 =?us-ascii?Q?c1DWe9CVr7TdL6OsnJJyMXc9LkhwCCJMmiunIDeBEb6w/Q5x1KaiLn6kWwhw?=
 =?us-ascii?Q?uPXh8gXbTUlWVpyGogTXcbZ0XANXz6PodugzXjcyIwRBHIdzbYcaVbbtRFPx?=
 =?us-ascii?Q?Fdaencc6cjwMtojsUtae1PLRhIMQ/6mHf7HhZph5owJ2HmlOSUd5sT9FAapz?=
 =?us-ascii?Q?4avqvGcbZS7airaydB/kOrjn7R4Wdtz0kGKKQ6RG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d62e851-8feb-4ab7-6fc4-08dcabedd806
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:35:20.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG1sb8OC1lqgoWHOVDRfLzhxIHN4IQPIkP/mRfdD66HgUGYW69Y/26dw2bi3UOs/RKHb1UoSCYzOnowDe1oPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

This exposes the "select" method for Broadcast transports. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 client/player.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/client/player.c b/client/player.c
index 2480ed64b..30b73c9cd 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4634,6 +4634,23 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void select_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to select: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Select successful");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void prompt_acquire(const char *input, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
@@ -4855,6 +4872,38 @@ static void cmd_acquire_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void transport_select(GDBusProxy *proxy, bool prompt)
+{
+	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
+					select_reply, proxy, NULL)) {
+		bt_shell_printf("Failed select transport\n");
+		return;
+	}
+}
+
+static void cmd_select_transport(int argc, char *argv[])
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
+		if (find_transport(proxy)) {
+			bt_shell_printf("Transport %s already acquired\n",
+					argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		transport_select(proxy, false);
+	}
+}
+
 static void release_reply(DBusMessage *message, void *user_data)
 {
 	struct transport *transport = user_data;
@@ -5283,6 +5332,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
+	{ "select",     "<transport>", cmd_select_transport,
+						"Select Transport",
+						transport_generator },
 	{} },
 };
 
-- 
2.40.1

