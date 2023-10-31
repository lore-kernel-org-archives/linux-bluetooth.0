Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D2C4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjJaP4B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjJaP4A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:56:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945E109
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQpwhaIpF/bGzfPCxEMA4XhwQcSr6g6TOOXpFSKaJkCpM4onwldLbwQYxDl2T2lRb7RlDWhQ7nPRn9+wtdCc/maPaTnZNLJC8Y/h0xhgSnNF0eqISprY4LVp+KB/CEG6gyXUb/H3fb+fGF832mMjGdmGzHEYvu+9D6318r2OjJ/G+LX7+vx01k7ntJoikYskSy4FRNxK2sOwkYKiNW7DYZvBWxWCNZDwUoYA7TBuYCbldHTZU9juJ294+CS+6bliXpi3wbSgEBwydulaSaxIAHbS005vxGgHv1437bEaTaSpsJBcXcqxIUh+ppalYXZ29r2NSNnPzOa3YQvT/3kQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzPnZ9PnDHsHFqPX1Dzc8vSd7iVAtpQyYuMFSndwo6E=;
 b=T1hw6eCDLMvzbCHzj38ogMjizk4IcoKXkoPRiCjC1dkIPrfUEmOFs/JWU2Lga07kFEZT9yOUEPwlWV5Q/kGKLYYWuRRr3PF/GcNrV3UMZ3JoDjy4SioVps7ecNHWIIZ8g8AiVGmyMYAs7pLfjUtntqY0mYaz8zclLPGJVP7nEw/Wa6Y7zRi/PWC+znPNwyx/z1ZJ7wrbZTbxUwM2fLssvYCeBjBr0Q0HobXWvVx6olCuNPDByCp0FyhZ3ZjzYtZ83kiUH58DYDQwe5n3NsGJ+GpxLYjm++JTg3VWv0YklAjMTIaXZ+A9ZOMdEFMf91SbevBLRZF0060pnL1c8KbfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzPnZ9PnDHsHFqPX1Dzc8vSd7iVAtpQyYuMFSndwo6E=;
 b=BmkNPRbEBVfeXDav46io0euEl3+PsZrsGr/B7lbQhRclmfH4p7zAW00gbhfSw2KKO0xaASLeue/liWLMnSGpJs3BFwhQBw1+/JWgSa8vTJg9x13ly/Q73M/ZWxfIiJgzs8J+tjicoPV5Z/cqwq3A8bEb4z+ShAPDzlb8REd/iWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by VE1PR04MB7440.eurprd04.prod.outlook.com (2603:10a6:800:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 15:55:51 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:51 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 3/5] Add support for bcast multiple BISes
