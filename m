Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAC18E041
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925174; cv=fail; b=jH7VAD5UGpWo0bln48tDa4mI5NCVqhquAyxgJdJ9LXiDcllllHVs/CQNlKteUwAQSr8CaNfvN6djl6B/AyVRLtcwF+r+cc7exaI8DYRFJKPckjT4N42CuflZ0gBLQNScUlF3i4L2pV3qlCBqJxjK7I4VhJcJusRE2w10r7/z/PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925174; c=relaxed/simple;
	bh=rJ3EvRKsw8u5Pplp12/DuA6GIw9y8cdjcM+1ss2FTqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0JX9epSeDBYoNXpY9zAM2pvmFLy5e/GNoQL5dBLlM/dkHZDGvnfiIwaAtkAETvRtlq9vZSKnxUoEnP/v7QNglS1dJhomFNXxmcBzIupzFiuNPDIrL9SzWzxpRjh8KDRtompZOjsYQIJ37UoPxKsFztjSRKsdHVdgDiCam+VSGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XqKo9pbM; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqKo9pbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQms1mK7DkJpsLcYUnrxSElyjH0dmhWYQ1SuQihppCuUS8yVjGBQIuh5iMveybOMoD1AKyVcO+TgXKRs6vwlc03no/3tFQh6AGGfnbnvKKkAQwmcphRrh3iR+JGWbC4tak+/7zT5bkAmsDajZl71brWZ19skJHXrA8dnubmEzzoiFib9PkMUREDC6AsUaTPbblax8YY3GRSxdXb6rQjsK8gufGr3kvcGp8TL8p+kVFl7Obcr/jynXzqdjHshreFqNFnatgPQhocfAapiSwJaLad+BOQ2rMGIlza1wx3jZPpn7tpY0JpHbmv9oAZdIz9YQcl1LPpzbrebIFolJ0od6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55NUroQtZB8/uKmFYWoyR7iVmGqDZiLtyA+wZoMZkFg=;
 b=qZ5DtVv46Xp9ELye0ENaXyl8VCJ2uYAlG7iAJbsDAeQCzIyQ3Qd42xxmDm4mh+DsRayPcPvOIMlaJ2NCxLdzQzrD9pcweNBVDs0F+y+PZnm7AxMUF0Iwu6DShcAMadeyHetsoUoWRkTc4H54OJu1vvIIZ8XXoM9H7JsRle2lZ9VWFPR1T03SCaa75a4caQeLVfWRRKUbsCbPh2/V1RJEF7WExPbA/0Jz8a6TjSZoBW6qk9S2TDGJaUma8Qjmy6LEZxxev41AIRjE5xDR9ZH7oVBEqb83Q/x2SukENixzLjpVqY6dYQUGc/mew08mdezwpsdVwbUw0aOBwkxYbzAkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55NUroQtZB8/uKmFYWoyR7iVmGqDZiLtyA+wZoMZkFg=;
 b=XqKo9pbMcIFS3nUVjaTbWzmy1+ETjJfZbf0qxpWG++tMIPwGUF9Mj4Giu8fuFtd6u/puBgoADuHvgCB6ajXASnjfFxadS15EDk8+b5fXU07Y5W9tg4nGEGcKzooh+LfcuoP9nxyqx5yvV0hoGgP9jbm7P3HDzrBjCoFZ3pyEYDJrBNmw+lrl8iZBhXMuo8SjnmkU5ViNii1QEgdJbOrHeDppTJQeiztAgo/0PNWeiddhhqfOmyIjO8RqWAOstYn9A5X2OXgDuGvbIQSzOyU9YLDfWHNekIOKCG3YvgfsWSiwWA5N9V2mA3phHB7tqddNlkJ99kF9Rp5CoPCTMvCCzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:48 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:48 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 7/8] client/player: Prompt the user to enter the bcode
