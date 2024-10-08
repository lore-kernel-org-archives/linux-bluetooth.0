Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DD1E885D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374524; cv=fail; b=TYqlc3uzTRVb9DUl+WK4vJ35Lg5XBC2L0U1nX7FguEG9g35SoTp+4YbwUMPLtac7mVC/scuKfUw78FZMtb/G2BjH5AtliuIUDG+fRt8XEbss7Yl0HC4Z8ITEZOxyJqNv16EW2hXiEP+tfNLffIoJkhs0+1fCKL2NwUjW454NQZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374524; c=relaxed/simple;
	bh=3cIlJqlDWZGa4xgJIfNL2YIOlUR4wIBEO1ZkeXCz7K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1jO1PBd8P3DYkgwyQMV8dbBDbqu6NNvf1Pgck1UAqRlu6FU6owZjfKJ+wzpEzwS+XQKMJCo23MEaOOPSpKzxbX43itLx/atSFSKfcPPa4V8PhyxARkbP2By/uVI9I1wv2Bu8CqINgKluE6zAdTonmmc91QvxJtEY8st64M8Pwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EMBAQvHr; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EMBAQvHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUjb8LhXO56XmYcgFWkk/cDbZFoJTcmcTs5kqGAfnfcxKoCgEwnz7tFPdBSH21yOFiYccOG5y+VQuMhTuj0yQ3HahjqVbiqjAmdHZasW2zhw703/Ru9KfjVVXDWuFgt2EqZrYYmQDf3zyXqZdHO/D/LDWybRwfyfb06dQmv6BA6g5piSmRZONeS7vWsGCmvzvCiWMvfXTdNc+Gr6eGXt0/O8IsItyCAUUTC0GiTssJy0z0a0qFbSwstLBQWa3+NQkkyGYBcH4YiHZTO2TwZI1jYKIApwPF4qWvxvJ5y/95wmzfMGgwdTC07hyzQ1K08pn6hR+uRefu/pTByK7R8HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQUw6Y/7nYzzKq7wKF7Q4unZeNz4MlwXy5mKli73RWY=;
 b=gc5J60Bn4FQE1FOL85PJPjXt4RlC3eWGLqiHvAcfH1YottkEEhJsH23tySH/Cd+hUw2gZdW5Vx+QuROX9OR1wbG7yEfifSaWIR6UtLI6VKUqo8rtoXmu3zaZwsszLQ2XSW2i3DUUFAA5tBSn56TwQNz3LjxB+np9ckBQk8eMJufTo1TGXFCTae+cBngShAIVs6Pdhz/ISo1tjdTqZU/UpFSkr8+tKt+v/LaIz25dlXUBnQR+XY97JgA0v+EW4izdgr+zGA1+Jw9Xl1d+eHTwEehK0SdFVeP1YwZjizwToWBreF4C7FPXTcaZ17KsMdb6wtZ0vw3fkwiK1P8HC5RQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQUw6Y/7nYzzKq7wKF7Q4unZeNz4MlwXy5mKli73RWY=;
 b=EMBAQvHrfmz0MURhgoQ5J9kloItxbGD+RrZIaQoYFS05K6ZSrXxgNYLIa+WzphNnr5dDIg++uyHYsa0Fx3lo0BVaoBI9yheXSUN/McsaKg3rDRZdGd43w97HjeCZRj15kt/6ioOB84BqFb7kGKyX2cTVABfZItHlilEj0me6YUK+UyPQ30gXxTE+wEbXle44jD+t9KwLpBK23U+LaCq5/RfKV93n4PUuXu+3oCodG/Y5IpOakWgcVvRN5R6hTFnVgl9AZM9BqERte4V9I7rTXSx8GQxw2XXdUO+TOu7UnoRTVrcE5ApZfLQvv6KSSCsRkeIa5/D7WiOQV3e6SqqSsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 08:01:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/7] bass: Add support to request bcode
