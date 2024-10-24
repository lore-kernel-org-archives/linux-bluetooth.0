Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804141C174A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767790; cv=fail; b=BQfvljfFeH5NNfwHhyrowZ5rVJMMyb+Mr9OTm0MK/B4UiZQFKonhnQvWNN6dDdIk+UH3u4qlgauGZxXoLDQY3ejJQ+Sf8F0B8NSBEF0cuvzkTwPIDDZcWEtbnOyPfo/t/N/x2yO2As6o+7rf9fi6BDWJB0aaYaNVQ7AsUp30/6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767790; c=relaxed/simple;
	bh=ZFFXxRCSf9Jx4GbQa2m//6EfaqXcj+5DDEi+eCi7Slo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtIbm76BN/clRMiOZDZOfS6RMFTBxS1YKfxyWPEQBYIx4bVk3DqNL62z9OtCRsuie4z8zf6b7bVjgaSIMLlVe6kjxBn25MT0lGwhyb5kYHS3OWEOCbNkNcDmoO5oDZb0kdXs2H+8TI2Fr2Ts6qeb6utm7YrM63XvDBntk+PLjlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HhCaDyIk; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HhCaDyIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbB8nuNAbrdSXjSVhzMPPE/EcqzYhyVyTAugQe+LiLWLspgsfVTyYsUUdws0nwmH/rDUddyswsz7usp736pGIXRkI0mzh65cthYm2SEJBjR5FCGo1owtZ0jx3dnPmpXxahzEw37ga/n3TjMiWdziM9I72xN6QGeZDEDKGYkO4gjrqgytmAcoTdljOJeTyC29Zg82VMNoRD2SSOEtYIb9hx1dgDHMgMWYbpDATwWBTFiCVd+7Xr7ZR1MNwmHl0WZcyyzNq5Uz5FxixWK8PNxOCPQieQBKwRHBEGIDWmuoaMLBXIhzXKQIw257nE/F4ktzLq6nlr0bFbS1DljL9z0G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/70KQ7Y2mqGgTXupXPGpsWqexp8myFutK+mNYzAWdU=;
 b=fU3nbXmjNVE5sT/iuplNyde2Up/ZD6x/mPrMlPo9RvGazBIP2+Si0sOvKLtebG037mljGO4YHdFsyQSQnDLLk0h3G5qqEBgFfZNnYGQ3wL5lpxjXrX3JI0mzEgHfWjFBOwdytQD1O0hKS6OQuXxNkpe4xyuKYuGo0cmJgvj+KV215ysYDncYxjIg0ojyntEeFfLRqpZlAl+GKxPG5ctgqyzLCkh0iXqdvVvLNMAb7F8sATBt7+DN4CkMwGOXmsDM/wPXsZQnR2QLDmq8sYsB+H894Mu6J3EkIz1I3Kf7IzIrV0Kl76Yh06+Q6pPZ2lW7iLKC+XGcViPpXK/hqgLgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/70KQ7Y2mqGgTXupXPGpsWqexp8myFutK+mNYzAWdU=;
 b=HhCaDyIkQnrWkjrv33ZDR3RM7bR557mcI01B4WjAp8ddIHbJIWvNFh5cf5AdRVySHiinnW9SU85PlrD+tRbOku71PM/8xMqczh0S+z+oiML7tQpqoUPu/B63AkIW3Y6tYczcXRGfSJh5mPJMyGl9Cqe7MEA//rnc/jZtQJDRIlqEVeliSAZsZOS5JYKyLmvt00HyW0il1Pyz5oU78advTBDUI8vaor8Xvx+5e2XQXDBLKW3QwFxdey8Yih/Qs/IAYEz6gg4eDJ/Ef1TrdAaWn1dWeuOtq0ptVvwN2ATXgQff+UAZi6rErCDbnKHj8SlhBxFc5+stC9g/yzeENvPkzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:04 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 08/14] transport: Add Links property for broadcast transports
