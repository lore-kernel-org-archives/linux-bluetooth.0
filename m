Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75E19B5A0
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139765; cv=fail; b=aEWckkK8eUIj4oMnjO/y6iGiE2jytpXLlY2nacJnVMBIuG/KTRr8doI0H+MqzYoVeq+S8zi/tx1uaijJakQRLPF74BQDjrCG19aLvRVPZR/+LZm41zrrF7/PIegu4mWovysm5/pQMc0nkW1qlakhYaCPyA8kHlYvBTNyKynfkvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139765; c=relaxed/simple;
	bh=KmB6s0PMUX1VDKiTzq7Zqx6MgglffuCE/KedsxpxH7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7YMeCFNWxa60NPLw0xKPltT0Ca/kIaIjHcmMFtl5O0j+fQvWhsTBXDdGbeLsDies6CfOG8YtFf/Y3Tv8xzHO0lj0dqNA1evPidRSeGl7JEdxr4xXV8JfdnIYiVALkZA2s5Gr88BjPDR2wcxv8f40hKum51y46DUtiJj7blZef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jmd/D8ZU; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jmd/D8ZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTFr+WOMsS6LJbo+eyrCb6F4VFbnR1S38IhahiFOQS/d9Ob06Bjjxj9mgnWX4zVOaHpZXqWDvtedfU0ioHefNpUXH44yVo4foLk2O36Q+SQUst/TUDehrbnghKMumMXQ3qOQjed9a+/cN4YFfnQz7pe2Ylzl+/hvs2dWtIk3QtHZ+MoKuCU1U/14hydAIdTMwlvmlh9ZC3W0g3fkuHfWGsYx6VsF2/5LNWNVbFP3OFoOoUCWemPKSiXaslaBdqByR2eZrpArDbVNuuqYJNhDTnYC7fTJEFicIZMA+RPn4F+6hM+txdKBgdtGgf9+2wWblDNYVyEGL3gWA0p14B3FOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAhAgbUq4RYQ2ObacC9nDZUA6hE0rqcgrhTOdHxS7LI=;
 b=d3nnU95daN70n1S+FFA8QXVUFFkRsfjIpkuRZJtVfBWHWhKlfF4Lk5b/5R6f7yNWaxZ5DDKBTnYX/+k2YVUkO6+bsE8o8W5yQvHNO7acMJRtYkZAN0U6WHdHcoNUS9wE1ffAeeoqbeIfL6lnW/KuNOt5vdwm4HzKolHAWS/75CLmHcfyf3soBIuPJs58qGV29mxhJgf03nO2uiW7IHoQwZ5e1fs4TY33yRbyojWt67T3A4xEZLuTnPcigMXjwurqVZt5Avq39IqG06rceQgLA2en1eB77jMlVBV6mYtzAfmv37iI7AcRio5gZxpAp5x3PHL2HMWOf0cypCGqd0qL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAhAgbUq4RYQ2ObacC9nDZUA6hE0rqcgrhTOdHxS7LI=;
 b=Jmd/D8ZUeUA7IbM4IcZNDH+y88nJyqrBa6mvlF/2ThSKljitw8zJzBpiBjQ02Hr2y3ceW8T6uyT7ZDZwTFXndTjdO+PJ+ItKq3BVwQ0yfKsklR2gfuI/FB26HelQ2nNwbsVTxKVCKK1b3t19ko27Zj+3H9mAeX9GZ705YDpSfA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 08/10] bass: Register MediaAssistant objects
