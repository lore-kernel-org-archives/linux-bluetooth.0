Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9884D0F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599247; cv=fail; b=cbYAuwjiTgY5n3FtnFeYfnQWohN9rHOnZE9Z5wyy/jQfPSnbff5bhuqabWNK1tqg2rV5jfYLCLjVU6LaCW3dAYbUdflzNM2nctTUb9wZ5VxJT5acmSZY90+rEL7bc8QO+PlC1T5Yl8j5Coo3CIG3YySRdZoAbGaybJWRplJYf34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599247; c=relaxed/simple;
	bh=YjvdzgaXzpBlUl2V4rpuOI5M8l0HgE/+uLbtDLJwpvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9n4ZWhYHRzLskkX00WwAaKVy/hvoSivQ/fbAI5z3ekh7t9PtPsSd+p+nPlHIFGO0SiRxrshyPu+O6kLuHkYNRaZ6VCnGH0QmSetzbm97rJK49Gp0fnE24EbS6tPddslLhjlZCIBzv/99SMxRWsPrJ8u+THjF+C+nZoem6tvnH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oiZJZycI; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oiZJZycI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXxDyMBQ4oj4DxKEdF5TAxX+MCyjVbbxJ5Ox4yPrUL0A/dQvAxn3yAc/xD1UyoP03e8tg7rGLnrlE+/ZuwohblSeTUpQomKu3JVFZL6NRcg6/vpATnhII4YI3J71JlH41K9MrJBlP7N0lkBT8Z+xvN/4bZXutZyFIytIe6N5n6ObrnoQNkZVVb0nbo8q9TAeu0wRV99KdFTtQj6N9Bkbdcbzk/YifVJNkAPoD3WUJJWlwpppIxai9jx4v2SJdF12ZcfbHkqJ8VRWF+zCc/L/J4/zcuUx6fXJws2MD7TzXb0YmGzHC9xUuKFRFmnHZcAN/G3gbcdp7hrObjkFYes/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33LM9qldiF0tWdBO559Y+C1iVarkxZwsDkQ76HAThJ8=;
 b=Ph43weH9RoazTfKqnUBRmnhtcnZEimMVt4gQBI5bprj+9MpM5mkBZmfDgzI3xMs21IRARa+GFWOWjYdmMurqrllubQpeYaS31KFTcCBcnqPTX3JAl3rq+VQ1jQeCtkIfAED10+YolOTRiRQkR53GyvIr4I7UwykWadJc6rXvwuPDr+QuBd6p4elRqXYu0MTkMJF4kKWlKAebB2aqTuk5vVQFhDMA6+lId/whOvS/SxaIu2ntNS8/K+Plu8oQdletrWjBpTecphSjUf6VnBUrISHu+SxSBQjlitUBifej7CHWd2UuLNTp0b8wpbU51gWV3JL51T+U1kbP0QAHJ1lQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33LM9qldiF0tWdBO559Y+C1iVarkxZwsDkQ76HAThJ8=;
 b=oiZJZycI8cCrrDD5yWO2V8FnuQBQrQV6HOTx962P8UF9zev9lJ/u19F5yV9/asuV9411kVkhM14H98ayulpe9yjGC3wNwzSfIi9Hf4ZL+AZ1xa7g6yqgQVaumwVUffIbZYKi32MRPTxYG/4h4MbqGjTf+S+MnHVsFkejgBaP1mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB8864.eurprd04.prod.outlook.com (2603:10a6:102:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:14:03 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:14:03 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 2/3] client/player: Expose transport "select" method to the user
