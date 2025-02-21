Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235561E7C09
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155536; cv=fail; b=JIMYna/P6ST8ajA7xJcKzh7Kzv6tRaRmDeol8JIzqVXdE94xoZZrXuz/YhJsac1jXAnVyehlFOZkLiE2evUs/mxa3puyq0+ghlTD5/S2sjDNZmQTEgzLYni6zqdOcIembbpA9P3kUpAXd69s0tYuKqlHwhfeUcMyk9su8vrhRjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155536; c=relaxed/simple;
	bh=0jjss6nS620tLy7jkvPmqlQlawuy7v51w8rCTzp8i4A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TELEaB2rk73ax909z6koZCUpcU6XkZUYh7aZtKXZqdXfqQ/ysFt22NIsSyxxVnqvd6n8luw8R73QtfnW5jGphEcpHQUlALbiKa3w7RttDDy7Vb08L1ni/U65+qzlDlDGYi8mVtNLgOfGhy+v/ttdJR5O3CkJDgnLvywjuWJmDVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITDO2ATc; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITDO2ATc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5fSLVVYrZ8ku+kpPOXK4g7fQRImkkODl2TtguPZYKl1EAQBFDpy0DRgus9qwh4bn/IwOvsQI/fX48XOPClS0QYyAkEcAUpCM7hP1Gt+0+y9mFl1oAWszib5ePHSYL8Jidv2VJU9TVOmABaa5WdrC4tkMmx94UhxJdmgRCh2SBQ0NAWyk8TyzKywFPJwtNzzG2eKiVTWkO9jcgUgp89z04sNn9ac5nxWlyjATqPhIMq4jLiwpVr4WsRV/RxZd7R0MAByh0fj4G/GZ45/eq5RlXyeVEfXTjIDWoD6Yf73X+B3Gacjq4Up9NPB45I4FrJq6GHVoNyJRJUkyx2eOVW6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6EgkcshiGoEF8K1A2EPIMlrTvI1nPlbuSS6S2WLEjM=;
 b=KJmwsqVETOaHhQvV5/Jdk35lUrwk7UImot+PQopxgVlWbtMAQDtzETrKMtmhaKZJvgbZ6MZwTvfOQsG/sUe/aDQKbPgHBZQKWLj8/+hH5x+JsuRtV7ALsnABRnBM0YxLMlQBcAnD1P7VZGgbFNcsIA54WhDeODrOYsFrioQnFyqofuEXYR49WsQE1xRk0+aPWITn8kqIe7PL1TIdpCksoUi1q+W4yY2+soyL5gxpCqa7V8nUnc9GHxRgDRB7zuC2fr4Vm9gjYlWujtt6wb9nvHpRWUHYwgl4R3aXsvoM8YxleIIM1shb4gKFXY6T6aQvTdhASsd00QloK4qv3b/Q5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6EgkcshiGoEF8K1A2EPIMlrTvI1nPlbuSS6S2WLEjM=;
 b=ITDO2ATcmFQrBS+MnSmGVxLoy2mxqUSOOmzP7XdLjclNe5q/869xjw0hUSZFnKt2vIkaRckyrwNDEHFjmwksSwcGKt6wEX3a/sHUFkWiSM555+WyLlCMf+KkbYyqbKb5mSh6bKsuo6++3C9HiNuT96Zq4/bFt2YGqUHgAj2AYGxHPUhw80qW2quWx5uxp+OYhMsJjDxdXiiyD+j46/Ab6LUkPd0a+Wu+z6QVH84Sxvtq4v7hwTNgSLCJTkLcwZntZ4kDLthuIDAyVM98yIsvIrxUN7/f1l2NWYoXkgUE88ipd/OjSJs35LdtffpI2r5EoK3u5WPpNGjJNkrDwg53YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AS8PR04MB8152.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:32:09 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:32:09 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com,
	iulia.tanasescu@nxp.com,
	mihai-octavian.urzica@nxp.com
