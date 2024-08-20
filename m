Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7776158A18
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150602; cv=fail; b=UxWzjyT2zOBdhYDKeKorGY9gQt6kJ5hrHLoo19MQGCtigsSkRCTXtEESxScSoQyZXrtcYZVr0IvTX6Tf+KhuOUAEN+Bt2RGGQ3FOl8DP/3ijJcw5BeyvNMye9er9quyQYaku6bojwZQ15NlHqtfi7ZqT+NURcfy41ZImBtvEfuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150602; c=relaxed/simple;
	bh=ITK6I+aiC9pnfqvRCBWZJjnpDjD+OyfZCUy6BaHu4Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnvAzGiwHao9IuSBa996c+JxKKEidDc2Vy30WhQdFoAFBvAlqKNyZrRLlDYcXsjc6//fpXjWLSFledck7p3z5OP4X3Zz3dzWNbX04km3W0YW/E5owKQ+m3j2m7PQxuZafJxYHcVvtrdEBCcvGVkI8by9n2W1U4PYB4uSk6JFoz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UPx8IV7c; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPx8IV7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkKxc4lA3KX63XdP/8gP4e2APsl40FMp1cWb5dBePYF3DbXmoccvCbJ97SuQzrQxM9v24IM1PAuNmt7R5h7pEAr6T4PnaBSSn6hHBGLkuB9GlCTBk25Z3h67seA0zqxAnvioqyvIMXXJDKxm1u06pdMY/gwRIrnGZ9hTNPEpA2bqvICqbpylOFxF6oDVe4MuzW9zSC9Z6st0QRa099dGl+G/I5yRTnPSk2AVdSaRC0EYfI8pR+NdkTIRZO8TgeYKiaP7c87PtldD0PjUxW/9c1bwhLnBO6EUPLyLqGLeTTpgHolzTUyZChhqLgR1OjF4PlPXO8VhAW+Ct0YBi/i+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLHtQfZ5kLUXv4cohNM77E6vGC1rveLTAZncRyHE7gk=;
 b=r5Ta7q0Al5+sXLHVzBPEu+irYvKav6hy6J3+xQWd+MXbMj1HP1Fn/aptWTkHqxh1DkertNXaisFhn4cmk+bETmliLMJZNrPwonYbaBNs5zPDS9Wc1SYsygvLBM6EeaxFUdB4JtKkwEmwVV3+TLU5SAmo7CEuz9PPaRaXvG+3fVSyA5gZYCqwFJ8gKTrBw5hF6F9gCLCNn7v6wGg0OHl3TEuTHmG8hlFA/L8eBcjHCqxHuN/BCN8d1NVtu4wBo2vQHoROf3f2laPLrJTc6agOduuIJb5RDL7HpQn+gogxTzlW9dP1lkf7v31eFCQIgxLpQfviIbsG/EYFQygjxqsA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLHtQfZ5kLUXv4cohNM77E6vGC1rveLTAZncRyHE7gk=;
 b=UPx8IV7chn21GhFYYYeluJIu9Bory1IIJ0NEc1wt4AzyG2SVqFQJJb5V9gGWuzl2elLwYKmW9kw0XO6shewRSEjFm97u8l96yPsAyQZ1RGDhHqn6nTSiEDhrKshemTBn7cpFuSjuzyj1cayFYiys76AcwfOc3abdCwD8Y8zVAj04wULQVFGZ2c5iqrPbVq2mQ0gQGxXnpVqK50zunChmBpSbz0+W1kmxts84QL+tl/AxbylR+vInHY4TodSlvNOxQa/7bLCe6AtE+BQN7D2wZRFqaBQg5BU4OkGeyTafFIW6A6Dti9dGWdhVWI0U86CBWHRIPV7rCA+vX4LbJoXeCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:16 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:16 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 3/8] gdbus: Add g_dbus_proxy_set_property_dict
