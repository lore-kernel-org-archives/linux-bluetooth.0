Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AE2003C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858947; cv=fail; b=GWwKmi7koy3/tls0k5iJUQ4TeEe1LLK03jQpAJJzq2869u7Q2SYq1ItxQ41nryMm8FS1aXMVMjt8nvsgmpF5mMecUeHVRf+BNXzHQU9qhdVsGIXyNe7ZuPa+Efub1w7SAb3rPcbWm3R41pEV21gzVQ6DFwHGZJNGUncVh+TG6hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858947; c=relaxed/simple;
	bh=KCTXfeS1Vp4ztM2OxZH8DnCVQvjzPo60dgO0s5W8r0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6HEQEAOYtNVarvtlRS53pJfxc6fAvWVSERwy9raSGSBM4PUrvzlwmb0+Qo+rLEBd91BCSKlB7OHY9zH5zNBFRfnfmyzB0aPTTikxuy3jcPUybo0KBeY6bf38X5Va2Pe3cp3UaR09+bQDhq/UJVru4HBZ2gixn3foXB67oHIdPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oIltK8cZ; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIltK8cZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXD3yp1nhrQWMRvVdVr+bnt/sSDGpHTvK0QcBuKLyufiJtlLy3SY6/ubtsf3JoW1g8SABuXU52VG3h5DcY69d6kKZP44X6Nh7imwIgZU9hUG7AwJMRgRz0HhcNgIObgRAjDakEb8DNkrnMI6Z5X3diyjfTflBu1jefc2xA4bwquRlxLsj8Qf9YtbgWgW/mmhHSPHAHJbwFs2aYRo+Op0fmPefJe7N6lb0Q5hGk7d/O+/G3ThoGXdijdIgyzsR0m9T7QB5yKqqCZQn/EeuHucqnSD3LKrcXcVsaXym/0E2bTuPH9xLEHmNBHjYCtvF7o0FJZb+Zr0nXjoxSeuenR73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwcTYG4EvntBrtoSqFm8AVSmvcVJLnuAa99fFwX/KTE=;
 b=U0qtirDPIr0rvSgtRmUDYNjjRbsuicgmp69b15lFTwaeRjcSKK1JHNDa6j4jMcRo83FE6GVZE2bRjJHdEGVS1OJT421ebPqAr39qmfbWX8zYFIbV7MMUG3vN4WkuGF3uH4GGC5jz7o3ZLo1LV2Ccp6l4cxn9+zIBdT2dz+e3Q4TtuS5q4E27m1vAxVp6RuxZ2TquP7vRJgkjom30fpIAADLWjhgFaU3khQTkLhw34IYOGrz0Db1gkusHwmR+SbaU9Ej9ao5JnB7Q7pg84S+Vp7+ZVxd39dIgTpUBRKPAkJIwoacNwyeTBxnB8RXvZJ6BaTLjTfe5D7tTAQK1eoqbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwcTYG4EvntBrtoSqFm8AVSmvcVJLnuAa99fFwX/KTE=;
 b=oIltK8cZr4B7BYNq7aCO6UywREjizTxvH8dLa6UcVyzYeSNeLFc8wjoRAYDwgpN1v9cuWa4+LTaQOOrd8vJbg/pyFruwgoaDgAul2V+nF2R1hVK7ZVNFdAP9amP6D6qWGl3mTYKXVgySFCfqQOYBylmAJ4LpCOL9ZsnaESz49Fe/yqHfM7KU1gJnQefo13pUUVTb5XQhvZR4dhC5zfHynIy53LP4wl65Dqd/tjQsiJ4BmFZLBceTte8Th2Ga3RNirBK4GbQaPr+qPFni+UYBweRjRqvZllkQr8x47xCECsrIt+WhCgiIQW/jY5l9f3uNKH4TCCunl/LZvi4945+W5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 03/14] shared/bap: Fix broadcast set state
