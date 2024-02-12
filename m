Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C03C48D
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751968; cv=fail; b=lEOtExE9S3D3ptyZs7/CWUe3pkoiEk4YeF9JixDoaBnGvGeobDD1ToJg0M5qEeulN6kcRy5PqQ80Zp6wUsu6fsXRBdfbFtsg0fGmIyXSIMpZ+v6VzHzCRQjKi5oJZmoIWm8DptZZ9bNScsmpcbd4sUXCklyEXbZZJ6cJNQmVADU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751968; c=relaxed/simple;
	bh=rQ2BK9wSZZBW4MU+ZjzMmowPBHtl+yKtF7KYLy0f0rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXfxufajAiFw6Mah2a42aVD84jmir32IJuLMwZM08YLQK/IikKoKgfj7ankzpkww1/iS+KWSBdN1sIu8cHlKvf47Zsd9xoLMMc1274reDg5P55tImOqiFtrx5WL+RLE3/5sSNsdXz6npcGa8Qi8pTgATApLxXhK4d/BkleVbNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dPqkRRAk; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dPqkRRAk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCo3hjrxMdHpK2kVmhLeWQnlcc+3WWzKz9G32BnGvuOpGBYS39o+KNzFxrRZO0ot5QQAKTmQrt011d5HzPm/wnH4XgCzORYBd5muvtdnwejv1Ra3UqHPyagbXKqlG8gn4OZEio+BFzxHXbi4S/e51JDA+I06W1w+hG7cnmcQ1rmVeFXNP//6XSceGEXZHXzuskoJc3b6UloeSBAGXVJaSRXgQBT2RXF9qaWA2rB2Rp+qDdQGY0n4EQu1yT+pAO54mxlykjkGS/T0F80b+Ik3G9MLQvSEhCB1y6KiYuar5mJhg33gnjlgONBbHwHyrwRC6jdHPCKm9z4qEWOwrI2Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTC9gPbWd/ul2xncTm8P28xh+GIbSi4ISeruqlif6HI=;
 b=BulgBeZZ0xfJBitcUKliTtLJOF95k8EMpQzOb/DzBMkusw5AKJyN9LxvYSi4Mfr27j4aDYyB+lbWc67D1Sz00zw7UwZRH2xL0KLl0yV/kS9Z3l207WwNeSuUYag/OijXWrf+c41FqB5W9/+5v4ZFcBTk66U2kOnRRWdKqkyMt6Si7glTKMUbFwPXopiaMZLrTX63UhnyUsXKRaM9mF2wzh1pOJzVyNgNYn9Jo0565rHy6PLmo+eWeR/phx02ykcjY4joFSuBhB8kesJm83CmCvYf6ZQ9lAcs+SSxSgd2aczq1CeEs5A/XSvtMftgPqRzGssGjVcsrqxEUYG/trJBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTC9gPbWd/ul2xncTm8P28xh+GIbSi4ISeruqlif6HI=;
 b=dPqkRRAk0dH++wG6QeeLBwK6w/Pz5exbpqJ0WEV2K9Xa7zAoIMDogdT7L7LBmTKY1Wd4cCDROcrDBV8/NPtu6SLgoRbpbmAKPPLkmPajk1Ds+UOO/fSGvuvssyd2K/fgLtdpxrSi4Ig/6uFW0ty/NKABrHfAcRn7bsmjJtcrNH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:37 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:37 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 5/7] shared/bap: Check state of all streams with same BIG ID
