Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B91C879E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767783; cv=fail; b=RyOd08vpNr5k85eYcLShLVJekC6wn7ZGjKonWDM4Ovg8fWpj6nWlQ1CkWix3cdOSYzC9El6ndfweXTOlaIaxERXZgHkP3b9OgIYVdHfzVF7UxmHzpaKTXSkZtIfkSe2qio6njCkENwKZf3DNEir21fUsxw4UnJBnawBeklPZr1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767783; c=relaxed/simple;
	bh=ucefT6OfmipidtrcCAGm5IVbEdm5IZbQNQOOVJ5jnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Te2QSPksE1unBpiDwWDkEOZPjNub21vtetGvK8nQDRgKNLcBZWZ9OAdLOQifP7cTm24bY6HU1hJGlEIZ0PhU3XqHvLKCeIVGdVn+ZVtf8StJm2cC+enThpVhNHcjlAtEs7YolNGU/cxKtHxhmH9ZAd7fZElFkUwsThzKxq8+H+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k2croH/g; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k2croH/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2Yv7lUTNCAjDD0r4JhzmF8/nl4R2/UXoJvfpLtP11hvEyH1ClcOY6irpQGBuyZEQEWxuOqsbJV4zX2jwcuyV1cCNEPpURayIoS5x6zgkLRMQdBBT7x6OETtaGHc44wMOf+5edE4F8fH49yFZvEufYSMJmYgSPeCQcecqEoe64LP5Bu/3qIgSaGsFRIHVBunZjenzd2QE7TZxjnr01sph55AtP8oDwE+qZ7IGHoj2SnWSfJe6a8U2jHdcGkU9qzVpd3Hr+n0KBQnnSgnubhUoQS2bLlLB9gA2DmWOwo3SPVa+5qT032es3/2qMp84qy2xJeGYR/FO/asRuNDwE2tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGv+Jqne9+oFo07LZMbU2TJ4o4hsoXrrxD4gv2nRhI8=;
 b=CKgeSYSn0AXc+y0jNbescu5xnDrDHj5zNq2r/046ywzXs2ruKuxiuND9gMDiruyLUCjjr094nfZWlBew0fRJrkxu18svRE0eEwYPQfDqRJnu1qmv8+0W/gqt5Z98CDOmlQ+Gi5zrndh9cBo/DwNkd9bTKAzzzVMzDu1duKmzyBss57/sfAQf6YdJv9GRddL6AOIGZtSd/WrdogPGRG8pf3Trd0M+eKd6reSkPRMjRiL/ziUtP7cwSu2ra6zw9C5O/77aTePB57nxituY0Lw0C1ozt0j1ILdLK5fbv6aJYk7agUYmGHdQoKQfu93SZPmoUwkH/gOe73wFerxjX/8F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGv+Jqne9+oFo07LZMbU2TJ4o4hsoXrrxD4gv2nRhI8=;
 b=k2croH/gnqtG83oSVcqzU75XCKlXIeqleXOCKSSHi2+7Ohe6vFhlk1Fnc3DBKNuWACl556Ase+WKKwLFfuA/gpmmd21/WNKov9frWyXp7WpFMiIu6sc2sS/CLR47ppoFLcMmDboiJHadAebILMGC3WpVnQWoPu3tBvzRIWr6j26AmiIbNqEStb62t/awM4dhVf96MU3PhCwmeaHvrhVnLAlwK7nskdozxBhgP8ycke2gF9Ylg86uLw70ugx1yN4gPiqVV8Lzr7uh1WH+1qULhoaN9xeNrxLk0YyYhpxc418zkqUP+GUBU2QNQoExXSBpzuqebmaFDpralfoDeEeUgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:02:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:02:54 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 02/14] shared/bap: Add support for handling broadcast links
