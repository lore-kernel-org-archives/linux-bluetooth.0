Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB761FDF
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406663; cv=fail; b=l/QukEuvrehEwKYAQabpJztZZ29ddyO1xnqxBEuTmqlAjXMo5V041AgmuiNTE8QMzj+ViQRa740sFsv4asfBnbjURSGM8g0UaLRsx4ejWO3JuGLZxSteN2kO5c5DkgUclBbiTSZkoo6Nb3sCds/5IvxPxbX2g9D1K8qe8G9ZIfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406663; c=relaxed/simple;
	bh=rNIo5OWQs61PsCa3zLW8V+f7OfNHAt0kvpg5D+nabvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzaLbHQDACLk95apd/PamMDtXk7PpYovzW/ZqlA1GzYRkFCo+LqhiG4vW/ymGGsg89CSai5YZeVAQg252uTj3H0SyusXpsK7hXjfGgV4IsMwXI4xBSx98cJfU0WxNDIezB37q4yJlwxVy3p4pZO4K0FmBZbXeJ3lFUg8LyLmS6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZV4DY7f; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZV4DY7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrPYmUDSZ5jFcVU07QRRHCmjnQ6jEvfTAE/dtoAYSDPGxEwgA1KhKZVUeSWObHEYLA3md2kflfvTXkaSLtH+gKzt0ebTpCN0tBTQ0hI3ZmzpfiGST8/51MFH2Ob/FUfZtk6JHEDWRmf6FtxQiYOiv7nUsQl9QC2gYmpPTS2ugqI24SOM3FCjPFOj2WAmJdy6OW+pwKlryoYCmZ9qPDlIrFMN4/9JsIKZDnMT6SwNSgVyCpOFw9bccZtrrVV7QelQ6cWYvSQVdpL1HsB1+/Rz6tf0bz3Z+NJhOaca8ZMPCxq6UGmaJyt0lyHH3sBimZCIhlJhP9qW9pH5yqds1IBrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+giHDWoikkt2JNGPn7WQM9DpPHTwYMiK7KmFjbxiQM=;
 b=Ku1uH9cjtjvsRJuDJNhti1t3QzgqtcwzI8x4LR4V0lNNzLnIzLzijUIjLQnryWeSAT/HFnIDGJUxw7kzGMlw6F2OnNtaQNU+KsyxlfIAIDLhC5AKbcogfTC6HKrw8c302Zh5YdKIZB3ouBFGxnro0RYrvq/hTfFCY3JLWmum1AN+Udv6kHbpYE3AyhXdX7rRgGuThgusl18OdDOOG/BadNMmaKK94c1lH5I2vYpDluf/SVl+UuWqwR6IdGlKhLlMbD6FTpWSLPCj9sr+3J6/OyeVMp0H4MsYBg/gO9Z4WVw29+5VBe+IPnhvkmy0foHGrzxgjdErQWSX/bQ1CcQIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+giHDWoikkt2JNGPn7WQM9DpPHTwYMiK7KmFjbxiQM=;
 b=hZV4DY7frcmWSbTcsHrU6rpqRV7cfOLgD3Y1miICcwzBmnnwe0lI52fOZuuW0EUzJVfdoyEl4ksRzJ0EB6HEvrIEAFN9Ee7A85PjyJuHWp0o860gNMwXxyCfbrtlLZirnZuO0CZByGYdj0Mi5LlSTJ8Ng1Eb7Y5SZLuj4WZVz1rDg0G3vyX3jXfhrLBab82Wa0PZT8UgRpf5BLgvmDrynjlmzGWsgu07SaRhAvu6i2b2HXk3SYTfUv/j7a2gVK4KNWogvsxwq1j/TBIufUMwxtKxuvhqaJgRGesX7TCt53f7E4gXMXh5XUH5P4IP7u9spSPWpgTmoqaTrvUFefZw9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:37 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:37 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 4/8] client/player: Expose transport 'Select' method to the user
