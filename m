Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B91C9EC4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332383; cv=fail; b=R8U8eTMvP09gj/Rpaqqwa6XwHRMhyT1ZsyTp2TeWOhQzQTvQQ4Gasx0NlU+0DQN4qu7KrQXX/FCscRY9l8jRQ/urrqUavhRMMd+bk5y0gu4O97pjSbEmSKfz//iGDqwMfLWqMV32KF3ruwPsma6RjFKFcc7J/o+eNB6UwMkvwj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332383; c=relaxed/simple;
	bh=uDoV3UxbmKJ24oPrtPlQ/LgwVW9UTzyTzVKKXKf3OU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7FhyKxtpAb1OZYItTANTrkXsWVaQCJfy6kr4YUxonetvyTww8QcI3X32+QJCBE9SoHuevtmTMnOkp263Wk2Dpxkzu6u2+YX5pqn252ke3cCGDgFFXX4ZEcQbl2aIU3BNBeIPsXju/P6E2oeeXKl8U8nJeLICz4HOzdU8h31bJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X6zeZZL0; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X6zeZZL0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKUzGPYzIYRj6veT2nG4tB1sBvgxDqTOURPpgDsO4uqEQVM08X3GSfacH8VrZ9z2lhdErGSw2ipuzVMbNkn5hywSbpGGqKCS53N8OxJMJs7hsI9vlkNFfJ+zmmHe3M9yvXW59ZuDx8siLhkswI0u66Gp5WdZCq/bLFWyg9vmQiieA3SS/us/cX8lN2djGPezNV9BWxY3ljJMc46s6+8VZ92P0qUAnWaLN8y5ltIBn7DbgkWrg+BRofOl8t0zZ26iwabbsDkGE9T1ZzV9Sr5PfY6Ibuno6S8VdLsLtggRcyF6IjtXXHQCzjXEzarz4+IxResCklEfkzwDjwDQCGZWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZZ2UXzBo/7XJ/ot4xgn/i9tbgjwaAs4qp+CnDTOzdg=;
 b=T9WLg7s5ruvXOuzcj935qUrNRzlU8C1B+LZw4nR+fBqNWusEkrxNO0u9K8IL7kPVl9nRS1i2xEcyIkoowFAPZrusFdupJIhBHGisYviMsCcq2TZjp+K8DJwoq+K2B0x6nBOvp9/YBKgO/ZoDPkLuuKDYaKZ9XWp3ldObh6Urimqg6SFQE4psp2Kr1O3r5BQ55AweuH/dSSbE4/HFAL+68UBVPIK0AAs9PB9PEmJEFSmLJFLTdQN/K8twjBTKYMsWjeDbSJPFuJwBFPSB5yryuszXcZTYcRrrHoWsVxXLwlPrsdTINEUUt3cIagV0XfpR2YHkeaDqBcJhJefnmp2SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZZ2UXzBo/7XJ/ot4xgn/i9tbgjwaAs4qp+CnDTOzdg=;
 b=X6zeZZL0hZ8cIVkjYX56Zrb68Y2+E6JkEzEl5ocC/cKPMyPguaZAAIVGpvb2D2hwvj0VXMj5I6JO8elMLaRs5OT+PLgkVkM5JiTzg7EF5ZyI79UXr8zaKurdxbWEYPq+oxB0EcXvdeom4USewQJfBd3pTVOOGKwRPjeOmz+ekGOoRCFsCdf2SFOupvFhimpWmbXFW9PEJwUqGovEVvWNFGQL9ApN+/X637FwA8ruOAWLP6ynTffIqBFKTKDfA2VizPtsq1Qu4Ptlv944pFpAy2tUshiPMsiAFSPP60EhSbroTIXa+tAWjGyPQ40B7r1f18ietGgiN23MLBWg1vIE5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:12:58 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:12:58 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 3/8] gdbus: Add g_dbus_proxy_set_property_dict