Date: Thu, 29 Aug 2024 12:52:05 +0300
Message-Id: <20240829095206.91150-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 832845bb-715a-4245-9c82-08dcc81056b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPqbSjLGNm8htjAnLcB2AAf7jnem7pv0PhWYxoYdCVEoK7NnM0/uxoELpfc6?=
 =?us-ascii?Q?Z6DOzSdGzsSdSrmZBHoRHBKcDUKcObv0zd/fYpbA7VbkBOmokxYvSeBmD8aI?=
 =?us-ascii?Q?kIWOZYIEtYH6NS0DIT00O2ABRBvf536PEHnx9LEfe0WSN0vyqT/Q2piFB0Qx?=
 =?us-ascii?Q?eEgaV+oKiItIKZbHj507M58Wd5tTpMqRxx3xvyo9NJybA5l/7gfTDsHrG6a1?=
 =?us-ascii?Q?S544FeTQsmFSK8aejGg3v8NSmGEMqdZ9Rw2eWThdVjUnCt4vlA9MPhxhu3d8?=
 =?us-ascii?Q?gKNnfkV+a/bB32jT2K4ZRM6qwxIGvsPwF8ehvoNjmM2BtX7P/Fn/XFPTdpYc?=
 =?us-ascii?Q?ogHCeD78Rk2Jmvr+j0+gIEIihRA8nB0Yd002J3iMUusSLPX+ZfhH7PBiCFr3?=
 =?us-ascii?Q?KZFuGQaQG44Ulisk3FAdF9Ej/UrZW7J5vpaHfykxVW0Nd70eCCbhPLXSkxDF?=
 =?us-ascii?Q?c2QrwBRrPGh8Uz98dIkcm+Kgz8Ovs6lCMmpmfciQ4BZ6c8VWtG5usRXcMRDV?=
 =?us-ascii?Q?3nGcyuZkU2Ia4hnZIkjZV+9qaz6nvmAwSLYdazB5790KzJUYio66hPwAnuys?=
 =?us-ascii?Q?3ywPXqWLL3ODBzTLUtOPgPuBKCAbAQLmFdHo4NsT2TLeW2WktsPTPowtUbTl?=
 =?us-ascii?Q?0harAgQ1pQG+rVbLMePI8pwfG0iw157s+T9B2OFw7HC9sjhNhrWMZdAxEy07?=
 =?us-ascii?Q?uHmEr8kArLe1N4EkPy3VB5m2C163HQJtuJb/M2f4MHefqLRLVTuvZTyxa4kV?=
 =?us-ascii?Q?Vw6/AcCa9ssmuaMZQpueM1wq2GuHwtrhzJ4A43d0zm/NDAnDUaitlBrCMNvh?=
 =?us-ascii?Q?eAlVjGuhxSW7FmLEChoOsVzhiqgJBAjcI67eFv53V6N56anxDQvsmPCVPLfD?=
 =?us-ascii?Q?b4DNi+aK9I5O7JG51krQobddBFRJvCgoGYmpV4EMTQnEh1naocaBBJ0s1xbh?=
 =?us-ascii?Q?P7N5tBn40NdwMpP0ud4YBH3h1tAMRTubk5RkEDXVO5o5m8Y4A8HlCybOl9dG?=
 =?us-ascii?Q?RqPSMfE3uB5W1iSBfrY7Q/nkKHv4ViId1RB18U+jQzF4tNLJsuBq9aeVEEZv?=
 =?us-ascii?Q?2+zHib7/EdPR8NnBy3+mQ894pB3keOw01iDDE09wNp3+LCR/kyqFkROJ2Obk?=
 =?us-ascii?Q?pxQN3dKl0kNs+oOtXLF1LBWAwcfhf+ZkLqRsk5ikj7TYfiuqSlXgOdeyKPaL?=
 =?us-ascii?Q?ob7COcVArDSdLBMa4xzGkUGNLy6DwmsnENCaX6o6dWnjssQF3jlDUnd7LE3X?=
 =?us-ascii?Q?gy8/xY3HgkBawSTEI54QapOsLLEEXaRmqgL84pPvGpkK3KBrf1Huqmp3SMWU?=
 =?us-ascii?Q?lFUNUiFCtVLYv/WN28ZwJ/7GcAw2JN2dyriipQFbmtCV+NM3SQ2SgxP95znk?=
 =?us-ascii?Q?bBLFk7+ICughyLn7/S1cqZwbRQJDbBR+Stbmu4xi7yJF2furHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MiQiMWPMnVN5fptv+x0X9CqvM1Vd7A93CE/5b6DkMsMgRmNBsWCgk8XdnFX2?=
 =?us-ascii?Q?em/cgUds09zIrEjq4NFqIplEYs2N+Rrec8jrAZwJkQfQfRB8bWyFpggTLwZy?=
 =?us-ascii?Q?x0qYQ/herutAf5RyAq9jMSXPeZtWjUMuOhFYQAZpdGWahalrs5ywdJl7KxVu?=
 =?us-ascii?Q?vChWfe9XSdqthZoDRU920NgR8Z7Ig57LSrY8fkquKQ7lrgrZS4fdr+0MUbnq?=
 =?us-ascii?Q?1aHNYHI+ioPOOE5uGy9MvfyR8IYP2n6JwlkGFA8sh3Yg0la759z0E2voqE+6?=
 =?us-ascii?Q?CikG4ARaa3bGp3ALFbrRTG3KFZ2uJs5ao16HU9JRBfveFki3ppO7gTU08ftY?=
 =?us-ascii?Q?bNxYu3fhefatG28z1SRhm7loQzLbh/7T+4FydaR4Vydorm4BFw2ZRU/pOidd?=
 =?us-ascii?Q?Uo6Z+CvdxyERDyCY7cPgKXhGWOk8nGA5h+s4n756Ev4kj0O4zUIDmvcn3Sb8?=
 =?us-ascii?Q?5MgMRlpqUYNuUf0QmP59HX9Wek3udQ7v7AKQir4Ci8ZC2zt89NG3OOixIifk?=
 =?us-ascii?Q?jnqgURi83NpI3AmaxhrIVbXbWsP2Zl8uE5VKZZEFofIaNebJppK7Fzj2DEoh?=
 =?us-ascii?Q?CyCmilxH2bXkVofP9DXF2IwYmtG81yU9hhCIamcjG0gnsUCPSXR000sQR3bw?=
 =?us-ascii?Q?KIW9A6RnPwsFdTde4ZXk38iZUwYxfmu3T212N0ObLFOEkmPJ4BfcWfJ/xGdE?=
 =?us-ascii?Q?ypk817RV1YXt4mQKffkhMZpr/yw4ay+8II9bTEl9X40OrO1b1fXO2f8oE/g6?=
 =?us-ascii?Q?ne7gukvNV7NK4IYAyHwX+KH4oP4XrvilESw0lfewrzCHcrEzF9eOb/REuhJT?=
 =?us-ascii?Q?tk122y1NjR++ZYsGDRAjmDFzqIOTA5938tB/8N0uAINp9E/XmdIaupcr2Rw+?=
 =?us-ascii?Q?TuP+ksFi4+L2d9YSBvpm55n3iu9BFJvIxvXRj3jAAY5TSySumy+xcgCKsvZr?=
 =?us-ascii?Q?egkSQss2/RJOat18PMZCxEoA4PK3idB7B3NAP57OYup47zTY0e1vdelpsiWK?=
 =?us-ascii?Q?YiBYYzsHddraW4ci9+EwO2dX8g3qOge9m7IiG76tl5MAhCnQA8qy95ITYOSk?=
 =?us-ascii?Q?HmaxmS7cvNU1q1n3Pdm/7zpl7fFSpIIcMKmRZqYPyrCTDDPhVSmyRJh7xdCx?=
 =?us-ascii?Q?18iqpNa9FosD4nrFXqToTCTdrcuamcjNThka94Yrf8YKOvqZ8QB/TQlIPtu4?=
 =?us-ascii?Q?28aHrbjzYgsg58BaB5sdZwdY4dvgoPgpuGnljFM8UPb8H5Z3kiuT5QCbYqHe?=
 =?us-ascii?Q?WXs3bZaG0V62Kk6ltIpBb+coTgk80KEivbGs1ys9XTA0xyDd5exJ2vpQCFQT?=
 =?us-ascii?Q?YOcrs4PENa8zTWL6+JlBhIb3qiIVuniwasxQeDVc4nLvbomipMgA5coLqM2L?=
 =?us-ascii?Q?Kvq5qIFSNNhP5uI44jpm2YEOQEjfttYaZjvssRD1L5KalI9l+7rMd1ORFiLj?=
 =?us-ascii?Q?WCgdTUnJQzb8YRuOTDwsHGFnFTGUQy3GtgLCBs1N00nTqa/wVlGT4+2p0O5h?=
 =?us-ascii?Q?PbLzeTdwkv6p50ytciOiFlrMNX87N0Asy+ErCYEjFbARHQV/tF/nZSCiXnWq?=
 =?us-ascii?Q?6M8DvU+4UXeXqsIc7a4NViOTURF7Dlt0Hjgc30LK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832845bb-715a-4245-9c82-08dcc81056b7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:48.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FQbNZMb6YPW2q3W801NcFNvMWarjOeC1RTZJ2qjbbHMIBmItHsIxaZMpLO1dGmxer2b8O143SKn4+9u8eiHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