Date: Thu, 24 Oct 2024 14:02:11 +0300
Message-ID: <20241024110223.77254-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 602b95a3-ceeb-4b81-55b3-08dcf41b6907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?reej14q6oI23S+gSXFKoIXwr/wlwgPPRG5php9qPJ147SMizrtVcFuypiOGk?=
 =?us-ascii?Q?cpaDTSGy3v1d1XxZLLuFc73oBQ/24heaALsHZu6220y3eMRUQgc/ThyhOhC2?=
 =?us-ascii?Q?fi+6Sz38PxagCsbq5lfJbKOQwcNP6BZQsrslBdwh59KUyCQVMiqx343TFlmj?=
 =?us-ascii?Q?4WWLKwatBrlcOlRbfs99o8g+owrkqa6xEReHLugJ43ukON2JRucBhsAveGhm?=
 =?us-ascii?Q?xRhsnrO08sIRfZ53k8BRB5a3XByJbCfA2PbMXn42ICkE+sWpvwkT/e+hhkxg?=
 =?us-ascii?Q?xkIurfJNC9xto57UUqumS48/AodLuIccrAN5+39jW3kDk0N28PoCxe+THhpm?=
 =?us-ascii?Q?JJN+N8KthcA1lW1WYNYKvH8eWsNzqbt4X3A8jsQmcidCwSIOY7Zh0ojrarj3?=
 =?us-ascii?Q?FIeXyo27zm0XQjpoHi0SVxCpal4E5zQ0KUPq7FnCVIGgX3IaG5B9lhRH2X1g?=
 =?us-ascii?Q?PqMdGXaF8xysYEl6aD0QD0j3J2IgFYKADXACRb+U8YdLH1zWclPj0iVr2FKr?=
 =?us-ascii?Q?wO5LdrNzJl5g8EmtPjpAYiI3elLUw4hGeUjcjl801Hn4mV+uPpvqeubND2mX?=
 =?us-ascii?Q?z6dVJVQ0wKBiOVKx0IIcoQ7UKo41NfHgkBfRqDgOCZc9YH4/V/7zHYaKddHD?=
 =?us-ascii?Q?xY1cR6qiy6//AkS17vGAGem2OnH1q5pmrD6KthJg0A9bH+FpBDxDi2noj35C?=
 =?us-ascii?Q?BaBGHbtUaJ4ELQEagwmMkkhPE+4hNPcWmEszFEgfuClS+/qfrWh7Xc0S9Nvq?=
 =?us-ascii?Q?lgRqWaVbe2qdsA7cTOGrt5vayKfaKcv1ozYES4Gg8scaPmK+OFvsNP3wA+Sx?=
 =?us-ascii?Q?Wf2+M3i+/ZRpg59KbiTz0DrrHo1hSJ8IvTeHBRrzeuzC7ZY1qTXc1TehQzSG?=
 =?us-ascii?Q?1fMlbdCoxYIZ9sgdPCjHANXGPL7pRqjlYkLynUmPXlij5J6c3ZzD90p5sOc3?=
 =?us-ascii?Q?XwRbX4OhnAt2TlIY6QbWJZctur1P6VuSb1bhKMr4QKUjxkQ/ZtYkPVY+Aar6?=
 =?us-ascii?Q?sJEsaXLQB2h1B9Onmp3DJ6RnN6UyVxBQMHSgy0eXWDrwoIhyGgfIX177g3qJ?=
 =?us-ascii?Q?L3fFKFFdwbFQdoECuZb9p9dQ1s8N15t36bbNIrSIf2lHfBNGPkDEHaNYp76s?=
 =?us-ascii?Q?IVgpDsswXilHEZ70epfWAn4//XMWLoVLXBcFc8KQCHsawpS9UrKTFNIdKVwY?=
 =?us-ascii?Q?CezlnRvYMsxBkuqbkaYw/p5SZGFY2c209bOEFTbrQ7WUTwIRUJV8QTL/PMWA?=
 =?us-ascii?Q?JJM/9g91ahsnf6CDFjihSz6gYFjGQhpFPq64WWC+/8B5/MESFR5TJb5u0960?=
 =?us-ascii?Q?93/NJOMw+6YPGhAAr2P/OJNZHjWJ/JP6WZjWDRZf04yIiVU3vGr0sznZ2zAR?=
 =?us-ascii?Q?eSX1kfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1LBUjcIAxbBHlGec0QYe4OvZiWf9VbF2k4LsDW/gGh07RbX82TPVk37IlYKV?=
 =?us-ascii?Q?VPsvM4mfNOspb15+rWSw9IbkThVQ8nHMpBcvSMd6oWcabwemUBI68oRUkO9+?=
 =?us-ascii?Q?nBFThHi+WXumFR3+/fb0sxLb/FhxQ8WNZBt6utFbWxKzwijqDjPuXkeJDCL7?=
 =?us-ascii?Q?tiYsxz54MbhCCigSShtaaXj3A9ktqqmaNcPR8rLJvdm+VsFd5nTgJECWbkmK?=
 =?us-ascii?Q?FkV1nQCbA9PfkA7+ZRkYpiKioMS6mfdQUDuJ+Qd2+RX7u3JKSyH4jwKNWk2O?=
 =?us-ascii?Q?4EP4le+xE2lhq4BmxC+zgcMMK9c9ybBVwWXQaZoDJTpZX2t4qqnP0ZfwmDh2?=
 =?us-ascii?Q?z5GoXaODT4yOU+nNiVfhUKYCCTRDYFrMOIJm7yjuJj8B0Yz2PgVQ48jFIocd?=
 =?us-ascii?Q?lT+Rfz/CIyuSN52b3odAFPpiizs5Yih4r0ZOu9uo8tJtQA/pUSSPkMtjJXQ3?=
 =?us-ascii?Q?BCD7GTNudpoxkIBjOjwCTiWxqMgTHw6PrQ7ZZgkicOGlqu5Y1d0R/rWCM3ly?=
 =?us-ascii?Q?3LEZAmIHr80Iqkg68lR5ZeX/tMuS3AMNk9d6jqtbsoTQMs6gfngX0qJhPm40?=
 =?us-ascii?Q?lo36RdRepdrDDK/qUSGjJ5AJf3P3b4AUJupbO0wRR5ce9UPc2ez88r1MsK3v?=
 =?us-ascii?Q?1yjlqUBHeiXIC/5ussDWoVHm1sLO0tujZ/r3CEbmIwrvd1b03KbeI84WEYEX?=
 =?us-ascii?Q?0ds4e6zn3YfFaY2srvZE0kbqw+dDU1UBROkVaMdH8XgRRZPQ0A2+JIKTAVCw?=
 =?us-ascii?Q?wdHu3bxwy0FAwMUWzZdcs7kD5usnNpzPyiyxVBcRHYq2Bhg1vD2dbs9OhXJ7?=
 =?us-ascii?Q?qt49PtgSv/kYTzqCiJTOOV01LoBsGw8XaaUqnwmuGSIRGl2KYZT9hxYykfOW?=
 =?us-ascii?Q?sIkK+Qc0bPhF2QXproy56y+0f3tv7wKR8lFZYQtEJNN6BEddS8VRwmrlwhRF?=
 =?us-ascii?Q?d2TVyNissDrGp2kldLDinaEOlj7d7ACuNwygxSMA2M8HlZQ9+UJApF4q2Hpt?=
 =?us-ascii?Q?XeSY15PLVgEwNRXpn6g7Tt5xKh9NK0zLeixCBaUoa8IgPwTARevPpHQYBp9W?=
 =?us-ascii?Q?XaRlsagdEq3rycAPU1FKhlp3ldv16S4dzlhwUtOb0psQZWlLAaCOvtXlZSQA?=
 =?us-ascii?Q?Nz3ItznAIdm2msMR0a3w87nd1Djq9ZgA5cFN/v5ScuRTuHHctti7fl4ng9Zn?=
 =?us-ascii?Q?CKIj1QBROZiEqQQ/Fz8viSY04xV8dEhoD9MuZ81OJRJsYrzK0xs4MV20HWvp?=
 =?us-ascii?Q?C3GTmZmeKg78ElNuALpc2rGRIUhurtxBgYDYXrY1jnFssLGAFwllifNNztCD?=
 =?us-ascii?Q?KP2CTCSWFyKJJlX23GigS1ZYX3OI84FX54EHEvgBr4FYHsTC2GEoSxWDTUEi?=
 =?us-ascii?Q?y7jwpiFq9M2YxPf1ZGg8y7x4Zhg332XR13aIHahSUtFjvi27TcRuZ+AxJ7M9?=
 =?us-ascii?Q?kB1mVjygzu2F9rqnrpa71MJnpWCsrKdV2mFWR1Q0RAPxPWWjLaR6Y9kYWyhh?=
 =?us-ascii?Q?jgpHRAg+30iNEOglBlxKJXQBo5urfchujb49rFyKA90EEel+5tGD+Dmc2B66?=
 =?us-ascii?Q?XihU8WbyV0nsh+N4pYYjKErnVdLJD8OrJ50tT69vPKUPu9CWpIlqpovcTBZm?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602b95a3-ceeb-4b81-55b3-08dcf41b6907
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:02:54.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSTLMQp/6JNRQv1X0Xz4oYuxRFwBeqM2CM7OZaoSF3Uk/7IVRWx93/l/pDIyzic6cCYr7SLqnsk7oIWM4TTnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This commit implements io handling functions as stream ops, since
broadcast links need to be handled differently than unicast:
Unicast links share the same IO, while broadcast links stand for
separate BISes with independent IOs. Unicast links have different
directions, while broadcast links share the same one.