Date:   Tue, 31 Oct 2023 17:55:33 +0200
Message-Id: <20231031155535.228994-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0135.eurprd07.prod.outlook.com
 (2603:10a6:802:16::22) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|VE1PR04MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ca7b6b-fe19-4f70-1732-08dbda29db1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qAYUN1YgYDlPXDNbLuKWEtQboT+Ry2W4egdAxC5IImNaUXsxGJbM9n0A9cBu7sT3mnvTS6Evf78JUPSsjqib7+pEGLsw5jgJJhCvCpN3bTSOyT9c9DFUrzq4Mccm2O3GoRuduVEzs8Qbr47KWyeSAlPVGQMIVlZjWBpVgcG78fBxGd98x8P4+dvgHIEbCSViIPYcXRUdNcePha+dlM4DeTManBH35SOYjweDq7+pDyXcmj2xBeXaRwCfb8lmE6GwvEpeNylebE4rr2y1IUk8ZK/MpdiRYKC5w3CKrm6Vl3waNJjBEyRQDZmC4kJWBzVaoi1qPEhgH3dMfgK5KGG+c8CRXyQoTSV7MnbgxtiSa4WE+T3OFjPu3CoIA4YpkJmb0I53VEN+H+hyy18Vc48YCU6CGsFOuqd+MA2Qe4ESD8sudKTj9colA79H0vYkdMbroT/TqpnyNdzBydcmqD1QBYcufWNOUHmjwzhzlk2DGIPNOqIS1veDj+nO8obDjnQReu2SEcXMBp7rBS2TgrGr3bFVr8jhgFPc9SHQ3piStuK8kxtVDrKH0S4kSG8QtYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(8676002)(4326008)(8936002)(83380400001)(5660300002)(41300700001)(38100700002)(6486002)(478600001)(6506007)(36756003)(2906002)(30864003)(6512007)(86362001)(6666004)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zi5TGNiau0kpWDa+UK6fXpCDBdOUbGTvdGglxt99Vn1hLFXQV1QdUTtrilhO?=
 =?us-ascii?Q?EM16z4P88tI/dfRo4qKvczZcHmTk/L/eC7GTSGPK55mJaGFKGo6/L7I8b0mZ?=
 =?us-ascii?Q?4G3608Cgdtt7LeAxGZdahYZZHi5cVrohRQQi1U7DnrCT65A3Tp1RGUqciyUd?=
 =?us-ascii?Q?EREIrRLg3gODPWU4hXXIYpIr3UsRcb4Syv7FZKRinK23xZxGFSuE8TmOUN8u?=
 =?us-ascii?Q?i8Ox/fcpykDChPrwJ+sS/G1Cb6rOKQbT7o0ZYwV/fkw693agudj30mZHjHbh?=
 =?us-ascii?Q?DVfcK8JbSHurnrSPlpVxoQepeP7U3ohJXDV+3n+3+aqZkU+kOGkI7En6CNYY?=
 =?us-ascii?Q?wbfBeJ5RdAe4KfZopCdQSJAdsHgvIDlfPR43X+kqFpigCjkXEDh4vDOqjb0v?=
 =?us-ascii?Q?i9an9c/GciScXHJpP43Tu7lb4h6bWu1vFNtmkjRz1BXAnOsRHHeicFPevJKo?=
 =?us-ascii?Q?2Ygp9uZ9Gh3Uciqf/y2HQ3v3wAYiMbWgxxjjjRimg/pzr9NnS0PMqXwC6jzP?=
 =?us-ascii?Q?WYwrkDuqPyU5hxTD+FsQjfB85pxoyw26On7Sm3GXR4L/GVwjHRn5Mh2e2KmC?=
 =?us-ascii?Q?guQTxTF2rkji0uNDpq+gh7bv0mMXn9TihwSoub8KvQmmYsw9sEocpaktP9K5?=
 =?us-ascii?Q?dx0hu7GUcvFgt24rWi67mdnvA6/lg177BE6d1C5pvI6pUiigsShOjrHDW8Np?=
 =?us-ascii?Q?qJ6AXQbQpFi0ogYj9i+EfaxsiDVO9++Srn3TJXOQMSrKdCIslJKwHDwui9IJ?=
 =?us-ascii?Q?ohGmBAkYSMhLIcNFCJ53UofcMnyugnyd77fel5j0r3xlpAQ2ItEhNqA8aQsn?=
 =?us-ascii?Q?RD97UibCAEpRUd8YQZS/dfSYCif/wT8tqYnbXDsc8WYceKX9heNWVSVUkHyA?=
 =?us-ascii?Q?5MDmWE0dWXiNAgoIw44+cs0yEft7DhpHi+DA8RfhSecgq/AOfWV8JZZ+QjCK?=
 =?us-ascii?Q?jvW1i0Xt2t8iaMP1OAE7QsWyIhIB/eEBp5bleiIi4EFihrQBdQq+EIuN+tUL?=
 =?us-ascii?Q?wpMqvyUKmuvF1cTJRXGjy0DYFMVUQFLfEHTsabDlM6m6sNvpt3pqHPK69uU+?=
 =?us-ascii?Q?aqFJFdBZFH9IP2AllkhHTSeEXx5A4pvTwDrIAtODLApyANI2FesX2aJtZQ8y?=
 =?us-ascii?Q?RDe/2uynLpih6LRE+9hcB2NPC0vXOqjuI7iKjZBGhyJWCX7ruhhuoW46QhNs?=
 =?us-ascii?Q?anzAI6Q+1ZNWcKPr+hYo0pQKeSH65EjzX0FO8gk4j0At9+VPuMDkbctLfde6?=
 =?us-ascii?Q?0xcdaUF7CUHxBn70/IvMec/X6vA+M3IfsVtLAC/b2ctftbTEM2CvZnpxH0Up?=
 =?us-ascii?Q?F+KQCeKxaXzYeoImf89k4/lXixLAaKlcpOdqNiVCMmQ2/vJI5V5oHsY8O44w?=
 =?us-ascii?Q?3JFiPjv6P2EfZik5VkFdcuKt5j4dTQ3zzrklEp74TjdT6x3SNmDqpFWnSywq?=
 =?us-ascii?Q?Pf0aOrdkcUHWq7s8dGboFBweDwJWJCiDGPrKjdlOBjkoi/rO/8ybMl9dLT35?=
 =?us-ascii?Q?Cpbj3xOKjEny+nUNx9lJ6Vpbz7zp/5sNZkAFJ8997CXvgsWWgzuXquYOGRzT?=
 =?us-ascii?Q?g/nIeR2xI9y3uslEULrYhSUHcz2rx6kMdtl1vJzXVs8gcLhUkJwgTMymPU11?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca7b6b-fe19-4f70-1732-08dbda29db1b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:51.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Bu8mnPiizuSmW8H7lD48c3wma3oC62K9KhTtr3m/LnjRr26YNS4MyoI/Rs+PDXNtBNGQN0yYVAOHeMeG7DXZN+aGy5nmxbAI5o562Pcrs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7440
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for bcast multiple BISes

