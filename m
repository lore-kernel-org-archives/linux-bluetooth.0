Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607DCC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbjEYPfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjEYPfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756DA3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDi5zhcl3Y0L54nUnauADhy99YHPyPN9z7/Jsup1eLy3kk2zAzQHNRNFpenXOProbXY45y5Xy5727Kx/casxUKASvWA7CjkF1WoyHScSzeY5dfmiKvVKJW5v/wSYvCqeK+cDfxazAP1rXdWT8CfOKXcbKAV8h5PPZvLPlHZKNXIl0EFzvj/cVfrCfU6BIy5Ar1dikne0K4VTaDzBAULSDILjW2I96Jp9ru9qMf3CcDfqR7tjCfYwhtv9pKQd74t2VwQWZVjVxNcuA9b21RpKSHjbDHD7V8wI/l/QDjYmSKSJhceZcjvFXbRNhJnbI2/AFyLMYa+PAGvPRzujsIBAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmgMQA9oj4RXQcVCKFu6lcU+808Hljd9ICtoYhHjwKw=;
 b=PViqnCIF6AkNgc1uGBxZyE7oUjVDgSh+QXcsgaIEpRRHvZZylmDXIeFMijvWUop1eytj6cllPbh78kFvTSctFvDJXymNGl1hRFmPF3eTGN7tQC2bPziD0oAolDpbbCdlPzkb5s1tkffDNJBYnCL2hzCWo9JhcK0aSLUUJIDsJJXvAzzJpOMo0tCyDKxLnjXavBQyne4iKsjlNhthd7MtOwW/RFV9IJeVFJ3KyGYDZZ/IaUUpY1K/kbSnX2JcDZmfWQUA8UoDHCyZemCiBUe3Xywm32lWKJ1eu8yp21556QeB1F8qN/aL/IRsjH43q+HjFVaQgm/yEYRKHLttRfBvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmgMQA9oj4RXQcVCKFu6lcU+808Hljd9ICtoYhHjwKw=;
 b=lUf/SYergp6ShIZv+tWTwfIc0I1k+sa3cdHR1lQJTwTQi1YiNvah50WIxayHQ3N3cE8QZhgXObX6F+mYTOhh4XPLJlFDnLSz4ZxH/nHG7a4g5wzSkVgyTHTG5racAUtDCaVRnQ3dOp0Gt6x/H4DEJWyIoXyXfMRMCUwl7vxy7x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 15:35:20 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:20 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 6/6] Add initial support for BAP broadcast source
Date:   Thu, 25 May 2023 18:34:52 +0300
Message-Id: <20230525153452.125789-7-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 3449761d-50cf-48de-1a22-08db5d35a597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSjVJ1AM2FWbaxQaS6bWL4FqJeGuAIr6gflHdbuz8iWMvNzE8tM7tEkfa9EEjEX+e+Xe4pj+VBSJG6cocDw28k2GtsRVMgApjGhAvTAWcXNxj7Q6BA1sYStL6roRYst6Ywm/o8BYQpS6wGQP7UTzUK3KhMmpDmjsIDHnq0rFk6oV2G5TahilG7X85iAm8ceizLTYW2Hr4n6N22K0DlO6gYZoVGqVf8ez6+UI1iSNhohlweXlo0aDzvVjicQUNaSZcHmF5QZysSDqdrihrBQQqYTztLFMYARz1/HDq/xS3ouri3DeMMaz4AZfignuWqnshdupTCGsEJfguYxnKGCmmtplkCNT36OeXSGVTrMWqDVVojf+8UQjwP/7SjYslCc3Hnog+7cdBY2AWmBsg9B8SqS7lJxmcg99oGGYZEPd+6KOssyfxbuAYNqkNjQCueMFHupCJ8DFIej1wCV2j99wab2t64t3R0NTv5NYfuE06wpKWfJxFbAAoiZidXaBmPhlHtMvpoOZG/NZuQ+RmLim5jkXLVn8up6/NuLEQXPAXRGHUfosMrH5eUOSzIpOYhU0g0BOwiVTHByLr3eVEtSixJF9VwtF7TAYQe65trnMSuCXFZLS8iTRqskmwosJJRah
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(5660300002)(36756003)(316002)(41300700001)(38100700002)(38350700002)(66946007)(52116002)(66476007)(66556008)(83380400001)(4326008)(6916009)(478600001)(55236004)(86362001)(186003)(2906002)(6486002)(30864003)(8936002)(6666004)(8676002)(2616005)(6512007)(1076003)(26005)(6506007)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRm0PiM+LT7ffFJkkOy/xp2h8WfMK/zTXYxIpQSvmKbIUX5ZATFIuO6iBgfd?=
 =?us-ascii?Q?vkW19+tmmrLjwBj+DjkdBywZ+l3hpgySytxEJoQvxgmylAZnUKMgPL/+mfpa?=
 =?us-ascii?Q?HlXEZI2rb0PtoK34aSInt15eg73PEX0E6mAROilGp+EFXTxeJceUqyBh4035?=
 =?us-ascii?Q?+7Rvew+zvOxDnvJlrzAVP7wNsJ2/XMyzUG934aJ/0WU3DhckToNxK15jk7Te?=
 =?us-ascii?Q?6V54tNobsGYITCN9HfV/5rP2ISkAqPudjb/znQkw/IYM0NYLXIOLa1KIZ7/o?=
 =?us-ascii?Q?QxgoHj4D4AdWxrjSvt+u0UeyIkEavscnu3x3PLCj9i532zpIvHaG/LP0Sxnt?=
 =?us-ascii?Q?sckpna72lGhUFgN8OaMUyibN3b3qejxWXs+m+FaEITZNzc1XCisiutoY6fqN?=
 =?us-ascii?Q?u8hkzJ1eD2CyxzRxrhG8HaW4HqsJJbj6iaUJ53sps3w/4Z7wHhhMNjCpcbI6?=
 =?us-ascii?Q?W8HHXYG8c55CL5iTom2LlZMxj1W1lqygUWQ0fo4JToMJQOIOvqNCtlWwiBB9?=
 =?us-ascii?Q?TWt/xz/cWeQR09qqXVGEFMxzxMTGUonNpkZ26Uu7aJVo7873Ho5DxA7fTfZ5?=
 =?us-ascii?Q?x9l1w9EtnSG+RF+RHqFmetOs/T3ctOADEbh7umwdeh470dtTSa6e3OPce7+p?=
 =?us-ascii?Q?XNAG8PspZsl8RMv8y5yWDQ/R+BKa3mJwwc/xjMHM8+cx79JCyT2qkxqOSr+A?=
 =?us-ascii?Q?ab0pftk0A2k8h3ozs7bLOLx7lx2TVF5MfSUJYk/vGQh38Zblz6N5iUVJlC/4?=
 =?us-ascii?Q?CMO00YlOH2rCtrm8JEDhaQgCRfOFWBlBeilfQmOJDh1hRM7Xp2FYvOCcwX0i?=
 =?us-ascii?Q?OrYGCR5HifsoBe9+N+1znHXb2Mv5UGW19tew40aEQV9RGFrqEh5Rmrl05Gvk?=
 =?us-ascii?Q?KcOCLPKebCvxR+nvDgzQRAogJ2A8GtDC2YBrlsIIXGkZePqRAEt1XOXUr1/I?=
 =?us-ascii?Q?L19tjvB6/sSa3rD1skNdjwWfwq6uYd8i+XxyzSUNH1oYMAYsnEVG8pO8QQuA?=
 =?us-ascii?Q?VKMNf9/8/r7LNU89GJQCOphni445lEcLOaCPyK1+FNm2SYR7uFZAvTNTwTbN?=
 =?us-ascii?Q?zIWLqqK2FrM+/ka5KuWp2dH3bCmijwZu80cKEJfv6RQ/v4ZyDU0oLgPaifu4?=
 =?us-ascii?Q?2+vOL1nxPokocJKQgK8KaNGqa/uMHlzsVH3o5+oCDG09q9nXkuJsgrhkre5l?=
 =?us-ascii?Q?gSq55Zc8ELPYW1fA2okp2h6yTB0p7rYjvmCtuJTD0klgUVe+u5uB0oZePTM5?=
 =?us-ascii?Q?G2QwtedwATqW+F7AUj6d0jKaKBn9WHCxQBvA9eNkGTKHiTyJM/0nXkmM4hse?=
 =?us-ascii?Q?hc3DqVp1Ic1s2rZOkUav35OmqEiFe24sFOm24TwuI2mpjUFTk3W7l1LEIaOb?=
 =?us-ascii?Q?CSE4HJLctKigm/fkLLG+Dc5B4+XH+BbXxfcm3VmNVm7UvCa1KFXubK8qSuUr?=
 =?us-ascii?Q?fqBWj02Z/t6pHKcuc2mKJtdn48PUYnh4EyyM3V+dlYk3jMFft3NfWqXFW1EW?=
 =?us-ascii?Q?jjPwNO4WMatqZDBBk26BWRswmJfRM1/4TiDO8Nro+hOkgfw6WhaxKqZywheh?=
 =?us-ascii?Q?tmIzaKFsR41/toLpYpwW+0MiUqjP7dvMFyHmf+3GBRh3qJ4NC0pCuAt4IeWn?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3449761d-50cf-48de-1a22-08db5d35a597
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:20.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmSaxwopVSY9Bp+p3Aj9GDtLVqnNrjbImkbdXyk0fWaowalVAFso17kfuEH38rX6i90Kh9+XXtVTkSK2Mh8oK8n4h8EqCANxm10qixLFfWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial support for BAP broadcast source.

