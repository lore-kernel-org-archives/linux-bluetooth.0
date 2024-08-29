Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD61AE86F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935780; cv=fail; b=d7Pc0siDRArkYmqdElb0bNFWc+Ej5bPXe//bRVgI78yMQM1xOPBX+Q3de4Qz48icvUsbLVzxJiN7S37ril0LYMH2LsRbil0ZMKwiGmDC48wgS0wJwFvaB88Vxoo7R3aYjtXWQHYn2y1vQa8cB/RS5O3JmB3m94C9rxp6I+CSO7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935780; c=relaxed/simple;
	bh=bYtobMeCi93vQcLNCsgOIgdTn8jo1PkkdCVk58WJKQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lp1ppg2mwFaldziUiI6wFnIvkV8SrCq644W/xUNntTKxb0XI1156SbZS797SEdRNZtLS5OHky5OF358m+6ezuQtj5GmIVhoZIvnvkVUE3d5h9NDHIWMhrKAxDkqt7bCKhqWHDOSfsbsZ154E5ZaZCKE1+mwM1srL/spzEPCVaaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRuazCjQ; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRuazCjQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2Ve0NaLB3i1VFvisyzyaJPWXN+Rvdt9a5dnle0zTSlA3h48zOkRoIEArT0epWvD82ykFsoQ+B+Anu8fdy5dR1XgFZXRENmUbO8SnmGANl7yTfFWpouYpkBVcdYkr4wJNVkndRWtB2VG6JgJ6gv2XrYt4bi35vXbkq8OtyIqUWSfS5XsFTXCgpWyf7DJQdo6bsh2RRfG2HAj1UUL/p2j9MpiD0YvMq03lJsfrCOM8NEFSQgLVYmIOLEVX/B8gM01blEUkLWLrgvqhQOUpKWGd4xLeMJsaSZ/rIUBYqLREf6TvOO6AK3IbiLlrLzJcD+dMFZ9y4vgKyi9SlsXSpjenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgP1XS9qydvy8vPz2ZQts0LN3mcAD17o4NCBn7CUkYU=;
 b=uwN0QbXvVtf2sXfjvDPFP59pz/u4qJExcIT+AvN/DHaS5JG624xOMqJu2WPma0qAXNVZ5pQajJvgKjdQcYKmZw+ESqttfP941e/psIMTMiCeoGJzLArW+8rmFa4riM3mcVuiolI+NSvaR7Uy6NgmtY0GIpc/MNCvb74EQ88lbDN7CWBMINeOkNpgpLYREwrBvb9Kt1ZA4SYINona2MVN25MnVxaEzE8Ugx+ua23EqrYG/Z4pgpGZgaazK493OvfA8AyewSJEaEZUFYKlgOE1m0FdY1LyMWxPmDRlrnny6Xr42AlcOhnhFLnJz+mPXo3hjXTO8njSF9BIkZq4HD/mTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgP1XS9qydvy8vPz2ZQts0LN3mcAD17o4NCBn7CUkYU=;
 b=SRuazCjQZK+QFnkj6WIHwGLY2TjsWZUdsid1MJWvxSY98bOP92W8fW8W0P3VQ9g2lXTl6GAwmFQ5n+Qbha8oC57it2KIqJ7DOpbPpy1jzr4Iuq9dd4nLwsjsWmFjNrFlUWedVJherpadc6giUYrAVYrT/ccQV3FLpPtCM0KhMcUhPUtctX0iNiSH2399Vb+Hjg9zUW7q5rvFOMs8Qu0vD3Hi1cEMytw0cdbhyElvR9GjW++sNb9wuVZTaAvY7it1LqVDUYjEz58XdybzoP/t1tBvvGQ3D2gfk39pSe1V6gSk6pDoyIAXuLbYPjRKgJCfSN1+ZOGqp7J+8W5OmJ4QeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 04/16] shared/bass: Add support to register cp handlers
