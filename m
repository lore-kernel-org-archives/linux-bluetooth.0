Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1ADC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjFGIXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjFGIX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:23:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF352189
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBOmp5VcxdmWXmV508CPjwx8zXmO+phmVMMQMwbyQssih2a+Px5rku3bIk/EdDeUYh0wrQnzN51vt7/DT5pQBz8vee1Px91U1cONram1+GtgYCKL2JV3lw1Zly5DfAtifJ4kCj8dHOjOTfG01E2XSIik0Z30plB46UwqN9GFMQnGWPsRkTWRXWSKcF5ZyncB8MW5xt73g613mMr5MxHRbzqk63C8TYcJcOlwMApjeiARaEapIIQOmHxXIJSTo0Mt0Zmd0PrhUCsk84qJT6R2p1nQWyD2iolul3IZP0aFRY4QBpYAXE/lZ8/XvGbo8nXf74EMOcTdxQT8e4Q/Ze1shQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIe1cRrw9cgVyKLalOR5UZUitV/XQqnreTvaegGXfdA=;
 b=RGOvl0RIMqKft0guH+Zb9s6GskUU5wB+BZ5E/RatYRFnTC5B+SMCfQPjOuJkhtHO3D4OFaofPUp1rRPNKpwwnzLpfcPhGvFScoXynFSPNZEHk2nNNF1/oF9FRMxwJz2a458CwvyGC0FUo8LDsD5q3sDbqpkghNbwFovH2jZdYOVw5K5dxJWWDVcIxEvDlB/gxiqAsM5UlBAcHspGHXbCGqI8yjTG2i0e0DvsMIPL/Mnu+ujkSstugh/L8j+QZp4C+dCbGFYd1k/zJ5ueXgHC6SaPf4/8dZNCn85pQCE0/DfIlJkug42vMFBsTaVP6lRTuBsJoQmrHquYuDhNoYPZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIe1cRrw9cgVyKLalOR5UZUitV/XQqnreTvaegGXfdA=;
 b=lUckazT812ox7gG+xXD8DUBdX4aEn/r+AJbQmUIdNwMrkR8pxWA5gBE3MBK/76kgg9bv+srV2PuKkPJUguRMyNej4u1FgGPWZOrwB449k8FCsSMPyIEkf6R+zDBhw6aA2y2YUrYiVevk1kZNDQOv5C7AYI7g5FlK2Yz/Eq+JvV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:23:21 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:23:21 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v4 4/4] Update BAP plugin with broadcast source support
