Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2012F581
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827152; cv=fail; b=H8MaGNrcVQUb5snTwYNSWRPaT1SWAUVHO2WRhm7oRhRBFrWxEUGtyA2AdHnMBRzSMxRHbZ3XmmjOOvx+Pg/ieEXP+yOHnJTzlG6u9DAwR3yECqjOlU0a37sOw4jkW7iC7GZUq4I7nMxzlJJ5dGREJIkECjpa2kNWKVsjNGrvVh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827152; c=relaxed/simple;
	bh=PVp5jfQ1XEOe7twhqGRJlKda7bP4QW4AE3VqnC3YbSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E59GFMbue36S4AbmRV4drbGJj3Zl57Xtv+A7Iqsl06xXic0qnopX7ZTLKGf9CEaUftHoBtEwCx88BXqYhfr2KoEuBckgRPHrk6+akumoXjSDlLkRVWdfGGb8Gsjcrd9g3OkYldSp+pby5LDIQYHTL15nzg+SOhMVPA2f/3E3WDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmH0QgYY; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmH0QgYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcW0h20A18+BxNnANVGTpZvz6jMbm53s2KIZJ79vxHriu5kA+Wk402652XliF0vbF6xJVoHquxWSF7rle43sUhhTgJNQxmB/cMofpkF0ONnd0CKBi1Ze5ziKYqmwA12mp+TjPhlof4ywN8qk2C2+3ktnvS6ECeiT/RhUrb3vWLyJPwQ32Vdo6YXp2h9yoyteUFBesasHazZpwhUyLB7lUIxTGRxL401bsl/DFf6Wh9r4/sjAeRAsNZ4rmI8Ip8CBaV532+vvPByZ7Bw2pV7yvLnDDMUr+qwWkHY6LlkeO85eUQldS6Pm7ifW9kwcr4XB6dSb3TMvU8fCkRTz4mrSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmkuZUUebJphisEp0tzYvp5q7ksz+ZFhprqI+/QXjMc=;
 b=HkxhyU6zMnvrdvaGXLTgm9ny1FsWjmoQYxG4Pl/nIaD0fc/6nixKHeBXtfO9EE71EgYy4q1n+YQlsfqKPwqie/AyHLBaxWg30+HMLr8Iv6Q3Ki2wYVyU7GcjJPn3Ow5urveq47+NO8MHTpAgqXNz2Kq5rZG4gn5ASW4BMeyVs/eC3Qf3Tcc5StEBi99CReMXPNPyEM5oSidospRQ5+JttMcxJopsqkegZvrpdqksJ2HVgmpsCouQS3F4VN699ljBCZt1gqHZXnOY1ctvwAzmOxyI7ERvcNKBgogUpHCBVgo6ypE6AMNY96WsJdpsy5EBmBOUb90FBAb/CK/p3O83uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmkuZUUebJphisEp0tzYvp5q7ksz+ZFhprqI+/QXjMc=;
 b=jmH0QgYYsIQexOSAiLOoIeO8P5Chz4N8P5CZpKmXlhDfjCJCrkV9NcfmAs1UB3j10CcQnTBU3AvQ+LQ5jxp983++cfkU1DymP7tmkaYw+ewT6NxAfbpqefvS30ilJOb6fiwOhLTMOIAT+vAQwU4cVev+eRPJ1iG3h3AuFysuzTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:59:08 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:59:08 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] client/adv_monitor: Remove shell quit from adv_monitor_register_app
