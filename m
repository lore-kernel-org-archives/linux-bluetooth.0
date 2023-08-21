Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0923EE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjHUPvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE432101
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YToZ3GlEcsTrbREPZhgCco+Y/tFEy+bsV6L33hXbq7LLUlw8fYmfb7REDv8j/nwKIru+GRJGnWhnTpZoA5HHHOzZu5PRWkKLvdhhN8XI5W3PICGvIACdmMKq1FAfd8etquZA9wQoszsFOFQzrsCCXRO9vbda7xo6P4mARdrBAEGgUYvagNfuKTzRkVNiOYtL9IXDJ9NUP+SsskOckbf3nkcm2yL6sFebzKh63ioocWdjJrk9eT8pZK1JD76ds81Ptx9beoywwv4msODGbblrbCRGt8KA7DO3t4vMSU/Kg+k8Z+msTUyAFhIVv9G4BS2WujM7BSpK2Ravmmj2E7GTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMFMd8wMyUm02AdJT82b26aGPLvtgO1k3opeHrQU/b4=;
 b=Xus47GwSL/HErPKbIY2Dpo05LjmMWEf1mM3VxrqAZ1WybQ0317geqZMRke3P4ghoMVtg5CmQO56aKZuT2OiVYZehdP6Blc9rhW4d/ZPOGYfOEL5KuYiRUprRdFPr6wItPe39gYmtK+Zia3zk8sgNUQ6dNVbMEmQBsGcZ/HzIlY529vN6DHXTxmlLWn9OGlbRyo9Sjg6SK8BNLDyqEV3pY+AR4RWoLrwtreMZAvmT+hbHB1YwhdbFt3J2k3S+ALGL5nvVus7+isLCd6WOW5L5i/JgRNqzDdJY+ep6JQdZxMYndwheANy/eTbW5jakzZ4M1djgEj0W5dqrVrsAJ+t6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMFMd8wMyUm02AdJT82b26aGPLvtgO1k3opeHrQU/b4=;
 b=DZkyOg92Xc11rNXN0pRwDpJET1p3AYlqpv79ss9y9mF+XT5wGdH/oYmnhccUGd0/8gH7EwNL9eXmcUqLMlgL+zZq+4DKc8uGX9VUm3F5Ti6J4P4qyb8sbxDl3NDHR7uAd01PofewuRNhyeJLnRc4bf/RY5HWSRCpHbbFDeVfCGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:51:41 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:41 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 4/6] transport: Update transport properties for a broadcast stream