---
 profiles/audio/bap.c       | 455 ++++++++++++++++++++++++++++++++-----
 profiles/audio/media.c     | 129 +++++++++--
 profiles/audio/transport.c |  51 +++--
 src/shared/bap.c           | 324 +++++++++++++++++++-------
 src/shared/bap.h           |  81 +++++--
 unit/test-bap.c            |  83 +++----
 6 files changed, 881 insertions(+), 242 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1a543a9ce..2b281f58c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -82,13 +82,25 @@ struct bap_data {
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
@@ -167,8 +179,10 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 
 	if (queue_find(ep->data->snks, NULL, ep))
 		uuid = PAC_SINK_UUID;
-	else
+	if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else
+		uuid = BAA_SERVICE_UUID;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
@@ -253,6 +267,8 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct bt_bap_qos *qos)
 {
 	const char *key;
+	struct bt_bap_io_qos io_qos;
+	bool broadcast = false;
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
@@ -282,17 +298,27 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cig_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.big);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cis_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
+		} else if (!strcasecmp(key, "BIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->interval);
+			dbus_message_iter_get_basic(&value, &io_qos.interval);
 		} else if (!strcasecmp(key, "Framing")) {
 			dbus_bool_t val;
 
@@ -301,7 +327,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			dbus_message_iter_get_basic(&value, &val);
 
-			qos->framing = val;
+			qos->ucast.framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
@@ -311,42 +337,91 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			dbus_message_iter_get_basic(&value, &str);
 
 			if (!strcasecmp(str, "1M"))
-				qos->phy = 0x01;
+				io_qos.phy = 0x01;
 			else if (!strcasecmp(str, "2M"))
-				qos->phy = 0x02;
+				io_qos.phy = 0x02;
 			else
 				goto fail;
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->sdu);
+			dbus_message_iter_get_basic(&value, &io_qos.sdu);
 		} else if (!strcasecmp(key, "Retransmissions")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->rtn);
+			dbus_message_iter_get_basic(&value, &io_qos.rtn);
 		} else if (!strcasecmp(key, "Latency")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->latency);
+			dbus_message_iter_get_basic(&value, &io_qos.latency);
 		} else if (!strcasecmp(key, "Delay")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->delay);
+			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
 		} else if (!strcasecmp(key, "TargetLatency")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-							&qos->target_latency);
+							&qos->ucast.target_latency);
+		} else if (!strcasecmp(key, "Encryption")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.encryption);
+			DBG("Got Encryption for bcast");
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
+							&qos->bcast.sync_timeout);
+		} else if (!strcasecmp(key, "SyncCteType")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.sync_cte_type);
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
 		}
 
 		dbus_message_iter_next(props);
 	}
 
+	if (broadcast)
+		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
+	else
+		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+
 	return 0;
 
 fail:
@@ -456,8 +531,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	/* Mark CIG and CIS to be auto assigned */
-	ep->qos.cig_id = BT_ISO_QOS_CIG_UNSET;
-	ep->qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+	ep->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 
 	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
@@ -508,6 +583,8 @@ static void ep_free(void *data)
 
 	util_iov_free(ep->caps, 1);
 	util_iov_free(ep->metadata, 1);
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		util_iov_free(&ep->qos.bcast.bcode, 1);
 	free(ep->path);
 	free(ep);
 }
@@ -551,6 +628,11 @@ static struct bap_ep *ep_register(struct btd_service *service,
 		i = queue_length(data->srcs);
 		suffix = "source";
 		break;
+	case BT_BAP_BROADCAST_SOURCE:
+		queue = data->bcast;
+		i = queue_length(data->bcast);
+		suffix = "broadcast";
+		break;
 	default:
 		return NULL;
 	}
@@ -609,12 +691,14 @@ static void bap_config(void *data, void *user_data)
 
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
 						config_cb, ep);
