Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26519AA4D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139769; cv=fail; b=IKqzbTOKxqOTmlyhEoFjQKvDhh2As1CKTgkEiaOmBUiDD7KZmmDgzlc3kYM36TMlsrv71rI7iHQ0Ce784YyCkgRRN92WsukyRHGWh8ryja+ua3MSvHJnlLe5hrHTFdtFnPASVypuZByC9Cf785484I82fxc6bt04YhKPbrioVQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139769; c=relaxed/simple;
	bh=fbSwkjuxSckBhgb+ghvm25tRRtGmKSTLwW1tQF4KA8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvYyqibN9ArI/MhU7z0NpQmAt3SEPkP0HOTDnm4bsLpT5rNQN0/cTYACV9MKR0WJOm7dEStyPz05/l/gxPXyq4KOMSd6uoGz0G6wiGPbFUEb6EaL0UxIVLw7GxP+0TrUDA5zHrt/ak0TwyZYIU0eD5+477V3xlpTFQohhLCy70c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hJQcljFo; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hJQcljFo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTJfGIw14H9WSEKHeuyEg32qb8PIsC94ppH2xTOAW4ZDzP7iTV7n4RZ5Iffyf0wkB4B8+hoWobRyQ/akYIuaXOaCViUrzQzZ0FR7ac7IUen+XiTcEo7YLb6Y9nQKMgx+0VRGkcjRHyX2q7GKZ59b6BKn0LV8XFx7Fy+lLF6IUJzolXVzPaQ79ILzcn5x8iA7A1Ys4mwR5YwPj/ucUcV4RtVawvYBTNEf1F6Hi60xva41siWiLCJieUjHqPegcU6LqFbOexGPM29n8tCyarC7/iOU2Ae48n8A4CjdzoiIud1m1zFUufo6F919nKyi1CBT8u1oTo7bhkLcRb6lP61rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou+7jPv1RdpPQobPgvQKt48iZEEpbZF1S2YT1Oj2jwM=;
 b=tcyLz7+U+VRa0vgxy9CSogEL+B973F/5PlyvCK54I24Na65ynPkiIW9Ggs43Ki9HHbBCx7M2RXC8CrXEsamlNt6ewj/Mk5KwlFgFi7xREoIf+BtVJOB0pcuL3bBHx67cB6XxeoiXu8ip91yAhQx9o6t9Mv7VCHrZkR5uWKGRWRHoN2n2isHhQZ9f2Kfspqa7l2GTCUQ+gRwLGQLqGiM4sgR+uNV1YLmwFxWMMuR8hdmNN8Bfe4vXn52lwuT+toEBT0RANScnBpnja2xW9LX0Em7LPU+t211Su+CELY6bK7UoUtrU7PDzgsY0AZF7Qr7d527Z/p2VMcNR05tCPqdxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou+7jPv1RdpPQobPgvQKt48iZEEpbZF1S2YT1Oj2jwM=;
 b=hJQcljFogLoHQUsIb8EGdx1S236re/d2+qqZ9FqsV7QElluMo87CyHNOHqSz5L9iLfQ0Dra7gOl/6tS6tIdJ1i4K8g8ZOmR8HkaXj97tDEp+O+GiozVQqTv7glOZ/C7JEztFTVFM76R0SpoEo8Lbt+XZH4YQUT94eN0WJNNZ7Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 10/10] client: Add assistant submenu
