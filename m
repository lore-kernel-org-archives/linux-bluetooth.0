Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA072D04B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344921; cv=fail; b=ajPPvoijrWOTHrV8P/Ljz+bg47FV8+8Ncc0QtA3LeP3IkGhvhB3MvMGVX9qUPtKa8HOSwe0Hxa96a6/H2AsywbwCSGcLfg5VHexKhYRkJxl5TJ+qZs8MHlqi+8AmOQbUJAEsGOVIzC77KW2lHiENtyEqXO3UKbjzZUU2fHn8G4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344921; c=relaxed/simple;
	bh=UcSKOeRUVuNBQYV/M3sgW3TBRLQFbsqeUJnPPqzwFNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAQplB0FW3WKP5nsLfXKqZ06jvar32+4SlfjPPwlDxF3eqChnYRNCYB4Fzi3LUt6svQsZVnokLnB0lE//tNrhoeyoS2Mmoq0YJ5qqFxEMPxovn8dsM92xYhlhuxdjNNxpyj3w5Gm4q1vGmakVeW0KJGxctYeh29zMOvay2S0j5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O5PEULnB; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O5PEULnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwAX7r72T1de2FMt5BVGC0j61TUyDYupv3v+1KA8MuIiITaQrLav91vKrjyX1Y51EERJtpjb7KXct+xqDgLvTBmhU+4p504BTOdOKlHECUVJGIE0Fyji78UaoiFVepoiJ+ZUQMxwXzAc/EZCjzgUPoPqUIo8UOe7CSylmVMrb8bD+QN8P3Oz3Uen+pXZPUuyb65oyXAC2DIcC8R6VPODzgjHnTVAgIKeEtXUIsQaH2cEdemaItV7pocZ2p0/y/ySgtA4sRqW8IgH1v2KFPfQNa9PkQ8MVd87lYDRAKuo0vY3S9S79XGIwo7Qw0qObt1EgufH0WSdx/kVuN73TAjgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu/Y57aVkzLZAvngIF8NaTXxbDGglPoTNZIrv0D9lwk=;
 b=RJTYAnmIl1tkt4cYDw3rHOHihp2fQYJbUPkXTzASlQmRcroVXGW6PpRUeVUhXQqod7/ApTeuuo219w9o5foKzCkjEu5WmpZNr/CBwEQSJHQKtoSXmRoqK+7tnlrWJF78uVugY0DFIe67ftqOxAjT5zCo5gxAF5F6nLNewW7gYK7BPyho4iQ6tx2A+WnHJZVt7WPxDWVvkDwRj9aRg2DVbi9u9U9fdGL80yACyQgnjmHF/Wd4u9gANiXp6feJ+Se9Om22SgtEG+yNmvpzytvjKU//xjAzkPYl8x4MDtkwkTUOUz195icDQCB2fX+95kcDJeYyfN2HP1KTW0LpsqXV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu/Y57aVkzLZAvngIF8NaTXxbDGglPoTNZIrv0D9lwk=;
 b=O5PEULnB+RRDmp8yZEnMxPCeLsjV9ULJSPmLdpRs+wDfod1pJi92yhlIi2HWhTsNCoX5cHRDDhcFtSXp9TvzN9Z7E8nHLQ5OPlgRGPuDug8zOOwTdC5dEVVaDn0boyuCFUTTRUG+t1gmNvYyNDfhZP3hD05UEdt/urVld4TahiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:15:15 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 12:15:15 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 1/4] shared/bap: Add API to convert BASE into bt_bap_base queue
