Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E3199258
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908781; cv=fail; b=IRH3pUWOmFg8gx7UCSdNh8yeEo7fpbaLWjOl3xcCxCrtOYWC0/6X4iLlTIJBfli4CviOSn/KrSu++eQy+MgXTSfvcrfe5omW4gKT5zs7CQYh2P+MP1jfrjcm8S/D8o7PDZWsF1IkyVehNkVcVMPKaLYKj6mequB/osj3JKhoPiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908781; c=relaxed/simple;
	bh=CmmC6iFRScey7GGcg8bk+zTx0yNf3xCzVlu0pe4Gbgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOTOsmVBzN/lWhDcCnkvKopC+Dseygx4/NBd3Fygk3GzDdeHybatX7OxfMXxiwA8BQ8P86AT8Jw/38u+an9HtDKhiHKwcRW2HK5bLs5VFPYG8aKGc2JXEI+1KC9H3xpuHv+sEAgmTm6o00Dts54IAw79ux7gLBjw043HUzu03L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MRzjD7se; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MRzjD7se"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/Pa/JBXpm72VWIeQBEdlfHcm20Vmcr/jZxakXTzeBnjRhzgU/5xwlZwvT7usXQDWJX3/KXTX/IaGVYmPZ7P1BrJ1mPa+SoD1sJCPKizisLzLdvof4RdopBE9FEKlp0/2Xuwg6+KGG3p7NdKN7lWKdsyqrYVdv0rsBN9IpU4ZAbYA8KKBAIA1nYv+5SNw45uZp4wCEC0jpj5/a35RqUAV7m6BqEFjod1xNslt/Cvrf6kFQQZCUc9/2ILTTf3tewqEZMfMlaH8tbha3si16xCJseJvJzmzll5DgyQ93hcY8HXS53sDwrsu9/72ht2jgh6MFSq6fqhp/xNyle4u7L9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAJw/dRco6+vXcKltrgyg5zGhdHLB5te2nNGHf+j2sE=;
 b=btwj88z/oX+GOFL6bBbHxqo88i8s6ryGEOMU5cbPX5WenjB9sbvpAwrParOOhGaP+vMncW6mriYP8Ibod72XbJXOifsU74lRSWNCE2DOna7ow6w+1MLE7q+XueVX+wisgNwXHUuN1C9oXyJuUXxZSSvyxZWKrvPuy1s18XRUDDMU6fmk5dVyHfC95WFv3chpxzUPvy7rAVky/S34DEB368aqsm5HTXtaE3798LyGCFbC/0V9ldlgx7p+WEqY5jIJctkfny19iWRDWjvF3XvaHhke6umtKCU3V3iu6ymPq0HTTLARZVnzh8M2Wuk46V59JbuaAqhV6/58kG3cuPqeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAJw/dRco6+vXcKltrgyg5zGhdHLB5te2nNGHf+j2sE=;
 b=MRzjD7senWtDp7OCeLtH2mpw/T5U3U9GQJ9ZCTOC4tSQrIPk1swpb2ATk8c4Ga+VlmlA4ubHNIpo6EbfU7G/qgU139Duv4FjYxxYy4Ukpnv2xhiFXMXambOedjx8pTZxZyyM8O7MDVUudwCpunOp7Hg4zdplgmXRTgmZt7mA0+8ezbBdPho0I5M2HquH2RgncGOhpONDbRyl3IRSHQu/iyOmjfWXWR2K/bLWQzznrbz3tXYWmryHeMX72/mPnxVZIeL9haDSbjc6Mc8TncnWdUrlxtl5VIYPtDHLnFey5Io9Xm0RvgqQgw7KAbciyoVaWwLJg3LsPtcO61fBWkOo5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 11:59:36 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:36 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 4/5] client/player: Expose transport "select" method to the user
