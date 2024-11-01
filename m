Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67744156649
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449445; cv=fail; b=kUlvcbiLEItKwxXFz2XN362C5cKmJOMVyiyPdus0gUfOCWXbsjPvkmQVOty7eJP1SRko7mHwTBvudD+DYH35FPjFgHOrc6nMTMnEFTS9ETsoX2Snz0wmyQJWKx2CobtK6lSY5ycLcK9NTfq+/8D9fRxfENiS3MQPpkHaVio7K4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449445; c=relaxed/simple;
	bh=2nbQe7PhmP0V1izv4sk6VukJKT0rGtqWx3VmSfxsmFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OleY6iIP6NtDFkghcmqnF4TuzAwgv9gX8DSP+vVNRSrG93NZfWYdxe7A7wIkWjTRXKgtTquYjfEiOiTAUK39sGTp0PTsWQ0CMz7wveAof9Y9zKr4j5/7i4qTDm7bqmLaYy4WM/iQamGvio7mhtb2HsQ1m6H14rpoYe2KOA7ee48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JFmRlUj2; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFmRlUj2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ8Amj8O8CB+V3fDwFL3PgFMPoXYPNB875wNrNgwn/eQvaZBzGusFL+ROHntm/aW38UcgB+WX5He3I9fQtq/9WQ0lYUKTxHWzPlkRIFi8vkrI2uaNgIzWrbwgB+P52JYW6MfH2Ezftv6oA9NIVxIDx/kJUyFJJ9dOEwyjrfLyKqSH2hpB28o5e+wf8pFRnApPhZKD9JW7ehruNq+fXrK/+XwgwAPEN9WnfiaUyCjxJYetYgAU+LkacBevwREdk0hWwwVDnZm+q3n/M0XxZvJDyNlbBWwzba1xXse0C7HqfLBx8gDXCH1hZJfAwmmUm6pwdPKL++O7UiN8yCiWLDASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPBWbxWrL+D7/AOru3o9GR6zU8kwbeKEMSr1Hztpxb0=;
 b=rMy28NITxxP4SNbDn0g/Cn7QD6mHMdD1Xz50hD+29hcofXAm0jBaX7WWMOgc7CD9LtENFzRbElI470kP4WBqIZNkrbss7++VwzQOJ2cZN7Ntt9VEWljVxqfbeYgFsQjLoJNeowTGTEwWLsHB1kkfGlVHK1VElVhrcbHLrIY9FDZEys5mFkK33aIUZ2LZmHXlzJmp4d7gVD5/azkDzmUgj1VhP1jBPZ6nyGxnmr5IzIvk2KebaOoTXnaICYNbynzmdTG/D2vYkKSdwi7wgyDnHWyTLSfd+yfDKzIeaQRcM/KlVVNUncLRUbLmP6ZW7as8EpNxrpRf0zaVcz7dcjBJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPBWbxWrL+D7/AOru3o9GR6zU8kwbeKEMSr1Hztpxb0=;
 b=JFmRlUj2SDI+CSDXTd6E9XWLr3LRmHodfT1JSUxyuYboP3XGq7UQtjZKuI2EALGuQs9L0b3AHoeuLMlVbde6NgUKcgHLHa+BwSwGb5cndL1iRyJ30odYVNGISJrUr1+SkAoWAfiS4MIHUMGo5qbE9UrP+YL9/EYPxzagIIu/uJ2XSbj1Pt53eQXK4Ha4SXqY3OtBzj4arIIR1bOHh1f5VvuYWclnEyjh0ytvANYSMahnRlrX0/+qFY5FC/rah9B140Q2RhGS8ArvG5now1EF6YsweD/WXra+cAAJUHbH1dFHFF8ZLO32oKjdz0pnyOIR03Ne+SlZAWaPiHqEOOQquA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 08:24:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:24:00 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/4] Bluetooth: ISO: Fix matching parent socket for BIS slave