Date:   Wed,  7 Jun 2023 11:23:00 +0300
Message-Id: <20230607082300.4970-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
References: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3612d1-f78b-43d6-956d-08db67307444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmxLEL8JOodausofhP6dZUpvpoY1/IGA5HoxPiBV92FYr3fxs1J7dAe8zetTq7VkATEbm3tAIM7kTYsAQ6UckfUxn0qepH4vFlRYvDZHsIDlt/sln55K0cDRslK9GkIlmQUJbMVbYXN8y6oft5ZTpi7fNh905WgYNPwuw9HN/rTXfTMot/bnjvdqLBaBnHWPduydeWuQ2tS1eHYi1nNU0JYqw8K78aiyZjDM2r4WBbsYEAWYq0/VXm8k/hbui37Gar2ulvundAcSLGr2ufsy4Vw6+MSUCfmHdSkdZMpZYdWmqmD4EXp0zE7VX0uS54ZCmsoRrydRhsHPJ1PGMRvOn4L0e5fImTUkm3sDRWA2bmxNRrbikvkTEyNId041CiF2Vh9ggsqi9Tyb1hwn7Gmv6Q2zmhui0iNvJ0ILgEuGGcKj99hqREcWsAKLOHYV0ZyQQhcyh4BXyhl5+b4FRt3qGEpN2PUoHfTmmiqi2Fyv5dx6Mj4rN3qol/4TH0YXTLBaZK8nkt1SFdDc8UiRWPGzdlgClLAvz8fqMcLy6qjgOMnPr21+z053D3BeOa1BY3SJv+Em5iqCSh4ZuziXCR//Oa1Xm81cDOOHnhyn6JoD8Mp3yApiVmkq43+yf6nE81Ka
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(55236004)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(30864003)(86362001)(15650500001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SyL2QEZW6VJuUtaPIgNu4uk59qUQpM7AzcC370WwLaSYnii+668nmcta4n2+?=
 =?us-ascii?Q?e3kSdKPPyRrNw3ZA1nn88t33iRmyBeK7vTGwWy0/NrCrn4EGWS/hC/XfgtPG?=
 =?us-ascii?Q?QNFXmk6bzzOMhgU+3mEqsYsaR/8IxfzWaawHF5uU+N4fo0UoWLBUnp2fCpOb?=
 =?us-ascii?Q?VABNcLpEkRsJ0FZNayDamkg7pVgB5ZT6KdJVZQY157ezBSr8cOxvuCSwVS05?=
 =?us-ascii?Q?yVMF51EbsHU8JYdU9Dx+GPuCqKMwhVg+YXEHmvsuu0LMvyzYgZNxLDx1skAZ?=
 =?us-ascii?Q?Ow525iw1OOF3c5OY0as1Lp3W5SpdgZJeDb5Eym9883R4nC0aVf+sv5oAiYhV?=
 =?us-ascii?Q?YQbteyE9hXTTLmTSRxn2mzA86cDKkE3rkZ3jHq7rtV6R1lzj62jDOJZOm+g/?=
 =?us-ascii?Q?azgUVzhUxWVN8UZZsdIdIQNbDza1L4CBRFqcIqfiBFgNVsxs6mmXyQ5d1F6p?=
 =?us-ascii?Q?mo2ntThcA/vsW4GTDXw7IdfLOhIp+wkCrVeltL3I0Q82K/q9eicKOmfRyo7l?=
 =?us-ascii?Q?f+VpQfSqTRl9bwpJ5f2cRGlFeZd6o9J8YCkpcWz8plm7n5FYiJZWcPJYRs2/?=
 =?us-ascii?Q?M6W1uJv6ui8UvkE0x3NvVAF1gqxExUnaW7rGlMlmmZPo/9JekkogzbbTRNG6?=
 =?us-ascii?Q?vBEIJW5nULh5cThz+PsZ5WZ9K89VasxpMLqMFHPlWb7za4zftgWotsLBP7AH?=
 =?us-ascii?Q?0/T74x73l0rzJc+sLD0K90cnIvEaH/wL+sn6+LYaKliGfn9VZmuR6g8rvy2G?=
 =?us-ascii?Q?yl9GtLU9cRnJg6S4U7iSjbH92P3QEc5WSE3hav4bckuNMafpNve899OjnoVn?=
 =?us-ascii?Q?7aNF55PbmtZYR3WZUKLpBV3dx43nBVPe9gN/LuOEZ1/lWa74CmjwFQXTmsj1?=
 =?us-ascii?Q?FdYqDjAB0xx7bIsw1yP/blq2TsaudsbviR0w5WigI3PPjZkuhvwznGI2GSuA?=
 =?us-ascii?Q?jeBeWc/1cONarGJixde7jPOGid+fkipnNIN0EJG/vxAr5HLS8NjGJUiQNDe2?=
 =?us-ascii?Q?pw4ZX7gIMawPPRt8qUNYH1SYCCN6NPEF6uq6pBXgniPECjfu2M0DZQdFcEHo?=
 =?us-ascii?Q?CCR/pPUjxcOGYB3otxsjWXzLGIwj9zWECai326LseLvBpA5mcz8d29NY9kLL?=
 =?us-ascii?Q?FaVATBs8VhhTxWnShYHyXCjq/RE2a1eDsQnPUKhoqrwl1C1HQrpvirP10vd8?=
 =?us-ascii?Q?IkeaEVFT43zDtFlG1XRbnM5Twt7EikYBclp/NjbQHdwD81Iqsxs75aLy6oEy?=
 =?us-ascii?Q?MkO0ELblzV9UT2peJHb6nhSLSWH3HS17NUBGoyecPbcBFyM5jRluidHQxf07?=
 =?us-ascii?Q?4MW/TM5lTYVU3Cmyf+j9zoQZGDk5hzYKEzqqGjjuN5th+YP/wpmsUMxsd0+R?=
 =?us-ascii?Q?ujasFB73appwXxL/q6h1G2qvLjwj+nyJV1XeVJ6EiLjYr1GeWNyqDFP2gALC?=
 =?us-ascii?Q?gC9zvFnu4aOQJAyA4PfBiRGyHTCZwNwjhpvdsNU9ivmwv+OgKImXVZN/g0wH?=
 =?us-ascii?Q?++zolCuKeUrIgFA4Bti3b2GjoU/uOhBiVym9rQ833mfPtY8EkRib7P6TA9WT?=
 =?us-ascii?Q?1WwAIsbx4lT+nkWbCnzVKV3r/iSuexme7j0feCK1t7AOH6VNDrzlrNoxz3MU?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3612d1-f78b-43d6-956d-08db67307444
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:23:21.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2L8ixaAeFvLs4PPq8xTZUbAdKilWB6nbaB0TvvfZ9jGVvEU26SVkK6sBCBzhcJXJCgdH1+HGTNQLTsvOPeLMESDkUwdJGZvEJ0yN3tYu/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates BAP plugin with broadcast source support.

---
 profiles/audio/bap.c       | 515 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     |  82 ++++--
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c |  59 +++--
 4 files changed, 581 insertions(+), 77 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cbaf705c0..cbe3c4b97 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -75,6 +75,7 @@ struct bap_ep {
 
 struct bap_data {
 	struct btd_device *device;
+	struct btd_adapter *adapter;
 	struct btd_service *service;
 	struct bt_bap *bap;
 	unsigned int ready_id;
@@ -82,13 +83,25 @@ struct bap_data {
 	unsigned int pac_id;
 	struct queue *srcs;
 	struct queue *snks;
+	struct queue *bcast;
 	struct queue *streams;
 	GIOChannel *listen_io;
 	int selecting;
+	void *user_data;
 };
 
 static struct queue *sessions;
 
+static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
+{
+	if (!data)
+		return false;
+
+	data->user_data = user_data;
+
+	return true;
+}
+
 static void bap_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -167,8 +180,10 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 
 	if (queue_find(ep->data->snks, NULL, ep))
 		uuid = PAC_SINK_UUID;
-	else
+	if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else
+		uuid = BAA_SERVICE_UUID;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
@@ -214,7 +229,10 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	struct bap_ep *ep = data;
 	const char *path;
 
-	path = device_get_path(ep->data->device);
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
+		path = adapter_get_path(ep->data->adapter);
+	else
+		path = device_get_path(ep->data->device);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -254,7 +272,10 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 {
 	const char *key;
 	struct bt_bap_io_qos io_qos;
+	uint8_t framing = 0;
+	bool broadcast = false;
 
+	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
 		int var;
@@ -284,11 +305,21 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.big);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
+		} else if (!strcasecmp(key, "BIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
@@ -302,7 +333,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			dbus_message_iter_get_basic(&value, &val);
 
-			qos->ucast.framing = val;
+			framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
@@ -342,13 +373,78 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-					&qos->ucast.target_latency);
+						&qos->ucast.target_latency);
+		} else if (!strcasecmp(key, "Encryption")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.encryption);
+			broadcast = true;
+		} else if (!strcasecmp(key, "Options")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.options);
+		} else if (!strcasecmp(key, "Skip")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.skip);
+		} else if (!strcasecmp(key, "SyncTimeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_timeout);
+		} else if (!strcasecmp(key, "SyncCteType")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_cte_type);
+
+		} else if (!strcasecmp(key, "SyncInterval")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_interval);
+		} else if (!strcasecmp(key, "MSE")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.mse);
+		} else if (!strcasecmp(key, "Timeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.timeout);
+		} else if (!strcasecmp(key, "BroadcastCode")) {
+			struct iovec *iov;
+
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+			iov = &qos->bcast.bcode;
+			parse_array(&value, &iov);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+	if (broadcast) {
+		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
+		qos->bcast.framing = framing;
+
+	} else {
+		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+		qos->ucast.framing = framing;
+	}
+
 	return 0;
 
 fail:
@@ -457,9 +553,15 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		bt_bap_stream_io_connecting(ep->stream, -1);
 	}
 
-	/* Mark CIG and CIS to be auto assigned */
-	ep->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
-	ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		/* Mark CIG and CIS to be auto assigned */
+		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+	} else {
+		/* Mark CIG and CIS to be auto assigned */
+		ep->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+	}
 
 	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
