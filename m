Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A426AC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332375; cv=fail; b=Gsnv5ruYHbZblUwhaYcqR4dnV2Mf2UOkQk/vWvvGHvUI3hqbPJtVsmDvNILfHPSk+d//025MpuGIzwoH0/csjdYZ1ColTNRpPvek7FeAdwiMGxImwgrNNrWxNsIEo4EdeHBP0Vmb/8bIeebFZ64V2NVJLYG3wa6h2lYMUWjpdlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332375; c=relaxed/simple;
	bh=m4k/wwpAyGPPCgjaAMfoUew5kFtCn+XdNuXiRmyVp4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Sf1wg7OSFPyXW6bFMza8w9+wzPnhJBT9UUIHzXAPiOuA/Fn57AoE4n1azLDMKtwOwBLOuzBBEDLEhQy9f7jXEUuN4gdvJBloGa4/Z6WQ+rzq3f4mqoLKTUGZn8XGGgm78z80RACSKtVBSLZE+LjK6CTTkcbQkE7RnGS9OJwBu8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=guYmtkor; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="guYmtkor"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buzeR2TUm4UWvEN3RG1G7PUTWaS45TfoFsUM+5s+QMf55uO2zClCkdZS0LZeVl1ploc/0DpUtkcegBWbYLKXXFZVd/kxKV99IcyOtW3SncleKbCY/7qqbcSnBmaSSCfz06oWI2s4+hJwpYdSoZqNowxOXjEPucFcw5XKrMjI8jshXgw025cEVItNPF2bF9X+xyMxHB4BXknkcQ2KE/FcYemVvVAUtBZXqLtn/JjtadoPDPxu7Mdy0LANjE7NbxpsO7esF9jCkI6bbwePHlsd6FLPgosBH5KHdpFx6emIZ9wOkTZEW5AnLdi+WkfTr/3zgljKvTWLvuQyUX7rTUP66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7iJibOrgp9Jwkfz3CciGP5+1soUDFePeQQW0ENBrjA=;
 b=TAwrHIPWIX1ZJzIVodxCQG1VmcemJ1XtgTmnNLPyBLI3YCZh1lG8OBTEzrbZOnTLc0msF9ZZoOhIaSjpX/C3TniWu4VV/n1PydS7lO1cAusOaPf4oM/mZG4T3p8l24beuEqac0ZDs0ThwroIaZt4Pf8E/ZNeXTu1v3C0SkGhh7Ypd1M0UbK5VTHD+8eO/XXxc2fjQOdhV9T8IpLedQldfaSzkkJl3Noso+QrxGWuDIeRCouzWBwfFSZIOLWmC+S/R4ZEd7y8fuEKPYChuVeriPa0D37xt6tY5St4OWb5ykpoPewTcn0/EL7AcnF6Z5+bT5j9f33Zmt9ufqNyae/93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7iJibOrgp9Jwkfz3CciGP5+1soUDFePeQQW0ENBrjA=;
 b=guYmtkor9k7JZ18mFI7DlM0RlJCavo9zMhxlIvwON2weheshd5RndSCqIfzO4D3ON+ikgMRNwCz1ejWzg9U/WgJ1RWb1pR1zE80bmfkF52BUmN7vEG/pXDmDH7zJTclWyloVG6823v+Y1LgK5PhUl5BvyeFzOY6KvCZVKkyPJ52rJG8SL4fIOUziBl+97akiL1xKcNTYsC07cnkcuH0cJz9TvWSDrKC1zGTCwp8FQlh59rjyJxEsN02Fko+mVI4a087irbsfEFdVpQcHfmMsI/libKCdIUoUUt+HzL/JdcdLwqdqJxy/WcQLaGXXMCxOXEargC4B/j8IOE5tBH3yfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:12:50 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:12:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/8] Add support for setting bcode on bcast sink
