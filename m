Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF921D3F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343116; cv=fail; b=O/iGIO5Ad4X+6G0LOXzyUYdgcYd+pdT385rq94pwkoFJbMTS+wadK1yM+ZhvBeQ9s7XYzLPikWBmgTLzt8igCR3vGCTVe22haumwWkaOgJTlHuL6Y2EMVy/uwPZvMPFrSczjyD/gbvcv4XhBpc8xwy7OIjDbPmUgdOvFRSWV0UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343116; c=relaxed/simple;
	bh=8HJDNOC6JXHP1+n7GXvRGyJwNhoDpch3JAT4OtphYhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mmwli7DhE35bvcXZUnzGjX7fWOgC77UDpODrT8ox5NWt1H5XYdraH+UNoFWryHEv6Exm/1rGNgkdIZ81MyOdVuYAF/Sdl7G8e9GjX6lHa1FltHSOZI5s3/52fDdnJet+aOfB5/Agrx+adnxFJME4m6RXUrBjsfGGP6rgQ/0a4jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jO9xiEnu; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jO9xiEnu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToaJMmkKnL4jcIbUBVFE4Us2aQuWSI+6jPUqWyTQundwquwuoAXnmn1ltFxw6zWst5whGjH7bRZy+cX/9RSRZSmZtDZS6RVkwMLFyPIG1FaEFGrrKLYFukEfdvRD+9OvN8VbzbE76yKBa3TU11yCgr8xFcMRJdWvcEb70EEqPCOtc17B1RkdL3mjv1X6kOUnTTmMIxZKYOx0OKPMfG/zxSIxH3yEffIvUQ8xej81ZM+Q1a1WIsiQJTCR5nmADxm+MH+j93tmt0cDuHqv5A/vKPFBjwxUZ6sxWg+5Z4dBHk7zNELkJb0gSZdrThRZcAQdORtly7UjSG9Y21RTXP1UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDl3h39kQL7nDp4ey+LDyE/hpkgHZ5O/f7EYPUTZSoY=;
 b=o3iEemuWZtCtvCuOiWWMN/azOoF/EOrgOLN+LPAeKVPGAddLwamecDzOZZKY7wRCGgSkQGuDdKdKQA9K5IrK2RlgCu3i+9hSZl4wPn76waKd8zSEUDNHZfgqGnBMBBjgvASi2dC7lISKgxy2+hWaVEstIILGej0mRFXg2rfNWS6pg7/Y1y4JB2bARsn5x4tHtzWnYU6CLg2dhSQeNeF8Q2KcBGHIaYV20kdeVefFurALe66q9Sy1UvX/O/5CoFkTvIdCvo7OsjUrgLYnxubSdBVepEeWKmzZcWp98s1pAzOGG3jB5rl97OQ1RHcHPiW9GGXFrUQSgcqNikkF6APzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDl3h39kQL7nDp4ey+LDyE/hpkgHZ5O/f7EYPUTZSoY=;
 b=jO9xiEnuaRq5zHYSXiVi0XMsZjpOtcwI7sbhUZdM5bISSJLOwGpNcgIwmlnY8Lo2VYXMtHFb6vHs0PZp0RpIHwaplGZmIkGn1p60HyaQgGgSlEG9uCULS0t3wG3lIOIbgF2/TNB3LuCeIv3EHIOHafJk9TS0YqYSF5LFac8sN2rZutGGPBmK60NOpUTgkh6QgN5L0tldXb7Yv8VFo6+BabUg3w9pyFjgVb3jCMd9WeuSFXGuIGlOukiLGoBMbmhyjL0cMREroBE51BE2qwmJT0qqPi4Q24NNS6i8shIyL1URfDU0uJ9zKitQfXyrpoKAel1xbzGicyAViZrVNOQEug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 14:25:08 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:25:08 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v2 1/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Thu, 19 Jun 2025 17:24:59 +0300