@@ -482,6 +584,10 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_stream_get_type(ep->stream) ==
+						BT_BAP_STREAM_TYPE_BROADCAST)
+		ep->id = 0; // No message sent over the air for broadcast
+
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 	ep->msg = dbus_message_ref(msg);
 
@@ -510,6 +616,8 @@ static void ep_free(void *data)
 
 	util_iov_free(ep->caps, 1);
 	util_iov_free(ep->metadata, 1);
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		util_iov_free(&ep->qos.bcast.bcode, 1);
 	free(ep->path);
 	free(ep);
 }
@@ -530,6 +638,63 @@ static bool match_ep(const void *data, const void *user_data)
 	return ep->rpac == match->rpac;
 }
 
+static struct bap_ep *ep_register_bcast(struct bap_data *data,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac)
+{
+	struct btd_adapter *adapter = data->user_data;
+	struct bap_ep *ep;
+	struct queue *queue;
+	int i, err;
+	const char *suffix;
+	struct match_ep match = { lpac, rpac };
+
+	switch (bt_bap_pac_get_type(rpac)) {
+	case BT_BAP_BCAST_SOURCE:
+		queue = data->bcast;
+		i = queue_length(data->bcast);
+		suffix = "bcast";
+		break;
+	default:
+		return NULL;
+	}
+
+	ep = queue_find(queue, match_ep, &match);
+	if (ep)
+		return ep;
+
+	ep = new0(struct bap_ep, 1);
+	ep->data = data;
+	ep->lpac = lpac;
+	ep->rpac = rpac;
+
+	err = asprintf(&ep->path, "%s/pac_%s%d", adapter_get_path(adapter),
+		       suffix, i);
+	if (err < 0) {
+		error("Could not allocate path for remote pac %s/pac%d",
+				adapter_get_path(adapter), i);
+		free(ep);
+		return NULL;
+	}
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				ep->path, MEDIA_ENDPOINT_INTERFACE,
+				ep_methods, NULL, ep_properties,
+				ep, ep_free) == FALSE) {
+		error("Could not register remote ep %s", ep->path);
+		ep_free(ep);
+		return NULL;
+	}
+
+	bt_bap_pac_set_user_data(rpac, ep->path);
+
+	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
+
+	queue_push_tail(queue, ep);
+
+	return ep;
+}
+
 static struct bap_ep *ep_register(struct btd_service *service,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
@@ -677,6 +842,23 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
+static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct bap_ep *ep;
+
+	DBG("lpac %p rpac %p", lpac, rpac);
+
+	ep = ep_register_bcast(user_data, lpac, rpac);
+	if (!ep) {
+		error("Unable to register endpoint for pac %p", rpac);
+		return true;
+	}
+
+	return true;
+}
+
+
 static void bap_ready(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -700,11 +882,18 @@ static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
 {
 	struct bap_ep *ep;
 
-	ep = queue_find(data->snks, match_ep_by_stream, stream);
-	if (ep)
-		return ep;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		ep = queue_find(data->snks, match_ep_by_stream, stream);
+		if (ep)
+			return ep;
 
-	return queue_find(data->srcs, match_ep_by_stream, stream);
+		return queue_find(data->srcs, match_ep_by_stream, stream);
+	} else if (bt_bap_stream_get_type(stream) ==
+			BT_BAP_STREAM_TYPE_BROADCAST) {
+
+		return queue_find(data->bcast, match_ep_by_stream, stream);
+	} else
+		return NULL;
 }
 
 static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -943,6 +1132,62 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
 
