Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387D83CC1
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263133; cv=fail; b=dQmgAg9pGZtnxOgD28RVze3JM6XW482rLu05lyfcH7a3CA4dgIgUmOr2NpamW9SWbv/0FLyD5ZQgshMFz0FBWf+0lRW+Abs0lmYKvDO6GJsJ66hDSQgn1804KYFfAz7qSHTvFKAXdX5AStsCRI+6YD2ofO4O0CbWRV0uSHZi34U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263133; c=relaxed/simple;
	bh=g9jTB3GBSn5O2RUgMPnoqo1GlAvNNOIJVAvI6y4aHDM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FnqSw/p+8th80RG0vZhC1/rg7YpnluZ0K6XHwESMMHAMVmkR6Amx/GPOXXYqisCSOmKvwdFwyJkuboZBWeB8lnyUGHXXh2t9yUQPFHYoGRlPIWGkPieZPcwyHtQpzYhXa0Xz39vXFm18FX60t0qK/6rxNsbRyQYkWnJxf8W7DN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pe/h/6Xk; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pe/h/6Xk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlMnpZU0SUGL1R79eoO6NmceGPcBsDA7S8JqVMQvhDATg+p+lJn43y7UWkZHXIHuY40VyXk6sUCLExbuX3y2GU8k1JoLMxJRq+6G/pp9GuW2ojUXIGrehOXZER2D9ll9LjwQaLpUWfSXsGW0VSxGKsX2KhESHz2xYUWCNtL6bgaa9pJsZ5pslmrVQzrKcktPDauOApatxMgPXQ7J+BwABRqbQTPFpfbYuEA8Q6MlwjrWUNc6zgd1PYcFNnvoVbjnTCDoJ7WI09auM3VdxfwvHY9+AMlULkBR1DHdiI53i5mQvhGnqW8iG9Slrx2+xnjqgEYyHke05w6n6/KUfIE3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGITCffxtqi4Q9ntM0nk9qFjtgFtX8JIeEceVALgScU=;
 b=S2U/IZkTHxDXec5VcuQT4l0HMWjtFQzHBih5ge1uCMujUlFCKz/wJYAo+cSFlVU7fI3phXE90yVS9htoPtPuuTU5mYxTqHanfugAcvzUaWsYfWmZrKTictTBbIYmiMb1cG+PxOwcYVzWNINIhvbI1F7x5OsMdiRRX06M34xzfiyk7i7t7N0+qajwKUYVYn1ChyzOqf9bBpx1KpjIgo7/myvKqT+02qfYO+kVVtjWUNBRHwxJbr+wueZIGeJSB9BRbR0vSt/FjJw4+x6qjBhvMm1an1pHEjX8jShsqaM4qxGNdPx0cLEYVvB74QjECZTxH8SKpJZNuavPORuV0MJ5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGITCffxtqi4Q9ntM0nk9qFjtgFtX8JIeEceVALgScU=;
 b=pe/h/6XkAeoHq4PHvb1Fg9L0st+mb9XboP2Uph8BvOyxTPpdZOZ4vNYCRKkAIujmIFl6cKizdGCfY1a1hAjH76NNUUJSdPfsqNN4whSj+N3tJFevtpSsVWca3s5afCxycBza7zNnrE4wF+Qx1RLUEg8MgwlALLQo+Nq/Dx+3zyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 10:25:27 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:25:27 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
