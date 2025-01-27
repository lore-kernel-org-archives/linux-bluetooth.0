Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F061FCFC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970220; cv=fail; b=aMOOuxxcBzVm8tk71hct6uEfBkSuMmonpsWZloT56BqZfvQNMH6EQlIGkzsQuOuv+deJtnJsWcNrXacq72k3ju9uIHNnTK/XjDSaYIJ24jMrbyF4SOVk7aCaVrcuReixio529Exavu9sfmW74JxxxqWvRD05qmAiWtDfSpGdHYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970220; c=relaxed/simple;
	bh=nwnm9zpmJ7TUkeTDkY4vMWIGYuJr1+3XMpbJt4vShLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upn1+fugB/fvzk9wu2kPnRVTgEAVcJF6WKPEhOu7mP0bWTgGh7g6E/uL+c4Dw7d3vo7ZhGcGEknebz2ULIhIdEiYObXRLIAo3E/TeakPfRy2va50/griiLLf2MRgaokkWSzNLq9DzlZ/198E/UK2jo9pcXr20E/de/vGyKCKBSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/aPUyhp; arc=fail smtp.client-ip=40.107.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/aPUyhp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAr3EV/EpCUkKiiXq+ISuN2VnTIB+e8QinX7W/Ho1GGQhg1BSJhk1ll/MhYT/T5SPxSPQk4I8wZdKSc2ImPmJXOSKdBe/hTvD5dpm4+nPB3QnEBcDlBPiv+wU+Eq3xCaw+itYkRjfxGB7hEvPL9DUPA4xDv3uFZ1juG1GA5Vg2sA3ai+rltXLMAz7mImb3xnIxb5wBgsC2ckaQdv/DfwCWqSFBwTDOAeOAl/GHDBRKT6mQc7PwUyqwS1x6JEqeTbQ2edLwB39otdYYwxFeV0RUQGpm/INgif2y6HHWloE9ZdVn2BGwSUo/xhOjhlkgoLvsWEGAl5STPksoBa4XHIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhMmerl8J8zFOZkiMKPwmHa44oLWHRqHLJ5/luLHKOo=;
 b=rZODS0tvJ58R/efLRZC1aohPee6vVagQLx6F2Up9nOZQuB6pxGDzzDNyYU69AyLpTe8e54dMXmSs+DnivUlELvxkhW2ajolm2e3yhp2mDjfQVG4VNHk4v99q958XjmbiGypiwbiY8uDVY0rXXQr8UAZnkNoDmoOAPhs6URlQ015lEBWprEjnnIre4xFOgZwqXToT0XkuZ3dBEBFmjkHn/YlsK+hFAuScBOweAOvHsyK2BIqC6BZ39bdC/FvhwJm9cefTCoYqjgMzlYKmhZ3L+n1Ne1AHurtDxU8fvGNMxhKZhFCf7xfTkUQfkgcmuH1L2daTM1Znavjp83vVvxNWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhMmerl8J8zFOZkiMKPwmHa44oLWHRqHLJ5/luLHKOo=;
 b=c/aPUyhpT78F0sTcxBEjWP9gu1YtiCy5+bG4Vv4UwRGLqbFZzRFHcqqDh4QqFZ7lb4g+SgMZ50vPc/xbV9pBUafUAHKCCoj2Z+UR0ncAckw7Hw7g5OLKyvuCxuSWm1yy1CZY0qdrj4JmBQfKLAMXoc8bYbOB9FGiOvyuWb3IHzNCTRwVvAnqpT6ybXVwF8+Gn/jDlxxIAzMBAQH1v8ttbROu+bN2NGMDtRVKaY6Ab/93tGMIQytO6VTvXtaxgCzi2xrAO9Tv0oeqtxkRLNitu3Ock6dVy5v//2YrcYJ0Mu/a9uzPCv2EvgjN00r9zhAG8LN0dYwqwNOa+McHIPxoHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:30:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:30:14 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/2] client/player: Rework transport.select