---
 profiles/audio/bap.c | 512 +++++++++++++++++++++++++++++++------------
 src/shared/bap.c     | 226 +++++++++++++++----
 src/shared/bap.h     |  32 ++-
 unit/test-bap.c      |  12 +-
 4 files changed, 593 insertions(+), 189 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a84181e1a..fcc0684fb 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -97,6 +97,35 @@ struct bap_data {
 	void *user_data;
 };
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_factor	= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -254,7 +283,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter);
+		/*
+		 *Use remote endpoint path as fake device path
+		 *for the remote broadcast source endpoint
+		 */
+		path = ep->path;
 	else
 		path = device_get_path(ep->data->device);
 
@@ -379,101 +412,184 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
-static bool parse_base(void *data, size_t len, util_debug_func_t func,
-		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
-		struct bt_bap_codec *codec, struct iovec **caps,
-		struct iovec **meta)
+static bool parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
 {
+	uint8_t numSubgroups;
+	uint8_t numBis;
+
 	struct iovec iov = {
 		.iov_base = data,
 		.iov_len = len,
 	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
+		return false;
 
-	uint8_t capsLen, metaLen;
-	uint8_t *hexstream;
+	if (!util_iov_pull_le24(&iov, &base->presDelay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", base->presDelay);
 
-	if (presDelay) {
-		if (!util_iov_pull_le24(&iov, presDelay))
-			return false;
-		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
-	}
+	if (!util_iov_pull_u8(&iov, &base->numSubgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->numSubgroups);
+	numSubgroups = base->numSubgroups;
 
-	if (numSubgroups) {
-		if (!util_iov_pull_u8(&iov, numSubgroups))
-			return false;
-		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
-	}
+	for (int sg = 0; sg < numSubgroups; sg++) {
+		struct bt_bap_base_subgroup *subGroup = new0(
+						struct bt_bap_base_subgroup, 1);
+		uint8_t capsLen, metaLen;
+		uint8_t *hexstream;
 
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
-	}
+		subGroup->subGroupIndex = sg;
+
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		subGroup->bap = bap;
+		subGroup->bises = queue_new();
 
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
+		if (!util_iov_pull_u8(&iov, &numBis))
 			return false;
+		util_debug(func, NULL, "NumBis %d", numBis);
+		subGroup->numBises = numBis;
+
+		memcpy(&subGroup->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
 		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
-	}
+			"Codec", subGroup->codec.id, subGroup->codec.cid,
+				subGroup->codec.vid);
+		if (!util_iov_pull_u8(&iov, &capsLen)) {
+			free(subGroup);
+			return false;
+		}
 
-	if (!util_iov_pull_u8(&iov, &capsLen))
-		return false;
-	util_debug(func, NULL, "CC Len %d", capsLen);
+		util_debug(func, NULL, "CC Len %d", capsLen);
 
-	if (!capsLen)
-		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}
+		subGroup->caps = new0(struct iovec, 1);
+		util_iov_memcpy(subGroup->caps, iov.iov_base, capsLen);
+		DBG("subgroup caps len %ld", subGroup->caps->iov_len);
 
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+		for (int i = 0; capsLen > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
 
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				free(subGroup->caps);
+				free(subGroup);
+				return false;
+			}
+
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				free(subGroup->caps);
+				free(subGroup);
+				return false;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+			capsLen -= (ltv->len + 1);
+		}
+
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			free(subGroup->caps);
+			free(subGroup);
 			return false;
 		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
+		subGroup->meta = new0(struct iovec, 1);
+		subGroup->meta->iov_len = metaLen;
+		subGroup->meta->iov_base = iov.iov_base;
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			free(subGroup->meta);
+			free(subGroup->caps);
+			free(subGroup);
 			return false;
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+		for (int bis_sg = 0; bis_sg < subGroup->numBises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t capsLen;
+			uint8_t crtBis;
+
+			if (!util_iov_pull_u8(&iov, &crtBis)) {
+				free(subGroup->meta);
+				free(subGroup->caps);
+				free(subGroup);
+				return false;
+			}
+			util_debug(func, NULL, "BIS #%d", crtBis);
 
-		capsLen -= (ltv->len + 1);
-	}
+			bis = new0(struct bt_bap_bis, 1);
+			bis->bisIndex = crtBis;
 
-	if (!util_iov_pull_u8(&iov, &metaLen))
-		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
+			if (!util_iov_pull_u8(&iov, &capsLen)) {
+				free(subGroup->meta);
+				free(subGroup->caps);
+				free(subGroup);
+				free(bis);
+				return false;
+			}
+			util_debug(func, NULL, "CC Len %d", capsLen);
 
-	if (!metaLen)
-		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = capsLen;
+			util_iov_memcpy(bis->caps, iov.iov_base, capsLen);
+			DBG("bis caps len %ld", bis->caps->iov_len);
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
-		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
+			for (int i = 0; capsLen > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
+
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					free(subGroup->meta);
+					free(subGroup->caps);
+					free(subGroup);
+					free(bis->caps);
+					free(bis);
+					return false;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					free(subGroup->meta);
+					free(subGroup->caps);
+					free(subGroup);
+					free(bis->caps);
+					free(bis);
+					return false;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
 
+				capsLen -= (ltv->len + 1);
+			}
+
+			queue_push_tail(subGroup->bises, bis);
+		}
+
+		queue_push_tail(base->subgroups, subGroup);
+	}
 	return true;