Date: Mon, 12 Feb 2024 17:32:20 +0200
Message-Id: <20240212153222.8191-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f11759-d611-416e-62e6-08dc2bdfd7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QpECMZH4PeXtkZ7iotk2igDWEOgg7QPTqEGKYjT3NlIeYzp4euRzMnCIiB6ddpz7PMopC+Z1qT3Zz/anhgrUazp926VObu5MjD88b4i6524DU8CmOIBulb6ooN3pS9JF6ptq/2uSOliPsD0TbfYt9r3nfxGakkUFyF9PjCgsp1xRGSq9SVes/kcANOPZZmZ9wZNilJPalLS7S0yERkEO5wP+1o7tPKWzRqeq9VeJvYv0+cGMnPA4btCYi0iyzlEohhi5/t4D0nl7YRs/wZp8xI0XOkrnFpWEQSYxu2IDEuCNUsOaaafQ7Mi3p7p0SFk+FfwxGITb1HGbbVDOS0Xjzch4HyhpsOVwUdgQ/P3t8xkKIklF1iTme063ZV2y7Kkc9T3zaEcSWxG4MYcD2gOlXqLl3ZMzUm2o0KTtNjz9+EYVO9g5HGXjgiFR05FQwl3fMdEeqsDgLmMbNGa6Y4H/r3ay+oTxD1p2siik35V5j+bTDsq2ea4eDPDxl4suJQEfM2X/FyUNeIiE9ndLkAr1UAQ+KO+7vthXGRBYz1RyVg9+GOKNNJMnVG/tmbO36XXs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhhgOr5eM6DcWwDYZdS4f9UpWU1TltQUMjPKZZYU+9ZdiJVMtWvjZ7BkvUvY?=
 =?us-ascii?Q?8Xsr21ttufyGdiTAdDEo2u79VRQtWD2FtT89T9pXz3qKijfOhZ4MiOv6dFML?=
 =?us-ascii?Q?+LVK0nnwp/MUEBNpzxKdfycYKifE+sBN1VWhruWUHz/tTLAPxxbtmwf4nOOI?=
 =?us-ascii?Q?+bZh/ryRTGeGQydrMQhaHyt1TjnrIkrB9OoNOmz6EMRxm5CcOPstF171ykde?=
 =?us-ascii?Q?+cUJjo9+zUuw5IUMfSjaCzsGV9fxK/82G0mOVjmX91NgVQ/PHRSmbst4/w6W?=
 =?us-ascii?Q?BSYoNLNMcAFQG6JQYYBOAzI9MqX3rM4ZkGWPXhwEdBvBWOPkfhWg/Ot6+lBi?=
 =?us-ascii?Q?M+9llvmBG2yGDcBMM5HC/4dKB46SYSQ7HqpGw6/JDDqaR/EaPJC9mT7RzsHl?=
 =?us-ascii?Q?SNMiViDIQZNEkx03GXgdXgkFeUUnd6uuwf9gQz/pgm1pGwLW3f8o3lLLuMSz?=
 =?us-ascii?Q?Dd0ZMyt4g67P/AYS1y/EMpjLmf4xLLGYAldFg/TiIAGqOWuGbYGHPOpEd/43?=
 =?us-ascii?Q?KAdKi8H6wY7qol5lKpgN2GHyCwf29V/pBuSYIPtrEPorfuoU6uwfVe3D60IA?=
 =?us-ascii?Q?aObhiMfOQZsXOGAV1Y3wn43scU8jMv4tzHO4yQpoXYlv817eN/dAslDz89kz?=
 =?us-ascii?Q?7vVjiAgta09HcasTX1nPQ9ZM3MBTU/NWE0P27RbhOaj4mjJQAtBI9h61yQ/x?=
 =?us-ascii?Q?4wb98xAozOim5rEYTeHguLakt2wAsbiFKexafGh/PK8U0dQJOs58gjFobT3p?=
 =?us-ascii?Q?DD1UPbRBosdRNXJak/DvTl8bX4e71b+23L8drDuZQKxeLiRuaIGkx1xPoxVc?=
 =?us-ascii?Q?XF26XXxSvnnH/xvtx6yNQnDMYmF0Qtuqh//wlasxXox7ca5BK5JxnYBWU4Ru?=
 =?us-ascii?Q?H9J3B/XAV3nyUkx+CV6QkIsHZyfI99ysYcbiFI54tAe8eXhRFpXsx0eAD+29?=
 =?us-ascii?Q?UkEQw9jQs7qHpJHpcyHM30bHiYJftrW0j3AEXtsu6AmKGaI6VJLvbHOMaQY2?=
 =?us-ascii?Q?jGmpWxZbzbYDD7dOWP3wgGf1krn9TQy3iRpdJ+lZalp0rtY0LDGEJbKhIsu4?=
 =?us-ascii?Q?8uh507D9hEMREEGsuEy7D4I4DqbgHwRcE1W832JjQzQhhJV+Er/DjJI//zZK?=
 =?us-ascii?Q?PP7soyDSrlrVUw93PFD39iosZadbh/UKmdBwYMs/bMe71jcMxIU79WU+MO44?=
 =?us-ascii?Q?QeesH9ElQgrs6Na68V1NTIdqaMqm41hSty0hrJVOPRJDlx+P2vy73MJSOIJD?=
 =?us-ascii?Q?dhBAt8tTSo25qvusbcsPDn/iHE1sDTOpkDqdc/11Ohvjh7cw5OUb460hxcjU?=
 =?us-ascii?Q?hDO+voaqIbHRdqhbtPQ2oq/XcP/70HbK00rC/IxxCspXMduHAGsEeKA6tThZ?=
 =?us-ascii?Q?5JfAj/f36rHx7PeR4Um5gzoODIDH8KcxO60t7zbHbc0/47V0SBsAgUdW38og?=
 =?us-ascii?Q?tQZLEPjSqScOn7LxCJdh24rOWFV/J3nEZM4d+wJcFGcF/lDeTkCVgHzYp3lB?=
 =?us-ascii?Q?/If6/qVbb/w/qbn3ZVrlWiQfm3sHixPopGiY6mUZFxBHnwPR44bYwbJK19aF?=
 =?us-ascii?Q?ucUieioYU0BhZjiNw6x0qg+LWnoIuwxHO1UC5yjjeLpAXHIFLVz5SidAGhvn?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f11759-d611-416e-62e6-08dc2bdfd7b9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:37.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OstxsmJIIQgmIxg+lJ8H3cxXdwZM3c+GDhE7Gs+LOa9U61n4n9Yw+m91XS8+m2AbNB4ObYkRa4lIl3hmfNUoIhWScuKFMc+pp1QZtWG1wps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

