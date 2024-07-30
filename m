Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3ED198E70
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336839; cv=fail; b=VyLtX2C5syH+0F4nPgrPx99MM5cFSCaFEVClZi9YRj0IIH7iv64dAVZjPYm8roKmg8sUASNri35nH31qk4UO3nlAAhbVsyP1AsAEXIHinlKl+L4Jgf/enZnZNA+9/pVeV+lJMBgW24dBAZ918ZLR037DPdVSJW5OQts97eO1mn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336839; c=relaxed/simple;
	bh=KA4PKf58In4My50Y6lFWBf7aSxOxuJDAPxnvw+pVrZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjBo4yZz0at3I8a2TUdT/x3ImwoaJC0eFkBaMDleZz2656A2APRZXDD3nPjcKIBwu0wFjYuEsfTIaozCwXt6iWKLA3TOLM+117Cr8EpMfEspG34ubgxCMZw8j9/cGWdwLe/eAIHNVkB+p4oVzElF1jN/YzDEjoJ3lLSoMU+HoOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCLQ71jK; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCLQ71jK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnc25fL6gN34w5Kcq2GCJ967gLMNZQvxTDRhMtSN/0JwE7+enQaCHGZgBeVZzcm/lkJBRS3rNWgSXc5y63aVijFWWssc8jWyzMDwgU58QaAibjRVNvSu+GV/wI/rA0BUDtZ1HsU3U2Spq/V17V464awyMwDtdrjQ5zM4ed0RpctOe1dOazprwfHnggMweiHU9WlMA65eEPvwu3IC8QmsIvb2nAtozSCWZfycCsIhMOHuHdDYVFMrxXB1YC56rBEC+ybMNJLLMWkIf2ZzZ87BroKLRe40BPRxiydA37q6lH39qUeYGMLbkoRQmMcCCB45FSEDyvCbBXcx4imcP+ddSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2+0NRk3ITjvOslV6uWlnE/OODjnlBDSVl8Kn/XDU/E=;
 b=DenfZcFo4PXUTfBOlzMp+bQj6UAQayWnDNA2/fywF9E3EXFyaENkwvjiq3pOEEsRzG/VAGTHUVSMbRlFWD1tfCip2W0s6Qa7kh/OIdERW5bOLtYsDCTBOuZaNINwK51HYDHmVwQJ98cPD/g7P9Se8p0K+w1ErzvVGoBzTQHvTs063QpeACWe+/b7anb5hNH6F9Wnv8Wz6Gh/cjaQk5/0jGRQnQdJxH5IlTwcYH8jawUnPnmrHTwhWhAF1sp94FO7vTX0On19ue0Hr1gxYaS82E5ywQroabI4lvCEQ6hvt0P1fj7smMz7yegryxKECxzwjn1e6EsbQ7S379230JB29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2+0NRk3ITjvOslV6uWlnE/OODjnlBDSVl8Kn/XDU/E=;
 b=iCLQ71jKkjWzHRTFRbfuD0apUgWO91apTp5jQiWNX9OO/yh0cfATsHeV9/On5TEg4HzUDWlJhPNP8QCwL11gz9gEyjSNFM7SimRIofX5GUxmKEM475xdYwpyrX5QbnOakHthoFxs56xiB7aQ70um85rzGv6XylFaUBUXg+SZmm4qY7eS44QgbGLGTbeQiQZ0ZjFQeqOTDCH0vQxFzTPgabMHAPEYWMchvRG/bwxclht58AzrGOrzaV+g1NKKvC5FgNp108GeVtS1AN5i8rxee3nYA+CWj6it4CREIPSPrvxe4qswAcs3FAfwy3j0tutbRnSa0MRWMInIladPK6qs9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:52 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:51 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 4/8] client/player: Expose transport "select" method to the user