This also adds a function for unlinking broadcast streams.
---
 src/shared/bap.c | 336 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |   2 +
 2 files changed, 291 insertions(+), 47 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1b70df4d5..ddf8ab84d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -252,6 +252,13 @@ struct bt_bap_stream_ops {
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
 	void (*detach)(struct bt_bap_stream *stream);
+	bool (*set_io)(struct bt_bap_stream *stream, int fd);
+	struct bt_bap_stream_io* (*get_io)(struct bt_bap_stream *stream);
+	uint8_t (*io_dir)(struct bt_bap_stream *stream);
+	int (*io_link)(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
+	int (*io_unlink)(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
 };
 
 struct bt_bap_stream {
@@ -324,6 +331,13 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static void bap_stream_set_io(void *data, void *user_data);
+static void stream_find_io(void *data, void *user_data);
+static void bap_stream_get_dir(void *data, void *user_data);
+static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io);
+static int bap_bcast_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -2238,9 +2252,194 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static bool bap_ucast_set_io(struct bt_bap_stream *stream, int fd)
+{
+	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+		return false;
+
+	bap_stream_set_io(stream, INT_TO_PTR(fd));
+
+	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+
+	return true;
+}
+
+static bool bap_bcast_set_io(struct bt_bap_stream *stream, int fd)
+{
+	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+		return false;
+
+	bap_stream_set_io(stream, INT_TO_PTR(fd));
+
+	return true;
+}
+
+static struct bt_bap_stream_io *bap_ucast_get_io(struct bt_bap_stream *stream)
+{
+	struct bt_bap_stream_io *io = NULL;
+
+	if (!stream)
+		return NULL;
+
+	if (stream->io)
+		return stream->io;
+
+	queue_foreach(stream->links, stream_find_io, &io);
+
+	return io;
+}
+
+static struct bt_bap_stream_io *bap_bcast_get_io(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->io;
+}
+
+static uint8_t bap_ucast_io_dir(struct bt_bap_stream *stream)
+{
+	uint8_t dir;
+
+	if (!stream)
+		return 0x00;
+
+	dir = stream->ep->dir;
+
+	queue_foreach(stream->links, bap_stream_get_dir, &dir);
+
+	return dir;
+}
+
+static uint8_t bap_bcast_io_dir(struct bt_bap_stream *stream)
+{
+	uint8_t dir;
+	uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+
+	if (!stream)
+		return 0x00;
+
+	if (pac_type == BT_BAP_BCAST_SINK)
+		dir = BT_BAP_BCAST_SOURCE;
+	else
+		dir = BT_BAP_BCAST_SINK;
+
+	return dir;
+}
+
+static int bap_ucast_io_link(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	if (stream->client != link->client ||
+			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
+			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
+			stream->ep->dir == link->ep->dir)
+		return -EINVAL;
+
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
+
+	/* Link IOs if already set on stream/link */
+	if (stream->io && !link->io)
+		link->io = stream_io_ref(stream->io);
+	else if (link->io && !stream->io)
+		stream->io = stream_io_ref(link->io);
+
+	DBG(bap, "stream %p link %p", stream, link);
+
+	return 0;
+}
+
+static void stream_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = (void *)data;
+	struct bt_bap_stream *link = (void *)user_data;
+
+	bt_bap_stream_io_link(stream, link);
+}
+
+static int bap_bcast_io_link(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
+
+	DBG(bap, "stream %p link %p", stream, link);
+
+	queue_foreach(stream->links, stream_link, link);
+
+	return 0;
+}
+
+static void stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = (void *)data;
+	struct bt_bap_stream *link = (void *)user_data;
+
+	bap_bcast_io_unlink(stream, link);
+}
+
+static int bap_bcast_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	struct bt_bap *bap;
+
+	if (!stream || !link || stream == link)
+		return -EINVAL;
+
+	bap = stream->bap;
+
+	if (!queue_find(stream->links, NULL, link) ||
+		!queue_find(link->links, NULL, stream))
+		return -EALREADY;
+
+	queue_remove(stream->links, link);
+	queue_remove(link->links, stream);
+
+	DBG(bap, "stream %p unlink %p", stream, link);
+
+	queue_foreach(stream->links, stream_unlink, link);
+
+	return 0;
+}
+
 #define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
 	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release, \
