Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35521A43D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343111; cv=fail; b=Wahb6adcPP/ZqDOYvfulcd5B1Wa9S4Th8oDrtm31r3GeJfo6ixTxUoyhT8hinA+iP8zBxo8gHmVLiD41MmCSU1sHArN4UEa5z3nZSGrBnPQr6fLuyW7C35nQIkaNallkl6WxnIMrxmMVJByKBtbTyYonxM6CRt4Lxi72O2gdP1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343111; c=relaxed/simple;
	bh=nxSy6HEdUgAUNrfKaesDIPIUPnuhEzgRlznUtekUNfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYUq6hQMUW0ZF1YwJZfYv/WxyNew0p9KMfjpcJhWpi1cKGaFSN4OXuaeGVtj6kLNUb4LMfAOl183oXclnLbCb535BqSUsgE2QgZ/5aRL2yQYCVh1dGhNHm8jG9fXTj7vFSwELbi5KG7kxFnw62d+H234JeA7m/FmOh5kYIOPKFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZNWHHiYY; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZNWHHiYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9aMn2TFKGLAe9v5f6bv5ac8mB2hDxeHPzNoId9VzsEvJn/J49N/+ZDGG3J9I3uX5G4064+eGGPSCEr75dOeH85ByOoNpvDyTwOHFhgUCdGPTNDOOLg13/JPZ6Ph1GzGPZjt+mflENRsIxix36Qjoyrsgm2iYEEreziHcRhqvuN0gmsFsiitXoYBlW9I22BAfbR4ZF0PA0rNEBM+FEgLxpy+QtIzdfSbO2zwiZZ+bAz6xiWUnQV/RovkZmmflptWV72wEfq8dmzkp6eiT0FsaIJiQhV5WyF5uKyjrhjny0ydYXkBTYBs8479r63jP39Sf0H7kfNDvXk8jqu44rIsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Iw6M7/VmOiFt12DHlKaX/UPOLufwbSU0eivWofhLQ=;
 b=nsN7oufkQVsYekr1eIlt6ZPScghyuKtb6GcAzFBumZPu1QOgT8lh4/TSNhDTVg0GcYWlLi3sXqoP7IuuCLtG4xAIComuWdsqyEavoFLlvCUEn+RKXq2euRtmP4KzIW+ALIgUXOBEoWl7rsC7JPMWyDUSjIxQpqsmQAEURB2bYHvcdZMYnf5yB+f2rmOzDY/9q5tc0TKjH6FpFvFvN48A1s0RrAKU8SdwfFenqBrJGwZSTbefMVUwojxgrfbz5R+Qflp9Ue8hFIKbwsiHa+V4lqncHAXIwZ6c/STtZLgtwVcT0OFvux5I7w1nqGCOUHK1uQQPFX4oTdnU/gbIIBR9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Iw6M7/VmOiFt12DHlKaX/UPOLufwbSU0eivWofhLQ=;
 b=ZNWHHiYY5eIRuhPQPTOsfkOnK5zENZc+aDcBOF2RpE1uzRB9wEfreRsWukFzXXUbp13PfQEec9oe7BR6ZLpMWRcTGOJtfJG9zvt9xNlIUmvg94T+Qn32MojKrFxEmvrtVM2HsQ+5NMo3PVuhZFKpO8ct23WZh3Ec+OYtKZFjxOryDdN/sBsdkZcV0Mgxn073mO5F5xK8+GlAE1hHUAnUdUKgV9TtY7fWkW4al0XMftLyhIiy5gxIfqH+TRt8lgun7dcRL7hl1tPeN+XWBCBzfZlQGDKXfDYnfoh/twv2IQGEPGGAEMXrIlF0YYINKF+AB4VfvtnZwGngnqwET1Jfkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 14:25:05 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:25:05 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH 1/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Thu, 19 Jun 2025 17:24:57 +0300
