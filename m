Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F024EE7FF4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 07:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjIKHtV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjIKHtT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 03:49:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD44CE0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duv42eWWoQhwjmUeWt0sD22L0RCxgG1gcWWME3lAPvJ3O2a32EozpfjfIlrF6kX1x5b4smF6zixUScmC/lwnOC3R+yxrE4zR1G23GqUw62wqhc+zBf0bhyhB1J4G2OqqdAskvjzkEIk+DTyOXyzh/4ZFOu381bqKlgm0rgXS7PZNdangMlHjXPSO0TC+eYJ4KehQ9TGLj3oOUqeK96QjG70hef0vn1VVOv82MDYxu0lGQh7K2v+BgQhfj/e54C6LUCfVcT85uS94fTw1HG14wPMTBuRUKcybbWh4g7bjuraHGKMQj5PzdWqoSpBmdO2gqXoNsSD54fcEcfDYXyATsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyUqSDRdn1RXznAn/2YMacldZc54mKVRSE8QWr3tqaE=;
 b=bDXOHbs34l3kOb0n6sMKKs3OhYzgMDxdJO5xN5Cluy7L+Ntm/VmZVECew4Y+9d/9RbIBY89Ml7BmIAKn8s7rsf0NlJ3YlQfnkewm5ipmSzrr1L0h+WRzGiiIAoWqosVq9zFlh316OdsyMAdxdxBKIkGlABLKpwZ4+HtZiUEbvTnV76fGHhwiIcPfQjScjB8HBgYoF+VLR3rmP/gEkQabf1o5GVKdCQ533wj2A2Tdtl1fEnKjWmOcEyppNzhB7iZuXCUkC9futswFAtHsnHpffPt/vjAnf/8vAoSsBl5bkcwGZIyHBwGV/HGXY2nPOe6LOtZJLG2n5ukVQOS/MUPAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyUqSDRdn1RXznAn/2YMacldZc54mKVRSE8QWr3tqaE=;
 b=JCsgPp3p5N4dxfPv7x1+VR5wfvYx065PHEKgP/sRGFzuQyYLltJhp/4ZaowCy4Ms9VsMFYlDC4h5lstEZ2pf7b858AG7X5SOyZAKANqhoGV0ryRf2ec5V8A2TRcQWTMFCI/8TdrnpyPMS7F1N7pEayMjEi/G7sXoFYjlYFJKYi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 07:47:32 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:47:32 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com,
        luiz.dentz@gmail.com
