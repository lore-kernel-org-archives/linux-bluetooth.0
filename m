Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB7EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGLMX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLMX5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:23:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B229B
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvvjj6zvC8RRUK2gg4u+dio3Jol+euUtjor2CrvnAuceP6XL+ViWTaQGrOHLmMxBH0HbvsJvAnuDzocixxyiSPl93kkVFvVwAUJk/NfmFAM21DE3Bio3HoKqZA+jaT235S7TUFy2yJ2gBIkY3fMO0mi9WGRofxS8o5YbsQHITVsaQP3ymVjUBlu1lKKam+57732VQwKH7SBR1fs1eHnUEa4k3XWo5RGYcehHS8w+wU+Rf4xh+mRT9uBqkDBE49ek+sBWGq99pfO3y9SikRvlnuXgFPl3QBC1Aln6tONJrHjGW1g0n0/xNcacPW0QtbHUIEh9WzYqPKsTZpEQbT3P+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qa+Zv59T5at1q/7+/NR2AHwZmstxZ56OkMcQTuu3U8=;
 b=iHqAv2RVhNB1jT4KC7ZACVlSsQm1/d8wpJA5v6oOngenYwcJ78v1bJnra6XdrSGhy7e4whIkbjPTj6TqgOqqWhqlng/5mySIG+MSm026ctatimKszaHEXHS/ZLx06z7tPKIhS6V5PQIs72wxOgmYBHA11KtNUKrDCcJiA4jwRJkCGk3GBfBqSFcbGcMKun0bBKQCe3Au4JUcErInT1DBLApxD0jtXcuKQV1/iMB6KKGmv3QonjuRTHUHUZhl0/SZzdvYh0a48JxtgO9VJJg5EdrvqrD8B2rIrPHNcGah9wt/vgFooVj10b1szdZf0s6d/kPjSQuqjvfTdWKgC85Nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qa+Zv59T5at1q/7+/NR2AHwZmstxZ56OkMcQTuu3U8=;
 b=WpdZ6PXQwHdE1FqDWfPwlmdinFgnFgvmEZCHPgtvKS15f8HGlIGzARLLsireqPssbYSnIkwSz/5e5791cYrfGhPW6fctY8o2ZE2WENy0jWl389DUAwBGXwzJypAixX6o+JCx8ExLiTpqsHbJOFobKMDl+pQCiecq5xJVWE7DaiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:23:54 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:23:54 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 3/6] media: Add broadcast sink media endpoint