Date: Thu, 22 Aug 2024 16:12:27 +0300
Message-Id: <20240822131232.531952-4-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 212fe276-cfdf-4b74-e51a-08dcc2ac2466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8/CEog8QY0rI09CXvEI7UJrO8NEHl0T6LjuDzdawuXCoHf5NP9FHFtqDFft?=
 =?us-ascii?Q?mOCQLmx7U5Q1vWmwylAjIJTSbaZd3e4+5NGpjOcRi4Xi3jwFhseSDySPyYVC?=
 =?us-ascii?Q?O4oE64d9sqaSkJZ8ZE/Y9Zneq7XL4J1KguDoHVETGoRqDTplK56yoRyAn1pW?=
 =?us-ascii?Q?GLkAAjn06zeEZBiXLbrp9FOWEl5H/Q+YAa+aqSg4Ztdk4Ttgh1QWmV24M94X?=
 =?us-ascii?Q?bdjjaOZLK3Twf0ijVMODHlHOhf/a14qn1nKmvK5r/27J0x9URQ3B/1B2L47t?=
 =?us-ascii?Q?ZhhfJN580yJW6Mx5LB2jDE/rdx/GaCKhKBeoxyVdXMFert6kj7p1MgmEwwRH?=
 =?us-ascii?Q?Cnrx+tkiyuESVTKKkzQH/UFz/HMCf1HoLr/+vfBWGzAXIwiqnethZYOjso+B?=
 =?us-ascii?Q?BbYEpNvO52NLyNZVFZkB/L2SBZTdQOg6ZGmqERRp4oVZyNJePWhrKiPaXVnF?=
 =?us-ascii?Q?97vSckzn/Z2dfYeY+vq/ZmJcDl9W63ZjrqZAi/5xmlfTpn/Dv5FRvlqD6zt7?=
 =?us-ascii?Q?IqNmNm6WKTO+t69xoMgFgpQHf7r0xS1gWv6waikfGdTDWL/uMPrsjYywucY6?=
 =?us-ascii?Q?lC+rir8D65VXsMhLdvnDl3bZOnx/X0L572DAQzzrpzsNgY/kms5UvSY8ScQ0?=
 =?us-ascii?Q?QHyNPGQ1QCFUPMnpfxsnGq46WIctgvCN9jLfeYq9M0oTvvPkkn1Okg5WpHDj?=
 =?us-ascii?Q?s7CwyETBLgwPWe/rppJ1WAForHUkYnQG/7XncEQmws//YSksPSvEj8+unNCZ?=
 =?us-ascii?Q?q7ZC0vInBP37ZmeZ1M1CzW5W270ygUL6c4dv2ktUYqhGTbWToCWwV7kZm8pw?=
 =?us-ascii?Q?scpvbDSnx5APjt3rr6Ab5B+XUXrcU74UPw8XCeWCXiaP8SP1EbIVaLTOk5bI?=
 =?us-ascii?Q?KMQ+CdzfPNFYnU56ufS+JPGkTuaz41vi4qzCuXFxf8wN6b4aYYBL6retLJMp?=
 =?us-ascii?Q?bohfoBE5i2juEkY5ekkjPsBZkO+71AG4QOjmS/6d521UNWePWt2gkZ7te+NA?=
 =?us-ascii?Q?VV65v8J23Cj9zYYgiZF/59iA4vzJ928knLABHnyT1YnTZy6PnkqKPiljwOmi?=
 =?us-ascii?Q?DipDqjiIj6J35HjLVPOjwzx9Htnn26KXT1gqiHUx8WoyTyYDnK6H9xcanu96?=
 =?us-ascii?Q?4BS+XPvcWH6AftCX9Pi79diqUiK3IU8e9MJPvnAxEieR8bhito25OUL20LyA?=
 =?us-ascii?Q?W1+rkH86Qdv7f3PVccXCoTYiYYKJKUOURrail+/rylVkAIagVoSs1IwMzENP?=
 =?us-ascii?Q?Q+spDNHN8GAZiSEjQcJF/XGIqQPsEF4pvu4o6pQ+PKX1TybL04by+zgANEf4?=
 =?us-ascii?Q?l73tCWGwpedtTuq+BkdyiPwFOVcOM3UmmfZ9XmvxkFEOQHHzkGotwjH4F93A?=
 =?us-ascii?Q?6wIdB2+ez+UGQJVPfSAZuSh4I9R1pYLVSNibg0ubEXghkmaKtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bu4zilGiJj7o2DVeQWGqAPcKJX6JrU5I8mCfWkX1D1CeXUNYhRGefBwncq8C?=
 =?us-ascii?Q?dnyDyukIUE9ULLSOywqgzEOeuSyB3IQPfQnHJQsDXm115L8vBpUWtnFYq0SH?=
 =?us-ascii?Q?t5RITVDPk4OqIrmYTfY/MOgqQO26HZaKPBpNOXAQKAGYTvL/33nDUUSKLR1i?=
 =?us-ascii?Q?/NOGnpPfM1hoRzhAYlsVO9ZefgtVZfKUkCk1WRkiyQB/PFx2uCg3IX+m6jtu?=
 =?us-ascii?Q?bsMI1OXcoDCkPSPU8UjY70/mG4EwAMx7T3izoYKHumKQQ8LAzLLCmS+nueL3?=
 =?us-ascii?Q?Ewyp28SzhNAWTA8M8G6GFrF/U12KzfyrVS3WdeZMMxX11AB9n1ludm/nu8wn?=
 =?us-ascii?Q?mnEkjWwV+VcdLS8dK7WXrwWDiPBlQeDpdwm8EQQxK6mwg4vg33HE7LiM+b+u?=
 =?us-ascii?Q?V3YkQAnVuL4KjpRb/YLhcJ1n/8EhKrt9W2OdbvaScO0779SxNjWoWr9aG/9P?=
 =?us-ascii?Q?fsaE33VtMiP4y+YjqxZNzyOkU0mGQYWjQnwXhcq3qH2DK65nnb/6reB/nvBe?=
 =?us-ascii?Q?x/UHQwalItsk6jGpLIIwBlNV3oFf5uY2mjYcrqdd0VnH2wcIvzbuZdCXvhDL?=
 =?us-ascii?Q?pps5eQ0GKA/DiiBpWe20K47F2ADgw32/aBbvWE2ELb3heg/IB48BspxuMO+O?=
 =?us-ascii?Q?+FP54fHbgpU6ZSKo0CZ90FtRnisExbYZ0oHlq/EQDk9WBFcbHYuFji7uutPF?=
 =?us-ascii?Q?poF7uaVUkExdZ8miSxDLBrlwsEKrRHOSFKPUMRkPkfk597K1A/XeTaBwvV7y?=
 =?us-ascii?Q?2VlliyJTHT7SknYpm9gHr2OsKWMHY/Ea237D5UVxidwzn31l4KP1s7fjze9k?=
 =?us-ascii?Q?TRJFw3Zq/82jEjzUT8BLnCSX23+ZE9RTURBODzCH4RQd0A2qs3Ha+7m2W/uS?=
 =?us-ascii?Q?ksq51/uXQ3Zv5B9EHSfZxZ1g83ZObCMMORxNTMHOhufYjacCYsghwAy5RuIU?=
 =?us-ascii?Q?FbgGuQaBKIYE4A9ur9ablpqWYqKbv61Kf7UWrvCJrcqIHJdTyPJ9qmeVnmq3?=
 =?us-ascii?Q?H+nXDiYnYomOKXYz+CCMDKMG9JXCq2IbAuO559gaZl12yrIVZ2OQpK8Luyj0?=
 =?us-ascii?Q?nqU0b8U/9WViTUD/qKnQFjzwp2aq4l3BIgXEJ+EuKhNsyA5qaNe27B2WygdJ?=
 =?us-ascii?Q?pJpEtyZZfx2O1Bx0m+ekSPEx9EKIwTz2yfdG7c7C97wZ95Djgg2Zi63SgHn7?=
 =?us-ascii?Q?8FsFPU9qqv0S+lQrvyUKLihz2B4e0+gDrwHUx6zY6R8SJvnPB1TMIWqhmiv1?=
 =?us-ascii?Q?dDDfMwVWGjtZfKyGLiHCIwklTYlisgngAB5oBkGwe0ZDkM2BoXdxabNRqeUJ?=
 =?us-ascii?Q?+XJAHLlbWdLpMjoAG0g0MrTNhOE5cdJdO7wOatSnRQrke8XTHQoGl6zYDj0n?=
 =?us-ascii?Q?NXnelcE5DupWlaNfxjWBGCfrR3FVrCNSoZlc7SFM3Y6kACrUx+WE87IMfZqk?=
 =?us-ascii?Q?IAVPkmnsTUKA0UPhz68JyBYm/LXYAehzezryZ66Tsfi1nM06mEu6AXRsZX4k?=
 =?us-ascii?Q?qmdVPTUIiUQCDvQcaEM1pw1k+tXEhxOnztJqQph++rLGKg3hJ7I8UCJx60hH?=
 =?us-ascii?Q?41mUhmH7mEYgy6AJx8EBkreZNq5yBNumdKEIoO+M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212fe276-cfdf-4b74-e51a-08dcc2ac2466
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:58.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwwb3G51+82J10z76BTirFgM1JhILaggEJi9++PPuwOOnBA8vY3qgIRzkQWGhZzD8JwbffoRJHqg7UDFkKhTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This adds a new gdbus function to allow for the setting of a
dictionary-type property (a{sv}). It receives the name of the
property, the name of the first entry to be set from the
dictionary, it's type and value, followed by the second pair of
entry_name, type, value, and so on, marking the end of the
entries with NULL. Additionally, if the type is an array, the
type of the array and it's length must also be proviedd. These
values are passed as a dict entry, to the set method associated
with the property. There, it must be parsed and the appropriate
entry updated.

