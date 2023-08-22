Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E1EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjHVOcs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjHVOco (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327ECC6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+6WgmKx1pY0YchR+GBdFh31yH6illta80vS7dGkrWfSwkGzz/m7VghgZt9Nxyxas2sGaJulTwV7aM1WIGysWlgEWU5PkEwTVodEY9rhN85I/2LsuSiu48wkXI10y6Xb5hLxoDbRMyo/TjsHHbR/d4OY4NU88C2Lt1YjYCQevlXQtkpUJACJ+I0dsYDYYvt8KFh1IZLZ2S+u1LqIhX2i2jaUmlNbF41jNv1z++SZabOoTfi8sFABmIHry4aa3+zKWirMb6znIDeaPjBbpskbc7PXiezb2yS5HktNliVxA8gJfc22xob8rxBLOChTVox/xC36HDKd98/W0C4/Tme79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3N0iY0CzexGRDd4WnLCWFDA11dUahXP1xTYin545Iw=;
 b=GNP++nku5G11ZxyKGHG8OMIhRiIyxe/9eEJyQ6PQr1pZT7uwI2XYb3PmEguBCGo3p+GPDtq9TsXq3X1iq5fy/pQ3coHpmL7vfyB2LUGt5rzek0o332x/qCNRxIhSLxD1k3kjC4JeOOBxgZyBa5f/lapNBDDD0qzEy1HanQXXP5oOmNDttrC/wcjRNPzyQZZDsOoHjtlDiHrUhLnveZOJ2zegmDfjR5R5ksp2CBGUk6wDUD6CHcfH5OVVmco9mHsntJ1oicTNtKKiSKDwFHDvex4OieQC5g3yGHANh9La+ThNyJbWR4if2K60PvNXXylGye2hsPQ1L6t5e0OUTnjHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3N0iY0CzexGRDd4WnLCWFDA11dUahXP1xTYin545Iw=;
 b=KVPvXx4MSPcyKdtgGJonLyXW91EPrWu+HqbUdlrOz12cUJqyAss0FR8S8N0D5onVJ7eI0mQBr1/1Hi5hwjvdu6imX1Pspf65r8RW0wLzKEKBC0nO848qBpu11782kTXcm4E+OiZBZpu8Bppsw7PUCrVVJk9X3vF7EIqsE3vyd3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:53 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:53 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 2/6] bap: Add support for BAP broadcast sink