+
 }
 
 static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
@@ -556,6 +672,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "BIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	}  else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -653,10 +779,12 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 
 static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+				struct bt_bap_qos *qos,
+				struct bt_bap_base *base_s)
 {
 	const char *key;
 	struct iovec iov;
+	base_s->subgroups = NULL;
 
 	memset(&iov, 0, sizeof(iov));
 
@@ -702,14 +830,10 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 	}
 
 	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
 		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
+		base_s->subgroups = queue_new();
+		parse_base(NULL, (*caps)->iov_base, (*caps)->iov_len,
+							bap_debug, base_s);
 	}
 
 	return 0;
@@ -796,12 +920,40 @@ static void bap_io_close(struct bap_ep *ep)
 	ep->cig_active = false;
 }
 
+static bool match_bis_by_id(const void *data, const void *user_data)
+{
+	int32_t bis_id = PTR_TO_INT(user_data);
+	const struct bt_bap_bis *bis = data;
+
+	return bis->bisIndex == bis_id;
+}
+
+static int get_number_bcast_source_ep(struct bap_ep *ep)
+{
+	const struct queue_entry *entry;
+	struct bap_ep *current_ep;
+	int nr_ep = 0;
+
+	for (entry = queue_get_entries(ep->data->bcast); entry;
+						entry = entry->next) {
+		current_ep = entry->data;
+		if (bt_bap_pac_get_type(current_ep->lpac) ==
+						BT_BAP_BCAST_SOURCE)
+			nr_ep++;
+	}
+
+	return nr_ep;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct bap_ep *ep = data;
 	const char *path;
 	DBusMessageIter args, props;
+	struct bt_bap_base parse_bap_base;
+	struct bt_bap_bis *curent_bis;
+	struct bt_bap_base_subgroup *subgroup;
 
 	if (ep->msg)
 		return btd_error_busy(msg);
@@ -832,11 +984,46 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (parse_configuration(&props, &ep->caps, &ep->metadata,
-				&ep->base, &ep->qos) < 0) {
+				&ep->base, &ep->qos, &parse_bap_base) < 0) {
 		DBG("Unable to parse configuration");
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		unsigned int nr_ep = 1;
+
+		subgroup = queue_peek_head(parse_bap_base.subgroups);
+		curent_bis = queue_find(subgroup->bises, match_bis_by_id,
+						INT_TO_PTR(ep->qos.bcast.bis));
+		if (curent_bis == NULL) {
+			DBG("Unable to find BIS");
+			return btd_error_invalid_args(msg);
+		}
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		bt_bap_ltv_merge(ep->caps, subgroup->caps, false);
+		bt_bap_ltv_merge(ep->caps, curent_bis->caps, false);
+
+		nr_ep = get_number_bcast_source_ep(ep);
+		if (nr_ep < queue_length(subgroup->bises)) {
+			for (uint8_t i = 0;
+				i < queue_length(subgroup->bises)-1; i++)
+				bt_bap_add_vendor_pac_from_pac(ep->lpac);
+		}
+	} else if ((bt_bap_pac_get_type(ep->rpac) == BT_BAP_BCAST_SOURCE) &&
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)) {
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		bt_bap_ltv_merge(ep->caps, bt_bap_pac_get_data(ep->rpac),
+									false);
+	}
+	/*
+	 * Kernel uses bis id as advertising handler. To open all BISes from
+	 * a big on the same advertisng handler set the bis
+	 * to BT_ISO_QOS_BIS_UNSET
+	 */
+	ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
@@ -848,7 +1035,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 						config_cb, ep);
 	if (!ep->id) {
 		DBG("Unable to config stream");
-		free(ep->caps);
+		util_iov_free(ep->caps, 1);
 		ep->caps = NULL;
 		return btd_error_invalid_args(msg);
 	}