+static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream,
+				struct bt_iso_qos *qos)
+{
+	struct btd_adapter *adapter = data->user_data;
+	GIOChannel *io = NULL;
+	GError *err = NULL;
+	bdaddr_t dst_addr = {0};
+	char addr[18];
+	struct bt_iso_base base;
+
+	/* If IO already set and we are in the creation step,
+	 * skip creating it again
+	 */
+	if (bt_bap_stream_get_io(stream))
+		return;
+
+	if (ep->io_id) {
+		g_source_remove(ep->io_id);
+		ep->io_id = 0;
+	}
+	base.base_len = ep->caps->iov_len;
+
+	memset(base.base, 0, 248);
+	memcpy(base.base, ep->caps->iov_base, base.base_len);
+	DBG("ep %p stream %p ", ep, stream);
+	ba2str(btd_adapter_get_address(adapter), addr);
+
+	io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			&dst_addr,
+			BT_IO_OPT_DEST_TYPE,
+			BDADDR_LE_PUBLIC,
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_INVALID);
+
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			bap_io_disconnected, ep);
+
+	ep->io = io;
+
+	bt_bap_stream_io_connecting(stream,
+					g_io_channel_unix_get_fd(io));
+}
+
 static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 						struct bt_iso_qos *qos)
 {
@@ -989,22 +1234,53 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	if (!queue_find(data->streams, NULL, stream))
 		queue_push_tail(data->streams, stream);
 
-	if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
-		error("bt_bap_stream_get_qos_links: failed");
-		return;
-	}
-
 	memset(&iso_qos, 0, sizeof(iso_qos));