Date: Tue, 20 Aug 2024 13:39:13 +0300
Message-Id: <20240820103918.24246-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: cafd1f41-2359-418b-906c-08dcc104e5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VR/oRZQ1kZQN4PsRsN1ORvTraLUksDHaSbUjRGVzhX9mJiemyd02UHjw2s6o?=
 =?us-ascii?Q?usdvo5/nHD7N1apidM1CRfG0Ek/O90O6T48G/z6euQscHojsgB9Naj5C1tgw?=
 =?us-ascii?Q?2rpefbUx4SAVQhAgNUmovl0StHmrvkeaLltAxw0ct8Yc5D1TqEeUBjRa7Kih?=
 =?us-ascii?Q?JxyJi03pUEisddw1CvuXrUYGAbJ3M2/R8Y0/q3nYVYIdPsWao68V+Y5ZR6RR?=
 =?us-ascii?Q?ODEwZTiVn+Z1jW6/08t9FPDAjPnA40hwuOpcxRyBkod9JAqf3pjdFNKT1135?=
 =?us-ascii?Q?ZrTEnYZ9kGEwQPoJ8+5tTtso55xwcwXBqbYysTLYm5zhgTH0utX0rUiybq06?=
 =?us-ascii?Q?DSer7h6SqMDth03P5HyV7SJliNXEgbtIUBXqbP2ZGRZZFkJJa1SWjUWtRAnp?=
 =?us-ascii?Q?bJmAzGqyARFVneadkbJMNNfqEcLQhLCZTS2IW2xrfIYUN0lNagGyILRVo4Wi?=
 =?us-ascii?Q?AZto/JnDpb20JUi5FwDMNRhkk1xq0+8zds2j/V9XYBnexUK7otbvHHcucm9x?=
 =?us-ascii?Q?a/zQ4OVLsOy0da9LqGs8bzVXrOUb9iF4whjDReYKlbog864bsUt8Jz4r0JKp?=
 =?us-ascii?Q?4HqUwBXjy9ddJ6t4My3Y7oe1tqKWCjOnI7m6dV0BIw37tO6gg+lraMHGkuSD?=
 =?us-ascii?Q?TD2YFyXKfdx3KhnBYs1IMGL5an9MLSJhHxGkOOKcZExxjqfaw10k/lqD5jal?=
 =?us-ascii?Q?Pg7+/V6rw0fJLazfEm48zMOuSmkjhyw4TMuHZcNTiDdI1kjwAU3G7FdOdh/9?=
 =?us-ascii?Q?02b77/eRkACmSFb5Be++qOlamALXoMCpSHmB9Zv5wxYDxjDU/MWSjl15CTk5?=
 =?us-ascii?Q?zeAvg/7d/hwbJQyBxKQNn5pExdGkSGJ5qGCUg2zjvhYsWDCmfh9EmKEAA4lf?=
 =?us-ascii?Q?QL4jOKq+1egLH6fgEvN+w0z1lCoAxMEqXMjhGXjNsMJJaISP6iU7LJ5O64qJ?=
 =?us-ascii?Q?ZfYDS1Cb0MmVczrIki09f5rGl61IXUyqGkicqbqBZPNLx+VqrubOHLYyLnyV?=
 =?us-ascii?Q?fO5bVM5CeBOZ2bdyFttdPOT/D/W154RLVv9WFlr1j1Tsvu6Sds38QUvl+QeK?=
 =?us-ascii?Q?A42aC+FW6/QUsy3KJWVUmzWXcmfmTd7Lp+QbbFB+ruAeQz3XMENaTJoQbm71?=
 =?us-ascii?Q?FBD4OOCEjYMuOrqWh/m59QtzH1GkvnFdF7VbuwD46RaGBryK8QfclO/Hha2S?=
 =?us-ascii?Q?Ni00+Lq54B+Di+CckXbzzQG26LKRAWnoznFucSi8P/repfDZzuxIu6xGUTbq?=
 =?us-ascii?Q?HIBUCk/Qbrh3LENEzcN1rOWsIpiTCaOIXTeUYB1VVPH39RjP0TuIufCCe7Yq?=
 =?us-ascii?Q?T6E5gTWmsvv4i8Fvu7JPP0+OOzlu4niH8eQbqG4po+lxOCGE4Ec4SYWu+3uf?=
 =?us-ascii?Q?3JvHxavwEFTcZVr9oqt/PeoBcYSYXssKFeuGxMi314pGN0YWPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmvgLJenjUB1FzWqutx3dnGQ/dhcjpYcTgjp9vIn0qnH9GXYhGwU48xOjRjK?=
 =?us-ascii?Q?UP56vdzIdaR9AAWVJxf0csMVzkZzjpu7dbcBeThqpmHhj1378z4jJan+rxrl?=
 =?us-ascii?Q?k/pnluWTwaT/4a/V/vpdSNA3gGQRqL6srnjBSc44lQnrxLwyYWOFWxB1xZKy?=
 =?us-ascii?Q?z1zVlYVvQ5aMbF4Iyk8Ums4XBJ7CVIMweOoAs6GTpgH/3G5667Ujngu1c7kV?=
 =?us-ascii?Q?MZNsZHVpnfF2DE96V4mfegaNxUCk0R/7lcQdYtg92hYPqpGulMxM/KhC4eCq?=
 =?us-ascii?Q?WPojfSM0WtgEFyG0rz0fCu5vbxLoWSGm3gTd9D+YOmKBlHoUa3tGuZHiD8L9?=
 =?us-ascii?Q?6nRs2/rdlX6BzT0G8TgmcNp2slEULcHSvTAHItb5og30SbwOqcXv2Vu1YR3d?=
 =?us-ascii?Q?CaMqZIA32AV7uv93F0uScOGun0GoyOvXrNEYv2DelD7D/GM9Hwqi+CJaKnEs?=
 =?us-ascii?Q?kAzuEIaSY0HcYYM36x52x5o9fDU7W6VNTZdY76CKHtXAnfQnsoY+3mijeDZr?=
 =?us-ascii?Q?u9sMFG+HszOynNW5M8+RjFj8CZA8qdqiLNjisiLJekv9u8PgnyfzIGeXgzDT?=
 =?us-ascii?Q?1pLwPkjQl0LwbdNKOh0xd3ARHkqLXyOZ+o/uHSDEhitBxLxd+QzJj7CtGT01?=
 =?us-ascii?Q?1DQGERDQjswcuHOyO/RsXycb0CDiyg5cbUFSiEFawWXFpB4F43QKdkXfH+/m?=
 =?us-ascii?Q?eTk6qmTSGfuLHAxLT8m5uCz7zeHEi9ngnV4QHCKL2XnoSGGxTCkhXxBJhPKm?=
 =?us-ascii?Q?pamaHgswvJSbuvsToLX4/qhbsIzpi61HJKXtlEppacmCLq/VZ70q8pW83UYp?=
 =?us-ascii?Q?v47n/3G7ZdjMYDSojt4H9NwtFEvYr8ZUzzjB3DC2BKTLltVjaBORKkfLOK0q?=
 =?us-ascii?Q?QabqHOh1ULY8M5xRVPX8Xz58ST2PvEPmjGD+BBuIgYRTM3hVw7xODqFNKR05?=
 =?us-ascii?Q?PsyWjeCJk6C4Zjr3EyS5MFxNmzZkBgavB2BbsRfxTI32pM6dCrBecuwfcEhm?=
 =?us-ascii?Q?A5Gqov5TFgB+02gsEiL4I4OQuof3UzrIqpb2iAug6atjbKbtx374q1+QaFGD?=
 =?us-ascii?Q?xDkB2inVkEyhHTMuhurpfq0+175FmODJoA4FbWToW8dl8l3yKKbObHpOibOf?=
 =?us-ascii?Q?mqf3gMbC1WT7z2GIRoXO4C+hptlBfm4MiO2gC0JhG/KgNMvhl4Tuk3rnukdG?=
 =?us-ascii?Q?BJbqly014aVSfaE+zRurQHgFr/+5l+A9IwgvLLJMmK0Wvu2/R2ILAJpZD7lC?=
 =?us-ascii?Q?k2NeSNa224XTXe/mZ2LEyEgA2Pw1nSwCalNbcqCRvUMUtAixVd3bhV4WzIqF?=
 =?us-ascii?Q?Iyi8uGU4I7bH2C/FpyJ8XdlaWey/ebV8fHMnfLdqVD5+kRdUU0AuShyYNl0N?=
 =?us-ascii?Q?KgtQxo6kpgN1OSPyUBt7qaGQCMLVoDaQAP/B/FKcm6c6OGXFvqm+TnIvew1Z?=
 =?us-ascii?Q?wRKBlxlAyMkax4kiVnIGF26+8AKQAHy0cIbL69amHRXbURkWsaDffUsp7yw9?=
 =?us-ascii?Q?eBdTSC8iOJLi3OxR3Hn4OWGx37yB+7IyHhBl5DfQFTQvRQC63CsSohtgnlvS?=
 =?us-ascii?Q?oPxSCcron9YNcJmAtyGapD2Mdh60LeKocN4N5QVV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd1f41-2359-418b-906c-08dcc104e5ee
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:16.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLyYYrmjzWPlmqDUERRuYpTTS4TPb+ZGZNUpoQmSrRNfXlNFTO+Y27guUDfuCEjI5fRNs6SDHiK5lRkiwiFgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

