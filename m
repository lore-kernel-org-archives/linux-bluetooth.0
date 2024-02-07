Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632D59B72
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308601; cv=fail; b=jYLHyVFBfHqpJU4F2xcZL+ztPvcfNe4REp806GaIencAMUBABXl4YUoMn+xXwwkiajcP96iUqKNJDz0hRGJZXX6Ba5JIiphuwNA4x7QEK7H2BlmxD1PeA8t+z4CBO8LxXActcMvyl7Cmtpz3x4uzaCHfJlgBHdFItVWMFVgcawE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308601; c=relaxed/simple;
	bh=yPSjGWuBlkwXVKOEuEKptm2LSK8+DKTdRtqFdPQVOnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUnZO4li5L2HrlcVwKaA09yT5LBiCOoVejAHFuo95N0t1C76D+Va0ow39nzRzemS27xHVgCjvC3ZYXXVlzL9KBNkMTpADrJIZANyGKU1btNR99Rt8SqwWMzB+0ajtCZ3NaevAoGsawcPzQjqdK7GILWScJt3rr54vyinnQziyfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mhDQMYR5; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mhDQMYR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBR1wa1gBZK/nhtmdUMKp3V3bIn1aVNZtyPClSeX/wjFoGv2kj0PMyY/1X2/pE2wO76z4pn9lGzA16BI5uGffnM/3CUm+vJ+LIt8S6s8UksNggrDsy7VyKKcqJsN/IuElzedl0g2fRzgleie4J6zVqDB7sZYm4F7E7MDX2yPYwdmk8DfIL4K1RTGbNjnA0V2jytTb4Jyd7+oZ81Z10xRzalfOYQITW2pOPs3FSzNiqX0D9lWuU/qPWez7CtP7xj0c3nhAtJKNqXxpdnb+P8TPqLMSbtE5ffOqFStTr/sp1U2wy29l2BTjWccJgxJ9UCfu83wzabZtN0dHznpql9+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt2e3M/HGvjvTO+q/RgTxDpRrwCsg2D4eblXxQdY8Bk=;
 b=EGjCikYrW5HInH3/Y/gOsMzMJzp6cN4db2Ydb2yDJf9oefieBhzI8dlyBlb3uiROwcVDo/6UBMPSH8UQv98dNyWDcH0gaY7rDvPEtbhN/JdHnp9ftsD4r9tYIwZIrszKp/w1wXHu8oUKos1D/qWavvw3oXAgxa6GfYXfEh0ES44MKkfMGO5N1Es5gMYzhJjofx1XKEsRMhQEXFGVzKQLAjXMoJHUAqMYdszqkGx6DBplkhFIIeiXGNV1N6lsH5y1RD7Uev9F3NiZIQbMeZK3LFlHY7P5Bl6XBXMKpHaDBsVr5Ke0OE9XNh+7tYXkQ5yB7/ULv4lPV2lnTv/8n3Q8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt2e3M/HGvjvTO+q/RgTxDpRrwCsg2D4eblXxQdY8Bk=;
 b=mhDQMYR5UeoFqlNDdEkhefL6iclkGdjcXMpY4fgZ7RQG9r4iN3/NSoOaBkxXXHEMKZTYXe59CtBZ8kPWCB7pEyS4gO1E65iQG/H4Zn1xzThEpQ4oc89ZArtO8S4H+FTIEhM3y71rrApO3b1/yF790Y1fZFOq7LpgyoERknxRRIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by GVXPR04MB9851.eurprd04.prod.outlook.com (2603:10a6:150:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:23:14 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:23:14 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/3] shared/bap: Add API to convert BASE into bt_bap_base queue