This adds support for entering the broadcast code on sink side. When
the user selects a transport, if the transport is encrypted, the user
will be prompted to enter the broadcast code before the process of
transport selection can continue.
---
 client/player.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/client/player.c b/client/player.c
index f1cd90966..eb944a560 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5022,8 +5022,67 @@ static void cmd_acquire_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void set_bcode_cb(const DBusError *error, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set broadcast code: %s\n",
+								error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Setting broadcast code succeeded\n");
+
+	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
+				select_reply, proxy, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void set_bcode(const char *input, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	char *bcode = g_strdup(input);
+
+	if (g_dbus_proxy_set_property_dict(proxy, "QoS",
+				set_bcode_cb, user_data,
+				NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+				strlen(bcode), bcode, NULL) == FALSE) {
+		bt_shell_printf("Setting broadcast code failed\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void transport_select(GDBusProxy *proxy, bool prompt)
 {
+	DBusMessageIter iter, array, entry, value;
+	unsigned char encryption;
+	const char *key;
+
+	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) !=
+						DBUS_TYPE_INVALID) {
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		if (!strcasecmp(key, "Encryption")) {
+			dbus_message_iter_next(&entry);
+			dbus_message_iter_recurse(&entry, &value);
+			dbus_message_iter_get_basic(&value, &encryption);
+			if (encryption == 1) {
+				bt_shell_prompt_input("",
+				"Enter broadcast code:", set_bcode, proxy);
+				return;
+			}
+			break;
+		}
+		dbus_message_iter_next(&array);
+	}
+
 	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
 					select_reply, proxy, NULL)) {
 		bt_shell_printf("Failed select transport\n");
-- 
2.40.1