Message-ID: <20250619142459.7979-4-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
References: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::21) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d42e26-d7ad-4fc3-9540-08ddaf3d17d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LeUcJlSxKvMaCBpNWusvubyhdpi6pacrAir5vshg/vsdcxK5ACRNfugKCmud?=
 =?us-ascii?Q?eChTBAXbRy8Ctry7Yn5WsE1MxkSRgT6QCIROFAHh6fDQEVeJuOimfuKH+NmD?=
 =?us-ascii?Q?ZpO/r5WPS0cuYzyOD/ZPHderGKS+mJSsHD5VC0T1JEg3W2Pua2+va9LEJqMV?=
 =?us-ascii?Q?ZXLX9NH8TrTSPxtOxaU8sspCx+yMAbEMqFFUeqme6qbkvrAKT/uU1ZlDEdBi?=
 =?us-ascii?Q?8TheG1nH5x1sw0xI/TUn6ebGW+qkq0PV+2YpLZPTIE2BstCTpU2z8Ad9RZ6h?=
 =?us-ascii?Q?H8hu6Y0sMyL0MN4QuKj5XjvEYxzO6YxSPgARs7FtmRj4ivZxG5HhnF592k2a?=
 =?us-ascii?Q?OCQssIm1HnZIdqBvYdAFsSH8ESzNab0PCIj2FWCUzZY5kXzq3xRAMkcUCmvv?=
 =?us-ascii?Q?vmV6FSNTx/qjCdJTJRVUGeq8zFrrmBYBcPPrBleBdVb2QvRNT0uCXc5J63V/?=
 =?us-ascii?Q?9nTw2hONG5gZ+TVc650FGIg5xJnixwL18DvSZNcfUZ64rxmSu9GVZtL1HzzP?=
 =?us-ascii?Q?7c+O1DfoYmVRyHeuB1xu6kBDf2c1bsN/K/GFYQ7bGPMPHM2Qur6ZRiPERHdf?=
 =?us-ascii?Q?+J5jl7Ny3L2n/L1NoxR3CD+Vjbe8jy08mUHVCI/wwbTFL/6gLX7T24AiMN5p?=
 =?us-ascii?Q?rNnEQaQ/+2HeDrLLoewl9qHvAXF/FIy8J7OxtwP9hqBFZfvfPS716wqfI1NW?=
 =?us-ascii?Q?sOR4Y6/VYpNEbs7YBdZRyd3IvWJ1IljWU2NowSfUsRMyR9cOmuZ6xiyfOsRP?=
 =?us-ascii?Q?KotcNzZarv7+P0xHvaMfHHrrbQLS+o7j67fVQXLV++6qeh/DJdFydGD7dq6t?=
 =?us-ascii?Q?2LWcS5Wmgsp5lbE6BHHXs20rnA488azNj7uW4bwkuhVbQMoXDbZOq2V7W8zy?=
 =?us-ascii?Q?Z56wT21OLdgSvvhQUuNPDaZOdd767wak6kJKil1zfpVjHtDLwRBwSH2wCwWy?=
 =?us-ascii?Q?FozAXmS1rcc/KdMkLrY2q16qTNxnDiZJoT+RicKeF8pYgvdvDkS4+QcJRpOn?=
 =?us-ascii?Q?09MPpy78meWyShMLuQ2QOfZqD7S1swXkAAM5iHBV2wnyBjnhAji359CBf1GW?=
 =?us-ascii?Q?EWZO0wnBTlqZxlAW0xp7XpA3j0WubI1iWaS6cRlUewxm3tjwU3Hj+em+k4Vk?=
 =?us-ascii?Q?Q8ikyUJ8CuY3Pqdk8BKgYtlU3JyDttM5zKjxWtljvCBPn4S7Unua/ElChZUn?=
 =?us-ascii?Q?Efi3gxZFwqV3MNgCye+eZmR/+tQHz4Sk8905R7dsAyVtIs2aQQBEyDDH9yGK?=
 =?us-ascii?Q?pXt0iAQZkEGm6S0vfnwyrCYE3jhzWrECSSn8D0mazrrza7H3Ied8IeSc28ND?=
 =?us-ascii?Q?voT5Nmi0FCJ2+bRZ3n0PyB/sHZe1hgD6wiklSsUjtXrCcA1NeSVCERY/mi7P?=
 =?us-ascii?Q?jD39nH9Ri+zeZaDdkUwoCKGMzp1Dr8ig/ZpFveWXt73YmWWl0fgDvsURfE9J?=
 =?us-ascii?Q?UGhEvpVQyu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QIIRlixRJHvu2SbSK1iLvW7fuL9TJlYb2Wd810/QuibVRn7OVVWM0nbbZu7?=
 =?us-ascii?Q?IS6dkUJd8/m8lNEAO9KyEmjmbXFl/ql9dz7RntvwkzHyTevhKTYjVA86NX3h?=
 =?us-ascii?Q?VgPPYObBDLRknF8rx7gBFPQAbsO0XclVNIJwvdevWZPKNqxPfC5NFoOe5nLc?=
 =?us-ascii?Q?eREaTjrWoexZyGGPE1i7aigOv9Rdzxc3McoDvwwsM+0y5R98qehPRohgVUyL?=
 =?us-ascii?Q?w2b5iI5F5EJO7PXpQD0/HC+JdFJI28EjdU8NzSSQEEOyG8Wv2lQ3CeMEz8dQ?=
 =?us-ascii?Q?ybVYyullhOnBNOSo898YRNd9TnYvJLmDRwplKfKS66a/Qfbzj/h3jZ4dRncW?=
 =?us-ascii?Q?2z0ZB2mqWe3MvSEMBh71JQEHx1O18TJ8OCXXW/CbRoqpyqnbMB6GpeUGiBPN?=
 =?us-ascii?Q?AeF2DFrJrs1ms+t8+rsPXtB9e7A+mM2CeFqsAA6JccyPZ4m8j/LZsHy3qNww?=
 =?us-ascii?Q?dzDT31pQBpQCvODNB2p7x7pPnyIK7M1WQTg6h0QORDwrDgRt3CtOsbkFfwxQ?=
 =?us-ascii?Q?+WANnI6L78ZVorbLVC5U4KKag2EjEMMrrKgmMgcqZerB4GoLpdY9x7DE1sgM?=
 =?us-ascii?Q?AYrmSKAE7UVn7hbu0PazNhllr4NcEjdDbC+HFa+wnXVnuCplM+Tlsn73oEto?=
 =?us-ascii?Q?VibuH7RSfVFyoDvsLkkIaXOIS8bAAXqe8ElPPENNC/WNq/4KOmH6hhjQdsD7?=
 =?us-ascii?Q?oyAkxb8xmv2aEdALbfDg4Kvw2c0ikBzifBylHW5ldTuzGf/obPDtrjk0JSR1?=
 =?us-ascii?Q?Zgwwnm8FG7xw75Y4N+w4a36dP+aazsPITw8Rmep2uwyxEEmAJ0mBegVJ4wir?=
 =?us-ascii?Q?izcsz1I6+vxSZW6cgb6Q25xROfAV/nMtYWD1SMKlLDaZRUMvVOM+rqFr2dD/?=
 =?us-ascii?Q?0AalBTR5LRO5wyetHOeXAe+WFTSPyxP8+9+J2UhVF8bIbjLjhGHyyRc298lR?=
 =?us-ascii?Q?lZ6hFNg4CDmK+f4tQKOsvvcS8N8zc6hMXUP4w1mQa45/IeSs6459vdKH+mNz?=
 =?us-ascii?Q?vrjpjTcF0RkdSd7yhwuectcZCWnYbpR8QeStbGA82T8Z+RBi3YV/CNMj7yHB?=
 =?us-ascii?Q?uoYvaxowoF7jmDPVVPIlUNU7AnrffDlG8jLEZ27tBaNaoidPZy9b9TQVyx5u?=
 =?us-ascii?Q?n/fRdOpfoVTMNFRUEJ8xvYzO0WV2zXqtfAolJuOLWQ22QvXwKekPJIueEeq7?=
 =?us-ascii?Q?44I2pOe2XDvq75OhMjRgU6Gx8F3VFXa+cIdrtpUzjy7BbShMisKcKBhMiJ0m?=
 =?us-ascii?Q?FCaAQtEKaE9NwIYaEh/+r0iSvqBIb7NNFzTkz4fvNBQB+stnMs1GMZcXc/EF?=
 =?us-ascii?Q?3r04YaBJyqDAwUYAxm4tFEJSaS82oQrKM/AgEaJBvWiUvPWuL+W+lvwgRqIv?=
 =?us-ascii?Q?EKpJeQa1cSsKfOB83IQBNX+vpS/94Ka8WP6FjW455wU0OwBaEDAvqbVyczuw?=
 =?us-ascii?Q?rTNtCmtz06psiCjzG9kfP1dtNbjUf9CqcM8ddDjFmhpCHgBN9OBXgZM7ZsQM?=
 =?us-ascii?Q?apXQ4Gb0tMQ2+ME7kJFEbvvaeLU1VDV+aoKIzDN/E0MkxfbudyIcGPPu7rpM?=
 =?us-ascii?Q?zTIwsKmenDaccVpT/SSRzRzEaUFDEnmyRUhNe//t6KF4sifg1nyguVnebqGH?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d42e26-d7ad-4fc3-9540-08ddaf3d17d7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:25:08.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YxZ/L8EbdRLNS3SeeY6YzuEoF7NxFnmj0jvrYIyM5ViOpNhVkhGwcGMAxOU4mlP19PC8Y4mCFdA9o5ss54yNjlrNhEH5U5rnG1f8NgLiC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