Date: Wed,  7 Feb 2024 14:23:06 +0200
Message-Id: <20240207122308.26457-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240207122308.26457-1-andrei.istodorescu@nxp.com>
References: <20240207122308.26457-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::18) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|GVXPR04MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6841be-35c3-4b64-3607-08dc27d78e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DlsZjDdznrfh4Onyy2jI6PteorBrU6QGCg2rTS6sWeIg90sWxJM+ENkK8xCsgEkqBCcrZGy0Rcf8/IiBJlSuBgaDzsPUfTPBlOB5I+unRWVNUj6pezMTW+PEaXeCs+dENPzatTdEHs1wJQNGY9YshTaTzvlE2PM1QoIVBAuvC+IQlBH2vcHylzs6lYDoBVEGWaJv8eEWqcp+8xXmF1lfQJSNWnpAWjxPt0Zix3aoOt0RGlxzmJxRnqSlV66RHgr8EBXnX2+lKH/v8cBPlC2F+OG/w0axgbzaJJm7IFFOClbHs8cXJ+090vSwzNeHbHf6MCdlOQQS2k5ztxGL4LWhJB5X38CmOuT6nsOgfNjb0v7EfThy0IwIsohifTsPj7U7hLdSctSco+2/NrRbi3Js1MXsYEoAOo5rzk/2aPoP4Ck6ic6u1EwhxTblAA9k7uQ+ltdcK/ERVphL/Qcepv3AVFmP1C0TgiyaKNP4cDRnwfag0oAENEUPfU6+Gf6M1ufu+ozPtmlN4qA2LhC/T5TLCFG9lz2OQD9cbb7nTxlniqQUwRfj9H5EZ5mcnYHecDL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6506007)(38100700002)(83380400001)(26005)(86362001)(41300700001)(1076003)(2616005)(8676002)(6512007)(4326008)(8936002)(36756003)(30864003)(478600001)(2906002)(5660300002)(6486002)(66556008)(6916009)(66946007)(66476007)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y3S1CznRRKtvs91RHFVau/HLKBcQBqtB/VpWeyifLtLpc2mUwLCmSvhoB8XI?=
 =?us-ascii?Q?LnOaNR7aRhYWz9jLiaJa2DJ/X71Hz33GySvz8pZGYElfTynufMEBZZaGmQYz?=
 =?us-ascii?Q?ptxjvJLNV5U0DE8ErFlgHX7i9LKteXI0NzFdm/Np8eZ4Iw3ZM0q2fsiswrAC?=
 =?us-ascii?Q?M2za+qejjDsJy7lJbeLjeWn/XkeYqHtxe1bnSRqBIFbLePc3ksygIrSaYN6Y?=
 =?us-ascii?Q?JVSKPChw2RUTMuBTQ8R5V39KBJRDVsEftssl/cUhDZU1u0AeVH4NxCoJZE90?=
 =?us-ascii?Q?wIS7lLunUGSFBF4BCRRTDPCnWDWv+Hyk04xjFSkoJVdkpHHgF82tq+zZIgzy?=
 =?us-ascii?Q?8XHK8lSFoD2RMS9RMB7sjo6xwQHkeJBX+LiVC+7O+cI86A0B1v/pJFEvNsKI?=
 =?us-ascii?Q?rkYp5aWeTzLlDhrisfO78/VOMG8vVPw1xRrjHFOD1+/yacheEu0lo/bOun0W?=
 =?us-ascii?Q?pzhX9Bbx1E0Xmn2w4d4eKe9NSLD6kZSQ1f1bN7VghyokJEakia2hnrCca37I?=
 =?us-ascii?Q?g3KVn+e+QYtRz0zXzqgqxSwOJXRgmCV84IEczel8yx/iIB0CxQMugjyEdQP8?=
 =?us-ascii?Q?O4AOr9Lfel0Fh16UEr29K2v90jHf7VNrczQwd1KpR3GK34ky1faPWAs7aUFL?=
 =?us-ascii?Q?sXkyYBmeNf/YUgeO0KbIicrXB0e/Ix7k9aUN8ybyOLPEiM75yDb+AUo0N9qE?=
 =?us-ascii?Q?xmPV5rBw0ZBBCjl+RXwCRBqnxgilIweSl15InSiOHTJqIJe1ufNwMiralwae?=
 =?us-ascii?Q?3eiJHp+ftvCJTTxMIbKFi4h4UbXxH3Pjbm3SMKgmM8fTSzZ7KHmExJK+rGeb?=
 =?us-ascii?Q?6fgw1EQ9F9VRuJtAQ570LD/42i3FT3xvDAQrPAu5ZRXM4i7Wz6KSRAK19uWL?=
 =?us-ascii?Q?oe0uFkS2MgC3FY11+AfWJu5/hp9vWpXMlMuhe3n115TWR6FRDJAkwDGVSYcy?=
 =?us-ascii?Q?d5shShj7aA0oyErDbF5a7F7RFWz3OTzq6+QW73ourv/Tt3q1TqnA0o+8pC9h?=
 =?us-ascii?Q?rJPk3UNKab6902Ivyrk/16wMBjS01b83n6zCx+70FUjyIev61ArjHLbarBCE?=
 =?us-ascii?Q?4/52p592e5UWZWEflyAPnQuwU4B5JavwT8Gk7jDm/q/o/s/8h/0sf+pK3H5t?=
 =?us-ascii?Q?TQb2JZeJZY8BWxMlvBNjbkucNTY/AWDIHpsHF+cuC+FAyOYZ1XcvrQQnzuen?=
 =?us-ascii?Q?Ip9lFD4nybiTDaRtUF73zhvwOcL7BXadx/mtk6EzdbvXry5oG1WZrHgJHStF?=
 =?us-ascii?Q?6S4gigQLe4hnsCcQIW0zailRqfyyUkGyDKpaz6nKwIo9QYxPbxkBXFivpwV8?=
 =?us-ascii?Q?YjlNDXEA+6fwDXjMnWtjTdz3JFxtqJPSbctj+vQWpYlwb+JXQDXEs0fmf6fV?=
 =?us-ascii?Q?4dpDO3y5e7TIH2Ud9mifgmTIkoZaZG/BG6WUxiyAZg7yYiNtx9okwgZK2spi?=
 =?us-ascii?Q?lQsiZeXkb3cTcc5TqZWDetZRzoBrhnr5aIbb8FCKxzAJ500jyuZK0bfc872j?=
 =?us-ascii?Q?41pKZtA7Z58npxVH0kxDMjjDctEpoEyOklo9aMwyr5QG5GeDSc9JL1+WGVGM?=
 =?us-ascii?Q?kz02G185S9MUl919Y5Pj4sVD+2tl8142C7HRrnWKofGJOo0tdHMfxDXy/7TW?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6841be-35c3-4b64-3607-08dc27d78e64
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:23:14.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pskNDJ9apiKxMvnrGd+bNcdzEVspbArGwAynNeDx5hstZsD48Dk9eM3Lk2hOD3I3Wjrd+XZVUdoT7+yNv5DoIGeLw0tlnmSw47h5MBAEzQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9851