Date: Mon, 19 Feb 2024 14:15:06 +0200
Message-Id: <20240219121509.5702-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::16) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 827f75db-6c67-44b5-1c3a-08dc31446e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pHsHaeNlVReGR8RhHI8OtrJlrER2xXEXYjcszKi8wMp/+65z7o3UHS8XKdB9ID6EqvhlZUvHmyj7MPsEUMIpbDB17PlION4rHeTNRELISLUFOTqTJJlFgJXk1dAJ5i5sb9WZeZPK1k7Y1EgEP5c+cX4CMMgioKc/MZsUH+BGBYGgBZIwfhFRSM//jSWr5YmfnwwYFVIJC4BY84LJdPASw66x34bnZRhZ/x8Q5bjL/Dm/4vahviea9RaqaH7BRSFTGa/sfbF0F83XZ9PJfXeujkiOF/fkp2lVKiq7nY6rHzmrEMbZs4iF4BZzGpkX3F2PTFjQjNt/d3mm2h7guWd/Be06abpLTQ7wDKXgizqNCdzDJgb4eTjWdGQOl8n6qsAI0y4gwvwhQs0bryTp/KiZ7roOAjDih69my5F4CQyb3XjwZYTyXSvFWVwvGQpn8Fm92L1ZDReiNakUBiwuJ0PaLoyQqk0tVQGckik8KfNCz3H/Q4rkDQs1ACEj6k7q5klB9Jh7lq+cl55VJUuDGonvOrJwPKQI4q1B23X9RKoUReY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ReHpShcKkl1OLGTcqeyihTOzqhFOpAA5GznPbXL0Bk1qvL+9ivkVUHB6CqSv?=
 =?us-ascii?Q?+o0KJ9ZFRiQ+SxDpzVEwFfxFQ29GFEj2lRSqCxP3S8W7nBWzj1k1dk1cFWgt?=
 =?us-ascii?Q?cqqnAKXGijnXO6nq+WiFeba+mq0fNIWA/I9NhZ57qq+gyThyj7aRyaq2yQFG?=
 =?us-ascii?Q?6sbE92fFbftLH2E61xh8riCF/Rjrcz5CortILpEp7KGq87du+wb9yw0kDsr6?=
 =?us-ascii?Q?In2A1MNG4lxoeqoCtg3MdGpT41/2DTIA6n2XwYGItkzil0IEdNGvZ+LeR+KP?=
 =?us-ascii?Q?P7gw6tHenHWkL8m1XZdsiEajjZ/dy2+qamKuqTsBpds+89482VlHPeipqw2j?=
 =?us-ascii?Q?7IggBUvEscNk6X0e5SG6SNkybPAGVhP1CtSYnjQLW9bzJ/R74LQ2EmF10TUl?=
 =?us-ascii?Q?4Cr4NS3sEYrxK3pjwdT0HRwZRu2QA2YkUFWyTYRW2Z/87lgWUumiDobyCjUw?=
 =?us-ascii?Q?Qe/WBg48FAcjHmgLW1Bugbx+dYH7s1yY+R2J+gRIAyeV4tqihgq5xAiqgk55?=
 =?us-ascii?Q?J68xAI/LuzqE4md57MndpKgHgc+xFUBiISqyD4fA9zJJqc6Fj/kh4KLIfiKF?=
 =?us-ascii?Q?TaDmAk/HcvqZ9z5nDz1N4voIf4gCYMIWY3w3YxAN7EUliXBl1CEphY911qbA?=
 =?us-ascii?Q?zcxlPTkApzsPTrwqMCiRSLPixnt4w/8ZOLkKRy0VSTZOJ4udjelH76Pgft+c?=
 =?us-ascii?Q?+IOtEC+6p1HTB5vwpzZAmCqe65myjKN0OYe+PBAjZZyJYIvbwhcwcPR6VONN?=
 =?us-ascii?Q?nAUQ1k0LhgFUtNCdctmA0wYCI1i0G24pB0YzjNCajdj/iZs0xaYgZCZQVoAD?=
 =?us-ascii?Q?mp1zScm+Abmlo5+g4TacASKuXZ6gzLhHRP30On5oQBz/FR+w0Yjkq8APAYWi?=
 =?us-ascii?Q?+nx9X49ELaWDwJEISK2Lwps4or2MSMlSP+bYzeTfFvQz1q1BoCkvPj7Ik17l?=
 =?us-ascii?Q?uIwI0EgjdwBmZbYUJlkeLG2aoSU0/pzKDyxK/g+lw+jxA7WHBwfl4iZz7teN?=
 =?us-ascii?Q?d4a+iARqQ20D5Jvyoa+NNrLjXLKFTf5atPBiJKM2MtyAsrIEhX+Noacr7ud4?=
 =?us-ascii?Q?J/0bTxLJOWDfkg8fOzGr8nR1st8sG/fg7XEiYpIvbg6EVsQ74zgJdWCKsAOU?=
 =?us-ascii?Q?D0MKr3AFS7+VD3kFClswZqjRcvLb7q7oFn1c+2vT5o5qLof9EUeuJTj6BOTZ?=
 =?us-ascii?Q?LjFivD8Raz81ylcHxy6LyZgajpaDdmVQojwELsDuBAh7slEeX1wuN2HVqIPL?=
 =?us-ascii?Q?WSGLShISA0nsTYDzoZ/4dgHAH2KcXmWHXvIcL6MhNY/QsIj9PpNZmil2Ec2q?=
 =?us-ascii?Q?BOYw9hxLejcgtjiJjGPde6iRJCqoUF8grt0q78iIKUbdAZ1Rg2OAa0p2fwcL?=
 =?us-ascii?Q?hRi9X6+to8iGX+KDLwmpqwhbdXk0/enlFVd3r3Ea+W73/z4mb8FLt6qGqxsj?=
 =?us-ascii?Q?vCmz2ZPiWm5rtZtpQ7yjFVUEBKyX1B3s3/LHEDuP+lOrWRfvOVIHkj9vYftw?=
 =?us-ascii?Q?r4sT4DcWPKsT3fZc3MnRvOc+4nPzqpLmgjkGtk15D/rWiBoESlYLzfO8fg8I?=
 =?us-ascii?Q?Ys3YWoeg1g4lWiXcTLQT4/vN/2Q27KzcDjTNEq4KhuZ3P6t63c4Px9Vst671?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827f75db-6c67-44b5-1c3a-08dc31446e3c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:15:15.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uspm6QW1sXCAgRnCPb6K1Ccux3LgMNqBPVaTlb/CQ8E8ghxSmr02CAGqZqEcR1E5SLOSe3GQtM1eVjO/UHF5uOP7lDCwOe0eASZQBfzn8Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