Subject: [PATCH 1/2] shared/bap:Update stream enable/disable flow bcast source
Date:   Mon, 11 Sep 2023 10:47:10 +0300
Message-Id: <20230911074711.62493-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911074711.62493-1-silviu.barbulescu@nxp.com>
References: <20230911074711.62493-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9a9d96-2150-41e5-f6cd-08dbb29b5b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDO4rZb0IT+pMr4BQkyz0+8bhJROFHiKOGsvJ5f5NhYLwX3DooDOtFmhOfwKd6UriA35+js4OzYbvxodUkfvQ6q+z5k2ZcQX5Zc1zmGvHeMZoJxjrk5rZZURdO1vORFFMrB6U5+zsRGCXkgCMVWDNUJxUJUm9bHwJipWvdRIVOgNxLCfciFuscUIHOhYCVlB06vL3HGJVFmUQMI9SEImI5Ai/tVWsIkVEL2R0RGCDP9ENKRoysGl8yEFOIaT7fkpjRoBMucStL0T2iX6jFXpJDxOv6ui8gIiEKZRymmETRGOsEATMZUv2zclqQmK/Rpln9gNC0GqVo5eCPi+8/Js9RPFUrlmSUHvAKxpLBnTkAMyhbqpV6qyGcWapVygiOMRfmRqKA3+7RbGOqtHX/iUUG8HxjiMznef8p+/Tjde0kqG6IJJchkXEx8sZOB8i0ukhv0RKGV/x5mf09BwzGdFSjT9Xd5EWVWTUhHNO7ros+9F79MzeoTK/B6iKNeTFX98XtDMdQXPRJn7M68UfNJbJH4QNA1Y8yOGPFV5wxbfwlgm2RNXxE3YmzpsqSDzSH6qvoOSh2ixkCo2mEV4go54c45cpQPg1P7hd0WJy+LMHkWVaEpQzO/UVApkDZFIt2Ei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(52116002)(6486002)(6666004)(6506007)(86362001)(36756003)(38350700002)(38100700002)(1076003)(2616005)(26005)(15650500001)(6512007)(83380400001)(478600001)(41300700001)(4326008)(316002)(2906002)(8936002)(8676002)(5660300002)(66476007)(6916009)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUg+6Q5WoURPR7JH8gLho3bU2k6lCIrdoWCbDkqvanjUyKA+6ThtNX62qgEJ?=
 =?us-ascii?Q?5rLEnLEGx74RbE+9FOcsUno3qqHX9oTJjM5CmiXJ2I0d13BrPngtLDcU1s4E?=
 =?us-ascii?Q?EfO4xsjqL3wJxMWTaShPxXz6NFE7a3hnyKa/UWX/8LDYoevcM1qnzBE1XRfm?=
 =?us-ascii?Q?Dcq/q4HVaYc72+qthTrz3gDK1+QUPKUbLXSrjia0Z1+45dqbO8QsEMZZaTcl?=
 =?us-ascii?Q?7zoM8ux7HgIPv4qTiwn3hpkEdJ/bWBzCNovKbwg3sFq9qrwauyJkuqF+L3qu?=
 =?us-ascii?Q?SqlTG+s0vxj1BGW9fMxxVwOlpdRySfWjSGRBPcNO3dJndiwaLmGTntS/yTw3?=
 =?us-ascii?Q?KAV/suPDs6X9mEVIgVtEG4kZO+eaaxnTfJ7174vAMzVwkCDFIHPxUggXGxVH?=
 =?us-ascii?Q?RJ2HFp06xIzDfbFUzYF9ikBMZBaFIicKIUnbMUKUvoFNNbQoL6N8unzQaNso?=
 =?us-ascii?Q?aihnvugxl1e36DbLLnaGH2TR39L3rsjykeKNNOXS2Y4GbGB0ByUc5LoVGmcP?=
 =?us-ascii?Q?2aAGeKG4w0bDFWekXUNDewcZzrA9JydZ1bzMEYwR0lnWsgjoN9kJCf12pniQ?=
 =?us-ascii?Q?f/G93j5ZjFANazGTLlCjyEGyC7wMa3hhrJ0jELyZJqQWo+4g7gJNG3+Zk8JP?=
 =?us-ascii?Q?DJo+2kL1P5zG9F4guPJvmc20Nfd0NJERyYMXoF6utXj1fSD64n3ma8/oQay8?=
 =?us-ascii?Q?euMzFaB+hFW/Kp1cSd1pBqDS58tijjg+zm7QjczRorIYo7V1j9TWJeU0DDVJ?=
 =?us-ascii?Q?Ib0B0VW8aDOz937k4FzkuS+AFnuuWbHKIDx3jTMVz+G1kFSB4NkOq3oCqzCk?=
 =?us-ascii?Q?lDoT+R2YTcq1I/o4jMM+iZYsH3rg0ZtylTKVI9utjwJbirethehYgF+Cz8kb?=
 =?us-ascii?Q?4yKsfETeFq+KqJCaqHmClf2/AzNrEhnR3xRUWCEgdAplshOcrVDiqypSUNeN?=
 =?us-ascii?Q?9CN74qHwHP3T4krpUOEBhSE91QWg3Cbf8gE7yOAXq6vm+Fnt+NTOfB75tdws?=
 =?us-ascii?Q?JREW/HH+gbIhYsaCAgBP6tj9kK6lnnkqLYlLeqT+JCxdYH1WSDRBdGKnKgZE?=
 =?us-ascii?Q?OIfkXbMwXE16ahCZeWhBLpfemMm91nocIIFWVDXdjM7GWZtipqA9KMeokBUJ?=
 =?us-ascii?Q?SAXYEL5LEWPSfUmKBquxH42qNlKwRxxPdCl+wFsQqb5hldnkpeeAW27njt8u?=
 =?us-ascii?Q?sSMhmS183mo9f+NFdgILQpPNYpcuQPR97fakZAVBZapm/d8+IbxN9MMavXUL?=
 =?us-ascii?Q?qf9imqjGr3u6PgLiUgEgjVpMncC6UGbMFUFXYhMB/hVGF1ERMc6TZmjSOocU?=
 =?us-ascii?Q?Vu+AWkldkE2/HEqW0bJajN+YCLD2MLjEJB3W+dI2Fgp0H8rPVArNwY2j26A9?=
 =?us-ascii?Q?WXz3DL8lEYYpR8jxf1OCHS4xTcSzQTDnsn6JNedQMZS6s2uCCOvL+cmAXE9a?=
 =?us-ascii?Q?+Wtln4UX4zpvyk5EywFl1oBhsnTOI40wOcVqL/GkcXssMSJhbgyFRbSJxjlX?=
 =?us-ascii?Q?2O2baUyeRH/NlpMKBgLtiO3DS7bfc8MT76tiOaS2F+4lPtbynp7a0iI6Mhjp?=
 =?us-ascii?Q?+Qv2XS/vCX+rQi+oCkTis1v/5JUg2s3pEWcpncXNnwPVqJ2yyRpii6poPKsp?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9a9d96-2150-41e5-f6cd-08dbb29b5b5e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:47:32.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J8BLYlqsGvU++13qoeD2FSW82zrd2SZuJb3dHvYajlnTuSFqxEhWe/y9W4NLMjjnI07tz43HOeUJWLrj+k8+cUlweV2jS3ylIvcUXwWeKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update stream enable/disable flow for BAP broadcast source

