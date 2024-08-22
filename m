Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DB1CB128
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332392; cv=fail; b=fOcUxspJtFCdetHTtxoGocKuQJlxiIUkH2kbZ6Ws3KgzRD+aBJNn7wyKMY3EYB6ApU8I2V76CnmYD0BFm5/UTLDlABZiSQ6KhqVnruKKot9DHcwOsXMvLNW3sJ5vLJGaZececAbBqK5cq9VU9AVQYv4bljEGBfgAhZxHkcsIaqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332392; c=relaxed/simple;
	bh=rJ3EvRKsw8u5Pplp12/DuA6GIw9y8cdjcM+1ss2FTqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1ui/p0YB9cAMoav5wUVEFx+H4Z50AQ0we5Vf1BTGM8v3mppnRzLeJKOqDFt+38VwNjC5DbPpKaIwv/BrxD0+8Uh8NmlZuaZWxw3jKhrD0qzCmgVsXJI4mfHyy8JE6NtxxQjQ0dkCQrOvEKBLtespzbzW914mlqyOhRUJZYtF9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ko89zgTm; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ko89zgTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdKVauhoZliW6VQ+zMM7AZ0QEJUUH2Xk+WA3f8/IjOnQk5vhQswS55suGH/BDEJGD8Mp60b/3Dli1Nq9PFLKZb7LpUQ5vq6ZbRqlziWwnoHygHiBPeD94wudXzevw+v6xlZIjRj3KDecLmZKem1IAZNLhrrg9qjDwCh0ooSS2eIyQK7VTFxhsPKcwEmiZL51qlN+5xMwQQqofAgJflgK6rCZeZCeyBc9AAWaoHXG8yqVc/g6V8WrlvY+Hgh1JC10QcapahF8+RH8Z1lXeO4IPoUyBGmfK7yriagNCrLiVg85So7IRNPspN0byyj5gpB41YvczHCCKAbaDscgYCsckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55NUroQtZB8/uKmFYWoyR7iVmGqDZiLtyA+wZoMZkFg=;
 b=V2luvNT76FjxbfD469Io+R31mjYvXI2XiA+sHc3PF3cSdOiXPDMqZcEjfhm3vv/hU4/cBn13vePMYMGNWT2riMaH1tZTGQeTLtDuZ1MiFeVvjTFnVU+bCASxuSWV76DunMehBg+GN9ber3o4xH/sN4ZFCB8UYM/uuPy7vn1mRE4fu2bFZo7hwYbTYw16RUk6oOaUXv3nyXSZJNYKVQOQVuuz8XTqKo8JEZ4ycMRAUrdM/Q4q17/RvBIuVTcOFGUdcUYnvU3rAr+3a558yVxQqbrXoHMbVA8uGomHdpsxn2vsHXawgDIWHgjZ63QPx4p2JTWjBzoMGmq+wjARa/fztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55NUroQtZB8/uKmFYWoyR7iVmGqDZiLtyA+wZoMZkFg=;
 b=ko89zgTmPsK6v0ea1VFJxhfTgHukx2CtD6pe3Vlz2yj4uJ0tdG3Q/+OTYZTpfGxhScD7f4bTKPf7lkQDvfqan1Qq52mK3nP2RE9Brpyw9xuW1P2MaBVTAKgkBorSFaqsV0D/wRstRsffHwqId3ADpncglwRW0lZmd5/OR7EX7k0wdk9+yVfdTIxw4JwUH6pIENtlrgRx4ysi6HNM1sWmYmUk07VluLWUYd1+GkbRsSIEhbPCKeuOAF0SKw05AHBID0U6NUSs9yqvYa5F2DiXoPrr+D2r+lG6s3MpboL0mZDwc6+UiyGKTZrrPSXJxnEg3BoajzsT0nIsbkVvtkfIgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:13:04 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:13:04 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 7/8] client/player: Prompt the user to enter the bcode
