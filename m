Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3D1547F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859481; cv=fail; b=S7jdxm6/Jh6XM7jHTXYjGMH1rRA+SlcpZ9trHv2v5sCUzVkeMUGZpA8p/uiSEyCFMAx5cX2l0IJm8DuCniDwbDzZz8+Qmb1Js0fJnnhIk2g7wcKQgirv4eaUSUMyRZa6dO+mTNWXVg/hGSIOlBhQtpV5qxmN5yyIZyhXiwKwcWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859481; c=relaxed/simple;
	bh=frG2pYz5Mg7LgnYECxJBXjE9+3yzVz9UzdFOh5bXZes=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XJFOXoYPPVXfoVgMYzz5i9YleiazoFHVV166hwjQ1TJ2BT+pQWjNERhksMsGcTaXYvFf4ctqk3Mn1Ye6WoM+DmPLrHwoowmGJeNkHCuJ2OmPT+MpCMCnq+fnKdPPwT6xIQOaP2sP5hH7rlVWZXSwUl3baKKe32riDDrbnzVHnw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ckZ6wbTd; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckZ6wbTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZPZ2PCz9+q1IudP7d0MF9yvZXxnE5LbHdCc4XH2YvBAhL1h2u5BIrjggjspnejr1+AvKt6Q3T+a8YeaVIG+z58fVAN0lkVspnFOR1pX9AFxBeMXQviRHF2ILfPLJlYQa5YfeRxz4Rs9cQkkrfojPgPIoC4VQDz1kPZVU7UdWVE8rkhEGrqun7V1WG/VheR0HPx+kU23ZQqvNQF004OY7zNVyzdt/kWQFLNjhulrIvajN5hx6pf7R6rOKLZXCElSIrnttByvOvYBS/7DQYIHa6ekh4OYS5PMwNhL3MYbC7ZmiWWELBsa+1zNKrJnSUmV4c6kyrYGgBP+qNiC+Rx7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyQ00G1q1Db7ULpSYYZgyb13K8G3eW54NvMU8PURwCI=;
 b=iXQYDAhT2ZKkszVAhoawfMrZuZk295hix+zFlCUrQp2+r4Yp7IXEkNbTg1nfBeeFl/9tHIwBAcgozg35zvebtmu+LF02eUdcVaDS9INkPFVm2ZkGI0UiEpzT426YqYh8jkK21RNHMNiSm8zCRIrOJ93pVBNdBl0YQZVGFneEBcRgPNzHc7zKIp6tpPINZ43PlcLB6asQv2KrvmwbPcLl09Q1FLINv8g7Xg0zSF0aMwQps+CoJ3ZAz2/vyrJVnwZnaAEtEj1NzGTIehemIrjPZNzimuHcUWtX1XrB1shta0wZdiab1RyrwtILpWJ7LSExiXTYX7tKTgPrxAptjVgPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyQ00G1q1Db7ULpSYYZgyb13K8G3eW54NvMU8PURwCI=;
 b=ckZ6wbTdyOqctKrj8CFactweXhDXT2Dm/sfo3H1318S6sC4o5QOe11mzOkoo0WMOckx0OqHWH/ANMKixZ/63O+R4ZNEVEAhAqt3gbTtJm0f2vycQulMPFaWaxT3JLmzeFhwnQxjPRLP30F+tAM66WXEe0rl8i4PZOUXbVCLm01DLUfz8WWovg2K1SsNQbvfFXufurYqaWO3PO4n1TaTiL0x8by9vAiY2bQgk2+clG50Ks8JiuNoI6IsHA3gjLeZM0YtKPESFxEtHRocITOUIJEFJF+PLKAHrINi00qX9JkBKVoI4fwTMfNw+ro/ZkAn7B/eUr/f7YBYv622S+mTJEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:35 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/7] Implement the MediaAssistant "Push" command
