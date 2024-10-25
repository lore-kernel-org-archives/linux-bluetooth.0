Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DC1F80DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858958; cv=fail; b=J0j3ain2Mg26ZCpwEJHyGcX/YKRSfvL41gBxl1VAs3YowNWpfR41jehqg4vj39Z+T9r1S9+Ifj8qpi22/Zo1RzUaQkwvEL3qxEpF2E7t69Vxv8RXzCLx8l+hqtUnHq0BNdsQGDByS/zfO6mKTPEFqJK2tKW3C3FkBniQFqsI3RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858958; c=relaxed/simple;
	bh=ZFFXxRCSf9Jx4GbQa2m//6EfaqXcj+5DDEi+eCi7Slo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKjEGetfOBuxhangKC8G9Vo8GdOQNDrvEJROuAceWt3yDcD8lM1lN+uZwwzDJGtqsFAmTlcYT7TeoLASesVJqbg0GMVDei/ZNMsW8fAKpkIH2a/LMISDGBWq6u044etMj0rNsm/oMxg1m2R6TokfqPzaGECTw6M7SzD/A9uNCJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0USWKtJ; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0USWKtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5Gb6sjCgztQZ/Fh77uM9jbz3TN4zZKBN7W4ogCKfv7zDNeR4Mj9IniqA9W3PsJiMhIUI6DdHdlO+VEq7zzqkxktA5IXeG2CADycQBgEL0tZb5ZsKu8Q79OeYgCk060yKdTf2nSsG6ljMZvGdahZmKsjNZ60suOLSL5h7Ge/8t9R4Q5mnT+nDvI6/NbGJ46FWMXlaH3yyHdqZSXvPuUPpRl7bqgRqB/6H3nhAAOR+vDMln/6BH2O50bofqBSUmySTyg/ifpYW1mQUuJ0k4NYBy7IvTvHN5An5Fcv+vnQT16pJYfJUdqoSTFj98ATWJYiBWe2s4vG/Y3GkPhEOnYx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/70KQ7Y2mqGgTXupXPGpsWqexp8myFutK+mNYzAWdU=;
 b=fkOoDmfp/YPD/5r/YLZ6vjasYVs24esz0ycEluEns0hG8WxBPaZZcovrFaGBZQMjHO1SNJatOt9NM8h133Q0n3z5NjrM2ljCNWrClR2VrNgoGKPtJy0kNCOWqXouyepOtFg/azU5PpyWCgZPLBAnCxxiNLG+9DGte3SJj5va++euP6qChS1GkQg4eP8o9xrbZ1dhpeJU3n1HwZaHVFipLUtMnxa39qhk+IICarA0Ya2HJNoJ9se4OVWmfz1UoVPIZvFMiGHQZ3NdoGzrpX30MN8vZnveHFUpI/umJI0stGLvXH5l/2g+C/c8OOwVxvMBa4B13Y51xSG20llrvdxBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/70KQ7Y2mqGgTXupXPGpsWqexp8myFutK+mNYzAWdU=;
 b=H0USWKtJjdySc7W5c4V1i7LucXK7V24+tojCEktnicgIN+zFBXGfy4nqMDheF3vMeddQAgFYfxaBWVFrqq9Fi7XUZIg91WNTAtyDT1EeHrcaZbAE7GQR5C5SPRLlIrWfTRVQDHqaiAjdqcL6YuoyyqSUkr0nqAucDfNYsyyCDy1z5gXVDuQGmHrrXGf6xreR61mJUoEpO1SyntDS7fJSMvl64+OC8vghOZMUg9iCjqKmtSdTa/PgjvtjTjISQAG7Oi7tJpJQfgz5osRwSXY2XjQ+rPRBQaOTiLTXdeoxkVANyD1n/6QRknPPynCh9QcZD3g+hCJvSGi670ZHgpDecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 08/14] transport: Add Links property for broadcast transports
