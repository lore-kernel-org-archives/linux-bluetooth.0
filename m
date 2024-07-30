Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC41197A9D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336839; cv=fail; b=ZmTLLRcpjf4kqGnNo0PGNOX/fYpOCEpmAyPxbmFnsN19z0ejL5N0WR59OqvzDMrTdGNIDmF/qKJ5Em0mZgFO9oO6Pgm3R8rUMMwT+GKruqLoWF+3zMeBeQ6AwTig5SgUciByuJgd6FxlnUiEIhDcmzXOwoRhkjFK79epBffW2oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336839; c=relaxed/simple;
	bh=ScA4UPNj3WGmvMkJvYFNz9vuwePqO/1d7vp86uw3AAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzFB4QAGTFG9NeWwhg9KLNTBzYPrmHsDB7EOMAXl9SZcZaEVj/XXSe2sJtT7GnhBnKumCBaGIUDgk+bZaYszPdS7JkxDYDE7ZHoHnYTJt5ZLX30VLAjtRtdZME/Uf6qCnVwzyuPbgCSjDaGPFybhd3MXPT5L7W5LSWC6C6Z8+Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=My0PWdAN; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="My0PWdAN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vX1WG1uYbFXRo5oXpTIFknSCGwSi6zwQ6OCx185GpOlCYc3j1QKeGkOkQ8f8vvVJYfuyIs8+tZ6YIzhHWh1Recjir1wXTytxhEIHJZJkhf5t41lqO3EusERTAoPAw/ql1Qs0Q8QI09+sba5X1QTOCI7gXsutimd4P0W9geE4xZclA0W7ZyaMu2qUQhD2lvAGB9ZGPZgJ3JY7qqpwASDMqiOPq56tD+zvcfPc+0vAx2tpJJbczz0X9L4mV4UNp8JUutshaAGTaDyWTaYhY7sYyCFQ+dMsoqeYh7graMNUEu+6lZgZoewp23bYPIA9fW+bDxSnN3sdV1mhC7VKVxOH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=GndPjgdHrTuZb4fn+KhvNPCvL1JHtvug0zoLunrS+GPZBPDwafko+0+C+wMzqXTlEiYPE/tjpAf/XrUSarh8zCf8ZybQdGbAFxMnllaU4cayfr6nHi5ugQt3HuHgjbKtbHXD2b8dZMVr93xvfIStYY+3B3BbXDn94toA6EW260LevR0FbO8gROdFc615sLZ1/xEbvCU79ruzYTpXa6WVfDaFeQB8i3mAy9tOhP0WiKfkoXs8btcm14vgdzO6q9YmEyxle9/nZ9H+jXevMahbZ5IYcZXxneOz+ILGPAaN7xydCISgAQpg1vf667Ka0AfYdWacCjkmbixjO9YwuiT57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=My0PWdANAWE2n++nEqQlIc8k34O1b0hAHDP9tOYaIk1zd1U6sobYDZF8vQr0uZhJ595VR2JG9pOzbwNGYijkPPcDVO3Xm1xF+Czbpz5kMPRf9+hgn8KCCtGPZctiDcf7GxFV5YToTFjf0/HaaRik8Uw2+QH9ya6JVjGpSiEOAm1RjFcCre+LI1qrq+OC86zMTsaV6OjCZtLIbJLX8eSDRBS9RRzSpFRxcx+T6zWTelZhR609NdZdW//4fmVkvtFVEQ3JALdbj5R4jsxzvPByVuAsD9TmHyuoOcfgwIphuqIqTNpRjCMvsJdhRulCX3tYLUV3ULDpYEENYSArA3vAfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:51 +0000
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
Subject: [PATCH BlueZ v3 3/8] transport: Add "select" method
Date: Tue, 30 Jul 2024 13:53:08 +0300
Message-Id: <20240730105313.403238-4-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d50a84ca-0e35-4b9a-9c34-08dcb085dca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYKpiRBUqMKVC1OOPXWXBU0559RbkZ32WbMZ7KZcl1iOcA10Aw1OphxiROAn?=
 =?us-ascii?Q?YzjIMc/hbl+dorNrFm7cTGCCley3IToslnTpcPMLRWJFa1vvIgL0jjQI9Hcn?=
 =?us-ascii?Q?mZ5o4xYmoOVhmLiUof+xJVmeOD6t3dDS3hljftwi8fOdn91NKexzNxcECt74?=
 =?us-ascii?Q?MZKIoQ9AZeskwO6PgEEClPYRvY1lnP5EYCbqhthlFPe3XhIfcfpIpnSJippg?=
 =?us-ascii?Q?d8hICIe4Nlikl+Fr/pWNTm5TRg4NVm1TnwJGOcxXCzzwARiUASEoJXYYT/0X?=
 =?us-ascii?Q?KkIFcut/IZKeK+/XhtcRJBSAV6QKJukEEhmzhuBpPhXU4dUHS+fn5cXjdcY0?=
 =?us-ascii?Q?RfrhRRNBwJ2+7hZFpK7c3wTqYTrhwm/w6oxd5UW13yiV0qE/6qOs78lvu0/s?=
 =?us-ascii?Q?8lptQ08osWOjCcylUBA3s3tYmulP6zZ8Xglsu1xUbaeq1e79srEGWjry750/?=
 =?us-ascii?Q?KxoEzITzsDTaQPNoRHbu4g+6qXs4t8rs8aWg6zowyXoX0+RjJfNIFaEauQf6?=
 =?us-ascii?Q?Y1Zbx3Vm0sfD6QN+VMANyW2WfNk5QQnXm9g5bdl1vgBxroacI0SJj2tqqWRA?=
 =?us-ascii?Q?KZIfJa1YpVDVyMQueYgOTYj1jYAf5x+k4oTDuWJ+MTBSYEL6t7iewB+9/uuo?=
 =?us-ascii?Q?XwO8a7PoZaqO0323GwJZsJGvflPelmHqN8JVL0SXQYKtcgbaw02Kyn8cTzUW?=
 =?us-ascii?Q?c6UregIKEYOeA+M4bNJ9d0rNO6hoRmBVO5MNo3qoyxReo97/TTt9x2gQRWDM?=
 =?us-ascii?Q?IbhH6vXrgE6z+8xrVHCbCbMFCjJ2sbTtJ9TS5q+SZ+RstD6VFnnjRAfEBpSe?=
 =?us-ascii?Q?RlbARqyNbH6f3TMZVbH8HJORapWVg6snEV/1TciwA/8RQLGEAdQZn6Yerrvu?=
 =?us-ascii?Q?w0rOKkDcCyfPpRgxfmSx5lLcRWKSoVsBqPZ5nQmAbamLwLBTX+VTWNSIhSYd?=
 =?us-ascii?Q?N6E0UoGH5kkN24Wx+srnSsSJkZUej3uG9C5jD3RtLvFUcCUWI9YnmxG0b8G8?=
 =?us-ascii?Q?DXGum2/j4sB7nT+m+rGR8Ka3n+KI4VnQQI8vW+MFjUxrLSremwtH/Vi6G+za?=
 =?us-ascii?Q?2837zX5/KlZsW8eejnGdOz6ynO/dNBjpZc7hd1EilVI21Wvzd2Sguo1jeh+K?=
 =?us-ascii?Q?Jd3ZmtLvh+j1cVmcZOEje03sArS2l88yOlgF20v2fmL/NXM2TkorXChNK/1p?=
 =?us-ascii?Q?huemztaLInuAqqpFA4sc9cQWaLBVHsfOjvVummzcW0s1OeAaFQgd6LCHeonI?=
 =?us-ascii?Q?/rcO3u8Z+1EmmAfjiW99Ihkc3CTNz6JkwvGq/nY418FNSNykORSGdl97AzU5?=
 =?us-ascii?Q?YQJdrh5IoTNL5N3Jc0zJj9olQ/wm/BCBJKmYNvnxmBp1JfLMhr0pMVo9fAN9?=
 =?us-ascii?Q?Z9HExiyPBTXVIwR+drQoo3Iiv+j1JkC0Y7LdhRLz6RdzIGgXqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZDzYxAvlDrondDDUk7X8g/HNo0Wlujuw2TL6y0Fg91bAR7BnSPKDdqaQV1C?=
 =?us-ascii?Q?Gi9C9tqiYjYf1KqIsbsRj4PruywbRuscfdSKU68gvDHOBbz9wTA3X/AtCs65?=
 =?us-ascii?Q?N+T3v4Ypr53HitzlyP6MeLyWDBZhY1LLidT7fJb8ewAUePJqDVFcJxZ55QNj?=
 =?us-ascii?Q?QvZ+fexvO2zUzwxRBq6DMff+3MAlsdF/TZ7KlnK1p7f6nh6i6s6YbrzYyz/7?=
 =?us-ascii?Q?bjGlPvWFeg6XOw+Ri7BxQyknn+huYYGXo0fXj0P6C8YDAZqdFRS/0xh7fFcm?=
 =?us-ascii?Q?7MvMO+AKyIGmOoDv4TQdqQDzYWgnunyIYom30l1fgLq8w0u0JP8FZt1xkbJH?=
 =?us-ascii?Q?w+xARHpTUGiHKSEImGbRJXlSjQcKKc27j7Y4hcgvFNRRmHkVYH4kSkIbLU0j?=
 =?us-ascii?Q?+RSXc/1WEpP5ssuDhrarBTVKPVYyJadQs5CsVWMlNBVYDHR62IL9U71BMGfs?=
 =?us-ascii?Q?CudjttkKuygcJUUmENN4UybK/uf5MO8v/X5WVn9WoUgGyDod9jFELS+q4UDI?=
 =?us-ascii?Q?O7eTXUgOm79NgQNM1n6r+io7LrA6CgRwipZykBjBXvrZSzI9VM95qaekMHS7?=
 =?us-ascii?Q?SsyLBixL0QchD95MIGdct41S9btmBQAh0jnrBIjsiOEeFG2htdG2P+h6cP/m?=
 =?us-ascii?Q?FzocSmzJ4FELyypXGBbS83jcoQzgcjVRNymJsmA8pbFUuB51xnU0wIulqcJ2?=
 =?us-ascii?Q?qcjUALn5X6u5yVYkGikVRuWsTaDcM+fnn7/d/ysDVvDf93kDsLMYEwP51c64?=
 =?us-ascii?Q?zpcjtGso8wg2PFugkollGdU0d519us/nDl4bl/NG4TUgwQ9tdTntCEHhYGTb?=
 =?us-ascii?Q?nfLYAKtaAg3Dz5I+gbXqKs/4J7QONqfbMqsCDtjESHwYrK5VhRg6e/PAuIC8?=
 =?us-ascii?Q?1PVZYqDNzJEIVtECXrNt+rSF3NvZDMdvCZikrBLc5lBAZQVXIsNx9433UsP0?=
 =?us-ascii?Q?9PZR1UOcEfzL3bSySG6PElkPKlLvYYMqYyS5ofj8W6FBVmVpUKd109s05965?=
 =?us-ascii?Q?BoiVMn+iK1vpLFH0YH31qDhMDmowlI+K4+xXRODQXU1i+2qiJ+B2Hs53D8X7?=
 =?us-ascii?Q?qKM1AmIVggalWT636DpcqQDWgeLl+lnz2xJBHhcLCketCfo+2vzNT1jdktA7?=
 =?us-ascii?Q?FjGjZ/3Mz5/R3hoqqLBk60ectQhhmr8dY7UmCsQaUPhj7AxdU7gBPLO6RcGd?=
 =?us-ascii?Q?/3Ek04wscAJAnBlu62cs2qxeiWQ6zGAiug/7gK6WnfMNeiDB916NWnuabvEg?=
 =?us-ascii?Q?8kVcbPx2w6dnhY2b+xz3yd1xHSNgU5LPD3liQ9BQl58pBYcrW/VS7cczgJ3G?=
 =?us-ascii?Q?3/9KK5oZxXus5Hf/xPPb8iS4e1Nt0d9TDcAXZrPaujv5mWgGzXb6vbRT5bpr?=
 =?us-ascii?Q?aKK+dDqWnch8+R2PvGxjzaRScMPN4DCOKhzFEDAq6YAOl3tBHoDivAhxy7hP?=
 =?us-ascii?Q?S+uNTHVOXcVlAjVP3QVw1yTx9U0eLa7mUyoWIuazS3qgEeA9SiKYRdp++nr3?=
 =?us-ascii?Q?5SlCdUc5HVx9dLGUo16yLSB8fh4s0nLNkd9xyJgaPRoVXW5lMpco7/6/GtUP?=
 =?us-ascii?Q?taBE1HWdYM591gD6EPUEyQugehTjmdd414pUfDso?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a84ca-0e35-4b9a-9c34-08dcb085dca5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:36.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApSZCN7dom/XdKn06y6TkTPY+lPYCsyQKjW+JMu9EqkG+euZ7edJNAihZMehqg2pX7i3HT+0QiNdr0XJCmr+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

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