-	iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id :
+
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
+			error("bt_bap_stream_get_qos_links: failed");
+			return;
+		}
+
+		iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id :
 						qos[1]->ucast.cig_id;
-	iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
+		iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
 						qos[1]->ucast.cis_id;
 
-	bap_iso_qos(qos[0], &iso_qos.ucast.in);
-	bap_iso_qos(qos[1], &iso_qos.ucast.out);
+		bap_iso_qos(qos[0], &iso_qos.ucast.in);
+		bap_iso_qos(qos[1], &iso_qos.ucast.out);
+	} else if (bt_bap_stream_get_type(stream) ==
+			BT_BAP_STREAM_TYPE_BROADCAST) {
+		if (defer == true) {
+			iso_qos.bcast.big = ep->qos.bcast.big;
+			iso_qos.bcast.bis = ep->qos.bcast.bis;
+			iso_qos.bcast.sync_interval =
+						ep->qos.bcast.sync_interval;
+			iso_qos.bcast.packing = ep->qos.bcast.packing;
+			iso_qos.bcast.framing = ep->qos.bcast.framing;
+			iso_qos.bcast.encryption = ep->qos.bcast.encryption;
+			memcpy(iso_qos.bcast.bcode,
+					ep->qos.bcast.bcode.iov_base, 16);
+			iso_qos.bcast.options = ep->qos.bcast.options;
+			iso_qos.bcast.skip = ep->qos.bcast.skip;
+			iso_qos.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
+			iso_qos.bcast.sync_cte_type =
+						ep->qos.bcast.sync_cte_type;
+			iso_qos.bcast.mse = ep->qos.bcast.mse;
+			iso_qos.bcast.timeout = ep->qos.bcast.timeout;
+			memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
+						sizeof(struct bt_iso_io_qos));
+		}
+	} else
+		return;
 
 	if (ep)