Date: Mon,  5 Aug 2024 15:04:22 +0300
Message-Id: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0011.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: f39d3f7c-bfed-4a9a-8a7e-08dcb546c633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TCgr+1GpsDUmRtZ1UEr8kkd3tZNVD5V2K38wFm49iwA4I76MUajvz6IUkiMB?=
 =?us-ascii?Q?e15J74j2DW+DjW4bQph01S+S517d1C+Ro/NI6QmmQzi6y2suq/NuN7tq05CK?=
 =?us-ascii?Q?JVluA7NcoAGhGzfKZ/d4Hk9UcNHZmO/1UYI6ZEVU+m4uD0C6WVRHv4LhQhun?=
 =?us-ascii?Q?u+FNL3Ad4mbsv7bin/umHQPIkHk5vfcaTNbPtxk/9ElYlclnR7zZKz6ckZsr?=
 =?us-ascii?Q?D+fGdlhpbS/pVSnpXsKD866SGn+9BNQCMm96+Bp4vYouANqKyQD8olSBcOc0?=
 =?us-ascii?Q?vyrDrEUbUFGSv7tXA2FXgquAg3y8MZG2V3Mp/5rC9cFA6GQ56rhu7vW77PZn?=
 =?us-ascii?Q?RbB5++Prn6NA9Ak1V/FmNWM0BczD0NCWVy1dLn530Ua1S0QKfIOMobAeqxd7?=
 =?us-ascii?Q?fqNuommyfq/2JYBFkS7P5MJYvkpJ3eJugsuxRUfppP1ybADrdlwB7hj+2hr8?=
 =?us-ascii?Q?40fvKTq78Vfp1C2YSfceWpD7vtjnqkhW8TAZVn28XpAOzEc8kSnX9LqNF7Tz?=
 =?us-ascii?Q?OdxXldrj14dOEE3uFExYFb+5gAt3lqhTd07/fDaNvr5q0EGTZmG3EanQXChk?=
 =?us-ascii?Q?PTDOO7UzJfighMaXB8Ncz4gSx361l/6AiarahIL65t2Mdf0TEY/ddqIv2aLQ?=
 =?us-ascii?Q?x6vnd4ouW1uPNeL0ZqptecciRkx4wkOe4EBO1Jj0sy1qEj9A4GA23eaqNV1B?=
 =?us-ascii?Q?FzE8eF5jKoOqBmZIz+5xKD3EvKsLCDUk+mY1sQ3QzU+Ste1eiOgeMli5EDPg?=
 =?us-ascii?Q?KV0S9zoWIvrn5ZeeAvniW7pAPy7HTvXPkICeTyFv76igvgSm7QytF2CE1mUE?=
 =?us-ascii?Q?ZmHQFrmlFpmT9l4L4KQ8wpmrOeRxnUXVbZtk9wmUsyJrMOP1RMbaVUVIoHzM?=
 =?us-ascii?Q?iWSt6ERc8PhSEbFLTCDGExSix9QjyHg/w/SIIX8JriW8at2YfLRd+TZ6jMvQ?=
 =?us-ascii?Q?WAAVV4XOQ4CJQlU4KyC3ftfhe3GXJdXB8TQt8rasBqOau/VcqHVjj8gxnnuj?=
 =?us-ascii?Q?7hPYHGuLHcFLboLz6Ba4b4vUqPmzGq+FdUR7x3Pc/IHLCg61tsrkg6Jdc+DL?=
 =?us-ascii?Q?XBLOup6u9XK9B2ne9WSKqzQmSB0FmHtfrlLvTn6UKkVolzEDCWXzrgyZDxXm?=
 =?us-ascii?Q?4Cbf9uB/KkYDD+WE3h42g46bYXP8Y8fnwBOBNKT/p7AVaiztZBnfdH9zSNoO?=
 =?us-ascii?Q?RukEi/6SM0QYl3HfelW7msfrjghWzmT1OI0xWz3CEyjkozes67nK/Sivhz5G?=
 =?us-ascii?Q?Yvj+Uepx2F6pwIK5p3Bl41vdag+eP9fJw857g4PTvX2fT81++jhWSGGWXPnD?=
 =?us-ascii?Q?o90HnJ3K6dYq2/3j5ngGrSaxgv4+nhilINT7vK5jr1Sp3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPDIGJuZg5sfGWVmIe+QVPNPvVKrFW9UTRB8m4SnO+4vBLiKdmUcw1ihZv2b?=
 =?us-ascii?Q?dfDIX2qWo0+BqCI9uiIfB+ctzaaJO74zND1uLXMt6fQlFEHRR3otHHE++ImY?=
 =?us-ascii?Q?qIQs8GDEK81kH5W6lfftEJMN6ljrXVmuYkcm4gp2I0okmzEledJy397vKP7B?=
 =?us-ascii?Q?KTG+mQuBBK+Tav5wL1s94B9cSLSieSyXGewdwz9GGOkXQk8D/oLdWwl/cw5Q?=
 =?us-ascii?Q?GM9lrIPf7IWyUbT8fN3KYp+mhfXkFmRAE9HQ0Y+gyZ/YIpe3bjH6zQiApNUb?=
 =?us-ascii?Q?a5uOlz20zAMuJ2ommU1Wx1wy0CBxsP5RpMhr/VmKNeNu6vx6WP2zejhmXUfj?=
 =?us-ascii?Q?Mey2S7tczMkZDh9zu5WdNxtOziR5aPQHNdFoRSLjFEpRCPcPSeQ+ny1ivuTb?=
 =?us-ascii?Q?c2op6xcD/1mbXXW5mgUbfxtCmmv6AHe3igigjM0ttIizUCeY160etbMEZjA8?=
 =?us-ascii?Q?D84ybBdg56aMvVzhmgfPTBbWDa01Q69aBwRqaJIpp1E2pc7m/nXIUwWpQVnS?=
 =?us-ascii?Q?nGN7BHrNrWkv7yxOmDDsqrd6rM4SIuzBWfXiHnoifxfeN8ShAGBdRHloybtx?=
 =?us-ascii?Q?h46Wqxrv/xglmUVMyp6MkN1CXLNndM/5WsQt+m+HL5LL11MEGFDTobWhFH4X?=
 =?us-ascii?Q?Uesgm3rg4icyy7PDAJzmi4VxA4YnUbPVOZYp0AAkC/+caeQNS0Df5MxVyBCn?=
 =?us-ascii?Q?xdKCno07XU5rwX/p3hsnZGjwwBevu+rBC4IOMVKzNuTuENhE8rJL0A5/118X?=
 =?us-ascii?Q?fZS103pj5l/lrjulKvs9PXjENbDc43lytr7LO+l2xOyUaoJMNNHnTT8eWSZz?=
 =?us-ascii?Q?y1WiHclO5CDFuj+aebNM1+eduLeAjIFMqi53Tlk/EdVfJ1dysDLThcMYK+w6?=
 =?us-ascii?Q?BYLcOKqiZJEzy6PiQITSE9QrruD32IILS96aEOlY6+yvcVxdyEF1JQ1p8QZ/?=
 =?us-ascii?Q?OOz4lcGEIhNP6i/Wme2jDxzj4K01UireBvOBT4KjtZHP/USvPwSnFafHWKfI?=
 =?us-ascii?Q?iKazpLOqrVl8XLtsIEnBsKYYLLv1+Ps4LSj4RsAvVbjMp0IAXQBeQJr/Q/LF?=
 =?us-ascii?Q?/+dqvgEos6wtJewhjdXPcaI1+Ygg7+s73hQYi/anzKgfc8+Sw+wARvKIGs9x?=
 =?us-ascii?Q?ykWNSY6MHixpFjmz3V5tvRg+wqJ2aQDMsO+RTCcm09xDM4qPhOKHSqNyE74v?=
 =?us-ascii?Q?gcFNQPI0D7Bov5V7PCj1x9v00tEHuMF25Gqq5U94iug6bLgNOOvwWWU/DGKd?=
 =?us-ascii?Q?O5wR91W9PuvUYYNNfgbObmRb+qJosP9ONkuDJm5CpUnQLKDQm3BKp3oUPARo?=
 =?us-ascii?Q?eEAAhzKOWkNeg41+dn4SXbjfJ98l5ddSUq47vd2KQ3u247GERaOWHaXepsub?=
 =?us-ascii?Q?c90Gt5+GkrJBqHfukZ7e20pvLXnW0p34QeM+dGvT+aJqzM5y76OpogaVxAVz?=
 =?us-ascii?Q?YPtUrSOlfP13aTJ62DWREiDA5QvJTxed/MMHo9XjZXXU/Wk3aiWQMiV+gZXd?=
 =?us-ascii?Q?fxd20N4Nbam/Oa5A8TxMicpobvHfjYBn+TTfdERPPnrftD7XTp306px+hszZ?=
 =?us-ascii?Q?aKS/UNSea0osqJDP3VQtm8MOD2Go0XGEKyrcrWxL9VvRTjilp/OZEaX5/9QS?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39d3f7c-bfed-4a9a-8a7e-08dcb546c633
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:35.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNTWsv6fH5KXQqsJoiavLevSCqIs1/DJ3ZSXJwYzk2Xjm9gn6Wo7Z7oESuPCSgT3g7BFeZCq1CJeVpdFlByLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

