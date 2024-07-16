Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6119B3D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139742; cv=fail; b=Fg5mbdSF6TINPCcBFuHvYN6TxQWau9XNLlDWWKijo86N7UXFAEF1mx+PbOHbZ0uJSQKwGrLNXT/RAMmqjq9r3RZGQxVhJ6N+s0dXrf5lndymfZd2subPcDLMbtdlrbJfUnIIo7QQ+Grp0Ae2DRJgGSWCRci7GueHStWAicilDDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139742; c=relaxed/simple;
	bh=IB072IM0FxWIKeRlt5J+Y4R8zII/dlrQb1FAnhJYdtU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KgRB9xHDpBwBYR6SCWrXG32p9kK9jzfXfAz7+7io8M2FNcsvBPVnKC6MtJdnMpkxSZIiz+Qna336wauMj+QXid2muTWipdSU1RPTCUAqdHBUd9IbRA158i6zuSxg6CN/pvGFCBZoti2+Vl0/cRCZtxWQt9KNKVPoluENl57HnfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mRn5+gr2; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mRn5+gr2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGLkktZ9WAg5Qslo2MJjG2PQBFq3gW7yYTVEFh3Btg61DqWJvrAKDyXtmeud8ITFgFE3w2xlr5WzOLbAl2eyFlgPaPP9O1KOxHv5oL7ErPEzrXuQjzWJXqx6KXXDWphr0tbGAfsHI98JixhUbSHywx2pCYkf71LInWR+ce35dU2Rf1pfXPCD7lHNPUYmxN9KfG/orzDnXErQ3p8UjRs3EJvB741YtDUFbaCIH13uK/ZWDl9hCfS1+IggJGEHgwHG0YaYVwGFS+9UMKy8NORjs4m8Z4c+UoRJvNIuZOL+HDIcQgo0R0FYNzJL8Bz2gNhh0LES8MAmqDXplcq15rC8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeCpoOsqTfW7SWK2PEStvP7SqG/2Ifnk02U9MhHcRl4=;
 b=sxvvObR1H8wVxmEYQ06AzpY3pQOoxK4DElOCiCSVdwyDXcQp7TpbfiF1zvt3xdXVFJCxMlaglngljjrSfE3wWzaV2T8Y+DDP03FgRf2kW7h7utIdHkIf3tbZ/WBsqOtfXOxRsdoMWidspGKI9JGIIA9/21lLwK/ljUHCJ+V7E6ym7QWqaZxc+MrHjncdMJn642HKx8cR5XiZquWwZlSjsQMoSK70wEa5SVWXRgi8xy4CpkrmW5uN73lvFoT2gQIQpbqJap5tE4/8Gzo33C23i+zXjmeWocrYH0d8/8XfeF7t15FVjIXsrJG8WnMdQaZiSNNdQMxxBJyw2pUEDYjzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeCpoOsqTfW7SWK2PEStvP7SqG/2Ifnk02U9MhHcRl4=;
 b=mRn5+gr2DyuMa3/jhC0mtlhVlOHDTm8clqvaydkePZcQdqpzQSd0UaPz7JzMBSdITRe2pqzDUCb8hh1LRFUZIW/7LS4C8H+u/kKoySvVEJOacGkNgRaZhZZaJsV4wY2AZ8EovGwOvXyqHLe+PO9ssuH4T3sym6e+ZnkweISalUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:17 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 00/10] Initial implementation of BAP Broadcast Assistant