-		bap_connect_io(data, ep, stream, &iso_qos, defer);
+		if (bt_bap_stream_get_type(stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST)
+			bap_connect_io_broadcast(data, ep, stream,
+							&iso_qos);
+		else
+			bap_connect_io(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io(data, stream, &iso_qos);
 }
@@ -1043,12 +1319,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			}
 
 
-			/* Wait QoS response to respond */
-			ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,
-									ep);
-			if (!ep->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
+			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UNICAST) {
+				/* Wait QoS response to respond */
+				ep->id = bt_bap_stream_qos(stream, &ep->qos,
+								qos_cb,	ep);
+				if (!ep->id) {
+					error("Failed to Configure QoS");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+				}
 			}
 		}
 		break;
@@ -1059,6 +1339,13 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_get_type(stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+			if (ep)
+				bap_create_io(data, ep, stream, false);
+		}
+		break;
 	}
 }
 
@@ -1078,6 +1365,18 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
 }
 
+static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
+{
+	struct bap_data *data = user_data;
+
+	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE) {
+		DBG("pac %p", pac);
+
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
+						pac_found_bcast, data);
+	}
+}
+
 static bool ep_match_pac(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
@@ -1118,6 +1417,38 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
 	ep_unregister(ep);
 }
 
+static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+	struct queue *queue;
+	struct bap_ep *ep;
+
+	DBG("pac %p", pac);
+
+	data = btd_service_get_user_data(service);
+
+	switch (bt_bap_pac_get_type(pac)) {
+	case BT_BAP_SINK:
+		queue = data->srcs;
+		break;
+	case BT_BAP_SOURCE:
+		queue = data->snks;
+		break;
+	case BT_BAP_BCAST_SOURCE:
+		queue = data->bcast;
+		break;
+	default:
+		return;
+	}
+
+	ep = queue_remove_if(queue, ep_match_pac, pac);
+	if (!ep)
+		return;
+
+	ep_unregister(ep);
+}
+
 static struct bap_data *bap_data_new(struct btd_device *device)
 {
 	struct bap_data *data;
@@ -1126,6 +1457,7 @@ static struct bap_data *bap_data_new(struct btd_device *device)
 	data->device = device;
 	data->srcs = queue_new();
 	data->snks = queue_new();
+	data->bcast = queue_new();
 
 	return data;
 }
@@ -1158,6 +1490,14 @@ static bool match_data(const void *data, const void *match_data)
 	return bdata->bap == bap;
 }
 
+static bool match_data_bap_data(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return bdata->user_data == adapter;
+}
+
 static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 							void *user_data)
 {
@@ -1182,26 +1522,50 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	/* Attempt to get CIG/CIS if they have not been set */
-	if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		/* Attempt to get CIG/CIS if they have not been set */
+		if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
 				ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
-		struct bt_iso_qos qos;
-		GError *err = NULL;
-
-		if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
-					BT_IO_OPT_INVALID)) {
-			error("%s", err->message);
-			g_error_free(err);
-			g_io_channel_unref(io);
-			return;
-		}
+			struct bt_iso_qos qos;
+			GError *err = NULL;
+
+			if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
+						BT_IO_OPT_INVALID)) {
+				error("%s", err->message);
+				g_error_free(err);
+				g_io_channel_unref(io);
+				return;
+			}
 
-		ep->qos.ucast.cig_id = qos.ucast.cig;
-		ep->qos.ucast.cis_id = qos.ucast.cis;
-	}
+			ep->qos.ucast.cig_id = qos.ucast.cig;
+			ep->qos.ucast.cis_id = qos.ucast.cis;
+		}
 