-	_detach) \
+	_detach, _set_io, _get_io, _io_dir, _io_link, _io_unlink) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
@@ -2256,6 +2455,11 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.get_loc = _get_loc, \
 	.release = _release, \
 	.detach = _detach, \
+	.set_io = _set_io, \
+	.get_io = _get_io, \
+	.io_dir = _io_dir, \
+	.io_link = _io_link, \
+	.io_unlink = _io_unlink, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
@@ -2265,28 +2469,40 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release, bap_ucast_detach),
+			bap_ucast_release, bap_ucast_detach,
+			bap_ucast_set_io, bap_ucast_get_io,
+			bap_ucast_io_dir, bap_ucast_io_link,
+			NULL),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
 			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
 			bap_ucast_metadata, bap_ucast_get_dir,
 			bap_ucast_get_location,
-			bap_ucast_release, bap_ucast_detach),
+			bap_ucast_release, bap_ucast_detach,
+			bap_ucast_set_io, bap_ucast_get_io,
+			bap_ucast_io_dir, bap_ucast_io_link,
+			NULL),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release, bap_bcast_sink_detach),
+			bap_bcast_release, bap_bcast_sink_detach,
+			bap_bcast_set_io, bap_bcast_get_io,
+			bap_bcast_io_dir, bap_bcast_io_link,
+			bap_bcast_io_unlink),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_get_state,
 			bap_bcast_config, bap_bcast_qos, bap_bcast_src_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_src_get_dir,
 			bap_bcast_get_location,
