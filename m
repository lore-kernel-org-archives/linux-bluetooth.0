Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D41292D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706908; cv=fail; b=XNAIeQALU63KIkVuZLp0fMIWZ9fHFa1hrXCNqkd1GsA7BGXq0sWESpj/mKbt+48B+LC2fhV0BSbQGjI/92dba9euPAZtUB5dqlKJGiGhPXP5piOmiZxUi1QUFnqmOGhFeDIK/kKUoCdMt/jkTt3seJD0h2Cx337tZbTeUPMeX64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706908; c=relaxed/simple;
	bh=LlRSp+8Ua9A3XNddrlLOjmT0qohzHHbYajSaClwaG2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCBT7VElcTEUNOfHC8WjSxykgUF1PjbDQJHSkoHZWZF3Z9Gh4HF5cPF9RlIwCP216DQVkH8SJ5pYDlgsidrj//V+sL1wFHFx19aD5pezohWXijg/mZk7/o43MFwWWwjj5rr4lQHfpKH1yuQBXfBgdJulzdLMA4EMIo7u+d+spEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/8wVjD1; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/8wVjD1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSmLckr4C4JU2fo+BbF92kNTXhplPnH37keWjoZj57lWOzmLJrY6RkP0cTVQdl5H6jhJZbxJ8sm8I3ZWGLynz5hKHgN9P2JsufNNhaeUcyLhXxx3tGioeVJ6f5OO9adIRsw1I96Ajlu+Ncg/v4dluRkbdn4eopGaEl1LgZLEq4C4A5z9f8BBmYvLdc4Aw5ObVhGFBLYz6XXBTycPgXx5k7ZJ/A9P/VHmxQ2gzXF2G8ws7zpoz6sWtolHa4oaevXT1UOwqcJPyS/33kVaA0Ub0OdpsgOJHVWydNe41RuHZiE0l2ILGnpnAEIP+LIjDhY6ShoMzvrlq9b8tDhzVjDDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOkCteYQTraNxDVvrJGA5+7PxNLuSIvyCF0eK4k0hGc=;
 b=GE8nCcKYQpAJHMsDet4w4GNg4mA43od6uwQ1nziuXdUveAAbrd9HeNaYRez4/jajex9pT/UPGf/Es8EVYCe/41nEi+eaEG+JmQKTyEiahuNv8Xxi9Aja2HJvynAmQiwFEAsn278o98fWRiT8cTlUmEO4CdrpOcQeGWyllBTO861cU2gKG8zkkc0URV7HgOImoXjB6c+snVWR9frtsofRbay7lejuZbTN0hnjnsHf4sR/Jor03hUJcGQw7xqosC1B614Rx+trSo8JhQoNP83QAvncFl8sZdQYQCtejOnhme4FhAOsVsU411FX5BEV/1rG+KuU351+laAK9U7bVGu+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOkCteYQTraNxDVvrJGA5+7PxNLuSIvyCF0eK4k0hGc=;
 b=k/8wVjD1li7E8iyntuW8flEJkoZOmjvKmKqwSIk491dTBXTGyVO7+5xvwskSwdtzxEL07GZVgOHX7/RiRc5u2NFI4pTHtnTjo3zpfEpQddZXXigNeWcIbPwfSxYvRabxKzHxjpn9HSiyZh2XTU3DeD7rxkTd/vCAM6vb5VI6UmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:22 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:22 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 3/5] shared/bap: Add support to create a stream for bcast src
