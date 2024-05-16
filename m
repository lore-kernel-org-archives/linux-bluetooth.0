Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1114658E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864654; cv=fail; b=JGmXUZnMOQgmRpAes/HLSosbqusASQ+lJTROFguw9Q+V+TSzmqoKcnmAaW3WT6rZ/pUDjmz8BnftFoUwguU2oCJHbxYFg8SJXpjHUQ+HGl8UAaRYH4OywIS/1HCJ4fdNCkcwITk9J7XEcvdS0QZ8cjGCOWXM2Rxi3qawCP3P20E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864654; c=relaxed/simple;
	bh=D5LxS67YP5NZj/fkWROgOC+HmBaoNl7qkzsQOLdG024=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FBwEoFz78CBVuGhZOmS5u9ThUfOBMjOTcUBOGii7Hywjz//7CHn1Fn7AA1l4l1bzz+VU3tmOavyzHVq0dAzJJVK0iAl1aAzrdV8Wbfu2lJwXPL5DneqNZqEQqEcGfhTlxClC+tj/+N7y3ylmGHj9qWeVCV3klxhsD8OrPre478A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C9SaJ0dF; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C9SaJ0dF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSpKAs3/Qn3n36xW3hLJLedQW2107lBN+zKnmd1CBrkTNWFMKE+auvRUd2JcbinHuarBx/MX1d/k5AgPLmfQ5CT4p2eyuS1kVzeUKBG3v/0ADdP6wyopiWsG3mCJr4T60uqH6v4BLBNh+ulsaYNB5e50OgyYNk8vXTyLJIzVxzO9MyPkCCcxQkTuuJ72797yOGq0JaJPwbipquCpD1nxRR6nNFt1VU97HKGslm5RoZrLzUbMbSuR9Rz+MrDwHiltISjpR1QxgbG+axCMiu+ISdyRAx0xf/hLR90AkcCOHSL4Gd/Wi+zaLsBS/r4yxDyevW75/0oxw996PDlLPBEvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA6NCO/giJpdKyrtKj5I8njLip8EEvIz2lYwhwb4mtg=;
 b=G7tanAqtB8RNRX9ncnD+DHh5NhuvXWv8ndmtr+4gxZ6GyRy9e1KbKyJuzRC1JQfmbZh3L8zJ8WLOO1dRGwIc3n9uh457t6IqL0FlNI3liF0DITyX5tR8TaQjGqdE/cnx8DQfyA3BCUVPyLui2oSXj9obIYiaGxiClAsnh8onjNpcaeuc0K4xKp4xex5EotgkSrGWsctKMT1S4J3jr/G6k4DboDXb6LWEegdm0QUHxf+MSoucaLj65QbGzsDXWb6DRRpjCwSGH0LPkJy8cvYkIqC8TK3cfFzGdEGCIUzAtNeOPvZDVKTDud3Bq3dfGp2N80K5jXAEB+Q6VTwVYShgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA6NCO/giJpdKyrtKj5I8njLip8EEvIz2lYwhwb4mtg=;
 b=C9SaJ0dFURmhtG3xkLpgGoUbK52Foo0lzlLYOnzgnAdvBm1imEJnwxN0Dr3U1muqIF7b9TS3zbaKSFbUPb4mLuIeQKzdiIqxrky2PN3B48harUxlouAogsPRFNUKvwmfBPOrPGNliLK94bTCew6VYubLfYZ2ZI1pjWSVU9UG/Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:04 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:04 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 0/6] Create transports for matching BISes