-	if (!ep->id) {
-		DBG("Unable to config stream");
-		util_iov_free(ep->caps, 1);
-		ep->caps = NULL;
-		util_iov_free(ep->metadata, 1);
-		ep->metadata = NULL;
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!ep->id) {
+			DBG("Unable to config stream");
+			util_iov_free(ep->caps, 1);
+			ep->caps = NULL;
+			util_iov_free(ep->metadata, 1);
+			ep->metadata = NULL;
+		}
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
@@ -650,6 +734,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -666,8 +751,13 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
-	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service)) {
+	if (bt_bap_pac_get_type(lpac) != BT_BAP_BROADCAST_SOURCE) {
+		/* TODO: Cache LRU? */
+		if (btd_service_is_initiator(service)) {
+			if (!bt_bap_select(lpac, rpac, select_cb, ep))
+				ep->data->selecting++;
+			}
+	} else {
 		if (!bt_bap_select(lpac, rpac, select_cb, ep))
 			ep->data->selecting++;
 	}
@@ -698,11 +788,17 @@ static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
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
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+
+		return queue_find(data->bcast, match_ep_by_stream, stream);
+	} else
+		return NULL;
 }
 
 static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -734,11 +830,11 @@ static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
 	if (!qos)
 		return;
 
-	io->interval = qos->interval;
-	io->latency = qos->latency;
-	io->sdu = qos->sdu;
-	io->phy = qos->phy;
-	io->rtn = qos->rtn;
+	io->interval = qos->ucast.io_qos.interval;
+	io->latency = qos->ucast.io_qos.latency;
+	io->sdu = qos->ucast.io_qos.sdu;
+	io->phy = qos->ucast.io_qos.phy;
+	io->rtn = qos->ucast.io_qos.rtn;
 }
 
 static bool match_stream_qos(const void *data, const void *user_data)
@@ -749,10 +845,10 @@ static bool match_stream_qos(const void *data, const void *user_data)
 
 	qos = bt_bap_stream_get_qos((void *)stream);
 
-	if (iso_qos->ucast.cig != qos->cig_id)
+	if (iso_qos->ucast.cig != qos->ucast.cig_id)
 		return false;
 
-	return iso_qos->ucast.cis == qos->cis_id;
+	return iso_qos->ucast.cis == qos->ucast.cis_id;
 }
 
 static void iso_confirm_cb(GIOChannel *io, void *user_data)
@@ -941,6 +1037,65 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
 
+static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream,
+				struct bt_iso_qos *qos, int defer)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	GIOChannel *io = NULL;
+	GError *err = NULL;
+	bdaddr_t dst_addr = {0};
+	char addr[18];
+	struct bt_iso_base base;
+
+	/* If IO already set and we are in the creation step, skip creating it again */
+	if (bt_bap_stream_get_io(stream) && (defer == true))
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
+	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+	ba2str(btd_adapter_get_address(adapter), addr);
+
+	/* Just create socket and advance to the configured state (when defer = true) */
+	if (defer == true) {
+		io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				&dst_addr,
+				BT_IO_OPT_DEST_TYPE,
+				BDADDR_LE_PUBLIC,
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, qos,
+				BT_IO_OPT_BASE, &base,
+				BT_IO_OPT_DEFER_TIMEOUT, defer,
+				BT_IO_OPT_INVALID);
+
+		if (!io) {
+			error("%s", err->message);
+			g_error_free(err);
+			return;
+		}
+
+		ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				bap_io_disconnected, ep);
+
+		ep->io = io;
+
+		bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
+	} else { /* Advance stream state to Streaming */
+		io = ep->io;
+		// TO DO change to streaming state
+	}
+}
+
 static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 						struct bt_iso_qos *qos)
 {
@@ -987,20 +1142,44 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	if (!queue_find(data->streams, NULL, stream))
 		queue_push_tail(data->streams, stream);
 
-	if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
-		error("bt_bap_stream_get_qos_links: failed");
-		return;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
+			error("bt_bap_stream_get_qos_links: failed");
+			return;
+		}
 	}
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
-	iso_qos.ucast.cig = qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
-	iso_qos.ucast.cis = qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		if (defer == true) {
+			iso_qos.bcast.big = ep->qos.bcast.big;
+			iso_qos.bcast.bis = ep->qos.bcast.bis;
+			iso_qos.bcast.sync_interval = ep->qos.bcast.sync_interval;
+			iso_qos.bcast.packing = ep->qos.bcast.packing;
+			iso_qos.bcast.framing = ep->qos.bcast.framing;
+			iso_qos.bcast.encryption = ep->qos.bcast.encryption;
+			memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode.iov_base, 16);
+			iso_qos.bcast.options = ep->qos.bcast.options;
+			iso_qos.bcast.skip = ep->qos.bcast.skip;
+			iso_qos.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
+			iso_qos.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;
+			iso_qos.bcast.mse = ep->qos.bcast.mse;
+			iso_qos.bcast.timeout = ep->qos.bcast.timeout;
+			memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos, sizeof(struct bt_iso_io_qos));
+		}
+	} else {
+		iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id : qos[1]->ucast.cig_id;
+		iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;
 
-	bap_iso_qos(qos[0], &iso_qos.ucast.in);
-	bap_iso_qos(qos[1], &iso_qos.ucast.out);
+		bap_iso_qos(qos[0], &iso_qos.ucast.in);
+		bap_iso_qos(qos[1], &iso_qos.ucast.out);
+	}
 
 	if (ep)
-		bap_connect_io(data, ep, stream, &iso_qos, defer);
+		if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+			bap_connect_io_broadcast(data, ep, stream, &iso_qos, defer);
+		else
+			bap_connect_io(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io(data, stream, &iso_qos);
 }
@@ -1039,12 +1218,14 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			}
 
 
-			/* Wait QoS response to respond */
-			ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,
-									ep);
-			if (!ep->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
+			if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+				/* Wait QoS response to respond */
+				ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,
+										ep);
+				if (!ep->id) {
+					error("Failed to Configure QoS");
+					bt_bap_stream_release(stream, NULL, NULL);
+				}
 			}
 		}
 		break;
@@ -1055,6 +1236,12 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+			if (ep)
+				bap_create_io(data, ep, stream, false);
+		}
+		break;
 	}
 }
 
@@ -1074,6 +1261,20 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
 }
 
+static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+
+	if (bt_bap_pac_get_type(pac) == BT_BAP_BROADCAST_SOURCE) {
+		DBG("pac %p", pac);
+
+		data = btd_service_get_user_data(service);
+
+		bt_bap_foreach_pac(data->bap, BT_BAP_BROADCAST_SOURCE, pac_found, service);
+	}
+}
+
 static bool ep_match_pac(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
@@ -1114,6 +1315,38 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
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
+	case BT_BAP_BROADCAST_SOURCE:
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
@@ -1122,6 +1355,7 @@ static struct bap_data *bap_data_new(struct btd_device *device)
 	data->device = device;
 	data->srcs = queue_new();
 	data->snks = queue_new();
+	data->bcast = queue_new();
 
 	return data;
 }