Date: Tue, 16 Jul 2024 17:21:57 +0300
Message-Id: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:208:55::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: a6621d91-e279-40fe-361b-08dca5a2b246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KE1ykW/DFpVA+Z40ydfSQy1rva+Q7Ezeej7dHddQ0C3yaWmk/0R4KmLV1UNJ?=
 =?us-ascii?Q?aoaIPMb0UKowqGFfwygT0miYtykfDV/ankJlJ/RqsRM3+dIK3H/Pg4ZwvEvt?=
 =?us-ascii?Q?GapTDwXR19MgyoKzYIyauS+bq32+VRcRZA2ze3h/nQkOAVOEbaEAm8vzyfqN?=
 =?us-ascii?Q?hDmBfliZkb2BI/Bs2HnW9CdhhNsSSbkRlT/kptw73J8Lw3b1oIORoAQYq32A?=
 =?us-ascii?Q?861E03iDo3k4Y6G9gMqMFWCJZqsvXhbSk5B3OQ2Plp9/9rhgOAkW6LiSC9gn?=
 =?us-ascii?Q?2XMRWutZYLcXCPRM5KvY1RqzWozh0BrUF24uHhiPW/y0VpXbxQ6+DBHWoSMl?=
 =?us-ascii?Q?t16aU15iMXaBXJ+NklJEWzuhjGFrvL9bM8xFRdUeYfX5HH3i4nFifK9QJEHA?=
 =?us-ascii?Q?pHJq3T5UhUgeW46seepZk5cKX4COdu2sOFoAjZBH7VYrSKfm2X75xuwsq6Nh?=
 =?us-ascii?Q?myO221vPbUJl0PKDsEL8bp9QTG7D4cTInCARIVOCr1xXrQShr1hGhPVC/oUv?=
 =?us-ascii?Q?Gi+Hhi7XQ9NrK+szxRstOegCoYnbe0SadT4JWLwosirIunlAVyRZWQJ8oCdp?=
 =?us-ascii?Q?ySKqo2UVyF2+FK5vSFRLv1bpE1+U1vVCPCPYODwhcFlMI6KLlO5sM10q1Dry?=
 =?us-ascii?Q?mdKmpRUisyRSbKP8aVO5kq4f/UsbGCepd+ubo02RtL3o0c2nAr10F3lDX8tL?=
 =?us-ascii?Q?yv3TJazu9d5q17pHMPhpJzhNRIKCuEynZy9oG7RR3I97Q+U5pqilom98iPlz?=
 =?us-ascii?Q?wDJWYxmr0NBwHtjJhoqojZAqcCe1hA4BsVBmb8TpAj2T51AD8rAW3LS5rrgn?=
 =?us-ascii?Q?XvWBWtv3OO2zznquH3GOd9kLnA2TYSY19aIeuYarL3JPUC32O7Zur+/GkLe2?=
 =?us-ascii?Q?CbjKn1/HfbPvgTosRd2frx9J/EKxOl05V7ZEEwCZ/qljCvgB1Q1fRRrodNua?=
 =?us-ascii?Q?bsB2qIXYHveVupy0jyM0oz/vtzDeOv74MRqX2rqfGbHB7Mu0RBiunr4o4K3+?=
 =?us-ascii?Q?93KtnMEgx05gtaL9MfHOCsnQNYH/kLRfcA1p2L1k3193RxzHc4afg+KY/Vaj?=
 =?us-ascii?Q?sibMvtDrNkgUCo9k7x6tPUwtUN1BZOhIpIRnaoOB9+6DCa/yU2d10UPGBlEN?=
 =?us-ascii?Q?8KTzggA9kswYof2mowsEfIOZJSAhnY2LqZdVgPqLQj38rQ8eWSO9V0NCvBOV?=
 =?us-ascii?Q?Y2BTW2+I6XzL4hm0JQJWAZ+3D25ViXpfDQfi3XSyJO6vB77/MsQiL34qp500?=
 =?us-ascii?Q?kLh5x+CTSqxKFnHcks2/6RSbBSZwNQEzDj7ue4hH9l3XBEk/yvINoY+K6zti?=
 =?us-ascii?Q?yJrhFWUznzmwpfdB1GwI0E75AeSJG9Vb1OibLZMIWcs5mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0JQOVB+JJYut/b7/5oJCLiacAo9g8HD9L2GT0GDczKDHFF/ZhYhZby8GYI0?=
 =?us-ascii?Q?pJYMOH0sHDHjwWsrzv1YlnmR7fITpod+s+z8+p5eLt/2kAnGTCC2bzUngOpb?=
 =?us-ascii?Q?bKkMrm0Tooltm51oPq4m8EhwPPzdjMtj/M1RoJlj2I5yPpNySbg/krJF3aD8?=
 =?us-ascii?Q?Sh/zkqHtGWuv5BFOZnlY5Q5KeuTlKAtsb8KOBMB+LzwybYkvSNgUTzVu4ICl?=
 =?us-ascii?Q?D9Pjsb0WoS5wVb+RzC7qk8GhPu8swyQqzxXLdFJbH+LJKVw31Akgwz44gEb4?=
 =?us-ascii?Q?civd9YTWLocPJY+70VuWa+lx0pkdleNI9viegz2R0prDCinTdDoLXaFJGLNP?=
 =?us-ascii?Q?XNOAY9+rff+mhvWNaxeFtP7adliYfDRgYiUmiHGG9avFHekYL2B/9w7sqRyX?=
 =?us-ascii?Q?9frmM9p7/CZ6ChZbM1DIrDseH2ibZjaSPv9cuVPo3LFZiLI93T65fFdDbDjJ?=
 =?us-ascii?Q?M3VuPhahELFt0GMi6YIXGcs+OMoVY4GpukB+Q22JeTpmg3GepXVo+ECTgHxa?=
 =?us-ascii?Q?pWhX9FTHdrNOT+H+GAa+B27pOyqgqd+xkcPjQqthe6Xkb6uOMxr2yaTltrw9?=
 =?us-ascii?Q?QUUlDtApgTnUsv4SSNi9ZLdMwXGpdHBJWCzIECNbRsbGBotxj8TqxSK45hlc?=
 =?us-ascii?Q?L+1SaAm2g+yXs5Ns91LyWp6wTx8v08RHx0/8p8hoDqN5VUYY5uCk5TnpiFzD?=
 =?us-ascii?Q?E/FdrCjwZIPEe8dcjUNu6A+zdCAIda4PC0rloTYYkKLtWXEjwCq4SM64/iln?=
 =?us-ascii?Q?fbvI1SDfqJsZb8QCGzueCCTc4ULxtY+fRCEn7KVusGCq3yDb5QhTkXYdBPd8?=
 =?us-ascii?Q?Eoi7Y28X3eswf1JSGgZFYGO9tZPe8OuakATe4o9yz0T3or9nF4NE5DqSebkr?=
 =?us-ascii?Q?jF6Tyl8Pl7SRP9NyGzUESBae1NNH4FrATJFI3kGAA06zfdbai6TDpmM4sit8?=
 =?us-ascii?Q?pzcvN5p9Lwvv+46HGeh1hKHlSsrrPFDlhRun+918fFbstUrr5UncpKGAgHLe?=
 =?us-ascii?Q?sUC6/oWzIDve2lnXSt0XN72D0dzgxZJD/f5onSSWgjlA7IOH03Z32bKPu6j9?=
 =?us-ascii?Q?NNf9dRyAceAlm7Ydky+98fsxLyXh5AUhCwLR1FDrrNfhbtNbMCgTi5rK9hXe?=
 =?us-ascii?Q?TH8nFy3VMZM5OK6MMdDmo+czSjPKO2wWnZJtmv5GzVrIXB0OMkjYAk6RKGjJ?=
 =?us-ascii?Q?9+tj6omwEAWU2nV6To2exp/IG/iRamQt/B0yYEtnjK7XJ+Ibuxu4wjGkoSy/?=
 =?us-ascii?Q?eWajmo23kPNfrMbzhGn6DrgLOcCTYhdj/2MjY+koAcAZViPCSeOoGvEs6c6Z?=
 =?us-ascii?Q?f8IdT6rRWUlh/1rC+7RAxGJdx3NOKU2qhFZpIketOpIUuDjMrWjXsuV8ihc5?=
 =?us-ascii?Q?RvjIWg6QdlZkfhBaiRG67p7HFpc36oQc9p+XzWJd+GPTbq3BQe+eVX/1nLsD?=
 =?us-ascii?Q?eT/Sprl0SDMA7phTgdmRNQxkhirCgDovvZV3Qvi5yxALQifTtZlpGVIifQjH?=
 =?us-ascii?Q?FL/7u7gY31BSE84XGVf+iAkKplp4biVPCk0KHs+gFluw3vQzJ3gjBESpJTTq?=
 =?us-ascii?Q?ZU+SOBpm0LuD2uSbnpDxAjJndBy6/xGWg4B1EApdROhzxdQLdOAOwrOqxv43?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6621d91-e279-40fe-361b-08dca5a2b246
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:17.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K4Pn6GRi1pgDSnrQ3jahJFdYtU7kqnLUChDwuS95kHqaFwqx2xV9DOEFdYSW9qa7M3W9PpScSQXvi6g5Zvvqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This patch adds an initial implementation of the BAP Broadcast Assistant
role.