Date: Wed, 10 Jul 2024 11:13:37 +0300
Message-Id: <20240710081338.17262-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: fce11c67-12e6-4364-9585-08dca0b842dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtZ9r/S5GfFu5SCp8GuIwmmXqsw+fBlE7SETYRi1oJ15qNlu9fLEptPxOU8Q?=
 =?us-ascii?Q?DX+G1zN2GvycDMUESc2c+h18ILbDgqPX5UFoxaZMmypYfEc5EyzfOyHSg/e4?=
 =?us-ascii?Q?LHKMneEy8RLErDgOQ2P3tAxIX0603WR30//EViJcpHKyGdFFXcGSmKO3UHhH?=
 =?us-ascii?Q?Ts02lWlK1se3Cvl/ExV0XGE2DAhQbm7E3fywnoo4y0+6h/JGkQ7bhJiya5kt?=
 =?us-ascii?Q?euVtWCOWM2Mzcu6HUQfLXj2EciaSMYy9NyEW/bevHGTlW2HoeWGI/WWkLejR?=
 =?us-ascii?Q?uEb7oSqdVSof4odi46r72UyY3VYFi8sYDTMtTT4OhqMFZ+jbGIEW7dzOygCl?=
 =?us-ascii?Q?m0KQZ6dTDQmfaYZ+Wz+sZJ/LqVo1hDLsgTW4tO7uVDfpq5Ay3KxI7SBORm+l?=
 =?us-ascii?Q?ocO0B4lhBb/XcPnO0Hew6XszcC1xrvCONdrjFLD3xLfe/Cs3FUuzkypOB58B?=
 =?us-ascii?Q?euDsp9IfK0d/ySqdf6PDCk+H/L/DSy8R2kDRNqWY+95+nZUUE7+wjwZC3LkE?=
 =?us-ascii?Q?9QZTA67eAW5vCtwcVtzX4D2PIPTewF6MBq1ge/at5RelXo+PXyDLQw//Oe8e?=
 =?us-ascii?Q?iXuAhnadG7j2aji/tz6+27M/gH7Xg66gbk3SOqFjssw0/Pmndk3Le7LUlBiv?=
 =?us-ascii?Q?nqeubuGy4KgP8l3Kgh6l6KiTgdSS6mCxNR63EuAePFopdMmxGx0bohQLwGHv?=
 =?us-ascii?Q?BMib9jfwUya8CLFqR6RQMAdlE1VGjxITb97xD/kBlKVmWso7LchXTlglYelD?=
 =?us-ascii?Q?N4rJg2h8bAlHe9pCDrEtZJCV5L6uLAQzZnxD10vVPzrbAxflkCyvnSGYnnN4?=
 =?us-ascii?Q?dwYFCsBhDh6Mke2OB3HtxUDQyQUjO8p5JCHIW+heCdZNebOSpRrzpml2YVD7?=
 =?us-ascii?Q?pIiFCjFTbbBZi8I45lfU6IMnaoh4gn9LrfJaCikwH4Si3jgwsw6DHAidm360?=
 =?us-ascii?Q?sYJfQ4VI5RP9uUTS4NnxZHjAdd81Z6vMX0Kk0zZ9alCh5d4JCRl+moM5VFYN?=
 =?us-ascii?Q?lMXFVddymSh0amEUoT5tPBoQs+pVRwzwzQUqPg6FM+A+pNnfXRIHTMMDg5+Y?=
 =?us-ascii?Q?/D2yf164C72TyUOE3RgRYNK0Fds3RWjmX/bNIcLWQxQ6e1nMIrrdYz7WDBj4?=
 =?us-ascii?Q?fZuNyXlneZb675teuGMV+GI4K3ckZ5gfJUccz23juUQZk+a+EnZtfvd52zMX?=
 =?us-ascii?Q?D7BkiHOax8vtzBWnS9VNUe7kF21LgrqEPb3awSMbne+Lv4px1/GQf9v1/je0?=
 =?us-ascii?Q?8QBdxw0XrlXZraEVhBhizeqol66WBztHuSVcSE990399ttLwVhdWUzZ1iFMK?=
 =?us-ascii?Q?Q0Egh3RpOIzESP8YMLJAz/Sm0zdWxHSaHAWQqrFnvlnSLfpJlohF7iMMxH75?=
 =?us-ascii?Q?j7UwsslHXj8OFnS0sgckCh+uE/EIgT4R0n8dt84fbFCTPNj2qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrLWmtwPsNSQQbyQEn2HT5P5BIRqzISprPLIMFnZI3E8qs35ZqFy0JhKL/1q?=
 =?us-ascii?Q?Z5dxW8LJvt50Ih/6jHLdKzOeuF2MjydklmxbU52iIbzyUJaWSbV+nFzd5H62?=
 =?us-ascii?Q?lNY5MN6+sBuoknWNGiffgCC7+y8q7y46I7hFxHnGqUcWgPLmMPAYhUsNyBVG?=
 =?us-ascii?Q?8v0GbbV3zhVD7kKVRiDF+thmxLq6o+UIbdh9sav+B0OX8+3mujK7DdW9a45i?=
 =?us-ascii?Q?KR6A1vW28AAUxSZcbt/1TuiT5qtUkcyfGRSK1BX/8gKcLdWx21EaBzhdCobd?=
 =?us-ascii?Q?mJIsbpRyGfeAz9xLLzUbAbqnqNUpnesSEJOHPKhqRYAQQoViEkiBxGNlU0xN?=
 =?us-ascii?Q?6dNdsKaxsF2H/rH1rQ3rhrbDAtEJDqmAtpQv0VbZlqf4sZyoRYZhMlKIywEl?=
 =?us-ascii?Q?Ubw3dVsj58dl7dD9Mo0A1BzLVuCSQ9DNBnY7hceL+XGVEc3GNKdFCsWIGejk?=
 =?us-ascii?Q?NwgPnixKJC6xAkvgYID6yoZXd58vuoN6OxiIRbI5wSgRH8BEzv45Qrefuj4o?=
 =?us-ascii?Q?RxY1MKMGUtaDuD43maM97LGxlsi4lG4marsyw+ESaoeQVWR7pKqTmqS+K01Y?=
 =?us-ascii?Q?mSpP9YLbgj26uaGKYlbpLaHV2ObpY0T2CYPRBJGm9JFjeloDXCev1d8m1JyM?=
 =?us-ascii?Q?w/ZgdGvo/Swn5gNztlkpJwv7qplzfqnepNlK8FLwbpbwBhc7/nuxdiVCLXEF?=
 =?us-ascii?Q?yihu2fkb0qemNR7nvvCjlXwu+wshhFMn/2s8APTyKkQ2mTycDkVQZPEdq3vo?=
 =?us-ascii?Q?CkiImqD8h2iAXdVl0fv29B6Wlrq5d5kA/d8E2aF2PjuIJjz17Nm6o/QDyqGX?=
 =?us-ascii?Q?7iKraiT1TNVsk10Tvqap6YpEl/BVg+lZ4rRILfz8X29AXd1whnvy89QGYoiN?=
 =?us-ascii?Q?Uzd2fPOGdVMcZ/4NmHHiXq0iBsoVrEKYoMmg/DcR8oy9LcT4S7NghOZ7Un98?=
 =?us-ascii?Q?Ua/Q+DMAdv4MB2c6mNFbvA2YIBbxv6S20flUFk8Hr9e39x8exuDzVehriSr8?=
 =?us-ascii?Q?RRTl6QOfKuU9OO7a5yRjDwg6KIPMDANv5OIPHFP9WghN9amGdkXEz1Yfoxyq?=
 =?us-ascii?Q?F9xsp4MdXn4CfqN5Ili2HulE/IkzVDcpnZ2RngJmK5CCCqypwTeOd+xaPS7n?=
 =?us-ascii?Q?WdW6cHstyqasOWAsCxh0RDnlsS7gyMEZS/cq5WvOB55rDUZdkgsvgDhymHzL?=
 =?us-ascii?Q?ROTgtzpDrCmJwPufmclUUtPqQvCriwjjpMWmx6dImjI2Jo19ky/oClZfO93S?=
 =?us-ascii?Q?QWCJ00ldW+/zGMk7w0hY8wMmLdQTrrYfiO0ULs5svdgygUBPToM+qWdJ/jPe?=
 =?us-ascii?Q?v+ga+n2IVige2xD0puvTQSacNLX5CID7PmB8CLnWrRn84xhG7fikkyFwvHnm?=
 =?us-ascii?Q?noDofXGdE2WF5SZkWoR8BjqgLj2Cz9l3UZAvOZf14gnKRpcUgZyI95Xo8uka?=
 =?us-ascii?Q?8pwaVe1tuAO9kAjLCNzEVlGgHFsaRhGizP6szzMMw0m5QnNa5NLbpih6gbzf?=
 =?us-ascii?Q?x+Bov0PNnRN8B0as7nkvBFrv2W9xKm4zMSXR9c8zwJ1W0BF0sSsAU1cce4G1?=
 =?us-ascii?Q?faAa9cbJ4MyZoMA5S6hl6fk5ZUGE2+cJrHO8NRlW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce11c67-12e6-4364-9585-08dca0b842dd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:14:03.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCsYMd2POs+z+5J6WVI4Qp0tZzOxTjqnV03zDvz7jOPpiVuT1tXG1/inG20XXqZJKcFfuUWYwdYsUulHKp7bCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8864

This exposes the "select" method for Broadcast transports. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is pending.
---
 client/player.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/client/player.c b/client/player.c
index 0d031e4b0..58805c26a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4628,6 +4628,23 @@ static void acquire_reply(DBusMessage *message, void *user_data)
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
@@ -4849,6 +4866,38 @@ static void cmd_acquire_transport(int argc, char *argv[])
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
@@ -5276,6 +5325,9 @@ static const struct bt_shell_menu transport_menu = {
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