Date: Thu, 25 Jul 2024 14:58:53 +0300
Message-Id: <20240725115854.234781-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6a0d5e-7737-4b0e-6314-08dcaca14116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4mfgfEFWO3C0Umke1RGAClQX4bI9Pw4GG8Z5VNJgPxum4GYZpkp88i26Pv/?=
 =?us-ascii?Q?gnIuZZS+DJtU6PB3yRLtZuDzcLgnXnpOeip9EbCtvn1AUY40C+9xFi4cy7Hz?=
 =?us-ascii?Q?RttFfYuYSWtjx1CdD/khQh319db160mjIDViUbjAlu1mMokBc1yeyIKF9Ou4?=
 =?us-ascii?Q?wI7l3CUsfsYzldFbHh484w2of2TPmnzEfAmaWbM6kpyQRhEr77Ton0+YDPKx?=
 =?us-ascii?Q?fAkRet0aaQD+CWoahy4BSIVSTvNTNOvlINWPsHgVt1APf/Cc8ky7AFtltroX?=
 =?us-ascii?Q?U27eScxY4CHV1jDkWz9YcjcRz8Q25ZrcO17g+molTZF5Ta3SeKmwZVmvHzmb?=
 =?us-ascii?Q?JlH4silA1Oe9glcwMT371gcAcfsw7LOj9AAcBJklkRnKqHaSyxU19NTWrwRu?=
 =?us-ascii?Q?1W5MhxlDcqFVBznjkiDPZG0DGL3iXKt0cbfAYw9eIbAX10g17qnARFb78XAn?=
 =?us-ascii?Q?eV92FPB419EJH/FNdaDaT/KMOZFjZH1jqeWBabf+HhdQE2BWhsG95aa7HKor?=
 =?us-ascii?Q?jiNP9jez70MTuJe+0ECPUkBhh7txh+KbZDtiaehoem0MQhpipuNs7/lu1FsC?=
 =?us-ascii?Q?NqFCOpkGJ5TF+jxn888z6SohY5nNg+oDTR+7ULhY0cQ4hUC2qD12bnMKkyzb?=
 =?us-ascii?Q?95V+XW1nvVWNDD4I3myC4YsjmYeH95WQkk+ITRyKZRZk+td1ryVhC3+GPR0C?=
 =?us-ascii?Q?ArZ/fl9YKpmqITOlUc+qeHFHo3WNw1f++DLvKa7lW76IknxPuMFGaHMGV7Ka?=
 =?us-ascii?Q?QaEkEVm8UK0OSJzb3lIiIb4SfUgWdadCins89yUTyI6fEk/NUJd7rekRQI+Z?=
 =?us-ascii?Q?Ab78EQYhIOwdJAJ7ce3VL4oJZ/iH0NAaX4QuCfR6aOEawRpGXJD0T8uynEDs?=
 =?us-ascii?Q?gRzvsS4Na1cGIHx5l7/Z8nAyoMRbxuwX/boA8ynGuLyVI9Kix1ikCet40nNk?=
 =?us-ascii?Q?ytpcFQarsbXZQtAkaBMUEEuI+7cldPLnZV6fNePvon5HtlyHlSBMqGx9vOuO?=
 =?us-ascii?Q?+2FfSzs0wPhpXH0qy0RogTbMz5jxXPyr2Ufa5W/DTXiCrdfD+4kNYQR7Ohcr?=
 =?us-ascii?Q?Nfz+3ztZ5JYAQMFsz+l5dAYjEyAtOZGdBCdjJWYV3lPn7SPq/UNop2e8XGPy?=
 =?us-ascii?Q?BjLOlSF4Ew/Gzmt13i/EZMIISZDWDiCibNC2sJmtnAgO5Q4Rs4h/aX888+V7?=
 =?us-ascii?Q?xUqx5c+WpRnbj1zfydOMlvzbmKrxtOyKTIIpcQlxIeR/rveh0IsNtj38yckZ?=
 =?us-ascii?Q?1Fs2ApzwLm/6fN5F9/yUQrywqAZcgAcQDrkiio/ccv0VTcQS4OGI2Uhfgk84?=
 =?us-ascii?Q?x/u1njcY2qUvdv8NpyS6SGgyOyKi+PizmhGoKZB0z7mp59yMMWCpoRMXMNcD?=
 =?us-ascii?Q?uB10p5qsQa6OvE+1InL/UvyIBN3ucHNUPxDMRoIlhVxKtGyjLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qhmoi83wfoGLOodDslwmBSa+nrzRq6DKsW3Op4FD7O096wU+ty3FvF5nfjzR?=
 =?us-ascii?Q?fNh7LFNkZBR7qU7tkWkAU8aVIExdJm6gnRJ9xF0K9rCpxVi80d1oTYMaQTrE?=
 =?us-ascii?Q?KBCWSg8qRUxW0yT6CpuXGyYbulNpPHrt2RIL7XJv+x/vTbVkiLKeGdi8Fk3Z?=
 =?us-ascii?Q?qNYvaB2tiNF3F/NPw8OYN2mQVjUYOdadHejLY1TDBUpRMWB8mTZ/0KA4hSVV?=
 =?us-ascii?Q?/PMVdRPHHilt4SxdGU1VnIGDkPAccmPid540gvXVSnvfQASY/L9CuLY1URSs?=
 =?us-ascii?Q?lOk823zBGe1irg/q0+WGt/qgjxm3Hdgck4SShixZaxD68GWK/CXgPMvqw1Yw?=
 =?us-ascii?Q?L6CcChFjTuew+/UEs73psq7asudT6ycuX0seZQV7gc0nC4q1dfxVnGd8cFXz?=
 =?us-ascii?Q?tj0+emHSamAYHi0vzFspYvSR332xn2dG4G0pFgZt7QIYVg/Zw1YvGNQ8E9xw?=
 =?us-ascii?Q?GnfnNerhvI3+rmY+rLUFiSucmJ0HFZXaU+KbhUcQTgQISWzzHE491xeUc0GB?=
 =?us-ascii?Q?YlVVaZTL867YNBoFCcwxpaIUtRBussZ5X8I7KqHBdFKnp74y0NERRZbvplNB?=
 =?us-ascii?Q?myuZRx4zgZxyIG6XJ3KaP3OmoSzwrNYUXyvts87FPKhPIFKUdeYcU4I9/9pE?=
 =?us-ascii?Q?obAJ34dQP5t2IT6JI8rlckc3SUyoyWm//nv97l+3Augygy6O4xUKcXSN+tEf?=
 =?us-ascii?Q?Zt5A8r4KJVDYz5QeVyGr6HxihK/KJdSUo5zuyBMf+0AlyKMPzHw8/f+fDZK3?=
 =?us-ascii?Q?d1cVFEv1/E/QqeTYrMBF8ioMDaYkOzwFcQWxmw7OQawd9Z9siP3dh3Hnrdq9?=
 =?us-ascii?Q?TplCEXU91GWzDUI9bodZ0nvJB2YXKVB/56P3LGNRc43SAWDH0v6k5xa1+Hs7?=
 =?us-ascii?Q?WAE8g/0RX2/jRU3ZqAM7p2Ttl8O/m1OnCPKGjpPGq7iplWtdF1kYcLHglUPw?=
 =?us-ascii?Q?Z16tghOMGFDhTIcoxJVj0l3Uu6FMuBKC9aWy4JIygAu8RTisMWzVQT6G2TMp?=
 =?us-ascii?Q?nb7udE1FzNe+SGvnMSD8yrFSN8riM5mc2gk2yy8KA5qAvrjHlRPKNhext48v?=
 =?us-ascii?Q?O75Hb6VRHhC/yQ3T3nsOqNj6ihm+oX9nY/zM+tGpTG0VDFZmBCzQbsg7xm3n?=
 =?us-ascii?Q?SHDdUwywsv87bXWkARQNMXTuIQyPwu9zhdEyAyjHBErpm1Qf3W5k8GF9G0dT?=
 =?us-ascii?Q?jHCGM/MtGAKMHCXt0YeOPN4EvyN5Ut1q49W9VkglrjvpSEjIOFbLV/iit+vM?=
 =?us-ascii?Q?VulaTRCWpsWH+xWNbqtu8sBzAm43M12Cvh7QJB3rqbclb79GF67SS1scnzWH?=
 =?us-ascii?Q?kHWGtpQh2Bvu5fE00VWpCSjpmfNNrpYKJ54y4muPjFkOD/IXtGKgeoNX3jW2?=
 =?us-ascii?Q?kmAXgo8XlPa9sawhDUVbP8077B8V+oWtlD24Ul1B7YVC5y6UbMAY9zEVzhF6?=
 =?us-ascii?Q?Xy6LPcUc3A4c3Xw/bAXM67gicFE/707ELa20k8gvUnXeZj8PctoD7MFiWdD1?=
 =?us-ascii?Q?H3n1QFW6AdOgCGEl4Qf1BEkiZ5Z7VLVdBcCOcfHMklZxNP3bib/2I9nNcx7O?=
 =?us-ascii?Q?ixT1BEh+QHMlZSEAM/94UxppiPJcOr1ZeyyTMbLD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6a0d5e-7737-4b0e-6314-08dcaca14116
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:36.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYtSIx8iYxQ5A9OPw7tQmBW9BSJoVrLTmdwW9qGsjd3sfdh2waw8psc94YUaZ/bc6M1ZMNMVEH0Zg595AnIC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

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

