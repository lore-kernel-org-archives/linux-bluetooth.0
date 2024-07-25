Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B671993A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908778; cv=fail; b=BnW+B5/6ntpZUZD6380DK5AwRe5SrUNWf8qxYYQtC3uPotQued+5EqWY7FYq4VDfzB7pQudof05+ElXVXNk47W2I/TZ8sAm1WrjAlWOU1OpEhARvjWa6QYtH4QMf8e50CNDv1zofQrJChlet9YURX8097U5FyyJShiPGUAIduhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908778; c=relaxed/simple;
	bh=ScA4UPNj3WGmvMkJvYFNz9vuwePqO/1d7vp86uw3AAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tz1bNBlW+Nhyo46MLN4WAQBnKCZeOuS9SEKVCGjX9l66I+V7JmK2kji8jXtBmymmtJxG7OeWFGbm9KWWyNXPQxQFcMATqHrJ6R89FpnD4+tA2+mXa2QyVySz2JYN/lWIEotJRTHiIpx/P5pZcnJA8QEOc/AsEfZ5vNE+mUNarTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nLuy+5Qp; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nLuy+5Qp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnH1DEXyfyodSpSGo0KpKPMGqihtC5KhvoAnUt7sWPkuyzqYnrTvXpF8DdQowiOtIN+LrayPY7Oshxx31sfW39f8m7sJdwJM4XWSSdSsbg2a6IJOHAoiFUhM1QZoGWATuS9irMPGi+AtRgk3AX7mtDbKyEIwBnAEHPb3tJUwrTjo7NBnv/We6gtQOcX0ZfeJ1ls3DoYE+VaJnxAGw0DqK/NB5s4agJH3K9U5JAgv7PvvHCjG/RO8/Yy41XlUcoC6Cc0N0N1JorXERq0BIDwz9hUR5+QvUzoS3fd7SZLaeOg4SVyV40etR5rUDKfMia/Mel19qoZ4ANVswkrCnTiiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=DuON0ADBGTa9IQ6/1jYWpNbtre45/xl08CZYZs9Nz/7Z2+/pYXVpQDNyrrLg/aqex/dqXR9TGuzx8Y4ga5RZovA4t8He6BwqmRlBI0e/euAR/jjocukfhpYXX2WIuKgc6E8QwP73RAKSbDGpIX+XYcYgU7YBWpGNh5ITgZfXb6W3bkhRYCuPofRPels/ZZdgv5rJY2m6zpK+3z7N0O8ysxK9RmhuD+CmsEWwbgBWniPTGJwmjDiipln+BgLXVg4YcY6bsvooJJbbnW+AVuB4kiUwf5bgpNSfPVt4akrNI6SnV/7Pn2Yd8nmEuCIubZIy7XAmQrf3FbopzJ904d1J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=nLuy+5QpU5n1j6Ywoh0phOANsCte+H0iGFQ5ElmeZ+HsXbCwHuU9TcpXCvAKCfSVjFnBScOXMhL+Idoyb4KG2HVVaTJhgK2VbbS5+Dl3Q8tKuZWdjOWCd85iEOpskLk8eiyk6s1mqlABYS637lRUUdtFYlv1dprTphKTyOlx8ob3atv5Pu+rlLXFCDuEjUfvJouERmgdhGhWkj3kGK29VOHrc2Q2GFpDkoSacDJeT4/NbhaAGn783hXgquh1kLPrrilpsWqddNjuCrS5mX5yFi8lIbJXOzSgrSEvX43iNM314ype8BEO3/Svj4WPNqcBPLKBuL/S2KlfST61co5X1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 11:59:34 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:34 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 3/5] transport: Add "select" method