This adds a new gdbus function to allow for the setting of a
dictionary type property - a{sv}. It received the name of the
property, the name of the entry to be set from the dictionary,
it's type and value. These values are passed as a dict entry,
to the set method associated with the property. There, it must
be parsed and the appropriate entry updated.
---
 gdbus/client.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 gdbus/gdbus.h  |  6 ++++
 2 files changed, 92 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 3b7faa4e4..980f8fc0f 100644
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
@@ -184,6 +185,33 @@ void g_dbus_dict_append_entry(DBusMessageIter *dict,
 	dict_append_basic(dict, DBUS_TYPE_STRING, &key, type, val);
 }
 
+static void append_dict_variant(DBusMessageIter *iter, char *entry, int type,
+							void *val)
+{
+	DBusMessageIter variant, dict;
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
+	g_dbus_dict_append_entry(&dict, entry, type, val);
+
+	dbus_message_iter_close_container(&variant, &dict);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
 void g_dbus_dict_append_basic_array(DBusMessageIter *dict, int key_type,
 					const void *key, int type, void *val,
 					int n_elements)
@@ -885,6 +913,64 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 	return TRUE;
 }
 
+gboolean g_dbus_proxy_set_property_dict(GDBusProxy *proxy,
+				const char *name, char *entry, int type,
+				const void *value, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy)
+{
+	struct set_property_data *data;
+	GDBusClient *client;
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	DBusPendingCall *call;
+
+	if (proxy == NULL || name == NULL || value == NULL)
+		return FALSE;
+
+	if (dbus_type_is_basic(type) == FALSE)
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
+	append_dict_variant(&iter, entry, type, &value);
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
index 6fe09b743..4aaf73b62 100644
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
+				const char *name, char *entry, int type,
+				const void *value, GDBusResultFunction function,
+				void *user_data, GDBusDestroyFunction destroy);
+
 gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 				const char *name, int type, const void *value,
 				size_t size, GDBusResultFunction function,
-- 
2.40.1

