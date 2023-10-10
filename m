Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF0CD8C9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjJJOtd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjJJOtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:49:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6584A99
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctaAHbMwgs0LYQUUoG3o9ZGxOFldQKEoECzLoRiDYP1QriUUMCc35Vhuj1jFXfFYDIaE4NOjDZeFDD1BJaZCsSxyDELzkftZtPas4VjcUbIi/FmSV18Wm/empH+9Iz21010ociCHFu5cLZvLea4fX6KYnsGTQsznbVjJ2omwc4799CBOx7UjbsSHXsNeT7LmU7yYSJ/lzPFcRPjJS266bMiiLl6ZFjZPulAmFDqBjVhzBuRJwFPu+lWpPTV48BbsWTBLHNepHFOAxfTBiEa5qXqF3qxFKtKflH0bimKveD//bMopYRa4v1vQnxrqPRRDJBUNmBQgJqoS7KudS5X+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=IVf4QIoFDeqUPxvH/Kr9F2bdv+w+zsmSmfow8iJdG53cnnqVFR4nET5Z9GQMJHjc9NbLN0bfnzAtt2uTKQIhtsNn806VBDHlWaumRxpcU7rJqPgBXm2jihc5BuH3ZtUmeUnfUWXOyfxKzVAw4WgqH/s+lqlGNiu0JB+Uo8YQUpip8snONhpynw6CyLCHvpn68/znSHDaD/TSMy9YxoDBUYyCteQppy86JGONHp0PHUIqTDffPFMPLZLKOjkNpySuJllVD841J2w/l8DnLk1xbnWeEvu4+s2Sn7UEQUpuOP6BV/0VSdFLRxLq1CilWWrvGnAGw4HeCngZcyxyJ4l86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=ftzd0PZJZd3VtbIjiVP9D7GnyaPZ4y8viet+MJ1OkIDfjU/kqy2H+okJY+y3S1bUAyKYuwU7vB/TwUxtNt2zxHWknIM10tW3ZhVpTP6dSdOoZmpNieoywUX34YCt0XQtlUgk8+BmkSXC+fuBaAKpXz7TFpuR3B77BZL4lHFj5Sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:49:26 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:49:26 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/2] transport: Update transport release flow for bcast src
Date:   Tue, 10 Oct 2023 17:49:16 +0300
Message-Id: <20231010144917.4400-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010144917.4400-1-silviu.barbulescu@nxp.com>
References: <20231010144917.4400-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc024cb-5d6c-4ea5-d596-08dbc9a0193a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk7wH7u2V8i8/kKTqxa55xuAFU3IhL3j2p7sBTcLm/sr7S/p/DVPvEI7nx9Hc6rzcLD4ttHqWvCE8LpGHfb5SdARMjg6LYZyELmP4z6ezVUzHvqrsI4QLmDwHVF4cnBZIkqqEyabXjkIhom7O7AIVx7FRHubEBuS9o6JRStZ/UP9BzsqN1UONipPP4VeY1X6RWnZftGDzoc4jv9IQogvM7hzwORo1ecPysxsecsrCfpuojauBW0DVYlLS6KQCYhx6J7/H0cv6CGS9A/+NfMmDUd6O2tILeE7dadvtYJGiMMOfU6fz6uIosRUlNWSHy8GhBCSyuRJSD3W8+XYfhXgD/8QW3wOx+AAHiU+zAcFgvYFUUjjkrNmFUURwC5aUXM0hAAGVkqBhiYhiWPkaN5YtvkwrLluVcXjjqcYKjed3/VvoqJZP1+uIU0GbMv73+57BiPuLZj4BFx3YU1y7/w/QgyEeRxj8S9QHmzb/EON+MKqUgFZvOc9FgPxz5qlp+RCO29VQCUMAnSHih+xrzC+obQ7+53zdyak+MJ+56XuOzvjxw2I/XmbQ/UYpisK2wk0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(1076003)(6506007)(2616005)(478600001)(6486002)(6666004)(83380400001)(26005)(15650500001)(2906002)(5660300002)(66556008)(66476007)(66946007)(6916009)(8676002)(8936002)(4326008)(316002)(41300700001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APLSy/cpazNwisUxbSb5nXeJ8AA7QrN7LjZlw2bZGXofBbxyJ9mroyrF+ZQm?=
 =?us-ascii?Q?zFAPa883lLU7Q5zHxPyFRfCT0EWZvVHCTx6ArIgBDNv3cc382BYn422B23oV?=
 =?us-ascii?Q?jgvYYADGxiRHBGPHNFIQRTWGIEXQkAo21Tp6eSSC/N5oTRGVlaOg65nCbLaS?=
 =?us-ascii?Q?hTeX6ftYZ7Jc/am7mbQ5T/hF2snfCgKL1K8K5XANn2QNJrrNFkTB2JdHSp89?=
 =?us-ascii?Q?ye93RJ4M0AkhirX7VHlJqHWb4mAhHoMLXRwV4h5kNZasf1tUFHqqkapPPAQg?=
 =?us-ascii?Q?l3LtnHMdpdivQo68u9mQvYvB8PwuYxM2hMgXwBvvl5UzfzJTZgi2Za0WnUEh?=
 =?us-ascii?Q?//xA2Pal31GTWzJvkw23bm9qSBhac/265xCbfzbYtC7L4noGNoVi2zSN/4FV?=
 =?us-ascii?Q?I+ehbaOrGQ7RVlPgaLAVktCRAzJCDiI+WFAowl347X3/jTg/X/Ol+2qMAwa0?=
 =?us-ascii?Q?RJIKBMSsGdlnh1kYnPU0P4n6WHfvHtZdua7yVR5ucRYweomALPAt+08VSHM6?=
 =?us-ascii?Q?vnQvjW6a9XuQ7Vly7hd3nZGUKiqwZkseyg8CNrwOwrLdgoeMIzusYYZpn3el?=
 =?us-ascii?Q?U6WOU6/obN5AN9irmRYTDzs2tMKCcKxViDhHDAumzzpe/DRZbrFJ5zXy9uOe?=
 =?us-ascii?Q?gjKyhwc58eFaUSYGXpnA9U5xrntWXIhPcopaXCCMbgeoai7/ziSeAnWrZ8Mb?=
 =?us-ascii?Q?1tJl8PQ+j+8l88cSuTzn788HG34aysePluumlqzK9v06sqIDjfCrof8AKxYo?=
 =?us-ascii?Q?xxhonTwavLDTLmnKAlm/umWo8PPIAoaewHkLrHdYd3bVt3AWF1l3pizuUrkk?=
 =?us-ascii?Q?FUB4i0qT05QchtH8OsbOxDTxbeqVGgRFLLj0iWUT2akl8hCg3ah6eg8e4RbY?=
 =?us-ascii?Q?Dc3b0gJHvnqpepMBRPd5HJADLXYQtitAo3xtEpluJK+vYGAhvWe6UNc4XMUV?=
 =?us-ascii?Q?feVvEx1+P/MOurn8hTUMhXun8xJ1O5leOKr7HgxydQtKucchFsUYj2UpsH0d?=
 =?us-ascii?Q?Td4nTnR8qeRK+45/WGut6svQ+1QYDNZRSzlXcGfNHoh17DDM9cbrzyKikkTq?=
 =?us-ascii?Q?qHuO8Uj4Ur8xcFj6lqz6+hbWtoufmWwQyUSSnKieSc/MwBUOhTsX1Jl+tj+c?=
 =?us-ascii?Q?G4+qAPaLvW9EQWX1bsTGS4YqsYCgOvcmmj3pkHs4LAA33XLjL8IPqZOEspBJ?=
 =?us-ascii?Q?ggIwmTDpJTqx+unxEniPe7f0urrVUUAINr3oCu5bVzFmWEbzESHK3nceZXDs?=
 =?us-ascii?Q?Ap+59zkRAJRja4cBU3svxNXZ7F2iPmyM7e7vMmh8nySQ9anWDumTmp08rYg7?=
 =?us-ascii?Q?tiz9S8m/0UQaVrLMw02qvf+gb70Jw7V4oxsQ82tkSQ8eDTOZyx83ibiaui5C?=
 =?us-ascii?Q?FhZh+3GijAwJPOMwxHDWdRCsnkWi4VrgFUzNNQOAbp4+cFgpRB1n2iC7Rw5i?=
 =?us-ascii?Q?wt/J7A7plVv8mnuvejkDVDmilCiGADOfZ1kX2OSAF86it6Crcl6J6BOSariH?=
 =?us-ascii?Q?cCeYckfFwmAhDJMphI01lCs1iaDlwnODcU8i4u33xPWdbvbg8DSNXGKY9d/J?=
 =?us-ascii?Q?tfjpOd5sotZcK8stpxRSnASmrcYuVjVK6otsxgFB8CoqlA1im63wAALCHkty?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc024cb-5d6c-4ea5-d596-08dbc9a0193a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:49:26.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UDPRdLCeo8SztVEoWiIni3G6zPlV23d54tK4Bcsipl8HW2vGTUTCvwXMdyUdln6rJxQM2uE/3TUyBhBwCEEE9Mrwkzn3HXgf6g6WaMVJEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport release flow for broadcast source

---
 profiles/audio/transport.c | 65 ++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1e03b7b51..23ea267f6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -606,11 +606,38 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void bap_stop_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_request *req = owner->pending;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (req) {
+		req->id = 0;
+		media_request_reply(req, 0);
+		media_owner_remove(owner);
+	}
+
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	media_transport_remove_owner(transport);
+}
+
+static void bap_disable_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	bap_stop_complete(stream, code, reason, user_data);
+}
+
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner = transport->owner;
+	struct bap_transport *bap = transport->data;
 	const char *sender;
 	struct media_request *req;
 	guint id;
@@ -642,6 +669,11 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 
+	if (bt_bap_stream_get_type(bap->stream) ==
+			BT_BAP_STREAM_TYPE_BCAST) {
+		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+	}
+
 	return NULL;
 }
 
@@ -1370,32 +1402,6 @@ static guint resume_bap(struct media_transport *transport,
 	return id;
 }
 
-static void bap_stop_complete(struct bt_bap_stream *stream,
-					uint8_t code, uint8_t reason,
-					void *user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_request *req = owner->pending;
-	struct media_transport *transport = owner->transport;
-
-	/* Release always succeeds */
-	if (req) {
-		req->id = 0;
-		media_request_reply(req, 0);
-		media_owner_remove(owner);
-	}
-
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove_owner(transport);
-}
-
-static void bap_disable_complete(struct bt_bap_stream *stream,
-					uint8_t code, uint8_t reason,
-					void *user_data)
-{
-	bap_stop_complete(stream, code, reason, user_data);
-}
-
 static guint suspend_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1499,9 +1505,14 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+		if ((bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE) ||
+			(bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK))
 			bap_update_bcast_qos(transport);
 		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+			return;
+		break;
 	}
 
 	io = bt_bap_stream_get_io(stream);
-- 
2.39.2