@@ -916,11 +1103,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	char address[18];
 	struct bap_ep *ep;
 	int fd;
-	struct iovec *base_io;
-	uint32_t presDelay;
-	uint8_t numSubgroups;
-	uint8_t numBis;
-	struct bt_bap_codec codec;
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_DEST, address,
@@ -945,15 +1127,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	update_bcast_qos(&qos, &ep->qos);
 
-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis,
-			&codec, &ep->caps, &ep->metadata);
-
-	/* Update pac with BASE information */
-	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
 					ep->caps, NULL, NULL);
 	data->listen_io = io;
@@ -968,25 +1141,40 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
-
 	return;
 
 drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
-
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bt_iso_base base;
+	char address[18];
+	struct bt_bap_base *base_s;
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
 		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
 	}
+	g_io_channel_ref(io);
+	data->listen_io = io;
+	btd_service_connecting_complete(data->service, 0);
+
+	base_s = new0(struct bt_bap_base, 1);
+	base_s->subgroups = queue_new();
+	parse_base(data->bap, base.base, base.base_len, bap_debug, base_s);
 
+	bt_bap_update_bcast_source(NULL, base_s);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1082,6 +1270,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
+		ep->io = data->listen_io;
 		ep->base = new0(struct iovec, 1);
 		break;
 	}