The function is used to verify if all the streams from a BIG are in the
same state, and if so it returns a new queue with all these streams.
This queue will be used to iterate through all configured streams in order
of their creation, and create the IOs.

---
 src/shared/bap.c | 37 +++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f0ffdebfe..2c5979b96 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6126,3 +6126,40 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
 }
+
+/*
+ * Check the state of all streams with the same BIG ID.
+ * If all the streams are in the checked state, return
+ * a queue with this streams.
+ * Else, return NULL.
+ */
+struct queue *bt_bap_get_streams_by_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *e_str;
+	struct queue *return_queue = queue_new();
+
+	for (entry = queue_get_entries(stream->bap->streams);
+				entry; entry = entry->next) {
+		e_str = entry->data;
+
+		if ((e_str->lpac->type != BT_BAP_BCAST_SOURCE) ||
+			(e_str->qos.bcast.big != stream->qos.bcast.big))
+			continue;
+
+		if (e_str == stream) {
+			queue_push_tail(return_queue, e_str);
+			continue;
+		}
+
+		if (e_str->ep->state != test_state) {
+			queue_destroy(return_queue, NULL);
+			return NULL;
+		}
+
+		queue_push_tail(return_queue, e_str);
+	}
+
+	return return_queue;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921..ad6bf2d97 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -323,3 +323,5 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+struct queue *bt_bap_get_streams_by_state(struct bt_bap_stream *stream,
+						uint8_t test_state);
-- 
2.39.2