Date:   Tue, 22 Aug 2023 17:29:31 +0300
Message-Id: <20230822142935.6016-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e02f35f-7de4-4fae-85ac-08dba31c8742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaH1d93YrwOJ/yq3caGPVhu9Gdcr1RzBaRpTDnlYwiPDYHlt3dG+dvuW/QYNA+9/mZEKzQc8aFXU770EmFcPtSoIFsP38GNRaLvqXkC9cwbGWnrQCoEnrlIt5mVb6DOwCXBE7iNtjrwrLWuzFTbxMUwdb2np4s6YUltOI7x/u/go/IXYNPUYhm+Ya6bvyEgshXW8/lNNZOsbrpnRiHbGN71In+uTo1dxTnHTKk2btlhQZnLUsokmgqRveFysqiqe22d9xNVy2oe/RXRy2gQVaBTu5fdR+UxKR7eURKcquMmEU6QZISYia8DVKtBKfL9US0q8sUbMKN64UJxyEmR/QJHHR2+sGPCWsZK8viRrW1acD2IEm0UHhVPPLsN8O0EAbAbzKdB5ba93RinrUifTGQVFgacNtl0+FrL/z2lY9WXE4MMd0wpQ1PKEq/AUdMkDwTFtZwEL1f0a8D3QKVm09hZjzu050m4+WbesdFhaJCCQerdIyWa+5oKh7Qnv9PP2Y5sNQjaC9MUmarDGC9Jc37xvURuRRzkQlCw2ejh6XiftZ/suYsgBna7cI/J4n95Mb8M94qjH2ySovDajMkG8N61d/cCF6kmzf8K+pcZDzIRhz2wiGmHdpjlcsdJXAIyJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(30864003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzS2VTJ8oVkMCV9mxFeavjwidKNe7fQaRRMe2eWIJ/Ch7WbVgZgU8xBKaU6o?=
 =?us-ascii?Q?nj+b8AFNuB01rZTGe0qTXS1WEVVLOVZaPCLJfpBgh6If8fyLbuTY8ClGnwzf?=
 =?us-ascii?Q?4qnwU5zwXVbXf+axRH4lgFFp/fZ2X7YfQV5EjjcZ2Fy69n7zRjMlXweKYI/H?=
 =?us-ascii?Q?53wyyR//tlblTjrdw3sApOSFz8K8CkEPPEsM3QZLWbqetkJNCUJb6zYTHYum?=
 =?us-ascii?Q?P+QuoGOuFVK42wXLKhTjm7orhU3M6OcdXcNq5PAr4dpWDjVqAppoyGNh1x0U?=
 =?us-ascii?Q?MnoBFKE6r6djkjiaI5w/l5f6qd6toGNkBkkGDvAEbVYxZ2p9jd2XeXly1nvh?=
 =?us-ascii?Q?GD/xksWGKpdk7hgpHVT/+65/c+RjQQL8JxGxbfhD+HKe1stp4nsMwItmkZBd?=
 =?us-ascii?Q?cUlIXdPm1nxoY7g9amx5lPGikPpn5j40BZ0O81Ondr3FbSOx+MdNt2OSayOz?=
 =?us-ascii?Q?ttA8dHszQwR1za3Z9PW236istzLp/jITo6hFaLSz6wYUYjUgO3kUYWpm/ehc?=
 =?us-ascii?Q?uTKw25DpRiISviqBzhEVmiF3Z/eHm5z6VBD3ZrmoqJtyVq5QSGSMOIBnnFKb?=
 =?us-ascii?Q?ARrYDHwRJ42x2nT0I3aK3w/Er96/JCNkT53daPmncQXXknJeLfvDQrS1rvPo?=
 =?us-ascii?Q?8QT4Sr6z41c3crs7sXfj6QqGPZNzZDoMv9kvxNQohbp5/sN62VMjGVbzSIVR?=
 =?us-ascii?Q?4CGfJQqLcvqw8tRtyJeRupVD1KqMcYW/0t8+eMVwKzdtQp7bpommqy9XbTgW?=
 =?us-ascii?Q?bTWjOqZRZtGF54HefYPbS5ExgmOeBoZI2mT1WRmcQHyt77bgd/zBfQNdwy41?=
 =?us-ascii?Q?fpZR6W8oMa49H2b4DJH9RGGu+UBoUOB4TzF+o7xwAP9nfIVrOh6vyxh6ulIs?=
 =?us-ascii?Q?uHrBcsK4lFYuH/KojoF8yBRa8cTg0jisEGrEXbC4DyQHZ3OMvz1eXBvoNp5H?=
 =?us-ascii?Q?twd9XiLsw7G0WQqaChAaHlVWpdG75PYsDMMZwhXD8OyzGuji4ZPkDhDWaYR/?=
 =?us-ascii?Q?Wo/AEv3hi9vjST6pS6F/w+vkdE5OZa6bxfSkuU8ooZ0bANmhwj2EPM9h2Uxr?=
 =?us-ascii?Q?A1cEWhVeT3yVRJMvwPr5oIWLP3B8lJStkLmxQRbJZsqMEwh2B1tgT91blwg3?=
 =?us-ascii?Q?sig1RBBFV6gek4ikYL3pnwadsxvT+GxoLGqvREFjZ6eFNyWIcxGB3Y0WSKFF?=
 =?us-ascii?Q?fyHsX/cR2CAzcNfalopxc7GLU8BrNGGwfBul74Q3hUa7PGIAb3r5JnJTXqcG?=
 =?us-ascii?Q?W8IaqTArGfnJPZ2kU4E4Ngdr/Lai2nOgFyB2rCyX8HxtD9ogD7mduefTWw/8?=
 =?us-ascii?Q?8Tz0CepQdzw9d521wTxoNYcWWAWvF7TMdtcekCxm0a4pX37AMCpRMT95LluF?=
 =?us-ascii?Q?pnv24hCbEs5iGBJp9ob2+79yU8dV+RuIGqb4/u5FfC2x+a2RwQhZ6am/Roi9?=
 =?us-ascii?Q?4xkSG//P0cISPA4cJHE0xlqS/Dp4ZpxeINTCrztcKnihLi5vQUcwQMVrooar?=
 =?us-ascii?Q?Xika5OJiMDdwzWOjpc0kKuGqTFvL++HpvuCCcO1f9bJLwas6WgvKVmh4fUyq?=
 =?us-ascii?Q?fjiscvULxZZZEi8w+Eco4HJAwFKy7zIy8/jXQwe+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e02f35f-7de4-4fae-85ac-08dba31c8742
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:52.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0pEVYsxcebCuLiM5R2GDUHYha/BZXyQ3+KYbLILhJtL9WXLDB16SlXZt7xTEs5bD00WEa+jSbY/7HQAQzdeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for BAP broadcast sink, creates a remote endpoint when a
broadcast source is discovered and synchronizes with the source upon
endpoint configuration.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

---
 profiles/audio/bap.c | 432 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 402 insertions(+), 30 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 922eac50d..dfc71edf6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -34,6 +34,7 @@
 #include "lib/hci.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/btd.h"
 #include "src/dbus-common.h"
@@ -57,7 +58,9 @@
 
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
+#define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+#define MEDIA_INTERFACE "org.bluez.Media1"
 
 struct bap_ep {
 	char *path;
@@ -74,6 +77,7 @@ struct bap_ep {
 	struct bt_bap_qos qos;
 	unsigned int id;
 	DBusMessage *msg;
+	struct iovec *base;
 };
 
 struct bap_data {
@@ -186,6 +190,9 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 		uuid = PAC_SINK_UUID;
 	else if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else if ((queue_find(ep->data->bcast, NULL, ep)
+		&& (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)))
+		uuid = BCAA_SERVICE_UUID;
 	else
 		uuid = BAA_SERVICE_UUID;
 
@@ -207,6 +214,19 @@ static gboolean get_codec(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean has_capabilities(const GDBusPropertyTable *property, void *data)
+{
+	struct bap_ep *ep = data;
+	struct iovec *d = NULL;
+
+	bt_bap_pac_get_codec(ep->rpac, NULL, &d, NULL);
+
+	if (d)
+		return TRUE;
+
+	return FALSE;
+}
+
 static gboolean get_capabilities(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -248,7 +268,7 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Codec", "y", get_codec, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
+	{ "Capabilities", "ay", get_capabilities, NULL, has_capabilities,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -271,8 +291,106 @@ static int parse_array(DBusMessageIter *iter, struct iovec **iov)
 	return 0;
 }
 
+static bool parse_base(void *data, size_t len, util_debug_func_t func,
+		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
+		struct bt_bap_codec *codec, struct iovec **caps,
+		struct iovec **meta)
+{
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+
+	uint8_t capsLen, metaLen;
+	uint8_t *hexstream;
+
+	if (presDelay) {
+		if (!util_iov_pull_le24(&iov, presDelay))
+			return false;
+		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
+	}
+
+	if (numSubgroups) {
+		if (!util_iov_pull_u8(&iov, numSubgroups))
+			return false;
+		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
+	}
+
+	if (numBis) {
+		if (!util_iov_pull_u8(&iov, numBis))
+			return false;
+		util_debug(func, NULL, "NumBis %d", *numBis);
+	}
+
+	if (codec) {
+		codec = util_iov_pull_mem(&iov, sizeof(*codec));
+		if (!codec)
+			return false;
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+				"Codec", codec->id, codec->cid, codec->vid);
+	}
+
+	if (!util_iov_pull_u8(&iov, &capsLen))
+		return false;
+	util_debug(func, NULL, "CC Len %d", capsLen);
+
+	if (!capsLen)
+		return false;
+	if (caps) {
+		if (!(*caps))
+			*caps = new0(struct iovec, 1);
+		(*caps)->iov_len = capsLen;
+		(*caps)->iov_base = iov.iov_base;
+	}
+
+	for (int i = 0; capsLen > 1; i++) {
+		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
+		uint8_t *caps;
+
+		if (!ltv) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+			return false;
+		}
+
+		util_debug(func, NULL, "%s #%u: len %u type %u",
+					"CC", i, ltv->len, ltv->type);
+
+		caps = util_iov_pull_mem(&iov, ltv->len - 1);
+		if (!caps) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"CC");
+			return false;
+		}
+		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+		capsLen -= (ltv->len + 1);
+	}
+
+	if (!util_iov_pull_u8(&iov, &metaLen))
+		return false;
+	util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+	if (!metaLen)
+		return false;
+	if (meta) {
+		if (!(*meta))
+			*meta = new0(struct iovec, 1);
+		(*meta)->iov_len = metaLen;
+		(*meta)->iov_base = iov.iov_base;
+	}
+
+	hexstream = util_iov_pull_mem(&iov, metaLen);
+	if (!hexstream)
+		return false;
+	util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+	return true;
+}
+
 static int parse_properties(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct bt_bap_qos *qos)
+				struct iovec **metadata, struct iovec **base,
+				struct bt_bap_qos *qos)
 {
 	const char *key;
 	struct bt_bap_io_qos io_qos;
@@ -438,9 +556,21 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 	}
 
 	if (broadcast) {
+		uint32_t presDelay;
+		uint8_t numSubgroups, numBis;
+		struct bt_bap_codec codec;
+
 		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
 		qos->bcast.framing = framing;
 
+		if (!base)
+			return 0;
+		if (!(*base))
+			*base = new0(struct iovec, 1);
+		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
+		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
+			&presDelay, &numSubgroups, &numBis, &codec,
+			caps, NULL);
 	} else {
 		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
 		qos->ucast.framing = framing;
@@ -556,7 +686,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark CIG and CIS to be auto assigned */
+		/* Mark BIG and BIS to be auto assigned */
 		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
@@ -565,7 +695,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
+	if (parse_properties(&props, &ep->caps, &ep->metadata,
+				&ep->base, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
 		return btd_error_invalid_args(msg);
 	}
@@ -597,13 +728,126 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
-		ep->id = 0;
+		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
+			ep->msg = dbus_message_ref(msg);
+		else
+			ep->id = 0;
+
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
 	return NULL;
 }
 
+static void update_bcast_qos(struct bt_iso_qos *qos,
+			struct bt_bap_qos *bap_qos)
+{
+	bap_qos->bcast.big = qos->bcast.big;
+	bap_qos->bcast.bis = qos->bcast.bis;
+	bap_qos->bcast.sync_interval = qos->bcast.sync_interval;
+	bap_qos->bcast.packing = qos->bcast.packing;
+	bap_qos->bcast.framing = qos->bcast.framing;
+	bap_qos->bcast.encryption = qos->bcast.encryption;
+	bap_qos->bcast.options = qos->bcast.options;
+	bap_qos->bcast.skip = qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type = qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = qos->bcast.mse;
+	bap_qos->bcast.timeout = qos->bcast.timeout;
+	bap_qos->bcast.io_qos.interval = qos->bcast.in.interval;
+	bap_qos->bcast.io_qos.latency = qos->bcast.in.latency;
+	bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
+	bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
+
+	bap_qos->bcast.bcode = new0(struct iovec, 1);
+	util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
+		sizeof(qos->bcast.bcode));
+}
+
+static bool match_ep_type(const void *data, const void *user_data)
+{
+	const struct bap_ep *ep = data;
+
+	return (bt_bap_pac_get_type(ep->lpac) == PTR_TO_INT(user_data));
+}
+
+static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
+	struct bt_iso_base base;
+	char address[18];
+	struct bap_ep *ep;
+	int fd;
+	struct iovec *base_io;
+	uint32_t presDelay;
+	uint8_t numSubgroups;
+	uint8_t numBis;
+	struct bt_bap_codec codec;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	g_io_channel_ref(io);
+	btd_service_connecting_complete(data->service, 0);
+	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
+					address, qos.bcast.big, qos.bcast.bis);
+
+	ep = queue_find(data->bcast, match_ep_type,
+			INT_TO_PTR(BT_BAP_BCAST_SINK));
+	if (!ep)
+		return;
+
+	update_bcast_qos(&qos, &ep->qos);
+
+	base_io = new0(struct iovec, 1);
+	util_iov_memcpy(base_io, base.base, base.base_len);
+
+	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
+			&presDelay, &numSubgroups, &numBis,
+			&codec, &ep->caps, &ep->metadata);
+
+	/* Update pac with BASE information */
+	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
+	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
+					ep->caps, NULL, NULL);
+	data->listen_io = io;
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	if (bt_bap_stream_set_io(ep->stream, fd)) {
+		bt_bap_stream_enable(ep->stream, true, NULL, NULL, NULL);
+		g_io_channel_set_close_on_unref(io, FALSE);
+		return;
+	}
+
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+
+}
+
+static bool match_data_bap_data(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return bdata->user_data == adapter;
+}
+
 static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
 					GDBUS_ARGS({ "endpoint", "o" },
@@ -649,15 +893,17 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
 {
-	struct btd_adapter *adapter = data->user_data;
+	struct btd_adapter *adapter = data->adapter;
+	struct btd_device *device = data->device;
 	struct bap_ep *ep;
 	struct queue *queue;
-	int i, err;
+	int i, err = 0;
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
 		i = queue_length(data->bcast);
 		suffix = "bcast";
@@ -675,8 +921,20 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	ep->lpac = lpac;
 	ep->rpac = rpac;
 
-	err = asprintf(&ep->path, "%s/pac_%s%d", adapter_get_path(adapter),
-		       suffix, i);
+	if (device)
+		ep->data->device = device;
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_BCAST_SINK:
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+			adapter_get_path(adapter), suffix, i);
+		break;
+	case BT_BAP_BCAST_SOURCE:
+		err = asprintf(&ep->path, "%s/pac_%s%d",
+				device_get_path(device), suffix, i);
+		break;
+	}
+
 	if (err < 0) {
 		error("Could not allocate path for remote pac %s/pac%d",
 				adapter_get_path(adapter), i);
@@ -685,14 +943,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	}
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
-				ep->path, MEDIA_ENDPOINT_INTERFACE,
-				ep_methods, NULL, ep_properties,
-				ep, ep_free) == FALSE) {
+			ep->path, MEDIA_ENDPOINT_INTERFACE,
+			ep_methods, NULL, ep_properties,
+			ep, ep_free) == FALSE) {
 		error("Could not register remote ep %s", ep->path);
 		ep_free(ep);
 		return NULL;
 	}