-	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
 				ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);
+	} else if (bt_bap_stream_get_type(ep->stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+		/* Attempt to get BIG/BIS if they have not been set */
+		if (ep->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+				ep->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+			struct bt_iso_qos qos;
+			GError *err = NULL;
+
+			if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
+						BT_IO_OPT_INVALID)) {
+				error("%s", err->message);
+				g_error_free(err);
+				g_io_channel_unref(io);
+				return;
+			}
+
+			ep->qos.bcast.big = qos.bcast.big;
+			ep->qos.bcast.bis = qos.bcast.bis;
+		}
+
+		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+					ep->qos.bcast.big, ep->qos.bcast.bis);
+	}
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -1349,6 +1713,67 @@ static int bap_disconnect(struct btd_service *service)
 	return 0;
 }
 
+static int bap_adapter_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(btd_adapter_get_address(adapter), addr);
+	DBG("%s", addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	data = bap_data_new(NULL);
+	data->adapter = adapter;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+					btd_gatt_database_get_db(database));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	if (!bt_bap_attach_broadcast(data->bap)) {
+		error("BAP unable to attach");
+		return -EINVAL;
+	}
+
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
+					pac_removed_broadcast, data, NULL);
+
+	bt_bap_set_user_data(data->bap, adapter);
+	bap_data_set_user_data(data, adapter);
+	return 0;
+}
+
+static void bap_adapter_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct bap_data *data = queue_find(sessions, match_data_bap_data,
+						adapter);
+	char addr[18];
+
+	ba2str(btd_adapter_get_address(adapter), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("BAP service not handled by profile");
+		return;
+	}
+
+	bap_data_remove(data);
+}
+
 static struct btd_profile bap_profile = {
 	.name		= "bap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
@@ -1357,6 +1782,8 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.adapter_probe	= bap_adapter_probe,
+	.adapter_remove	= bap_adapter_remove,
 	.auto_connect	= true,
 	.experimental	= true,
 };
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 515263af3..8280101af 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1041,28 +1041,50 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	transport = find_transport(endpoint, stream);
 	if (!transport) {
 		struct bt_bap *bap = bt_bap_stream_get_session(stream);
-		struct btd_service *service = bt_bap_get_user_data(bap);
-		struct btd_device *device;
+		if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UNICAST) {
+			struct btd_service *service = bt_bap_get_user_data(bap);
+			struct btd_device *device;
+
+			if (service)
+				device = btd_service_get_device(service);
+			else {
+				struct bt_att *att = bt_bap_get_att(bap);
+				int fd = bt_att_get_fd(att);
+
+				device = btd_adapter_find_device_by_fd(fd);
+			}
+
+			if (!device) {
+				error("Unable to find device");
+				return -EINVAL;
+			}
 
-		if (service)
-			device = btd_service_get_device(service);
-		else {
-			struct bt_att *att = bt_bap_get_att(bap);
-			int fd = bt_att_get_fd(att);
+			path = bt_bap_stream_get_user_data(stream);
 
-			device = btd_adapter_find_device_by_fd(fd);
-		}
+			transport = media_transport_create(device, path,
+								cfg->iov_base,
+								cfg->iov_len,
+								endpoint,
+								stream);
+		} else if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BROADCAST) {
+			struct btd_adapter *adapter = bt_bap_get_user_data(bap);
 
-		if (!device) {
-			error("Unable to find device");
-			return -EINVAL;
-		}
+			if (!adapter) {
+				error("Unable to find adapter");
+				return -EINVAL;
+			}
+
+			path = bt_bap_stream_get_user_data(stream);
 
-		path = bt_bap_stream_get_user_data(stream);
+			transport = media_transport_create(NULL, path,
+								cfg->iov_base,
+								cfg->iov_len,
+								endpoint,
+								stream);
+		}
 