Date: Fri, 23 Feb 2024 18:48:11 +0200
Message-Id: <20240223164813.66484-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: a472dac1-7088-44a9-7581-08dc348f3f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A/U6p3d8ih+lWeimToS+igyy43ZLYv9K97NeLYCV+PO3CXgFrbMBTXvRkFc1I9nu48F0A51haqe98+XBu+wQztSElOsqbXrU9sX7UsCvCO63QqaSxDpyS7ki+2U9NJpz/AfzxxkrHpB9IOvSJweF4H08g1MMIDtgb2RWmBPIZfByRsrPbVNcP1khQ+dhschsp6jAlbQYgmvIDnDCinmcxnlCsGddtc2w45XoPxsUHaCm65UJSq0DqhhBxI8sF89EMHtprtRQnXMS/wRLARjiMKnjFjhvw+fUcP91qmJIhpm1d8am87iLXE2CJjE1pE8FG8GRa8KXdHRXbxdVAOj/G+ESEEoZmwQVac7tsa8Q6U69tLOZqbMNK8+w49NNEiLBtvm7PzAptyBT92opxa0gdAqh1F/xg6uQnk5hIE0JToomQEKmrYmdr4/CZ7Q45V/36m4cQSvf1s7cXHO3LPOWmEvUlXyAzDCamenk7cQIOBDwH4xIGuXX0R4ZdcZlgae7WQmLdYLFbrluk7gAJS1Oy9t2OXeRNOg9VN8OjoMIqh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xG6kh88ak0/rb3WY9r9ec8B3dmZfcbFktaqFyGM7w5LlyXzqaK1JNrhmdZ8L?=
 =?us-ascii?Q?Jq8ZSdRFyucCqA0HOolscI+HcvaR9nrPwG/5jAPpid4VM2Ezi4S4rYbqin86?=
 =?us-ascii?Q?NG6yMN/XRqiE+AmU+RQPm6cxGe1NHu1kVyHGnbrSov0lGd0D4ENXCTaajt8j?=
 =?us-ascii?Q?Aie9AI714okSXjXcnBPlUz+B5VQ5wz90WXZsiR7S5Z49/55lZcBwROt0RGt1?=
 =?us-ascii?Q?CxuaEwdCluVBGyyZRZdXxNhqCtenSb+0jkRVbvgWUofFa14bf/C3VVoREJc3?=
 =?us-ascii?Q?INzvMtqqKO3rxproKuOREd2sC7/GBCHDwpgR0a5vzBmR1ZMtzGXPLbZ8y/Jv?=
 =?us-ascii?Q?Wkupdem1AacfEJLsGhosGS9kyZ7aPATzuM2DWFfN+fnxKdHc6UN/luYiOKEE?=
 =?us-ascii?Q?99IZsKoBD527MCiG5C7g4w9AUS/TFOD6YQUX8NDGM14kmEoga51xsup2ugpq?=
 =?us-ascii?Q?OkC5yxDC/JGmD8VUcoowrT3v6JZ39bksbfqpNj5VpzCcFodaOfM8KDP+G+FS?=
 =?us-ascii?Q?UAK/7+G04dAaxkB1ur5wWJW4lB62qzpC0gzt4UBAkczNRbL6EDfgpzAXAm3A?=
 =?us-ascii?Q?2xeYqn9GZRmoEljS/cEZnpjPRpcOZ47eZf3+k6GQzfna2EhmP0pRG/6W+0Oa?=
 =?us-ascii?Q?GH1eGiTwTMk+fcWsEYQBBbF1lUaUg+7bZc7dJahlzPWjn4nifzTF28bHpcwW?=
 =?us-ascii?Q?5KFZ69Apc8+zIfOM4eCtae1ljNFLHnqV0BNzo16jG/vyRyiA9wsp8zOzzaQX?=
 =?us-ascii?Q?6A2ftU8jbht2wIbpK4P99xtBAbM74ir14szXS2PqVLULZ+zoihOqkJMSw0wR?=
 =?us-ascii?Q?f7bZ8gNPIB8povJz1G1VpifXjShZIZ9fhAxaBGrLgKTek0XZzs60ankKDL//?=
 =?us-ascii?Q?N9xZUFCaz7enzKsckaDs2LJNCM1gAAjzoo3/0KS/vNKrm2k5c511cqXs1saw?=
 =?us-ascii?Q?uIOvpNZJJfqV24w/zx+SjfskbI6ya/2zG0gZnTYoZqbYZY2YglG4sDCj4giE?=
 =?us-ascii?Q?AGHJe6rbI1DUerwHuOfPHTonblkgfPwjvj0LL5HJdDZD9iFeYb8idKQiyOKC?=
 =?us-ascii?Q?HmSvn18Jr4YAQLdyDexlKYZbNvGi6FOsCFegBbDusa/pcDN8/kTREal+veOn?=
 =?us-ascii?Q?iPXMEKNd0JdDUuiB3pX5AJsteJ8DIFTKD0/GCZsx9dHsaLVJ5E/KT0O0YAEf?=
 =?us-ascii?Q?ebClB7rVsR7gDFYJ0TpvlIhm7/GN/I7oVLNYST1RfXpRcKIsVmLL2UTO6Ndw?=
 =?us-ascii?Q?aC7pGAJPSFah0cl/MbfeJva734yN1U1rsXS3/Vhxp3GzXU1IKWHhk5rxLpA0?=
 =?us-ascii?Q?aJTNrD6mvQ6b6j5SQ+0PAcFQmTMvwq2DAOqqrQlDJLz8TNhnMHK/iVAeWOqk?=
 =?us-ascii?Q?by/RmDLHVo8Fw4rZKJbIr5m0mSi+UWWB8VRZHF+JKr4mcnW+5GrccX8v0Dhi?=
 =?us-ascii?Q?7CllhLftmVMDIUND1NXQF//tox0iQbCKXCXvPodBcK69fu3A2qJqbAZN9AG7?=
 =?us-ascii?Q?83zQvbRam59lncAZSQfzPpReYz69lwPW7GG1akgz5a96nEWF3sLCUUy2pEqh?=
 =?us-ascii?Q?LpkK6hRYqztOj5IKZL0Ioir3m+Td2gGOqTWYfINICvxOvU4O8SRV3rxG2tRC?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a472dac1-7088-44a9-7581-08dc348f3f2c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:22.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGL7zHJ88z0FVpVbGEoUcYjqZqVHoBvBqiVBu2gN9SMzBaVk8/eEIEaGFzcx5eG86sMe/wjxBoB15Ld3LW6xcpEZt2RVHaBkm5U4U2RicMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

