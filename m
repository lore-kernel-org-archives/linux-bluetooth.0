Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78318E348
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925167; cv=fail; b=gBDHjenWFGkORha/EkJ8tVjLz+lFfnqSwTVvyhDEvVfJwWQwTubKwYLmZwuVOxC0HlJtA022ZJ7l1SliL5B06rDCqd86CCMPoMPqwwmyXxeW+gJRNVqZHh2NAV0PR9Te00S16iq1TXa0kOLEm06btZGmS9MMjflBZopj7LYLua8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925167; c=relaxed/simple;
	bh=uDoV3UxbmKJ24oPrtPlQ/LgwVW9UTzyTzVKKXKf3OU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TILWWwj03pt82FbHkz25W6M1ddsFThyiM1t5iCyd7oKmlEqny/IjaVgdIxHFyBZUr0RJSWGxJyRgZuaK2sE/MRZ2lIY+W3C5fpSFVXKoLPk7QjvNwOUcdQzmprIhIS3yOBchaOAJ7cOTViXQfNDzD/ZI+xoDM8dqn1iJVOmE0mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S4f+I1EL; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4f+I1EL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6AlCdP04D8VT3Sv1lX9uEmkvh4D+evyECDNZSh9z9s0/jYD+ynw7GPXyW2bpfgPADpBiVOppZvv9gmMePJE4n2MhRVfz2Vz3hylqx/21uQ0C00udVqW+c//kE5Oaw4C1hKq9KES5mCud3AdjwanmFgs2d90HNNKtdJDlPg5Qktlpaq+StPPdAZhAv5ntnEv4HrMMMJ0V0WB8sRrnlioyNfDjZuFSBD8QoqiCvS0TKnoaqKypu6sP3nlctnLcW+JAfhQ6r9OAV6reo1DYbiuEdalKpQIlHnY4jkNrqaqcv7Q+bia1bg2cWmflP3yJle0qUzcl44Wwx3e8cLsioflWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZZ2UXzBo/7XJ/ot4xgn/i9tbgjwaAs4qp+CnDTOzdg=;
 b=D4APpy/C8bsjd54z6tuoUXjYahm957PBS0kEp1Ea251nsz2kskKvqAnQtWKkIBIEQKuFk+8EGxGeipTh/ZyYu/Y+Rz0rOMjehkBPrJKPma2V6CxOLahAAbbbdC1qVxFj56IbnBvhx4wpvWfwO+mMYrjFhuzHQA8ueycEYaBNDu70rQR03AVJnkFLIhv9PgDIDKmMr06wFvDSBiKT2/hi+oJ9LiOKOvMchIHacJ3AUx2ERJWrxXZHNBQQGxhh0ccrxQ1cfgBvvu/ZbaKsikq+JONCZSXj9s7EtdDRcTaTpx/lm5xIR4dHYNaHCq/iL2eNAehOO34x2TFVMdsq7cV87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZZ2UXzBo/7XJ/ot4xgn/i9tbgjwaAs4qp+CnDTOzdg=;
 b=S4f+I1ELdQckVvfBUHh2f05S8qLhn/vxwhsmsuWZwMRN3vpI+jMQq8Xe5DjCGiahqCK/FZ39uxVd5VzN5NgJ9pZBVOXA6O/3Wi1d6GNwRKiBsr6+4LW+OrPUfnGyalH24059h73hVWfAzcUTJzIcxKKuSE5U4Bl1dS588sK4cw8l/Jy6vF24DM1vic6DuqQVAMGlz7jbvg9ONb4kqGKshBpjP5lvW77tz5ZvZpityhq4/yyqgiHUKr+nWYLBR+/XCN3oLoIKB1qPCxFaGsSWM9fzJJUnbt6lxAIlHR1k6Lk+Ws8/YrWn4EbFlmK3d5BFPSbQ2OHLKsS636QVPrey+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:41 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 3/8] gdbus: Add g_dbus_proxy_set_property_dict
