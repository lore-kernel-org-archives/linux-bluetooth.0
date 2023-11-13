Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD44323C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQUweUFW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1740C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:38:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1a7cVy/zaner8phyBMYoEVqfSPz9khfegd95rmnRvcwEtSFG5eRPMVwBeUPeDCAqi+LcrbJfwy2vWKHzLar9BA6YrAVmJyyDw4ptRcY3FZlE9FSiBhK3Fe0kT3kze2VvUhKaqndfIe/uW8pYwJ2mIbTtYWW8XkIMIAR+f9BMXyO4VUa7JNmV7+b0qIX5nanFvgljuBjK9Od9bMy0XPF+Ev5omopbv/M7liAuUutAiLHlbumwt87jIjSbfiBiRWY4uGfBZqOhT2812+OfKAaPm2rvCN3rUZxBUJ1+kIEJAiX7+W40ohmXmOhoySYVoRrQAP+ZgmM3nv/JDyN/ABOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7s1YoATqnbLkubnijMgOwJ07dVm+Aa8wrTTnrg6SSg=;
 b=ETG+uVo290mJuP96mnQhhCiqvXTjiWl46B4F0zYD8VlN6t3eWCdfNeBWjb7cRu+IrwfXufcUyk0QcXtPZfsNldQcvrERZabkXZK2laPw2qSUtVdZQhba1h2PXrgmPEMw//8a1ZQba9wqBTHtnSz7sedK3O01Etk8V+mDVPWA7vaVEjl4RqTKIA5ZkY8mglTuHj+kfyC+aY55t7jGr7CSwxxbFHSxNCwnVv97oAc5joPHrecT2syZ0KS7fP9+Ipe/AHJvazBoQUQXKOBKj/Mc1uzz7aIdW4+Y1pfE+o3j/noYR+MKHFabgMBGSvxUDQmsUzwJNi5Ms3ujP3Dzn+klIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7s1YoATqnbLkubnijMgOwJ07dVm+Aa8wrTTnrg6SSg=;
 b=XQUweUFWOiBR6WQQJZ/W89EEaWCoKQCq8Pmsn8VyIfMK/I6FMy8GdgXotd143Pfw13FPl7YFx8kdoHrTvqSGisQVjvNWj9UVLFMvQqc740ftqo7bJxstQlEuU5S24oMMl4tnvXakKkX1jxprlDFiYdt79w4UpLdtobnOZZ/khkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 15:38:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 15:38:03 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date: Mon, 13 Nov 2023 17:37:59 +0200