Date: Tue,  8 Oct 2024 11:01:22 +0300
Message-ID: <20241008080126.48703-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 593bfc64-58e3-40f5-faa9-08dce76f7a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USf/qzdYRmzAkHPnT3eMc9X7opvtpmCHX7xuMrY0ZrzPKJTMLg/dJC6yWeee?=
 =?us-ascii?Q?sUKgIH7rLIWlYKAdUsc93xvwoayAVSCj57fI4T1sQvf8DegpvRdbIYeyUqnZ?=
 =?us-ascii?Q?niXFb82lSAXF4sjffa90uWNkjeesTIKP+OKT8HEVQCEUlFPoLVWMiLBxPoTG?=
 =?us-ascii?Q?jk/YzLJidMUQ4kiibI+DcrARgkO97YLBaJBaZYEqoL6V4kE6KRgaA6ERh7vT?=
 =?us-ascii?Q?Bq53HbfreaFMl45PqYmaOOReKvNQXRp3CpaUq8JQlGmpa8EE/YKyQo+x1Q79?=
 =?us-ascii?Q?JxPPF4KOucMsy1QCWu7r/6HPhkJDsRIPQmqbt8+UYOUJ2npxHgSwro//mF94?=
 =?us-ascii?Q?C6xA+UICV5bcofhr3Vbyx0Dhfemh/hTo1JfirnnSkB03uJDVoPqvr70KesX2?=
 =?us-ascii?Q?Z3hnoR/ATgqrlK2hwbt9HrpnlOIQlkjzrFXBIl5p33DOqoRDmIEZGNGmmBDM?=
 =?us-ascii?Q?zzWBFlYaviAfT9D4bJkPhi/HRNnV78Qw4qSexdyeBKXJb9NKVQ/nKEMXJovO?=
 =?us-ascii?Q?XwaCTpGG0tVJ+ErxSnjfUkSwb7GWczDiUgDx68raY7boht/+A6iqiucypkPL?=
 =?us-ascii?Q?3eMAkfBMRwMp/WKolNpFwk6ZjI3t1ZKcUVtfhYN6Umzej9J1dC9DPCwY1lja?=
 =?us-ascii?Q?dcthPxjlzOpVraoFR8D2LYFnZ7X/z/gL9Kmr+mxSQU3sE4Ay1eWGe3+3MJi4?=
 =?us-ascii?Q?kraXA3VrAWup7DKGz2VLiCY+PIPWm/n8upZAlYQZagrUBWk3N0IFOtiwGn/+?=
 =?us-ascii?Q?kAsaTpCxs8n8iXtCAzf4GeVoi4Ws3bkDEOlE+FGpPYdyMYow6H5GyoGxa4Dd?=
 =?us-ascii?Q?T+PugV4wXKDBb6Omjg/2YkgDGTsRJgCMyHHEAiPMX69+vOK3OisdS7GJ2oRz?=
 =?us-ascii?Q?fx2BKtifBtB+GWVclLgRVOS/fUO4XtnhGSgX7klJfavqLDK7bG25o/kC+TTc?=
 =?us-ascii?Q?5t23uq3zoCw5+/tGl/ansfUmyfBxbzAlUjA+OGMryFLYkdVukWqsYyA+ZGXo?=
 =?us-ascii?Q?8BQf7DhqRHYaYonH+tbS3oUmtOM32b3JVnVYef//Xqul4MJXKjCcdPkZZw1n?=
 =?us-ascii?Q?NE096xUIQOMJuY8MbNVKc0DU0H5KWk9ckflkD614+Pw4v1+bCLmJvboLQmkT?=
 =?us-ascii?Q?ecHFqT6QCBUO84zB1LmcZ365X4KZWs2m8rt+WIQkrQSvhiyJmHC9HWCKjO/G?=
 =?us-ascii?Q?LrqFXZB5n4Veo0kdht/DmMy5tyKUqR6BVM7TtmnImF7FSvHwGfM+T2VDycHv?=
 =?us-ascii?Q?D6EbE2mPlIaFL3yH6GTyVyVN9Iy6XhU5ATXi0XMg3l82GPlWZafU84tg86KN?=
 =?us-ascii?Q?lXVkOLHml5j1Wm3jX88qTJUgojcjJxHRQCoCEGkSTnSw5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcFEvvwK3Scp+7dTouB+N589lxNOES/0V2S6pLZHW8i49ogilucUH38DDMyY?=
 =?us-ascii?Q?YfBtXAe95KB8TZcRyYJgzJ1ApH6YJG728dv5gIDQSTA+8lJTrdFIerfbejqG?=
 =?us-ascii?Q?/ODjQLOsvXjgLs9JKy4FglmK4P7e5jgxEx9zY/yhFy2cYQaYuf2MdIV4HgUy?=
 =?us-ascii?Q?AsuwGLcUlWL/BCVok7jZlqy6PFXJ/HSN4Wu3HbHPq2JMysgGFJ+o+badrWu4?=
 =?us-ascii?Q?gbqX6KqRV+TxGllLy/qs7l628quIKQLZ9D7xBITtcGxKTZ11OWbrzR9cT1Ut?=
 =?us-ascii?Q?jU6W/Y5OyFsiVUM+EEunNbz1FciI3n9GYlHG3X/SiY1K0otHq4YBwWxWA/Ki?=
 =?us-ascii?Q?9RqShN+hXZMLrEWh4AbMO/fPsPwSEJCXO3Plws/BjyhaD1VisP6vgF/Gezzw?=
 =?us-ascii?Q?HO3ygA5m8uoLBNpIKV/MYCfEugP32eoQXylpNcbhNpYi+L+D7YbT9jJ5Kjm9?=
 =?us-ascii?Q?aLiueY8sC8gY1Mt26Cpk/eg3hxoMg1IpCocSX+wLzqt6xtSqv2fpaICgwYJx?=
 =?us-ascii?Q?PO7qvzLlURizwxL4+TLjhtkHx8rQTlkSzEoftr4enFqldRPVyLn6cAsoN10G?=
 =?us-ascii?Q?uxELDdRusBE04/tcZduZmcApKuHIqIUV5lYBjd0SWFSZGlcqe9zb8uTL2yGe?=
 =?us-ascii?Q?DBs7+jLMPsi/12furqmtv89u2roxoOO3l3u69tkdnSFMxb702BI2B2nIQL1y?=
 =?us-ascii?Q?oEeGO+gl2hI3pNu887NoXr7mG+jfE6Bd6iYDtXNjVL0xAzkT2kxGRT8qvpDC?=
 =?us-ascii?Q?XRJO98Kls22D7H7fGc5SAgOpaDiWRDw6SUbxA+TNSjhzJUtXVGxkgcjCv03V?=
 =?us-ascii?Q?0lFfF76a748fi1b+GpIL2FVqFzuNGvwHddAcZS4bpGfqt4PiUx33IwlKk6ih?=
 =?us-ascii?Q?CDM7ChBEI0IUNQaEUR0tTjpVUim+FMOTb0CYpxz87licdQkWp+RgwMmwQrhi?=
 =?us-ascii?Q?hjljIj7VoN0gpryU/XSRC1Xv767TBZqpSXZfdsFVDlZlcVd275c3V0cRBLTh?=
 =?us-ascii?Q?GNg4iPDfu4j6se+uuI2ZXY/aJa0Ok47SsOGUFgcCYjh4BdfVgmTX2hLDDNkF?=
 =?us-ascii?Q?2QxdQgE0pdYauFdo6eQIPgsObPdAPtmZffkn45nNMWVVWwlmSxY+mhU3zts/?=
 =?us-ascii?Q?blOzYkjnLKnBOX47DdNDgB55sEkVR2OFr39Tb3gngTXC8dQusJAXEpozUTSD?=
 =?us-ascii?Q?zZqGSDPxO2Yv1yyH2NRe59SQ/OX0xL5zWPKqq5I/kVX7Em310BL8CYOBtMy4?=
 =?us-ascii?Q?OFnODvpqscNhvJI3QsEQL5gVzYNYK+2clGhhZbGX4gA0TI/c3wvfLI9hVr0n?=
 =?us-ascii?Q?mUCGPT62RmCmRlWFnaNYNr2vHsujQkAmDVoe9wm+ylgXwyf5ej2N3HETCWPv?=
 =?us-ascii?Q?QiM0jdihCJf5YdWWbGDBeJ4mOvWG4zMqrvBN4imElYzq30J5tmXRkXZuTcjN?=
 =?us-ascii?Q?5UX2bpAAno6/afP29CmJaN4fhr3DMJ/w1EpbapOafF0Bl8ZAnFX9pgzCh4mH?=
 =?us-ascii?Q?y7KVCAe7bRIxMKoE7bKg5vPuYckWJjLHaOwXry1UlOcqo7ZFeorWK1uBwpHY?=
 =?us-ascii?Q?Z71zeLcAS9kj+uxisZ2p6ITd4+5gdqIxcFLYqSLISTXyRjzuoGiYGCs7O1uD?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593bfc64-58e3-40f5-faa9-08dce76f7a70
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:56.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqsFukOAMS6NNtbT4oyqCyIYueJNlb5xFrbl3EW8F9Ncu5g1sii/UcvHh3fzjybeUrHJvHIujaM/EdhXkCHJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343