Date: Fri, 25 Oct 2024 15:21:35 +0300
Message-ID: <20241025122146.17925-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ad4573-fecd-4cd7-196d-08dcf4efaafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVwdcDJXIA5WpdNWMd2yFcwsbDwLgsYVRoknSxmqz5J5HcaZqcPN4Tu4iMcE?=
 =?us-ascii?Q?51yRAl0Br1iuzzhz6hYiIOlRIxJT7Orq+HfRjJPg29sjwIZGKK8jdjJZMR9Z?=
 =?us-ascii?Q?sKR0aI8sTFsrFDFgAajOlKequ+MTOOFhLwHDBgmWgamwUU+0Oq44dcpAWB6E?=
 =?us-ascii?Q?O413KJpImIopkq/1ANEs0gMLDwdODZ4R/v6gFIi6+9P8b6pUX6ha2vN/L/DF?=
 =?us-ascii?Q?ATd7jGoaKJe99mU06SS2X/tGRrGdBOR3FFmq8l2HdR2X6lTa8BtNQaTpO0uX?=
 =?us-ascii?Q?FPhtjUCL5MZ2/IIe+tJiN559i2kw3OeROktwt3GNxBoHm93gy6K7XYtZ5lK6?=
 =?us-ascii?Q?CxnglCQGmVXwSFg5PoStkkuh5PJ9IZ/VdFuUJzSXmGFYW36HLUMad4vb1ZRc?=
 =?us-ascii?Q?I1+tuMij1lj6kg4PDlNm4xM9r4y2q5lUDA3gIj7VDO3iab7OvSReNHB4RLqh?=
 =?us-ascii?Q?2BGU8q+J41QzQU0wsFtSG4vCQiruLWx4q9sXdFUNDgMHwaI2Dro7DfMGVYAi?=
 =?us-ascii?Q?/TSgFGNDFQV+uv9fxwbU93DzBl1WV+ULYS5ktfYknydNxzx+G/tLHZqJHLjT?=
 =?us-ascii?Q?HD/k4exXfD9aXZ9Au4GVc9GOstiAlSta1ufmFDXb7FU2hVK7CFGl8zZ8iA44?=
 =?us-ascii?Q?erZ6vxndtvI++9dgvXQclWhTHw61ytOHU5WeXAr2bmFAyff9uvDAATMzat1b?=
 =?us-ascii?Q?KQCwUzc+RGL4+Jfej+LQ1P/j4XBUNx4JFlTXMyG2PyZVBawcL58Aurdm2HlF?=
 =?us-ascii?Q?0XHTHdOL/ZjE4JcddOAiHttvrofzTUolQvMeCIImyrVt9JA5MOnn1ZlkZ5U3?=
 =?us-ascii?Q?/XNBuY7hz09CPntdtQWDkntgl3PH6qcGpCWy0ILySzngje4kJZ5CzwgIev4A?=
 =?us-ascii?Q?xNDOTtLfUmhFeMSGM8NbzDGYDlDMiR7RnNo3il1QCthREVyAYT1DYSCSYp6a?=
 =?us-ascii?Q?wNJLvMY0rYE8jqJrInl6a+k33R/bgAgxczr+8f5O+CIAPT2HNWt0N+Z4SEBN?=
 =?us-ascii?Q?3KeuKa1JPkHrqAdxLCECQv3VMWueoFgzo8vTdcNvRPtGqx/Yiihviz5HeI/5?=
 =?us-ascii?Q?GQSaDyS7IyM7ROKGU6VyU3D077cT+LGVhfN02C+itsuFL2TrwXM0nfWaCm9Q?=
 =?us-ascii?Q?+7RUJBHmAa9GRKnRRFqKA0ke3d5FwwRAYn2OEOob/Bp4/5hDLv3K3rJHFEAI?=
 =?us-ascii?Q?JW3XngK+I9D9B9aaYRqYWPt9hZImL0nYlgRbMhWzuan0/nC+/8Us3ET15Vm6?=
 =?us-ascii?Q?KzhxRdiG0LAsKshPw+drPD0H7X47n5aXn/PMV6tG9lICS3BkOk2wHXnZQQNx?=
 =?us-ascii?Q?Se1vWuF3Gb+UipPkkJzygrib98o3bzacscyp02fLCzT1NVeCfHD8+HjKa57f?=
 =?us-ascii?Q?Ra8PvVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xiyGUPzcEgreg8ZVmtk+0wFtOAjlsc8XCHfw/5RJWjGuDNX/ETszCiUDmJOn?=
 =?us-ascii?Q?6GS/UPt4rNTEpLq78WQ5LCs9Ff2G6nLnmAic3a9umJK1bw50AgH9xU/s141Z?=
 =?us-ascii?Q?ZQAnSmBAXRFgvaVX7jJX4dD6zbKzCknGuDXyLQ4H5B6965rr3575NUJNnn9p?=
 =?us-ascii?Q?JyNRQ78J9mFxyrxLjRvAgjq/GRGqRP81HBH9ARLKa2RJJEoQwiEqcTX4anLX?=
 =?us-ascii?Q?jPIPToNuP5QA0t2tRlZxPma+5fjbNM/0ju4Jkbkx/VXECaNwNIYv9/aJ11CX?=
 =?us-ascii?Q?OacUnmXVtYZqEB0xh8e90EeDYZIxxXiK+Ssq9uCI+kF/wPT/GqM08QQ6elZ3?=
 =?us-ascii?Q?PnLLRJO6JcZ71iQG6SRQaYwq/hvTBY4aKwW6qYYyiSjdQ9bb24oFAL8ZpnfH?=
 =?us-ascii?Q?4Tg+2BetfOjvF6XRxRdj9JHH76pHXdRA9+WOiTgPyS3xjZWzk5wPfKxZDBfL?=
 =?us-ascii?Q?4Q48d34QHlpKapvUibO84ly3Y5QfD7A0BFdXTyfK7ciwZdvpYFmxu8cf4mj2?=
 =?us-ascii?Q?7V0fSUlhbOCsclz4HfSivcVcLFsWxnEwTZqds44dRH0hc3E+elexh/DAE2lQ?=
 =?us-ascii?Q?UIy2FiDaisZ5kKKpf6b4VULEC47ZJebGna/dYyMHRyC3qZ0sMGv9JZF/5ufI?=
 =?us-ascii?Q?cVq/3vSf8kSpoLtwe6glN2Ru610pRNyfWZIyl5sZZ9FS6CcfaVtMzId3AnQp?=
 =?us-ascii?Q?dNJB7lkLCTWh0+JLcnfwHpVcXM+bFkLLlrwSZmTVBaLKoLDND6sPv+oQ/LE1?=
 =?us-ascii?Q?j2amEunkjWV/gWX9MwAeQDAMBIt8fVgjLzeEfjIIcyQL4Fwp4spA53Gmrqbh?=
 =?us-ascii?Q?AAppy+A03roKiPCy9QoPYR6jqZC5IuwcJYrknfd6Qv0VpEPE6D/VX62uQwO6?=
 =?us-ascii?Q?1UAmjqapt/k7k9y5ms/CqD3ZfmLMCtiO0nZF51m7l/8IgJQCvlv5W/Tpa/N3?=
 =?us-ascii?Q?CqqH3IXjnTFIrttdS25F5CpvhWQ8gUjzQ7yzIZ+q2SXn50IQj3kr4VH8Ow8l?=
 =?us-ascii?Q?wBr1wERhtUoXVonsC4t6R6aR3fWd6SR76NVEk1rt9j9A5VBxW7AM1E2kN2X8?=
 =?us-ascii?Q?jMEcUuv26hbJRmjXHuXQIr5PsHBWF11Jq+dRRNkBgJ3aCRBSnAgbZBq27F9y?=
 =?us-ascii?Q?9NIBl5lxIiM7z+gCOV2IQpjn77AXCcJeX8F51vyPLVxgX/0GM6iiJ3LGJier?=
 =?us-ascii?Q?IRLKXD3gr9RVjM+ohyDxPdIzWsoSRi8vthI0va3gfp8T5nkzKdJNF/0iAKlD?=
 =?us-ascii?Q?eo456E5bzqPecolvtzxLAkGYlDGBKZX7sp1vC3K7R9DJGicG2sOCBdyzqkym?=
 =?us-ascii?Q?M3lHJ/ZcPYqxOMi6Z85jNkt+WzUqF+3+Nqjx3WBEQYuiJN/9xxgxd7HjXxdR?=
 =?us-ascii?Q?2FURoVBtCjlpa9x2v0oZZPXewuWDEhQNpFa6+7mEb/Zf2/DNXBTuuZHokCHk?=
 =?us-ascii?Q?tEYa/GOGmuTJ7pUmUtjyKpPvIDKhkH8nUQvhOIqL3Q2YjrJsdMKYdZ/zmojH?=
 =?us-ascii?Q?3ORP2DOhBWIreZ1CiJ7MtamaelZLcujxBHFiKokaWlfRyPEfQ440dEGyvqzt?=
 =?us-ascii?Q?do6tSf4x/iIlSrN69Zd3ygCnulb26fd/EUUXlvWnb0cvbf1WTCGGIjCAwLNO?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ad4573-fecd-4cd7-196d-08dcf4efaafd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:18.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrkoBBgouXqRHNo7OImmccGJM15hznE/GYz4A1qkHOpjIWN0oU0szPB/3foCGet1Hr5bQRc5Vb66I09EpCL3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

