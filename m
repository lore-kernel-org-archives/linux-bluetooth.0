Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B251A0B07
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348627; cv=fail; b=ry3rlwl6RwERSObEfh6iZabIb6EAfC365r4pojyiHk6altP68ti2TjnuKrzmJXS8BmdL64TuntBz8OrAMtQbYULJpuECXuybXPtP6sjYso3RgoDGOpHH0WC7E23QQUmPd1dpxSOh/7583y3itahPNe9i0WNgv9pXoY76I1LmxAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348627; c=relaxed/simple;
	bh=C6ScDrkMAD83Y76MxJYyAX5K6fhgAjv7nDHs0eFRnVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3pZnjoiAgHOfEI+Io8miZCY5aQdaWnn+WjuZXwZXiFt//s6t4+NvYnXsmDE7HCWhYhyxwMdcect29IHxpQ/5vRzhqXAdmQCYygWPSZh4pd8IL8a4/63eJI+3BNNMXEwkvwiCGZ7HflDhJYb9sj7w1O52OjfkWG7j42OgZ8dXXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YAfJt6N3; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YAfJt6N3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj9zEmVn8YK7nl7wI1sek3dIqcSF87E1dQbshvcEnLgr4MRneKSSMgYCLSUqRIw4XgknpLvlbua3VcQek0mkxdn9VEWwCteSXNEhIS0rDUKtYMkaceRFtUgBn0dTWohdk5ENXeIDBvLkwFSQarUVpDq2Wlo3FjG/3k2mnXRD9NWc07L+dl2yKckN7WnVcTnm3njJR27CC55ihj7S41iErEiyY35nTugYVL12Rc2K8FfzYjU8fHOkVLjDhYNbScMqsXH3Y/PYydCTzVmMcvsa4NcFdUIX5yn9R0is4gTxrQUAi0PaXM10mPrV9Y4vqY+YkJAWx5E0Z4csxw2eU/79/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2El+uiBpaNbjvMOYHfoSPjMvWIA7FEKk1YdW8f53aLA=;
 b=S5ajFOaE/B2xc16Iy3zR8KiLQUgPL1cgfq1LzFBZyDH43IcKO94AP/qpPYpBmj016pyDf/Kj8jNJMF+wcXqXIuQFrQ0rwGzwEQvhSQ2tTvAAbPKo8JV2sJwAXSZnSecEz5gld4T45H2/hhCZU9RHUbq5F+VkdSuWPZo+JiDlK7V5nWatduWKMUzE/LHIdXO/IWat+oSkdO6bb5kBjsv8OTrjnnycFozi8f6v7EUUnP+1ZefDErtMoZ6Oe5XfvP35iSYRLcjbERlvk5Q4TvejBt/oYt/F0MApRSkCg3eJy16oYg7C74o8+yp7zqiOv5ZRRl5kJamFoSf/qhQvS9LefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2El+uiBpaNbjvMOYHfoSPjMvWIA7FEKk1YdW8f53aLA=;
 b=YAfJt6N32o1xvs5byuL4WWdi1sHjYTP1kb44vEsG0dyxK0Vhm+F8ZGVaYerzdXEUr1hhoL6VmYayBFbysu5f6y025tBS/Vzy4jSd3QaOESFp+00HfZf03/BA9H19OI0Ob0kh4zx9oys3XYoh7HJ0Sn2fkPErimwrfZXexO3gLN22dMPez7gSybNFctbYdoAOghb+8sceBsJh0GUcufIkg7/FjDPg4vK7AmjTkMQNAtx5rQ0sz/55dkS/V92ghbRWk3Of1eoggU8nXqGQ3oWyZwOJgpkrs+aiNUg3RGNGGznqBY8GgJhU4XMzoXrG0tKkJTsI1iwonIedj+um3b0/Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:18 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:18 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 8/8] client/player: Expose transport "unselect" method to the user