---
 src/shared/bap.c | 51 +++++++++++++++++++++++++++++++++++-------------
 src/shared/bap.h |  2 ++
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1c43680c2..801716dd9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1331,6 +1331,11 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	ep->old_state = ep->state;
 	ep->state = state;
 
+	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
 	bt_bap_ref(bap);
 
 	for (entry = queue_get_entries(bap->state_cbs); entry;
@@ -1492,7 +1497,7 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 		return;
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_QOS);
 		return;
 	}
 
@@ -4698,13 +4703,19 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_STREAMING);
+					BT_BAP_STREAM_STATE_CONFIG);
 		return 1;
 	}
 
 	return ret;
 }
 
+void bt_bap_stream_streaming(struct bt_bap_stream *stream)
+{
+		stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_STREAMING);
+}
+
 unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -4779,24 +4790,36 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 		return 0;
 	}
 
-	memset(&disable, 0, sizeof(disable));
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		memset(&disable, 0, sizeof(disable));
 
-	disable.ase = stream->ep->id;
+		disable.ase = stream->ep->id;
 
-	iov.iov_base = &disable;
-	iov.iov_len = sizeof(disable);
+		iov.iov_base = &disable;
+		iov.iov_len = sizeof(disable);
 
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func, user_data);
+		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func,
+							user_data);
 
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
-		return 0;
-	}
+		if (!bap_queue_req(stream->bap, req)) {
+			bap_req_free(req);
+			return 0;
+		}
 
-	if (disable_links)
-		queue_foreach(stream->links, bap_stream_disable_link, NULL);
+		if (disable_links)
+			queue_foreach(stream->links, bap_stream_disable_link,
+							NULL);
 
-	return req->id;
+		return req->id;
+
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_RELEASING);
+		return 1;
+	}
+
+	return 0;
 }
 
 unsigned int bt_bap_stream_stop(struct bt_bap_stream *stream,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index edb5c1bed..d3c9b241e 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -264,6 +264,8 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data);
 
+void bt_bap_stream_streaming(struct bt_bap_stream *stream);
+
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
-- 
2.34.1