@@ -1582,9 +1771,12 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	bap_io_close(ep);
 
-	/* Check if connecting recreate IO */
-	if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
-		recreate_cig(ep);
+	if (bt_bap_stream_get_type(ep->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+		/* Check if connecting recreate IO */
+		if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
+			recreate_cig(ep);
+	}
 
 	return FALSE;
 }
@@ -1675,7 +1867,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 
 static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream,
-				struct bt_iso_qos *qos)
+				struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1711,7 +1903,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -1763,42 +1955,28 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
 {
-	GIOChannel *io;
 	GError *err = NULL;
 	struct sockaddr_iso_bc iso_bc_addr;
 
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
 	iso_bc_addr.bc_num_bis = 1;
+	iso_bc_addr.bc_bis[0] = strtol(bt_bap_pac_get_name(ep->rpac), NULL, 10);
 
 	DBG("stream %p", stream);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
-
-	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
-			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(ep->data->adapter),
-			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
-			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
-			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-			BT_IO_OPT_QOS, &qos->bcast,
-			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
-			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
-			BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
+	if (!bt_io_bcast_accept(ep->data->listen_io, iso_bcast_confirm_cb,
+				data, NULL, &err,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
+		g_io_channel_shutdown(ep->data->listen_io, TRUE, NULL);
 	}
-	ep->io = io;
-	ep->data->listen_io = io;
-
 }
+
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1833,9 +2011,6 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = ep->qos.bcast.big;
 	iso_qos.bcast.bis = ep->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = ep->qos.bcast.sync_factor;
@@ -1852,9 +2027,9 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	iso_qos.bcast.timeout = ep->qos.bcast.timeout;
 	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
+		bap_connect_io_broadcast(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
 }
@@ -1879,6 +2054,31 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 		break;
 	}
 }
+/*
+ * Function  test_linked_streams_state will check if all linked streams
+ * have the test state.
+ * If all streams are in test_state returns true; Else returns false
+ */
+static bool test_linked_streams_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *linked_stream;
+	struct queue *links;
+
+	links = bt_bap_stream_io_get_links(stream);
+
+	if (!links)
+		return true;
+
+	for (entry = queue_get_entries(links); entry; entry = entry->next) {
+		linked_stream = entry->data;
+		if (bt_bap_stream_get_state(linked_stream) != test_state)
+			return false;
+	}
+
+	return true;
+}
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
@@ -1906,15 +2106,26 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
-			bap_create_io(data, ep, stream, true);
-			if (!ep->io) {
-				error("Unable to create io");
-				bt_bap_stream_release(stream, NULL, NULL);
-				return;
-			}
-
 			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BCAST) {
+				bool defer = !test_linked_streams_state(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+				bap_create_io(data, ep, stream, defer);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
+			} else if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
+				bap_create_io(data, ep, stream, true);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
 				/* Wait QoS response to respond */
 				ep->id = bt_bap_stream_qos(stream, &ep->qos,
 								qos_cb,	ep);
@@ -2222,6 +2433,12 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2260,7 +2477,24 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with source");
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &default_qos,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
 	return 0;
 }
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index d8a3adde6..8ba0320d6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -254,6 +254,8 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -1111,7 +1113,8 @@ static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 		return stream->io;
 
 	io = NULL;
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, stream_find_io, &io);
 
 	return io;
 }
@@ -1323,6 +1326,12 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 
 	bt_bap_ref(bap);
 
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_QOS:
+		bap_stream_update_io_links(stream);
+		break;
+	}
+
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
@@ -2357,33 +2366,18 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 	return NULL;
 }
 