Message-ID: <20250619142459.7979-2-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
References: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ece4488-2eb2-4355-6888-08ddaf3d15db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVEx4/+LyuNIPKTnuNKbaC46TyQDw3sp2AnDxtNLZEmTKYhGF2Q02Z6Y7AnC?=
 =?us-ascii?Q?bbgGxAaZJXLMLCIsavjeuZrcTA98p8SF9yaa23Zt8yziC7C0vnwYIyGzWDrX?=
 =?us-ascii?Q?sKhnmgFFueuXDiV90zMLlR4w8DDWGNHlJjxeqJEi7U0gy81jJzaDA0HvA+U4?=
 =?us-ascii?Q?CX2boeAfqyMsSYCFBFwJY3y7n4FURJNkxF8AQKJyeL3DPW9cZONTkN+CUcEG?=
 =?us-ascii?Q?GUH7ctNtfHl7P+6Zq0o1NSgdomQ55hOuJTMEu2P4DVyZLSSceZCQoc+0nDTD?=
 =?us-ascii?Q?IGDkNykmArgvqv1fAOAP6mM1jauhOF8xTDLYYo5Z2JY95Hqt9O6iLJrCif/6?=
 =?us-ascii?Q?iEzXa1z0Pi2gyDNWKgPfCPV1eKp/8z/y2ukou/Zyyse/kUzxHkOJvUwhd9Dd?=
 =?us-ascii?Q?RXbRfKGBjmhN3scYHGJhWBWsX/loxmtXIEe1Y0weol/HFCv+i8AfXdHqFdU8?=
 =?us-ascii?Q?1eZVTQnRUKc8QBouiQO2NHlN9DDOKpy/30lDz3V6tMM309XANWQgSvZ5Pk0W?=
 =?us-ascii?Q?hiSBFQp0D+QqrUydSjnNvLDE0bifo54TBKw5joCObyaPCzye71cEOEvql2gf?=
 =?us-ascii?Q?9EE5GCl1asIhpq9Iv5eKDttFcFSkPoPUrI3QEeSAYdSJmcTQ2Y/ne85YxtFY?=
 =?us-ascii?Q?v/XCxK9+WWndke3YDmOb/dKvWNsDhqnm4LMVd6T0gmQhuGDVOiWE6ApezwFC?=
 =?us-ascii?Q?TTNIUV2V+DbANWhbTCD5MJappoNxocxLZT9M0Tn52ZDtz6SSiB9FMeITMv7i?=
 =?us-ascii?Q?pWphAUQycZs9di0BkdQs0DNtnRVH+A38+zk3UIFjdqbA/F4YFPn1cZ6vZMu+?=
 =?us-ascii?Q?eioqyCDf98igvWZsrx8NYTxDj3pC6/9NbCZCdqZd9gwVh4O9hWI1aZGAYhiD?=
 =?us-ascii?Q?zo/ex8Rdfdu23biuU81gnrs2n3J8QTA34bYexPhQjgt+gB00Q1SV2/MLxig+?=
 =?us-ascii?Q?SHX/iACpLrU9omo97n3hr8fHICOPexT2TdOzZn5jh9khlKFjUxMn/AQMKAGl?=
 =?us-ascii?Q?Rj34kleHNkxOeVKKpLBpL41h/Ku8j0CHyLIuLmQTv/zDwRc1sKiMS+DPhToy?=
 =?us-ascii?Q?7Oml5JrHAD1uNunMuf0UTuUPLviVWK2ohj0K8ApJdZyWo6a5A7jqY2AJGmFh?=
 =?us-ascii?Q?VgItNhExvYcNoKagWPWDRQ2uB/TbhluF/q2sq8CO3iz4cbnJx+mgJxmr3oRO?=
 =?us-ascii?Q?weXIyvt5XCWCtDWS4dFR0hKvitmOkrmOOjxMTUh4+D+IP2WAlfGinMyLoDDA?=
 =?us-ascii?Q?JG3qmrBIzEhOk1PKCTuJsnppctxEj9tDRWxtp+TXoptd7G77n3dfwes6Bxvu?=
 =?us-ascii?Q?PCazo1tt2gC343tTJvt+P2eKfQRFpmlINCQdL1rLLT5dLWjjQtF760GiNvwt?=
 =?us-ascii?Q?XGpGK0fGCMpXtVxYT9/f91IQJq45ToOu1FcSFUkxQDwPTugNeCSUtRT7C5GV?=
 =?us-ascii?Q?LwjVprO6OPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsbUdcG+UaXPL7pfkmKR9JpoZ7tj9qV6AhJ2N5sUEQgY5OG9o1MW8OFD11sJ?=
 =?us-ascii?Q?n7Cr5evUDE7NoBygmuiSeS1FDklon50i/S3qjPHLd/DHQz/uWSXEOTFm66P2?=
 =?us-ascii?Q?1nQeUZiIXnJaKXHryBlPA2fGuiGSsCDDF+0k/ELd+6LAPya5mtJfkfxVfyD/?=
 =?us-ascii?Q?rnOnsHXdRlddT14BQ+qee/Rk+TbcetT2euRgwXMKUwDREn5pVd9i0tTE7YW/?=
 =?us-ascii?Q?A/a/5Q/bEXI35VUuMTSUgkoMQ1V6WGDChGYhVo3adjeWm1p2DwBOivZN7BG/?=
 =?us-ascii?Q?YlXrHppZT3DNem4W3tSRKAqLHSiYFC7enuedpdHd0tEH3IUadzxBbXa5HHvO?=
 =?us-ascii?Q?i8f50y+cJWKKZWttaaZGo8rLCJSJYH5MJKVQ5Hd4EDtfl054sjHe4qGLByXs?=
 =?us-ascii?Q?brvtxDhyz0DYLRfF8zOt7aXkS35U1VEwPSptbhmvmE1wKa9P1kOOFnrczKgg?=
 =?us-ascii?Q?K5zt0WSusLnb1BGXKlmeU5ZsLfPckp8fUAgKwDguTz5gG3ldSxltKmWPAioD?=
 =?us-ascii?Q?Bj9CGwHb88uz5K9SIzPT+Sido7P3dfeDfNGniebhpU7JhoEEFq3QUp8L2GsD?=
 =?us-ascii?Q?nqS2T6EKVvbT34RR9PuNPdhZFNM5MNlyWvY0fqgK/4d/VOCZuJkNBo2MJuRv?=
 =?us-ascii?Q?+ul4O63sp0s9K9sXyoNEDv89/D4cdijrDl27b3Zusuk9w7Nsdby2Dxstgv6W?=
 =?us-ascii?Q?3rdGLZbGPjXYcettrT9amBLt+NQXm7QEkm3IXFNtzdHcYHZ0iXUZRIPWmWvy?=
 =?us-ascii?Q?FNa0upUQhE0RRjBY3ULlld+Nb0rzf2yl3uKaNZSnYdUpRVKVO5/4eBjnM+ji?=
 =?us-ascii?Q?oOLwvjraKj1zdUUVgqFaqU2DOYxExKuEhOwEdkGpqTWTLjdtjxiT8rs05QqF?=
 =?us-ascii?Q?8xO+XAveQ4FwWVWo6oF94QWh2RWahK6QSrxw7e/Sgaj27rOnfwZMiHvzFeLG?=
 =?us-ascii?Q?5g9RYI6udT1ieQvncZuVjW20fGNUwAZ5a+8SeglbKhC9uQ/1dnw9NvEnj/6Q?=
 =?us-ascii?Q?hu4uW3miy8U1RjXlUortt9PqTQ4YTN/xwrbIyyDiVoH8WcCWbwpDJQXLFFXZ?=
 =?us-ascii?Q?VB7czM6Ne3psndpJHByUE3Vh8MBpFdMvScuLo7csZe02PcosjQmifAi0sSTR?=
 =?us-ascii?Q?a1M786jR8+hPKtr8b79S7oZDIeBASN1XTF14cS0pC5P4UyDEDVxmdUzPi+sC?=
 =?us-ascii?Q?AxRN45VWHe6JRUjZmZDKYX+12BJR1c5yvnIKSNiwRN2bXYo1pGvvDRBs0czp?=
 =?us-ascii?Q?s3yJJTcyJCwix33/3IMarZzOyD0QvXMLpe87vuDOns8CyZWQiTl8MoJbiZI+?=
 =?us-ascii?Q?Ex/ISs6dwnd4KXLwj/qS04eYRkzWZl/c41hYGF1JMBjJF/szEOPMifYGyDrv?=
 =?us-ascii?Q?d4Zq7myW+jUYH62iW4LTt9NsP5i74KkALbKsH9TnbbIlI7qtKff2WhKwctWZ?=
 =?us-ascii?Q?YZemautqssTvrr4TTdXPN5lTRi4Ym1XeN068eCrwSlCSCLpj3lvQI8e1+pi2?=
 =?us-ascii?Q?utz6AVwHFNH53Td3aOm37TqcoJN/lr5kapjgy1iDH7NtAKJFlkFfe/GmqyWJ?=
 =?us-ascii?Q?aDZzdvI9Sb68pb7DWynCSdRCaIhUVzE9GFcPFl9ao14zChFBpiuMuhPzGEO0?=
 =?us-ascii?Q?j068Zq6wLXiRJlBfBE++CTA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ece4488-2eb2-4355-6888-08ddaf3d15db
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:25:05.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iiPrE88lDFecrzSeDm52vTUNGDYRffhy0e0ZTt+Az/lt7TVNSV6SHC8GY/+B9HUBTBlnPotoZCO8oJXY2MuLyQvacGkLDxGtaLHllK6rWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
---
 tools/btpclient.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 055270edb51b..f80b4532a248 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -2510,12 +2510,23 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
 	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct l_dbus_message_iter dict_iter;