-			bap_bcast_release, bap_bcast_src_detach),
+			bap_bcast_release, bap_bcast_src_detach,
+			bap_bcast_set_io, bap_bcast_get_io,
+			bap_bcast_io_dir, bap_bcast_io_link,
+			bap_bcast_io_unlink),
 };
 
 static const struct bt_bap_stream_ops *
@@ -2372,15 +2588,23 @@ static void stream_find_io(void *data, void *user_data)
 
 static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 {
-	struct bt_bap_stream_io *io = NULL;
+	struct bt_bap_stream_io *io;
+	struct bt_bap *bap;
 
-	if (!stream)
+	if (!bap_stream_valid(stream))
 		return NULL;
 
-	if (stream->io)
-		return stream->io;
+	if (!stream->ops || !stream->ops->get_io)
+		return NULL;
 
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (!bt_bap_ref_safe(stream->bap))
+		return NULL;
+
+	bap = stream->bap;
+
+	io = stream->ops->get_io(stream);
+
+	bt_bap_unref(bap);
 
 	return io;
 }
@@ -5885,14 +6109,25 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 {
-	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+	bool ret;
+	struct bt_bap *bap;
+
+	if (!bap_stream_valid(stream))
 		return false;
 
-	bap_stream_set_io(stream, INT_TO_PTR(fd));
+	if (!stream->ops || !stream->ops->set_io)
+		return false;
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (!bt_bap_ref_safe(stream->bap))
+		return false;
 
-	return true;
+	bap = stream->bap;
+
+	ret = stream->ops->set_io(stream, fd);
+
+	bt_bap_unref(bap);
+
+	return ret;
 }
 
 static bool match_req_id(const void *data, const void *match_data)