The core implementation resides in the BASS plugin (the BAP Broadcast
Assistant is a BASS Client).

The BAP plugin implements the callback to probe Broadcast Sources and
parse the BASE. Information about each detected stream is notified to
the BASS plugin, which will compare stream audio capabilities with the
capabilities supported by the peer Scan Delegator (discovered by reading
the Sink PAC characteristic).

For each match, the BASS plugin registers a MediaAssistant DBus object.
The MediaAssistant methods will be implemented in a following patch.

This patch also introduces the assistant submenu in bluetoothctl, to
enumerate MediaAssistant objects as they are created. Commands that the
user can call on a MediaAssistant object will be implemented in a
following patch.

Below is a bluetoothctl log which demonstrates a Broadcast Assistant
connecting to a Scan Delegator, scanning a Broadcast Source and
enumerating MediaAssistant objects:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:94:A6:A3 00-60-37-94-A6-A3
[bluetooth]# connect 00:60:37:94:A6:A3
Attempting to connect to 00:60:37:94:A6:A3
[CHG] Device 00:60:37:94:A6:A3 Connected: yes
[00-60-37-94-A6-A3]# Connection successful
[00-60-37-94-A6-A3]# [NEW] Device 15:65:78:B6:52:F6 15-65-78-B6-52-F6
[00-60-37-94-A6-A3]# [NEW] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis1
[00-60-37-94-A6-A3]# [NEW] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis2
[00-60-37-94-A6-A3]# scan off
[00-60-37-94-A6-A3]# Diovery stopped
[00-60-37-94-A6-A3]# disconnect
Attempting to disconnect from 00:60:37:94:A6:A3
[00-60-37-94-A6-A3]# Successful disconnected
[CHG] Device 00:60:37:94:A6:A3 Connected: no
[bluetooth]# [DEL] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis1
[bluetooth]# [DEL] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis2