---
 tools/btpclient.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 055270edb51b..5d5a7ea4a2ae 100644
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
+	const uint8_t *data = NULL; /* AD Data will be stored here */
+	uint32_t len = 0U; /* Length of the AD Data buffer */
+	uint32_t eir_counter = 0U; /* Count of AD Type, AD Length, AD Data */
+
+	ev.eir_len = 0U;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
 					str2ba(addr_str, &ev.address) < 0)
@@ -2538,11 +2549,90 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
 
-	/* TODO Add eir to device found event */
-	ev.eir_len = 0;
+	/* dict_iter will contain the variant for AdvertisingData */
+	if (l_dbus_proxy_get_property(proxy,
+					"AdvertisingData",
+					"a{yv}",
+					&dict_iter)) {
+		/* key will contain the AD Type,
+		 * variant_iter will contain the variant
+		 * for the current elem
+		 */
+		while (l_dbus_message_iter_next_entry(&dict_iter,
+							&key,
+							&variant_iter)) {
+			/* Unpack the variant to get the byte array */
+			if (!l_dbus_message_iter_get_variant(&variant_iter,
+								"ay",
+								&array_iter))
+				continue;
+
+			/* data contains AD Data,
+			 * len is the length excluding the AD Type
+			 */
+			if (!l_dbus_message_iter_get_fixed_array(&array_iter,
+									&data,
+									&len))
+				continue;
+
+			if (len <= 0U)
+				continue;
+
+			p_ev_temp = p_ev;
+
+			/* Allocate new buffer, recalculated to sustain new data
+			 * eir_counter length from previous data,
+			 * len is size for new data,
+			 * 2U (1Byte AD Type, 1Byte AD Length)
+			 */
+			p_ev = (struct btp_device_found_ev *)
+				l_malloc(sizeof(*p_ev) +
+				eir_counter + len + 2U);
+
+			if (!p_ev) {
+				p_ev = p_ev_temp;
+				break;
+			}
+
+			/* There is AD data elemets to be moved after resize */
+			if (p_ev_temp && eir_counter != 0U) {
+				memcpy(p_ev, p_ev_temp,
+					sizeof(*p_ev) +
+					eir_counter);
+				l_free(p_ev_temp);
+			} else {
+				memcpy(p_ev, &ev,
+					sizeof(ev));
+			}
+
+			/* Populate buffer with length */
+			p_ev->eir[eir_counter++] = len + 1U;
+			/* Populate buffer with AD Type */
+			p_ev->eir[eir_counter++] = key;
+
+			/* Move the data in the p_ev->eir
+			 * that will be sent via btp
+			 */
+			for (uint32_t i = 0U; i < len; i++)
+				p_ev->eir[eir_counter + i] = data[i];
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
-						sizeof(ev) + ev.eir_len, &ev);
+			eir_counter += len;
+		}
+	}
+
+	if (p_ev) {
+		p_ev->eir_len = eir_counter;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(*p_ev) + eir_counter,
+				p_ev);
+
+		l_free(p_ev);
+	} else {
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(ev) + ev.eir_len,
+				&ev);
+	}
 
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
 								connected) {
-- 
2.45.2