Date: Tue, 16 Jul 2024 17:22:07 +0300
Message-Id: <20240716142207.4298-11-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0138.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 822725aa-7262-4c66-c329-08dca5a2c33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DD5QiwnPvdBLlxndW6rrKBT3+qPHBxwT3+PdDLEFZk6TcbAmZ5l+cYMw8y+Y?=
 =?us-ascii?Q?j+dNsHGsOThvhSyDBK7Ijh0F9cF3yTXSzaglR7SIVq9/cw4b86Rns/5U+fSC?=
 =?us-ascii?Q?DOwo3exGN1R13kAUAc5WG7aTQ4uYKKSTsREzq54iExW2ts6hIVxxAKwwwnU5?=
 =?us-ascii?Q?JRE5CVRqfWuZL2KKQNUS+jQWmrW3Lo6Fy5MTHv4wePDDYNv6mdtk4+H4Sv4J?=
 =?us-ascii?Q?tRCR/HJBGmhdFWrScAQFG9LpukahhxLZCHu2odHeSsObPKf4AAd0QvUj+gxv?=
 =?us-ascii?Q?MxjZ7Qcs1uMYQkAuN6x6TMYZFbIgvwx4NoDnrsgg4H9wpux1PCOFjrmTQZ4N?=
 =?us-ascii?Q?Gn8yB9SaBOxnaEj5NLmnA2T7r2M2vdKWK1FVDOV+r9P1v3RgXJcnPd3fQqXV?=
 =?us-ascii?Q?BEcCoqC+5h46tw1rtr/Cg20tlAapM93fnUtx/p/TWx8MYWs0kJECw/kaycvM?=
 =?us-ascii?Q?791Udhmjj+6y/24BGrUAiU8Dkm7ksuDBLqDmBUk9ApocuRnTq6pNpEQateNK?=
 =?us-ascii?Q?X8/r/wXtixtpmBYw4On9mKKnVCPp90vPTLO6wN6vKrNHzdjLQZ2FcFXrObDW?=
 =?us-ascii?Q?OwbeXqJPtDU6cN7I1EeJM2a1wDG+2S16Id3oGaS+QHA5KtM9pVIZh5MEcfMl?=
 =?us-ascii?Q?xd9ntT9VO3WEup7ipBr9H3W7IDxKYlecuTH1pMLkDnTbsu0TqrxIlsY/A/EF?=
 =?us-ascii?Q?QSQ+cha173HOJRVJuI5fWV1DIXJvtHYn2YrMGwDJVZoSObnQV9hoUZjhLCf4?=
 =?us-ascii?Q?ZINr05EfNRM2SewtgMssWjAxbfk6GR+3P8wUiJAZzFq70xqrUHF0OdPzbG1A?=
 =?us-ascii?Q?kyz7dVxUyDSB5hg/AzKcaZwJfG7B6lOb2Ok6oHzXCXiwI17ppsCqZp0mQa/7?=
 =?us-ascii?Q?wMoB5H+32RZfAmoeMrBirDJ2zGU6MU9yRLOHDENwgUdeuwes8aNY3eY6dmxu?=
 =?us-ascii?Q?jYl7EZU6lxxrKjciYvzTcINP+Fg/9uBqZmi2LEcIW3edXcI8qkZbNwbUre27?=
 =?us-ascii?Q?qRkAO3s78poV6ikXnC8GXINcfLzrI7BuaX42eh+ESkYD0Qr1skffiqi5j5zX?=
 =?us-ascii?Q?UxDgC8J/+nmMGMHjCa+XYhJRiY3ZNB6NEtQpJMdt3q8KvEgIwPXSWjrBY069?=
 =?us-ascii?Q?gmBT2XZryxLQ/lbhGjEYfqJPTRaItwjN0Rtpb1h/4gspctqbLifKFkcs5Pdl?=
 =?us-ascii?Q?oIqIC6embL5PDhwRHrX97SNjFStIr154jVscsTpNXs9r5W3Cfn6cHUKLi1bj?=
 =?us-ascii?Q?Q1yaKCyPOYzS63khC2IZT4qDMtL+60cFXxU9CE4srFhyfoDLBgSVg2E5Otjs?=
 =?us-ascii?Q?mBKQ9yyZ2BJTEBNxKscRPMX+qqjjmzXcuz8xzoGomS4Btg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0erLgckzfLUVsjqn2tvrMveZ1+ycps3y2BaExV6oCYcNs7SmAGSow3F+Iwj?=
 =?us-ascii?Q?3std6CCD0zHHTxHtPw7Z15eQCJfiC5pK+uInAWTQeEEbFhwAgKcCH59qJcpa?=
 =?us-ascii?Q?o3TszuJkoNLsTAeCQGeFazLXbmvAvSPy3l9k5Z6zohqcbUxa2hXLa6ww8lB+?=
 =?us-ascii?Q?2boDu0Tgm2tv0MjjZYBN/Ah33XjUG/eJrAnwvVgwAy4uaAvb9Zmd/euKLwLw?=
 =?us-ascii?Q?w/7sFaMH0JjYmmvjUlwWkgLmAkEfa4S+p2KaL/5ZeUqF6kIiHjYILw3+kU7s?=
 =?us-ascii?Q?oVtGoxwbD92trDE7GiLOWdVKSMjBOz8UWrykUphpRPUtd/CNObzK/IPGeGU1?=
 =?us-ascii?Q?MzpTMZ7WSVquaTUJS4Q2PQU098Bht8z9OMVWKPEtpI+hYdNjkrg9c7Zvk/9p?=
 =?us-ascii?Q?qEuHdCHZTr0xyL0tkZGjQh6du+4TN9n/+Xi+PsrYuw3s7/gbr9/mQjQITl7D?=
 =?us-ascii?Q?AAQAdL7oej1VQE8FBQdsyzr+oIV869DfZJcoby0KmXIzxPcbLFwZqHWYc8po?=
 =?us-ascii?Q?Wdb/nka26MPnlg03C0xlnTNmfUCSiFIjMCdTEiw49pm6JWUXUDMYK3alL5V0?=
 =?us-ascii?Q?+SIlF0deZ0VQAf2hN21elA8qUY0/13BOW9gxI0ibGsfOiz3CeLcd8o9ITulS?=
 =?us-ascii?Q?5s/wZ80bn++1yElAqUPKwxKGkcHcza1bV64VzVv4fQRVUi8+Tx9gnjHkwxD1?=
 =?us-ascii?Q?wbjBwtKmigM0HfeRet+s0Y71LjfxpElLyrDIZk9rfGYRok6ZO8Ffy7okpUEM?=
 =?us-ascii?Q?7bU+E0mkSgb3Itz2t5tTLXCf7CUPoNm3iWXBAwlJXoWT9pGZanAlBiVsMB77?=
 =?us-ascii?Q?U+urLZ9QipoCdXhphRVf/89B63pdZI7jvRfJnXF8iiaDpMrfzKXF70fosOaa?=
 =?us-ascii?Q?teqT2t3L7sN/i/oRjZJSYXg6yKRY0uJrg1LGNDg7TKYpWV6T3RjZifZ9oQBH?=
 =?us-ascii?Q?JJV6dV4Jde2SmBld5uU9TyYkjqZ/0FZzowUsHfSYUNjmLA7e5D1Yyl6gUDOL?=
 =?us-ascii?Q?E79w2Azjb0lTowx5w0MwzJl9S72xxwSH9xuuCAoHnyqykr40/qqQXFbxNr8d?=
 =?us-ascii?Q?2xbT2puM5m53tXR2vcZjIH4U1rIrjERKHan/qv0v/gRlGooJybQL7FpHGDOj?=
 =?us-ascii?Q?K0q+ApphkYZ0G/vlc2ejvA2QsFQPS5dj1mxoLWpbjIb1QtHRhwQxK5nHH3cE?=
 =?us-ascii?Q?ejRbG1BRcgZ8De/4x/KHxpHeFDk94gv5VOkV1wA+61wtMF7KAtdp3OzR+elj?=
 =?us-ascii?Q?sJiK0Z5BudZ4/X6vbKKX/soCNrYtZbbZX+ep8IGAFXun21xtLQJmO/l4oYgs?=
 =?us-ascii?Q?1EhpJs5GkXccmwwJNDmpzzNbX8UReKCGT/o2JpMrk+/BEZvDZqPJFhYopF4o?=
 =?us-ascii?Q?IjAMaCZDSUnTWzus5IXyhVL7YLDEFlUf4mJVwxldBuYNoIJDKX5FWN+df7Dr?=
 =?us-ascii?Q?uoPiRRoDNqKlv9f8p/qPPqsAUJKMWMF2MoeyOgKpxM3NqVEp2EF35Au6kTqL?=
 =?us-ascii?Q?Y4GedTTaIQRR1I59SViHrwNPHobQaK87S78Y524AWGtDeZXIPE5YlpepVl0B?=
 =?us-ascii?Q?yPbCzDV1gOcLveaBGNVA30A3mlN7+6kCffPAWtE35WXg8/qC+0wZNv+kXlrU?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822725aa-7262-4c66-c329-08dca5a2c33f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:45.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM+SxzlcuHwA3vzV5D86r4XW5A41h75TZZn4ocYPqvVSg7tBW8T6x2Cu9xlv9Oi2FFHkpe5e6diV9m9ZEoijUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This adds the initial implementation for the assistant menu in