@@ -1154,6 +1388,14 @@ static bool match_data(const void *data, const void *match_data)
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
@@ -1178,26 +1420,49 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	/* Attempt to get CIG/CIS if they have not been set */
-	if (ep->qos.cig_id == BT_ISO_QOS_CIG_UNSET ||
-				ep->qos.cis_id == BT_ISO_QOS_CIS_UNSET) {
-		struct bt_iso_qos qos;
-		GError *err = NULL;
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		/* Attempt to get CIG/CIS if they have not been set */
+		if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+					ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
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
 
-		if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
-					BT_IO_OPT_INVALID)) {
-			error("%s", err->message);
-			g_error_free(err);
-			g_io_channel_unref(io);
-			return;
+			ep->qos.ucast.cig_id = qos.ucast.cig;
+			ep->qos.ucast.cis_id = qos.ucast.cis;
 		}
 
-		ep->qos.cig_id = qos.ucast.cig;
-		ep->qos.cis_id = qos.ucast.cis;
-	}
+		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+						ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);
+	} else if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		/* Attempt to get BIG/BIS if they have not been set */
+		if (ep->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+					ep->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
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
 
-	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
-					ep->qos.cig_id, ep->qos.cis_id);
+		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+						ep->qos.bcast.big, ep->qos.bcast.bis);
+	}
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -1345,6 +1610,68 @@ static int bap_disconnect(struct btd_service *service)
 	return 0;
 }
 
+static int bap_adapter_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_device *device = btd_adapter_get_device(adapter, BDADDR_ANY, BDADDR_LE_PUBLIC);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct btd_service *service = service_create(device, p);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	data = bap_data_new(device);
+	data->service = service;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
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
+						pac_removed_broadcast, service, NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+	bap_data_set_user_data(data, adapter);
+	return 0;
+}
+
+static void bap_adapter_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct bap_data *data = queue_find(sessions, match_data_bap_data, adapter);
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
@@ -1353,6 +1680,8 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.adapter_probe	= bap_adapter_probe,
+	.adapter_remove	= bap_adapter_remove,
 	.auto_connect	= true,
 	.experimental	= true,
 };
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6ce668e31..ab9ae42e0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -6,7 +6,7 @@
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
- *
+ *  Copyright 2023 NXP
  *
  */
 
@@ -748,7 +748,11 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 					struct bt_bap_qos *qos)
 {
 	const char *key;
+	struct bt_bap_io_qos io_qos;
+	uint8_t framing = 0;
+	bool broadcast = false;
 
+	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
 		int var;
@@ -777,17 +781,27 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cig_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.big);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->cis_id);
+			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->interval);
+			dbus_message_iter_get_basic(&value, &io_qos.interval);
 		} else if (!strcasecmp(key, "Framing")) {
 			dbus_bool_t val;
 
@@ -796,7 +810,7 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 
 			dbus_message_iter_get_basic(&value, &val);
 
-			qos->framing = val;
+			framing = val;
 		} else if (!strcasecmp(key, "PHY")) {
 			const char *str;
 
@@ -806,42 +820,106 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 			dbus_message_iter_get_basic(&value, &str);
 
 			if (!strcasecmp(str, "1M"))
-				qos->phy = 0x01;
+				io_qos.phy = 0x01;
 			else if (!strcasecmp(str, "2M"))
-				qos->phy = 0x02;
+				io_qos.phy = 0x02;
 			else
 				goto fail;
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->sdu);
+			dbus_message_iter_get_basic(&value, &io_qos.sdu);
 		} else if (!strcasecmp(key, "Retransmissions")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->rtn);
+			dbus_message_iter_get_basic(&value, &io_qos.rtn);
 		} else if (!strcasecmp(key, "Latency")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->latency);
+			dbus_message_iter_get_basic(&value, &io_qos.latency);
 		} else if (!strcasecmp(key, "Delay")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &qos->delay);
+			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
 		} else if (!strcasecmp(key, "TargetLatency")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-							&qos->target_latency);
+							&qos->ucast.target_latency);
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
+							&qos->bcast.sync_timeout);
+		} else if (!strcasecmp(key, "SyncCteType")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.sync_cte_type);
+
+		} else if (!strcasecmp(key, "SyncInterval")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.sync_interval);
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
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			parse_array(&value, &qos->bcast.bcode);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
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
@@ -875,8 +953,8 @@ static void pac_select_cb(struct media_endpoint *endpoint, void *ret, int size,
 	memset(&qos, 0, sizeof(qos));
 
 	/* Mark CIG and CIS to be auto assigned */
-	qos.cig_id = BT_ISO_QOS_CIG_UNSET;
-	qos.cis_id = BT_ISO_QOS_CIS_UNSET;
+	qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 
 	memset(&caps, 0, sizeof(caps));
 	memset(&meta, 0, sizeof(meta));
@@ -1166,15 +1244,13 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
 				endpoint->cid, endpoint->vid, &endpoint->qos,
-				&data, metadata);
+				&data, metadata, &pac_ops, endpoint);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(metadata);
 		return false;
 	}
 
-	bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
-
 	DBG("PAC %s registered", name);
 
 	free(name);
@@ -1193,6 +1269,11 @@ static bool endpoint_init_pac_source(struct media_endpoint *endpoint, int *err)
 	return endpoint_init_pac(endpoint, BT_BAP_SOURCE, err);
 }
 
+static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint, int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_BROADCAST_SOURCE, err);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1295,6 +1376,18 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
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
@@ -1308,6 +1401,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
 				experimental_endpoint_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_source,
+			experimental_broadcaster_ep_supported },
 };
 
 static struct media_endpoint *
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9172d167e..743fb5156 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -525,6 +526,13 @@ static void media_owner_add(struct media_owner *owner,
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
@@ -540,15 +548,22 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(msg);
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) == BT_BAP_STREAM_TYPE_BROADCAST) {
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
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) == BT_BAP_STREAM_TYPE_UNICAST) {
+		req = media_request_create(msg, id);
+		media_owner_add(owner, req);
+		media_transport_set_owner(transport, owner);
+	}
 
 	return NULL;
 }
@@ -828,7 +843,7 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	return bap->qos.phy != 0x00;
+	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
 static gboolean get_cig(const GDBusPropertyTable *property,
@@ -838,7 +853,7 @@ static gboolean get_cig(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.cig_id);
+							&bap->qos.ucast.cig_id);
 
 	return TRUE;
 }
@@ -850,7 +865,7 @@ static gboolean get_cis(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.cis_id);
+							&bap->qos.ucast.cis_id);
 
 	return TRUE;
 }
@@ -862,7 +877,7 @@ static gboolean get_interval(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
-							&bap->qos.interval);
+							&bap->qos.ucast.io_qos.interval);
 
 	return TRUE;
 }
