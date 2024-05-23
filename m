Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3B12E78
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479284; cv=fail; b=km9F334wTVLSFaYvWX4r6oxx/VNeIcnBZEO/y6pssv9qCWtF0Yucnx6XO8A6q7LOP/wnouOcE9+kMDigcRGfoKQ25Ar/e10xIl6Hhdek8UMim8AospUNHoAAdV3sJXO4r9pSdF2Twv43PJCy7e4csF3E23vRHzOmVw3w/ea6DhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479284; c=relaxed/simple;
	bh=tXGfaxszquYsjcPSu2fnpfU8sMHmp/ddILS8J36PFkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jewia82RUEbMBbz4pdTin1lY/C39G+0U92T3CknqH2Yg14dUSonWM7+YIVuXIeJRMpRWKw9ZWI136ujBz2TXdt2uA5TOpW8l753NxVlsdoV8XLwg3cRdBeY3cPCW7XWIhLCqsdhbsDnWpw152nbhnci0tka9JiXzFzUejoDznBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DdjQcaDC; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DdjQcaDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfLZm7VTqYllfTTGnHrZA7t0MCez5W0cQpVNPvJ9sNU6DnvHPVxGKzaVd/EoJq1vyK6DjdHMeVBGGfxzliQF0xq52g1CMCcOEqm2icd3djvKqXhsCZmNgN/Zy+2wE9ahqQoC+WBaeIRytYkOL95BaH0de31xCv1bZANygbEYfejHztgEOt9uiYAaChU5W4UnlHAp8Hw/2kgDPpFX99Qi7rKeG4KPlhxP4usU9CtelmP4D3BqAnfQ+aPuWwdJm8+1ZVzbTqJFyTkmK3boNXmAzivrKY9jcZ5ycE3p4q64n5RwSt2onRGx5083jqfcyKpLJ1gsLA6uRC9TOoRG20khXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZLUm9oZ1RqADjuc8vP7Tv9f1PjBaP+t4CJF0kx0e8E=;
 b=i5lYNn4oW+q7EbY6T3JNtQWs8sW0NQa8zbPhQDgLXGf9hJ9MEZNBHHjtWlNlC552k4t46jIBnaMSpKXnSNrI4tcyrsDF9xcA62/1/LFibOXcvbVXTJn0NIm7jRs70BcEvG1+WXTdLJjDvrUZtUL5k7aWEJMqGmMAQVJZD0h4H+C7FahLVK3yFLD+/njOb1pyvsijAEoy7dz7NMDwT2MTRAmOCslugrUhRaYnKRpOSBn6NUuwH7+tr8yVaRujg1bvewqhIVgmkQFxeXiLiUVzJ0EonK5QteVOz7aqYo8lk3XNLQQmW0L3fX8327GIMkvqliMGxDgbXk4OKLP3vLzZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZLUm9oZ1RqADjuc8vP7Tv9f1PjBaP+t4CJF0kx0e8E=;
 b=DdjQcaDCSpv9zOMEjBEhkbrHQZ0fwwSAIeGAIMMkiUaRtEx9Z+l9Mk3vP+rBS/qOdX4lzRlRFX0nN/nWQQCo6/3IK6rpZc64bUr2QSguknRJ8nQ2kwzZ8m60vmzBphNLKT/wLrsiGMQoyannP6axRyffxZBAFkKMrXWgoL7HyPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GVXPR04MB10658.eurprd04.prod.outlook.com (2603:10a6:150:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:47:59 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:47:59 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/2] shared/bap: Update BAP Broadcast Source state machine