When a stream changes state, the update is notified to other drivers
that registered a state changed callback. These callbacks might further
change the stream state, leading to the stream being freed. To avoid
use after free errors post notifications, this commit adds support to
ref/unref streams, to make sure that the stream is kept alive until all
processing is completed. This also updates the switch condition post
notifications, to handle the stream based on its current state.
---
 src/shared/bap.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a696471bd..17fedb397 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,6 +262,7 @@ struct bt_bap_stream_ops {
 };
 
 struct bt_bap_stream {
+	int ref_count;
 	struct bt_bap *bap;
 	struct bt_bap_endpoint *ep;
 	struct bt_bap_pac *lpac;
@@ -1204,6 +1205,17 @@ static void bap_abort_stream_req(struct bt_bap *bap,
 	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
 }
 
+static void bt_bap_stream_unref(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return;
+
+	if (__sync_sub_and_fetch(&stream->ref_count, 1))
+		return;
+
+	bap_stream_free(stream);
+}
+
 static void bap_ucast_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1220,7 +1232,7 @@ static void bap_ucast_detach(struct bt_bap_stream *stream)
 
 	stream->ep = NULL;
 	ep->stream = NULL;
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static void bap_bcast_src_detach(struct bt_bap_stream *stream)
@@ -1238,7 +1250,7 @@ static void bap_bcast_src_detach(struct bt_bap_stream *stream)
 	stream->ep = NULL;
 	ep->stream = NULL;
 
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static void bap_bcast_sink_detach(struct bt_bap_stream *stream)
@@ -1248,7 +1260,7 @@ static void bap_bcast_sink_detach(struct bt_bap_stream *stream)
 	queue_remove(stream->bap->streams, stream);
 	bap_stream_clear_cfm(stream);
 
-	bap_stream_free(stream);
+	bt_bap_stream_unref(stream);
 }
 
 static bool bap_stream_io_link(const void *data, const void *user_data)
