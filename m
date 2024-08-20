Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF8158A18
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150606; cv=fail; b=O3M2OYj2+CawEsBPG5JG9qveolFA/hlveMb4dW3CxDLOv5oL7BrKG7UsSb6oQlRua7B0PI5mG0bcjUAMx7c5ci24P6QRXp4bKgcsAqSDzKqOcs46WndkJZ4vFF94M1FsGYwFSj4xql0Gh/Vk9mI3FS9GMcD445nYjgGSHFhdZcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150606; c=relaxed/simple;
	bh=gYgKqf/W7QuahMHNlQj5seQsu2jDo/EzRoKIoqPJH4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfRJ4wdIJR3kDm3djUCPUgGY0cFadKOA2jTCVct8jGqYEy9ZmPdB9zOS6ZjpvtTvBBKA8CdtB2jpoRchSgsHbJ2BN89nH8hcBZzdZ1MWYOEbDsLpRVa/VBIsxRQ1rK+nWjp+PBzzyRK8J1cLlz9e9KKWxweQUxn8zmevJOUtXYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAF0Y/RW; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAF0Y/RW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx7iMaXZ2JMHc2Ia2onHQNUC8GCOIPVBkMUiORVEGZlQaaVfoJD9Sc+mKYo6s/v1PJUFM+3yMac5YPriLUpu0TyCyFBxJyF8MLvt+Vh75hTWrUl3IukuwAGL2N1ppsi4TdhJAsnr3cPsusnB1JJixq62gQxsyKVQylhepRGme9jSGSRjjmSOS49UFDI6PMJwNk92hmFyds5dPi+wLqYjJuF0aKZmgsFVFb1Z8J81zJfzlr0zP0q/PP9vLn0CgOYOzaNHXyVUYC+hkOFXCnthbXRRwXyK1yiRfWENlHu6ySaCd/Y6Br3z3m5vfGDThy8G1tQ6/MSYJCasj8L9x9tVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nqzerb6xuk1Pssm7WydafGfZmdw8hyHUnDD9LOlL88=;
 b=hCNGRh3G3RZ1CXJvknf5c0wFpC6VG5zpEaSUiamxtW3v+s8WknPZIgP/VPtIrB3dV1KT8WiQRcGJq9UQACwEx0tiUZoj11bj4gUQ6BdVWT8I/vw/KCr17aSf5CEcyIfxZeuL5BmdlOBusc8Cg9DyUW9jOXNj8d0UG7NzH4oeL3cer7azXe5OM+t7lfIxBQdwO/op/wfvbshAAlFrLOON84uvdTuomzqtISHCFVlPo7MB/J/FgD28gysrTPjcPHFuknDqXEGHThhmDE/Huw4ZQYepxR4BydGNkpEtgb6ilwAH/yI1+h+6xLRYsbstLhe8FebjmjN4F4a0qoPCZjHFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nqzerb6xuk1Pssm7WydafGfZmdw8hyHUnDD9LOlL88=;
 b=QAF0Y/RW+S0Bza3njqVWkefzzPWv6qtk60UzzKD2Wos7CScYFeUuJe5s6k59eRSXjsNLl/cP9FnYsrsSp8mXxjFyZF5YuorCe0KVz2rhQuW0POr0uvds1ex4Z6glgUoQwLSaHeFcs4bZ4CitDLRgeEX1DfbRuDraEFiBdWGiJqYPojUt+Cl5OH74Bti13sYTPiFMJ97Pdp4VIu6xcpfZKY/l0B9OrxF4WzlR2qoKTK27w/EqIg7CpSKLSGuL/MBX3Gf1yjPzYBGCXw85uzuixUzcTR3lVjy/mpAHv78V01555GH0Cqn9DpEh2WiNCtNgL+RTdBjvUAKqb8vfjnIdXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:20 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:20 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 5/8] transport: Add set_bcast_qos method