@@ -872,7 +887,7 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	dbus_bool_t val = bap->qos.framing;
+	dbus_bool_t val = bap->qos.ucast.framing;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
@@ -885,7 +900,7 @@ static gboolean get_phy(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.phy);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ucast.io_qos.phy);
 
 	return TRUE;
 }
@@ -896,7 +911,7 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.sdu);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.ucast.io_qos.sdu);
 
 	return TRUE;
 }
@@ -907,7 +922,7 @@ static gboolean get_retransmissions(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.rtn);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ucast.io_qos.rtn);
 
 	return TRUE;
 }
@@ -919,7 +934,7 @@ static gboolean get_latency(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-							&bap->qos.latency);
+							&bap->qos.ucast.io_qos.latency);
 
 	return TRUE;
 }
@@ -930,7 +945,7 @@ static gboolean get_delay(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.delay);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.ucast.delay);
 
 	return TRUE;
 }
@@ -1478,13 +1493,6 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
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
@@ -1555,7 +1563,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 			goto fail;
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
-				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
+				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index f194f466f..573089170 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -120,6 +121,8 @@ struct bt_bap_db {
 	struct bt_ascs *ascs;
 	struct queue *sinks;
 	struct queue *sources;
+	struct queue *broadcast_sources;
+	struct queue *broadcast_sinks;
 };
 
 struct bt_bap_req {
@@ -622,6 +625,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
+static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb)
+{
+	struct bt_bap_endpoint *ep;
+
+	ep = new0(struct bt_bap_endpoint, 1);
+	ep->bdb = bdb;
+	ep->attr = NULL;
+	ep->dir = BT_BAP_BROADCAST_SOURCE;
+
+	return ep;
+}
+
 static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 						struct bt_bap_db *db,
 						struct gatt_db_attribute *attr)
@@ -644,6 +659,26 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 	return ep;
 }
 
+static struct bt_bap_endpoint *bap_get_endpoint_broadcast(struct queue *endpoints,
+						struct bt_bap_db *db)
+{
+	struct bt_bap_endpoint *ep;
+
+	if (!db)
+		return NULL;
+
+	if (queue_length(endpoints) > 0)
+		return queue_peek_head(endpoints);
+
+	ep = bap_endpoint_new_broacast(db);
+	if (!ep)
+		return NULL;
+
+	queue_push_tail(endpoints, ep);
+
+	return ep;
+}
+
 static bool bap_endpoint_match_id(const void *data, const void *match_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -861,15 +896,15 @@ static void stream_notify_qos(struct bt_bap_stream *stream)
 	status->state = ep->state;
 
 	qos = (void *)status->params;
-	qos->cis_id = stream->qos.cis_id;
-	qos->cig_id = stream->qos.cig_id;
-	put_le24(stream->qos.interval, qos->interval);
-	qos->framing = stream->qos.framing;
-	qos->phy = stream->qos.phy;
-	qos->sdu = cpu_to_le16(stream->qos.sdu);
-	qos->rtn = stream->qos.rtn;
-	qos->latency = cpu_to_le16(stream->qos.latency);
-	put_le24(stream->qos.delay, qos->pd);
+	qos->cis_id = stream->qos.ucast.cis_id;
+	qos->cig_id = stream->qos.ucast.cig_id;
+	put_le24(stream->qos.ucast.io_qos.interval, qos->interval);
+	qos->framing = stream->qos.ucast.framing;
+	qos->phy = stream->qos.ucast.io_qos.phy;
+	qos->sdu = cpu_to_le16(stream->qos.ucast.io_qos.sdu);
+	qos->rtn = stream->qos.ucast.io_qos.rtn;
+	qos->latency = cpu_to_le16(stream->qos.ucast.io_qos.latency);
+	put_le24(stream->qos.ucast.delay, qos->pd);
 
 	gatt_db_attribute_notify(ep->attr, (void *) status, len,
 					bt_bap_get_att(stream->bap));
@@ -898,8 +933,8 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	status->state = ep->state;
 
 	meta = (void *)status->params;
-	meta->cis_id = stream->qos.cis_id;
-	meta->cig_id = stream->qos.cig_id;
+	meta->cis_id = stream->qos.ucast.cis_id;
+	meta->cig_id = stream->qos.ucast.cig_id;
 
 	if (stream->meta) {
 		meta->len = stream->meta->iov_len;
@@ -1260,6 +1295,36 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	bt_bap_unref(bap);
 }
 
+static void stream_set_state_broadcast(struct bt_bap_stream *stream, uint8_t state)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+	struct bt_bap *bap = stream->bap;
+	const struct queue_entry *entry;
+
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	bt_bap_ref(bap);
+
+	for (entry = queue_get_entries(bap->state_cbs); entry;
+							entry = entry->next) {
+		struct bt_bap_state *state = entry->data;
+
+		if (state->func)
+			state->func(stream, stream->ep->old_state,
+					stream->ep->state, state->data);
+	}
+
+	/* Post notification updates */
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+		bap_stream_detach(stream);
+		break;
+	}
+
+	bt_bap_unref(bap);
+}
+
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1396,6 +1461,11 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 	if (err)
 		return;
 
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)	{
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+		return;
+	}
+
 	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 }
 
@@ -1575,20 +1645,20 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	memset(&qos, 0, sizeof(qos));
 
-	qos.cig_id = req->cig;
-	qos.cis_id = req->cis;
-	qos.interval = get_le24(req->interval);
-	qos.framing = req->framing;
-	qos.phy = req->phy;
-	qos.sdu = le16_to_cpu(req->sdu);
-	qos.rtn = req->rtn;
-	qos.latency = le16_to_cpu(req->latency);
-	qos.delay = get_le24(req->pd);
+	qos.ucast.cig_id = req->cig;
+	qos.ucast.cis_id = req->cis;
+	qos.ucast.io_qos.interval = get_le24(req->interval);
+	qos.ucast.framing = req->framing;
+	qos.ucast.io_qos.phy = req->phy;
+	qos.ucast.io_qos.sdu = le16_to_cpu(req->sdu);
+	qos.ucast.io_qos.rtn = req->rtn;
+	qos.ucast.io_qos.latency = le16_to_cpu(req->latency);
+	qos.ucast.delay = get_le24(req->pd);
 
 	DBG(bap, "CIG 0x%02x CIS 0x%02x interval %u framing 0x%02x "
 			"phy 0x%02x SDU %u rtn %u latency %u pd %u",
-			req->cig, req->cis, qos.interval, qos.framing, qos.phy,
-			qos.sdu, qos.rtn, qos.latency, qos.delay);
+			req->cig, req->cis, qos.ucast.io_qos.interval, qos.ucast.framing, qos.ucast.io_qos.phy,
+			qos.ucast.io_qos.sdu, qos.ucast.io_qos.rtn, qos.ucast.io_qos.latency, qos.ucast.delay);
 
 	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