Date: Tue, 30 Jul 2024 13:53:09 +0300
Message-Id: <20240730105313.403238-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
References: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c9953d-365c-4aca-610f-08dcb085dd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IBqho5h8613yCJyKbRe/nvT6hOS1xJt6qxWMnxf7rZcfKUMNKtHge1OqW458?=
 =?us-ascii?Q?WidafeJ8uGgI6APSnSr33Ssz1cPRjut5KGCML5A1Oww0rndYq5RQykCbDOPY?=
 =?us-ascii?Q?CpTQ36CnioFZyLyqurQeUz2WGWU1okDG3lIA6bqLBwk14ElRcIvclZevXACL?=
 =?us-ascii?Q?9Ieg0l5CusqIQ7kp5tHl4XYJvD5aK955i/xpIA9+BSukKFtT/QWsDHcQa7K5?=
 =?us-ascii?Q?f7OcJbBr2iZ7XonoSDvIHJOqbmtZLIcyGYpBA2xHYmGiY75ANiJKMRWegZlA?=
 =?us-ascii?Q?ruVlEQPPjCCW7iRRRiC1wysoLXZbaWJ3iPHgNgeRU+JLu4IX0/fZSKoPlcYd?=
 =?us-ascii?Q?HplslgEjPA9zthj0NfbEiXXgEOkI5GSd6Tr1T09wnU6z7bpYKZzt0BjQDWAj?=
 =?us-ascii?Q?BQh9nQJJYtgO9SG+5Kher4pyw+XlhreVWN9J0eyZABvCV7a1mFSfC0tHbRYS?=
 =?us-ascii?Q?y4vCB7+lI6/zqdjoM3ntyPD6EliDwE7ttVtiFp0AqYLCjp52iRevlB1goQBs?=
 =?us-ascii?Q?l/MFIikgNTYwxbYmRwnqk6RWsbrpBgmK8jghnRkcKKd9Ek5gXgUPl3GWWCTK?=
 =?us-ascii?Q?LAf0jGGrxQHz62w7gocHygaFOu7nexUcALXRz+BfVNdL0ZeXENb+uLF5lYlv?=
 =?us-ascii?Q?XgqQgYYdsrNgB99BhC3UaliP5gRAlJjbjn1ADe65KEV4Lx2gKNpDeeJdhHB/?=
 =?us-ascii?Q?tj4ReTJDpRv4qYeqBeOTwvJSt00B393Tdx2JI6+8aqQ22Uu8h89mVP2Gtf7R?=
 =?us-ascii?Q?E1AaGBPCwkRIzPRKkxdWM7tNbyYfFNDH31EKi+TzxRu3itve7ig2G/vieLiF?=
 =?us-ascii?Q?W1R1jX6zIawAZ9qJYUtZuL7nJ5LOt3afA/76krdaGW8pREPEnBfFd8IF44yC?=
 =?us-ascii?Q?SHsjfXBd/YORfBNgjKQ8ZHwpN6qfEZ+AY3rJvUmBjXUYJi4tvfkRAGs5GvSJ?=
 =?us-ascii?Q?CiSSAa+1swL0D4tU8m2MF9LqstuULm3LK2kQcjzZ6x/syH2djp79L+zxCssM?=
 =?us-ascii?Q?c7PqgC4tTTBXjuPQ8sQpHORa/JGV/acHASp1mwgQQ2LM2e8RZ4z8oQOdBJft?=
 =?us-ascii?Q?cJAJu8dtnW+VahN5wgfOtSpDZ44Er+NI6r0GoV9U3ebqSRnNx5ejMOD2dKwm?=
 =?us-ascii?Q?28VU9VKbIDGYk9/9zVlSXMHSW7VLgpxwQU4eCvMyXvxpIhk6SVKuYqnLMRgt?=
 =?us-ascii?Q?ol9Hw837SznNZhlrNbFUEs+Ep8M2Ni6pxVwOo5GsBcXxYk0JOs7+3axJdIbk?=
 =?us-ascii?Q?KvGBx0Oln9AhOiBWbFhmE8yyXk44P4zMiPf6IdaQ0TLNNtSUW0RUikFvJLfF?=
 =?us-ascii?Q?t8Mr6t7G/S1URw6vDpgPVH9dudYBF+RfSgk8mLk5MFjOxzdwMLcutUyOxVKr?=
 =?us-ascii?Q?pp4BccI4uWHzCR05A8T13gZ9Fh/tJ9wmzsKZ9a6flU1/Ciyqyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/ku4wYZOfjtW69HshRXxWMhvXxdZ1m89pUPTMCVr/SSm9Bt2GepOzvHDFPq?=
 =?us-ascii?Q?LwqaGJRJQ/hDA9njogS4tEyiw1KjHWjvNHAdccOHV8zKFWt/2sTGwB3CWq4h?=
 =?us-ascii?Q?KUYFA5IPDNEQUJFRgKgc7uKDlUggWqWd/e32HkTROqfZB7b23m/MBug5XY4F?=
 =?us-ascii?Q?+wljg9c7pQcJMxAMqjeAC5uDSkX8xwm2lo3i0lCapK90qtTuAfKUMwpoE2uw?=
 =?us-ascii?Q?7TtS4PiKZ1Mwr1t6PERZ9CmCPI7XHDYIqr5jUGPlMM6vpomsd3kLlZSJC/XY?=
 =?us-ascii?Q?JJf1Ky7GdwpHHSmtLkonwS7yaB5qeOJ8oD5yPT8QWnSeMcX4NUFItUZpmR49?=
 =?us-ascii?Q?Q4DMiNFWVvNiXXwClD2kl+E4jNbLaLp1CbyXhfXPZQ9XsJjgFisuPDbbjwC4?=
 =?us-ascii?Q?CpfdmAj2dcneVedIk2okxoIeWhm90HAn/9CmvWySECJkq1rnF7Z8nc+xxz9/?=
 =?us-ascii?Q?uRb0zPMpc+nU25gPQD0QeIvczvjGInKPNsORCu0B/D22mKDRNurQRrrv9ifg?=
 =?us-ascii?Q?HoZaMiq+qY3vBvR7h6BBrys1GVtWUcdKKoXiddtF9dYZ3AbFioJG9y1fDoWE?=
 =?us-ascii?Q?xoC/SOVQ9I9Se/LtMuaDNtwU+I2D0mQCBL0LULmxXGYYYSCq6o/ZUBv5EJw9?=
 =?us-ascii?Q?63je6M7mypXws2/J+D2DiJpsHYrMy8ACc6f7v1MyFPLOsyLC0uWUNDZfdoNW?=
 =?us-ascii?Q?kzvlGV/J68SrWaUxucC/yxYS1qr0RdhN9eziOXu7AlamBwTMTcQ3rM9Y4x5l?=
 =?us-ascii?Q?qOlQomLG7JKR/Kge6TRV7FC5EAQRdde6DZ1fNtyfhryMFre9QvyKwnIjTIlP?=
 =?us-ascii?Q?KvuEKIqj8RhVo52HhYsztWCIDp6OAxvbW5bTi6c0JOwiIkXWcpuN2pWQ1AtF?=
 =?us-ascii?Q?85SCbPEK1LfWc55Ha+M8Ti/hZNsNa2noo4S8QJeto5MvDtCH/q0j7ODFeWi+?=
 =?us-ascii?Q?Sty+PtweITbGxspI6ccgt+fuXgVqFDl4w5SG0AO+Axk+EbKfnzEOpAkzlaOQ?=
 =?us-ascii?Q?nCwTOTCq7Zxws7cjJlcK7hpTv8njWe+k3O9NVcrhE5TInuJ+TuY9fWv4Xfo6?=
 =?us-ascii?Q?ybVlMkdtEjFDzduyMJx+hbSw3gUUCorDUG4WjaExWAxRPTqF/I8NBSku66ZO?=
 =?us-ascii?Q?Yl/UR6kTZKk0oRXnVyjixtg9PM0neYj9Al26H3BkoqbEA5ShxiGw0N633ruf?=
 =?us-ascii?Q?74cazkfYSkQla6yg9+4+q6W8b7PnLd/4+6DjzW2UTt1vJT/CGxh+Mck/Oi6t?=
 =?us-ascii?Q?SnDlnihu6vSYDxCurYvEJwqniB9pQ7jikVH7E3DOMrpxrnMy4WLzzAeOe14l?=
 =?us-ascii?Q?IG7LgOZc5xLIVC5WuiOme+vfYaLnlRvvf7Mxb8inN5vKD3JGs9qgzvDqphmY?=
 =?us-ascii?Q?NPXUxJa3wR4Fb+8eJ4Uh/fYUuwbw7SQ0F/U6itk6C58zNyqn7q3gHlO0y9iL?=
 =?us-ascii?Q?oWswflUe6BUb6XBfD32jWWnnWqpJHEsHzxn7MrOODBDQBpWTv5l6e750+zNi?=
 =?us-ascii?Q?c5S5jkOiMk4MxwM/AITMFgNweL/2ETshSapZyU3kWgqeJL0aKCo+nk2/4OqX?=
 =?us-ascii?Q?GYCTc5n7alVp+15jv1Me+HjhK334gdVl6FlY4tAk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c9953d-365c-4aca-610f-08dcb085dd98
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:37.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15KS0ItlzS0Wp1tkZk5esXTRNnfQU1kc3mMSszmrH+w9EBxapYQsuPcvL4tn+oefYBtfY+K0vpOyg0rdANyCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

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