-
 	bt_bap_pac_set_user_data(rpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
@@ -824,6 +1081,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1244,10 +1502,10 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		g_source_remove(ep->io_id);
 		ep->io_id = 0;
 	}
-	base.base_len = ep->caps->iov_len;
+	base.base_len = ep->base->iov_len;
 
 	memset(base.base, 0, 248);
-	memcpy(base.base, ep->caps->iov_base, base.base_len);
+	memcpy(base.base, ep->base->iov_base, ep->base->iov_len);
 	DBG("ep %p stream %p ", ep, stream);
 	ba2str(btd_adapter_get_address(adapter), addr);
 
@@ -1310,6 +1568,45 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
+static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
+			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
+	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
+			sizeof(bdaddr_t));
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
+
+	DBG("stream %p", stream);
+
+	/* If IO already set skip creating it again */
+	if (bt_bap_stream_get_io(stream) || data->listen_io)
+		return;
+
+	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(ep->data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &qos->bcast,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	ep->data->listen_io = io;
+
+}
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1364,10 +1661,10 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 done:
-	if (ep)
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
 		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
 	else
-		bap_listen_io(data, stream, &iso_qos);
+		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
 }
 
 static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
@@ -1417,6 +1714,11 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
+			if
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
+				bap_create_bcast_io(data, ep, stream, true);
+				return;
+			}
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
@@ -1424,7 +1726,6 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				return;
 			}
 