Date: Tue, 16 Jul 2024 17:22:05 +0300
Message-Id: <20240716142207.4298-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce33688-a5a9-4a70-6004-08dca5a2bfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMs8QOi882Deu8wEnN4MPWSOPlrcvQs50Qy8EpYOr5u7sC+RgCwOrZ6pbnjw?=
 =?us-ascii?Q?CQE0GrAY08TdmkH6jVblu9kOyTVP5+TnbR9iJ207SWOfezGBjTLjUwm5Wprb?=
 =?us-ascii?Q?VBpYROppBQuD602khEPHAwocGW5xHIDCc8+yn5z61e2j890qX0SPeElPfjEC?=
 =?us-ascii?Q?OaVetdISlJxGqVWcQWVBX4l2CHQ+Bq/G7sQ3Byc0jRW8pRccfPL3HUtlpe+g?=
 =?us-ascii?Q?PHS2uX0F3TBAPfXYr+4rJYSyXFrEN00cTerjmg15n9M2akPRQinutk4HvQtS?=
 =?us-ascii?Q?8bkMPZo4u4ESigx+5bbttUDqhGncHiajZacVWh5Q5NnhgheYLLiqfQO57Ck8?=
 =?us-ascii?Q?nteXdxJOTYrVktVMoeSkbqBYrei/AxxesT5PGb+xVz2a6+HSDsacrCah6sql?=
 =?us-ascii?Q?k2hAoyaKDwGHylKrj2jfcrtTkKJUriRVh6Wh3ytUkmyo3QQQAEIEfRf74n64?=
 =?us-ascii?Q?p7l20Df5oW1qy8+pj/mKZ+j16CbZcWEPnWtE1Fb8p46s0yZHyFd33H7P6FRq?=
 =?us-ascii?Q?AmNkyGO2WwkqWkYTWU2dFGYvkej3qde3PDJppDqitj23UFzkD+Z8INDv0KWq?=
 =?us-ascii?Q?G+/uwxIFsTFAyIUKPoJ+YsYqezewSvYeW2IXwHtCm2SgYyycRGzYvru4sIsT?=
 =?us-ascii?Q?51Yr/zvyF0LJbQYJ8duo3MvkepOdcV2vavDdaCE2XMVFO7NlHXymGGXOqh0Y?=
 =?us-ascii?Q?odNOX9uT1PCPQ8PogCiqBDlQ+mTwbVf0nISliDrdPdPxk7v9q9aeMAEKDdSg?=
 =?us-ascii?Q?d839FzEkFVtj42udjasSYuQbuZJXNdf6qQTtwq3jIjeRdlk8UjcWBOjPwbKk?=
 =?us-ascii?Q?3bMvhQzzYPfXgpgn4wDNdKwfUeBfDUsva8mqk+rSYBVbiYlDidLJFjFKSjTP?=
 =?us-ascii?Q?PF0inCGkXPO7NPGKlZ3E4k3aUkZCERH88V0z6e0r4UCPZmmhLIuDkqQPF5qG?=
 =?us-ascii?Q?18/93onnhMitd0Afx+61Y0ikKIZnGh2AKqGt4NHGWvbag6zy2KfwOn2nysCz?=
 =?us-ascii?Q?9N99kO02/oHB6E+B6YlFI7QIIdNxcyXBFcQ7v/o2kUlPps9wF6v6YGU/TuTc?=
 =?us-ascii?Q?Ka+twRs7k6Am3DiPriTXhZAoVkpEhqo6IPCo2CvmiLimxxfxQlKYpY4uomY9?=
 =?us-ascii?Q?4dn9yAAzxH2rlgCZi/sOz9+a9r7v/okBEsGw5X/zvPSVcYL2J/mQHp94umbC?=
 =?us-ascii?Q?klOhvjNVTuiZEu725KtGCnB98gPHMHRE9jvlngbg8tVKhMUUdasIvyu0GG0J?=
 =?us-ascii?Q?y0zXbJ1oFojIs06FPFQYzmUtPksOPyrUBanxdwDG9Ey5HT50fdAC57Gohmze?=
 =?us-ascii?Q?a3zciNnEDWCRX7TrlPCbLpx3a5SK2g9GrranYv9am5TLEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ed1raFwN1MwB8E/NQRpwaSN4cw6B/18xJSl3lBq3b0B7MdKJqRsbHjmMhZAw?=
 =?us-ascii?Q?zSrag6twKtl5pe/s6moRQr7I/NDJe8fVdtILP8IqfrbW+YFNj5vcTDTMFPCG?=
 =?us-ascii?Q?c/7Pe+xmiUr/7AdLM4QNQ5Cx21voM0XDv6KI33+JgRHtt0akk0wAMTaN1c47?=
 =?us-ascii?Q?gW3053uu/yBzMjiFJlCoURrxyz7tYdku8pNnjw/7wbP8VtEZqv+L9SEqQghu?=
 =?us-ascii?Q?9lCHXy1llrc9UY/NonZyQSdAD2V7oO5NY2ZWpML/CVxCoHFr1b+mbFpW6KDV?=
 =?us-ascii?Q?eJ6JWjqTERD3u5gc7LVbV8zmbw+AWW87sZLI5dElvUApPGbmk72hjFrHwuK7?=
 =?us-ascii?Q?5Sc4/VTs4zhBPaegZdCZjbC2yunspo3svQUASitJ0VpDOKFNCxepVddj6SE5?=
 =?us-ascii?Q?jjR9drYdMgsJ6En2lYd/sA1kCjsX1AN77gk/81wyhwCdG6fSdt1HDdcfpMau?=
 =?us-ascii?Q?6nfgQvz1lKQEpaomYj1zxWh0Hhqg4FuA0psKexf7h2RJs70W1P6W3AYosZHx?=
 =?us-ascii?Q?bVHiqUrPzPWA23sdtUQy5g5aVThmIojq1lf54y++8p9/way7nUGQ23ia9sxN?=
 =?us-ascii?Q?mcHa2ATfa9m1rCqQ5s9nZmtgYWaWRbkTcwXljIdh8uOPmHL4nb+TpzmrHCz6?=
 =?us-ascii?Q?3Rq1BxJtzMUqVNBpSbv+bFLaeWJeUlp6rGntENaMOvdb5WsMYPqZKhjF3AHn?=
 =?us-ascii?Q?3wTf5VG4jhzBL2v+DXaKPpvy0E3dJZyS2WIVKMrJ21xMX1ics+i/gyn9DI+i?=
 =?us-ascii?Q?R3THVdNz9ZmRiIsyme8HEw3ybvC2XFM8PnZGgqWmGglIwqQ1Ub45nUkD01z6?=
 =?us-ascii?Q?k3o1MEbrSns21EFE+VV5Y2+3c5WcN1gndc9iD/9VgBqa7u60vp2jCgPmyUIQ?=
 =?us-ascii?Q?WqWVT/+xa2b2K9fzb0n07D67uHRCIwV9bxZKwHw2f4/VG4rc52zhUEQCQUbU?=
 =?us-ascii?Q?3cP/G+Vo2/v328i5mz+ICsrs9UzmrMamIDp02lccalDh/lFaUYucCfizPhAb?=
 =?us-ascii?Q?mxP0bll5B7P5EzGEWtAeXPmg+dSRo1GOoP88x2PH+oaRYhHBFCXUW2EpHMOS?=
 =?us-ascii?Q?OIOPmCdMFrh5JZknLMx0mj07toT68Zaj3MRVW9tRYgjPyKsEBsULtJ3bziu2?=
 =?us-ascii?Q?7fdhSc78LslCeTTzDfc0t3MgiJpar+kUkVLr6nHtf96+iN0/0wCnbeBmvyMi?=
 =?us-ascii?Q?nqhXs3fQLapKHE5zaFQtl+uHtIz6q8UIDLTx0jfkYZlcFYEpK6P6wGsqURCQ?=
 =?us-ascii?Q?/9mSDG8VGW9o3uOvh/XXJBHxBkM0U3ea74e7PST+AuP5zJhECh2QWhAgOpfl?=
 =?us-ascii?Q?cbDgBQUw1YSHQMJCMW/O5tEgIUzAz7dbrycN6Y+f7p6ECP4i9K7MRJLcO9h2?=
 =?us-ascii?Q?HpvVIJtcaDJtcUVR1wdCLjERGrLhiWnCGHk6LKiLxff7Lqm6bAuO8z/TMBHt?=
 =?us-ascii?Q?zlZlpD8IYpXPPf2fnoTutoIx6TNCJkQdvbzuXMZEGPZanT8Z/e/t3tLQOZCU?=
 =?us-ascii?Q?VyyicfYAUoA8eV4925I4VSxBt9jcKJHSWuJLNkmOZfbskbRVXzqwlKMyumpn?=
 =?us-ascii?Q?ZtGDDUOWjs8/DYOXN587J1SNpvwWKDguE/Gy1cOhRXbfg1qpq3Xnsd/7/4F2?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce33688-a5a9-4a70-6004-08dca5a2bfc2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:40.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLD5X7FvCDdhQ7drd6ZoQxBeGDo1BK8r6WECAdKUdiAeDvBDaV2DDiI7G8Z8cRXZqXYS/g6rRjPQ6IlaOBE76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This adds an initial implementation of the BAP Broadcast Assistant role