Example of usage:

g_dbus_proxy_set_property_dict(proxy, "dict_property_name", cb,
user_data, NULL, "entry_1", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
value_1_len, value_1, "entry_2", DBUS_TYPE_BYTE, value_2, NULL)
---
 gdbus/client.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
 gdbus/gdbus.h  |   6 +++
 2 files changed, 121 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 3b7faa4e4..deeb01dab 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -4,6 +4,7 @@
  *  D-Bus helper library
  *
  *  Copyright (C) 2004-2011  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2024 NXP
  *
  *
  */
@@ -15,6 +16,7 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
+#include <stdarg.h>
 #include <glib.h>
 #include <dbus/dbus.h>
 
@@ -208,6 +210,44 @@ void g_dbus_dict_append_array(DBusMessageIter *dict,
 								n_elements);
 }
 
+static void append_dict_variant(DBusMessageIter *iter, char *entry, int type,
+							void *val, ...)
+{
+	DBusMessageIter variant, dict;
+	va_list args;
+	int array_type, size;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	va_start(args, val);
+
+	if (type == DBUS_TYPE_ARRAY) {
+		array_type = va_arg(args, int);
+		size = va_arg(args, int);
+		g_dbus_dict_append_array(&dict, entry, array_type, val, size);
+	} else
+		g_dbus_dict_append_entry(&dict, entry, type, val);
+
+	va_end(args);
+
+	dbus_message_iter_close_container(&variant, &dict);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
 static void iter_append_iter(DBusMessageIter *base, DBusMessageIter *iter)
 {
 	int type;
@@ -885,6 +925,81 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 	return TRUE;
 }
 
+gboolean g_dbus_proxy_set_property_dict(GDBusProxy *proxy,
+				const char *name, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy,
+				char *entry, ...)
+{
+	struct set_property_data *data;
+	GDBusClient *client;
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	DBusPendingCall *call;
+	va_list args;
+	int type, array_type, size;
+	void *value;
+
+	if (proxy == NULL || name == NULL)
+		return FALSE;
+
+	client = proxy->client;
+	if (client == NULL)
+		return FALSE;
+
+	data = g_try_new0(struct set_property_data, 1);
+	if (data == NULL)
+		return FALSE;
+
+	data->function = function;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	msg = dbus_message_new_method_call(client->service_name,
+			proxy->obj_path, DBUS_INTERFACE_PROPERTIES, "Set");
+	if (msg == NULL) {
+		g_free(data);
+		return FALSE;
+	}
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+							&proxy->interface);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	va_start(args, entry);
+
+	while (entry != NULL) {
+		type = va_arg(args, int);
+		if (type == DBUS_TYPE_ARRAY) {
+			array_type = va_arg(args, int);
+			size = va_arg(args, int);
+			value = va_arg(args, void *);
+			append_dict_variant(&iter, entry, type, &value,
+							array_type, size);
+		} else {
+			value = va_arg(args, void *);
+			append_dict_variant(&iter, entry, type, &value);
+		}
+		entry = va_arg(args, char *);
+	}
+
+	va_end(args);
+
+	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
+							&call, -1) == FALSE) {
+		dbus_message_unref(msg);
+		g_free(data);
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(call, set_property_reply, data, g_free);
+	dbus_pending_call_unref(call);
+
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
 gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 				const char *name, int type, const void *value,
 				size_t size, GDBusResultFunction function,
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 6fe09b743..d7be17661 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -4,6 +4,7 @@
  *  D-Bus helper library
  *
  *  Copyright (C) 2004-2011  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2024 NXP
  *
  *
  */
@@ -362,6 +363,11 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 				GDBusResultFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
 
+gboolean g_dbus_proxy_set_property_dict(GDBusProxy *proxy,
+				const char *name, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy,
+				char *entry, ...);
+
 gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 				const char *name, int type, const void *value,
 				size_t size, GDBusResultFunction function,
-- 
2.40.1