This adds support for a Scan Delegator to request the Broadcast Code
from peer Broadcast Assistants and to update a BAP stream QoS with the
value.

A BASS API is added to update the BIG encryption status of a Broadcast
Receive State characteristic and to notify peers. When a peer provides
the Code using the BASS "Set Broadcast Code" operation, the BAP stream
QoS is updated. The driver calling this API will pass a callback as
parameter, which will be called to signal that the Broadcast Code has
been received and stored in the stream QoS.

A timeout is set to wait for Broadcast Assistants to provide the Code.
If the timeout expires, the callback will be code with the appropriate
error status.
---
 profiles/audio/bass.c | 141 ++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/bass.h |   6 ++
 2 files changed, 147 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 7553d1bec..6237f5acc 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -104,6 +104,15 @@ struct bass_delegator {
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
 	unsigned int state_id;
+	uint8_t *bcode;
+	unsigned int timeout;
+	struct queue *bcode_reqs;
+};
+
+struct bass_bcode_req {
+	struct bt_bap_stream *stream;
+	bt_bass_bcode_func_t cb;
+	void *user_data;
 };
 
 static struct queue *sessions;
@@ -117,6 +126,90 @@ static void bass_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static gboolean req_timeout(gpointer user_data)
+{
+	struct bass_delegator *dg = user_data;
+	struct bass_bcode_req *req;
+
+	DBG("delegator %p", dg);
+
+	dg->timeout = 0;
+
+	while ((req = queue_pop_head(dg->bcode_reqs))) {
+		if (req->cb)
+			req->cb(req->user_data, -ETIMEDOUT);
+
+		free(req);
+	}
+
+	return FALSE;
+}
+
+static bool delegator_match_bap(const void *data, const void *match_data)
+{
+	const struct bass_delegator *dg = data;
+	const struct bt_bap *bap = match_data;
+
+	return dg->bap == bap;
+}
+
+static void stream_set_bcode(uint8_t *bcode, struct bt_bap_stream *stream,
+				bt_bass_bcode_func_t cb, void *user_data)
+{
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	/* Allocate Broadcast Code inside stream QoS */
+	qos->bcast.bcode = util_iov_new(bcode, BT_BASS_BCAST_CODE_SIZE);
+
+	if (cb)
+		cb(user_data, 0);
+}
+
+void bass_req_bcode(struct bt_bap_stream *stream,
+				bt_bass_bcode_func_t cb,
+				void *user_data)
+{
+	struct bt_bap *bap = bt_bap_stream_get_session(stream);
+	struct bass_delegator *dg;
+	struct bass_bcode_req *req;
+
+	dg = queue_find(delegators, delegator_match_bap, bap);
+	if (!dg) {
+		cb(user_data, -EINVAL);
+		return;
+	}
+
+	if (dg->bcode) {
+		/* Broadcast Code has already been received before. */
+		stream_set_bcode(dg->bcode, stream, cb, user_data);
+		return;
+	}
+
+	/* Create a request for the Broadcast Code. The request
+	 * will be considered handled when the Broadcast Code is
+	 * received from a Broadcast Assistant.
+	 */
+	req = new0(struct bass_bcode_req, 1);
+	if (!req)
+		return;
+
+	req->stream = stream;
+	req->cb = cb;
+	req->user_data = user_data;
+
+	queue_push_tail(dg->bcode_reqs, req);
+
+	/* Mark the encryption status as "Broadcast Code Required"
+	 * in the Broadcast Receive State characteristic and notify
+	 * Broadcast Assistants.
+	 */
+	bt_bass_set_enc(dg->src, BT_BASS_BIG_ENC_STATE_BCODE_REQ);
+
+	/* Add timeout for Broadcast Assistants to provide the Code. */
+	if (!dg->timeout)
+		dg->timeout = g_timeout_add_seconds(10, req_timeout, dg);
+}
+
 static bool delegator_match_device(const void *data, const void *match_data)
 {
 	const struct bass_delegator *dg = data;
@@ -233,6 +326,13 @@ bool bass_bcast_remove(struct btd_device *device)
 	/* Unregister BAP stream state changed callback. */
 	bt_bap_state_unregister(dg->bap, dg->state_id);
 
+	if (dg->timeout)
+		g_source_remove(dg->timeout);
+
+	queue_destroy(dg->bcode_reqs, free);
+
+	free(dg->bcode);
+
 	free(dg);
 
 	return true;
@@ -794,6 +894,7 @@ probe:
 
 	dg->device = device;
 	dg->src = bcast_src;
+	dg->bcode_reqs = queue_new();
 
 	if (!delegators)
 		delegators = queue_new();
@@ -808,6 +909,43 @@ probe:
 	return 0;
 }
 