Subject: [PATCH BlueZ v1 0/1] shared/gatt-db: Fix incorrect attribute type 
Date: Fri, 21 Feb 2025 22:01:38 +0530
Message-ID: <20250221163139.1705-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|AS8PR04MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: b85fd712-bfdd-403f-6fd4-08dd52954984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRpdvJ6RWwu33Rho8mVhcaYxB1zWsaNbJ9FxxR6E5s1Bn+j2zdRx6FBQSv+z?=
 =?us-ascii?Q?IS3XmsjfYkEsGDbiMe8ule6hYOHmCo9CZbSOzBpAW66kU1PpuuWuZ9pXjRVW?=
 =?us-ascii?Q?uCNkZZV56LOTOhW0nX8PlH3WfoAe9xBkUutAaPd3V5PrYbPcc92yxBW7tuqz?=
 =?us-ascii?Q?UnH6QAYEj2ZtAA9LFLfjpsa789PGGNkeGbdmg/ixQN+sGhjDZxjv1OWQ+Tjb?=
 =?us-ascii?Q?HutqlsEkGhRppQHBhjpjX7vEUFw030rPNg+Hvh1qhr/lzld6k4KcMEd7OQAd?=
 =?us-ascii?Q?VOR3OQh9MRwdRs5rfcAmKeWTP4TsBt8Bh6h3EG2KeA5o37dysJtGP8IKlCSw?=
 =?us-ascii?Q?SPOguJqUHK0ax0mgWVP3ZQpyw+fuWXQnLq3FIITmpyhhaFfBJQxZi2bm4BRW?=
 =?us-ascii?Q?JoQeLwzgBQtlNeVZYMinjpxjc9d8QpbQJ6zsg+bSkbUFr9DPe9WRCSC34nvQ?=
 =?us-ascii?Q?47bmutpPd0oTs/0DDfDAexTHR1PSfLgFXJ5Dr5PsQzNbarVaPPVpM8TOXP5q?=
 =?us-ascii?Q?vdnN7VkzEf14y+XlrNoMid2RQbjkva7VcY17J79cxpPpOH3MfZmfAHdMJRAr?=
 =?us-ascii?Q?DmZqqogqjjB2mcvyVQ1d7gYCmjokBr57QxR85pBu2s6Rso+A/l4GSWf2FUIr?=
 =?us-ascii?Q?Z26z3H8nxnBSTrqo0PaW+dgCsKmDH8C/7mQieDVOj2ui+8wwuGhfGssScbao?=
 =?us-ascii?Q?MGbuk4kW+lwcOQYeWsYREtEGCis+0gIwP/+VL6FXYe7KhA1rI4vzD+KBQXwD?=
 =?us-ascii?Q?LVSnJrXy2PI0mBi5vtLfF+xRQ//KTGwaq6zfdZzeD82thjrw8JFqiZIpUvbJ?=
 =?us-ascii?Q?fm1kiSbRsBPJ0RkwqofZy+nyoS8MPmpDz+pIVZZwdnvuJST/AnAhSa5w8ec1?=
 =?us-ascii?Q?fU/WdNR63pvcvuatAVXQQvkAQ31/GTcNwb7ko1+vFi1z6bL7VgkarpdKk4qZ?=
 =?us-ascii?Q?KGK3u4H3EzmX9ZSXoGYeIt+jhFSVIF+4uHZmmRY+mlwyJs3u2ph3HNZHwtyz?=
 =?us-ascii?Q?PRWvdQwbmbQpZz+CNdFFd5EQFlzKUL2PdbeEDkgwUeS6iBUuE7sbMr+6mGDu?=
 =?us-ascii?Q?JH74x8edkaal0DzN4EunYu4RsNoFVcVLu6Zpm8jQOkWRnFLjsJfemduqbOHj?=
 =?us-ascii?Q?W8KaEQzRHxg3k3bvty7MNlb1Ie/71V/zqCQoVIxvSvwWOCvpOXOfEUn8ivb/?=
 =?us-ascii?Q?Tmi9kMac0NqG+ls4xP4EFXWW0bMwLsVCUfeFeChPjAqSNHhmUSq6eGiU0rBt?=
 =?us-ascii?Q?XTLdC4Xnsqf8K2QEnl0kk8WIXX4VxME87/KWJNKk7EsCk9uNWXl6HwWm9OzP?=
 =?us-ascii?Q?mHZN4rNgHyB1A+tU8cAl7az4xxIG6ZP6UQT/yrwTChTP3lGacCrGKfxUpOcE?=
 =?us-ascii?Q?2txl7g187VoS9zMcfEzlXo6N1x/nP1CRcRWW87b++14xTS3mFgvzlRGyiRc3?=
 =?us-ascii?Q?CddjlFiujRZaSkyo9jfYJHzKAgCjLpMf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHMH6fIIlNIqzNvzv52F9sFcU7ZTqKWcp/Gd0ZQBesKa0XL5DLHuGey0PlrQ?=
 =?us-ascii?Q?t7CFhetH+M88pSHPAWbQhR2ZyGYOtcUUGk3pBdQGEiESDtxcsaR+DtrZceUe?=
 =?us-ascii?Q?q5r2q8Q1IMH4QtElCmXHMTjmux5sfyxKVkjnVeftAUXnZTeIkMErGy/7EKlA?=
 =?us-ascii?Q?0UBvOJw7XzkhJ+Omjv4TNU5eAUlXVxf4sJUmoccg01zWuXw6CPP7OEuhgFz0?=
 =?us-ascii?Q?6Ru/1q1N4/58sAdS39AuXiZhJyOwxSB2aqg6GO+1gBw9fucLYUohoji5ao32?=
 =?us-ascii?Q?GDOj0ycLOR7bLgMwjz/cBFmQWjyExIofKHzvN98I/Se7FdTjUrXCeHFul0In?=
 =?us-ascii?Q?FtGJ9SzjxLlkOqBEou9jHyGllYqlb+VO7kE2CRCewYv8m2kNeP9GgGT0Wdlo?=
 =?us-ascii?Q?9Cad7/NvX86EA1UvdXOI7wuoCNfGDSnyHQuiSr2R3/NLZ12nC85hHjKeJNnd?=
 =?us-ascii?Q?K6b41UtrvjmZT+U6pyPx5QZG8IAmLHnu9qm5sPUF9vI7xGPzYJQyEwKgvML7?=
 =?us-ascii?Q?W73g8Ir0Sf4wpogPkZPVXMHEM5oTWHllEJ5rbLifsR8tHkKBNrRGwAbd5wqI?=
 =?us-ascii?Q?qFbucBWdgErZLEEGI2+K/Egf6b8/YivwWjGgqVrIETmXGv4SIOEGVc4jyYtz?=
 =?us-ascii?Q?y0f+LaMga5bew3FkxhhSZsvtmG+cxACN2eAMqNU5clVAX3cJzk3JhJe1kEu4?=
 =?us-ascii?Q?jF4yoUCcsl43ih6AAsbLHqfDmAL2RvQL6fGgTideTvb+1X6gpnNQvjyp/Z3T?=
 =?us-ascii?Q?fArcgcYfKGaqYi9OHOuNN6pAz0FmniYRecylEn6SVAMpnVK7EUPRrRknWgav?=
 =?us-ascii?Q?oTuyyLATx+0TOztwXuOBNq1BJlfxS8MvSq9lHn+73ipIsBByaaW9bZroDHdr?=
 =?us-ascii?Q?KQqkHJKitY73qvxizfygNLMvBULD11X0Ak4diprS28JFgNOlWE2juWVpHpW6?=
 =?us-ascii?Q?PB2IsLYpv6mn/XVX+dc/+k5cIzaO2XOS0vpsY2by0QD539zCO+69t68nLTrO?=
 =?us-ascii?Q?y/Z2TOs3xbR09fdJCCpg7RSl5V7FCZPFUq16idUtI+x/zZCWrFBszh4IHkCg?=
 =?us-ascii?Q?9Ppy+mrBj+xFj2xBV6dp11f/3fSxChAJDn8xG/DummI+O1fsU50L+a01rhMN?=
 =?us-ascii?Q?SfOQ0EvbubEy5zbWu2BKFkMaJHaqlWHybo87FYDjGkVg/PAj8KqLjHg/Hivb?=
 =?us-ascii?Q?PgblDNxPPdGNja8QoGFjvlM75EYEkood2EvSPmkslaQNxCeSjC2jHRkUf/SK?=
 =?us-ascii?Q?oe0nOO1AaTTEIJMnrtne3rLZVyLo4y7831CRln15LkSpubbslga2Ja8XFpgk?=
 =?us-ascii?Q?gmQFqhQLWnnQE9Q4P+pwVnsP79wKXQLRdetm58zgxSj+D5+mwV6BzqOsBato?=
 =?us-ascii?Q?TTTJ09hn9w+Uy89B2OfIAXEbA2xZLaj77+fItqC/MjqIuHJar7Kz6nsMShmk?=
 =?us-ascii?Q?x0DY1EguSJkeWSbC+XcJMHkB5TbHqZiaMX7aRdSaDuCPeNVle2MiawBa06K+?=
 =?us-ascii?Q?Bbrq/aAo98GdG4buoDxazkqcgIpvM4nfPAYZ3UUkaXeqfBoUtRbyjD9UpSW6?=
 =?us-ascii?Q?Pi7aPiUjFseyfPDtNytvfH19hzpMtn+tO3f6Shnk+u0ybhrGL0SpSWE7M3/Z?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85fd712-bfdd-403f-6fd4-08dd52954984
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:32:09.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCv77MwoJ4XjfMoqpAzfHXptSNXPfB0YSoqUiqvpshUml3luDkE0Vu1OYCvtlPnlh4+3qAjtQ3Hf0JdsGLWPSjYd/XPJy83Y46BCKhiMiaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8152