Date: Thu,  7 Mar 2024 17:58:48 +0200
Message-Id: <20240307155850.68395-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
References: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0220.eurprd07.prod.outlook.com
 (2603:10a6:802:58::23) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2c54e8-068b-489d-602a-08dc3ebf859c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwzkznNGa0S21FUXQrqBrskMOEJK8JjD3I9PmplWGysWXq7cFGy3/d2sCf08IGI7ZuItpLI/RBYpxWT4LYW2jH9P8Cm8/REWO95bfwQjoch5dX81Q4wb1N3uGgAVRUWsI4MyjdYZobZ8ud59faYetNvnBWgkt81wDoMRp1gR4NRr9vmLy1I6vU726iFT+3KadX/6Uo1mcHi67DMPd5Qqdbt3WCV0zln0wB0IFH/7v06AwSMZGJSYf3QXC8GgvUZ+4pegCdCL4fi/7BRCZSO1BS35uFeFJ2IhIFUzao1M4UsFvUmyxj98TEFNFmcpa2CmJtLD8gwXZmOrid/wTcnppTpD8BbqOiMHLm9tII40phbQHcDuxwlP9x5WPIJ3frn/xe1jlGqIfPwpZgolFEQ0LOlRuvqzdkteMJm2vJrrhIrn5FACP3GbpeqA2Gmh9ocBWN48x5SKgqL7jkQCizGyQjRj5P/Q5bSzG7ptshwegR2pLO3C0E2SQBqP3k93BPaT3wLKfyTlnvD/iuGOK0lo1IcWi6tbmK8RycEySHURc772C2rxwAJR1atHdqVJ1xm8QXRwfAzUfUTOmVZWmE9O1bvofwsIFShQ00K/ZQDUxut21uQZGzYWjXUdAkh5LYc7FSXdTa7RNQLAMvXGzouDK7lF1qgL3P5OhjusrOFyigM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reW4lj3OLbuLouZiM+ZHFml0K2RsERKSFij75F4OV2M/wJFzT28Jt6KM+oty?=
 =?us-ascii?Q?HKqFWtqBQ626cGXY0z1l9ShvBw9xk/hpZnMnpr6ADLgqD8TvBtRRlOGPNZJv?=
 =?us-ascii?Q?AdHkcjjQVe3GMS/MYvrq1mGf5uZQmFapKgP5jRPsHRlLP2qv9v1IHdX5yJq0?=
 =?us-ascii?Q?wZGeyGbwGpgw4qeS/gO0SCqpweiithudEyNRlnshiiNjPzkqOnmhIV/bskv9?=
 =?us-ascii?Q?WjbTgsu++NFbVJco2nWlnUu01YzBEDRb9mwN+0+gdBDHdaCTQbz7wwjeRRrK?=
 =?us-ascii?Q?M1oCPh3yS/QBsiGNmQm+4witxITkhhdKlRZKnlo/UxJNSAohUwAUMEkKIPi8?=
 =?us-ascii?Q?mE2es7vKF18iZmel3EFmiTv8kvVBUFijR7yk8yQozDmeYGE39s81e8zHDQs6?=
 =?us-ascii?Q?TdKdCPQVk2tGOYNus/Pyzo2nE3hmpYpCi2xhqTPhiAqQ3msisMHB2f25QEPY?=
 =?us-ascii?Q?gHIuM6jltpVwm3JN2l1xRK/3maJbxil0VU/pVQxjRa8B19P/r2wGaL9zDjxM?=
 =?us-ascii?Q?eJ/cOjJ6NcFaEzbmOJYZSswqM/YrLizdI2pYxjvPNkQ4RAHNGEkfTNvcT8wY?=
 =?us-ascii?Q?Gnemx5SiHGLGfDDSYDj8Ye8fdCsaRCdVb3ykeiGoVkZ5DLVxWRvRXtwUU6iY?=
 =?us-ascii?Q?mNPV3mRdEQjYNUbSlZFw/Cy25e6kWHpSOlDW9ct0+YiKUMlaihG7Rdwp2tIS?=
 =?us-ascii?Q?zkKVSLlMgrBvKW85Ad+Q5707lZ2XSUTC2ntrolCUTVGS9l6mNkKi2Uz2iwKd?=
 =?us-ascii?Q?mgVWHcTZFef73dUUFxgf4cmL7IGnJsvqBgLQ2i/38yErBZdSKbaX3DqCkK9q?=
 =?us-ascii?Q?N/HDxVCYe3gIEm0LulYD4N99vlYNyEibqXAGoxG2hXLJ3U0irjtA0Q49EzxT?=
 =?us-ascii?Q?JjYPMmqytDXjT9Jsm31i0/tuCteT6Y7xSPsHgkX7J0C4KZHkbbJEvrRa8f6z?=
 =?us-ascii?Q?or03pscw+k3yp4ucXBxM1Qy36np62LHAy+bFk2WmobjV1A3fNe/zq4dO+joo?=
 =?us-ascii?Q?k0dtg/lbbaKI3bmMmyDJCbOzZETwggX4mVAtFUwl48DDOMYi4nW7fmwBM7D2?=
 =?us-ascii?Q?ePZEpIQ40kNANC9wMhIpvK9+rOO5cAnKM6qZ5kHanT4gM6SPfp6hGVtHzCOH?=
 =?us-ascii?Q?6hzWFi2WvNLj3AeInXQWnXbJxyV0cWp5Im8sNjxQ9fkXFurnwpDuZwSkdBd9?=
 =?us-ascii?Q?svaNWTy79GIAwBIpD52soW1Bp4KWpmDrtCD2xe9YeAYF7sEM59V/4LU7X1wh?=
 =?us-ascii?Q?Ztqj745a71SaXKK6QfgRmxo1zHskCVzgJFY3kV3vKOn6iocKNaWPlQqUbZD8?=
 =?us-ascii?Q?/iKcO6mdmqkNuACCN11YmSW1Hwu++6k4fEwQvsmsI9G3kJ8OGE+/YZsv7kQ6?=
 =?us-ascii?Q?9foV8SdoNDrBM+t/MuygNdhFLd3/K2bckOgnVaCeOev4sN8BTvvGzbDejmaf?=
 =?us-ascii?Q?NlgF/SMLybszCoFAXVgtSWmae3B96YUntS3CsByhC0AYuMwE/Vg+VtVTEsKl?=
 =?us-ascii?Q?rFznTN/ARlXPunamqNDJpjfbtIhpiCe7raNpXHPKaOiIZ0wmCenmJW0rxfxj?=
 =?us-ascii?Q?MhoU7cz18Racdu3ixwL2jfh5osIzB4dKcYrBBbrqAWO9krGuRrjdqUyUp64J?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2c54e8-068b-489d-602a-08dc3ebf859c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:59:08.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91dsn0j27wUG9eQ6SkIJ7KL6+uPfMSwTVc5hLrN0ail5158eG4ZUVhZuhXEOHst/pszEikeEN2ZPdL0QYgqgfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417

