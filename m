Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013056.outbound.protection.outlook.com [52.101.67.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4551991A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336841; cv=fail; b=vGnViSX0GvJtjcH8XAA33vb5oHWRdpbP+Za5md++v7cgPLmbS4I2uXr3Cz510wSit+S/pv+VSSh7r/DJlCReyzb+ek2/lLKSyFG+AqqIP+/yoFGe4E7tIcLK9taC5VN4P7fMMkL/E9apoifSWTu3PTEvRJtSbBaKSNBJ5REyo6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336841; c=relaxed/simple;
	bh=C6ScDrkMAD83Y76MxJYyAX5K6fhgAjv7nDHs0eFRnVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXTFCrGuxVwvbFV3SSCB5mZCc/NkS79kfyqCOoNT4Kem5s6JN+FHn1+hyLQdKfg3VZkfWHLmlE/rIjv6MnVhGndwERDY6X0B8OUilYly6J0m+PPSo4CK4SYwvXPJyZ+Ubw+l0hWmtyZjIsoVGL3gDuaP+K1SCHaPS+6rVSLTpOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dn3o6dNp; arc=fail smtp.client-ip=52.101.67.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dn3o6dNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+piwITjKH+3t3+W6MxSfUhaPMT79YEf+i0kh6//Mw26bThGYg8BAOLMuz9oWXDo6EF+L82K3QV0kIRYQqtF60ySJOGJcB9iG4YR/uOYzqjwxtQHKU7dAVf7cx3VxR0SYPBykRTWKGR+sk7McColGLNW3xos4nhsK9g6f+PqrlhPL8KLedrCVaXZSgbn9alroIwpLaR2b5lTuRbXq4zx+iEtgdQ9PNwHsrTyN7KI/MdUTWYNXiBDIsarPqmGEYykEV40/4jtMW/MpfgmZne5U6FAELFEukrvsGnu9kgk/Wqt9dp7yHRpB/uv6/Obvgv6NZff781r6g8HIRB1ZRRBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2El+uiBpaNbjvMOYHfoSPjMvWIA7FEKk1YdW8f53aLA=;
 b=FnB6J1yZhOTC8dDSkHKe5iNDkZB3OTPTBC9oB/J/Nn/UyOhEeU5NKmcoQ+sIubwR5A56Sbu+JPKXxFT8S2qV2bLwykTy8TMUvVrVcToR9/fleUEAbk0wYzDg1i/S1GMZ0yEP2/I3G3vWFAvkbBncWrmBEf1mTQ2v7Z+r+y1ECkVNkq0s5l4wRJ39dl1AO8eAtg0gVcn43J7UBQgzuCR58F34ZnlG583kbGcT1HUXVagod1ykOIqmZLEk1XS7dajBonh3Gyxmql22OXYQn/Ph4VWihFmOaEd8CHgK99BkCAIQUFssEqndZxo22Lni35A3NqfAZUncZXVtwyjzCQT2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2El+uiBpaNbjvMOYHfoSPjMvWIA7FEKk1YdW8f53aLA=;
 b=Dn3o6dNpFnCbDzT1raGRM+l0uZ3bMbkzuOS4931fUwEwCdMMXxm0EghAKvg/duiRrgc1gEJomMJQFK7of9FH+jJc9m0WxBtWjGG0Da0RZJHrO1HRJ2HxmJhQ8SL0kkNBw05e9K9Cn8YIZMs/nNl7BtB0ZycwYYtF8Ab3rzLtWdkPUhb0AuRXoalOnErBvMxirN4CHHcyGj1v41rKGELZ7XZWnW61PyoVrZ589uzIfeDfesSrxIID0LNQ7bVAXQWsc0Q57sKAsv9Y+mZEGP3Eyt5TugZI8LwfGcxT0LhkmoD4+mJ30C5esmm6XnWbcMv4buTHYRo4qrXaSI2JJrr2wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 30 Jul
 2024 10:53:54 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:54 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 8/8] client/player: Expose transport "unselect" method to the user