Date: Thu, 16 May 2024 16:03:54 +0300
Message-Id: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::39) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a94dd5-56d7-4488-05af-08dc75a8a99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39hDBhhqeSxQs12933DzNIX9vT9S+TKc/wL4I49rLk5caSmiKduG29l0PTx+?=
 =?us-ascii?Q?ywrE8AEoMymw5hjwKYFJYNfh26h/jKYi6ffvoB1mB2x6AHLI65i6U3aKNNUG?=
 =?us-ascii?Q?JQBOgVSbkczBhBrX9/UWg5lZQdter+En3HRNR3OZIwH/wOMB/UnYrWWRLss0?=
 =?us-ascii?Q?tdPDWGEmDiRBc47nBatTzyuagQ2TkTIA1duTGp1vyJWmi0Y7fut61HmOXr7V?=
 =?us-ascii?Q?45AkE3lRBWToPwTA7K0I8ZkuKO9XqKgrKNZzRa67NkmRgdqmZfcRLfRyrZFQ?=
 =?us-ascii?Q?KmyFkLK0EpQChJWp3N4yelrSzmRTMPzIPEJ+0L+0RlxNFDWDZ7Soxrn8A5jz?=
 =?us-ascii?Q?6NR0ZaCvpi32ubU5Sq9j6g2u5dXp2N1y30DQhFDN1HLsLem85j5rCip8brgc?=
 =?us-ascii?Q?0fMYXjmdEob1Wj5UIsUznex9BIdefugVWLsucXDzce4nSrb106zAuq83nekj?=
 =?us-ascii?Q?TfYL2Om9OY5OimNpD2SXdIWWVQ4J5Izl7EmD4rxfXIjBY7Rxo0KeMsauGEsL?=
 =?us-ascii?Q?7F4NUiMbN6IU3G41gwvNIcqjpG+7f/YhSBitcNfcSPQMOXfoeQLbdq9oS4I/?=
 =?us-ascii?Q?Hs1tvFYIXmQBb+b6CPcmTnACdzKAIZfA9YnNAM3Frxs/MIVvmoO7hMIoUIHk?=
 =?us-ascii?Q?rs1HlQlAFSc7BKW8ANGncvEEAZgEhK0NxA3+JycpUjRjg8/DQcJ6I7O+aQa5?=
 =?us-ascii?Q?tETKPeW4uhZk37DMb/edU5ldXEhG8CDPWDIX3e7fMe31hV4d7D1frxWxVmSB?=
 =?us-ascii?Q?IXfPgCXNFja6+PXLZYPvhhSQZKotuSEYks0+yGYpaX4PPHCd4NYhcTL1MecT?=
 =?us-ascii?Q?QCoLMGr4pQOS5MFgYZNd9p/qq7A6PSPKZiX0/whHt1tpmqKv2NRbnF72WRLZ?=
 =?us-ascii?Q?6I34Pl2sDBpJfMqqK1/tRyJdbwK/u161xnAhwDN4VRzAPOwXMwsWi1Cjg3RY?=
 =?us-ascii?Q?0frQloCp9RleWM0trINs+qvJ9mciKEPiS40764vlntIszJpqdWGYnf5N7Ekk?=
 =?us-ascii?Q?3QFFHhIier0kpLzNxq6RuPes5CJpmGXxnHqW5UJxW4K6GMhZn1VrlAovDjMm?=
 =?us-ascii?Q?PqskKdsQ6AGIBw3QnMe8xU2R1G+R/Ugdu8tPRWqrMEF2yUB91Y2SrFSwzJbR?=
 =?us-ascii?Q?kSQfkfXoJ9gLTyaMz0c+gY3/RijkZXtQGfI6OUE8zizyLZmNR3BCWzOU1FLz?=
 =?us-ascii?Q?IHjOA5uBDRDypo0/OLq+N0z0vXEnlrNIPvisGFODw9NO3atQESkQOVxhMXzZ?=
 =?us-ascii?Q?0thhbpiTnSqyAT8CKQpm3vuLPkmGS9+Skluqps7R+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hTm9MAh6HORT5RQP8kzXV+vLKSPOVBnF73HHQT2qHWom8RQXivxtEolol4+?=
 =?us-ascii?Q?cAskZjkuWfBwVrizsDvounhpKNNSxktFvaNeUiXC9QEGplGBW5tBHtLnKGNB?=
 =?us-ascii?Q?4X4jUAwMD8+PLkvSICLSdZFWcAXysOSygdJQCYeQRYKg3i+gKATNRKC9kD+J?=
 =?us-ascii?Q?t6cm9io4HYjuZPE2vH8obM/S+fNp1H2w6PjHTmXVD5HmoWK2FN/G+sAJEFGD?=
 =?us-ascii?Q?drpMPiPHhGw/MdR4UPO1ajpipd5G2RZt6iGv5QalX7zyaebmwVLm8mgMZuYe?=
 =?us-ascii?Q?TC1P24OjXjAxneht+vP7DXwZub/fU/AjS8LtnWjTT0/J5Peocm56/fX4LCW0?=
 =?us-ascii?Q?qx6eNSLRN2CmzFhA2NE0pIRulkpK+KnBqyotWrD5e5IDGbY5aFm/K+LGXGs/?=
 =?us-ascii?Q?vmQ82zs5NNmdPBCluKyUM4mP7GpMZnmmakHLGpA6lzkYwWexxUEPJAylrGXR?=
 =?us-ascii?Q?Im7LWRRfYFZZWcIQ5NwOY+XELBhfDG9DcgKMyzgsW+t58CjBsxYH/uGiR4kP?=
 =?us-ascii?Q?B69StTxmCTRiUXLjo88wFsmzFmfEEn42zd4423w2sUKXJ/B+RlOutogVjllc?=
 =?us-ascii?Q?NISNsBLeh0OJvyfDPswvNv/4UMNCAUPwD0Zu0KqadVW8p/mSlbVZHJhfwK8V?=
 =?us-ascii?Q?qxTJQhvU0P9Ze10RhP+n8fDjfKaOBiRUQ0BLEN3TdSmVAlHVHG60dEmjDuSU?=
 =?us-ascii?Q?pgtNsYd7TiO1PtniLRt+M0Vz7OreWyRtEp5MKSokpdcXa9OaKiUVS2dmQapW?=
 =?us-ascii?Q?FTkSYjqX4e1KnyM47XtXz3EVdUNe+QuOw2/CarD0hodQwSixMZVIkFWYfXKn?=
 =?us-ascii?Q?n6gnbbhg857M7iL4Bic+Ids+TP1/LFeAHsUss0mT30dYfta8aAZtFdYqPMDV?=
 =?us-ascii?Q?9IwR4OEHCXwxxwiUDSgkjqLe2oBT1ALJzkkQcdlZSLrypFH7DhWfUOqN40kP?=
 =?us-ascii?Q?3DXoeYemWhEWp4op8uhH8Jy4q56BUeeYqfP/veS/JoGlgu+5paVu5LFkhPUp?=
 =?us-ascii?Q?YYR0akVXW/vgkpEiHPVbTrbbSJe8KH6YW+mQKwM1jm7H6X23uZzFXyeMMsph?=
 =?us-ascii?Q?aNxPixTlgOZyVje4EXczHwI3BZOlMIXEJuAATF4eD+SjG/i2MfWw012GxXEd?=
 =?us-ascii?Q?0Rz+hGkLpQGAUqWShPeOHvkJqXVmGtpXm3++0k6T+CWkPVaKjaJfzdWRf1Gl?=
 =?us-ascii?Q?Mm6u6o8Z/I3QjvXx7pkt2vFQtSjk1au9GbEJrVIKNWkaoek8ZP2KjRToQU0l?=
 =?us-ascii?Q?3fytt3qXqkXTAyd4lAsyjmJG5D2aw3ElfJw6wgmCvjGDM/+8V+aFN/Ct6ghY?=
 =?us-ascii?Q?V8TiAXCn9aMDwOs1wEpF3EJ5lCZrzdps7Tmjb5ToMFwg2gx0aW8fzOKvt0Q1?=
 =?us-ascii?Q?PzCE88LxLNbJnuNxixpDSUtuSTA3ZRyocmvxG8qZ5iNeeka2V1708KQdglhj?=
 =?us-ascii?Q?FlDidsE8cBgj+/1Xdwu9qJ3qSlnYpi/A4Nj6SXYU/wcJQ2FcmbM2qY1zV3Fp?=
 =?us-ascii?Q?yNPCrXltUGejULZF4iERq7r5VpMqyAYcNOD77Yw3XO58l2Q8yNGwZrwfrfFg?=
 =?us-ascii?Q?7P/TpQmnxvgbL8i4Dx+rxvYqfMhCMyS7f3vfUlEl9PnIJJfDAwxKi0LNwsXj?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a94dd5-56d7-4488-05af-08dc75a8a99b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:04.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3i6K14L37X1DDGYTiAh+jp18eCSXDgd1VOgxQ8OVrrGi7Q2lg8DQ4YpiniPnNNcTvv4Ifo5u+KdjpQXWPPoiAXkLcoGTS6Mi/+y79M2fzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