Date: Fri, 25 Oct 2024 15:21:40 +0300
Message-ID: <20241025122146.17925-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b96eff-ea75-4bdf-ada4-08dcf4efb123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjTGMfVBVkLDjiLgbFOPmBDtkabalivQT4toZcd4HmYESwhRokIEsDDCsaTx?=
 =?us-ascii?Q?q8cSWEKdspWOOYDB83YGEkMF7tAC/TXFLmQETT8eeW2cfRfKnzII4IdCo0S7?=
 =?us-ascii?Q?HVH6NmNCGi3r3d4sAI4rfpAcFWLSMDuTVZdIKH2/L+1K3ICXzRLOJwEhIOIQ?=
 =?us-ascii?Q?8q5Pxl7fqGO23bioDa826ogquHmJN6XY4qT8m03BcYw2ZRmDa6yBNf1K1HW9?=
 =?us-ascii?Q?CJzF8ebYOpJNHhdW/v73I6atucZk3S9yxAXJx91NuCYilsOARM29iM3TyiaN?=
 =?us-ascii?Q?rqOmlpYqJHHFuUyTVO8YLgdS/HhLB3UQsj97C6rWUi4756gYzxB5Bx7Tgmwf?=
 =?us-ascii?Q?J7nf6XmzYxpRr9gKdcGSrP2PLKcqyGRgNNHfF0ICfZfXrsFPOsuWHGI3I9cR?=
 =?us-ascii?Q?11f3v6rcwBmxQdFivFdCpdrnD4Be+ZFJkV72Y+0J8i5BIKzb1zFdLnKW/B+T?=
 =?us-ascii?Q?iGkkgCMwJrT8x2pWyevd2RCPlMV2ICNEeg231H14v9KWnZ6mZ/optia0pCIi?=
 =?us-ascii?Q?Z6q+QTiQSaUi05yXRXSJxAC0+naFL0DhJxV9vLIsvzGFPCd54r2TAB2RwDL5?=
 =?us-ascii?Q?a6QExGBsHJ5YcmffiUr0b01SH0HnE6ejKV2J5S0suYLagftWnBoLLTmlfsfq?=
 =?us-ascii?Q?KM2VQAXWCsebtLuicPKxZb1oc0l+rq9AaGe2Cp2hCCQ9ZJaf9Dg45V9XN1dE?=
 =?us-ascii?Q?w90h3CwOz1jr0JpOWsWtszw9Hi/OxZN2E22bCKi8gztg0z0hbNIoHP20EedV?=
 =?us-ascii?Q?RkMtrADvCPKLpsiwgM+E1dtYFb2BKu5pEBZw4SfnETwLizsnUVvOPOCoL/aG?=
 =?us-ascii?Q?x6//CHSRZCBHGrWWxmkTAjvbxPl0IivNbBEPH3MHKKSidrvdpToVo2LIGxcy?=
 =?us-ascii?Q?1XMJV0ktJKhNYMvmoIu5aAfr+heySvWCR+HNjE4oZiSUbK4arolHzY+OZ9M2?=
 =?us-ascii?Q?Q69RPdnKBFQFYTa4nKaPEnL/myJrDeov4IvNdXM4xs6R1Gy2f9WlH8XT/EcR?=
 =?us-ascii?Q?D8O/+3akXidbZxwrYSGbIgX/eMfUhDM8m91/EwIY24k5xZg7y6OI2w6G9Ih3?=
 =?us-ascii?Q?bnTxtpHEXHL5ylmT2G6xOHYyWAUtemjjkcZCVEy1DM1qLWfwUh7E3R4TcJFq?=
 =?us-ascii?Q?az1Isrrj0QMxMoxt1AjrwX4DmJaxrC9ObrB/V2/ioZ/N7lZfbVfSaribB4sX?=
 =?us-ascii?Q?7rckWXTUGVAsDY4twIe9MxcOVeXnU/EIPSdL3eIxkm5q3nnMBw2dXaTOH4w+?=
 =?us-ascii?Q?fx2BVoudd5HP9ckkloSgAoIrzmBiLrRPFNG3KYgGJXn7WadSvy0huMiSELvZ?=
 =?us-ascii?Q?tDCAaMeZrJSo02SMVquuxZ9zkPbVs2ZJ0cjlAl9MC5FrJ9A+Q6GixMYlqc98?=
 =?us-ascii?Q?6M8nlGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSO71gRPQP6+uLQvb8GNegQw7vV04OhcTqFXnkqxeWQ69y20KRvg2TTA01yP?=
 =?us-ascii?Q?ifZv1relQAQWvrrva5oWnSur2MGOGIt15dz9JJcCox7CCb/IEUNcNh7y6+OO?=
 =?us-ascii?Q?v6ZF/bDLRk7J5wSGHfOvo8+PB96LrRoXOeu+5SqOekZS0k89b31turzs9pK3?=
 =?us-ascii?Q?yQmO+qRy1CpVZvo7Re8U7Dih4Ezc/FnC6YJ+PJGJFFDir4f9gw+5QqX4IbJ/?=
 =?us-ascii?Q?AJLHVXBJEWrq2ZAw3YYMexAHbvnll3nL/J9KrFAOhP7pM5AlUWeTibgGIZ2/?=
 =?us-ascii?Q?fXNcigyTdqEii3IQzDBo/BGTqT3Dc77FDt2PdqMVHV5a91jEmlicVCMfG2e0?=
 =?us-ascii?Q?oabxfYe2A/AmF6Ou23jp9bCuxH/u/8JAuxYbwflpu+Js5MWKKRP44+SHTqca?=
 =?us-ascii?Q?mE2oTxwZwkHGQ3SuNNI0Z1k4xgsKYLdkuUe0C+w2kOI4zfXkrA1YWEFkgyzX?=
 =?us-ascii?Q?pmBX7l9HuFsKdWekCe9KiFG2Xkv55wo2yiTecShHjr9U0q4enkaXegYJfL8M?=
 =?us-ascii?Q?9pwPQLlU4sOWdDSzwRtsxJnC3Nxb/QsnL6YmlZglYWXu5SX2rc0WNydtoTe6?=
 =?us-ascii?Q?9wNXQJrpwKZl71z35WzjgllT9vmT2QwFXj7yXUZmDchwRVtZolZWUlKoVbuv?=
 =?us-ascii?Q?PCbJwCfqdapnQv2oQFqX9s3bQLq8aW8mHsPkGfs7JTblevzCj5dqr8RUVby+?=
 =?us-ascii?Q?yGuL9rlDdBthOVjP+Pjh+/25bLycg04mHZ2VEJFlrh30f7MF8I4kHMcxk3Yl?=
 =?us-ascii?Q?+pwQ7H8RuD+OekjCe6kHocCZ97GHNA11gO1yoQP0o5HTv90bsHcr0AxjucNC?=
 =?us-ascii?Q?dkyhhTAHVHmIJpu2HOifXxrYtRfyWin4YSfba5gdrxfZaF2ROkpL8Wsp0j/g?=
 =?us-ascii?Q?7NH2J71rTxTKcrIL23yfYbTWkiQ892t4k42PEoII8dbD6bzLCVODLk+7SEJF?=
 =?us-ascii?Q?rA3dsGw0xDH1oNcM7x6Dy7w8hUFW0NPKkYxqQeNy/PDtImhTu91qaYxGlKWo?=
 =?us-ascii?Q?HCfQvaJVBEg77+t09SLotFBXnjNYvfJgtmvpQNH2nSxg9oxxgN+/02T2MHY/?=
 =?us-ascii?Q?cqz+cHxf+DIFiQr86Ys6LtX142A2IqEADQ3vrrLIwTWlLhM9JWPE3KX45CZi?=
 =?us-ascii?Q?v/SEtMmMIek9HYcBWkiodgq93cFGqkA1LofbYLTPVZ6kitmcxg/7WOjEu5H4?=
 =?us-ascii?Q?feiDKhXWc6T4vTAzR5ebR+IX5bCS2DcUgvsH7N7xG5715kGx4hK3xh2lYnH7?=
 =?us-ascii?Q?nCkPPqGnn+ujW17oV+AG4mm32+LnsSeToXzGi6VyEmgnlbi1CMSpZn39AEhP?=
 =?us-ascii?Q?WN1yP8h6vYA3uSCoFh8xo+vIpcEaR8didxn10IGasvy+MDunx8FtWUvk4mFj?=
 =?us-ascii?Q?u0qHtKZ9ZTHZe6spWtInz6hWVDN+VZw4dJYwDYlGeB53/Vu+0+ElraXdQLYY?=
 =?us-ascii?Q?+1qVAk4oxrSkXC7SfOUwJnNIw30tYfNXJ6lvN+I2ey7vtNYq/fOvqZ4XC/Ka?=
 =?us-ascii?Q?UyOp0Hn1qYJRB1fnqTMUuI0ggvQgakTFBTlKRTma8i3prtQUPOqxwi7J+ANn?=
 =?us-ascii?Q?XLpoQOo39cAXmPbBj7AeXB27poThr8LOVFw/7WQoLu4XPePe5rTXVY4JKQL7?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b96eff-ea75-4bdf-ada4-08dcf4efb123
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:28.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjXZG8vLxi5Iyur3aZP15qNAii0QK/vLngn0JGI3GSPJ1PQmtbbOFphVVSDjDrfaYZAXqZRUqJXGIfGjdJgmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

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