Date: Fri,  1 Nov 2024 10:23:37 +0200
Message-ID: <20241101082339.4278-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f5f5ba-6853-41e1-6c56-08dcfa4e89a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V3vBdWhe0GQucD+cK9O8+fxid/ijGnsZUwKzH2hHN4fLY/e6iC6kCST++i/3?=
 =?us-ascii?Q?SMolij5IRq4kz34TGTCVbx77jL0MeFA3GG6++/H5mQQpW0Jtrt8tU5CPoStt?=
 =?us-ascii?Q?C5I5LgzDasPwt4YEWDb5mBy0emtK0bEK1ENEanHyQ5Cp9/v71DiUfsbGbENX?=
 =?us-ascii?Q?NosgG4z3T6/vqsdqhju1aCahGWj+cP2XDv280nNNA2hhLltDLH2y/zV7jB7v?=
 =?us-ascii?Q?Iq7oCm/REW6t4PdrsZMXMXHMW3uLTG4+NmyE7Xbq9OfOb9bypy//Jf5v3jwt?=
 =?us-ascii?Q?uh+HbwlAdkn3c3a2LKz2OMQNwEEC9yE7wyyK8R90FSTKHyQSwBoPjZB34cN/?=
 =?us-ascii?Q?YtQFGrmDiPmbMPm9HS6knrAjiMqtgZMU+Uhaa+JRCh0dZrNZq8Ikt+OWe6hY?=
 =?us-ascii?Q?czY+6uEr0Ax9qjfRzJwBiSUgS+36BXhgWRWIRElfv8Y3KuYfruJTcYFgvTMZ?=
 =?us-ascii?Q?ziBhT4g9p9yL5W1E3CLpipZqaZLUEaaqS3abJLrijmEnr0YbHFabEiwoDteF?=
 =?us-ascii?Q?zoEzOQo2CKlvqGngMhf+CxHkz4rKt2NTtEcZt+xDKscpn895jnypuhcer+VA?=
 =?us-ascii?Q?dpU1he5MLyx0pzEg7FoEewvVNVdbq8JCxGbxG4hMEW9NwDHhpy+ADlV1zKQH?=
 =?us-ascii?Q?nfUtOUHdw5OOtIPHDGjsMGjT2dOhQqS+HFbu0FTIZ6rzpBZjOV/s6WNUiDVo?=
 =?us-ascii?Q?rcGWjE49PE/4mgUV7EMZn/drw4In156a9PGwHUpDmnvVJWJXHmN90HEXrecB?=
 =?us-ascii?Q?6rzECM9m304CC6jr9KnFOtBwfAP20XSezAKBbsKwTqETGQ764+eMOuddk0Ad?=
 =?us-ascii?Q?4NrGjhaAUsSNN1vbSNMXKQzLhdhBNCo7G9abNMkSZZ0DCna8wU7C1zXohgpq?=
 =?us-ascii?Q?Osyz2A1+eoUNFs1tqfrudmHu8Y1As0dKqkw/WegFumZnTGlSmaCTH/9EBg4P?=
 =?us-ascii?Q?F1BC6hfxXvBStbhU6ZwQqpnkn3NLP9xwfKNxwJpATzYqkSQxD1UhQY84mWGY?=
 =?us-ascii?Q?SV9Pc8coD2m4eStPULj8jzUlZU9BRxtaX4IXL346j7UnhjiRRQ7H/SColdRp?=
 =?us-ascii?Q?Te7S/Dhi+7ghqYwMyEmjjkCaTazZTMuET2KaLnIPg7rMO2YkEC4k+mC6+0jT?=
 =?us-ascii?Q?ERQp/SlKfykVfN7ydorBQMmyOddpAyXs6VBz3z1u9CCSu+BkTPRrwn9Tg3R4?=
 =?us-ascii?Q?mucMjKd446+Fesnn+wjJkGfibwcN3Qwd3P/pc1E5SPsgplATkmS295zdCOYn?=
 =?us-ascii?Q?7RamJ0taDFIRSKPXBwZEnyVyqSIxpt/BgdLT6SaaOstifDWG6wHEZjkY9WSA?=
 =?us-ascii?Q?ntI1s6irb8RizIARf90au2sovcfmHgauDjDZ8eCvaLvZkEiJbs4DwxLuUqN/?=
 =?us-ascii?Q?1I32NuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tiwk1E78M0DHhPxkSvgRkBQGZ1OOMB7yR2azWPb3ce8Z5HAyj5JRfq4FdzJ?=
 =?us-ascii?Q?JB4sXhpWO1gwRVhZVPcykNJDcHRmfTevtLHEFCyv2saTGak8lViS5E3FpQPf?=
 =?us-ascii?Q?KiSmck30jaiGy6wAHdQ2Ir0rZp+6r+qDvOYAScD1L+erE95/YB4WgRw7m9BF?=
 =?us-ascii?Q?b3940fNEU1FxfdbtJnZvAbTJm+LvXlJ0XKTmHDiK01+YMGAeABe8+Erht/JA?=
 =?us-ascii?Q?D0Ibm8IU27nsTTGw2ApTdmLphRD3WSfE736e7ecohzGH3aWE4e9vWEdKXGa/?=
 =?us-ascii?Q?7CYpyQUY/zoeDhgSoGeaqQ5RXTbKpfUYEmcCUYOVdlYMHAge2VxeShzvoCbt?=
 =?us-ascii?Q?bVWRVeCKtzxvtyhsxFhgrdN3bXuKhROYX4jUTw+/UA55pGqNGYRKeHMw15fW?=
 =?us-ascii?Q?wZLBnMwUYt7OxD8Le+6MzQ5oEbZ7Sz6VbKAer2fieoqhuAMspk+YUlAQv7k6?=
 =?us-ascii?Q?pEhjdLbn+u+YxIBrtrRgn5SvGu1Em67d0aaUE7n3iDU6ylAQ4IZC3wcQZDPI?=
 =?us-ascii?Q?L9rpxD2BalzbwEC70BXo+7iqPEsYoC3y6eEi6MIGxXpLEwRbn58F87nCtXT8?=
 =?us-ascii?Q?GzWe4fjfwCZlWONGGUjN0d/gPIFSjO/SixVfzfj+C5Z4PpsReR4i5Pnqsuc5?=
 =?us-ascii?Q?sjmL7mWZsu6W6kUuRNl3ecv8hm52odGcyHyzgprW1Trx38slwejtXbkGzAFc?=
 =?us-ascii?Q?itMS2IXLluVVt3jEupU2L2EVzytzk+5EDlspgWsURMd9xsphVmnM2yubOyAX?=
 =?us-ascii?Q?+u/E1qk2OK8VaNnhXiWcmyUr2j/YkvjbgstZ45tg2+7AdFzU/9QjYPAThwwF?=
 =?us-ascii?Q?OhIhGoHRuSmkwh0012jdJK1AkW2bKjvAhSVEDaBem24i0KjgL44g4b2IyQEg?=
 =?us-ascii?Q?MMuMC7MX3dU+W/qC5thLapQgqFl+ifQ1Wye3bayd745jEgGwA3jlAgcmcLGB?=
 =?us-ascii?Q?rz8w5ShtIhAbfeAlsqTPnVxV3SBhNdPtKYtgUkRjQdBgEOv18ct0cvwwCzN0?=
 =?us-ascii?Q?3WzxWQaYoCUZHQ9NM42zb8FSV8SrvmYLBqg8pfoH1M7qkjKk+OYVn3WKzRY2?=
 =?us-ascii?Q?sw6vsh2qDqmA/gNmtPG2LPR4knEEOZ3gDdLcOsE4a3fq5M9qRTylSXIcjhwC?=
 =?us-ascii?Q?RSV/VlewoxHnH0v9lZwBT+GNtJ2H7mZf8zhkIarLIDByIqDi5v/0QMK+hW5k?=
 =?us-ascii?Q?VdoAtHyqllRyvwqt97c7+slj/MS0n4fiEnVMQRM7o8G+CobCr0yGevytcpGv?=
 =?us-ascii?Q?IkU2gZfQe1u6poRNqT1lKA2Si4kbY1WvXOQvNDGzj8OYigBd72qqlBZVxRgh?=
 =?us-ascii?Q?cJbkwuYXCAdZ6ens/Y3vj6tfxrfiMjT3hazrqS/HWr9YL/QWh7qzXtkz3jGE?=
 =?us-ascii?Q?Ewfo1Dd9iMoGsSplJ6yEhdAwA+J55QfLVsdgUxch4+F8oQrX81GJXfyHiSGm?=
 =?us-ascii?Q?gLq5wZ10Twrl8AwbR1L92fMmB+PVaRXCYhfCCht7q0oxE5qdQRlelRNGCHsf?=
 =?us-ascii?Q?uQDYMxRb7db5rzUQMiX2R0qq3m3vens3peHg1BvITI7MnYiDfMZCfWH5ZuS5?=
 =?us-ascii?Q?K2J+2JxjR3elDRwF10GIhSGDYNddWchqyg/3TPtiFedjmdGMWf0YqP007K4n?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f5f5ba-6853-41e1-6c56-08dcfa4e89a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:00.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLLdWEUlVZQxfikmgSUB9RiUEWBShh086JNu3KIELunJaNGaMW/UNeY5uKYArpG4lisxlrUqqN8WKjYC/wpoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