Date: Thu, 29 Aug 2024 15:49:06 +0300
Message-Id: <20240829124918.84809-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0103.eurprd04.prod.outlook.com
 (2603:10a6:208:be::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: cb359fc0-1a37-431e-76ba-08dcc8290a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMOuNGmO2KVIexvJl5PG9Ck2K7d6X3+GjfJtbduL5qzdjYZn8dkovGQ48uOP?=
 =?us-ascii?Q?6/x7LJTZet/KTTKK0AxQjMZSp3uJG267+TZE2m7qf7Muc1OTIBBZSi5MR5QL?=
 =?us-ascii?Q?51OrcEorxwohtmGLjYmljYAgtzm0OUFxMonJvdrJ1naHKAnbVF36QHY1VyPB?=
 =?us-ascii?Q?XWxngtHVHmAAKJmMtPJyJmoqowid37SLEzg2+/xIK8XlhRS8OPEncot1dALP?=
 =?us-ascii?Q?hORw+uHY6O2iwlLGkYs/GbQGO7PFDjZmTczN/SxA4bDRb5DvPNk1hEdF/2DO?=
 =?us-ascii?Q?ImALPIrjuIWezC9dxd1OKlF6wvOhdH9wL07RgiuKBYQEIBXoq8X62sN2EIYk?=
 =?us-ascii?Q?dM9DuDKqMQ1ov5ZK8jycj5cazKGwVPwRJFM2r43RHWYn9Zi9uvKjEZqIVLUV?=
 =?us-ascii?Q?ouICUCwmVj4+XFTqwQ2UUssmk6KFhPd3JRig8Be0/o20ccA4woyeY9eHVG51?=
 =?us-ascii?Q?qpo51nxauLhjD+8ODYOJHSje2exe9O2outvLTOpmYv0IJ+jcFhBFEao7CNX5?=
 =?us-ascii?Q?VKW6sNyAufn7pEe9/Wb2Peib4jKM6EGt9+NByPTI/51kjq29z+gN7S82j7Mc?=
 =?us-ascii?Q?yxTs1vX2jTFpAu7A4ZCKPp5nAVis59Jur7p5EaTe9pTlFex0EuwX458uAgVk?=
 =?us-ascii?Q?Lz6AdMSxdiIScct+54g4hJInJ4y6gtj60Ub/sfhbCJjgyq0CVf4PAnnwzwW3?=
 =?us-ascii?Q?rIRHpb+LlFMleJrKRrV+Zazd1lu2JApOviEkn96x4nmo/q9GYGEJa3U8tzeC?=
 =?us-ascii?Q?1Z8ocj4A+dodfnWyDQJr05E2lXP9yhvlHI8Hx1sQvYc4xfDUKPlXrLXz23JP?=
 =?us-ascii?Q?s7YfX6/Lzn0JprTifZa3UWQKVefGmrsXf8uwwulVJtBPdzprjxkM7qKoFwkh?=
 =?us-ascii?Q?56ZHciMiNarWAZdICtRm2iDTQQ7QaCh13CyM1xBO6LXovgSz29E1VA2spSAg?=
 =?us-ascii?Q?iR+610C5TKjjHyUbOLM/Z8+/wrsEBzO+wPqqHUqtcaM2H2pQKYJgZ3N/OZ1Q?=
 =?us-ascii?Q?bRZS3Cs6jBebWOXKgQzTIZNaGfO7+kFbIkDidTGzGDofTtJD9x2IOpVFlDbG?=
 =?us-ascii?Q?tm0X6tP3x+EikEr3QXnzlzu8TseArjVVefiLI6deLH2XRefpxQPHTIgfLM9c?=
 =?us-ascii?Q?zZztIR5p4iXauAnhEG5XJSGmiINCS0F7O7biBii7Y0qw7LSVzWZfOXJYiY9s?=
 =?us-ascii?Q?uEu6CwN/lKD1DH44TmgECbGO3ZOGoPmTdNPNbRumJhtgE9XzCQObI+roGJyB?=
 =?us-ascii?Q?/+M1iRASFuCkOvXUIQ1GGZaJ0c8ck+FabBq+JemY2IrCr0kE6wcPt9/yX9v+?=
 =?us-ascii?Q?zqncwPSjfFi52EAlfIDEqJA2CcfQMjfluacldsThjVbotA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NBA3hA7vAXMdZqOsvvK9Pas1+X9m0EMv9TwyQ3gYnxV2/brqMX1b3GoSnmiK?=
 =?us-ascii?Q?QyCr9xlA0vMyPupMMTdHnbEvg0phziVcXXsm8a5QppFBK0C1Zu+e87ea3OZl?=
 =?us-ascii?Q?+F/a4SOPv1Wq2Dwa2xAFyOsKa5Y+1m6rfEx3F5PNhZ1UV8wRhchnY0LJjyCC?=
 =?us-ascii?Q?i4+nTQVdLKnCU0PFmWnNovwuf66Dtl/fI8Fzuvny+XsRg5ro1jKFZxrtwwOX?=
 =?us-ascii?Q?YiUc6rSzNSYvyaLX+XhBq1gos3bMuOyFhAcSW427537em7hvOE7FH7r8pBMU?=
 =?us-ascii?Q?ckwsWmUP/gbpypaJTT9aH7Ewp9VP+o1R0+5PRPo81Iy64EWooNEREadWSAN1?=
 =?us-ascii?Q?UCWf7B8ICsF0NbTA/Lnz2IJLYjzHgjU3vhRcaeSi2VFyu6BzdH3FGIQELj4h?=
 =?us-ascii?Q?ms0Bifzs553LWsJoNmnwfw3MW0riBf5gzjd5uq4aVaK1TePG4ZNxUVlvaVtA?=
 =?us-ascii?Q?G6a4DhXVSLJKjdcFU7Jhg11TE9Kz+Gf06k9XMQHQLaOSPgrlRPnYlsJQ0f+f?=
 =?us-ascii?Q?Je4r1W6S53yWIKU5E8J95qLZS3Q+zbAQJQxKbkyvPKW9FdCBiROHcyR/DkDa?=
 =?us-ascii?Q?95Sfh8Aj93HM6gU82tp5hOH7Z4Hp80aAjpeLOtRApwgOcGQAZxu86GBCDt2k?=
 =?us-ascii?Q?myTsaIxL2LNKQT8iWtzczbMgaFpx7lFXliv9fcGdAwgwyIhmWx8xUEcOChS8?=
 =?us-ascii?Q?r4f9IdCVMzgOW06XzCjj7xE0ur/7KemuS4/87jasHNtrOwZCL7mzcDy8t9wO?=
 =?us-ascii?Q?KWlTR67keNKVGHq5WlFBw2I7wxcCU0LYR+dyioIV0SmXkw1E5+frOTxG6mW0?=
 =?us-ascii?Q?CxDxSItOxjVrgN4qDWLbu/8pgBVIGaf8F5ZfSODHelfN23LHQiKJ6sBwRh4r?=
 =?us-ascii?Q?tMCk2X42/NBfoGEJLIKoT+beWTxN4rKsd5c37+ZcWNcUvsgtIDUO+bTyOdQb?=
 =?us-ascii?Q?+/VO/tbGP96yQNUIvZn0oly6C7a3W2s4Zd+NmQYMGlizQUAD/PZ+Fi+3CAvl?=
 =?us-ascii?Q?WNuJ8GhF63vq1+5TBm4RbXV2x7aJqy4sRLXXyn1P64rLVUw6eGa6vxXpqNws?=
 =?us-ascii?Q?64N8ZcXXJnwZ9Igmcs9kLPlg7im21fI01qvgzH2ahlvTHi/1TNq97uLrm6gI?=
 =?us-ascii?Q?yMBVtnTY/Wm70T8Wf2mwRXZwRxiPNHApWfXtgfVrOLmrYOmjznl8k5yeAdzC?=
 =?us-ascii?Q?9bVtAS0Y/6fDG2ablNL7pIwcxh0VVZm+RFrk76rSEpoZ/9UXFn5K8P8Iif1y?=
 =?us-ascii?Q?tLtmtJJEiackscPUjpqs5UUg45u8sRJIUOOw5DQXwriYnyrIt3d/lNwLHOU7?=
 =?us-ascii?Q?qBaMl8JUAALb96cK0vC0BcP3nD8ybbH9ourTPfDXA4PWfNfLheDTajFL+iPa?=
 =?us-ascii?Q?8DUkr5tEg0Lb4F8vDaSiexLH37BxC95P64ySGGkq2lL9zBhWKWjqN+U/2/mc?=
 =?us-ascii?Q?4NsR20FaZ4NeFPyfqsSYeXGvO7pr8XWKqkHUuI5b2+8P8+WbQNCSFChdQVRJ?=
 =?us-ascii?Q?wECz9Ybhb2qpeYhx93e7eAShbNWaWB2olI/hIphQM9TeW7V7CsDOX+HOJUch?=
 =?us-ascii?Q?1Lt08lp+rtYb0Cvh9ZK0hT0aQNB3Vws1F4JpNnMkyYk5/WZPVMrz5pgt+zHx?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb359fc0-1a37-431e-76ba-08dcc8290a08
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:36.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRiyVYhdNiZ1iibgSPLhv7XGzjYCgTJzHa4xI9XJtnbm3TNTyQyXuGPwVPtf1/2fbn6rO3IdlaocQdD753uW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

The BASS Broadcast Audio Scan Control Point characteristic defines a
number of commands that require the BASS Server to sync to Broadcasters.
This should be handled inside the BASS plugin.

This commit adds shared/bass APIs to register control point handlers
with bt_bass. The BASS plugin will use these APIs to register a control
point callback to handle each operation based on opcode and parameters.
---
 src/shared/bass.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  9 +++++++
 2 files changed, 77 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 636eb24fd..635fe1054 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -66,12 +66,20 @@ struct bt_bass {
 	void *debug_data;
 
 	struct queue *src_cbs;
+	struct queue *cp_handlers;
 
 	unsigned int disconn_id;
 
 	void *user_data;
 };
 
+struct bt_bass_cp_handler {
+	unsigned int id;
+	bt_bass_cp_handler_func_t handler;
+	bt_bass_destroy_func_t destroy;
+	void *data;
+};
+
 /* BASS subgroup field of the Broadcast
  * Receive State characteristic
  */
@@ -134,6 +142,64 @@ static void bass_debug(struct bt_bass *bass, const char *format, ...)
 	va_end(ap);
 }
 
+unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
+				bt_bass_cp_handler_func_t handler,
+				bt_bass_destroy_func_t destroy,
+				void *user_data)
+{
+	struct bt_bass_cp_handler *cb;
+	static unsigned int id;
+
+	if (!bass)
+		return 0;
+
+	cb = new0(struct bt_bass_cp_handler, 1);
+	cb->id = ++id ? id : ++id;
+	cb->handler = handler;
+	cb->destroy = destroy;
+	cb->data = user_data;
+
+	queue_push_tail(bass->cp_handlers, cb);
+
+	return cb->id;
+}
+
+static void bass_cp_handler_free(void *data)
+{
+	struct bt_bass_cp_handler *cb = data;
+
+	if (cb->destroy)
+		cb->destroy(cb->data);
+
+	free(cb);
+}
+
+static bool match_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bass_cp_handler *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
+				unsigned int id)
+{
+	struct bt_bass_cp_handler *cb;
+
+	if (!bass)
+		return false;
+
+	cb = queue_remove_if(bass->cp_handlers, match_cb_id,
+						UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	bass_cp_handler_free(cb);
+
+	return true;
+}
+
 unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
 				void *user_data, bt_bass_destroy_func_t destroy)
 {
@@ -1418,6 +1484,7 @@ static void bass_free(void *data)
 	bass_db_free(bass->rdb);
 	queue_destroy(bass->notify, NULL);
 	queue_destroy(bass->src_cbs, bass_src_changed_free);
+	queue_destroy(bass->cp_handlers, bass_cp_handler_free);
 
 	free(bass);
 }