Iulia Tanasescu (10):
  shared/bap: Add separate API to merge caps
  shared/bap: Update bt_bap_verify_bis to receive caps
  shared/bap: Remove unused param from bt_bap_verify_bis
  shared/bap: Allow checking bis caps against peer caps
  shared/bap: Append bcast sink pacs to Sink PAC char
  bap: Add API to get bt_bap matching device
  shared/bass: Add API to get GATT client reference
  bass: Register MediaAssistant objects
  bap: Notify scanned BISes to BASS
  client: Add assistant submenu

 Makefile.plugins      |   4 +-
 Makefile.tools        |   3 +-
 client/assistant.c    | 164 +++++++++++++++++++++++++++
 client/assistant.h    |  13 +++
 client/main.c         |   5 +-
 profiles/audio/bap.c  |  40 ++++++-
 profiles/audio/bap.h  |  10 ++
 profiles/audio/bass.c | 257 ++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/bass.h |  13 +++
 src/shared/bap.c      |  59 ++++++----
 src/shared/bap.h      |   9 +-
 src/shared/bass.c     |   8 ++
 src/shared/bass.h     |   1 +
 unit/test-bap.c       |  13 +--
 14 files changed, 555 insertions(+), 44 deletions(-)
 create mode 100644 client/assistant.c
 create mode 100644 client/assistant.h
 create mode 100644 profiles/audio/bap.h
 create mode 100644 profiles/audio/bass.h


base-commit: 73266377b0185c56c921b8cece257df428612d73
-- 
2.39.2