Date: Mon, 27 Jan 2025 11:30:03 +0200
Message-ID: <20250127093004.19268-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
References: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0177.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0309d5ee-2087-423f-b070-08dd3eb53474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pH7hvqamNVnE3akp+l4WutYYD3/T7RU/ZAlf0aSa/Z62LZRg/esF9dTgfKWb?=
 =?us-ascii?Q?HS0Nntn05nOp+lKY1IQEp8XYe4LBd7nfvJhaTKO3znXRWUbQdZC+4beUYgrs?=
 =?us-ascii?Q?Tt4da4j4QDj3rRm6p0u9vKiVhO5G1aqiJD7EEkYN8NVZUt0foq4/V/vHBrIV?=
 =?us-ascii?Q?u0hKziwyuRmx4HVfG+qaGJ2UMGE3BhGenIrsvy4hcaXjLBEJT1GmT08OGgGH?=
 =?us-ascii?Q?Bc6AZXJ7AYYquKsKTSVluFN4W7PrpKyIJfMZbiGnaPB6XOao0JAvKRFvI7sH?=
 =?us-ascii?Q?o4gDaC5U8G27Ns7Ri9dFr6Kp1KaL6QgrcFXWAvrlSpHi3CpZaM9+rJ1En/Ez?=
 =?us-ascii?Q?PzvzVgWpWpmDaoo4NQzViSxTR4vv0ZfhCFSR1veW7SlXcc55bS5L1G1GiG8j?=
 =?us-ascii?Q?iwXgOW18gEICtTQMIOTSQChlRTSs+O31ONykG4SDe/TX4DyvhtRnfoxV0w07?=
 =?us-ascii?Q?axywztC8Rk+3BJ9f6/YUjjWwSbFwEw0/8+XMfR3+T7doY2hTu5p6IqRZcYWj?=
 =?us-ascii?Q?cIs4B+gSeMmfdTxs1ge9b8gNWLl3dTQmWXcQibr/M1pTLT4T8aOltSrk5nMR?=
 =?us-ascii?Q?5T13D9jRQwg71li+IQQTYztWDFv21+BbSKKWXgwR0QqPacaRQVaCu5ifOval?=
 =?us-ascii?Q?BB7dRI5Pmy5IxgAk9kSJBYDyA+QQ3U+GCsR09p9dcYLX+eYFpGpLL23S/HJB?=
 =?us-ascii?Q?RNTpsprYLfByeM0mcxxzTtHkJfLcnjDwIo1S9f/zjXpeW8XbzQCo8WGRJrE0?=
 =?us-ascii?Q?fQ6i314XmXAKvgKr9ow6SQYr+rQQxR6YiLVI8jclFWMKUooJ8xs+JOPqeJOY?=
 =?us-ascii?Q?osN9jWKU3R1khNXZEtBITf/iuAPGaGDy43EVumhrTM49sIvc55y5yIMZylV6?=
 =?us-ascii?Q?Q+34qCIbaUFFCVd8ynw5rARBwUzVn3Ypt4J/i/NCA/C0alIqqi9SOXH2H4Kb?=
 =?us-ascii?Q?oKrUlIp0Lt9MFbctumXq8oBRnLd7c/+6MaHKkx4c7e8z4bmXGYA5CroZu/GL?=
 =?us-ascii?Q?snVhd4HOzlhMSt+ZRElpV92kNML78C4Iy8ckf1qj1qUZPXIkYUj2NDeAJDva?=
 =?us-ascii?Q?SWWyfje/3kEiJaFM6hiSAFtqm/FnnptufJv+yPhcd/rKJ/Rn/msozynLTJWX?=
 =?us-ascii?Q?DEmaBaTr8declLApHFZhtT/ilA1YfJWEZQ1JXHeNqD4XyNFKgJLmADRuNXp2?=
 =?us-ascii?Q?IRDPK+iS9AD+G7YbhHTHJw+hyTLqluShgMsE+aguh5Nym+DhrxSkdle9od0F?=
 =?us-ascii?Q?XAoEpqkgW8W/zaHk739LNUjJAs5GrtlYIEHsXVItGZf/eFZVk5MOTtcJeX9Q?=
 =?us-ascii?Q?COFHIs04nF/H/yKLGK5VTLdPyYC0ePk1mt9HV6omtNmC1bxmI2h1Lgpnhjii?=
 =?us-ascii?Q?Wx+vXpYCi6C4Tib2V//9NhN9YW9l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0l7kviKE+zqQfVq94iqYjLm4diyB/JDPPW6A+VwCDnN0M6SvbFtANFIu0XD?=
 =?us-ascii?Q?sXL2id/CTVkCnK8KicUkPl/xkYeyWs7vjy7/PBE3UvEo9KlNZJUuYZeSaU28?=
 =?us-ascii?Q?UGDOjoCQmArtstEC1+VDi82Zs1vZta0Gb3MPxaj8LpmHdftLT0Pemcf/EX5j?=
 =?us-ascii?Q?XpGr6AAEgjDp2SjEQKDZ9ozjzbLeRrXlLmDaAOUj7+Ofb9Saceo+taZexYty?=
 =?us-ascii?Q?yU0hxDVIvhW75v60rJUycyov6OysiZbd6I2TKWvcd+WF1neJ7drIFSNMyKer?=
 =?us-ascii?Q?WGxDjB0NAW3kdeojyX6kjJXab8Un7B5K9eSuz7lUhcdR/yABFLpIQprztSZc?=
 =?us-ascii?Q?0F5UAgP8jm95Vc32yAvfoyC8nE/s9Ku0YlHTbCIBOI8SKhhXVJI7e3ypGmVZ?=
 =?us-ascii?Q?UJ9aIlJdRUVpe/a578/xHV1lOJxzwgO1eYjXkJuPqUVwGBmfu2PQPCHvVDT4?=
 =?us-ascii?Q?aHE1pWv565PrVZgwszIpc3Bce74ndMUojgku9OzhJUgMf7QkoDSk7s5Ge6yk?=
 =?us-ascii?Q?kYy8l28hT9LSuN6unjW0D1a9zhQ5zQQcYqy35AUozrHNMRU177pXZ8byvStv?=
 =?us-ascii?Q?O66+ym6z5d3VIUcG/xE21Yn8VOI3QnFu1xShehSPWsd91uurS/O8Gt7a9txY?=
 =?us-ascii?Q?P8ashE0XkbOCdvh5Hj00fTN1EYLoxaFa6tCxRwAt3Ew1bba3T9txX4msn3k+?=
 =?us-ascii?Q?U0Z4abAN/uf33DMCLOTJ27fBeJF4uyRHQvX82RWmIII/91Kp0UnwQI39buS8?=
 =?us-ascii?Q?VjwOK0w4Cen7Kxd3iSTMYZHMSwGy3erDoyw9YZCtL9iePDgLoWTXAYLxxqiP?=
 =?us-ascii?Q?RVNWw65SckywZiQMAVNF3X/FFHy2o4oALXFZiekAcqFo1p1a2BhYeWkBYeCt?=
 =?us-ascii?Q?yAmQ7R8o4oPF6Hs0Gd8MWvgZrRtneSGOmw5u9su077dYOAnxEUI++dXdDrSa?=
 =?us-ascii?Q?+Pv1dxnQHSuPlpwExEWLJt9MdvfcNTe92ee/wtQp0Xc9gMsBElenv0nZBLFE?=
 =?us-ascii?Q?0rJgzzrxVqJL8P+N/ToF2OzVTeCNfgiBGSflpu+tL0ndZEB04ng2zIggLh7h?=
 =?us-ascii?Q?L3BZ0dvk52rhI/9nTHa5g9K97CRtZLzQ4zj3V/9yQyJFCGpYEOWQYJGaJocS?=
 =?us-ascii?Q?Zd7A6hAOZ6hFEkRSfAfzBFNXb2S1jHM9Vj07ubXCW23g3cjGS8Nd1EQgqxqK?=
 =?us-ascii?Q?ul9py8bOb0N6Q/yUZpMwIIGuN4pSNBLvmmZYdaUlzkuZ4KvPpUoElP4v76uJ?=
 =?us-ascii?Q?DC2FoB6S7KGJF4IdLISD13YUh/CGykSqQ2i7yVJD3PsX/Z0CqUgoq8sEkH4L?=
 =?us-ascii?Q?WkYyxdd+0jsQt6TKShT2JfDeFClLp5/849M8unG0WueRsK9ePopbYk1fa1CR?=
 =?us-ascii?Q?9Es164rxuPRz0XJIMl5MJ3g6B/htParN0plWJbgWyGBPGyMzRR+j37nW/ajb?=
 =?us-ascii?Q?feY5FcXueD/iJy8fKwxeqgrxY+46r5EP4LDI1cU7JgQLtFEQu5yL+E9YzZDq?=
 =?us-ascii?Q?riB9gM5YLorCl7IxlNWzSoM2eyibVQhlNUVlKjY5/AqNCZd8LteED5OZfzIP?=
 =?us-ascii?Q?xOc0p4XlQhj2+dcKLDRer4Oztr5IyaIjleYnjfaZByHcqYQKP30vbVPDQ6dE?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0309d5ee-2087-423f-b070-08dd3eb53474
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:30:14.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9WCDYxECslSazAvPg8KM4LA3x1jwxenR1F7gJvlCmguA2wa9t9qnPTOln3pSBUHjUDIr46kCpam5zEow90Aiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