Create public function to read the BASE bytes and populate a bt_bap_base
structure for further processing.
---
 src/shared/bap.c | 250 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |  27 +++++
 2 files changed, 244 insertions(+), 33 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 00d211c15ddf..aa78b1b74fbb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -255,26 +255,6 @@ struct bt_pacs_context {
 	uint16_t  src;
 } __packed;
 
-struct bt_base {
-	uint8_t big_id;
-	uint32_t pres_delay;
-	uint8_t next_bis_index;
-	struct queue *subgroups;
-};
-
-struct bt_subgroup {
-	uint8_t index;
-	struct bt_bap_codec codec;
-	struct iovec *caps;
-	struct iovec *meta;
-	struct queue *bises;
-};
-
-struct bt_bis {
-	uint8_t index;
-	struct iovec *caps;
-};
-
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
 static struct queue *bap_cbs;
@@ -5536,7 +5516,7 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 
 static void destroy_base_bis(void *data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 
 	if (!bis)
 		return;
@@ -5549,7 +5529,7 @@ static void destroy_base_bis(void *data)
 
 static void generate_bis_base(void *data, void *user_data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 	struct iovec *base_iov = user_data;
 	uint8_t cc_length = bis->caps->iov_len;
 
@@ -5566,7 +5546,7 @@ static void generate_bis_base(void *data, void *user_data)
 
 static void generate_subgroup_base(void *data, void *user_data)
 {
-	struct bt_subgroup *sgrp = data;
+	struct bt_bap_subgroup *sgrp = data;
 	struct iovec *base_iov = user_data;
 
 	if (!util_iov_push_u8(base_iov, queue_length(sgrp->bises)))
@@ -5604,7 +5584,7 @@ static void generate_subgroup_base(void *data, void *user_data)
 	queue_foreach(sgrp->bises, generate_bis_base, base_iov);
 }
 
-static struct iovec *generate_base(struct bt_base *base)
+static struct iovec *generate_base(struct bt_bap_base *base)
 {
 	struct iovec *base_iov = new0(struct iovec, 0x1);
 
@@ -5623,10 +5603,10 @@ static struct iovec *generate_base(struct bt_base *base)
 	return base_iov;
 }
 
-static void add_new_bis(struct bt_subgroup *subgroup,
+static void add_new_bis(struct bt_bap_subgroup *subgroup,
 			uint8_t bis_index, struct iovec *caps)
 {
-	struct bt_bis *bis = new0(struct bt_bis, 1);
+	struct bt_bap_bis *bis = new0(struct bt_bap_bis, 1);
 
 	bis->index = bis_index;
 
@@ -5638,12 +5618,12 @@ static void add_new_bis(struct bt_subgroup *subgroup,
 	queue_push_tail(subgroup->bises, bis);
 }
 
-static void add_new_subgroup(struct bt_base *base,
+static void add_new_subgroup(struct bt_bap_base *base,
 			struct bt_bap_stream *stream)
 {
 	struct bt_bap_pac *lpac = stream->lpac;
-	struct bt_subgroup *sgrp = new0(
-				struct bt_subgroup, 1);
+	struct bt_bap_subgroup *sgrp = new0(
+				struct bt_bap_subgroup, 1);
 	uint16_t cid = 0;
 	uint16_t vid = 0;
 
@@ -5784,7 +5764,7 @@ static struct iovec *extract_diff_caps(
 static void set_base_subgroup(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
-	struct bt_base *base = user_data;
+	struct bt_bap_base *base = user_data;
 	/* BIS specific codec capabilities */
 	struct iovec *bis_caps;
 
@@ -5802,7 +5782,7 @@ static void set_base_subgroup(void *data, void *user_data)
 	} else {
 		/* Verify if a subgroup has the same metadata */
 		const struct queue_entry *entry;
-		struct bt_subgroup *subgroup = NULL;
+		struct bt_bap_subgroup *subgroup = NULL;
 		bool same_meta = false;
 
 		for (entry = queue_get_entries(base->subgroups);
@@ -5836,7 +5816,7 @@ static void set_base_subgroup(void *data, void *user_data)
 
 static void destroy_base_subgroup(void *data)
 {
-	struct bt_subgroup *subgroup = data;
+	struct bt_bap_subgroup *subgroup = data;
 
 	if (!subgroup)
 		return;
@@ -5858,7 +5838,7 @@ static void destroy_base_subgroup(void *data)
  */
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 {
-	struct bt_base base;
+	struct bt_bap_base base;
 	struct iovec *base_iov;
 
 	base.subgroups = queue_new();
@@ -5877,3 +5857,207 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
 }
+
+static void cleanup_bis(void *data)
+{
+	struct bt_bap_bis *bis = data;
+
+	if (bis->caps)
+		util_iov_free(bis->caps, 1);
+}
+
+static void cleanup_subgroup(struct bt_bap_subgroup *subgroup)
+{
+	if (!subgroup)
+		return;
+
+	if (subgroup->meta)
+		util_iov_free(subgroup->meta, 1);
+
+	if (subgroup->caps)
+		util_iov_free(subgroup->caps, 1);
+
+	queue_destroy(subgroup->bises, cleanup_bis);
+
+	if (subgroup)
+		free(subgroup);
+}
+
+bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
+{
+	uint8_t num_subgroups;
+	uint8_t num_bis;
+
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
+		return false;
+
+	if (!util_iov_pull_le24(&iov, &base->pres_delay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", base->pres_delay);
+
+	if (!util_iov_pull_u8(&iov, &base->num_subgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
+	num_subgroups = base->num_subgroups;
+
+	for (int sg = 0; sg < num_subgroups; sg++) {
+		struct bt_bap_subgroup *sub_group = new0(
+						struct bt_bap_subgroup, 1);
+		uint8_t caps_len, metaLen;
+		uint8_t *hexstream;
+
+		sub_group->subgroup_index = sg;
+
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		sub_group->bap = bap;
+		sub_group->bises = queue_new();
+
+		if (!util_iov_pull_u8(&iov, &num_bis)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "NumBis %d", num_bis);
+		sub_group->num_bises = num_bis;
+
+		memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+			"Codec", sub_group->codec.id, sub_group->codec.cid,
+				sub_group->codec.vid);
+		if (!util_iov_pull_u8(&iov, &caps_len)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+
+		util_debug(func, NULL, "CC Len %d", caps_len);
+
+		/*
+		 * Copy the Codec Specific configurations from base
+		 */
+		sub_group->caps = new0(struct iovec, 1);
+		util_iov_memcpy(sub_group->caps, iov.iov_base, caps_len);
+		util_debug(func, NULL, "subgroup caps len %ld",
+				sub_group->caps->iov_len);
+
+		for (int i = 0; caps_len > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
+
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+			caps_len -= (ltv->len + 1);
+		}
+
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+		sub_group->meta = new0(struct iovec, 1);
+		sub_group->meta->iov_len = metaLen;
+		sub_group->meta->iov_base = iov.iov_base;
+
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+		for (int bis_sg = 0; bis_sg < sub_group->num_bises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t caps_len;
+			uint8_t crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &crt_bis)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "BIS #%d", crt_bis);
+
+			bis = new0(struct bt_bap_bis, 1);
+			bis->index = crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &caps_len)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "CC Len %d", caps_len);
+
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = caps_len;
+			util_iov_memcpy(bis->caps, iov.iov_base, caps_len);
+			util_debug(func, NULL, "bis caps len %ld",
+					bis->caps->iov_len);
+
+			for (int i = 0; caps_len > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
+
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
+
+				caps_len -= (ltv->len + 1);
+			}
+
+			queue_push_tail(sub_group->bises, bis);
+		}
+
+		queue_push_tail(base->subgroups, sub_group);
+	}
+	return true;
+
+fail:
+	while (!queue_isempty(base->subgroups)) {
+		struct bt_bap_subgroup *subGroup =
+				queue_peek_head(base->subgroups);
+		cleanup_subgroup(subGroup);
+		base->num_subgroups--;
+	}
+	util_debug(func, NULL, "Unable to parse %s", "Base");
+
+	return false;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921f07..b13fef688da3 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -98,6 +98,29 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t pres_delay;
+	uint8_t big_id;
+	uint8_t num_subgroups;
+	uint8_t next_bis_index;
+	struct queue *subgroups;
+};
+
+struct bt_bap_subgroup {
+	uint8_t subgroup_index;
+	struct bt_bap *bap;
+	uint8_t num_bises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t index;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -323,3 +346,7 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+
+bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base);
+
-- 
2.40.1