in the BASS plugin, by introducing the MediaAssistant DBus object.

The BAP plugin implements the callback to probe Broadcast Sources and
parse the BASE. This commit adds 2 BASS APIs, that will be called by the
BAP plugin to notify BISes discovered in the BASE of a broadcaster to
BASS, or to inform the BASS plugin that a broadcaster has been removed.

For each BASS client session, the BASS plugin checks BIS caps against
the peer caps, and registers a MediaAssistant object for each match.
---
 Makefile.plugins      |   2 +-
 profiles/audio/bass.c | 257 ++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/bass.h |  13 +++
 3 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 profiles/audio/bass.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 9dd8134b4..9da29a3ce 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -120,7 +120,7 @@ endif
 
 if BASS
 builtin_modules += bass
-builtin_sources += profiles/audio/bass.c
+builtin_sources += profiles/audio/bass.h profiles/audio/bass.c
 endif
 
 if MCP
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 7952105c5..083988358 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -39,6 +39,7 @@
 #include "src/shared/gatt-server.h"
 #include "src/adapter.h"
 #include "src/shared/bass.h"
+#include "src/shared/bap.h"
 
 #include "src/plugin.h"
 #include "src/gatt-database.h"
@@ -48,21 +49,265 @@
 #include "src/log.h"
 #include "src/error.h"
 