+static bool delegator_match_src(const void *data, const void *match_data)
+{
+	const struct bass_delegator *dg = data;
+	const struct bt_bcast_src *src = match_data;
+
+	return dg->src == src;
+}
+
+static int handle_set_bcode_req(struct bt_bcast_src *bcast_src,
+			struct bt_bass_set_bcast_code_params *params,
+			struct bass_data *data)
+{
+	struct bass_delegator *dg;
+	struct bass_bcode_req *req;
+
+	dg = queue_find(delegators, delegator_match_src, bcast_src);
+	if (!dg)
+		return -EINVAL;
+
+	dg->bcode = new0(uint8_t, BT_BASS_BCAST_CODE_SIZE);
+	memcpy(dg->bcode, params->bcast_code, BT_BASS_BCAST_CODE_SIZE);
+
+	if (dg->timeout) {
+		g_source_remove(dg->timeout);
+		dg->timeout = 0;
+	}
+
+	/* Set the Broadcast Code for each stream that required it. */
+	while ((req = queue_pop_head(dg->bcode_reqs))) {
+		stream_set_bcode(dg->bcode, req->stream, req->cb,
+							req->user_data);
+		free(req);
+	}
+
+	return 0;
+}
+
 static int cp_handler(struct bt_bcast_src *bcast_src, uint8_t op, void *params,
 		void *user_data)
 {
@@ -818,6 +956,9 @@ static int cp_handler(struct bt_bcast_src *bcast_src, uint8_t op, void *params,
 	case BT_BASS_ADD_SRC:
 		err = handle_add_src_req(bcast_src, params, data);
 		break;
+	case BT_BASS_SET_BCAST_CODE:
+		err = handle_set_bcode_req(bcast_src, params, data);
+		break;
 	}
 
 	return err;
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 5e34db90a..257346374 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -16,3 +16,9 @@ bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
 bool bass_bcast_remove(struct btd_device *device);
 
 bool bass_check_bis(struct btd_device *device, uint8_t bis);
+
+typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
+
+void bass_req_bcode(struct bt_bap_stream *stream,
+				bt_bass_bcode_func_t cb,
+				void *user_data);
-- 
2.43.0