@@ -2219,6 +2289,8 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->db = gatt_db_ref(db);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
+	bdb->broadcast_sources = queue_new();
+	bdb->broadcast_sinks = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
@@ -2394,6 +2466,16 @@ static void bap_add_source(struct bt_bap_pac *pac)
 				iov.iov_len, NULL);
 }
 
+static void bap_add_broadcast_source(struct bt_bap_pac *pac)
+{
+	queue_push_tail(pac->bdb->broadcast_sources, pac);
+}
+
+static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
+{
+	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+}
+
 static void notify_pac_added(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
@@ -2415,10 +2497,12 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac;
+	struct bt_bap_pac *pac, *pac_brodcast_sink;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2444,11 +2528,17 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	case BT_BAP_SOURCE:
 		bap_add_source(pac);
 		break;
+	case BT_BAP_BROADCAST_SOURCE:
+		bap_add_broadcast_source(pac);
+		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);
+		bap_add_broadcast_sink(pac_brodcast_sink);
+		break;
 	default:
 		bap_pac_free(pac);
 		return NULL;
 	}
 
+	bt_bap_pac_set_ops(pac, pac_ops, user_data);
 	queue_foreach(sessions, notify_session_pac_added, pac);
 
 	return pac;
@@ -2458,10 +2548,12 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+							data, metadata, pac_ops, user_data);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2486,6 +2578,21 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return BT_BAP_STREAM_TYPE_UNKNOWN;
+
+	if ((bt_bap_pac_get_type(stream->lpac) == BT_BAP_SINK) ||
+		(bt_bap_pac_get_type(stream->lpac) == BT_BAP_SOURCE))
+		return BT_BAP_STREAM_TYPE_UNICAST;
+	else if ((bt_bap_pac_get_type(stream->lpac) == BT_BAP_BROADCAST_SOURCE) ||
+			(bt_bap_pac_get_type(stream->lpac) == BT_BAP_BROADCAST_SINK))
+		return BT_BAP_STREAM_TYPE_BROADCAST;
+	else
+		return BT_BAP_STREAM_TYPE_UNKNOWN;
+}
+
 static void notify_pac_removed(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
@@ -2544,6 +2651,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
+		goto found;
+
 	return false;
 
 found:
@@ -3295,13 +3405,13 @@ static void ep_status_qos(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	if (!ep->stream)
 		return;
 
-	ep->stream->qos.interval = interval;
-	ep->stream->qos.framing = qos->framing;
-	ep->stream->qos.phy = qos->phy;
-	ep->stream->qos.sdu = sdu;
-	ep->stream->qos.rtn = qos->rtn;
-	ep->stream->qos.latency = latency;
-	ep->stream->qos.delay = pd;
+	ep->stream->qos.ucast.io_qos.interval = interval;
+	ep->stream->qos.ucast.framing = qos->framing;
+	ep->stream->qos.ucast.io_qos.phy = qos->phy;
+	ep->stream->qos.ucast.io_qos.sdu = sdu;
+	ep->stream->qos.ucast.io_qos.rtn = qos->rtn;
+	ep->stream->qos.ucast.io_qos.latency = latency;
+	ep->stream->qos.ucast.delay = pd;
 
 	if (ep->old_state == BT_ASCS_ASE_STATE_CONFIG)
 		bap_stream_config_cfm(ep->stream);
@@ -3876,6 +3986,25 @@ clone:
 	return true;
 }
 
+bool bt_bap_attach_broadcast(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	if (queue_find(sessions, NULL, bap))
+		return true;
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, bap);
+
+	ep = bap_get_endpoint_broadcast(bap->remote_eps, bap->ldb);
+	if (ep)
+		ep->bap = bap;
+
+	return true;
+}
+
 static void stream_foreach_detach(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -4080,7 +4209,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 							func, user_data);
 	case BT_BAP_SOURCE:
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
-							func, user_data);
+							   func, user_data);
+	case BT_BAP_BROADCAST_SOURCE:
+		return bap_foreach_pac(bap->ldb->broadcast_sources, bap->ldb->broadcast_sinks,
+								func, user_data);
 	}
 }
 
@@ -4193,42 +4325,49 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	if (!stream->client) {
-		stream_config(stream, data, NULL);
-		return 0;
-	}
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!stream->client) {
+			stream_config(stream, data, NULL);
+			return 0;
+		}
 
-	memset(&config, 0, sizeof(config));
+		memset(&config, 0, sizeof(config));
 
-	config.ase = stream->ep->id;
-	config.latency = qos->target_latency;
-	config.phy = qos->phy;
-	config.codec = stream->rpac->codec;
+		config.ase = stream->ep->id;
+		config.latency = qos->ucast.target_latency;
+		config.phy = qos->ucast.io_qos.phy;
+		config.codec = stream->rpac->codec;
 
-	iov[0].iov_base = &config;
-	iov[0].iov_len = sizeof(config);
+		iov[0].iov_base = &config;
+		iov[0].iov_len = sizeof(config);
 
-	if (data) {
-		if (!bap_print_cc(data->iov_base, data->iov_len,
-					stream->bap->debug_func,
-					stream->bap->debug_data))
-			return 0;
+		if (data) {
+			if (!bap_print_cc(data->iov_base, data->iov_len,
+						stream->bap->debug_func,
+						stream->bap->debug_data))
+				return 0;
 
-		config.cc_len = data->iov_len;
-		iov[1] = *data;
-		iovlen++;
-	}
+			config.cc_len = data->iov_len;
+			iov[1] = *data;
+			iovlen++;
+		}
 
-	req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, user_data);
+		req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, user_data);
 
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
-		return 0;
-	}
+		if (!bap_queue_req(stream->bap, req)) {
+			bap_req_free(req);
+			return 0;
+		}
 
-	stream->qos = *qos;
+		stream->qos = *qos;
 