Date: Tue, 30 Jul 2024 17:09:47 +0300
Message-Id: <20240730140947.411655-9-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f9881c-f36e-4ec7-b8d6-08dcb0a15721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZeQ4JYmIfU3AYw3s1F71F0/R44rldWtgQGWrkcoecE7fZE4OIz9mju8JPxOl?=
 =?us-ascii?Q?VCPrGn1ZpVwwnplA/83/JmVTc+DPkrw2DggTGN10C8XXFEKMHVf6tV43aCDM?=
 =?us-ascii?Q?VG0a4CJMH6OVZiOctb9VWs8cW0lNOik44IBnz7k03RkSgA5V6hooFB7Rczrs?=
 =?us-ascii?Q?BLu7+9aL4NQewCJRkMHKi1CLOCBiq6LwaWbuwmHv2AujJRoMAC+KzBzCk0vQ?=
 =?us-ascii?Q?3a734WkjXJEan6GyKyuXcH50FjGZ0C6T+mVObjlDRb9oAog0guFeOIIyQLbj?=
 =?us-ascii?Q?VsZEjsojeWvQ9fHuwasvgiC3CHC+caJXmcJPKUCI58S6j2St/RMDi0yeA/lM?=
 =?us-ascii?Q?9s2m7+wLy8uFuaBrjnAgCepLVpdyUoPfj32Sf83P0NnqKERC9Zyu0ChjyDJa?=
 =?us-ascii?Q?6qALtU3ClWWM0G7uFKfBSsOxArWtm2LIsFCWEiM94S4apX6PZrpxa+D5GbCJ?=
 =?us-ascii?Q?t5fBKRswNBhtiPABDa/d4GTuLn/Vo32zsFraVSEjyGCB3DBszaQgWs76guHb?=
 =?us-ascii?Q?XUsXti+B7TQ0MTpxV+TVe5pjyGfSQ1w3bIUOJUDNzU/ZGiLXZ49s7r1mZIoz?=
 =?us-ascii?Q?fyHOTB8drGO9FkGM3m0gy3DQ42E+mdB+mhfMWPDfVuuxF/tK29yGhB84oR9E?=
 =?us-ascii?Q?nEJ5fSlo9iEnEtRzZsygH+nGFAUVU0o6xfz4cEwGLHyrmOzDRFG9ut0ueqLr?=
 =?us-ascii?Q?H1/jOOp9e84qYJT/B+QDmeyYd86sYcAVCbPwKLHpIgOLWvJ2AQ5TcSQDBp6L?=
 =?us-ascii?Q?IApRwnIGHXKepOD68riBY8Bcqoz10TXbTkofVB3e51quHXsE5Xd+RG2SnUy+?=
 =?us-ascii?Q?ARCFjMHrdkEaIa6W22QSzl0yMFCqub6cZpcffasqX6nGdEE4kbVBPsYAqAiq?=
 =?us-ascii?Q?KnpYHtYhuMt4jCA4+8RqmRxZ8Q5qaiBgErSyw2QkcoAX21HZTQCz52rMdeQw?=
 =?us-ascii?Q?SHfdzFLRK2rQxegGMKkEdyDJYFhnsOmn15eJm9Wx7PCP9DKUKCvuLuuSizP4?=
 =?us-ascii?Q?dczZ4IYmnPRkNC+P+dufnNHTOGZ6UhYJPAxhslHkr5uXxxiFz/gSRzg6kibd?=
 =?us-ascii?Q?5wuQToiORir/tO/4fmX2Dmg++c2Ad16FdYaFGEKj/s//EDgq5FawjVK84wp0?=
 =?us-ascii?Q?s3yPK4OdHTplTuJQUlb//kNrcy2w/FeYvsdAAS7Z92Ku7GzQBIJtrqaAwBtW?=
 =?us-ascii?Q?R4HsJCObKKTLX3irQFaYK9wOn91NN0VrjO5ZPAuI3PvqBd7VSRNLHRBQKgiQ?=
 =?us-ascii?Q?uSnaBz3VyCURMf9HyNsZAnvBDt1Xvu8BK/R4xkVlUd0UgFlP7LLKS/xiwAQO?=
 =?us-ascii?Q?YBgh8XsqKEqxwIK6M0JLzA9mA9RZG9XnIvmetHiWdo8TKRKlRASJV/sLMwbO?=
 =?us-ascii?Q?zy2bcWKA9fQnFXMLsBSF36VZFMGJoY8oRKbRLlnKMXR+KKcYkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNE6lRXH5WvhgyI592RGd2EJ5j8vHWZJp8zrCRlRASeLfDTgxxkqIIEOwC6Q?=
 =?us-ascii?Q?ZGvfbogyyf17gy1A+gkk+3KE4ya2KElEHZzS8/AlgrN7QPXEAIFhR2pfHhl9?=
 =?us-ascii?Q?pRqY9i4j62lJac35KxULuLrSCBhYr+osIi4bQ2qTycN/cD3Ci3HIkTGbTw0S?=
 =?us-ascii?Q?Xz4Sv0JGVoGi0o6ALD6RPvLg+1g0uFP/XY4xZU3hLDaly83aRg3lnn2b4nmn?=
 =?us-ascii?Q?jnTNtXQyvZWKtEpUzWd7rpn/ROx+DwKsrI2iGrPn6uK7db+Ppj8M3EmvElXy?=
 =?us-ascii?Q?wTNAihv1HmGELesvSLC7hLnGfk6j3jEE10QdWscqUe+xVI3C9RA05wUqbxxK?=
 =?us-ascii?Q?KVBRy2RsGfMmKtGY6uKuTbSvpOBvPFqxINqwrwulrxNBxmPATkAdwwHKCruk?=
 =?us-ascii?Q?7uB7DN7o+vNcLAXxw9CDS4MU20w/HJSE1ozYB/k40utuanCiqVQ/vSUUnpdQ?=
 =?us-ascii?Q?0Yu4ML+qtkgsxkuBze9W/tlmVggNWXOZrXW7IQjUbBJWXYhv5XBZj/Ux1ApA?=
 =?us-ascii?Q?OOHCNeZriUxrVa0e2ava51YY98L20wCJowSLcvDBzaCbep0qCurH/M2fTakq?=
 =?us-ascii?Q?OCjy03j0J4KAcZMYxEzYwbiMBHAL+ae3B+7ogP551joMMBGkF6pbkY8XsWRY?=
 =?us-ascii?Q?7830sULI/BJfcyAXUqhwjKmBZ1GLIpRmOg1o+A8OKzbv6PGgbQehw5SBd45f?=
 =?us-ascii?Q?5Ln3YOOk3eiNUYA1j4/KjreAhqEP7vVulYfIcjYs0sU4t02ipJuT8OOQVInY?=
 =?us-ascii?Q?v26+hr0THScOP2GbkxQrWtlrHEsyFaK8wG4edY20wMAhnifIfMzwJGLxCjIj?=
 =?us-ascii?Q?1gMbZySNqnpQFBuEQn+h92BlBXot7Xu8PdskwGBLCelj+Fn64VNN3OGsROVR?=
 =?us-ascii?Q?pkJTLZ5kwErHzG2tPM6xnlCb87aF6ShP3iiz4CiHDIU7jw8LypNhsorHJiCi?=
 =?us-ascii?Q?QntQrxly06W2uZ2cGLp3WC2YvrDL1LXFGjhETYvBIHpFaVjGSy8iNAtILnlu?=
 =?us-ascii?Q?UVlpWmX+08Odbv2ZrOKW1z7Dc/7ZDmgs3BXMhQcCwOLdiyppzxz9lrGiyMTC?=
 =?us-ascii?Q?uMpufZPSCusBMOAczdz789AGPpPadS14X7TR6m5/MTZlcQOksMB0qkPBueeg?=
 =?us-ascii?Q?xYrFpRN/Fy4MGu1YADVcXye16V/bMWDaa/eGJmw/pDvN6s+91H849AIz0Maw?=
 =?us-ascii?Q?v7CT/bRXzWmgJmPrv1gf6phB1ExI45BqqaXR0kObQusN1+jnpX//q2gEtHZY?=
 =?us-ascii?Q?rYMqcWO1mLLbjoGNSlA7U4c5a03WTsnlYdFV/QqrV2McBA89Et6ddM8rj88C?=
 =?us-ascii?Q?CIpoUbcXXsR8whypkqIQqav/LnF0LIA2AfiR8T3uT1v6IMAWXddq+cPyJkW8?=
 =?us-ascii?Q?kD5wKseijcfLtnTSdVKinfJDntISSbHLlouIaReoqLagubjvYDWioVVhKqVY?=
 =?us-ascii?Q?Jh6r9XsWjzVzrJJBRuVs6mY9RuM+l+gFd1xlD/dv/k77f9XOW2Gya7IIzrRP?=
 =?us-ascii?Q?Cpp0gAG11aWLHhY/19hhdY5bym9rdMY8ENVR2z7baaO2h74bbi3d0Jde0epU?=
 =?us-ascii?Q?Wqlh3fB5QAKjoy4eg5m3+9YuFDrzpwAjm6gc8FQC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f9881c-f36e-4ec7-b8d6-08dcb0a15721
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:17.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbMIq+epwFa0l6cWEy3SkctKX78npZqREjUReIR0vqS83FACnR0fRV2ZldALjBcUoAsPN0TPs3ckrOpvZFwckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This exposes the "unselect" method for Broadcast transports. This
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