-static void *ltv_merge(struct iovec *data, struct iovec *cont)
-{
-	uint8_t delimiter = 0;
-
-	if (!data)
-		return NULL;
-
-	if (!cont || !cont->iov_len || !cont->iov_base)
-		return data->iov_base;
-
-	iov_append(data, sizeof(delimiter), &delimiter);
-
-	return iov_append(data, cont->iov_len, cont->iov_base);
-}
-
 static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 					struct iovec *metadata)
 {
 	/* Merge data into existing record */
 	if (pac->data)
-		ltv_merge(pac->data, data);
+		bt_bap_ltv_merge(pac->data, data, true);
 	else
 		pac->data = util_iov_dup(data, 1);
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
-		ltv_merge(pac->metadata, metadata);
+		bt_bap_ltv_merge(pac->metadata, metadata, true);
 	else
 		pac->metadata = util_iov_dup(metadata, 1);
 }
@@ -2614,6 +2608,20 @@ static void notify_session_pac_added(void *data, void *user_data)
 	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
 }
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac)
+{
+	struct bt_bap_pac *new_pac;
+
+	new_pac = bt_bap_add_vendor_pac(pac->bdb->db, pac->name, pac->type,
+							pac->codec.id,
+							pac->codec.cid,
+							pac->codec.cid,
+							&pac->qos, pac->data,
+							pac->metadata);
+	bt_bap_pac_set_ops(new_pac, pac->ops, pac->user_data);
+	return new_pac;
+}
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -2671,7 +2679,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *metadata)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						    data, metadata);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2701,6 +2709,14 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	if (!pac)
+		return 0x00;
+
+	return pac->data;
+}
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
 {
 	struct bt_pacs *pacs;
@@ -2783,12 +2799,26 @@ static void notify_session_pac_removed(void *data, void *user_data)
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data)
 {
+	const struct queue_entry *entry = NULL;
+	struct bt_bap_pac *pac_entry;
+
 	if (!pac)
 		return false;
 
 	pac->ops = ops;
 	pac->user_data = user_data;
 
+	if (pac->type == BT_BAP_BCAST_SOURCE) {
+		for (entry = queue_get_entries(pac->bdb->broadcast_sources);
+					entry != NULL; entry = entry->next) {
+			pac_entry = entry->data;
+			if (pac_entry != pac) {
+				pac_entry->ops = ops;
+				pac_entry->user_data = user_data;
+			}
+		}
+	}
+
 	return true;
 }
 
@@ -2807,8 +2837,13 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
+		/* Mark stream->lpac to NULL,
+		 * as it will be freed in bt_bap_remove_pac
+		 */
+		stream->lpac = NULL;
 		bt_bap_stream_release(stream, NULL, NULL);
+	}
 }
 
 static void bap_pac_sink_removed(void *data, void *user_data)
@@ -4471,6 +4506,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
 	return false;
 }
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
+{
+	return pac->name;
+}
+
 static bool find_ep_unused(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -4682,7 +4722,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
@@ -4699,7 +4739,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (!ep) {
 		/* Check for unused ASE */
 		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
+		if (!ep && lpac->type == BT_BAP_BCAST_SOURCE) {
+			bt_bap_new_bcast_sink(bap);
+			ep = queue_find(bap->remote_eps, find_ep_unused,
+								&match);
+			if (!ep) {
+				DBG(bap, "Unable to find unused ASE");
+				return NULL;
+			}
+		} else if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
 		}
@@ -4839,7 +4887,16 @@ static void bap_stream_enable_link(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct iovec *metadata = user_data;
 
-	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
+								NULL, NULL);
+		break;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+		break;
+	}
 }
 
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
@@ -4866,13 +4923,14 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		if (!bt_bap_stream_io_dir(stream))
+		if (!bt_bap_stream_io_dir(stream)) {
 			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+						BT_BAP_STREAM_STATE_CONFIG);