-	return req->id;
+		return req->id;
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		stream->qos = *qos;
+		return 0;
+	} else {
+		return 0;
+	}
 }
 
 static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -4289,7 +4428,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		if (rpac)
 			type = rpac->type;
 		else if (lpac) {
-			switch(lpac->type) {
+			switch (lpac->type) {
 			case BT_BAP_SINK:
 				type = BT_BAP_SOURCE;
 				break;
@@ -4354,6 +4493,10 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+								ep_config_cb, stream->lpac->user_data);
+
 	return true;
 }
 
@@ -4384,15 +4527,15 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 
 	/* TODO: Figure out how to pass these values around */
 	qos.ase = stream->ep->id;
-	qos.cig = data->cig_id;
-	qos.cis = data->cis_id;
-	put_le24(data->interval, qos.interval);
-	qos.framing = data->framing;
-	qos.phy = data->phy;
-	qos.sdu = cpu_to_le16(data->sdu);
-	qos.rtn = data->rtn;
-	qos.latency = cpu_to_le16(data->latency);
-	put_le24(data->delay, qos.pd);
+	qos.cig = data->ucast.cig_id;
+	qos.cis = data->ucast.cis_id;
+	put_le24(data->ucast.io_qos.interval, qos.interval);
+	qos.framing = data->ucast.framing;
+	qos.phy = data->ucast.io_qos.phy;
+	qos.sdu = cpu_to_le16(data->ucast.io_qos.sdu);
+	qos.rtn = data->ucast.io_qos.rtn;
+	qos.latency = cpu_to_le16(data->ucast.io_qos.latency);
+	put_le24(data->ucast.delay, qos.pd);
 
 	iov.iov_base = &qos;
 	iov.iov_len = sizeof(qos);
@@ -4463,7 +4606,7 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	int ret;
+	int ret = 0;
 
 	/* Table 3.2: ASE state machine transition
 	 * Initiating device - client Only
@@ -4471,12 +4614,17 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 	if (!bap_stream_valid(stream) || !stream->client)
 		return 0;
 
-	ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, func,
-								user_data);
-	if (!ret || !enable_links)
-		return ret;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, func,
+							  user_data);
+		if (!ret || !enable_links)
+			return ret;
 
-	queue_foreach(stream->links, bap_stream_enable_link, metadata);
+		queue_foreach(stream->links, bap_stream_enable_link, metadata);
+	} else if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_STREAMING);
+		return ret = 1;
+	}
 
 	return ret;
 }
@@ -4655,6 +4803,15 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 
 	bap = stream->bap;
 
+	/* If stream is broadcast, no BT_ASCS_RELEASE is required */
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		if (!bap_stream_valid(stream)) {
+			stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_IDLE);
+			stream = NULL;
+		}
+		return 0;
+	}
+
 	/* If stream does not belong to a client session, clean it up now */
 	if (!bap_stream_valid(stream)) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
@@ -4690,8 +4847,11 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 
 	if (stream->ep->dir == BT_BAP_SOURCE)
 		return pacs->source_loc_value;
-	else
+	else if (stream->ep->dir == BT_BAP_SINK)
 		return pacs->sink_loc_value;
+	else
+		// TO DO get the location values from metadata for brodcast source and sink
+		return stream->bap->ldb->pacs->source_loc_value;
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
@@ -4796,8 +4956,8 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 		return -EALREADY;
 
 	if (stream->client != link->client ||
-			stream->qos.cig_id != link->qos.cig_id ||
-			stream->qos.cis_id != link->qos.cis_id)
+			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
+			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
 		return -EINVAL;
 
 	if (!stream->links)
@@ -4834,7 +4994,7 @@ static void bap_stream_get_in_qos(void *data, void *user_data)
 	struct bt_bap_qos **qos = user_data;
 
 	if (!qos || *qos || stream->ep->dir != BT_BAP_SOURCE ||
-						!stream->qos.sdu)
+						!stream->qos.ucast.io_qos.sdu)
 		return;
 
 	*qos = &stream->qos;
@@ -4845,7 +5005,7 @@ static void bap_stream_get_out_qos(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct bt_bap_qos **qos = user_data;
 
-	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK || !stream->qos.sdu)
+	if (!qos || *qos || stream->ep->dir != BT_BAP_SINK || !stream->qos.ucast.io_qos.sdu)
 		return;
 
 	*qos = &stream->qos;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index e9f769d0e..3b07df158 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -14,8 +15,14 @@
 #define __packed __attribute__((packed))
 #endif
 
-#define BT_BAP_SINK			0x01
+#define BT_BAP_SINK				0x01
 #define	BT_BAP_SOURCE			0x02
+#define	BT_BAP_BROADCAST_SOURCE	0x03
+#define	BT_BAP_BROADCAST_SINK	0x04
+
+#define BT_BAP_STREAM_TYPE_UNICAST		0x01
+#define	BT_BAP_STREAM_TYPE_BROADCAST	0x02
+#define	BT_BAP_STREAM_TYPE_UNKNOWN		0x03
 
 #define BT_BAP_STREAM_STATE_IDLE	0x00
 #define BT_BAP_STREAM_STATE_CONFIG	0x01
@@ -49,17 +56,46 @@ struct bt_ltv {
 	uint8_t  value[0];
 } __packed;
 
-struct bt_bap_qos {
+struct bt_bap_io_qos {
+	uint32_t interval;	/* Frame interval */
+	uint16_t latency;	/* Transport Latency */
+	uint16_t sdu;		/* Maximum SDU Size */
+	uint8_t  phy;		/* PHY */
+	uint8_t  rtn;		/* Retransmission Effort */
+};
+
+struct bt_bap_ucast_qos {
 	uint8_t  cig_id;
 	uint8_t  cis_id;
-	uint32_t interval;		/* Frame interval */
 	uint8_t  framing;		/* Frame framing */
-	uint8_t  phy;			/* PHY */
-	uint16_t sdu;			/* Maximum SDU Size */
-	uint8_t  rtn;			/* Retransmission Effort */
-	uint16_t latency;		/* Transport Latency */
 	uint32_t delay;			/* Presentation Delay */
 	uint8_t  target_latency;	/* Target Latency */
+	struct bt_bap_io_qos io_qos;
+};
+
+struct bt_bap_bcast_qos {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_interval;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	struct iovec bcode;
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  mse;
+	uint16_t timeout;
+	uint8_t  pa_sync;
+	struct bt_bap_io_qos io_qos;
+};
+
+struct bt_bap_qos {
+	union {
+			struct bt_bap_ucast_qos ucast;
+			struct bt_bap_bcast_qos bcast;
+		};
 };
 
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
@@ -98,28 +134,32 @@ struct bt_bap_pac_qos {
 	uint32_t ppd_max;
 };
 
+struct bt_bap_pac_ops {
+	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			struct bt_bap_pac_qos *qos,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data);
+	void (*clear)(struct bt_bap_stream *stream, void *user_data);
+};
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data);
 
 struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
-
-struct bt_bap_pac_ops {
-	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
-	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
-			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
-			void *user_data);
-	void (*clear)(struct bt_bap_stream *stream, void *user_data);
-};
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data);
 
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data);
@@ -130,6 +170,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -149,6 +191,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
+bool bt_bap_attach_broadcast(struct bt_bap *bap);
 void bt_bap_detach(struct bt_bap *bap);
 
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
diff --git a/unit/test-bap.c b/unit/test-bap.c
index bf525742d..8d1b3fd52 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -377,11 +377,11 @@ static void test_client_config(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps, NULL, NULL, NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps, NULL, NULL, NULL);
 		g_assert(data->snk);
 	}
 
@@ -391,11 +391,11 @@ static void test_client_config(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps, NULL, NULL, NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps, NULL, NULL, NULL);
 		g_assert(data->src);
 	}
 }