Date: Tue, 20 Aug 2024 13:39:15 +0300
Message-Id: <20240820103918.24246-6-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13bd13d0-c940-4e39-1c3a-08dcc104e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gmz+3ksP+/aKyabOtDfArJP3caz2S6T3UZqrTVYbhv1kft7Cjyx1okg9wgXH?=
 =?us-ascii?Q?peho9X9loXrnPmMTvtzZelQ03xZMwWMtXkSW6vvfnzYrco2SzvQFJ//eFv6V?=
 =?us-ascii?Q?2FxeWvyhECPHGEF0JhMllysv79IxeLq/H5UVQziTu23BOk1mSnh3uqRfqTpM?=
 =?us-ascii?Q?0BNY3i3HLvHgdAlC6UEQmUYFNEa/3R+KeZi9bHomTBbkU8Ba2JYW4UaLr3I8?=
 =?us-ascii?Q?n/5Qk+ZannDFQaXALoLxjKJjAwTiddSBxOlRkSiwVY4OK3Zpt3OyZt0tYhlO?=
 =?us-ascii?Q?CFMZIg0/ElWlTDzN/f8/c+L6NWRzNUP6VkpxGFetFgcYPKyKSuQuW+iTZBFf?=
 =?us-ascii?Q?25Gi6m5rJBgr2IIrGByL+4vpkHz9EEGd/39l7g3t8Z4wVlUyMrGXKqD8CR6K?=
 =?us-ascii?Q?S/2OEPfD17h37/b22rqryWe38jD6cxPKSzaF/6rCl442tVKE3ONuLAN+xcMk?=
 =?us-ascii?Q?lk7Rgb1oFZuQATUN6JjZbjMWLKgyGJ4CeAWlqeKyEwOkLkWPuqy9mbbe86Dy?=
 =?us-ascii?Q?2MEj5YegadnzAIVTDyVTMy/ZesoS/ln1+uHSnD8sM8tmDGDKGSIYL0ZWxHDR?=
 =?us-ascii?Q?urm5lWIemwR7OPDzFbO+ri8m4YSca6SAJOGzu0GgMpsIhmX0k5WUwt/kcJqi?=
 =?us-ascii?Q?MoI+slsQ0diH4iqXlsPGgaPqxYYcR0ySX6Yjbkuzie1wqTWUVK0gCszyLDtL?=
 =?us-ascii?Q?AoBYmGLWNCqZ8LUbtGRqDRFhTj144dCxQJ2eLdlrymcd4hvvHd+roGscr5Ld?=
 =?us-ascii?Q?DK3WjnPzXZaJzflOPwK+7qwPWB7H1D3eZ3Uven+k2s2Rc/rLwrNx6MCsqQK/?=
 =?us-ascii?Q?6mGEC39Kw0fux/Pm+h1QSWYvQI071FaClP5AB3glH8NzbccR4wAtyi3YZYR5?=
 =?us-ascii?Q?0QFgHMuikHwKdhVopq/or4WsFbRVADEeJyTK3VpVPITTGwC2bm3zIPkRtaKW?=
 =?us-ascii?Q?vda8j97BygDvXJSbIg+BZqFGFnCux8pn1bNcxSFpIVIXEit0ObKiXqMd/q69?=
 =?us-ascii?Q?f6RcCSRK6PDPAbpk2I5jUPNQDyM3eFp6G2g20kwKpT+SSAv3O3n+T1o3I4pR?=
 =?us-ascii?Q?tRvcLKIAJm8oH+ozAyfIYuLeDQY/PTsu/FxjSfBdHXhLMsUErA37N3Dj4EGW?=
 =?us-ascii?Q?dWYoMsd3O+zrCCSTJss9pSSsdYBIp/ZJReFArXnvik1NV8timSwDKtFn55B0?=
 =?us-ascii?Q?TE5QX7ZW2993dTpreB1fxG73iXVcuzwdkEt/oX4IZ7nMsEs0nltusQsTc2vg?=
 =?us-ascii?Q?0MdFmqtBvBt0WBeiLh0JwtCvdE/TlxLN4XmGCGSc79VT2spVDtxzEVKM4gn2?=
 =?us-ascii?Q?7s9KHzUjnBXP7WWeV2NEQlSZmxUa0hEGYcFXoCzKRqlGIF+Bo5YNON4eLOCd?=
 =?us-ascii?Q?oVbi5s/Ryy7aCoFU9+ZA8/RlxK1+8XTnb3UIJdKWDTI067P2ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zV0FgT11E71hRwtMoxHCgjwnJpkVMC/GCzM8XoJixkIQLIa/f4cDi8f2xc5?=
 =?us-ascii?Q?m8OBhLniM3Xda0M49/QrJ+MxEEbgJQ3cbBQQsULuulnlS4fENMIS786+7pLH?=
 =?us-ascii?Q?YRI2SSfZ9j/e1MAZiV6tLLGWdasge4waYkeXg/pvhEkgbVSHI68yFFxyeN5g?=
 =?us-ascii?Q?f2wxaa/B1WLZEk4DEFgXszfyvhQu0o61hhE0rABK8DRjJdCM7elNUJpAV8cG?=
 =?us-ascii?Q?7gPXCfRQwMryjCFeLOkaqRTFRYf+tQ7+RGUVr6YqNIaOCcMWqfCcVriDuv8V?=
 =?us-ascii?Q?DIMW8Ks6LsWmROmnLIye2YUtZwB7Q9aBRefI8bZGnIBfR76e3vbP3qkt1jO2?=
 =?us-ascii?Q?yYC+vB1oq2JxYnUP0JLZwn6tyjZZ/hzaOyI4DjehUNKAlAyPDyU0ZY2iK/u6?=
 =?us-ascii?Q?SpZpK3vD1YURqTpmrDJ4RBVKQCZ4bMrLUnyhx5ibnEKo7EboC/bs09/tZ54c?=
 =?us-ascii?Q?3o5ZqPze/OQRQy8tbQGre7ta4fxElYAmIWtNxQcXQHcQ8gTlEsG5WVO3VTlz?=
 =?us-ascii?Q?v8RcPAVz8tzTBkHWS1aoPyppFuQsUi35m+7/CI1cBFqR1qVdtrmOOKDu7d9X?=
 =?us-ascii?Q?cYk+k2Wv4dthdfY9Gjsw33LFT0iITviIQcYUfiGTvdXvDGV9YmdxAOqzA/oQ?=
 =?us-ascii?Q?UfDG5IBFpnfIIhkMdfRZEG4j1+N3eNsMdj6gpwZ2t+xzG7mNzO72hV0NuMth?=
 =?us-ascii?Q?GCWr4r9LXtYhhuEZhqvEMNSsOU5u9gbCIIcL4Vgcav/0MgWiCU00gczScIa8?=
 =?us-ascii?Q?4/Gy4hliFqMYVy5hScjtWEExavgUq1u6bLT+QuUzLSe9tn0ckr2122e9EsSo?=
 =?us-ascii?Q?rhxu8Bs7DmwmQVlkdEu22Tx6BvdvlDGkS4Iup6uuRxTUHI9/tM2HdM0TjicB?=
 =?us-ascii?Q?2hL8anBkMrtCLlpfzIScwKy9TyTflnPCf6/PUmYCw3LOMYSrcVgdztwvjj+u?=
 =?us-ascii?Q?rfzbwxfe5xeUlAtZg6eld6lMjLuIG4mF6mixHrI46V8mQ5SvBYDKey8WhlBh?=
 =?us-ascii?Q?u05UDmmP+NIOJjQmdYtOHxr+74+fwAWQlVQAtS29VrzZNswtQxWSTQ7NvZ6P?=
 =?us-ascii?Q?rfxQqwNcnzByFB9rpz6u4O+v3cYsW84T/xAUSowYu7rdvb+oyCBys1DkaPQg?=
 =?us-ascii?Q?vavfYHor47sufioXnT4Gzrbabwbml+sRjK3BVKZhIuI8n9+sOCPPFk+R9r8k?=
 =?us-ascii?Q?LM7NgUyeqkgiwYExV2QUSw9GvrrcxUeU8p/UyKvj9oXTaX387+zolN16WENb?=
 =?us-ascii?Q?zMwVGgL9P1l6dSRr7TZO7LLT+Cy1W/cAOqTtJ5BM25/ox9ex+HG3QDc1s/tO?=
 =?us-ascii?Q?X1Ir+STtxbrAnQHGiYKntM/JoqcgE4QK7f5Uc8cVH6YRH4OOfsulnnhDXv7T?=
 =?us-ascii?Q?+5zlc/6hOS9M7Lln1i4zBq8fqPGK60Veu5bj62ZPDwAuYXat9j5S1zx+jk+O?=
 =?us-ascii?Q?g8oG5yfVMCkbrXm30eYA0QyFrRf/7CZVaGagSf8F5155lF7Kgysc9NxQuF6g?=
 =?us-ascii?Q?FaBF6j9ji0yb1aWkVbH1Ej9wsoe77WrLSoGWJlYBnblyttR9sliWNirxg57g?=
 =?us-ascii?Q?JOaves1cJfTsEHvi3jMDO4kNdkMAIC7yH28fb4to?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bd13d0-c940-4e39-1c3a-08dcc104e840
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:20.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqCv7tgNYj15pPYXAgXyK1glXAU3vaJyFXkOxHvT7FCp2RiR8c7wVrYabmaY0zaJaAr5iup/Q+eQbmidrnAaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