In adv_monitor, adv_monitor_register_app is called when an advertising
monitor manager proxy has been added, when a new adapter is added.

This commit removes bt_shell_noninteractive_quit from this function,
since it causes the shell to exit without a user command having
executed.
---
 client/adv_monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 792379fc4..29e670960 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020 Google LLC
+ *  Copyright 2024 NXP
  *
  *
  */
@@ -372,12 +373,11 @@ static void register_reply(DBusMessage *message, void *user_data)
 
 	if (!dbus_set_error_from_message(&error, message)) {
 		bt_shell_printf("AdvertisementMonitor path registered\n");
-		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		return;
 	}
 
 	bt_shell_printf("Failed to register path: %s\n", error.name);
 	dbus_error_free(&error);
-	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void unregister_setup(DBusMessageIter *iter, void *user_data)
@@ -408,13 +408,13 @@ void adv_monitor_register_app(DBusConnection *conn)
 {
 	if (manager.app_registered) {
 		bt_shell_printf("Advertisement Monitor already registered\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return;
 	} else if (manager.supported_types == NULL ||
 		!g_dbus_proxy_method_call(manager.proxy, "RegisterMonitor",
 					register_setup, register_reply,
 					NULL, NULL)) {
 		bt_shell_printf("Failed to register Advertisement Monitor\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return;
 	}
 	manager.app_registered = TRUE;
 }
-- 
2.39.2

