Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39EFA55
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628888; cv=fail; b=OHyyDdsTg3jZBVpVyiCf1oDO6wAcmZde7dVwRUQSvo56obKlGSaOtL+k20YPXSvU6IOMsiLe2BX+Ad2bgMCAViV/JNaXqtIyg3M8S/9QJ+VS3QIdplYjIRhd2qZs6vwNNt3CXTn3gdfX2XSH4BTvSJBU06sGolg55jsB6CtjUU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628888; c=relaxed/simple;
	bh=nxSy6HEdUgAUNrfKaesDIPIUPnuhEzgRlznUtekUNfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WmJzs5laPUiQfahU2Q7LmVH3nIbQWKf8EfiwvgScc20cgvXAk/hxgSkT8WCOUV7sLAdsOV4RmxfM0n1+rj2khL9GnOONQwOj+Fc7Hoq+fs/nZnoz9CUB3TYqml1s+lRz55dVPtHpGqqqcm3HgG7Zb7EpLzxDeGTLQKjlgidce/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKbJGvHg; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKbJGvHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEUFhRBOGE57X+q8vIVtbBTKdKgaEZd+RjvvmNvB4tu3HiF2IreqYX0acwtrf/3aUBAjl5koICnijp2TF1Sk1EBGBp1Oo9Vm4nX/7eHn2rNqOpINo5I+vg6zJXBjI/dyTezmfp97cV06eKzdv2Y3Wfsr8hjaWl/mDk5P7zzeD+cD1MVotUqRA4RW+QYPwPpXpLYjrFNlya4tXaqAa/QLkchmpwu7ZgV8hn2VcsQis0htZxozR4WU/12OuW8Oy6+Y9jRJgnDwV4dGWKJAPCJEbncz74tbEeFrJ9wbMXyNWuVD+KvUdOwIGRYjLsQ7SjT1hv+f7Vq/60OW2dNxBoa4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Iw6M7/VmOiFt12DHlKaX/UPOLufwbSU0eivWofhLQ=;
 b=DkMU6+MtQvfuGdVEIqxfVfXtEwh88xIlZ1DBv+SjQzwfZBY/eKjiFzJZ/1zunzC/ol+vo2WcBsm7MbadEnA2rHl1q2AQnJehpbruRld1zR+fYGvV1iRvfU4EYcK+nO7Jy6nhRBhpyapiKemmDHQzL+6Hgs1p8he7swBweuYKf/2S/Z0QzTtkkZjktnkYLTFMVL71BMAhCne1Ohp11a3fE9w906ZHAackr5zXoxzvqAo/pmlhFmNQ92YyOgNdDFsaIKV1p3+onkDFSmVdifih2ZaVWTPShdstSljoH7KOnLL6tnxmQ0X5OYCm8SOln1HU71mG29yPGwrSVuwWpQChvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Iw6M7/VmOiFt12DHlKaX/UPOLufwbSU0eivWofhLQ=;
 b=UKbJGvHgzacZW1dabRcmQNkjJmJGQtkB9F1caoKCtrfS1tlbSSPFRnY3dT8At8i83HpxJ4BgEin3pKV4RwxVZ0qM+QGSGk5HxjzyO1+NOPL5P8RtqHbB7KwB/ugMbOjJY3YO11rTxgje8iEfBNHWXKQvRP1NQdm9fb+p5/HsLkywaKoRCeG9NmJSfAIOcE7/NnUabvElvNDV6SWL5e5xpHOMln29xkoKCrkhcjpdDBD1NauZHtCasx79ncSUteTWfks14E+8RCtt8Ti5CKl0WsKed9BnMNO/c8gvoZ2NZiY2eXqv6b6RaiAGpKjJ7FovPD1VV2D0L9zL72YEUm4qTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 08:01:23 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 08:01:23 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH 1/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Wed, 11 Jun 2025 11:00:44 +0300