Currently, when a BIS slave connection is notified to the
ISO layer, the parent socket is tried to be matched by the
HCI_EVT_LE_BIG_SYNC_ESTABILISHED event. However, a BIS slave
connection is notified to the ISO layer after the Command
Complete for the LE Setup ISO Data Path command is received.
This causes the parent to be incorrectly matched if multiple
listen sockets are present.

This commit adds a fix by matching the parent based on the
BIG handle set in the notified connection.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7a83e400ac77..0d98cc16bbac 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1733,6 +1733,13 @@ static bool iso_match_big(struct sock *sk, void *data)
 	return ev->handle == iso_pi(sk)->qos.bcast.big;
 }
 
+static bool iso_match_big_hcon(struct sock *sk, void *data)
+{
+	struct hci_conn *hcon = data;
+
+	return hcon->iso_qos.bcast.big == iso_pi(sk)->qos.bcast.big;
+}
+
 static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
 {
 	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
@@ -1756,8 +1763,16 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!hcon)
 			return;
 
-		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
-		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
+			/* A BIS slave hcon is notified to the ISO layer
+			 * after the Command Complete for the LE Setup
+			 * ISO Data Path command is received. Get the
+			 * parent socket that matches the hcon BIG handle.
+			 */
+			parent = iso_get_sock(&hcon->src, &hcon->dst,
+					      BT_LISTEN, iso_match_big_hcon,
+					      hcon);
+		} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 			ev = hci_recv_event_data(hcon->hdev,
 						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
 
-- 
2.43.0

