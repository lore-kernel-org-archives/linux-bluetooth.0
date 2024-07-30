Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DF1A2C34
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348619; cv=fail; b=iCiCn5ZqRe6Pga1RXB9RYKkDCN2P4hL6vxcDey3h0MzVzYeue4JR4zMwd/Z4kYvGOEZ5uRpSzDBv+ywbuZu5HT/INGocV9S2VGEzph8VUHWzd4o22YRoMfsfDjFoECPKFFCU1H41DBS4nLdsUPfUNvTb1JlkDW5JW6GcPMZvWWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348619; c=relaxed/simple;
	bh=KA4PKf58In4My50Y6lFWBf7aSxOxuJDAPxnvw+pVrZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+mZyytGwxVWRGsgquv+gVySU7i6PLH5EISuGuNvmaQLlOIPN0013To6gmisp88rbO/27ZBf3srlelBAU3ylBWhIt39RhEYsMT35jsftpaJuG1uAIEccdQx3aD07tXz6tDkmu4k5PAMhhHJ/qF4ajFAtka7y/S1RCYlhic+6PrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nkxAJXRL; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nkxAJXRL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahTClseZXYxW36MugCbIJ+gHY+rqTLy6VHj00i2ilY/Lp4MEBgL7MKG/yC1i1tYJ1pMZ8w/d7dWmsjMLAqdyvECmQISizd6T+suyZ82Hv090rC8TAtlG7xw/5nc8uUFMZZVKKBSGMfAqoJ7UqE4g8Xk8GHIPFnBDYzQYGVLtFh8bAufkZ8Y3vKPlfrhinVNjopeJjmmqVv1vi4EwfN/laebAZSoEpCd7KYO+5LjSjCzgDyE+44u0KwDV8LqdXTdbnFqzxwjcvuRtZmMzaZL7TkPMoCC+NVcO/EMea9KL3m/QUQLSMzdQf14x5caW7CdxMoV8N4Ev0o1TtwqbsQn87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2+0NRk3ITjvOslV6uWlnE/OODjnlBDSVl8Kn/XDU/E=;
 b=cznUcmRTpajMjUk1gAlqDxO17+HZSvWc/1xqxFvoXryUu55vikE500xF9opDysDO0UvKPDmjJHaM1s/Uv82up41X/Dxm09iERkkwi9f1FtNBSzhklYB2SWp9jdACNSnshvA30RIT0SNsj3RCGAa/xIs7/NfBdU2nN5LYzsvwS5c6ehLt40xWnSawSs5ULXbVIcCxz6fYjGXAV5MM2Kr8bACi1ZBUPeIOWj9MqrBNJ/FS5ZL2/fUoVev0cSXfRKmWwiyj5aPdp8ACFK0KjOYEcKo56QTpSoRKP1C005C13TZfSr+MV/oqmeqF+CYZ7al+eGmKGt/PIqPZDTMamKryFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2+0NRk3ITjvOslV6uWlnE/OODjnlBDSVl8Kn/XDU/E=;
 b=nkxAJXRLCmhRqTm+GlrXU9DrZHanUaZElGKk+grcwjFrZxTI3QFC/tl18wV8auzpBRsw0szsHdBPEB6PqczZTOLSSLjWEHP2vUnBhzC71PXw9roAj4g1Hv7tA8CJh5GlMEXpHIE73LDUkDHxtSnJ1PL3c6b5l9OTZ9N4lS/feY5P447OuAnXnAv1mnXqZ3woaE2KvHEtkeoH5JvhZl7e0cHYfix6i6YtGE7pY8s/fWGknnA26UHVL5zw8tm1JjOkxYCvzAtpcE/qm1e0P51+nWI3/670b1lWikj6wAzHkRE4U09R0cz21KAjKvN1YbOHdoqXjH3Kt8iDpYRDRJeTDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:11 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:11 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 4/8] client/player: Expose transport "select" method to the user