Date: Thu, 24 Oct 2024 14:02:17 +0300
Message-ID: <20241024110223.77254-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 462c239a-c986-487e-7938-08dcf41b6f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxYeRwCqRmZ/Ng3xYJAG6lSC4v7Bftkyw4wNYdF35hLiVbhnceS4M3iofGBd?=
 =?us-ascii?Q?uluXA4N++lVIbTHdrbgDL3ECQogA3Ug4/BD7K/s7nHyepVXKZIfRxQCzFuOI?=
 =?us-ascii?Q?nBYr3paOh7Kji/9cJaz/nYAYmMvSVNJsjc8dUiY/oNEf4XrMu+Nz3kL1xv9P?=
 =?us-ascii?Q?RKXjG05uBsNRChFN2M5NbIGDVnI4659MWvSWWR8Bu2w9taCQR2H3TiyK4bvB?=
 =?us-ascii?Q?kFKdI23IQdPzFEU27bnEHbI5LHvrb4C5gBHwDegYHGUzxetAVgzwoEAFQnv2?=
 =?us-ascii?Q?OEsUAzU8kLHsSASJFGCqHFNBvMh4RVSxXXoMhyNCjK6WbJHgeTUnTgLl9OTP?=
 =?us-ascii?Q?WAYfD8+DgUoQbPgf8kJXZJSzmM835yVrQCwsgLMe9MbDUvY12S8D/c1zRH6t?=
 =?us-ascii?Q?I6i459hYkRxLuHThTq3tWAhxVldoo45IscTYizjyNOPyAdC5dmtanlwEhVtr?=
 =?us-ascii?Q?1mKFDrk86SM0TqvpkYSghrm4ix0HRe/VP78qd5qSrQkM754YSYU70Fj/ZqPj?=
 =?us-ascii?Q?Hkf6IR3aifjkmsU3PWuixMbmoVMHL5LB8O21fu/c+IQHRhSY0OlkOB+7viYN?=
 =?us-ascii?Q?+zmkrerrBzbG4DQq8G34/YehhiX3YWfLhhcGsBqJ9jSaqqhEhskOQLlPFnVt?=
 =?us-ascii?Q?FwjzWKOS8sejjnZbw3fZ/Yio65VjOPJvqlwwDR6SZFlSHyHw1scMmGA2JwWj?=
 =?us-ascii?Q?NpVvNyCCdZMYZt9DsGNPPu2I1LRDVHI8bjGoa/QtUvPUT/DqpmPaJqocYACo?=
 =?us-ascii?Q?QLrjFb+q6Ez8szNGx9CCnmRx+eTC/mF73iyRHUvtOic7UpfQsoZQC2LhmQRZ?=
 =?us-ascii?Q?zc2HXcw62BtDhWevj8lF319RgoNNNZzL64YBWbtZfbEJYDyU+itegW1x+PYJ?=
 =?us-ascii?Q?ejREt2+I3MylJKIGXQSTnCpAkhM3iG0rAgAYRqLMGAzV2OPabBnIOxptsEYo?=
 =?us-ascii?Q?cHZax0DrAOL+fHsSdUyQo7e79SS0MsSy5NnjuZRTJfrirQO0Ox0R8N258NAI?=
 =?us-ascii?Q?7ycVKmTzMvd8yfK+rCV+HD7aScwS/J+c6i8rKs/MJ45xfwHcm+U3M0Py1C7q?=
 =?us-ascii?Q?E28IKI6DUc6UxOgsSyhA1GH28Af87jUATQHsKqoDEaKZ/7XTvbBIgaAsFtfs?=
 =?us-ascii?Q?FNCpAQrT90g0tgM8bWRvWGehqtxfHJfl1NZLqGOYKZDHsHnkc2wL0rwasTB0?=
 =?us-ascii?Q?AP6TkwyjNozhvO9V4N+iPAIT+WK4Bf0LedqVkPzaIDNVhqfn60JjSuEjqlg6?=
 =?us-ascii?Q?Y/L2x80UeziWxdQ/fNQ14zCJGqeUTeJ72HnXMqGv9YxBaA5zhRPs823MqxiU?=
 =?us-ascii?Q?qnNnB4VecaPBLIbmW+T/DXiUHe9Xto/Iuzgltoesh7N8QHgG7ISEFgdnBIOe?=
 =?us-ascii?Q?HvTMh5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1V117PotcbwDSyWUCyOSTKTgROTKJqzMeApJCTT4pcsoyNhOJ9Bd386IdmD?=
 =?us-ascii?Q?podfsndC7SFhAQmm56hYPqraldkd1fMn+4eRp6i+QknBykWNX02f19hJ3+Nu?=
 =?us-ascii?Q?DFgLhMMs/pEXauwBxwsKvqpmrlbVTP2gUUpdgZ0mp/TtmBf46Y0jtnPxe97a?=
 =?us-ascii?Q?YzcysWUsBaTZEouCk2ej1jJtrcDsySHwEn7S90JSRv/PsO5iaPd49pADnbTI?=
 =?us-ascii?Q?BhEqqdTQSm+GLIFf9McR5y/LM/1A20RnCfsf0nLumZN6y0yp6/4UUMGbvFx4?=
 =?us-ascii?Q?NZu+cnrTfLZOHGb3GGCeqvGnSuDL5agfcof4MeDEj9/RKrZiFjqip5XNidmm?=
 =?us-ascii?Q?D3HGRaNqnhF2jMroJvCGyGWbtG7fXiVqGIHM7TqqwN+MUe/9PcPb3CixH1NC?=
 =?us-ascii?Q?TSFi6Rbc0Z3koUI+Q04t2CHGd6AVP+9aUlSDpUIm9Obx9+XKNaz+HhWVWBEX?=
 =?us-ascii?Q?dl2TkXd7mm+DGPAv18jJA2G56Jw8zvmxxzBsxqiSShdaTOjDdtbB8Mr3r7gt?=
 =?us-ascii?Q?oh9jxEi4VCrUXBm+RpMabhq79eyghvLehXvVmyEHTfvTeJSBSb6ebsWScGng?=
 =?us-ascii?Q?31MBfuB+x2/9dxv4P9AQQvJj4yHvHKgCXuwtMgSzpBgB50cXsq7rWGzWFDoD?=
 =?us-ascii?Q?ZGrs++6SSE0PwQTjDR2OYrpy/tB0yaatts5cKV47afdz4lz85jF6UZs6xukI?=
 =?us-ascii?Q?3awEiCfY7GKNcIIIbgBMX3UmVE4KrNmYULs3NTBBCrM+vr5Lm6b4B3NDABpf?=
 =?us-ascii?Q?eDF4M2EVSIzJSiJaad+GZ2MPy5J1my0rW/bx0tweKDM9lfOagJrydnrJcPYM?=
 =?us-ascii?Q?VgFVy4ObhPHqN+hbIMPvURTwQn6BLdZDYbuZXWIrYU8JxMyZs0sb2QqUWzZf?=
 =?us-ascii?Q?DiqbT/51ooxu7PE+rThtwanoTAyZ1giR7MdScvVDcqowv/rwBSDzjnhN2EhZ?=
 =?us-ascii?Q?VqwdSYOcVNbbaFK3MKSzcnaS+Ay5iSyG+H80/ge355QXaTBl5h/nphNEwXOD?=
 =?us-ascii?Q?WmABA2LFsPWj29td5ZcX3pJtJGVegJ6uogDdIFz+n/cUQOiQ4MuR5hyGyaxt?=
 =?us-ascii?Q?tfV9Bz1ifTHA9DzgLa1TvDEJpWbyvBE3nPtL82mwc1XPN5Urojn8MVomPDnG?=
 =?us-ascii?Q?vzp2ju9pL4gD9LaDcxbfPmoSaFkHKAg5T37ppAw6DGm4wBUB+wQQE/RaA8wa?=
 =?us-ascii?Q?JoAccSjQPAbNG9bbpNiY4fow9544wx6KnOrqETodjTPW72mtgnQSrelgM1k+?=
 =?us-ascii?Q?jkNEzM67U+6j4TpxmYc9X3eV3qKtYU2HPRVv6g+j2EB4DJ+GK4ZOqp7HCUrb?=
 =?us-ascii?Q?AWCRGPWXI+PobAYABZQBDkvKeqQCJo92TYAypVdc6g5AaKr5LR66L4dyB7Oj?=
 =?us-ascii?Q?VXRqVPOYl5NdNyDbB4qFjSzVSFxlPxVwmbYcUn7sE5O9345A9AQT6RndBjw3?=
 =?us-ascii?Q?cXGI84+Lu5wKOIUzi7zZFJIlO/9vYDm6jjCmkDAwNcttgNgSy1ErZZSicblD?=
 =?us-ascii?Q?2QY0gBn3L60o27UdOWa53uOv3+skS6T/PyqPyM5rJadKKBen2NHGcsGL565b?=
 =?us-ascii?Q?8vRYWirGn8JWbzV59IpKwggq+SZ2PApxSileU3ao7JdbbXKiofkCz0wePVoy?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462c239a-c986-487e-7938-08dcf41b6f34
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:04.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3mikXwvDGFXhL/YM98vG2eXTJLnLXzdF2q5EMn0gLpwLZvm7aUEsdmqX4DrERB1P17OyNHTSnxRYK60vrBs+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This adds the "Links" property for broadcast transports, which allows
upper layer applications to write and link transports together.
---
 profiles/audio/transport.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dafd1c471..b3bcbaa19 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -183,7 +183,8 @@ find_transport_by_bap_stream(const struct bt_bap_stream *stream)
 		struct bap_transport *bap;
 
 		if (strcasecmp(uuid, PAC_SINK_UUID) &&
-				strcasecmp(uuid, PAC_SOURCE_UUID))
+				strcasecmp(uuid, PAC_SOURCE_UUID) &&
+				strcasecmp(uuid, BAA_SERVICE_UUID))
 			continue;
 
 		bap = transport->data;
@@ -1142,6 +1143,64 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static struct media_transport *find_transport_by_path(const char *path)
+{
+	GSList *l;
+
+	for (l = transports; l; l = g_slist_next(l)) {
+		struct media_transport *transport = l->data;
+
+		if (g_str_equal(path, transport->path))
+			return transport;
+	}
+
+	return NULL;
+}
+
+static void set_links(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct media_transport *transport = user_data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) ==
+						DBUS_TYPE_OBJECT_PATH) {
+		struct media_transport *link;
+		struct bap_transport *bap_link;
+		const char *path;
+
+		dbus_message_iter_get_basic(&array, &path);
+
+		link = find_transport_by_path(path);
+		if (!link) {
+			g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+			return;
+		}
+
+		bap_link = link->data;
+
+		/* Link stream */
+		bt_bap_stream_io_link(bap->stream, bap_link->stream);
+
+		dbus_message_iter_next(&array);
+	}
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean qos_ucast_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1295,6 +1354,7 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
+	{ "Links", "ao", get_links, set_links, NULL },
 	{ }
 };
 
-- 
2.43.0