Message-ID: <20250611080044.26730-2-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250611080044.26730-1-adrian-constantin.dudau@nxp.com>
References: <20250611080044.26730-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::10) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c282b3-ef70-4283-9156-08dda8be2837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B5ah7R6Qgvz2Q5b2YsGIp84ezwLTfkm2CxlndjzInOEAxVb1gOjJm2fzf/75?=
 =?us-ascii?Q?l9XPXOjtlM9O8IIFH3/3ihM6vuZprHQIn+/zzfCjoC06WseqxcKQPXduEzIK?=
 =?us-ascii?Q?wmiz9kO8Et60SVCMUfZHPNhWbcClFaNteo7n9tafp8B0JCEXP19VS/8yJ6l0?=
 =?us-ascii?Q?qzBsg+16a6zhjetkDgvr6izszhOXPVUp8S9wOYx7lmcIQuuoK1JD6ZJOdeQ4?=
 =?us-ascii?Q?qHh9hlC96Z9/IL2E5JvH8mNsT9G8TDE7S/ywXJHr520omw/ubOco8Q7CYDaA?=
 =?us-ascii?Q?3RGnkk8uB4ojoHKdadz8Z3vZMq0YDxI1oiy6XFw+NdXmlrgXajIR9S5S/j56?=
 =?us-ascii?Q?pIN7YT/vM1rAaPpUJdmeKd4Nx1uH1/13r8pBCtuUkZN6VzThKrGcuu1cCuvt?=
 =?us-ascii?Q?yE0wUQSWCvj1kU3K3a4jY+AREHikneReGlt3SwMOGODKV+ovQuw+DKNLefo6?=
 =?us-ascii?Q?SSJFpQ0mSW+leN/J2qAieXd7Unxvl5+BB9CVL9+lmnrgq3kFDCfwVRNsny5W?=
 =?us-ascii?Q?98eFLr1vgRQ/vIra8kvnaJbAVOm+N37PmEbhunhtov48MTwB/xPD//R5Ujjo?=
 =?us-ascii?Q?R7Q0iq49mvFtjuOb3xSrK//OYbeywpeOYU1hB6SA5scW1dhIlUPVeJo78RVA?=
 =?us-ascii?Q?YVWfecseMy6/XFebdww1oamksEnPwwiN3LnkZz+2M/xW1xPGr9fP6KxDL+5C?=
 =?us-ascii?Q?QibNhN7G6sb5n/BVsVWuX9xKxSO8fqwTPuXL1aMctOWkzNVHEiIX8B5vmSIr?=
 =?us-ascii?Q?BsnxBEfy2jTAuypAS53az+3wTR+XCBpXLiuRfV1Aaw3gwXJL7K8Fgl/yw4tc?=
 =?us-ascii?Q?ca7g9pS8yNwmLccDeWE4XWSWAHeLXtmErUHyWf0E2z5B5K1BnyVWBlMvfXOp?=
 =?us-ascii?Q?b0DiIaCsmPfKtdASJvnxvCoNYjF7FE0TS8YAv55DJ/i4unZN3XqYcgUx9eKd?=
 =?us-ascii?Q?1eVB0HE2G2iebAdfH7wEmAAqosvhJObJUQLQ+hIxj8XeicgSjR/GMRdVxbLJ?=
 =?us-ascii?Q?Xl0C1td0vKd6kdZvLNjCDNi11sz3hS9brajmhxk01NliucuHjJMnuew9hPM8?=
 =?us-ascii?Q?UJbM8iNhowh9bYbnfr+FznAMggDyjdllUegTx8Y6qA28OiNniviz94SenMoc?=
 =?us-ascii?Q?U0lb8T0A/oSv/yE/G/7tSxjb37G7PUkuXyjDpKXmRt6vVbbYpdt8tUEpy21z?=
 =?us-ascii?Q?IVUZdlARwRPkHfVs1XojfPfryJ2NZIdNzerCJh3KHr/bP4WEZHq9w6H0QbjI?=
 =?us-ascii?Q?dFRnbF7NpEJEVyB9wA5NvLuEWW9ys56lXYSqjlqqH86np29baeB0Q95Ghibs?=
 =?us-ascii?Q?ZPOwbn3XjuaHlSHZ8c6Rw/DjvX2C/pUtWGJMj+ThJmV5TO+1mMqg2fmHvwKC?=
 =?us-ascii?Q?UxBa3510IcLVdfeXzUeMef1IYPZZn9YltKHlWypV09y8bhIzplrL9DU3lT8X?=
 =?us-ascii?Q?WKAfC0Oqt/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeyMuhdKI+LFl9upKHdb/9E9w1D67YHzl7/cEkNNpiHaRK1ckDvUUa0Evjov?=
 =?us-ascii?Q?efBR8kT3NL5nJiMx8JVKcO1KwY4u3JlHbSJ14AyGUSUFDqU4Z8fA4bT+k4hZ?=
 =?us-ascii?Q?CKi3wcH0Wc7TntbBG3lNqPHYUf4VDC/FGlNcDwRL/qdd1OjTrMr+rJwRpag8?=
 =?us-ascii?Q?od10pXgh4mj6PQBNyaEUgT8aq2RVjbGPqeQ6tskFGXoZ7tkm0FD2NQrmMm2O?=
 =?us-ascii?Q?RmjAa4SEAwXx/79K2JeHl7XvQnou1fMdJCjpRzdjtOcSBG9R/YXbHv/Aypl9?=
 =?us-ascii?Q?DbH4iuruLb0Vm11ZT5SiVPsteKeL08CSGbC1dlAPzgRMRVYG7OqkUWdd0DR0?=
 =?us-ascii?Q?omDY7B2kmSiwQ7rDxhSnJ6Gr+aYFu2xZWF4IGA0CUrYmKo5KPOkdKsCA6oaE?=
 =?us-ascii?Q?N/8GiYy7du93idx40CE1ARC637LkMTCw62afBqCff2TFjwJtNRkuNqiJ4OiZ?=
 =?us-ascii?Q?mnJKLCTxuom/T8t1Mojv3tQxsUP37P2+L/R7Tp7xdGS+vJUSmXWu5cZaRege?=
 =?us-ascii?Q?c9V6/7qVK3HQfr3B212cmpYGjpSXF+Bu8w+ioxUm1UKXmHD7VRzVb1RxVMyX?=
 =?us-ascii?Q?NwimGmA1/z16I0c4W5HsfjAfdJtuPixWmdugGVNUpePC/g42jqyP3k4GgjZF?=
 =?us-ascii?Q?f0HImKZ0m96WFIk7siBg+S8SRJqtGMHSjdp5x8ugEjBhq5aeZOCQtOEkgR1x?=
 =?us-ascii?Q?pJPPv5if+/WmjB+Fh6flDxD4t/A0WljbaMlZgZVKweokEkh5wkVzKqXVufQR?=
 =?us-ascii?Q?+XqQueUn87hkihXZEV09A1TAiUM+N5HVAO/3u2NJIbGi4ixJM4GxUzNVQyp7?=
 =?us-ascii?Q?9Zny1DzrcYSZ1tgj4wolaS/hUwE+y4QIDhfj3Niy1hESeTwlKk7kJwoj0c+M?=
 =?us-ascii?Q?FDv99uk2gYxi8SWUs2rZWkOZmj8Gj2mtR875w9Za0HgVTMyj1gqXncYukWxr?=
 =?us-ascii?Q?l3vixZQ0tpjGxNXs4BYMK76A6ARpf0Gwny+MXYwKI8HBirDEuLF+BJ0EdVrl?=
 =?us-ascii?Q?Jy+HVFMtPXyDLxpsSsIG23CO/daLSM/e9CB40t6mekEmNCpTH9n9/gFruA5p?=
 =?us-ascii?Q?GgUhScTc1Ghk5cfL0m97FwmCG1vwkLjYREBlwH8PrDpiFzXDp/H/bH7d2xHF?=
 =?us-ascii?Q?YAttVPOjKLHim0dhDbMRlx2f60xvCT0z5Ti2OxjZEKWCm8Hfr4aUX5mNlX76?=
 =?us-ascii?Q?Tb8jZPmPveoPtQeFbhfhlJQM8ksTYauNeH4/669f27esNHxbfz0gyRbQMKzA?=
 =?us-ascii?Q?D0vglahEy1C8tfew3omNxBT9hSIt2RL5A0x8wkENUxTVYkV8D3L+kl6onljl?=
 =?us-ascii?Q?uf90khjwsBbBh/Da5W1yq4XThT0Wsnc1D3AJ+4P+0SDgYNZMtNviNdboFZAj?=
 =?us-ascii?Q?1wROi3Bg6Hp3Ezr6FxlphHz45+DkQuYCrn+Ei0L3tDzaIjV5qerji/u0poVm?=
 =?us-ascii?Q?v29qjQ0S6i3x53nKGukPuOqz7lUY6JICmtFGFnn1ez6T/XA2OBwr2tsmCbco?=
 =?us-ascii?Q?aQZcKg2KfPUh1GK8Cg1qLg3Q8ddm1yP4yZ90oSxHqNiO89mYZwLXhRRZA2Fz?=
 =?us-ascii?Q?qpBNtdck1drx2ozF8OSBtwZRoJLLWnML1HsJfFVd7diNhyzE59kS9MfqHzAk?=
 =?us-ascii?Q?pQINdY5JYPyc0CsaqjPYIsY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c282b3-ef70-4283-9156-08dda8be2837
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 08:01:23.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4S1ca3/6ukB7yQaIg3OJkuLDoVPA0Ku8cMModLO0QFuHKWTExgeG0orsyzxlxuivTg6KP8wBY/nm9o+YzLK7Tk0tHxnkEh2ACdQW9VNqVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

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