+	struct l_dbus_message_iter variant_iter;
+	struct l_dbus_message_iter array_iter;
+	struct btp_device_found_ev *p_ev = NULL;
+	struct btp_device_found_ev *p_ev_temp = NULL;
 	struct btp_device_found_ev ev;
 	struct btp_gap_device_connected_ev ev_conn;
 	const char *str, *addr_str;
 	int16_t rssi;
 	uint8_t address_type;
 	bool connected;
+	uint8_t key = 0U; /* AD Type will be stored here */
+	uint8_t *data = NULL; /* AD Data will be stored here */
+	uint32_t len = 0U; /* Length of the AD Data buffer */
+	uint32_t eir_couter = 0U; /* Byte count of AD Type, AD Length, AD Data */
+
+	ev.eir_len =  0U;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
 					str2ba(addr_str, &ev.address) < 0)
@@ -2538,11 +2549,72 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
 
-	/* TODO Add eir to device found event */
-	ev.eir_len = 0;
+	/* dict_iter will contain the variant for AdvertisingData */
+	if (l_dbus_proxy_get_property(proxy, "AdvertisingData", "a{yv}", &dict_iter)) {
+		/* key will contain the AD Type, variant_iter will contain the variant
+		 * for the current elem
+		 */
+		while (l_dbus_message_iter_next_entry(&dict_iter, &key, &variant_iter)) {
+			/* Unpack the variant to get the byte array */
+			if (!l_dbus_message_iter_get_variant(&variant_iter, "ay", &array_iter))
+				continue;
+
+			/* data contains AD Data, len is the length excluding the AD Type*/
+			if (!l_dbus_message_iter_get_fixed_array(&array_iter, &data, &len))
+				continue;
+
+			if (len <= 0U)
+				continue;
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
-						sizeof(ev) + ev.eir_len, &ev);
+			p_ev_temp = p_ev;
+
+			/* Allocate new buffer, recalculated to sustain new data
+			 * eir_counter length from previous data,
+			 * len is size for new data,
+			 * 2U (1Byte AD Type, 1Byte AD Length)
+			 */
+			p_ev = (struct btp_device_found_ev *)
+					malloc(sizeof(struct btp_device_found_ev) +
+					eir_couter + len + 2U);
+
+			if (!p_ev) {
+				p_ev = p_ev_temp;
+				break;
+			}
+
+			/* There is AD data elemets to be moved after resize */
+			if (p_ev_temp && eir_couter != 0U) {
+				memcpy(p_ev, p_ev_temp,
+					sizeof(struct btp_device_found_ev) + eir_couter);
+				free(p_ev_temp);
+			} else {
+				memcpy(p_ev, &ev, sizeof(struct btp_device_found_ev));
+			}
+
+			/* Populate buffer with length */
+			p_ev->eir[eir_couter++] = len + 1U;
+			/* Populate buffer with AD Type */
+			p_ev->eir[eir_couter++] = key;
+
+			/* Move the data in the p_ev->eir that will be sent via btp */
+			for (uint32_t i = 0U; i < len; i++)
+				p_ev->eir[eir_couter + i] = data[i];
+
+			eir_couter += len;
+		}
+	}
+
+	if (p_ev) {
+		p_ev->eir_len = eir_couter;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
+		 sizeof(struct btp_device_found_ev) + eir_couter, p_ev);
+
+		free(p_ev);
+	} else {
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
+		 sizeof(ev) + ev.eir_len, &ev);
+	}
 
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
 								connected) {
-- 
2.45.2