Date: Thu, 25 Jul 2024 14:58:52 +0300
Message-Id: <20240725115854.234781-4-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6fe7150-4ec8-4e34-2ab8-08dcaca13fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sw+cW657G/zB2MevT2h9XWvRd0Iqg9OA/2EE9eNaDWxNawYOLhJlG6OKGfG9?=
 =?us-ascii?Q?OCvCINTxZZRVp9AmcuRL89WAd7P+isZ160AjtKu4zK2pb++H8Kh8ztr3DYAW?=
 =?us-ascii?Q?D+Bx7JM+vEWWHZWB+f8/joIgdH7f54L9A+cishbs3S6Mii5/39yyBPYJuDi0?=
 =?us-ascii?Q?mUB43S1Umxfpno4AQQ9LHu7inkfhXx+qC+htef1b3k/8fvS/G5Ye3UT8YIaX?=
 =?us-ascii?Q?QpNLeUdmmjK0B7zuDOmmpIPSbylY5Uo343r9Fovi/RI/hiwT5Tes8PoCldEw?=
 =?us-ascii?Q?NAZBZAD1BoXykQ/EZGFHmk4imUcoKTMNZiixTtQw7oQIdEc+hMOnYt+dS93k?=
 =?us-ascii?Q?K7sVV9Zegzf/ZqiLqPAoh1mgDO0aMtMoJ5mprh6W+ej3wBJYWn4Dz6mI0SLj?=
 =?us-ascii?Q?aBZr9TNxjFFgNiYieJBUmU+DfU/DZDYqqKWD1orH9JqMQeM7vdwRnEzDaUd3?=
 =?us-ascii?Q?wNpq9Jxtj+6QOJyisoTAvz8ZGLccZxnMxjiAiMUznaYZGWFgd5jvmulS/IyX?=
 =?us-ascii?Q?WuyMZiC4ddktuyEZir39gYbAl7aK/xX1fmZKtwcXZOZsKqSzWEUpW1inTbvQ?=
 =?us-ascii?Q?GkC/3OoAAs/VRlThTFrxBdBJykl97Rvs/hqyltX7R0jFnxnwJQrNrHAqIDNk?=
 =?us-ascii?Q?OWRuqbrSVI6IwuvQFdtb2tAsBcl/VK/BBnMkc1qpnQ9VMC/hdCJX+jSha6ju?=
 =?us-ascii?Q?JhKh6RJDeRR5tD9fehAGheqP4vwFDOlZYPO4U1DCRdde1dPNHK9mJuA6fiMO?=
 =?us-ascii?Q?bm9GRenIKaqrXBe3x7hi6135ui6scWjkly9FTu5JObuGHQPtJHl2BWs6B1s3?=
 =?us-ascii?Q?y/kY4KGoIML+Sr+dRE4w5nsvu8ibJn2hyqdihSBRqQjnNaaoIxV2W+Pi9z5/?=
 =?us-ascii?Q?ks25DLVaqYb1cAadLDRDHyyBvQAJ45cQ2oeYbXDtHimCFNKmFEHqTozEluiL?=
 =?us-ascii?Q?4kCD816qmFntBzMS544Aap8VZgqLkvOJnXAo7uJZtknMbboIqNV4RtmmAheH?=
 =?us-ascii?Q?6+Vn6FjK9fvEP39wQt0cKg9oFal8NBMnAnZ/Bfc8NUkyOBH5BC8FFMjZQhJy?=
 =?us-ascii?Q?TBUd7rwBpsy3mDoIYmSEZWZnNVOOJCv2gX24MAryqjKcjpzpt80pkwAT2mG5?=
 =?us-ascii?Q?GvLGOAIEc52/O0DT80Ooc1qzod/fIW8GPf34zgBSOXTA8zsgWXYyadtYyfks?=
 =?us-ascii?Q?t2yopQPbj/va5dxt6E+QxlDUqXYcIAWuijiZP/ZDKzZ6r5L2YqXxLueewlqf?=
 =?us-ascii?Q?0GKPACk4PaLXPXcuARR+1xToqYBtxvvCmLNdNnZQKUqshR2SSuZQdqJpCwuV?=
 =?us-ascii?Q?wGwg2x1eGcpdaXnN3BxzuYkh2bVLe1FpkD4Ga/6c4RSldYBbbZpkvf+HzDPC?=
 =?us-ascii?Q?IxiCXVDG4YdeXxSn4QdXh8EGX+gDTFKm/1OvwFt46YcfnGrVDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8J4DLSE+e9aTlSiHOU8oJJ5C5IxV/+uCMV9tRJgdusvoqwxk6t+uQ7Ni/hd?=
 =?us-ascii?Q?J7rdscnSMhuEyDo4C/mo43qHwa9+bZm+nLN4g2QClR8GkADNYQ0liEEPpFZ/?=
 =?us-ascii?Q?HIWfXGT17qI3ouLUP4DWbZq/vtYj51Wvg0EwIYPx9l7XVchIMnFiYESV5Lkw?=
 =?us-ascii?Q?JheCeJ+sQigBolGgONNz5gteK/KcSAhkI+GdSTNfWKshiEUK7Lxijb5TWYo2?=
 =?us-ascii?Q?Vs9D8kzkAcBMDSLCYSHH2r8Pm6OO9mHzeci1nVdJTuKcLq5OPAZ5gKZm8+2l?=
 =?us-ascii?Q?wVPjM5DGIMZhH5V6MYbCn5h7ePL/v24PEHECNa9Zi1urZeFllfJEjBJSjcMI?=
 =?us-ascii?Q?f9ML+thssZZ9wuQu1Vb1gu62AMF9IK0KwFG3I3+jTMOU4+KBpz6dr5g128Zk?=
 =?us-ascii?Q?u/l5gLju72I++YZnVou0R76N2FX8Kam8z5CS5aUi+zhV91teaOWK4WpnKFOQ?=
 =?us-ascii?Q?t54VftcvxWIpfOYaDO3Tsy0nvxQHNtPoKo4EdYxo4aLAdB4Yega67yVU7vx0?=
 =?us-ascii?Q?9Chb9Xe9c/BRVUnBG1V31dvQyp8ibajlvTFzPN1mrtdEEWIRZc2TjzibSkKl?=
 =?us-ascii?Q?1TIQFbjmP2BUFS6LjYWWFYxifMiAl9NhE/5dJbHldUGpzFfmUrgUm8LhoM4k?=
 =?us-ascii?Q?w9Q2dZKBsFVcZSsVUVjb12rPPUn9j5mElnmIOg42JU73cnLbR7T7O17cde24?=
 =?us-ascii?Q?qEQJdxzF/XknFckebMxH+aNWKL35ylo6VXeu3x+2nSMAZTgpw4uKjtO/9Rra?=
 =?us-ascii?Q?vOGJQ9A4F6fap00nsqty+1PXQMY+EN0zKvrOirAgLUSQ4YrvWQJ7CSXa19c0?=
 =?us-ascii?Q?OwuZt7/QgDrpKu4oHZOlASRwvGjPXacCOWmPhoOoftV8RHMiZGvyHeyIXEJ9?=
 =?us-ascii?Q?zYgUZvAik2o0fIR7zyo8PBqJlmj6gSvQOkUtiKAQFrzi++dUAEbI45btU20F?=
 =?us-ascii?Q?LwfYX2DO433LYoF/8O42IAP5FS5FQTd7lUBISGVYTfLi5D+jZDidch0VJdKF?=
 =?us-ascii?Q?dCAS547jEw2EWGdz5A9P9jJzIBf/5WaQT7HIembYIuDz4uzczoV1D5OjeTC8?=
 =?us-ascii?Q?zPtGlnIgYKeH8ZYi/5D5G6PlD8CFddGd35eH7njOUf8jPgdq/EjmWF+FPBc/?=
 =?us-ascii?Q?vdoUH6yw3masL9lIKYjDWMzyDbDzDL+j2gyq3YqOpxoWRBQwm+VpB1SXskR4?=
 =?us-ascii?Q?Tt1Fha1zF6WMc6OUk9vQgGrc2GekfJoOrIiUvEzGlr6pGl9pBnN4wEFwkoT5?=
 =?us-ascii?Q?KpyTqO4EcPOmGao/WkuAKipxGrmQpZe7i7wH3GwpCbvGMKaX3h9PbdXOPlk1?=
 =?us-ascii?Q?MShrWsii5KuP7yJF3SvXjAGuucTDzA97OFRn5KPojwWiCYB082gbdjKzmiON?=
 =?us-ascii?Q?TeLW5BdAhpD0jIoL1Gkrhwu0KUQGt2mAnTpRN919yIGkr+OijXlgTXc1oecY?=
 =?us-ascii?Q?6Ii+Wio5aLYUMi7QsVV1G/u8PNmEQjRUb+aUiq8W4nEwrMhU+buMSl1TEQEs?=
 =?us-ascii?Q?qZBXOl6vVvR5c8B1/OjUymld7SOWcp3FwPYtxetP/B5CFAk2UqraI0y9zaEw?=
 =?us-ascii?Q?txiaSWkJu1XpgmXfnngL706vcAp0mpovFRugDeqF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe7150-4ec8-4e34-2ab8-08dcaca13fdf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:34.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzPOTPTgcCLl6TSXs/GlWd7GHaKSnEBXXrAGmOw2Zfh/F2CMoUETzQOAtuXAmmFPVRuGD6jyOwmM0yyg5MbmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

This adds the "select" method for Broadcast transports. It's role
is to change the transport's state from idle to broadcasting. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0a890c0ac..bf2215a0f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -972,6 +972,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -984,6 +987,8 @@ static const GDBusMethodTable transport_methods[] = {
 							{ "mtu_w", "q" }),
 			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
+	{ GDBUS_ASYNC_METHOD("Select",
+			NULL, NULL, select_transport) },
 	{ },
 };
 
@@ -1302,6 +1307,25 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (transport->owner != NULL)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, TRUE);
+	}
+
+	return NULL;
+}
+
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
-- 
2.40.1