@@ -2139,6 +2151,16 @@ static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static struct bt_bap_stream *bt_bap_stream_ref(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	__sync_fetch_and_add(&stream->ref_count, 1);
+
+	return stream;
+}
+
 static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap *bap = stream->bap;
@@ -2147,6 +2169,8 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	stream->old_state = stream->state;
 	stream->state = state;
 
+	bt_bap_stream_ref(stream);
+
 	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
 			bt_bap_stream_get_dir(stream),
 			bt_bap_stream_statestr(stream->old_state),
@@ -2162,7 +2186,7 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 
 	/* Post notification updates */
-	switch (state) {
+	switch (stream->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		if (stream->ops && stream->ops->detach)
 			stream->ops->detach(stream);
@@ -2172,6 +2196,8 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
 	}
+
+	bt_bap_stream_unref(stream);
 }
 
 static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
@@ -2568,7 +2594,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 
 	queue_push_tail(bap->streams, stream);
 
-	return stream;
+	return bt_bap_stream_ref(stream);
 }
 
 static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io)
@@ -4148,6 +4174,13 @@ static void bap_detached(void *data, void *user_data)
 	cb->detached(bap, cb->user_data);
 }
 
+static void bap_stream_unref(void *data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_unref(stream);
+}
+
 static void bap_free(void *data)
 {
 	struct bt_bap *bap = data;
@@ -4166,7 +4199,7 @@ static void bap_free(void *data)
 
 	queue_destroy(bap->reqs, bap_req_free);
 	queue_destroy(bap->notify, NULL);
-	queue_destroy(bap->streams, bap_stream_free);
+	queue_destroy(bap->streams, bap_stream_unref);
 
 	free(bap);
 }
-- 
2.43.0