Date:   Wed, 12 Jul 2023 15:21:32 +0300
Message-Id: <20230712122135.7734-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712122135.7734-1-claudia.rosu@nxp.com>
References: <20230712122135.7734-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e61f009-dddc-4f75-e6bb-08db82d2db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxac9izwFnQ7ahsDlnY09vJ689qsiR8wDScjfjX7Pug92RI7VF+GqC7DLMVuxZd7fnu2ecGnui3WzUmgYwk5ciQ5cRqvkqKGTgoo78xjXXv7U/Wesg5YNsvzkCrpLEuUwHvwWSLC87ppSRR8Zp9XaBUXpSDOGok3JPiExA3UoXKDxUESGWvEbxhh5v0enOHleV7Ls0QLQ1YA1u9g4jLfsD/WhXXxXB87c9aXaYW5yufp8rma0pOVE2deY6voWfqV0CEecl1BMZc0koqCI7woAQ6YTk7g7yoDIzxOBexutGrwsX7ue3xy0Q8CL9UJHUSHBxxbcO3R5dg7UGyKU9zKvU4d0HgA/3xn8LhDflHLrMwL7JExvH6OqcGeXknpzAWhbdnp+dNVk89Mkl0/b86Ix4M7jpRfQBxN0SehaJ5SQUr5kgs1Z94tKI0RSVKJnWCLGfLLl1xPZGw933diUsmWJATpk9+hewefU8xe7Ao8CNW7Y8aoGp0MxP0eAZI3zu4bg55cEQI9UYQUzQ9WZKIcnrivHG2HqSOSyIfEgytZjLw594QYFWWpLjmH6H/+AbCwqPvdDniMlgdh7Jpf2XxjnPSPzI8FeboQaKXnejJ9IXUX1LRyQhCVbN3NQhZ2UWrB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(38100700002)(38350700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(66476007)(4326008)(6916009)(66556008)(66946007)(6666004)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(1076003)(6506007)(55236004)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AqzYA2g+ppwQoGER5AYB0WnSK/fUwO4jH+ALUdVb0r9wsiSnN8wHpgqORH1K?=
 =?us-ascii?Q?OpLdCjVDQdkfq+7y0ShL3aJBofR8MNx/LAzQMfPkTZASlrOSHSAOgYEBqYYQ?=
 =?us-ascii?Q?PnMyM3rFPs7AQPy3S7No1/fK9S5DlZMos/5iEcVixwW2nypfNa3grcy2cmok?=
 =?us-ascii?Q?/7AARs3xgF4zqScH/GpkpBxr0EzjNNiDK1OUjzRtAY7BsKPSP0a4Erx3l7l/?=
 =?us-ascii?Q?CaDih4FxSsz7+2PUnPiuuL1HqQIZY0KENw//ZumOtQ3m3EsjwGArWfdyl5ta?=
 =?us-ascii?Q?Ban+3MnIG3WQ9tJh0QnDo6tx0gEaInSU70TDTynm9uu6yVFaCM3XfeuA1NMZ?=
 =?us-ascii?Q?/esqllWgYF/aJwb/ag1jz1fiiMKIek/t6QecRZPBHRPKlVjQzkQEzvRevixQ?=
 =?us-ascii?Q?CADJv035/jyjU9XJAvX+szUKAMkR5LcDDonllel2jmMJWpXeb0L02IlHquo0?=
 =?us-ascii?Q?CbWiJppRRA+8VnAdTSL9/RuhEvloRwrcq7EImmBztyrgCF7t01Nha0rr2fFI?=
 =?us-ascii?Q?u/raK6OeE3PWd16MXCObicU61JvtadZ+JRyK4THA/QSitW9/GUTKxv36giK4?=
 =?us-ascii?Q?13OZ/dXyQKBPLAmgIq71WyY+jxEd0IFssYJAOB6ahBsinftPyRrcParSEbYj?=
 =?us-ascii?Q?dMlkv/8t7oEnwaaZci2VEpzPo+uw57jN4ss62JhxgXkxsqMWsqv41wEH7xA7?=
 =?us-ascii?Q?kMgYUaf3h2mDmOZAZrFjtlROr2Nt68p7A3P3NwqEN5ppB9Hs4zA+GCLX+Mxo?=
 =?us-ascii?Q?zQvWMsd3R8UGxX7u/3ub+MjBqFXpjOhG+scrw1xUQqD7iZE8eY84SoWcLCjA?=
 =?us-ascii?Q?szj9QfeiQxr12qlSFKc3p6u1jJxauf4M+El4TuF/m/+DI4k3x/V9GwSdHvej?=
 =?us-ascii?Q?MJk5JssW8n+qgiQ1xN4VsHXFl4eawXDtd9RaMDgqoWfkaVl5T//eNAKLyzdR?=
 =?us-ascii?Q?sa5dm2ho6u+im1vGxykHDTR6Td7mZG1l39BTwtz268s91XiqdOFJLqKxGX/9?=
 =?us-ascii?Q?hHVTqeQJFCLU40CQvGbQ88I5D2pAYxBaoY1p4MMmmjCQJ7lKa7Z7rz3xbOp3?=
 =?us-ascii?Q?AskDH1J53w2Lj0NGUj7C4EOkWDLVwk1l7b/LM7a+fHqzQfkkGW/EuCh03NYT?=
 =?us-ascii?Q?tepLnQqJat+IIGMbAswcXq7RuwfigZ9/AsmeZWLTzVGy9h86z3w4dewf+QzS?=
 =?us-ascii?Q?wns+zafAEI/+KZisPM12cETyNXRVtiJg4lOPA4MIYP95Iy0g6NbI1wGFvhvm?=
 =?us-ascii?Q?T+uqjyZ1EvFv+f8lKDev129WBBYFilFjFUKY1ujErtbmAcl19inkWiRg8wrA?=
 =?us-ascii?Q?8rLgDU5DZQLn3hcCmzFitxkQ+t2rR/t8Af3iod3XikijzObcoZPeHHuL73sQ?=
 =?us-ascii?Q?u/EhqNNUBxvoQmIEj90MqxR8bCquZO/433gFLNl1ehUdSF9Ij8ouwgSfzw1Z?=
 =?us-ascii?Q?5eBh+ZxFrbyu1jPVHBkhDA65FLyxVimsl8mpjcv+7k/tJGXslxWDDn0npd+i?=
 =?us-ascii?Q?jsWenlEFhyyvL6O30stkhwI2Dr7M20GSbu7ZmUUGJVD5Vo5HHjX0fc21xVFG?=
 =?us-ascii?Q?JKoOv41DX/2sbPaEjAP9aNVDfRxpgBG3wiAdhCVzmI9uxs3V5TMo01Yww07c?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e61f009-dddc-4f75-e6bb-08db82d2db99
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:23:54.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvuYwea0L5ZW1AxwyJE8WB606e/iM7qv29htQ8d8FGH0B+Bbvu9VAjnrvMlu4mKjFHWXiBf44mlkN12ptOMbkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.

---
 profiles/audio/media.c | 35 ++++++++++++++++++++++++++++-------
 profiles/audio/media.h |  2 +-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bcf4eae26..d529a4f60 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -105,6 +105,7 @@ struct media_endpoint {
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
+	bool			broadcast;
 };
 
 struct media_player {
@@ -1224,6 +1225,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 static bool endpoint_init_pac_sink(struct media_endpoint *endpoint, int *err)
 {
+	if (endpoint->broadcast)
+		return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
+
 	return endpoint_init_pac(endpoint, BT_BAP_SINK, err);
 }
 
@@ -1333,8 +1337,10 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
 		return false;
 
-	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_CIS_CENTRAL |
+	if ((!btd_adapter_has_settings(adapter, MGMT_SETTING_CIS_CENTRAL |
 					MGMT_SETTING_CIS_PERIPHERAL))
+		&& (!btd_adapter_has_settings(adapter,
+					MGMT_SETTING_ISO_SYNC_RECEIVER)))
 		return false;
 
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
@@ -1382,6 +1388,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						bool broadcast,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1397,6 +1404,7 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->cid = cid;
 	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
+	endpoint->broadcast = broadcast;
 
 	if (qos)
 		endpoint->qos = *qos;
@@ -1462,7 +1470,8 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				uint16_t *cid, uint16_t *vid,
 				struct bt_bap_pac_qos *qos,
 				uint8_t **capabilities, int *size,
-				uint8_t **metadata, int *metadata_size)
+				uint8_t **metadata, int *metadata_size,
+				bool *broadcast)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1546,6 +1555,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Broadcast") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, broadcast);
 		}
 
 		dbus_message_iter_next(props);