bluetoothctl, to detect and print MediaAssistant objects.

The current BAP Broadcast Assistant implementation can be tested
by running bluetoothctl, connecting to a BASS Server, scanning
a Broadcast Source that is streaming a number of BISes with
audio capabilities matching the capabilities of the peer device,
and noticing the MediaAssistant objects being created:

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
---
 Makefile.tools     |   3 +-
 client/assistant.c | 164 +++++++++++++++++++++++++++++++++++++++++++++
 client/assistant.h |  13 ++++
 client/main.c      |   5 +-
 4 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 client/assistant.c
 create mode 100644 client/assistant.h

diff --git a/Makefile.tools b/Makefile.tools
index 679c914bf..f4f9e82dc 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -13,7 +13,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/gatt.h client/gatt.c \
 					client/admin.h client/admin.c \
 					client/player.h client/player.c \
-					client/mgmt.h client/mgmt.c
+					client/mgmt.h client/mgmt.c \
+					client/assistant.h client/assistant.c
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/assistant.c b/client/assistant.c
new file mode 100644
index 000000000..69a955c18
--- /dev/null
+++ b/client/assistant.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2024 NXP
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/shared/util.h"
+#include "src/shared/shell.h"
+#include "src/shared/io.h"
+#include "src/shared/queue.h"
+#include "print.h"
+#include "assistant.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+#define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
+
+#define MEDIA_ASSISTANT_INTERFACE "org.bluez.MediaAssistant1"
+
+static DBusConnection *dbus_conn;
+
+static GList *assistants;
+
+static char *proxy_description(GDBusProxy *proxy, const char *title,
+						const char *description)
+{
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	return g_strdup_printf("%s%s%s%s %s ",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					title, path);
+}
+
+static void print_assistant(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Assistant", description);
+
+	bt_shell_printf("%s\n", str);
+
+	g_free(str);
+}
+
+static void assistant_added(GDBusProxy *proxy)
+{
+	assistants = g_list_append(assistants, proxy);
+
+	print_assistant(proxy, COLORED_NEW);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, MEDIA_ASSISTANT_INTERFACE))
+		assistant_added(proxy);
+}
+
+static void assistant_removed(GDBusProxy *proxy)
+{
+	assistants = g_list_remove(assistants, proxy);
+
+	print_assistant(proxy, COLORED_DEL);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, MEDIA_ASSISTANT_INTERFACE))
+		assistant_removed(proxy);
+}
+
+static void assistant_property_changed(GDBusProxy *proxy, const char *name,
+						DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Assistant", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, MEDIA_ASSISTANT_INTERFACE))
+		assistant_property_changed(proxy, name, iter);
+}
+
+static void assistant_unregister(void *data)
+{
+	GDBusProxy *proxy = data;
+
+	bt_shell_printf("Assistant %s unregistered\n",
+				g_dbus_proxy_get_path(proxy));
+}
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	g_list_free_full(assistants, assistant_unregister);
+	assistants = NULL;
+}
+
+static GDBusClient * client;
+
+void assistant_add_submenu(void)
+{
+	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
+	if (!dbus_conn || client)
+		return;
+
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							property_changed, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+}
+
+void assistant_remove_submenu(void)
+{
+	g_dbus_client_unref(client);
+	client = NULL;
+}
+
diff --git a/client/assistant.h b/client/assistant.h
new file mode 100644
index 000000000..418b0b840
--- /dev/null
+++ b/client/assistant.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2024 NXP
+ *
+ *
+ */
+
+void assistant_add_submenu(void);
+void assistant_remove_submenu(void);
+
diff --git a/client/main.c b/client/main.c
index f012ddd43..a96a42638 100644
--- a/client/main.c
+++ b/client/main.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
+ *  Copyright 2024 NXP
  *
  */
 
@@ -34,6 +34,7 @@
 #include "admin.h"
 #include "player.h"
 #include "mgmt.h"
+#include "assistant.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -3205,6 +3206,7 @@ int main(int argc, char *argv[])
 	admin_add_submenu();
 	player_add_submenu();
 	mgmt_add_submenu();
+	assistant_add_submenu();
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
@@ -3222,6 +3224,7 @@ int main(int argc, char *argv[])
 	admin_remove_submenu();
 	player_remove_submenu();
 	mgmt_remove_submenu();
+	assistant_remove_submenu();
 
 	g_dbus_client_unref(client);
 
-- 
2.39.2