As part of BLE GATT Fuzzing testcase,if application sends an invalid
ATT_FIND_BY_TYPE_VALUE_REQ with attribute type as CCC (UUID 0x2902).
However, this request is not valid for descriptors like CCC, as it is 
specifically intended for discovering primary services with a given UUID.
When processed in find_by_type(),attempts to access attribute->value 
without checking if attribute or attribute->value is NULL,leading to a 
segmentation fault.

Added NULL pointer checks before accessing attribute values in multiple
functions to prevent potential crashes due to invalid memory access

Bluetoothd crash dump:
0 0x73fec87ae81e  (/lib/x86_64-linux-gnu/libc.so.6+0x1ae81e)
1 0x73fec94942e9 in MemcmpInterceptorCommon(void*, int (*)
(void const*, void const*, unsigned long), void const*, 
void const*, unsigned long) 
../../../../src/libsanitizer/sanitizer_common/
sanitizer_common_interceptors.inc:881
2 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:892
3 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:887
4 0x5d5c290f2456 in find_by_type src/shared/gatt-db.c:1389
5 0x5d5c290ff855 in foreach_in_range src/shared/gatt-db.c:1549
6 0x5d5c29099752 in queue_foreach src/shared/queue.c:207
7 0x5d5c290fb085 in gatt_db_foreach_in_range src/shared/gatt-db.c:1593
8 0x5d5c290fb4ca in gatt_db_find_by_type_value src/shared/gatt-db.c:1434
9 0x5d5c290e1996 in find_by_type_val_cb src/shared/gatt-server.c:745
10 0x5d5c290c3083 in handle_notify src/shared/att.c:1015
11 0x5d5c290c3083 in can_read_data src/shared/att.c:1100
12 0x5d5c291867c1 in watch_callback src/shared/io-glib.c:157
13 0x73fec931bc43 in g_main_context_dispatch 
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
14 0x73fec93712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
15 0x73fec931b2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/
libglib-2.0.so.0+0x552b2)
16 0x5d5c29188518 in mainloop_run src/shared/mainloop-glib.c:66
17 0x5d5c29188e26 in mainloop_run_with_signal src/shared
/mainloop-notify.c:189
18 0x5d5c28d8c6ae in main src/main.c:1544
19 0x73fec8629d8f in __libc_start_call_main ../sysdeps/nptl/
libc_start_call_main.h:58
20 0x73fec8629e3f in __libc_start_main_impl ../csu/libc-start.c:392
21 0x5d5c28d8f4c4 in _start (/root/LE_Audio_Work/Bluez/bluez/
src/bluetoothd+0x6204c4)

Sarveshwar Bajaj (1):
  shared/gatt-db: Fix incorrect attribute type handling

 src/shared/gatt-db.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.34.1