Date:   Mon, 21 Aug 2023 18:51:02 +0300
Message-Id: <20230821155104.86954-5-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f25d55d-46fa-4807-938c-08dba25e82ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXBN8V77JU7kEZvjKn/OCC/OpHxVq54h/KCYKS2qcSaZi51S07as3xaRz9g2m/+8lOjHC5vFL3B0LZFh+tHeLCT8a4z7CAh5YM/oST9x0sq3EJ/xHS7E48ek7y+qnjKFkZz1CFuOO25GZ7LIdvi265RNhaeMYNXE0nE+wlfIhmKJ0MDsYD9SqjDTSE7mUU9IlYQXvwaqUYIqbJ6unHs0ggdzyQztdV1bZ9OYYskOSxmuYswoA6pQpCrWJMWUg2GJYAU7Um2NsyxG2EUirkwyP6zjsVIZLXP3xW6+MxV1HSW4fBtILEUIPfo14b74AMpy9ZoJqmm6sj86mSTTUcgOvfhS/6DtVCCdvy6X1bw2FNGErmUtsgq/KHaa8HK6TcAIbNI+8Ue9UN7Sklgeq09rKHL386dyXnmVXWpF8H9ZX3R9eOsgXdxKwwP/xni+RIvFZPOtH2akbKvn+NbaZeZvmzbaCkm0G8o/lhhTqK+gexhV7mayEbWQD3sW96FfnPnI4laVjZB7y3LcvdfBEyKrywgk/0PybZNyJ2vwzfTbUOJhRDaG8S/PbryHWa4Iy2so2cryw4lpzp0F5z2hXM3y18wI+4Vil403TmktTnftgRytdBybwJMqpQizjnDkYz7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpRVr3biroxiytUn+Y+rwAJJSPty+kt0DJ0wVsq/4IVuYpagYbhs8ndUB5RB?=
 =?us-ascii?Q?nGulAOAtvEQVQf0dtdM+nHV4ozuAYF9uoks25VbJBIF/a3XDuzVMHrpFDleY?=
 =?us-ascii?Q?QaO3+63xsaitooP74+hPmkso6f4T0L1H0A3gWs4kdlRy3WeyL4qyRJpsKfg9?=
 =?us-ascii?Q?3NiOAEdd4FQYXPeU/LRpg6SDLnZp1kdTd6FvAfAG4Vw/ecsPnxbFS2eyoK/j?=
 =?us-ascii?Q?ciB6mgoJzhu1sQ8qC9y+OrjYBMzjY8CAxc59Rn4cuqC3ITX5xK/JrZv6LMeD?=
 =?us-ascii?Q?l+/EPTz+0HSMBcs9BK/kXzgcIeNjyPjVeuAidLQEg+St42Q7vlcyUpNjIi1O?=
 =?us-ascii?Q?tzcw0WcY7vsCVfKUMe7iOz6Sww0T5UdK1NYOnQmOHrzfwcjQXiF146b7H7YH?=
 =?us-ascii?Q?iir2IEKQo1ZzCm34GxO4drYyIOTnlWkk6uqY8SWrT/i8L9r4w54QOzCltBx0?=
 =?us-ascii?Q?UgXwIJj9bwkhMOn7Ljwn2mWRXfewKjzm1uEWSePpMoty3DbGy0URnDj9UxSA?=
 =?us-ascii?Q?q+0p6gZAB0bgzkCyxW+xI2ndSXZnCIALk4vkMd8t9NXCg5mYRmxyAFJu5Jow?=
 =?us-ascii?Q?RtnQEruBViCNrCmSX/5CAwEBEkGWp4nKbTRsMwhAEjcGKAZfzUjWJ4z9qyOc?=
 =?us-ascii?Q?OpS0RJWLvRvY6cg8R3xg8aoFZ+ApKYpX1N0/wmcEi6pdnijxOeLC0ZepL/pB?=
 =?us-ascii?Q?HTwzH33JAjXoqAWrQ5vPK4GCM5B28AafXPejbpbLqUaBYf2OWI8/v37loEnb?=
 =?us-ascii?Q?SU1Bsc0mqq+44KllJTn92TegC41WcHPpQBdI2+INqoenJr1bbvcSuzsuUVJx?=
 =?us-ascii?Q?j0gFYsh5mgywCruKJ4IcGqRiDIA7++FeU1bFpSkutRY6jkbfk4bdW6cFOtZQ?=
 =?us-ascii?Q?xqZG8ZK0g9k53HM6bX+6CWtTmB2PCEpYTh/Gl6y3a0Qhj2Jhd7hzyW/ph+Pl?=
 =?us-ascii?Q?0bplR3s19rfjsAb5IkyyId8EXisQGbiY0J8DIs7tdNRGLF0ScnT/REKU56fA?=
 =?us-ascii?Q?MEFz6mD7CnEs++gYoKniyZL3MlgHHqAZZfUAN+QhfRS8j6o3FSc9zX2hhSZ0?=
 =?us-ascii?Q?skLw664zzu8A+ghwadVd5cO5lIiMumehEjP4gLRcZeqA5gB2Fk4tIdJXleLb?=
 =?us-ascii?Q?HT01DCG09i8wLnR1neQnXr2EP4jP7tb+xViU335XTB1zYnAVMO+gzlGSAdOV?=
 =?us-ascii?Q?tlDLjldHSTNri+MpFssyez8i2UpGidLWB++IwZQxKkXbGrfepnhtY1zp8UGI?=
 =?us-ascii?Q?DkWybHHn5Qjplr3loMxydRyU9U0sVYmjyhJzxuPAIz4su955amz3onKAgiSU?=
 =?us-ascii?Q?IQeQnOFpxZz2Rj21/clwbWvfjycVUxA/9Xl6u+R6eGXaj6lpCasR3SC8Xfgd?=
 =?us-ascii?Q?EuIL8DHwb9SfIH277z8Ehxhy9G7OVq7u9+EES1FqJgwzOBX+VDz1vxWbff4t?=
 =?us-ascii?Q?QzmrmT40uP2WBgHV1fBaKfmhs1kCqYDVy9mlGnjfq6oaGWEaQ5xyqEgRYvPI?=
 =?us-ascii?Q?aK8KHuvNuTTZWO249Hxq2fW3Ook2xs8Ir72iNyn71w4cnUZQ3O/1pUZ7GKxG?=
 =?us-ascii?Q?uW72OhMALF1fYTrDHBrRifqImDIWYN6KLpA9/wxD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f25d55d-46fa-4807-938c-08dba25e82ff
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:41.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igQzmmNOT0k/m2TFSJxDXZ4BBGXldxUid0jJ9MBIev1aSVMoo5Prewxqbq4wWwuG1CMAuG2/Qd1/Uur/f0M2FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.