@@ -5938,41 +6173,49 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 				struct bt_bap_stream *link)
 {
+	int ret;
 	struct bt_bap *bap;
 
-	if (!stream || !link || stream == link)
+	if (!bap_stream_valid(stream))
+		return -EINVAL;
+
+	if (!stream->ops || !stream->ops->io_link)
+		return -EINVAL;
+
+	if (!bt_bap_ref_safe(stream->bap))
 		return -EINVAL;
 
 	bap = stream->bap;
 
-	if (queue_find(stream->links, NULL, link) ||
-		queue_find(link->links, NULL, stream))
-		return -EALREADY;
+	ret = stream->ops->io_link(stream, link);
 
-	if (stream->client != link->client ||
-			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
-			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
-			stream->ep->dir == link->ep->dir)
+	bt_bap_unref(bap);
+
+	return ret;
+}
+
+int bt_bap_stream_io_unlink(struct bt_bap_stream *stream,
+				struct bt_bap_stream *link)
+{
+	int ret;
+	struct bt_bap *bap;
+
+	if (!bap_stream_valid(stream))
 		return -EINVAL;
 
-	if (!stream->links)
-		stream->links = queue_new();
+	if (!stream->ops || !stream->ops->io_unlink)
+		return -EINVAL;
 
-	if (!link->links)
-		link->links = queue_new();
+	if (!bt_bap_ref_safe(stream->bap))
+		return -EINVAL;
 
-	queue_push_tail(stream->links, link);
-	queue_push_tail(link->links, stream);
+	bap = stream->bap;
 
-	/* Link IOs if already set on stream/link */
-	if (stream->io && !link->io)
-		link->io = stream_io_ref(stream->io);
-	else if (link->io && !stream->io)
-		stream->io = stream_io_ref(link->io);
+	ret = stream->ops->io_unlink(stream, link);
 
-	DBG(bap, "stream %p link %p", stream, link);
+	bt_bap_unref(bap);
 
-	return 0;
+	return ret;
 }
 
 struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream)
@@ -6049,23 +6292,22 @@ static void bap_stream_get_dir(void *data, void *user_data)
 uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 {
 	uint8_t dir;
+	struct bt_bap *bap;
 
-	if (!stream)
-		return 0x00;
+	if (!bap_stream_valid(stream))
+		return 0;
 
-	if (stream->ep)
-		dir = stream->ep->dir;
-	else {
-		uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+	if (!stream->ops || !stream->ops->set_io)
+		return 0;
 
-		if (pac_type == BT_BAP_BCAST_SINK)
-			dir = BT_BAP_BCAST_SOURCE;
-		else
-			dir = BT_BAP_BCAST_SINK;
+	if (!bt_bap_ref_safe(stream->bap))
+		return 00;
 
-	}
+	bap = stream->bap;
 
-	queue_foreach(stream->links, bap_stream_get_dir, &dir);
+	dir = stream->ops->io_dir(stream);
+
+	bt_bap_unref(bap);
 
 	return dir;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index cd5ea2eba..126348e81 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -231,6 +231,8 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
 
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 					struct bt_bap_stream *link);
+int bt_bap_stream_io_unlink(struct bt_bap_stream *stream,
+					struct bt_bap_stream *link);
 struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream);
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
-- 
2.43.0