@@ -712,12 +712,15 @@ static void test_disc(void)
 #define QOS_BALANCED_2M \
 	{ \
 		.target_latency = BT_BAP_CONFIG_LATENCY_BALANCED, \
-		.phy = BT_BAP_CONFIG_PHY_2M, \
+		.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
 	}
-
+#define QOS_UCAST \
+{\
+	.ucast = QOS_BALANCED_2M, \
+}
 static struct test_config cfg_snk_8_1 = {
 	.cc = LC3_CONFIG_8_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -727,7 +730,7 @@ static struct test_config cfg_snk_8_1 = {
 
 static struct test_config cfg_snk_8_2 = {
 	.cc = LC3_CONFIG_8_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -737,7 +740,7 @@ static struct test_config cfg_snk_8_2 = {
 
 static struct test_config cfg_snk_16_1 = {
 	.cc = LC3_CONFIG_16_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -747,7 +750,7 @@ static struct test_config cfg_snk_16_1 = {
 
 static struct test_config cfg_snk_16_2 = {
 	.cc = LC3_CONFIG_16_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -757,7 +760,7 @@ static struct test_config cfg_snk_16_2 = {
 
 static struct test_config cfg_snk_24_1 = {
 	.cc = LC3_CONFIG_24_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -767,7 +770,7 @@ static struct test_config cfg_snk_24_1 = {
 
 static struct test_config cfg_snk_24_2 = {
 	.cc = LC3_CONFIG_24_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -777,7 +780,7 @@ static struct test_config cfg_snk_24_2 = {
 
 static struct test_config cfg_snk_32_1 = {
 	.cc = LC3_CONFIG_32_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -787,7 +790,7 @@ static struct test_config cfg_snk_32_1 = {
 
 static struct test_config cfg_snk_32_2 = {
 	.cc = LC3_CONFIG_32_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -797,7 +800,7 @@ static struct test_config cfg_snk_32_2 = {
 
 static struct test_config cfg_snk_44_1 = {
 	.cc = LC3_CONFIG_44_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -807,7 +810,7 @@ static struct test_config cfg_snk_44_1 = {
 
 static struct test_config cfg_snk_44_2 = {
 	.cc = LC3_CONFIG_44_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -817,7 +820,7 @@ static struct test_config cfg_snk_44_2 = {
 
 static struct test_config cfg_snk_48_1 = {
 	.cc = LC3_CONFIG_48_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -827,7 +830,7 @@ static struct test_config cfg_snk_48_1 = {
 
 static struct test_config cfg_snk_48_2 = {
 	.cc = LC3_CONFIG_48_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -837,7 +840,7 @@ static struct test_config cfg_snk_48_2 = {
 
 static struct test_config cfg_snk_48_3 = {
 	.cc = LC3_CONFIG_48_3,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -847,7 +850,7 @@ static struct test_config cfg_snk_48_3 = {
 
 static struct test_config cfg_snk_48_4 = {
 	.cc = LC3_CONFIG_48_4,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -857,7 +860,7 @@ static struct test_config cfg_snk_48_4 = {
 
 static struct test_config cfg_snk_48_5 = {
 	.cc = LC3_CONFIG_48_5,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -867,7 +870,7 @@ static struct test_config cfg_snk_48_5 = {
 
 static struct test_config cfg_snk_48_6 = {
 	.cc = LC3_CONFIG_48_6,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 };
 
@@ -899,7 +902,7 @@ static struct test_config cfg_snk_48_6 = {
 
 static struct test_config cfg_src_8_1 = {
 	.cc = LC3_CONFIG_8_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -909,7 +912,7 @@ static struct test_config cfg_src_8_1 = {
 
 static struct test_config cfg_src_8_2 = {
 	.cc = LC3_CONFIG_8_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -919,7 +922,7 @@ static struct test_config cfg_src_8_2 = {
 
 static struct test_config cfg_src_16_1 = {
 	.cc = LC3_CONFIG_16_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -929,7 +932,7 @@ static struct test_config cfg_src_16_1 = {
 
 static struct test_config cfg_src_16_2 = {
 	.cc = LC3_CONFIG_16_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -939,7 +942,7 @@ static struct test_config cfg_src_16_2 = {
 
 static struct test_config cfg_src_24_1 = {
 	.cc = LC3_CONFIG_24_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -949,7 +952,7 @@ static struct test_config cfg_src_24_1 = {
 
 static struct test_config cfg_src_24_2 = {
 	.cc = LC3_CONFIG_24_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -959,7 +962,7 @@ static struct test_config cfg_src_24_2 = {
 
 static struct test_config cfg_src_32_1 = {
 	.cc = LC3_CONFIG_32_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -969,7 +972,7 @@ static struct test_config cfg_src_32_1 = {
 
 static struct test_config cfg_src_32_2 = {
 	.cc = LC3_CONFIG_32_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -979,7 +982,7 @@ static struct test_config cfg_src_32_2 = {
 
 static struct test_config cfg_src_44_1 = {
 	.cc = LC3_CONFIG_44_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -989,7 +992,7 @@ static struct test_config cfg_src_44_1 = {
 
 static struct test_config cfg_src_44_2 = {
 	.cc = LC3_CONFIG_44_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -999,7 +1002,7 @@ static struct test_config cfg_src_44_2 = {
 
 static struct test_config cfg_src_48_1 = {
 	.cc = LC3_CONFIG_48_1,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1009,7 +1012,7 @@ static struct test_config cfg_src_48_1 = {
 
 static struct test_config cfg_src_48_2 = {
 	.cc = LC3_CONFIG_48_2,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1019,7 +1022,7 @@ static struct test_config cfg_src_48_2 = {
 
 static struct test_config cfg_src_48_3 = {
 	.cc = LC3_CONFIG_48_3,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1029,7 +1032,7 @@ static struct test_config cfg_src_48_3 = {
 
 static struct test_config cfg_src_48_4 = {
 	.cc = LC3_CONFIG_48_4,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1039,7 +1042,7 @@ static struct test_config cfg_src_48_4 = {
 
 static struct test_config cfg_src_48_5 = {
 	.cc = LC3_CONFIG_48_5,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1049,7 +1052,7 @@ static struct test_config cfg_src_48_5 = {
 
 static struct test_config cfg_src_48_6 = {
 	.cc = LC3_CONFIG_48_6,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 };
 
@@ -1141,7 +1144,7 @@ static void test_scc_cc_lc3(void)
 
 static struct test_config cfg_snk_vs = {
 	.cc = IOV_NULL,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.snk = true,
 	.vs = true,
 };
@@ -1155,7 +1158,7 @@ static struct test_config cfg_snk_vs = {
 
 static struct test_config cfg_src_vs = {
 	.cc = IOV_NULL,
-	.qos = QOS_BALANCED_2M,
+	.qos = QOS_UCAST,
 	.src = true,
 	.vs = true,
 };
-- 
2.34.1