---
 profiles/audio/transport.c | 251 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index cf5662d1d..f7a29ca83 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -552,6 +552,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(msg);
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)
+		|| !strcmp(media_endpoint_get_uuid(transport->endpoint),
 						BCAA_SERVICE_UUID)) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
@@ -853,6 +855,9 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		return bap->qos.bcast.io_qos.sdu != 0x00;
+
 	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
@@ -868,6 +873,18 @@ static gboolean get_cig(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_big(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.big);
+
+	return TRUE;
+}
+
 static gboolean get_cis(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -880,6 +897,18 @@ static gboolean get_cis(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_bis(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.bis);
+
+	return TRUE;
+}
+
 static gboolean get_interval(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -899,6 +928,9 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 	dbus_bool_t val = bap->qos.ucast.framing;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		val = bap->qos.bcast.framing;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
@@ -910,6 +942,12 @@ static gboolean get_phy(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.io_qos.phy);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
 					&bap->qos.ucast.io_qos.phy);
 
@@ -922,6 +960,12 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.io_qos.sdu);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 					&bap->qos.ucast.io_qos.sdu);
 
@@ -1040,6 +1084,121 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_sync_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.sync_interval);
+
+	return TRUE;
+}
+
+static gboolean get_packing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.packing);
+
+	return TRUE;
+}
+
+static gboolean get_bcode(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (bap->qos.bcast.bcode && bap->qos.bcast.bcode->iov_len)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&bap->qos.bcast.bcode->iov_base,
+						bap->qos.bcast.bcode->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+	return TRUE;
+}
+
+static gboolean get_options(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.options);
+
+	return TRUE;
+}
+
+static gboolean get_skip(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.skip);
+
+	return TRUE;
+}
+
+static gboolean get_sync_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.sync_timeout);
+
+	return TRUE;
+}
+
+static gboolean get_sync_cte_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.sync_cte_type);
+
+	return TRUE;
+}
+
+static gboolean get_mse(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.mse);
+
+	return TRUE;
+}
+
+static gboolean get_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.timeout);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable bap_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
@@ -1059,6 +1218,17 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "BIG", "y", get_big, NULL, qos_exists },
+	{ "BIS", "y", get_bis, NULL, qos_exists },
+	{ "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
+	{ "Packing", "y", get_packing, NULL, qos_exists },
+	{ "BCode", "ay", get_bcode, NULL, qos_exists },
+	{ "Options", "y", get_options, NULL, qos_exists },
+	{ "Skip", "q", get_skip, NULL, qos_exists },
+	{ "SyncTimeout", "q", get_sync_timeout, NULL, qos_exists },
+	{ "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
+	{ "MSE", "y", get_mse, NULL, qos_exists },
+	{ "Timeout", "q", get_timeout, NULL, qos_exists },
 	{ }
 };
 
@@ -1341,6 +1511,77 @@ static gboolean bap_resume_wait_cb(void *data)
 	return FALSE;
 }
 
+static void bap_update_bcast_qos(const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos(bap->stream);
+
+	if (!memcmp(qos, &bap->qos, sizeof(struct bt_bap_qos)))
+		return;
+
+	bap->qos = *qos;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIG");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIS");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncInterval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Packing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Framing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BCode");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Options");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Skip");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncTimeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncCteType");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"MSE");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Timeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Interval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Latency");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"PHY");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SDU");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"RTN");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Codec");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Configuration");
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1493,7 +1734,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		if (owner && owner->pending)
 			return;
 		bap_update_links(transport);
-		bap_update_qos(transport);
+		if (!media_endpoint_is_broadcast(transport->endpoint))
+			bap_update_qos(transport);
+		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
@@ -1503,6 +1747,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		break;
 	}
 
@@ -1631,7 +1877,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
 				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				!strcasecmp(uuid, BCAA_SERVICE_UUID)) {
+				!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