Date: Tue, 30 Jul 2024 17:09:43 +0300
Message-Id: <20240730140947.411655-5-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d479d45-3584-403a-f1d5-08dcb0a1530a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZXLHr4zUzXunImfaGL67C9wwwBAg5vNQ1hKYqEDYQQb9CMmZQokgcO0doVV8?=
 =?us-ascii?Q?7bMnCSH3bFlc4IXjrfIbfZ+bhfmSKj3ygGnI2jRrjqMrY1Lqk/hYzyNlIfhO?=
 =?us-ascii?Q?8rs1aGpdGoS0BafNKrXpl+W8gtwJYy24xDIx9Etgygxc2p0vFh/yKwsxbLo6?=
 =?us-ascii?Q?5NkRFEHqB4BfBmngfmcI8RbA9GrBkzn9jMLkaBtPV9D3x9L9n3Ejm9qu69WV?=
 =?us-ascii?Q?6a132XoT6gYVx4QKeoGujX8/I2S7+yaeptlpqmSQbdHCODY7n+qskTRwq5/K?=
 =?us-ascii?Q?LVwIcvPVpLTZc5okORBlLjejVaCaEcw68byDY3TGSqwaS2Hg+iQkMi6P0WBi?=
 =?us-ascii?Q?0R8I24LH5naVsD2efuijr2XDOhMap+GdsiGHDFfTstC/sKT0AEaUOX4Sm7DL?=
 =?us-ascii?Q?alMnUQqBod7OWiuSwAZDiBpilzNFDpgjNB4Z23ZZUwSHNA86RrbB/+5RxBBi?=
 =?us-ascii?Q?x8cNepZiNl72NXDGaDq0APWLaFU8v/hthYPkhvEcFt98rnK3hw0mXuRrHVk4?=
 =?us-ascii?Q?JX1BnNGkyrpUWaNn5TWzrqAPCpcE8jNjgU9ZK5QKD2gwmWF7iSRO3dehh6Hj?=
 =?us-ascii?Q?+7ShWgh76iH1Z+GQpje/TF2mJYjgzKTxsR0n1qQNcoxJmQXZ8dUXH223yeYx?=
 =?us-ascii?Q?vyUhGGHi17UGCkOzbHPNyMAhQIgnqqqwQLKkFVKLlT2nuYqMLtvXq4X5RzgA?=
 =?us-ascii?Q?A0ATxq27tLubyWslgCOUTu/EAZ/qIAohR7oiJDfnaM8aDBfHaknnDjD98ceF?=
 =?us-ascii?Q?/+7p7yV17qViTdd90sQlaajXYHlbWVBQaozeMhq/uf6/m7kG8s6Cgle5ENH0?=
 =?us-ascii?Q?rc5acVEIpAWQLaYoSfgMpHZGPgVWuQCyrwVBGGEGTvPUfj+VkAPgdLA6rAkM?=
 =?us-ascii?Q?blMGPTJP1Uyld/lKzjW7CAGrMRYSGzuUyro/hFm6cJyekQaKb0MU9fCRzpYU?=
 =?us-ascii?Q?1xwYedvAy/HfAI5ahE+gtuBNw5/hvF1cyJrKiiJgU9WOUdgcPAddYQLLq8P5?=
 =?us-ascii?Q?xF7OWuxxIh2pnv0DJRusdctKJRTB+ZUXNDeOJXemUVMyJCtSSFIcD0xI7kEj?=
 =?us-ascii?Q?13/I/sUkdLgLV/ysKvAo7AhkTRZS/ZsNJOfICvTTQR8Be/ld8aMUxgR5h/VS?=
 =?us-ascii?Q?Tfm7pTG9wWnY6o5MkpGbKwNJ8mw54zg3w7s0QTMff5uLyXnVFzmEWH4F6kSq?=
 =?us-ascii?Q?FvU4/Ue1Vpg9PNzA1xC4PeH6zJOLeLMjq1oIXWpPkGP5MaFJFI15B43lNjoL?=
 =?us-ascii?Q?SEVLjf0vrSMKeyxG6TwCLaVm2ob1qzCQsxbgHj8E6HgZyjygWHcsUE0EHmKc?=
 =?us-ascii?Q?kOYGJUme0xl7n1pPpUZbZeKDZSwBM65txcq0zJhLIdRAP5t9ZT7N3huv1Bdg?=
 =?us-ascii?Q?eWYAMaKsaGzjEMMWbHM/9Pm+zTn/NJhKU2kj/z9AWuzAuLoHBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HG/+QIxjQ2TkI7AAhp/VrWQgUQiHdewjKE6NJe/tiHr2B6SIw+Yi/i+4ZP66?=
 =?us-ascii?Q?/2REWWqmq6Ggs0skv3gf9RS29sWlnE9D/DLmFVnSeWyEetOo5XceKRjUkgo4?=
 =?us-ascii?Q?NjqhoXmOR4Yokd8tAhinpHLZbN/RB9ZhzTlC3Btw08GdlDVqnH39EFfqYHE1?=
 =?us-ascii?Q?4W9PWV7E72SnnzwU42oLpCaN9LqXRf/tcfOzG4WXNCUwZfnolJQOPB/90aPc?=
 =?us-ascii?Q?9r7QkkGGF8OA6WETYsmgFQzBQ9qzO0Iy6TRA6ILY+9ndJHkUrdrIUuwoK7Jv?=
 =?us-ascii?Q?99PpdUCA1tUnTdJL5e5wd4DsYRnjjq9MHJRCDCM0TZcW/RYE2YhJeSmAMLH9?=
 =?us-ascii?Q?Ip9IKMS8Vre8uikDDC7YVFy5PMh8zF4PYZRtTUj5XtoRxHI0QKGyuMEBkPjd?=
 =?us-ascii?Q?Fk8iE6Lo06FHptGQG29mSqL/dJU/AfvVUKfCmnuddV5fXsxr3vOs0RcORNFr?=
 =?us-ascii?Q?pUD5qlSQz2Uk7NQn7NP03KHP4f9bgbs2kWBNbeRYsPitJ/lLPBOQNS3zAJtg?=
 =?us-ascii?Q?JvS9Nj2RlG+YoqJLzLiAe2zmYuWNpPGzRCb3ay2khvRKSCRsULK6myzXK/lV?=
 =?us-ascii?Q?n/2+FdYaIRbzWGmfWmgqhif9ju91ufJVZXofpfruxM3tjrQ/r/OMZfmglKjm?=
 =?us-ascii?Q?4NimJ3zjrp0pjPpFQJjpxXH4X7HPYmTMaN+OX9zwb8VvTod0IyVCH5EXgfnX?=
 =?us-ascii?Q?7HA52sTDAD1VgDzkCVS3ybmYNgS1VPGuO2aetHfsOz7oYHwuAvgJIwl5CuzT?=
 =?us-ascii?Q?1IlZWhlUrZHgsyLVjkoZV3EhwZkHjzaMBbnbVbljfWPoPPsvKh/gw1B+UuCW?=
 =?us-ascii?Q?LlNZImQfW3e6MeQ4CM0PRi9bm9FVhi/wDBhv3jwUgJeUm+a3PhzK8QpC89Ab?=
 =?us-ascii?Q?28GJtUa+NlcfcEwSwL1dPyK29MpEKvbtohqy7kid/h/LjWQjjStRzE9h7NqW?=
 =?us-ascii?Q?mkGkTlrnLvFNI36afJSHZ4BQbdhlo/9MM0Dub5Q4/6r/9c4StLbSlvsijh3Q?=
 =?us-ascii?Q?mNoQdXU+s0WgWmYo7t87zL7AH4C42PTKqJbvkzhMQmEC9YzCFWuO++7xtI1o?=
 =?us-ascii?Q?nBUlrC2R0dvSpT5D6fdiMH0B8LplqJ2UWdOYFHngphyjn3ZyPPg27aYmoVj2?=
 =?us-ascii?Q?sfIiNg/m1muAybJMkQ4c6UlQv01f+NkyoaCrUq3FGaDkBXxLHAU6/V4Sgt7J?=
 =?us-ascii?Q?DyrwRmeu/4GodfFMBK9E+yrnd4GqDjWOuhufS/qPI3YcnpeRvT0zdwczVlhN?=
 =?us-ascii?Q?nkTLBaKGWjKyLE5MwBLslcm2l17IRrmuiNpa8ZIdaLIT0s7i5fisc6UE7ybs?=
 =?us-ascii?Q?LQYGscX/jsS2m6rSdNg5QWr89nAebF13aAGXbw6DvoBv0Tm3gcELOddIEfKB?=
 =?us-ascii?Q?S3WkU7Nq/Ztww+McmrcSIiJbCzB28y5hKOs7qdtgGbpRYYYfgc7WAXqEMb36?=
 =?us-ascii?Q?T+2n7f2jl/1VsS0Tc2oueggVstGaphlfpPSWAy7gkxhZZiPh3wnIbU9E2NXr?=
 =?us-ascii?Q?/pxRLD6Xa1UrDy7eMLcTWlLnahQ3ppsH/vqRxcRmCKV4KqHePnYrI8yluo2S?=
 =?us-ascii?Q?wiJaYo8lRUnfDUf4N4YBSge63SK0R5bIvzAbvi6g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d479d45-3584-403a-f1d5-08dcb0a1530a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:11.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DnWIWYDWJlenPbDPBAhbTk8qmPKHBJnO7V7OXYI64T8/qRB39iPopQplfPnT/flVKrpmW+gF8EbnDlnAC2PYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This exposes the "select" method for Broadcast transports. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 client/player.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/client/player.c b/client/player.c
index 2480ed64b..cc30022e1 100644
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
+	{ "select",      "<transport> [transport1...]", cmd_select_transport,
+						"Select Transport",
+						transport_generator },
 	{} },
 };
 
-- 
2.40.1