Split bt_bap_stream_new and  two specific functions for
unicast and broadcast.
Add a function to find an remote endpoint for broadcast source.
---
 src/shared/bap.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  6 ++++
 2 files changed, 98 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0a336fc01..0931c8fa2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5043,6 +5043,16 @@ static bool find_ep_pacs(const void *data, const void *user_data)
 	return false;
 }
 
+static bool find_ep_source(const void *data, const void *user_data)
+{
+	const struct bt_bap_endpoint *ep = data;
+
+	if (ep->dir == BT_BAP_BCAST_SINK)
+		return true;
+	else
+		return false;
+}
+
 unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -5153,6 +5163,88 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return 0;
 }
 
+struct bt_bap_stream *bt_bap_stream_bcast_new(struct bt_bap *bap,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac,
+					struct bt_bap_qos *pqos,
+					struct iovec *data)
+{
+	struct bt_bap_stream *stream = NULL;
+	struct bt_bap_endpoint *ep = NULL;
+	struct match_pac match;
+
+	if (!bap)
+		return NULL;
+
+	if (!rpac && (lpac->type != BT_BAP_BCAST_SOURCE)
+		&& queue_isempty(bap->remote_eps))
+		return NULL;
+
+	if (lpac && rpac) {
+		if ((rpac->type != BT_BAP_BCAST_SOURCE)
+			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
+			return NULL;
+	} else {
+		uint8_t type;
+
+		match.lpac = lpac;
+		match.rpac = rpac;
+		memset(&match.codec, 0, sizeof(match.codec));
+
+		if (rpac)
+			type = rpac->type;
+		else if (lpac) {
+			switch (lpac->type) {
+			case BT_BAP_BCAST_SOURCE:
+				type = BT_BAP_BCAST_SINK;
+				break;
+			case BT_BAP_BCAST_SINK:
+				type = BT_BAP_BCAST_SOURCE;
+				break;
+			default:
+				return NULL;
+			}
+		} else
+			return NULL;
+
+		bt_bap_foreach_pac(bap, type, match_pac, &match);
+		if ((!match.lpac) || (!lpac))
+			return NULL;
+		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
+			return NULL;
+
+		lpac = match.lpac;
+		rpac = match.rpac;
+	}
+
+	match.lpac = lpac;
+	match.rpac = rpac;
+
+	if (lpac->type != BT_BAP_BCAST_SOURCE) {
+		/* Check for existing stream */
+		ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
+		if (!ep) {
+			/* Check for unused ASE */
+			ep = queue_find(bap->remote_eps, find_ep_unused,
+					&match);
+			if (!ep) {
+				DBG(bap, "Unable to find unused ASE");
+				return NULL;
+			}
+		}
+		stream = ep->stream;
+	} else {
+		ep = queue_find(bap->remote_eps, find_ep_source, NULL);
+		if (!ep)
+			return NULL;
+	}
+
+	if (!stream)
+		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
+
+	return stream;
+}
+
 struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921..fa0d4b524 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -244,6 +244,12 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_qos *pqos,
 					struct iovec *data);
 
+struct bt_bap_stream *bt_bap_stream_bcast_new(struct bt_bap *bap,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac,
+					struct bt_bap_qos *pqos,
+					struct iovec *data);
+
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
 
-- 
2.39.2