-		transport = media_transport_create(device, path, cfg->iov_base,
-							cfg->iov_len, endpoint,
-							stream);
 		if (!transport)
 			return -EINVAL;
 
@@ -1198,6 +1220,12 @@ static bool endpoint_init_pac_source(struct media_endpoint *endpoint, int *err)
 	return endpoint_init_pac(endpoint, BT_BAP_SOURCE, err);
 }
 
+static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
+						int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SOURCE, err);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1300,6 +1328,18 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
+{
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
+		return false;
+
+	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_BROADCASTER))
+		return false;
+
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1313,6 +1353,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
 				experimental_endpoint_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_source,
+			experimental_broadcaster_ep_supported },
 };
 
 static struct media_endpoint *
@@ -3185,3 +3227,9 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
 {
 	return endpoint->codec;
 }
+
+struct btd_adapter *media_endpoint_get_btd_adapter(
+					struct media_endpoint *endpoint)
+{
+	return endpoint->adapter->btd_adapter;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 96bea9db4..1de84a8ff 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -20,5 +20,7 @@ void media_unregister(struct btd_adapter *btd_adapter);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+struct btd_adapter *media_endpoint_get_btd_adapter(
+					struct media_endpoint *endpoint);
 
 int8_t media_player_get_device_volume(struct btd_device *device);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 82f5fa6fe..773be8411 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -91,6 +91,7 @@ struct bap_transport {
 struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
+	struct btd_adapter	*adapter;	/* Transport adapter bcast*/
 	const char		*remote_endpoint; /* Transport remote SEP */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
@@ -526,6 +527,13 @@ static void media_owner_add(struct media_owner *owner,
 	owner->pending = req;
 }
 
+static void *get_stream_bap(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+
+	return bap->stream;
+}
+
 static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -541,15 +549,24 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(msg);
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+		req = media_request_create(msg, 0x00);
+		media_owner_add(owner, req);
+		media_transport_set_owner(transport, owner);
+	}
 	id = transport->resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
 
-	req = media_request_create(msg, id);
-	media_owner_add(owner, req);
-	media_transport_set_owner(transport, owner);
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_UNICAST) {
+		req = media_request_create(msg, id);
+		media_owner_add(owner, req);
+		media_transport_set_owner(transport, owner);
+	}
 
 	return NULL;
 }
@@ -628,7 +645,12 @@ static gboolean get_device(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	const char *path = device_get_path(transport->device);
+	const char *path;
+
+	if (transport->device)
+		path = device_get_path(transport->device);
+	else
+		path = adapter_get_path(transport->adapter);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -1483,13 +1505,6 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
-static void *get_stream_bap(struct media_transport *transport)
-{
-	struct bap_transport *bap = transport->data;
-
-	return bap->stream;
-}
-
 static void free_bap(void *data)
 {
 	struct bap_transport *bap = data;
@@ -1539,15 +1554,26 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
-	transport->device = device;
+	if (device)
+		transport->device = device;
+	else
+		transport->adapter = media_endpoint_get_btd_adapter(endpoint);
 	transport->endpoint = endpoint;
 	transport->configuration = g_new(uint8_t, size);
 	memcpy(transport->configuration, configuration, size);
 	transport->size = size;
 	transport->remote_endpoint = remote_endpoint;
-	transport->path = g_strdup_printf("%s/fd%d",
-				remote_endpoint ? remote_endpoint :
-				device_get_path(device), fd++);
+	if (device)
+		transport->path = g_strdup_printf("%s/fd%d",
+					remote_endpoint ? remote_endpoint :
+					device_get_path(device), fd++);
+	else
+		transport->path = g_strdup_printf("%s/fd%d",
+					remote_endpoint ? remote_endpoint :
+					adapter_get_path(
+						media_endpoint_get_btd_adapter(
+							endpoint)),
+					fd++);
 	transport->fd = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
@@ -1560,7 +1586,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 			goto fail;
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
-				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
+				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