+#include "bass.h"
+#include "bap.h"
+
 #define BASS_UUID_STR "0000184f-0000-1000-8000-00805f9b34fb"
 
+#define MEDIA_ASSISTANT_INTERFACE "org.bluez.MediaAssistant1"
+
+enum assistant_state {
+	ASSISTANT_STATE_IDLE,		/* Assistant object was created for
+					 * the stream
+					 */
+	ASSISTANT_STATE_PENDING,	/* Assistant object was pushed */
+	ASSISTANT_STATE_REQUESTING,	/* Remote device requires
+					 * Broadcast_Code
+					 */
+	ASSISTANT_STATE_ACTIVE,		/* Remote device started receiving
+					 * stream
+					 */
+};
+
 struct bass_data {
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_bass *bass;
 };
 
+struct bass_assistant {
+	struct btd_device *device;	/* Broadcast source device */
+	struct bass_data *data;		/* BASS session with peer device */
+	uint8_t sgrp;
+	uint8_t bis;
+	struct bt_iso_qos qos;
+	struct iovec *meta;
+	struct iovec *caps;
+	enum assistant_state state;
+	char *path;
+};
+
 static struct queue *sessions;
+static struct queue *assistants;
 
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
+							  void *user_data)
+{
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable assistant_methods[] = {
+	{GDBUS_EXPERIMENTAL_ASYNC_METHOD("Push",
+					GDBUS_ARGS({ "Props", "a{sv}" }),
+					NULL, push)},
+	{},
+};
+
+static const char *state2str(enum assistant_state state)
+{
+	switch (state) {
+	case ASSISTANT_STATE_IDLE:
+		return "idle";
+	case ASSISTANT_STATE_PENDING:
+		return "pending";
+	case ASSISTANT_STATE_REQUESTING:
+		return "requesting";
+	case ASSISTANT_STATE_ACTIVE:
+		return "active";
+	}
+
+	return NULL;
+}
+
+static gboolean get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bass_assistant *assistant = data;
+	const char *state = state2str(assistant->state);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &state);
+
+	return TRUE;
+}
+
+static gboolean get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bass_assistant *assistant = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (assistant->meta)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&assistant->meta->iov_base,
+						assistant->meta->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean get_qos(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bass_assistant *assistant = data;
+	DBusMessageIter dict;
+	uint8_t *bcode = assistant->qos.bcast.bcode;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
+				&assistant->qos.bcast.encryption);
+	dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
+				&bcode, BT_BASS_BCAST_CODE_SIZE);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable assistant_properties[] = {
+	{ "State", "s", get_state },
+	{ "Metadata", "ay", get_metadata, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "QoS", "a{sv}", get_qos, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static void assistant_free(void *data)
+{
+	struct bass_assistant *assistant = data;
+
+	g_free(assistant->path);
+	util_iov_free(assistant->meta, 1);
+	util_iov_free(assistant->caps, 1);
+
+	free(assistant);
+}
+
+static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
+		struct btd_device *device, struct bass_data *data,
+		uint8_t sgrp, uint8_t bis, struct bt_iso_qos *qos,
+		struct iovec *meta, struct iovec *caps)
+{
+	struct bass_assistant *assistant;
+	char src_addr[18];
+	char dev_addr[18];
+
+	assistant = new0(struct bass_assistant, 1);
+	if (!assistant)
+		return NULL;
+
+	DBG("assistant %p", assistant);
+
+	assistant->device = device;
+	assistant->data = data;
+	assistant->sgrp = sgrp;
+	assistant->bis = bis;
+	assistant->qos = *qos;
+	assistant->meta = util_iov_dup(meta, 1);
+	assistant->caps = util_iov_dup(caps, 1);
+
+	ba2str(device_get_address(device), src_addr);
+	ba2str(device_get_address(data->device), dev_addr);
+
+	assistant->path = g_strdup_printf("%s/src_%s/dev_%s/bis%d",
+		adapter_get_path(adapter), src_addr, dev_addr, bis);
+
+	g_strdelimit(assistant->path, ":", '_');
+
+	if (!assistants)
+		assistants = queue_new();
+
+	queue_push_tail(assistants, assistant);
+
+	return assistant;
+}
+
+void bass_add_stream(struct btd_device *device, struct iovec *meta,
+			struct iovec *caps, struct bt_iso_qos *qos,
+			uint8_t sgrp, uint8_t bis)
+{
+	const struct queue_entry *entry;
+	struct bt_bap *bap;
+	struct bt_bap_pac *pac;
+	struct bass_assistant *assistant;
+	char addr[18];
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bass_data *data = entry->data;
+		struct btd_adapter *adapter = device_get_adapter(data->device);
+
+		if (!bt_bass_get_client(data->bass))
+			/* Only client sessions must be handled */
+			continue;
+
+		bap = bap_get_session(data->device);
+		if (!bap)
+			continue;
+
+		/* Check stream capabilities against peer caps. */
+		bt_bap_verify_bis(bap, bis, caps, &pac);
+
+		if (!pac)
+			/* Capabilities did not match. */
+			continue;
+
+		ba2str(device_get_address(device), addr);
+
+		DBG("%s data %p BIS %d", addr, data, bis);
+
+		assistant = assistant_new(adapter, device, data, sgrp,
+							bis, qos, meta, caps);
+
+		if (g_dbus_register_interface(btd_get_dbus_connection(),
+						assistant->path,
+						MEDIA_ASSISTANT_INTERFACE,
+						assistant_methods, NULL,
+						assistant_properties,
+						assistant,
+						assistant_free) == FALSE)
+			DBG("Could not register path %s", assistant->path);
+	}
+}
+
+static bool assistant_match_device(const void *data, const void *match_data)
+{
+	const struct bass_assistant *assistant = data;
+	const struct btd_device *device = match_data;
+
+	return (assistant->device == device);
+}
+
+static void unregister_assistant(void *data)
+{
+	struct bass_assistant *assistant = data;
+
+	DBG("%p", assistant);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				assistant->path, MEDIA_ASSISTANT_INTERFACE);
+}
+
+void bass_remove_stream(struct btd_device *device)
+{
+	queue_remove_all(assistants, assistant_match_device,
+		device, unregister_assistant);
+}
+
 static struct bass_data *bass_data_new(struct btd_device *device)
 {
 	struct bass_data *data;
@@ -101,6 +346,14 @@ static bool match_data(const void *data, const void *match_data)
 	return bdata->bass == bass;
 }
 
+static bool assistant_match_data(const void *data, const void *match_data)
+{
+	const struct bass_assistant *assistant = data;
+	const struct bass_data *bdata = match_data;
+
+	return (assistant->data == bdata);
+}
+
 static void bass_data_free(struct bass_data *data)
 {
 	if (data->service) {
@@ -109,6 +362,10 @@ static void bass_data_free(struct bass_data *data)
 	}
 
 	bt_bass_unref(data->bass);
+
+	queue_remove_all(assistants, assistant_match_data,
+		data, unregister_assistant);
+
 	free(data);
 }
 
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
new file mode 100644
index 000000000..5bef92946
--- /dev/null
+++ b/profiles/audio/bass.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2024 NXP
+ *
+ */
+
+void bass_add_stream(struct btd_device *device, struct iovec *meta,
+			struct iovec *caps, struct bt_iso_qos *qos,
+			uint8_t sgrp, uint8_t bis);
+void bass_remove_stream(struct btd_device *device);
-- 
2.39.2