@@ -1513,6 +1580,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 	bass->ldb = db;
 	bass->notify = queue_new();
 	bass->src_cbs = queue_new();
+	bass->cp_handlers = queue_new();
 
 	if (!rdb)
 		goto done;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 086fe335e..2ca659cca 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -99,6 +99,9 @@ typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_bass_src_func_t)(uint8_t id, uint32_t bid, uint8_t enc,
 					uint32_t bis_sync, void *user_data);
 
+typedef int (*bt_bass_cp_handler_func_t)(struct bt_bcast_src *bcast_src,
+		uint8_t op, void *params, void *user_data);
+
 struct bt_att *bt_bass_get_att(struct bt_bass *bass);
 struct bt_gatt_client *bt_bass_get_client(struct bt_bass *bass);
 unsigned int bt_bass_register(bt_bass_func_t attached, bt_bass_func_t detached,
@@ -120,3 +123,9 @@ int bt_bass_send(struct bt_bass *bass,
 unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
 			void *user_data, bt_bass_destroy_func_t destroy);
 bool bt_bass_src_unregister(struct bt_bass *bass, unsigned int id);
+unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
+				bt_bass_cp_handler_func_t handler,
+				bt_bass_destroy_func_t destroy,
+				void *user_data);
+bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
+				unsigned int id);
-- 
2.39.2