Date: Tue, 16 Apr 2024 13:25:00 +0300
Message-Id: <20240416102501.42996-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GVXPR04MB10518:EE_
X-MS-Office365-Filtering-Correlation-Id: 2303c38b-5031-4dd4-8d94-08dc5dff8897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4K1XOZ3pIwjoEL2jqeRWMV/i9pOSucwpNevx6hOd9LWYe0Vf8GWZn+B+gSUTcPdibrjLXFxroh9u+dAmyw1QQ4zJCWXCcfq/QzQN+cmL9i6iMicvH5n/Yj3RBNXe/vZ5t9scxrxMygaDBB049VGiI7hADPQTWffyccpCNbode4NMwLY3PGc0vEv8XtieR25pMumvq2EultofqDSbUEhZeOMAj3cbfgDozO9yRly6hmLISZe9qQp17sKv4X0CAvV7dgIL38kD5abya/ANslh+Vx6TBFgdNW1SNLQPHjXXmDGrFoiqSXDf8rIdhA3okLf2nxa/NkIsrDpGuxYywKx1LPnl1sLYcLJ9LtXJgSLdNydVDiwN9WZCW27q9QBM5EL5R6gQ/7KZWbCMFHmw3umbVUg1vXAn1QpusvsUOV1oWCIgNnLrNho7iDjDnY3FvNaludr57ZmgYqKjcBjevOoZaDGB6g1VgFnmR1W8qgC60nMqZRn6JjikObDufU4pzc3HVKKpzT0xGwTA9gak1r5kydNkIY4PrHp31p72fhX7Y274ddVHz1p52WDDH83YqXrd8XW60qAaPJhyTlT9Qaa/GaLeYWeFKfMnsevhEB2uU1t4hby1kxguquN6NAD0klPk9NWw9FqbKDUNB+c6LvE59QAI4njbIT7M3s8lLG3IN9BbcTixmixxb2MUvTgsFWPUktbpfqO9/50/qWEc/AyPHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8BjTRMmF5bp8tIjPEj4NNzPqR/8vwP4Djy5LMsBMO6FcgyrpkC/k/QscfEL?=
 =?us-ascii?Q?LEofDLgXGxEq4re6KrUezGkF8gDZBYEJOZq9CXsM0aWfbytALluEe12TjT0q?=
 =?us-ascii?Q?Fk+JEqAFX+ZCoez0U/8S29JXmdCfCLiELix+VOrU00IlqdoyH801+ayU4kUf?=
 =?us-ascii?Q?ibT0UtdPUMus1VmaBDD/AVLa9ucza2a+PviUS4D1LV/+3H1Xz/AenzqGIoC0?=
 =?us-ascii?Q?1KRqFJClnbbP+Igt38BQLsZkUyX4OQkXD2gIHzIy1pFA/bemv+8iMOdhJq91?=
 =?us-ascii?Q?GgW0ywPTm9azQ/xNZmhap05WE6mUI9f/EXy9UXHKe9+qEUKTwgMzR6HsLTKb?=
 =?us-ascii?Q?Hott43htmL5+MOAYBwSe5z3cjqnMa/giiyGt/PdvS6IxC+Wa8kLPWTPKQD4a?=
 =?us-ascii?Q?u8RuhzQJfk6WNu2jwONhRs8tQwrkMcTzfs/QNNYZ4/OAD8TX7Y8gO+H8lXHY?=
 =?us-ascii?Q?x2pGhdRHvVQY/F1KTvznLsE9zM/85XDH7zpbcy6XTB3xA2yIYn3RU+q5rNa3?=
 =?us-ascii?Q?D5btenOApphC9igubNF1TCJxcMeG/UxZp/G1sT5YX1BeNE8iarqXBdiMEiiX?=
 =?us-ascii?Q?6U8U7H5FXL3J0Xln7sUqpi1ltwGTh5ROw9fFtj7nX7XveQWl2KLuduhwEYbj?=
 =?us-ascii?Q?zop8e0urUrvDSTraiurTyTys8vwMrpSG2xmoIN/ijGBtIzg20ufCAw+mcpDv?=
 =?us-ascii?Q?BNNbJrorVrHbqzN+WMrVOQaONOkPR8bjW3zK9MCTkmTxqIXQiJHTFrsMUGBx?=
 =?us-ascii?Q?GC+tRkKIhb+EQYCpKnP9lSYxEFUNZH5ADL5OKAPakTF19e42FvA3metUeeZL?=
 =?us-ascii?Q?kOoz69btn8qIVkH87rzI92Mr/gB/mrhAluHqZlxkmkTkgzdeIp+zwkAG5c4Y?=
 =?us-ascii?Q?ucuKbDZhzFemc3KgtvSTzTWFA2hZjEt28nYyiSd06o7wNvxl98GodtkIIsjY?=
 =?us-ascii?Q?hDLAYtOiaPzaaImrYK9BaGSuN0EzsK9Sm5iNNloEGqo84p9FmSkSk6pGZlgv?=
 =?us-ascii?Q?1oX36KkwM8yT7+Vfi/VunxnJPTczBkMNb7ywwUSseEzd8SWL4MC1gq7kFqfD?=
 =?us-ascii?Q?C6mOj/fleBYHCQHVNuZwUY915YoX79TbzOT2+ZP9dR9+9ESQPYsJK6hxd28P?=
 =?us-ascii?Q?j+Ru/QCsw3oXHFrgpZgjP1kj+ymAHNDws08rIuZCRxuJbzi8ncXS2OoXIGuM?=
 =?us-ascii?Q?Zi7QftaJeb9DHaQ++n8CadnooSjACd/UckXWREBF2mbut59vJ1SfhBXIWY/u?=
 =?us-ascii?Q?tf5rQCVFzYOMrqocVs7cbZ0ji5XmmOpDegoZLacb7QOrO8aQcbM9GNMlRh+y?=
 =?us-ascii?Q?Ss+mKplEjzoV8E6yclwBDByRsVoKVTQwr6lBhKIvsySjIG/6LP2d/vHbj1EM?=
 =?us-ascii?Q?BER68PbrPH+HTthQr2NQsJWRnQRykCYAe7FwqmCa0Oc1JIRy8aS37ScY/LC9?=
 =?us-ascii?Q?PUmymZOoeEkJ30LhdfpfpVW6371CwURhFCtVT29tx4n/ZA8jI/kwyRZTTFex?=
 =?us-ascii?Q?p4+o8c5ZpSv04RunnbPnw2HPrDXCp0D0TbodOh8zma+z+a2QFL02Mq43gyz+?=
 =?us-ascii?Q?uP+NJC8pE2EKBQdonDyGrlNUKvUi7XPOErT3JMVr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2303c38b-5031-4dd4-8d94-08dc5dff8897
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:25:27.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6zeI/jxhx6Qwz1yjYApJmvRCVlW/eAWP0IITljIv96mwhP4PRxZu5xXQ64t2FJhygEdmv9ncU6GjTFgZ2RQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518

The latency parameter of the broadcast qos is calculated wrongly.

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G

For framed PDUs:
Transport_Latency_BIG = BIG_Sync_Delay + PTO x (NSE / BN -
IRC) * ISO_Interval + ISO_Interval + SDU_Interval

For unframed PDUs:
Transport_Latency = BIG_Sync_Delay + (PTO x (NSE / BN - IRC) +
1) x ISO_Interval - SDU_Interval

For broadcast sink the latency should be taken directly from the
BIG Sync Established event and for the source it should be taken
from the Create BIG Complete event.

The interval parameter of the broadcast qos reffers to the SDU
Interval and shouldn't be set based on the latency. The Host will
read this value from the BASE.

Vlad Pruteanu (1):
  Bluetooth: hci_event: Fix setting of broadcast qos interval and
    latency

 net/bluetooth/hci_event.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.40.1