@@ -1569,6 +1582,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	uint8_t *metadata = NULL;
 	int size = 0;
 	int metadata_size = 0;
+	bool broadcast = false;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1587,13 +1601,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
 			&vid, &qos, &capabilities, &size, &metadata,
-			&metadata_size) < 0)
+			&metadata_size, &broadcast) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-					codec, cid, vid, &qos, capabilities,
-					size, metadata, metadata_size,
-					&err) == NULL) {
+				codec, cid, vid, &qos, capabilities,
+				size, metadata, metadata_size, broadcast,
+				&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
@@ -2627,6 +2641,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int metadata_size = 0;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
+	bool broadcast = false;
 
 	if (app->err)
 		return;
@@ -2741,7 +2756,7 @@ static void app_register_endpoint(void *data, void *user_data)
 						vendor.cid, vendor.vid, &qos,
 						capabilities, size,
 						metadata, metadata_size,
-						&app->err);
+						broadcast, &app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
@@ -3245,3 +3260,9 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 {
 	return endpoint->adapter->btd_adapter;
 }
+
+bool media_endpoint_is_broadcast(
+	struct media_endpoint *endpoint)
+{
+	return endpoint->broadcast;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1de84a8ff..2b579877b 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -22,5 +22,5 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
-
+bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
-- 
2.34.1