Date: Thu, 22 Aug 2024 16:12:24 +0300
Message-Id: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: ad21b400-e870-4011-b332-08dcc2ac1f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ad58tGPt169oqwj6cayaL1liKlLHgE9Kn0UhsqTnyzqXlw4LWjtZa1Z92A47?=
 =?us-ascii?Q?AtY6hby7gLb3Fz9cMCrr/MSXM+4AMLIg41XZVzV5q6EiVkbA2V4NTLHuEyn2?=
 =?us-ascii?Q?/YVAr1jb5ChJ0wasadjikyhjxVCPHt0l6qBQ/S15x1cbXCbfHNO0WRI7NGO6?=
 =?us-ascii?Q?jPL7lNMzKEAngOEyNEM4H12bfwBgnb0zPZTFJnjpcysF2leyUUvs0DoYjwK0?=
 =?us-ascii?Q?Ry1ozPn2MZ+UuxkAqs3v347VKa45R8+OMEzcsGp4bwSwczoRObIbRir/TgbE?=
 =?us-ascii?Q?KuUml1KkFReIBNknBxAjaQUzD9WLkmkA1gSEiNyWWjsSFfq/v2vS5CukjyNQ?=
 =?us-ascii?Q?5srq91Oqq7hbTYzSqA1AK5BRwZwC7Kjnk3/UAmtAFxgjFC7bWinfefIu4oG4?=
 =?us-ascii?Q?kHdZL+JeJATXl/PfXN6Omla2awIKsh1Wr0zoRL4e7SH/PnU0i/dj2uXMQeTE?=
 =?us-ascii?Q?DG+iwR60hVCqDdGvNx0urlU0/GBQEKtw3Q5lGXQU0D0WuSOqXOQ8mJPMkAWR?=
 =?us-ascii?Q?2FQhk1loscetNoMaod7vZqqslcGXLbhn2vGxIhddntacGfRnDb9DtvoDCMPb?=
 =?us-ascii?Q?fhdxtquWhTrrTnDvZTCSHfdLBzF1v/PMpmH6JGD8YbC/7Z+JZLqqnSsmpLzw?=
 =?us-ascii?Q?mxjV+hJ1IlTk4Pa6qB4/dFJDb7UZ4WGZuWB+Qe2Sr88xUf8nl1E1xRrLs4y7?=
 =?us-ascii?Q?BBbOpYOs/y+TLTQkpHWKK3CaJiCs2DZ60mWA+KKeqL6KP+iwPF/i0oTBoTBb?=
 =?us-ascii?Q?L3AJe049DXGfhkcO0m8zjjYouj+RkA/HzvgvWZjPkH8qj2xYpObv8fGu1Pol?=
 =?us-ascii?Q?5wQvfYJ34/aeASX1e+/tplm/UQUgaooJ339iJSt/1vULwyjPHXj7yq6O2R3F?=
 =?us-ascii?Q?jWjsJ6uE74yOpLfPh/SNQo5YCD0cSUT58Jk4C2mIH5uD6WJSVZVvJYYed3qm?=
 =?us-ascii?Q?nOLhOLz9yKh75NrUyYofgc2cXlFOf4BPl/RX8YXRm/tcAkTN3SMMB8rZcCt0?=
 =?us-ascii?Q?1/zaQwaZmq7BR/vh9TPmF5B4+QpgatM9KN9TeDpzIHeFtDNm5Gp30Oj0PJzZ?=
 =?us-ascii?Q?SR0PKHIzv9F6IkYEGGZnhVTrohXTojQLQHb3HbXDDi8BJ0nIZ+GTgkyBNcaw?=
 =?us-ascii?Q?Rf7bX0dFn1qqBCyPNj+7Vr0XAf/vdDdp+ZkYoe4dews8Fs7lOrzqzZxT8fq/?=
 =?us-ascii?Q?jBCU9uWQAuHBXDPpj4aEcXs0C0vyRlywqBxowiXtJax2grIZYdtsCAkBrt7g?=
 =?us-ascii?Q?2lTfnuRluaw174FMJIoJ9ZnRSZr00eD+IzfNECNX8L3R4RFUqfbexAOfGruk?=
 =?us-ascii?Q?2sNAn8R7A5UN/zagZAKbLfcjKc1aJO3OIk4vrMTkIJKl2rrJYPhJbZuTO6SJ?=
 =?us-ascii?Q?SduevoGfFrjTcCZO1ygCxKBi/770Ewpi7lfCQf0WNtuQ+vBUlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tqu639d/4f8XNmO1s4B+vJlYwwFC/FjSCAl4qWQQFJbrIYPV01WNJSLmo0G8?=
 =?us-ascii?Q?vKkS+tqyiGh2XMjU+sl+i53nYp7mgXMl6dyWyuqMtAZjtAcscelRsAjd1J9v?=
 =?us-ascii?Q?1EHrqAfe4+TUD91bnxX79MbxvzjlOfMNizldmVS6+78prVJ5kEX7n9bd4wJs?=
 =?us-ascii?Q?nhBbxeV3p0HpzJX9q7OrUKk3qg/mqWwWMf9F5CwFMeruYEEAwNwqGGpmURyL?=
 =?us-ascii?Q?cZPhzcNtnOqoDHkL1f1OHj7B1hV6fM4m53SWpLbGsvRKbUebukZQIMfgycZ9?=
 =?us-ascii?Q?MgH+aF3dsYeu+GnnMh2TV7fszdALSdnyDJfVTwU7WN18sI3QRG2/75sJhOTt?=
 =?us-ascii?Q?WzXwfyumJadaP4HearDH1M0w8z/CF9IrNS431+8QQeRT8gfIJ+uhHWGT5TMX?=
 =?us-ascii?Q?36zUkxGANH7jIlvU2lhs7aHUmnTyzYY6R1JPaDoit3UHZ19kajF1im1fWX+O?=
 =?us-ascii?Q?YGEdS1zkzaasZueuYJAFrzrDaDPxuKPjYEEnPhk/47t0XsuS+PxxBoI98M+9?=
 =?us-ascii?Q?BICgRmvqzIEmJYsPgMKyP7WQ3tasY2EuefH1rtEpbWMzpt9YrZ9ix35ZhL2J?=
 =?us-ascii?Q?zpOd20a4BMP0sNMWT4e+vzLqwUueXHC83G9TOdhpGDwtLKDcummOhEAYcStw?=
 =?us-ascii?Q?UklfQsQcbUxe9PxsNrqEeV/V/zmgGKkczYum7h2BlsUMKQ1XgfzLEaCGfePg?=
 =?us-ascii?Q?yT/1R7Q1pZ9GkZaE5CgaXZNLuUR4tJZ6hIvGghO4vwSImtbgPxwzSDkCMSF1?=
 =?us-ascii?Q?tdAxii/cRaZz+W5DlGuIRtFP+bUO+dtNQ7KFbff55iHcuoF+G73EqHS4+hMI?=
 =?us-ascii?Q?W48smeRaho9sDJx9RJ8I6lZoMPhPBklPmVhxQA2V2Eq+VQyJUyxtEw2uTGXk?=
 =?us-ascii?Q?MHJWdO4vgP6LPyjgNowZpZvhRV/TsDQR40J2S6M4ahUbQ9xXrm8/xgCgQZwU?=
 =?us-ascii?Q?icfSZS5TCy0zU7SAiZTQXhPFG9LVawzIlZGlXXQezgd6yIaFQt32QgibxwUT?=
 =?us-ascii?Q?xxfI38hdCNEA8Vf3aOVlfd4N6qCO/AUe8zBub09UOcGCYUwHJgtzhM/PbLMO?=
 =?us-ascii?Q?o0r8+CXM0YgDc1NonwzU1YeLfIdUxYwZ/NlOYkcQH2xYlleXSST+def6GTW2?=
 =?us-ascii?Q?Gq9tImKTCjuFCYGAZWPy7Q479/jw3W1wyEWdOC1rbhz2pYR1NtzexcCpbtWv?=
 =?us-ascii?Q?uBsos8XKqy61inC3IduE/pkQI/rHb1lPGyxgOkYTkdKkgin6nWvmZ+XfRU3D?=
 =?us-ascii?Q?sgj9uQkwQ7/GxxQV8cetAAgcMuq4ShwCH2+JY5muar1JrdjKPgDvCVymKEkO?=
 =?us-ascii?Q?3NxlwS6gwAgarYL60YhSDUb/3jVcTuSmYfZUySaP/wYa+PqdBYHRxjJ6hDzp?=
 =?us-ascii?Q?Qe2pySQTaWMZdlnrSArXpPjG6cUU1MdaQklkUV7hYLBq3184txdk6KvdWnSw?=
 =?us-ascii?Q?9JrQSfrO8bCuicc2/Z//s/2hnEOXZ4pan1lnkERed6Z8vC2qkeoY1JCaft9q?=
 =?us-ascii?Q?sWTXObWIH4POESvEwRMyc1QgZa7wkTzZ0pxnjxA/I+kPtte7h1aVW/PGfyt6?=
 =?us-ascii?Q?2Xc5lPpSGP+Q2Tln8kbXkeZM9G87d4RllVasTw08?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad21b400-e870-4011-b332-08dcc2ac1f8f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:50.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arGVjrPCzxoDdCgzn0jRQh9uuQ6f6zan2PpHBzz5tqyXIeG/zmnLktJIhDlYSS3yfYDkgubmvMnHVfyJglUsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This series allows the user to set the broadcast code before syncing
to a broadcast source. Upon calling transport.select if the source is
encrypted the user will be prompted to enter the broadcast code. Then,
the code is set in the associated stream's QoS. From here it can be
accessed by iso_do_big_sync, which will pass it to the kernel.

Vlad Pruteanu (8):
  doc/media: Add Encryption and BCode fields to QoS property
  transport: Make get_bcast_qos return the encryption flag
  gdbus: Add g_dbus_proxy_set_property_dict
  doc/media: Make QoS property readwrite
  transport: Add set_bcast_qos method
  shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
  client/player: Prompt the user to enter the bcode
  bap: Refresh qos stored in setup before doing BIG sync

 client/player.c                  |  59 ++++++++++++++++
 doc/org.bluez.MediaTransport.rst |  12 +++-
 gdbus/client.c                   | 115 +++++++++++++++++++++++++++++++
 gdbus/gdbus.h                    |   6 ++
 profiles/audio/bap.c             |   2 +
 profiles/audio/transport.c       |  39 ++++++++++-
 src/shared/bap.c                 |   2 +-
 7 files changed, 230 insertions(+), 5 deletions(-)

-- 
2.40.1