Date: Tue, 30 Jul 2024 13:53:13 +0300
Message-Id: <20240730105313.403238-9-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 289958d2-c0b7-4a0a-4f33-08dcb085e171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLIB6rzc2obQijQ6mY7DmAHL1HeVZSNYzXWi4PUOPmAB1VxH2ToC7CpgQsIC?=
 =?us-ascii?Q?+NNSFeT/iCVKiMcCt5vACVMOti4cQO/rjGp/hbRpxw8Tu4bpm6h0zGb435Qj?=
 =?us-ascii?Q?yWB4pi7u2yDanf8dORjaCqtBnJJoAXoGKaut2PUtLy+z6pM3ldK3heRw6SCW?=
 =?us-ascii?Q?Jtrmy9SgtQA2NOYJfm5RqtGp+yYws6dwngB+vtt7j1mTuVbf/4ZFsk0Ufa9c?=
 =?us-ascii?Q?JvI7ppEpVScDKAC8T8dBkl/vKGfNYZzmfa0DCTPE3kiZsRAfyIZtMXsDqliT?=
 =?us-ascii?Q?jDe2pcWrNXMPPwIhqVnGsizONEkblQ0d6XZx7j2kxfeXh6UXhMDVDoJ7qZ4e?=
 =?us-ascii?Q?yl8nv1MpZdNtED9bmDmei2E/TEJ4tG9ZfycqwAAbHbCQ4w7kDAMPgmsfHLQh?=
 =?us-ascii?Q?RgCfAh9iEZ5JYKZ4W5zbgH4ZGivpm0AZT7mrlDULXAraLNd9Wl7+HaC5U6WD?=
 =?us-ascii?Q?NsNiAYcFdTPqCwfW1gyfmbvGJ9siiZ+vXKq+xFEZa7fAkpMrWE2NPh6jZxcO?=
 =?us-ascii?Q?jBCkNm/pYGj2W3JMephvj24mTjUEICJ5vtub9NeQdcwRzDHqyHUYrFV1lBte?=
 =?us-ascii?Q?IH7vF8iSS2IpOCCe6BB2qsMkeSLVNDGxlEwSQeJ+4lTLs9SknEi01vSUbtwd?=
 =?us-ascii?Q?z6r06TrYQZXVmf/FWpKe10a6f4LgNi71cq2UcRuZtcs1JYEY44xtV1/AJc0T?=
 =?us-ascii?Q?6z0eJISbfF+Idur5mj0hLZW4lVGalpD++LDpvX7QEKLyp663wO6NMnRFomsd?=
 =?us-ascii?Q?gn0PBFj22wl0lW0OI8LHBdDCqcS3IqcqEQNKTU1zF5lEytqsFXIAa52rABeW?=
 =?us-ascii?Q?dpT2VlJzrAzj6u5ZqfamRmysmoaTGs8cwGLGktBQm6NK2s3of9IXZRg9H/Al?=
 =?us-ascii?Q?i0fX8tVqgxPLTxUboPKkmrbWxQYerjyRCrHoOnXWuOQLfHf18HbCWpheF/LK?=
 =?us-ascii?Q?On+6/QgxycNCm2PP6VcuzScGwxUmRqAU7ooOzmgUnYTxD2oGwPUHATv5sGZK?=
 =?us-ascii?Q?OGUizca62ujWIUChDkwbqL7eMaJrpEDwf4DB6v4h4cxEgeOlbopClnPVwp1n?=
 =?us-ascii?Q?t0Kjl2pRXIQUU0kQ5xD29fRE95p5QCEISjkQ/ROoNySwhT5/ASe1YzwPlBHD?=
 =?us-ascii?Q?EZftVK08C87Ih5vggCi65k8InHRikfRKJyTU0enUk+Hp2nmjGtNiMVeKJhjt?=
 =?us-ascii?Q?BAnRwO5l9IJ6ZOW1XDSVt8Il5K+Jg+1Ofpjp4rljxR+NcK084yPfZcudDhk6?=
 =?us-ascii?Q?8+WmWsFp85xGYrewCp4zMCABrRRB28jTQzvadZ9m2eyQVYOfAD3gyLR5/Zx2?=
 =?us-ascii?Q?FRBT7zd6Ow0wsrsbi35f11ZRYDmalDcT/syOGhgYWBpJx7MvYehIEj+4PQkx?=
 =?us-ascii?Q?9qrtiP2emmDu6iVvjBZ4u8YmEi0XDu/xcJL9G7fStDq7xS1gCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLSWp7qeYQw1hTCXZ/z6qtpPSq7zW9s9GYrCuWVypbyIsy2tR4yUghQc+ddd?=
 =?us-ascii?Q?HeHCgQZpXNgk1+aRxzeZMmtUBUEZ0uDHLnPNGGJ1RBxvhiV0hryJmZBvyKYO?=
 =?us-ascii?Q?8qD7EHOHYjIMMcR+8X349naMs4cj/fJdhtXg51RuUQSbiJGzuqG9cbj/ut3M?=
 =?us-ascii?Q?2F5dS88iHktDUEZV6+tzgVtIwCV4eKicwww2cmCwp65Yj9+FK9ljhPO5uSOd?=
 =?us-ascii?Q?vC4aWdWCAuoK/u8xEOA1CfhyxVmZAhpX+PIMwsANRrivVMU542kljpQ2dTuf?=
 =?us-ascii?Q?8701KopcyOK6gvN1CVHYQ82Rvj4lIT9IzgjrzJmXSEamXT9HNREM/oQLtPqi?=
 =?us-ascii?Q?D1M4vpSsK+B74x+UZJpqND38UbHY3//Cnrw0KwX/nCpbzAFZu/zKg2rL98C5?=
 =?us-ascii?Q?PwscxMkAKs6fYJ8sMH5UbaiTjTsVJ3TWzDxkHQ7DHDk6aEQUFeMwMfZNQvd3?=
 =?us-ascii?Q?N/E2USO5FBmOOk9VxW2Fl3cFJSuD/wrqvOikeY/LraByTSIUle3BsqeU6+fO?=
 =?us-ascii?Q?j3HmUlclkQNkUDx+11sdv6HtcBCMZV/Nrt9SptsljwtH7rrF7y/oI9B52jYy?=
 =?us-ascii?Q?dy1qDWy3twFUzlCSiLwVw+OdKbOaTZ1h1iXLX+QBeh+O1Bc+76xX2ipbEC5x?=
 =?us-ascii?Q?FkdVJmxTkbZ4/ujb9AHzjNxdtSHn38eN7VZcifEKDx83A3HeSgHbaBfv18q8?=
 =?us-ascii?Q?QhmcuKkW4iPygOXRKkyUUYlaKtvqVAEXS2453XcBdFYGpt/1iapCem7rG4S3?=
 =?us-ascii?Q?D4XkjQ8Q60zmIL7rQLr/BD4lmSqB+oMND13w5vmodBvfqHfNywqzUcLpHyRv?=
 =?us-ascii?Q?TG7XDykVKMvT/9KpvenbIj2Sp5PkO1fqpj0Ob6R+/kPY4XqUIRmb/Z4rFsFh?=
 =?us-ascii?Q?m1gt8tPonZx4kUyXPFspMd6v6k/B0TyXCVpKgYnaKKGqzp7fouMjcFhUZWLH?=
 =?us-ascii?Q?bi3T+ZMhEUlQx0OwkVKcOg1fYV+hMn6J+rhV0sIlbYSjCElcPO2IZ6g/Qm4G?=
 =?us-ascii?Q?+OpzJ+Ou3cGCLX6HYm3Q1IEW/NKpZ+ZaZdwwgJIZWUrYFiQ2+QRcQkl+Ga6Y?=
 =?us-ascii?Q?16RYIYG1Wa5BGFm2TWfu+yqYwYImpbP1gIcJDvzJydFJazySIOSvzNAX6MAP?=
 =?us-ascii?Q?zR7PXbFwKIASQDnycY4YUtXTeTbBo9k3aYW/q8c6o2LShvXWixFY81hYTsTH?=
 =?us-ascii?Q?wwe7iWMtq6FzmivogjJS+xZ2FZ3pt3dPk1VvjK4skTmjJlWpjvmr33w0wF+M?=
 =?us-ascii?Q?NK8QsarZe5T9KWL7xkT0D0aoqFFsEOp6CIcqHeANQffFHY0pDcb+Ol1AwyHP?=
 =?us-ascii?Q?6mPan7fmOtrgplVidYwGTjD/gQeAJqEqY4jDSvchFoF3k0sB0krES3BLdMVp?=
 =?us-ascii?Q?3h4ccxZRJrNpG/3Fk4wgHOGRDy9IQDJudCxs5yQ+U7s6QXCGut8Madev7UfJ?=
 =?us-ascii?Q?p7HKdimMFnsTzUXYx+4Nd5D2Hryf8M0vDnxbDAogE2ZkIoyjgwXKXOpiPPfO?=
 =?us-ascii?Q?21gx5joSuSa7mEoIe7asZA+aSLXz6rQ1LChHFfq0BDfb5GblXEGslpavwsae?=
 =?us-ascii?Q?1E3S9297loyBg+S1wMp6jWU58hQk17Ajkq+q0IKt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289958d2-c0b7-4a0a-4f33-08dcb085e171
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:44.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqSeHAQJeMFMdIdnhgjktJY/2qDdJ8F0lEh+B2De7N7vk1mqYONJ94h8cOKSLrc+ndaaMjrmEAx8d+QrRvue0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447

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