Date: Thu, 29 Aug 2024 12:52:01 +0300
Message-Id: <20240829095206.91150-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2a357f-0f71-4f6d-a1bf-08dcc8105272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrZbcho6sxgEhHtRfGbnEnA5qlxkvGVN3ma9e19/qckoZNgJHd2/NEccesRb?=
 =?us-ascii?Q?gS7p1t7fNoWxwdxAK8mXbAsLMjKg0gbI0IWse9olrk0CaYSuDg9ccsco7/WB?=
 =?us-ascii?Q?kxCXvtdgePGyz96tx3oIkHCLHpC0+HRWCNmDPxDDesoADCRA3ko4JIUio9sg?=
 =?us-ascii?Q?RABZRf8iT9bDRf3h8fas0wVwuqUBWrr7zwkI+DoGoy2vhF3bKs72cXfAF8uo?=
 =?us-ascii?Q?CcSisBlxCRdJlKbEU9uJOSDCMFlp8pt90dlp7HmuHjs2iPirSqELg2/EwS2G?=
 =?us-ascii?Q?yFf0H11u7a1kD2Qax08J6LnfIVfIQKLxmSDyIUejg6/kthfhfTw7NlZMigPv?=
 =?us-ascii?Q?wT4j97v4djdulVTHiiDj6zX0wg/7Lho1iX8BIk3BugDfX9EIygIwRkPT3Uxz?=
 =?us-ascii?Q?J4j2m41mztOLFrkSO45uTPnpbVnY7SC0UjwB9UhWOS6QNH/hdBU30ewykqmH?=
 =?us-ascii?Q?4UCFgS3k385St0obVxVDvb8uWY/0cNyc+D7I7YWGez8N1/dVhxdj71buZMGO?=
 =?us-ascii?Q?xp7RMXn9YAHtoKQefbIqCaCAkFU2oaXS02x8ZAVTzgpUjW1pgnnVpmSzioG8?=
 =?us-ascii?Q?pAffnDX95ZP2cXQbc2N0EriyRw21fO5FpeCAetuh9m1ML03xO/nxqegf9Myt?=
 =?us-ascii?Q?2MJdNv5Ah5t0cFAJ92sd9i0+3Cq8ZiRzR91hZIBgJZsPZxdSETNdVforKmad?=
 =?us-ascii?Q?sd6vgr2QeC0mCGAKaDDTsEwsJlj/L8MC0h9RatMsB+nu0uBuEs+NMiek+hFf?=
 =?us-ascii?Q?N4fkC+b5QMPh6GLtuk9ZrL80lOAXWhOvZfUOD6FfWsH4F1wigmYBnEPZN2S4?=
 =?us-ascii?Q?l9ADAXrKJOPxcY1u/DW+VBSpCRuaohWPZgy5yi1VdbI10WGlkCA8l0A2yX9m?=
 =?us-ascii?Q?fRs3vvpeP88Ccfz2T7173dhI/0+h9X4GyVDCRIB2rOb0GzERWfcVm9w1lkWT?=
 =?us-ascii?Q?psmMzDTo/OCYf4kuZ4Lc/X0lUWrwXXlFYMXwFUc17SSjJAHx+VNxs1LORhdj?=
 =?us-ascii?Q?bgMT9Ln+vhvp2tDmC3MJHq1qKLb3NGd3UXid9Yic1FABFzC0fjFQ5u8fEVEV?=
 =?us-ascii?Q?zIJ50FA3wz38x95Y8do4NpUFA2LhVCQY1e468jCKjvf10x/q7dsX3BXgDaNL?=
 =?us-ascii?Q?al9GxySweyOcP7V76UjPPK7XX97MN3lbOAvUSgui5jpEPQ+kyQuy0v6kCHw9?=
 =?us-ascii?Q?yrDnDJsZ9e9FDxkHJDAy+BcP1dpsuS6LeyhUZnB6fPaSauUQTLmWHA5nmoMr?=
 =?us-ascii?Q?9rBxa7IwXfZ+mvDcfrwL/NtP9SbkFJjhiZH9uXOf15CiTHdZXVK+P/nEtj3B?=
 =?us-ascii?Q?anuFexHLbMOneEmp/oc+jrYwFuWfJHTeheF6WMv4yVBOU7bgs8+xriBY62LP?=
 =?us-ascii?Q?kS+XYSiNTZ9DS+52HqISe6mkJh3d1IdJUYPSMygaxhB1HjGgVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2+g3FJFb1+lUyOMWn9yvIFYkLAxyFac+6MBpjcgcSwR0hAHleUehI9jwChv?=
 =?us-ascii?Q?WvYQhEAJFHnlbsoBVpHY4hBYYRhAnSIzZ6cp0AgDpVX+bnw7Hj0ffyaH54co?=
 =?us-ascii?Q?Z+WIAVbOlJ4bKlxKxnvezC0ZxKSq8AtI+vqWyZHqmFlk3L9QT0RuhBF1jagt?=
 =?us-ascii?Q?5qOEDxcsZPX00OdYSywpRvELFWldqFP9OmbU+9jzeZwneggrWsb7qbEG4FrV?=
 =?us-ascii?Q?KwBG2CQYuz5AI85Xu/jQKtVVNm3ZoIN9dIFoNSYWuIDYcP5JpHnpN12FEIMj?=
 =?us-ascii?Q?QwT/4U00Z+EQ4n6Mf+HVpSxtUj8+VOE2FJJRCMavcvgjnqTHDp8gKhfTE8FR?=
 =?us-ascii?Q?KZP3EdIkhEN/49JBVlRyUTKs1JMNdXngen0pZF7YqJGMeVabElgqaw+LgiY1?=
 =?us-ascii?Q?gUoeYNruuHp+otqDKmjDSOXZv0BoitLNGThYBSutJKY47qzk4jVX6ogbppMZ?=
 =?us-ascii?Q?nZf13sMi0oOY+AVylc789CIyVEckA0Iq8QMfK+7Ub0mK6VTmQt9Q/2QKYib5?=
 =?us-ascii?Q?FnCDnaRNFnlUDCdRYRNr2/raJDxLQcRjVhK3f0auTjmhapw5zt86hfPZfodq?=
 =?us-ascii?Q?odBn9bk+IRcwzOWn6qepnjmZUX9AzKe5r3XFGLXS4BG2DONhaN5RN7+PLXNp?=
 =?us-ascii?Q?RWTjHQk9ggm0qxmVjqoZygEtfW3l+gv+A03/cNBSGb6artwfUHWepbKSdEch?=
 =?us-ascii?Q?X6chUlgAFdWFTU5KMVbWQh8a4o1rCUqgv7cwJhDTvqb5QRDaIJY8u5zYLVK9?=
 =?us-ascii?Q?bbyQdtRkNxPQIR1OytERCt6r/GsW06z30toTPjw8Du/LQcQCxgR9lMQe3xub?=
 =?us-ascii?Q?YRio0+wHqPOU/Z1hXHm7A74icEJhyT15qadUBGwsjuVf1dWuE2xFhfeiYFCp?=
 =?us-ascii?Q?UYODMiewy5R/1fmIlWe1CsPW5WPFUl2HxInbyP+EyH/Ot12gEDpFX7qvVKwF?=
 =?us-ascii?Q?2hxiBd/bxRM+CKj6+6hZvDVRk8PPF6kqeN+eeZkbUXUzsdl2Ok7rUdQwTnPS?=
 =?us-ascii?Q?CG5mT5MDgdfPVLewc+u3Xy2+C2CYwzUzUHbkBiThXBpwq3jTdvjmg1MBoh4j?=
 =?us-ascii?Q?7JQWwza2+xKpkkD1S0s3A5p1dlTVtkDZkZWIVm69pw2V0f5CUl6Y7z4CoM0d?=
 =?us-ascii?Q?tvF9jMRKbZ0dEOD4QfTJ0u0BSHXhDcv0LWnsqaGxnhjAuonaKVxM5JPW4BD6?=
 =?us-ascii?Q?ejkVmFI/9zigI0mRaWzub9EEVPaiKDAQTlYQ6TKuqlyvUIQiObPYOcR55u4I?=
 =?us-ascii?Q?j7NwpcG3Zyj29JptUf9o4saTRxcoVN8dMDrYBjOYeNbMrO+OnxWTZ0Hdwkct?=
 =?us-ascii?Q?kJUt83lUL8Xq4Fw6TAEpPFjwo4HbxUUN/7GDNYxqhTyPsBAYBXDU11XBgmMx?=
 =?us-ascii?Q?zWQAuRmny9ZDZkF2jGhQXswBRKcnotGeUXJEX+MoVXugdt3CH5mRABoQWpRN?=
 =?us-ascii?Q?CCTW+Yj0HjpV2wMEaUf6isSPgVp8xu7B+cW/SKXKh7yvPsonf22mZOgQFPmL?=
 =?us-ascii?Q?AH2vyOcRs27EJ63+aaUEyLgpRNPFhtLMjOi1rXrGe+tVXusWvn/m9hs9EMBF?=
 =?us-ascii?Q?sFw7ERLBFBEg6cDAzUuAo3ULlLfaFXQaXka6HXK0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2a357f-0f71-4f6d-a1bf-08dcc8105272
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:40.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvyqa7gE05Ltlk9Nz0M9iAv98d5guXPvVb7oMuv916kJ6zrLJJxB/4QBjWAupSnOigFmQ2Xh/xnoGdU9VXD4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

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