Date: Thu, 23 May 2024 18:47:53 +0300
Message-Id: <20240523154754.39451-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
References: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::7) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GVXPR04MB10658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca53a24-d7c8-4f87-bec1-08dc7b3fb883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hxVLqz0EObIIprdV+jd7N3C8MKqgmdBzU2LapMvXzp+UcWTAZnCj7Xe+8n86?=
 =?us-ascii?Q?/XuQYthlPI4YKJbt1KkDHxyIqxxBBKOFIiqXkCmNYA0MvPQtECoDciPwxQcg?=
 =?us-ascii?Q?sdqC/TOXZ3w+J4NQBQ9/XtT5gSC+9id2nW0dboyw8sDaIs9CyHJKl1DwHl9u?=
 =?us-ascii?Q?KCzf8kM0Nm8muVwJtge9OSnrPGFhW9cXgWYqcXzCiCzqB6GUMjuFyfmSlh6f?=
 =?us-ascii?Q?OHjNVEPx9f/USltheW8tarRIrXr7rUGy/lR++6/inV3fzpQWWYyRg0V2i21b?=
 =?us-ascii?Q?7IIqQiP/Vb11FT+zOOd+4oiF4RFuQ5qNvn9OIQnlSHqmGm0UG3Hr7shFKDxs?=
 =?us-ascii?Q?QNShNpEnsmGmqkwVus4lfMHn9IZBkXNJSENV9FDdXTvInd9XuW9faOIMSots?=
 =?us-ascii?Q?FX+QCbZsqgyYnsuqyPBQclXHLW8ZvFoOz2E/ExG5V+GnTMiOS4y/j/vLhwUQ?=
 =?us-ascii?Q?E2jmglVmWpevYii0itF01pXTRrovssVdn8FZqJlVPm5xFL3Lan/7v/iSOIFa?=
 =?us-ascii?Q?j21jnRHrdF6l0FDO/kDeU5ZdJsZYuwelrmtsDGrHCnp/MCh9eyjOzxuxxdSb?=
 =?us-ascii?Q?joSZ8dx8rm6zJ8WspaW7N9F3AUsdsm49M3jQtqB9y1RZeemWwaloSP3EtaSL?=
 =?us-ascii?Q?bA1iW2x6t15eUHZ7WdsLFa4fqmWlpWY1la6uGttRlA+mCdMXNTkXMUj3zj7c?=
 =?us-ascii?Q?daVbYYKCgPPUnQ07Vd8/C2BSqokaxVBGLewWsLpZUvtOleROjc4j7/HuUJGS?=
 =?us-ascii?Q?mObFLuIfRsi4tpkhQGh6UUUZWodQuBX9H6TtMbvoswLC1bPcr/vvJlx5FaFJ?=
 =?us-ascii?Q?SXzUwTQr7rw+r3j2L19THy+JLnTqdfsV3bBP5umDlEZkSut8Q6htDSv3WELI?=
 =?us-ascii?Q?GZ/KcQsR8KuGT2NBjss3F14ybGm5K10NLy2K8cWteQPYKRj7YP9kj1qLe460?=
 =?us-ascii?Q?1+VY+CQMJAO8Qr1FtqkNCkymdQI8D4gBHJZzkYdeke8udd/MIQFA2Sh997hx?=
 =?us-ascii?Q?KK0r84+g25OoiF6NsfyHRkLcUWplh5RGl8cO42k85j3DvjvQ/bx67jhrsPh4?=
 =?us-ascii?Q?BsLUZQdolwLiV1L1CuPUcDGu1Jq1gApwLqEqwWzkgfYyjARDkxAojhSghRdO?=
 =?us-ascii?Q?5C+AY3NBpCSdmI9NT6huX/UFa5k4NR7pU2dKBJsX2WX7OM4z7j70cqSA/hIl?=
 =?us-ascii?Q?qTIyXmYOpYpEAZN3Wl/dkUs+lMvsWvtMgqnfNtL2mCa2q5Xy9npgEAHWqIet?=
 =?us-ascii?Q?tPeIG22WEV0FD3qqFzXRTEYfL3iBl8YCecvpWtd+fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AF4CGfbeZnOODrqViV8ZxRxZFQBDehLzK46QPftMqVBmaZ+jCsuv5Lte6ZtV?=
 =?us-ascii?Q?Nobv8AjhMsk+19zTrNzBndifHVf485vkNfdix4Dv8ZYaApBqEw1AtfDuT8en?=
 =?us-ascii?Q?honQhDj6ZZcLojc0bM4XEwTtsWLhyDsoYJqaDxIzpxP6Py6WVL2rJu9M6Igz?=
 =?us-ascii?Q?JmFxszZRCTEepurJQuK75hSF5Beuo+Vozy4Gx55nmGAwtGEH3vxo17EXFOyJ?=
 =?us-ascii?Q?rBjgIkmKlEbmawfP7bBllEvJHGShhkG/NTP/Au3RIAf6u+93PQrG57dOQHwl?=
 =?us-ascii?Q?Ynrc/bAFrty63NgSwP0bezXFLQbepZtZm7J3jCyzQyq/UhY9MQ9aofvDFjiP?=
 =?us-ascii?Q?bgnU80X6iY/Yp7Qd233oIqTZnjLf44wolatIYmExeM9KPSWsgJn/WmlTppg3?=
 =?us-ascii?Q?ZyXqAQXxTTqzZUkxm2uzyR8sx/tukAYurfrK+qt+pwOfvYW+UEUmh0FFGf96?=
 =?us-ascii?Q?9kqk/vdoPng3KLO9fQdMUk2riaxJGAq5SPrPmTHiT33yCvCn5u11LdU7iIeQ?=
 =?us-ascii?Q?Ky0KQNaHK0cKkGnbiPE4dpFpNH2omn01u5RthZ311G+eI4LBjUBZvoqWa0/V?=
 =?us-ascii?Q?THSx8UecOclAOUOqne/szwhWlMXlGfeKMRrMVHrgOGjmEz39vGlrfbMUfYTi?=
 =?us-ascii?Q?wDTFDhvIxx/X6RHcdGDpm0IDiv6u97WVQZ97V0riA/MHix42ZgmD7R6ReaPX?=
 =?us-ascii?Q?PPs+LpXBCBEEYxZQm1xiuNwhBaL4NDYIilheoC8rlS2B9jw21v+zTh20Ei/O?=
 =?us-ascii?Q?XXrltvg7rKWHJWMPx+GSYCtFjzHHChBCKC5uLratOeqHztFf2snFnchRwbwl?=
 =?us-ascii?Q?tWLFpSihGUZ0mBL47rZ1M9gaTCpVoZNuyu12w4jed2WU3gFoeE7cOJ0UhVoY?=
 =?us-ascii?Q?8xO8iA0qIRTsceX49JWwrK1gdEzYfrNBZJupNaGbv791uIcSJmg9rjaBxFF0?=
 =?us-ascii?Q?4TPsSpWNg2IBeG7hWoIeMwtf5ipIU8RUUmSBiwmdOhs03oq/eWMRvu5F24RZ?=
 =?us-ascii?Q?DkufC3RSpDG/7IPtKR6dtH0KvketiTpkjy4h2eF0oEOxlK1CfVK/fLkhhTqg?=
 =?us-ascii?Q?keHsEXzc3NlaF1eN/e6ahz1JruFPX0QfBiorDHW6pB91YJpcH57KYp7aDgyd?=
 =?us-ascii?Q?2l4MKP1at1tvg68lfGkX3V28WYm3fKauwSOcPQ6s5er5HyrYx8Gnxz8MohzF?=
 =?us-ascii?Q?7Z22Wm7CqXd3f8ZDKhqilvJDPf/rcHV3DLHX96UAmoLJJMQstXZUzh/9c9cX?=
 =?us-ascii?Q?U79yAa7QiGVfpLWQdfLEISfAsUzsIJA5tGQd2gfyFEomkXMMk2v7c71fVILV?=
 =?us-ascii?Q?HaaD5dPMBuPPoZXzqXGHj2TDy94MEjchfaCOIKhZlICx1dpvvdt8OQoxajfd?=
 =?us-ascii?Q?alri+uqBUZ155PcMz+7TDowXVDE7m3+X27gK27Q/CgVpP4kJpRkpJyPB8sbW?=
 =?us-ascii?Q?5b2u2M6p0jP2SkgTjS1e58JcOhiex2Bea7JEknmtdqyM1fs4NX6WZlRWWHJK?=
 =?us-ascii?Q?VV2vA+zCt/hPZ6tmFRYpgy5KDif1HxT5MvLvD/yYlX+UXxwI2Sm4bi/kjT/C?=
 =?us-ascii?Q?hJbBufmUlkEy7aE+DaLJznDYMuKW+mt2UqT7KpjTypETfbwuFZdlEYlHSLpI?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca53a24-d7c8-4f87-bec1-08dc7b3fb883
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:47:58.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgfbZdioaAQdbYANPDqhiCWH4WpktLt/R0w2yjjasdYrR2JpDAezznOrS01kkrni+J2v8v0+j6sSVpXSGvr2npzMnXUZqYFwNsW2Tr1WFjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10658