+			queue_foreach(stream->links, bap_stream_enable_link,
+									NULL);
+		} else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
 				 BT_BAP_STREAM_STATE_STREAMING);
-
 		return 1;
 	}
 
@@ -4933,17 +4991,27 @@ static void bap_stream_disable_link(void *data, void *user_data)
 	struct iovec iov;
 	struct bt_ascs_disable disable;
 
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
 
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, NULL, NULL);
+		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov,
+							1, NULL, NULL);
 
-	if (!bap_queue_req(stream->bap, req))
-		bap_req_free(req);
+		if (!bap_queue_req(stream->bap, req))
+			bap_req_free(req);
+	break;
+
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_RELEASING);
+	break;
+	}
 }
 
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
@@ -5189,7 +5257,8 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5210,6 +5279,23 @@ static bool match_name(const void *data, const void *match_data)
 	return (!strcmp(pac->name, name));
 }
 
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter)
+{
+	uint8_t delimiter = 0;
+
+	if (!data)
+		return NULL;
+
+	if (!cont || !cont->iov_len || !cont->iov_base)
+		return data->iov_base;
+
+	if (add_delimiter)
+		iov_append(data, sizeof(delimiter), &delimiter);
+
+	return iov_append(data, cont->iov_len, cont->iov_base);
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
 	struct bt_bap_req *req;
@@ -5245,10 +5331,15 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	if (queue_find(stream->links, NULL, link))
 		return -EALREADY;
 
-	if (stream->client != link->client ||
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
+		if (stream->qos.bcast.big != link->qos.bcast.big)
+			return -EINVAL;
+	} else {
+		if (stream->client != link->client ||
 			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
 			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
-		return -EINVAL;
+			return -EINVAL;
+	}
 
 	if (!stream->links)
 		stream->links = queue_new();
@@ -5377,7 +5468,9 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_io_connecting,
+						INT_TO_PTR(fd));
 
 	return 0;
 }
@@ -5433,11 +5526,58 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 	return true;
 }
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	/* Push remote endpoint with direction source */
+	ep = bap_endpoint_new_broadcast(bap->ldb, BT_BAP_BCAST_SOURCE);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	ep->bap = bap;
+	return true;
+}
+
+static void bis_to_pac(void *data, void *user_data)
+{
+	struct bt_bap_bis *bis = data;
+	struct bt_bap_base_subgroup *subgroup = user_data;
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+
+	bt_bap_ltv_merge(bis->caps, subgroup->caps, false);
+	pac_source_bis = bap_pac_new(subgroup->bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, &subgroup->codec, NULL,
+				bis->caps, subgroup->meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis->bisIndex);
+
+	if (err < 0)
+		DBG(subgroup->bap, "error in asprintf");
+
+		/* Add remote source endpoint */
+	if (!subgroup->bap->rdb->broadcast_sources)
+		subgroup->bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(subgroup->bap->remote_eps, ep);
+}
+static void parse_bis(void *data, void *user_data)
+{
+	struct bt_bap_base_subgroup *subgroup = data;
+
+	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
+}
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata)
+				struct bt_bap_base *base)
 {
-	bap_pac_merge(pac, data, metadata);
-	pac->codec = *codec;
+	queue_foreach(base->subgroups, parse_bis, NULL);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c8f9208e..ea49b13a4 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -97,6 +97,27 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t presDelay;
+	uint8_t numSubgroups;
+	struct queue *subgroups;
+};
+
+struct bt_bap_base_subgroup {
+	uint8_t subGroupIndex;
+	struct bt_bap *bap;
+	uint8_t numBises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t bisIndex;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -168,6 +189,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
 
 uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
@@ -176,6 +199,8 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -231,6 +256,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint8_t *id,
 
 void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -314,9 +340,9 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
 
 bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata);
+				struct bt_bap_base *base);
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter);
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index adade07db..d308d42f9 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -377,11 +377,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		g_assert(data->snk);
 	}
 
@@ -391,11 +393,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		g_assert(data->src);
 	}
 }
-- 
2.39.2

