Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E26C71153
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377187AbjHRNgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbjHRNgS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 09:36:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB68358D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 06:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7PVCP2fg3bBdsQC1AYqHLrhkX26xDrp1nDL3xNWCkXjUc2Egt16PQxfqxFvlcN6N+mXLRzs0ANMhxiPsPbfo2mSMNcsAxNeag3gsAxGXA9ojdM9w6sgGP7YVLTpx+mz0+spG4UA44hUljXMoed1n7P1JY1FlSef0MukFRhb87ly8wHud7FgdRMhSOh2VjoSZy7lSpf1tRTdI9XJehTzGB4Wy9m23zEdy8KcnOmQep0FjD45xcDx5l1p6VmjEB4gsBycqX0aHR4WXjyOA6+jF2vxZUkdnO1Pg2Cm7hQP+yhoZOoYrn9+7iMxrbHr6cabZzsrGJQDXCMhRxaYV0s9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TILfo5unjE2BiM13NNXEh6/77Lr3MNVuJNdLn1Wc/IY=;
 b=BmvGNGwWsipTgPIJf5L1TBUvWRYUsBk65vQVl0+UizbAqpYd3mbu2Ez3R3E1RKooqzMAR6r7QvwNvkRABnj+eWi6jJz5igcxgVnskYm+aLnqbHotgffR8++MC79h4kTnd2hLq/08I5w0dpXkdalfZu+JiVgNfz22Hi9THohFO71oozABEtwFWma1ggWquz9bYfs9xDrQGrm6GR1BFGhuWa5oGShGzrANVxAmisE2LnmoESZh34DTLZWrU9d44QHtFNddcDjd4y/llNAgeOJB5zz0iXw84tHQ1Nsi20Gilk0b0kwR1b3ImJIuS2XWf33tW3tpY9dveq/2yDO+JC+XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TILfo5unjE2BiM13NNXEh6/77Lr3MNVuJNdLn1Wc/IY=;
 b=FmZRwhuG40IBQFc4U9gzTt+bj/Di3pwYoqwfgTRpHnwoQHjNulUScZ71P8k2u2AMUPojXRRObbteHr8k5SkN8PKXYJ6wjDcZSgIWzLbJ1hjaYlzpdh3YaTBEdXgtyFm+clDKYpIjDC8Yg3HvQO/KQ2gU+XiJ9xa1YvmeMJ8UlOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:36:15 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 13:36:15 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/3] bap: For broadcast ep extract capabilities from BASE