This patch refactors the flow for the BAP Broadcast Sink.
After observing the BASE information, streams and transports will be
generated for each BIS that matches local PAC capabilities.
Because endpoints are not available any more, local PAC (which contain
local registered capabilities) has a new list of setups. Each setup is 
generated based on the matching BIS observed.
Then, the setup is used to configure a stream which then generates a
MediaTransport.
The transport is in the TRANSPORT_STATE_IDLE state until someone
acquires it. The "Acquire" procedure results in creating the IO using
BIG Create Sync. The successful reply of it causes the transport to be
advanced in TRANSPORT_STATE_ACTIVE state.

bluetoothctl log with two transports being created and acquired:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 3
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00  ................
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered

scan le

[bluetooth]# SetDiscoveryFilter success
[bluetooth]# hci7 type 6 discovering on
[bluetooth]# Discovery started
[bluetooth]# [CHG] Controller 00:60:37:A6:AE:22 Discovering: yes
[bluetooth]# [NEW] Device 07:34:BB:4B:6F:C3 07-34-BB-4B-6F-C3
[bluetooth]# hci7 07:34:BB:4B:6F:C3 type LE Random connected eir_len 0
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/
fd0 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/
fd1 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[CHG] Device 07:34:BB:4B:6F:C3 Connected: yes

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/
bis1/fd0 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 8 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 State: active
hci7 type 6 discovering offm[seq 0] recv: 0 bytes #            1
hci7 type 6 discovering on9m[seq 146] recv: 0 bytes #              7
hci7 type 6 discovering offm[seq 149] recv: 0 bytes #             50
hci7 type 6 discovering on
[seq 2446] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis1/fd0 State: idle
[07-34-BB-4B-6F-C3]# Release successful

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2
/fd1 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 9 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: active
hci7 type 6 discovering off
hci7 type 6 discovering on
[seq 1330] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
[07-34-BB-4B-6F-C3]#   1;39m[seq 1331] recv: 0 bytes #Transport fd
disconnected
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: idle
[07-34-BB-4B-6F-C3]# Release successful

The difference from v2 patch is that match_data is not initialized any 
more, to overcome scan-build warning:
warning: Value stored to 'match_data' during its initialization is never
read struct bt_ltv_match match_data = {0}.

Andrei Istodorescu (6):
  shared/bap: Update stream management to avoid PACs
  shared/bap: Add function to check the validity of a BIS
  bap: Update BIS management
  shared/bap: Remove not needed function
  shared/bap: Return the local PAC when matching a BIS
  shared/bap: Add stream ops for get_location, get_dir and get_state

 profiles/audio/bap.c | 320 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 290 ++++++++++++++++++---------------------
 src/shared/bap.h     |   5 +-
 3 files changed, 362 insertions(+), 253 deletions(-)


base-commit: d9de306a28fecd711d3d2f88bf778f98f2772424
-- 
2.40.1