This implements the MediaAssistant "Push" command, in BlueZ and
bluetoothctl assistant submenu.

After issuing the "Push" command, the user is prompted to enter
any stream metadata to be sent to the peer. If the "auto" value
is chosen, the default metadata found in the BASE will be sent.
Otherwise, the LTVs found in the BASE will be overwritten by the
user input.

If the stream is encrypted, the user is also prompted to enter the
Broadcast Code for decrypting. If the "auto" value is chosen, a zero
filled array will be provided over DBus.

Below is a bluetoothctl log to exercise the "Push" command for an
unencrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 15:19:44:63:76:7A 15-19-44-63-76-7A
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: active

The btmon log below shows the GATT write command sent by the Assistant
and the GATT notification received from the peer:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017a766344191500c21a3702ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 15:19:44:63:76:7A
            Source_Adv_SID: 0
            Broadcast_ID: 0x371ac2
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017a766344191500c21a37020001010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 15:19:44:63:76:7A
          Source_Adv_SID: 0
          Broadcast_ID: 0x371ac2
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

The bluetoothctl log below shows the "Push" command flow for an
encrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 05:1F:EE:F3:F8:7D 05-1F-EE-F3-F8-7D
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[Assistant] Enter Broadcast Code (auto/value): 0x01 0x02 0x68 0x05 0x53
      0xf1 0x41 0x5a 0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: active

The GATT write commands and notifications for this scenario are shown
in the btmon log below:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017df8f3ee1f0500f4015d02ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 05:1F:EE:F3:F8:7D
            Source_Adv_SID: 0
            Broadcast_ID: 0x5d01f4
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020101000000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

< ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 04010102680553f1415aa265bbafc6ea03b8
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 0102680553f1415aa265bbafc6ea03b8

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020201010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

Iulia Tanasescu (7):
  shared/bass: Add API to send GATT write command
  device: Add support to iterate through service data
  bass: Store Broadcast ID inside assistant struct
  shared/bass: Add APIs to register bcast src changed cb
  shared/bass: Add additional defines
  bass: Implement MediaAssistant Push method
  assistant: Implement MediaAssistant Push command

 client/assistant.c    | 247 ++++++++++++++++++++++++++++++++
 profiles/audio/bass.c | 317 +++++++++++++++++++++++++++++++++++++++++-
 src/device.c          |   8 +-
 src/device.h          |   5 +-
 src/shared/bass.c     | 133 +++++++++++++++++-
 src/shared/bass.h     |  15 +-
 6 files changed, 720 insertions(+), 5 deletions(-)


base-commit: 100c845b2d20e7f4f96b371e044b8b59944230ab
-- 
2.39.2