Date: Wed, 31 Jul 2024 09:17:09 +0300
Message-Id: <20240731061713.435586-5-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5cb3b976-c2af-4504-ef7d-08dcb128799b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTpvnRSVdSawUBXqebm55nwY0TaFbTsZpW9QTpvIMGRyzGHsS/alqEdgSYJI?=
 =?us-ascii?Q?pCmElDlYeYWVD9qc4aELnsLpkJoEeqM/YnV20mskGPsFIOu7jda4RvI+dZGe?=
 =?us-ascii?Q?FzpaGr83kk9X+DEsi73wG2qfbkNrvq6y3g5lnfzMsV47dIsNStpO0ehSadcb?=
 =?us-ascii?Q?2qwyQkqzMTLhu3X3vGnWRm2fWP3eeT00NLhfEE2ZBEjDGUxqlktHJ4dlV1Tv?=
 =?us-ascii?Q?m5wTPIUj8SsChEi/WVQ+zSB5UKGiSLa/yUWusYRKK4iXHW3uooGQRqzdvKJi?=
 =?us-ascii?Q?HxkLERJlPCSIm/SMPt0euJAUwIsaO5bFHVQcsACR4ySj3nq+dRUk/K8wClhD?=
 =?us-ascii?Q?PAhXUo0xsMUBQDauI/lG28/LBoJmSmhyqrf3cO1DL2o2Ll5jimuxCw4gp/pv?=
 =?us-ascii?Q?XRGvh1ycE2MeKcwMvv35lyHdg8NgTX49qkDPnf50vmaKbYFJ6cs//u9WXpG9?=
 =?us-ascii?Q?TM/TNqpMWEaq7BfKQ7SjdxZ98pu0yOfAIoam4OUIn+RyhuGYfjl07M9yI5Bf?=
 =?us-ascii?Q?IISIbOkcu/RKZCP01Ut9x2xqHs4U5e7G8Cz++lOkAcyOc5xsLqF4VMLqFLLd?=
 =?us-ascii?Q?GsKBsIhfKRcntNaBkxEa3k4vCdk6QvNRdoMP2JKnhBiCh6TZ611Sbz0xtWDT?=
 =?us-ascii?Q?Y6rtvuZahKyXOWOU+aSyyZobMrAo6FvSW+3Inh5mlW5sLCCQjb8QlP8c6EtQ?=
 =?us-ascii?Q?O1nN3KGdOdYD5M41qopCG/Jiyzr2Pa3HIrlibm265xVnmxK9C5H0nGWKtgAF?=
 =?us-ascii?Q?4e6jiYNtS+LK4ON4wslQkErh2W3M0+FhtkjJB8moHLJiWw2GKHf0VXGb6+CU?=
 =?us-ascii?Q?kZbAJZfQQ6OFnRHkUTl8FkoLDD6ARK7Pnznwt130mU6nHgFpTPE5zpgTdI0r?=
 =?us-ascii?Q?YHAhULl8phTRzbpmbc1y69p4ugee1Fxgmh4isIljpBC1jS6ukFJbGabqauk0?=
 =?us-ascii?Q?xl3ZUrkmM6fZzmhb7zINNwfFVVTy7v+3d45iNxCC0kte8mYxsfvFfRCrTca+?=
 =?us-ascii?Q?C0poo5zQ3q+0kobXSDXYRwkpqHdgIPZIFnBFkGdHO0RGy13tRZqMsmD/hTO1?=
 =?us-ascii?Q?c0eUBkqyD+Emd6c4gieN6/tOGMlGEYBcMP/uej8QCnGObVVuidEEqn8b4C/e?=
 =?us-ascii?Q?2tRIDJTAcc9XzXcaqmbUhpo6ssM0mY1ysuTyC9VxxziPLXhffMHsA5CvSEwP?=
 =?us-ascii?Q?8SijfaIMxU13jH0dzHno9IXI7XEYALwHJerZlmYNs6/6Uzl2zi/c7cRlTYrT?=
 =?us-ascii?Q?biC3yXuzMCdBHLIcGmc56U9WPjFc48Vsoic6Ypkj47RMFItt8h8CKwCLsEw7?=
 =?us-ascii?Q?hmwrsSY2l9VvpAX2CIr0V//7u+mAaFhCtcaoE2BQE0I7zeiLvZk8XBHlvafH?=
 =?us-ascii?Q?wUm3Jog/i48JB+dAbXWKpcVkMuEzwsiuSkFSm7gTSJzXc8ufMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yni0cdlbjCe2S0XH3dzzez8Ow23lREglaxRi0wQNsmubQk1EY6eIeLMNqu7k?=
 =?us-ascii?Q?j0HKY0eAlbUfsd5R3h8Upix8ll0hDJT24QLtS/6dpxcIREymFw+sHYhbT9+E?=
 =?us-ascii?Q?4cK4cu1NBI5mH/ZwowF4B37jLp4F5D9XaPKD4xTUlgZqIzorh0SvSErQN17J?=
 =?us-ascii?Q?n5GB3Go5lP1wGY7I3l+X4c06AGJQWwtZZYKZefXxqnVbifXHeSC6rzr8Ib3w?=
 =?us-ascii?Q?6TtE9BfBJrOU8ibfgCxvd22KSb+nuMMlvrb28qO5EfZlgj7YhxQnVibBWuEy?=
 =?us-ascii?Q?LgxIQlG+9yiwftkWfumIeb1kHv2P8YBFZrkcFlQxFHF3QWyVWOAehot0PeHm?=
 =?us-ascii?Q?Mb157plBIdtNPnv/apB368yyY3QCkJbSfpB+Dg1zMBIetkzXXy89yYiUp+Un?=
 =?us-ascii?Q?tmDuuygaEmKaBDsye1FEx5uyN+1A4mei/hVwkMmUjeHSeDWlO8C2yrH8LZw/?=
 =?us-ascii?Q?QMS6YOVvoM4WKsLZlWO8z8w8w1hcvXGE6nxRXv0Tp0T0ZWr0TR6Xd70pHqft?=
 =?us-ascii?Q?kRkxk26HKbdSOT5NrZVMfCF5+Stbm/bsAanpUyHQpBXv7A7GMQtF2ks3dkD8?=
 =?us-ascii?Q?groSATRRERx3T6R+ChITze7Ws03Xo+r1Ps0HkRkMpQ3YnMy0lG0RoXK9uw7+?=
 =?us-ascii?Q?DUTDh5oljz5kqpOvy9ogQtJD5S42sRqJphUb2X5Na+gWev0KjxKPgJx/eJcK?=
 =?us-ascii?Q?TcApSMumv9Yw8RCBFafqR8tX5Egr8/SS4ctmZbuzsNIWrZXIhQ0QePUj8wOT?=
 =?us-ascii?Q?QRUgVP8vhZsXbipMigqzoI6HQNkVHYciFpoDAXMhy2S3PnMImEZKJ4y9MAAY?=
 =?us-ascii?Q?VYDT5M6UIZAtUB+epdGQ499bOQT0rcD9BFfMniv1PXqSn9Rfxtjv70leQ9JW?=
 =?us-ascii?Q?gipfhssMRz4r1rrXAGRM2W5j2mYjTEEK0ueyOHw8guPOBsEHYqhMRk+xOlFm?=
 =?us-ascii?Q?rnR5itRm/AuRLPl2iPf8i35Pnos8o/yUd8nn5mChsQCI3KQ1aXnhIwIETSpx?=
 =?us-ascii?Q?szqyqSFPmJ0Uz3+/x6g8k1WHiMCzZAJItPh8gSLGXJQEFnOUyA1JvwZi/Vkt?=
 =?us-ascii?Q?IvnN2bj1eXpJmBARLuh5nOcUEOqKjbz6v2mZU+YZMQVSPDVrUnQjB62YIAht?=
 =?us-ascii?Q?MfBPpBXoxf78QPK2bbrWDugFEbRML6Sa8vT/ulrIVVj8DWKGyHCA3OAKoSE4?=
 =?us-ascii?Q?D1QcRy11069zHZ5AaPCCYHAWSUNWTJq5X/R6m3r76yQ4iWALxDFNSK1x3uny?=
 =?us-ascii?Q?eN8WfLaAfpFxtG6N7W35Xgm8939uQyQHm+jNwh1Z69eoFgAS49mXGsRilrva?=
 =?us-ascii?Q?d9Ea3TrJM2xQusqP+B3G8XOFbXr+rd8eLaYYJFT9hxaD86OoqBfISIm7RUkj?=
 =?us-ascii?Q?3dg+WVyPNxoXJ/alMQAl/OD7imiOFAykzUKmKCck7mD159TQNOF1amzEkuR1?=
 =?us-ascii?Q?2A2qf7CJKbq8ERDknMOyYMqTwGwM7KJjMy/+UnJQcQcB7AsUBjrnuEM36wUA?=
 =?us-ascii?Q?4v8FoDMHaNzyfJp66uqpUAWXCsKLt2DFeu0tJeb8o9rnERn2JoQcIDdS6ebf?=
 =?us-ascii?Q?jshlazDqz0SOFoxjbvjHK5EU9r5VuUMmzt7q/j2N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb3b976-c2af-4504-ef7d-08dcb128799b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:37.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEWAZywebOMMiCPXX6WdzRiXFwrh+Hxrrno7yK/DyPiOXqSOh0T8fDmMFxGy/IPAb3taZPb2DscEZlUPFWDbAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This exposes the 'Select' method for Broadcast transports. This
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