Date: Thu, 22 Aug 2024 16:12:31 +0300
Message-Id: <20240822131232.531952-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fb1c1da-c093-404c-6a3e-08dcc2ac27fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tjSvpyoBR46Bp8cxOKo0eGAm4TtVH5I+EENaGZBnvykFUEdg+KCB+bLjM6+?=
 =?us-ascii?Q?mrw+rXZjyHZ45Wf9icnMlHoUh54QN2lp8l+oLENUH60gZa4n7S0WJdSW9XVk?=
 =?us-ascii?Q?Y15Pe9/xZkVRW2qwwrk7kVxky8u+eDWkNyzJVmneX7B5fo9z/QkJ83mEO1Li?=
 =?us-ascii?Q?4QVFItvJgbT7zMGIo2v2Y/6ZAE/T0lBv026qhEa55H7YXFEjwxVBuCfyg47X?=
 =?us-ascii?Q?ODk6PUQdqhre/wcMpIAie9hNxaNsBONpzfPK/jhHJS5wEPmIovibBwAasK8d?=
 =?us-ascii?Q?A3YPpogZ3iTQuf1gzD2z0BpqQqNz9ArrVeCVR7D0kc3y6JNv/nWc1fUg6UO5?=
 =?us-ascii?Q?bwnqooMqPGG67rgY8RxroMQQsVnBDAiLQ3vHTjfLWrI9TpiBMT6AFUa0EO1p?=
 =?us-ascii?Q?Muhtl8GHnIny++OXsD/tvakDc07HrwfmgFNZNBsg8iHgsQVTQeEcCP6J0z58?=
 =?us-ascii?Q?/SZ9VQRJy0m6t4ARo2ZSuTlcjTVteY+GRDUZhnByuVKdR5+sBIIay+1WFPaV?=
 =?us-ascii?Q?X+NmVPErvjlmpLMTHXX1NqxYyYtO46CJ+/CjnmYd3VWOFSBc9yPOHQD6trm1?=
 =?us-ascii?Q?fSDQrvwFFLr6+tCJTWh0booWwjFzj9GHfr0xCRZDdxQdFAsLnTDNtWZPVX7E?=
 =?us-ascii?Q?CUOCO3ggXja5W1jLSqDKDKlV242S2q1QMqjGHZw0sZBR/SL0W3aCuZpZYYmu?=
 =?us-ascii?Q?rZWydd89HGEsojUR/aqmnKFlGHkm85DTSAAkZMuYIx7daRxWwINQkqIhtaLO?=
 =?us-ascii?Q?YCNVKUpRjDkMzbZS5DzAeatMTtcc6L1l2anYyFEAam41dD2W1MD+7AFzZfj2?=
 =?us-ascii?Q?UB7thDk0iXcydH9hN2PCPuGrySAmlGJZYCYiP68MgZJR55NV3ab6W30ZJkzO?=
 =?us-ascii?Q?GGH6qvBDluIEsJgkmj4CjWjVwESolDt3RjqgnP3t05pOCSaQ6a4RysNee6QE?=
 =?us-ascii?Q?2h2FXHeStCoeAFrz7NP9x9Y5JvJnBE1qjDjMc7Ea0ffz2r2IwRyT6u7BDHoj?=
 =?us-ascii?Q?hlF2jmAOPeYEymdpkCAHr44Vgk7QPCgLjJ2Eunolj3zZ8uY0ehiqDUc5L+wY?=
 =?us-ascii?Q?YHdyeXerskgUDBXdNYG9ZQMmy/0U7dQzGYBFwDJqm/wz96hi005jA/xTM5+9?=
 =?us-ascii?Q?ccpDUPStVy90rCqhcbTumHNqshJdZGeV+JOL2s642RHEPkqelJGsy+xaVCOX?=
 =?us-ascii?Q?9hQNzwqk80iPwIGC1I/al9Hu2j6jSUNyTfMStp+plJvZ8GcSYFWtvYpvmxTj?=
 =?us-ascii?Q?s2sU5xeRTTz0Gm1ouYTZWzgSblbAT2dY1pEDpvtEsBquGhFNJrHwo23GOLk7?=
 =?us-ascii?Q?8m5X5utq32sSLMeAWu+pP9z0ryloV35R29llPMEpiz5CAdSOKVlbssLPFTND?=
 =?us-ascii?Q?S8Ne/kmf8tkYrVYbrHk4QT8LGOVBi4A6tH6AlflxFO/0r/nxQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ViR/Ht5RxVIGq4gWj30IIRw4DyikuklpJ0YtPvu5KX0tETSmmU9DWhXTD/d+?=
 =?us-ascii?Q?OzscZPW3LCus1g9pwWkbga3pHK3EP10Ljb8WRCw9KlZk8lC6NIj/GvudY/UG?=
 =?us-ascii?Q?ZFFLvh5VT/kzVhvSUBMI8ECl8Qs5cBQFJlDsi29DRa+dRa/n/b1r1uzvqkmM?=
 =?us-ascii?Q?RMlUBYXQqkwLKsksiVhAf80wpfJ30UW4A/e1UDhkCl6kG/rqKS41c+IdpInf?=
 =?us-ascii?Q?urQJKMb3M+Wm8CT5+iC0zF+P7wjQ45CVtNYrOw50b9kPeoS+NvMMGyAEaK3u?=
 =?us-ascii?Q?f3Qvy+yGaLBicM40utLBErgmsz7QsmgdRqZTXQ1A1Z0YDFf4k0ybsFRuPj5G?=
 =?us-ascii?Q?sbU5/IHxigtDTcjDoVU7n3mATVu9buKhScM9A7RMaPRc43ASzdHtNCErmjoq?=
 =?us-ascii?Q?7lN7ZSkpVAOSQzZ2Q4NyD5QTQQvA2kuYDXpzGRDpeTvzBomWlihr3xghnMjx?=
 =?us-ascii?Q?XcBTxVt74cMzmc7QDg8XSVFswascS75dCjITwmeEoz0rghXLyVaTFY9xP+bf?=
 =?us-ascii?Q?pWdRmBr7qvu0Jnu5O8MKtbxn2Hkt39SOpHxUEAEMvfAX5GgEIPdWX0XNC3N+?=
 =?us-ascii?Q?gDfd9Td0QpENX77Lflx1FSQWCqW0piAjDt6gdC7udNlj64/XKFrWTWsgJjdl?=
 =?us-ascii?Q?POdnVyNMLjoNpLtKq776OYU5Z8mXgIIPr4RcLDcMppnXPxJmfyp3XQQlSi95?=
 =?us-ascii?Q?WSNCyfBEQk26lPyXy+PmduHAUMwONI3Sh/tl+2MjtgbisCGJZ//VCVj11TjS?=
 =?us-ascii?Q?lWOVpfUX18oy9i8vxo3uYu7n0gTDcf8nS8VdvlOX5y7zgdW1Of6Arh0k1qIu?=
 =?us-ascii?Q?mi2Hzr4FL/bcfmARxc+zQS1uC0KSn7ZweKBWVIuyvieJLVX6CdCZSLChSoGQ?=
 =?us-ascii?Q?McAHsstOJORVhTnhm2z1S/4sNs5XpAwB87B9j/n8pzzVvYV3gp2YkSxLcctC?=
 =?us-ascii?Q?oNoHzzuXLjZn7k1/8+WkvdEfUhOTeb6/B76zvBVIkldTNhvklIpvjfis+DOT?=
 =?us-ascii?Q?vvRzDPEF9jgZ7hw0Ji5Ifvy6iXg/zv3bI6MhWsa69NvqMyK59F8TqkNoCISr?=
 =?us-ascii?Q?SlhhZAjTlyh3r2Z47Wgc00a+wVuMH5Vkr84FYRqxOJ99G98wdwST3KGSOcvY?=
 =?us-ascii?Q?pUiT6B1yknl8ipkMDHk+HFM4PHAEKH5sjTrzULAd3Sbs5P9s3MjVd4wdMozA?=
 =?us-ascii?Q?RJplfqEQ0Up6Zz+5ZJZveI8JPq5xwUs1+8jTAWDv1yS7HPFdKHDyTJKBxtpF?=
 =?us-ascii?Q?PBfJAy31hIdmsTyl6m00tHyS538HNaKlgKFl+Ti0IPVJKjlI7ESUnE3oWPDS?=
 =?us-ascii?Q?n442DEQqW3U8uSAG476SDu8BazDxyqmjydJRTpN9RQivtbv+BVdJH9ppxR3Z?=
 =?us-ascii?Q?MhK2gr4Uiwiy7cKABSUhRtMtKbkdbqaNZES3J/DooTDp6uEAK/JgWz34CFn2?=
 =?us-ascii?Q?iCNmAFBJTeDrG2kWmQ6IuKUMtquduA12InO5HLLZynkilqhxrtUZ4KPEH1Zv?=
 =?us-ascii?Q?nDe1wL49OsP1jvZyy7CGtMFCa9g6JqcbTsXB99kqYeMvh/DH9TjAWj5GRiqL?=
 =?us-ascii?Q?MSxyTYnA3W9iWsDH2Ly0eYkTfmS4QnA5YkctWePm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb1c1da-c093-404c-6a3e-08dcc2ac27fb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:13:04.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZMd+NRLdepVVX8keCSc2Lo8dYsUIw5xNaBtOADR7dgEgjtYkCUaiT8Isi9mqveLBcebLvksTp1yWD9rad1oyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

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