Message-Id: <20231113153800.3771-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0080.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: adca67e7-d145-4e42-5e6e-08dbe45e864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q038mPMc0IlqPh70gCmAKDlCOJpSHj+HpTKnJnlx6bQdGWCbOr2cwzsUBcUZcjV0IjOjCyWfA04b9f6GupQzpeaqCUtAwszxGg9xgx7EFZO4LoTSGfmzmg/CD+d/VKTRv0db/ypt5zCee6So3wpGUE5/JAdgkc0klDtb0D+/eYM7QD86i8jLqcVSDbMvqlsKQH3TfNysLP9ZwGXrjGCQ+NknDFB1BH9nZOTxrkQJOFGpNfBAb0X5XBak2H3T3Ff0n1GjtZCbZhC3paMyiOV1rhKbdAzSu9FVXU7gC3H85hT6jt6EbmDkruY0Pd5nGURPwUlJM9nHC/+eORCAF4cjVb3u5mhll/qr+LH0xdAGrFnYPM0IsXIV2RIbN/wYSy7T2UHpd6vZkSoC0SzxgEWlRpqatL7kVDVo1oGWfkIqd72XJJIH6VfsbdY6vSmL/i02FLHD+Pa5BCxrKNUBfCHdVrOYPrwypJXkKr52QjxK+O6T1OAY6dq48yakaVLTrlHXi9WfddX1Lmm1ZgbI69e3Oun9BWBmU0bMuqQlo0ePZJS8RszoF+r143hSEwSx5wVG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(44832011)(41300700001)(6486002)(478600001)(8676002)(4326008)(8936002)(6666004)(2616005)(5660300002)(6512007)(26005)(1076003)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkv0uPdyOJbnVefFEmqowP5LtLiiBB16sLDt3ZcIa+ZBN8UvNCo+nM+ndypO?=
 =?us-ascii?Q?spcrK/D80cVm9dp41p9I4sjcuN8etUxh5YYciBmrl/2TcHHuob9hX0Zl1WOr?=
 =?us-ascii?Q?AlOMsUHxEF5rbJEsqE8uSv3vNtg11dkoI+mvd7JEOWZM+VoJH5l0thaofK4s?=
 =?us-ascii?Q?dRdV+d+oo/psQOPMxHZHuxjGaC4okBfbHYDzqAc17Hvv1jS79wCHMJgRWHYS?=
 =?us-ascii?Q?4TXP5HBKElHIM2Beg1GtHT8FgsQ6d0Baud4s1tUT1w6kfa2AOiBT5Ffs9YZa?=
 =?us-ascii?Q?22ww+qfyBbBtjF6pPDUGS4RrmGKfwq+iIRFp6ih4OfSKQeIe/hihUjYzgNWM?=
 =?us-ascii?Q?M7DOs4uTqzPmSflleY9hoPOgaJzSEAnXulg80giRWQf9wY34x1C/dgTBGVyf?=
 =?us-ascii?Q?ejelIwH3f8DtxVXOwJyctC5iYHYkKBaaeTuQcRAHeRlCFQthNkjDgJUMCnWS?=
 =?us-ascii?Q?GLFbfzKbUepkz2WsGIZbtgQoY5mzvqNtDa6s1ulEoKZKunFtJAZKV01QgNth?=
 =?us-ascii?Q?lJ892ISjQf3As90WMcfCnAEaiqo43Zj4wosbHeX5wLhoEyjwfhJAOoON2PMO?=
 =?us-ascii?Q?uNqKUW2bgC0r2OM5eHdfqJG0BorvhewK6Gk9XtChzhA6w9/ErJg01j/XHiHG?=
 =?us-ascii?Q?IsA+umIHxNmtlLslsuQF0qt/Zgjw9azptNuuj2wj0RhwWkboSxO2ZwsHVJ75?=
 =?us-ascii?Q?Sx/lpqrWpppzDH0K7Wsf23whO92eutVR+/GSl8dCV6Yl1hMrX6mUUgWfKIxR?=
 =?us-ascii?Q?Sszf+oA622A67+T5ISV/ybD4/NnSwXtpNh6fOvsJTm7R2PtZ6RFBzmmT0BxH?=
 =?us-ascii?Q?ovZoovp9Q9AvrCnPvRk8KLwBXp1ROPPyg6meuRH0m3SY3pBiwi64G8dBAOhc?=
 =?us-ascii?Q?Go3qeb3BV8UpwgWhIqMaAJrO3twFdl13Di4v0gj88mF22Wu5QMTqjOK+hZDj?=
 =?us-ascii?Q?WB+AOqvIUSjzcdcWrx72l+9o3/bfmTBzZXwqgN76bQwNpJRIVDLzsV14EUko?=
 =?us-ascii?Q?pV3hoK0Z4qsmTRnBDRpvCAdP0CBJ5JnRfgiWkYcWK7ASKkEvFg49mu9yUNce?=
 =?us-ascii?Q?fExGiGYCKodTYoG9UQQpxg+3CdlRdFiXrbkCL2rMTnBWnqZ2EQfL1FCKRxH2?=
 =?us-ascii?Q?9EqUy5OSLRn5moDOw1twGB6+P3lihQtIgXcGzMS8uJ4lm9qhOGWXLXq3gqKy?=
 =?us-ascii?Q?AKx32CCC+aEfnnfAb2SP8XZ4upttRyzbCw6joholpO+OaeMs8jcQJPtGcWEj?=
 =?us-ascii?Q?yU1Gn0iI1wQeBTP2s44yYgXszIz0ebNz7oBqoJQwQbbmjeioA0g2QjJoZ6V7?=
 =?us-ascii?Q?8Yb1qRXT6atdNkDtMTLCZ+GqAEnwWcbMKXzUz2TOApENch1CRJGaFozx7o1L?=
 =?us-ascii?Q?0MR16dHWqEtUJIRWZlzzYOZOHHH4bBEfHkAus8bWTQGxeBT8NmvDnfRmMgFW?=
 =?us-ascii?Q?9fR9Vry5plgwrTzExEjZokzsEAgd1SB/1Yss0zvqatzEBjYU5gJU2tzVP/Dp?=
 =?us-ascii?Q?iF9qSgbXgwy85pNNVycyGpWcxdSOwaxZJ08uKwquXjWXSr7Mn53Oy5QWh4qD?=
 =?us-ascii?Q?PRL6twWWLxBBAlDWj/GAlKJzZx2h2pIm/t/KHsrDJ9G+9MVT5Y1B/1ovk17K?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adca67e7-d145-4e42-5e6e-08dbe45e864f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:38:03.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S24ZOeC+onhjrsvQDnhnaqeijK6OQFYchJl5eEzymrlHuWR8GmHwvF3HmcxL9YmH9XdqTQDdqO66lVM6e683Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498

This patch implements a kernel improvement, to be able to reopen a BIS
socket from userspace and reassociate it with an active BIS connection.

This is useful for a Broadcast Source with multiple BISes - since a BIS
cannot be terminated independently from other BISes in the BIG, all BIS
hcons should be linked and kept alive as long as the BIG is active.

If multiple BIS sockets are opened for a BIG handle, and only part of
them are closed at some point, the associated hcons will be marked as
open. If new sockets will later be opened for the same BIG, they will
be reassociated with the open BIS hcons.

All BIS hcons will be cleaned up and the BIG will be terminated when the
last BIS socket is closed from userspace.

This patch version fixes review findings.

Iulia Tanasescu (1):
  Bluetooth: ISO: Reassociate a socket with an active BIS

 include/net/bluetooth/hci_core.h | 24 ++++++++++
 net/bluetooth/hci_conn.c         | 32 ++++++++++++-
 net/bluetooth/iso.c              | 79 +++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 4 deletions(-)


base-commit: 0783375f2c56ca17719d5ec670e498dc661ea5c3
-- 
2.39.2