Update BAP Broadcast Source state machine states to use BAP define states
 for source Idle, Config, Streaming, and an intermediary state enabling.

Updated test-bap too.

---
 src/shared/bap.c | 39 ++++++++++++++++++++-------------------
 unit/test-bap.c  |  4 ++--
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6572ef1d1..639149520 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1361,14 +1361,6 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 	if (err)
 		return;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
-			stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-		return;
-	}
-
 	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 }
 
@@ -1759,6 +1751,15 @@ static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static unsigned int bap_bcast_qos(struct bt_bap_stream *stream,
+					struct bt_bap_qos *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	stream->qos = *data;
+	return 1;
+}
+
 static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
@@ -2071,7 +2072,7 @@ static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
 	return stream->state;
 }
 
-static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
+static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2081,22 +2082,21 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 	return 1;
 }
 
-static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
+static unsigned int bap_bcast_src_enable(struct bt_bap_stream *stream,
+					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
 }
 
-static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
-					bool disable_links,
+static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	bap_stream_io_detach(stream);
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
 
 	return 1;
 }
@@ -2106,7 +2106,8 @@ static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+	bap_stream_io_detach(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -2205,14 +2206,14 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_enable,
-			bap_bcast_start, bap_bcast_sink_disable, NULL,
+			bap_bcast_config, NULL, bap_bcast_sink_enable,
+			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
 			bap_bcast_release, bap_bcast_sink_detach),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_enable,
+			bap_bcast_config, bap_bcast_qos, bap_bcast_src_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_src_get_dir,
 			bap_bcast_get_location,
diff --git a/unit/test-bap.c b/unit/test-bap.c
index ad2bbfb16..b59f642ca 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -555,10 +555,10 @@ static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
 	struct test_data *data = user_data;
 
 	switch (new_state) {
-	case BT_BAP_STREAM_STATE_QOS:
+	case BT_BAP_STREAM_STATE_CONFIG:
 		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
 		break;
-	case BT_BAP_STREAM_STATE_CONFIG:
+	case BT_BAP_STREAM_STATE_ENABLING:
 		data->base = bt_bap_stream_get_base(stream);
 
 		g_assert(data->base);
-- 
2.40.1