This adds a set method for the QoS property of bcast transports.
This is needed so that applications like bluetoothctl are able to
modify the QoS (for example, for setting the broadcast code).
---
 profiles/audio/transport.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e8915490d..854b30601 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -1208,13 +1208,42 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.bcast.io_qos.phy != 0x00;
 }
 
+static void set_bcast_qos(const GDBusPropertyTable *property,
+			DBusMessageIter *dict, GDBusPendingPropertySet id,
+			void *data)
+{
+	DBusMessageIter array, entry, value;
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(bap->stream);
+	char *key, *str;
+
+	dbus_message_iter_recurse(dict, &array);
+
+	dbus_message_iter_recurse(&array, &entry);
+	dbus_message_iter_get_basic(&entry, &key);
+
+	dbus_message_iter_next(&entry);
+	dbus_message_iter_recurse(&entry, &value);
+
+	if (!strcasecmp(key, "BCode")) {
+		dbus_message_iter_get_basic(&value, &str);
+		bap_qos->bcast.bcode = new0(struct iovec, 1);
+		util_iov_append(bap_qos->bcast.bcode, str, strlen(str));
+	}
+
+	bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
+
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "QoS", "a{sv}", get_bcast_qos, NULL, qos_bcast_exists },
+	{ "QoS", "a{sv}", get_bcast_qos, set_bcast_qos, qos_bcast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
-- 
2.40.1