-
 			if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
 				/* Wait QoS response to respond */
@@ -1475,12 +1776,12 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE) {
-		DBG("pac %p", pac);
-
+	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
 		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
 						pac_found_bcast, data);
-	}
+	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
+						pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
@@ -1596,14 +1897,6 @@ static bool match_data(const void *data, const void *match_data)
 	return bdata->bap == bap;
 }
 
-static bool match_data_bap_data(const void *data, const void *match_data)
-{
-	const struct bap_data *bdata = data;
-	const struct btd_adapter *adapter = match_data;
-
-	return bdata->user_data == adapter;
-}
-
 static bool io_get_qos(GIOChannel *io, struct bt_iso_qos *qos)
 {
 	GError *err = NULL;
@@ -1733,6 +2026,71 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
+static int bap_bcast_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	/* Ignore, if we were probed for this device already */
+	if (data) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	data = bap_data_new(device);
+	data->service = service;
+	data->adapter = adapter;
+	data->device = device;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+			btd_gatt_database_get_db(database));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
+								NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
+				 pac_removed_broadcast, data, NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+
+	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	return 0;
+}
+
+static void bap_bcast_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("BAP service not handled by profile");
+		return;
+	}
+}
+
 static int bap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -1901,6 +2259,16 @@ static struct btd_profile bap_profile = {
 	.experimental	= true,
 };
 
+static struct btd_profile bap_bcast_profile = {
+	.name		= "bcaa",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= BCAAS_UUID_STR,
+	.device_probe	= bap_bcast_probe,
+	.device_remove	= bap_bcast_remove,
+	.auto_connect	= false,
+	.experimental	= true,
+};
+
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
@@ -1911,6 +2279,10 @@ static int bap_init(void)
 	if (err)
 		return err;
 
+	err = btd_profile_register(&bap_bcast_profile);
+	if (err)
+		return err;
+
 	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
-- 
2.34.1