Create public function to read the BASE bytes and populate a bt_bap_base
structure for further processing.
---
 src/shared/bap.c | 250 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |  27 +++++
 2 files changed, 244 insertions(+), 33 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4cc81844f1be..f688e1ad53fb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -282,26 +282,6 @@ struct bt_pacs_context {
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
@@ -5765,7 +5745,7 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 
 static void destroy_base_bis(void *data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 
 	if (!bis)
 		return;
@@ -5778,7 +5758,7 @@ static void destroy_base_bis(void *data)
 
 static void generate_bis_base(void *data, void *user_data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 	struct iovec *base_iov = user_data;
 	uint8_t cc_length = bis->caps->iov_len;
 
@@ -5795,7 +5775,7 @@ static void generate_bis_base(void *data, void *user_data)
 
 static void generate_subgroup_base(void *data, void *user_data)
 {
-	struct bt_subgroup *sgrp = data;
+	struct bt_bap_subgroup *sgrp = data;
 	struct iovec *base_iov = user_data;
 
 	if (!util_iov_push_u8(base_iov, queue_length(sgrp->bises)))
@@ -5833,7 +5813,7 @@ static void generate_subgroup_base(void *data, void *user_data)
 	queue_foreach(sgrp->bises, generate_bis_base, base_iov);
 }
 
-static struct iovec *generate_base(struct bt_base *base)
+static struct iovec *generate_base(struct bt_bap_base *base)
 {
 	struct iovec *base_iov = new0(struct iovec, 0x1);
 
@@ -5852,10 +5832,10 @@ static struct iovec *generate_base(struct bt_base *base)
 	return base_iov;
 }
 
-static void add_new_bis(struct bt_subgroup *subgroup,
+static void add_new_bis(struct bt_bap_subgroup *subgroup,
 			uint8_t bis_index, struct iovec *caps)
 {
-	struct bt_bis *bis = new0(struct bt_bis, 1);
+	struct bt_bap_bis *bis = new0(struct bt_bap_bis, 1);
 
 	bis->index = bis_index;
 
@@ -5867,12 +5847,12 @@ static void add_new_bis(struct bt_subgroup *subgroup,
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
 
@@ -6013,7 +5993,7 @@ static struct iovec *extract_diff_caps(
 static void set_base_subgroup(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
-	struct bt_base *base = user_data;
+	struct bt_bap_base *base = user_data;
 	/* BIS specific codec capabilities */
 	struct iovec *bis_caps;
 
@@ -6031,7 +6011,7 @@ static void set_base_subgroup(void *data, void *user_data)
 	} else {
 		/* Verify if a subgroup has the same metadata */
 		const struct queue_entry *entry;
-		struct bt_subgroup *subgroup = NULL;
+		struct bt_bap_subgroup *subgroup = NULL;
 		bool same_meta = false;
 
 		for (entry = queue_get_entries(base->subgroups);
@@ -6065,7 +6045,7 @@ static void set_base_subgroup(void *data, void *user_data)
 
 static void destroy_base_subgroup(void *data)
 {
-	struct bt_subgroup *subgroup = data;
+	struct bt_bap_subgroup *subgroup = data;
 
 	if (!subgroup)
 		return;
@@ -6087,7 +6067,7 @@ static void destroy_base_subgroup(void *data)
  */
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 {
-	struct bt_base base;
+	struct bt_bap_base base;
 	struct iovec *base_iov;
 
 	base.subgroups = queue_new();
@@ -6106,3 +6086,207 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
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