Date:   Fri, 18 Aug 2023 16:35:51 +0300
Message-Id: <20230818133552.20673-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
References: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 980c9928-a896-49c4-2a15-08db9ff01878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqCOxxLYogLvfVQpGWd3ykvzik1wNm6wo2uPMtCQI3Ev7e/gr3IkFXievBGRPQfc1WJYkSSYTYOHgV7d4n9zqfLHktJTefxASsi1xl307W/G3ie3fw+Nn3Hqao4G0BuTuFFZZDLd6//ID1Snw5KhCnAUsO8NewVFh9uK8z77JbdDVsbIH0thNl1vZLqAhU3yNzRMItWRZO4KsVcOUVde38sJyBWy42JO7ErxP4fRhpi1c644UTP34Luzi/GVZ9HkZREW0Xg+og9O9Dm5tYmOEphwj3n8mADivFzQJePzmg7GUZLXmWFF2K2utbck6/cbRg+KcnvGOIzHlg8bZ+N/7b0t+h99qepq6e8HhoN6Sw78ehxWvBQQPVSQBQQclFT7iZ9iiNN1pLUNJCMMDw7eu9XtOHCWut7Dqk9fc3/pPRYhqFAa8AldSgu9uPDesG1Hhq19Rxf+W0N0qnV4IFw5pm/M80LnwaZ5T7LwAOjyBRxeL1LqkAnK0U5pCug/dQnXh4xUontiknq3Zi4exF9VbCXvpOzePk/G8XiHCywfAC2RSfofNe5//2tKWkpRfC7TbP9x6W8lHel88ih3zwbC/RsGk49sZVmtzyXXvAkzNffswlZIjeEy1Lm5bGeeXR76
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(86362001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(41300700001)(38350700002)(38100700002)(6512007)(6486002)(6666004)(26005)(6506007)(52116002)(1076003)(2616005)(8676002)(5660300002)(8936002)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOQT2dUdGdJY+8fpViVCl0SK+blaZ7i7AopO34zyIt0UgZLz6zLm37OhH/Pw?=
 =?us-ascii?Q?LWsxQyBW6cwGRXBLzfphxP/v9Q6RjLXGxRk13c+QOptDz7picmgSJNNZ+ccs?=
 =?us-ascii?Q?+6r07v7fs76sPi4b59Yu7u7/pTWeC6L2k3zLfLXn1KQT+ePiRsd6Yyt52ngR?=
 =?us-ascii?Q?ZbVjqCyyT2kWlYCLIAiw2TBs4U/wBSUYYgz1CXDXNKiMJt3QmH5ZtaMcpdBv?=
 =?us-ascii?Q?6JgTEnOOTBWDeRqOChaogHM8l3Cp5+7V6IWIedSShxB6ztBmF0e7MccfXdZS?=
 =?us-ascii?Q?u1/u/7nrXUD+cnkp3nQoAsuF2ETkkenoHLY4m1kwKlKP1ExImYXPkRMp+/WI?=
 =?us-ascii?Q?Jt9x3S/KO9qUbo//Yn8rAE51XO+91DUcwuNAvTonLGO0+ih5XVEQz49wdqnu?=
 =?us-ascii?Q?LjJSqALUMUsn2RNjG8S7qBZKPGcw1jYWWKWFN+2SbLU1vHEi3eWjhxI8MpJM?=
 =?us-ascii?Q?u5AI5bsB3MvpLb0MuzUw5P4xN711kOJY7mHj2G8SaD8xshh79Dy5Di8I/2RE?=
 =?us-ascii?Q?jX7aKAhwpqId5p2O3HcHEk610mNTUHCB3p7xIxXzrVofwpf9ZLIDgs4lXWWo?=
 =?us-ascii?Q?VEFHpZVd5cGg/5j/v02ODnKGNvgXYu64ySl3pIiyO8vOtXTu80xFAukXuvGS?=
 =?us-ascii?Q?ZzlLRy8gFpuU2D3GzFwlMWSlILpeJF8IMTWf+G8PgpIyFOA5LZ+CDq+T81Bi?=
 =?us-ascii?Q?u3YBfQMXv/3HsOv2DeLp897G8GDEUd4AnqORIrSlB8XoMMLaMM4kPp95kmfN?=
 =?us-ascii?Q?aiHaI1M8f4B4gKptkN2i14ULp+19C9p+hSSGoJnv8isCXC491RuLYOU/5RBE?=
 =?us-ascii?Q?C+YYo7ZWD9zvgJbsc5Uvgz32zcdJgHn239PXt9mvIBZ6VmaROEv8MqV8ZYxr?=
 =?us-ascii?Q?jS51Kz0CkyUAAKRqDjsNt/tP+/Y/haZW8oIvgAC6A6ihoUFHhgGUptxfLdjI?=
 =?us-ascii?Q?97GYJX9deS9o8EbzOEvcn42GI2ZRUvXdZnqEmPavGY0TxHAcT5E5zY2Btkv5?=
 =?us-ascii?Q?gNIE3B9+zWUsPeWtxSIlPcbZR3K4uiaUbnO5+DUDItCtnvOzNPbxGbp+RP48?=
 =?us-ascii?Q?AwxoeJgKoLLrj9tgLR8HdEHd49eVOZ7Ooxu1VvjdRizxov6nmp/bNtxJaUgv?=
 =?us-ascii?Q?DA0fLZvwMq+iXamRKiJrlaCb6moh5sDrtWN+RKKPyAopJREhhU2iOIYXKhEN?=
 =?us-ascii?Q?dDvI0y67qZ1zyQqWrXXCVzNIp02mQ4o57W80o7ERe9Va6+e15J9cb5X1sndz?=
 =?us-ascii?Q?ltdEpArf7GsgEWr2lPUMHr0fqAOnPkzZSTd2KzPgBels7Z8qzCuIZ3DFhLZz?=
 =?us-ascii?Q?j+wrBNbNPD839vovBo4RJGVeket9T6BF7GSNHYwvEWk0JNzTWxFJk7253CvG?=
 =?us-ascii?Q?RrejutkprdPHtaY+mIjWjxoP5OjSg/5lTZ3HXDB60w8/0+5GjS+SJv7gEo7N?=
 =?us-ascii?Q?GWCkVvRuEppaV/bPOUNeRDatDgMOHoAD91gB/POwUAAU1W2TmIv9aAKL5WqD?=
 =?us-ascii?Q?gP1NEHgVr3GVW38Z2OUF6xj53g6QEWgo3D7dL5+SwiXkKJk+GT1Yf65jIe+S?=
 =?us-ascii?Q?Ra9JpogKMfh5ppAxWthY/279xVj7TOn6TRx9DPyL0Axa/xWcxCtBsRXV7gAP?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c9928-a896-49c4-2a15-08db9ff01878
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:36:15.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcMZDTzSbPUP8/ob6YdKSLoCbVPiPHlcZJ9uMq2D3RPJFfHAP4r3yf6cywDNvHkrZyQJrztdXo7LNxDeoAkILsZhy8pPXN/SErr/tXOw6PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claudia Draghicescu <claudia.rosu@nxp.com>

bap: For broadcast ep parse BASE to extract capabilities

---
 profiles/audio/bap.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8cbb238ef..de19023a9 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -74,6 +74,7 @@ struct bap_ep {
 	struct bt_bap_qos qos;
 	unsigned int id;
 	DBusMessage *msg;
+	struct iovec *base;
 };
 
 struct bap_data {
@@ -272,7 +273,8 @@ static int parse_array(DBusMessageIter *iter, struct iovec **iov)
 }
 
 static int parse_properties(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct bt_bap_qos *qos)
+				struct iovec **metadata, struct iovec **base,
+				struct bt_bap_qos *qos)
 {
 	const char *key;
 	struct bt_bap_io_qos io_qos;
@@ -438,9 +440,20 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 	}
 
 	if (broadcast) {
+		uint32_t presDelay;
+		uint8_t numSubgroups, numBis;
+		struct bt_bap_codec codec;
+
 		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
 		qos->bcast.framing = framing;
-
+		if (!base)
+			return 0;
+		if (!(*base))
+			*base = new0(struct iovec, 1);
+		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
+		bap_parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
+			&presDelay, &numSubgroups, &numBis, &codec,
+			caps, NULL);
 	} else {
 		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
 		qos->ucast.framing = framing;
@@ -565,7 +578,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
+	if (parse_properties(&props, &ep->caps, &ep->metadata,
+				&ep->base, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
 		return btd_error_invalid_args(msg);
 	}
@@ -1244,10 +1258,10 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
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
 
-- 
2.34.1