Since the transport.select command should also work for transports
created by audio servers, the transport should not be required to
be associated with a local bluetoothctl endpoint, to avoid errors
like below:

[bluetoothctl]> scan on
[bluetoothctl]> [NEW] Device 1C:F1:FA:E7:B0:3F 1C-F1-FA-E7-B0-3F
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
[1C-F1-FA-E7-B0-3F]> [NEW] Transport
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd1
[1C-F1-FA-E7-B0-3F]> transport.select
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
                     /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd
Local endpoint not found

This reworks transport.select to use a dedicated structure to hold
information about the transport and its links, instead of using the
local endpoint.
---
 client/player.c | 156 ++++++++++++++++++++++--------------------------
 1 file changed, 72 insertions(+), 84 deletions(-)

diff --git a/client/player.c b/client/player.c
index 464a9cc14..0aab0fc2c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  *
  */
@@ -115,8 +115,6 @@ struct endpoint {
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
-	struct queue *links;
-	struct queue *selecting;
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
@@ -150,8 +148,14 @@ struct transport {
 	int num;
 };
 
-static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy);
-static void transport_select(GDBusProxy *proxy);
+struct transport_select_args {
+	GDBusProxy *proxy;
+	struct queue *links;
+	struct queue *selecting;
+};
+
+static void transport_set_links(struct transport_select_args *args);
+static void transport_select(struct transport_select_args *args);
 
 static void endpoint_unregister(void *data)
 {
@@ -2923,8 +2927,6 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 
 	queue_destroy(ep->acquiring, NULL);
-	queue_destroy(ep->links, NULL);
-	queue_destroy(ep->selecting, NULL);
 	queue_destroy(ep->transports, free);
 
 	g_free(ep->path);
@@ -4891,26 +4893,37 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void free_transport_select_args(struct transport_select_args *args)
+{
+	queue_destroy(args->links, NULL);
+	queue_destroy(args->selecting, NULL);
+	g_free(args);
+}
+
 static void select_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
-	struct endpoint *ep = user_data;
+	struct transport_select_args *args = user_data;
+	GDBusProxy *link;
 
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		bt_shell_printf("Failed to select: %s\n", error.name);
 		dbus_error_free(&error);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Select successful\n");
 
-	if (queue_isempty(ep->selecting)) {
-		/* All links have been selected */
-		queue_destroy(ep->selecting, NULL);
-		ep->selecting = NULL;
-
+	/* Select next link */
+	link = queue_pop_head(args->selecting);
+	if (link) {
+		args->proxy = link;
+		transport_select(args);
+	} else {
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 }
@@ -5174,22 +5187,23 @@ static void cmd_acquire_transport(int argc, char *argv[])
 
 static void set_bcode_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct transport_select_args *args = user_data;
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set broadcast code: %s\n",
 								error->name);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Setting broadcast code succeeded\n");
 
-	transport_select(proxy);
+	transport_select(args);
 }
 
 static void set_bcode(const char *input, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
+	struct transport_select_args *args = user_data;
 	char *bcode;
 
 	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
@@ -5197,47 +5211,39 @@ static void set_bcode(const char *input, void *user_data)
 	else
 		bcode = g_strdup(input);
 
-	if (g_dbus_proxy_set_property_dict(proxy, "QoS",
+	if (g_dbus_proxy_set_property_dict(args->proxy, "QoS",
 				set_bcode_cb, user_data,
 				NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
 				strlen(bcode), bcode, NULL) == FALSE) {
 		bt_shell_printf("Setting broadcast code failed\n");
 		g_free(bcode);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	g_free(bcode);
 }
 
-static void transport_select(GDBusProxy *proxy)
+static void transport_select(struct transport_select_args *args)
 {
-	struct endpoint *ep;
-	GDBusProxy *link;
-
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (!ep)
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-					select_reply, ep, NULL)) {
+	if (!g_dbus_proxy_method_call(args->proxy, "Select", NULL,
+					select_reply, args, NULL)) {
 		bt_shell_printf("Failed select transport\n");
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-
-	/* Select next link */
-	link = queue_pop_head(ep->selecting);
-	if (link)
-		transport_select(link);
 }
 
-static void transport_set_bcode(GDBusProxy *proxy)
+static void transport_set_bcode(struct transport_select_args *args)
 {
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
 
-	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
+	if (g_dbus_proxy_get_property(args->proxy, "QoS", &iter) == FALSE) {
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	dbus_message_iter_recurse(&iter, &array);
 
@@ -5253,7 +5259,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
 			if (encryption == 1) {
 				bt_shell_prompt_input("",
 					"Enter brocast code[value/no]:",
-					set_bcode, proxy);
+					set_bcode, args);
 				return;
 			}
 			break;
@@ -5264,7 +5270,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
 	/* Go straight to selecting transport, if Broadcast Code
 	 * is not required.
 	 */
-	transport_select(proxy);
+	transport_select(args);
 }
 
 static void transport_unselect(GDBusProxy *proxy, bool prompt)
@@ -5278,58 +5284,52 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 
 static void set_links_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *proxy = user_data;
-	const char *path = g_dbus_proxy_get_path(proxy);
-	struct endpoint *ep;
+	struct transport_select_args *args = user_data;
 	GDBusProxy *link;
 
-	ep = find_ep_by_transport(path);
-	if (!ep) {
-		bt_shell_printf("Local endpoint not found\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	link = queue_pop_head(ep->links);
+	link = queue_pop_head(args->links);
 
-	if (queue_isempty(ep->links)) {
-		queue_destroy(ep->links, NULL);
-		ep->links = NULL;
+	if (queue_isempty(args->links)) {
+		queue_destroy(args->links, NULL);
+		args->links = NULL;
 	}
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set link %s: %s\n",
 						g_dbus_proxy_get_path(link),
 						error->name);
+		free_transport_select_args(args);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	bt_shell_printf("Successfully linked transport %s\n",
 						g_dbus_proxy_get_path(link));
 
-	if (!ep->selecting)
-		ep->selecting = queue_new();
+	if (!args->selecting)
+		args->selecting = queue_new();
 
 	/* Enqueue link to mark that it is ready to be selected */
-	queue_push_tail(ep->selecting, link);
+	queue_push_tail(args->selecting, link);
 
 	/* Continue setting the remanining links */
-	transport_set_links(ep, proxy);
+	transport_set_links(args);
 }
 
-static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
+static void transport_set_links(struct transport_select_args *args)
 {
 	GDBusProxy *link;
 	const char *path;
 
-	link = queue_peek_head(ep->links);
+	link = queue_peek_head(args->links);
 	if (link) {
 		path = g_dbus_proxy_get_path(link);
 
-		if (g_dbus_proxy_set_property_array(proxy, "Links",
+		if (g_dbus_proxy_set_property_array(args->proxy, "Links",
 					DBUS_TYPE_OBJECT_PATH,
 					&path, 1, set_links_cb,
-					proxy, NULL) == FALSE) {
+					args, NULL) == FALSE) {
 			bt_shell_printf("Linking transport %s failed\n", path);
+			free_transport_select_args(args);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
@@ -5339,28 +5339,17 @@ static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
 	/* If all links have been set, check is transport requires the
 	 * user to provide a Broadcast Code.
 	 */
-	transport_set_bcode(proxy);
-}
-
-static void endpoint_set_links(struct endpoint *ep)
-{
-	GDBusProxy *proxy = queue_pop_head(ep->links);
-
-	if (!proxy) {
-		bt_shell_printf("No transport to set links for\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
-	transport_set_links(ep, proxy);
+	transport_set_bcode(args);
 }
 
 static void cmd_select_transport(int argc, char *argv[])
 {
 	GDBusProxy *link = NULL;
-	struct queue *links = queue_new();
-	struct endpoint *ep;
+	struct transport_select_args *args;
 	int i;
 
+	args = g_new0(struct transport_select_args, 1);
+
 	for (i = 1; i < argc; i++) {
 		link = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
@@ -5375,26 +5364,25 @@ static void cmd_select_transport(int argc, char *argv[])
 			goto fail;
 		}
 
-		/* Enqueue all links */
-		queue_push_tail(links, link);
-	}
+		if (!args->proxy) {
+			args->proxy = link;
+			continue;
+		}
 
-	/* Get reference to local endpoint */
-	ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-	if (!ep) {
-		bt_shell_printf("Local endpoint not found\n");
-		goto fail;
-	}
+		if (!args->links)
+			args->links = queue_new();
 
-	ep->links = links;
+		/* Enqueue all links */
+		queue_push_tail(args->links, link);
+	}
 
 	/* Link streams before selecting one by one */
-	endpoint_set_links(ep);
+	transport_set_links(args);
 
 	return;
 
 fail:
-	queue_destroy(links, NULL);
+	free_transport_select_args(args);
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
-- 
2.43.0

