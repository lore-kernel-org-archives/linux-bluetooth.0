Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B050199389
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908783; cv=fail; b=Fr952IOQoaEr/HPyk6B0yA9CXxlaajlhAd9EeIS7DJzYnVdhssRAXRBkaV0i0wOJFZL4vQ07QsVQlbhPYnS4Cz00nAYeBGSJau2/CULU/wXXEKsONYcYSjYPLlmOptoDiLGRcJdn8VsdWGXo/WaI4h7CMpOTSG2qEGRgmN+uiRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908783; c=relaxed/simple;
	bh=ino9CKwMHj0DBv+NzvmAiU/tjI+GV83RaIoS0wgg9DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+Q2V+6rao/pgv0FE1m5qN8Me0djZijGnK220qvyfDMdrdZkPi4nDCFSmtfx+x43DCBQK6g8X4ojFURdoMoyJAYGHOyr15WgfNQ6YRK90SQ76W9mE4Sk7ncze9USuWKBkhqfIgBXBnIedw1qn9U5jcLBkVsyzNlyzcPkw77cqpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AdWXK9Wx; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AdWXK9Wx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5kXK5QxLfOxfDzB0cCyAWp5RTlqcbCRk4At+YTejbdR0XHFz00+gxpv7AhYR0rO5hsS0vB/ofKUpBItgNzwB3eTeZ4s8PbGKKVysA9LlPTNcSr1vkQyRycqwhAkH5oF5Mj5n1iMq2amLMnHISr1J1C5Jxfl4kUMA/7HesGmqG2pnwvz69HGXTdKW6YoqZFmczZbN34FVuROkKf9J9l4ZGPJY/uiPRDCEWOcvkYDhMXsKuHLzwUZubEfoa9o3TP9ehs14eJvrl23MqUhp3C/WYruLr/jI/4NOVvOPs4hbQ7JUYqj363qhcBAyddXq53W2leDYYKPpQwgWzIE4h9hUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+RSGohamDFPS6Q8CA4NUxM5hKKveX6/oZNLOFjw3qU=;
 b=k/jgz7LWmixxwsS7TwVCPJ+obiEzRXAZbMsmOfgZb8MjZu7cqyo0+MHe8+1xidDHDsY/ggY0A2D+olcezH2C4Z78jCgB5LsY2cGWQsLhl4hVFb0anzoPdAiy0pMQZQcyb5iaogAq4Lkb1ZvaYahTO8mWwNS+dJOar9551pJ3Nj7DCKDBBhr6lRk+UV5k7wbkVtORI9aAgl4IOKB6QgzLwuXG83fpJRry0m5vRw9bVRMWrr0Q7uJlp/u0T+GoGJziq77ccQifIwXXhrJd9/dZqwIjk7jdppCSxDAQl/yHSs4UEodcVuGoMQxd+pTxyI/ewwxbp+rpevCgOeqkJQl1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+RSGohamDFPS6Q8CA4NUxM5hKKveX6/oZNLOFjw3qU=;
 b=AdWXK9Wx/5ftYYq9VjvukB2OjVh5I9FZg1JDEzZJVXYaxIlLnHA05ATynVaGFfWDm8CEDx2J4gZlD+2dUsnLjKeTnlPoVWgqcooNs2tAXTTIQBDwFiUOdt5leOjnDgN/Oi1xsdoxDRi15AsxoKKmkULW3MHxFZI9hva5k/sEoQ73yyTMZk2oLcjlP38bQDtFQCur011bSKRFH6lcnKjVtWzVQLzRhKlfZtbGgDIeI3LRIayCdHd+LCyqpOgPMmdtAGcPCo913813jKDVqUXEa8KOxojPnmfQvZ91Wnx7X3Lcx4A7s9aYGZU48b5ipex4EE8SwRXQNw6qdGW6FJgWuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 11:59:38 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:38 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 5/5] transport: Broadcast sink: wait for user to select transport
Date: Thu, 25 Jul 2024 14:58:54 +0300
Message-Id: <20240725115854.234781-6-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d0c4d3-099c-4232-a638-08dcaca14254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wduzzD5KLJOmZrxEcmPGzv7vi1MFieuYDzcpf+vfMCQAb6YKsJUroMgOt2Mn?=
 =?us-ascii?Q?WrusqXLfnxx/huOE9U7bJtj6slFGTyY8hq358Haq94L2LC2JdRCJ/DT53I0j?=
 =?us-ascii?Q?wV6+jioBHuW9wGM5GTcUcaTs0VPUmCBUWvNQigcjmI8Zv3cDx5MkFXAi71pz?=
 =?us-ascii?Q?yuCrm5gqSlwKqznzNV9q+dTHcKzj8Fu0SrD17CweuX2J8vJwCmOI5XiZ3Bxz?=
 =?us-ascii?Q?U4tcVeEfrHl6pzMf3ueZIIr7fCFsmneRBmNDvf7OVDo1G1iUOCjOEqvSTk6i?=
 =?us-ascii?Q?zZNW7rpXJPef2frJuPDnB2MrGr7Xj6wrZqAq9yrHv5x5LNkXywA8lBEDWvHW?=
 =?us-ascii?Q?i5RpsnnoPSYJqHZFCwv1HehrEAAar6kpkiJWBllBHg+ggdQT3bhusKOYSAZV?=
 =?us-ascii?Q?XIRCa9asDLXBcvsbfBOfOXn6eCa5PMsOduN8OwfvnHDJMH+vtNNOMNnK1fTd?=
 =?us-ascii?Q?xyB/hnyAohX9OJwuygFRC/7CWtysuKBi18Ja9JP95+FXng2k8rqDs/Zpizw5?=
 =?us-ascii?Q?yArTPTtS3RLO8WFvwMvh+GIsVtL/nJuCeKMPnbDK9bY0hF16aajEi9tHtjmW?=
 =?us-ascii?Q?sxaMPJIBF7x5w4UN/dZ5h1MNhoRHrqWE68cT2anQTVUw3RsPM86WqGO3F+Cv?=
 =?us-ascii?Q?RouOf4A7fkZLV8ILt8CGkeQmJ9Mp8pnzMrw6Z+3bVI8+Lb+OcHWTJJx0yMuG?=
 =?us-ascii?Q?LgyuKCGq0G4Su1fD9bdDN6KnyknaABDQpOMqCpz4vKyefI0gs3UTFHiM58c1?=
 =?us-ascii?Q?kR0ucV78PASMCPhaIub1X8Z1LHfPGrseNROUy2kpY6kuKzKF3TnpvB1ZDivZ?=
 =?us-ascii?Q?jy7DVUjE+b/ZiBI/97d7WDAFZj1UMVVpstsS8gmyQSN3dLqGoKXEr9W+hEtQ?=
 =?us-ascii?Q?AKRuGINb5MwcHZUiXkNIa9T/CMlvtXpvsocmLMTzq8xz1wyUrApZ46jFtAhc?=
 =?us-ascii?Q?7LaO7fQmaCSPMvBSUZ5mL/AOnzS3Tylj826PedojWf7NJLCVsGqL7pf2+gBu?=
 =?us-ascii?Q?lHcGlaIhWQ5bsj2IXHKWS1v8t5XpP+R8WrYmeaGlZaBJbQ36gXOLK/+5WRnM?=
 =?us-ascii?Q?wIA1+sZvuiWRpv4ok9+NFaFARobR17XlkzRvZKDk/KN/iMLicAoptiHaHQXu?=
 =?us-ascii?Q?FMJoOCbiR3Tzwn4j4YQoK9ixSnU6jDOnsq0sQdTF3sI6GYoU/jdtNpOYKpru?=
 =?us-ascii?Q?wYfx20xKtc1uJKi8Ge6PB67qspG7q2YwpP9ECaO3bTMLYUDb5HrnCzuCFEdH?=
 =?us-ascii?Q?yHLf53LrELPlFqUXJZd8fzpnAW5BjRHOFUgmv4LvJJ4AosoOxwoCtcaBVuvt?=
 =?us-ascii?Q?tCr1iCZvIexdXD/7uC1LTbA5QnJ8DAldnmNzfJdHvhhJXFj4SZWX3nueZUN/?=
 =?us-ascii?Q?WUmYbNDin0tSTr81jdpd6xcr4ia2nfQliaQ46a4TavPuYB4SDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5n7wjjnwdEIcJbfz8ZyhwqiIRomegiKg8z6ko/3zdWPDewz/VJl36ePr9SSK?=
 =?us-ascii?Q?JNy9D+kFeh5hsCqq+tMS8eNApLd+zfsahdCmUA9Zk264K01Lh2SWrPLH85I/?=
 =?us-ascii?Q?J1ZphERuK/qCvJzqSfrz/STvwkqzow0eur8yWaL5+LAm3fdOx64fBkEKVXkG?=
 =?us-ascii?Q?V9PXRj0WSx1eLm3HcesyedmK8AurOAGuBlF6zCNXhuF1HclfHGzK3lvXktAD?=
 =?us-ascii?Q?SMnVqe+UfBIOj9XiUYJiIR0e0A5Mz+qzRjCqx02mdG/Pb6ABI+/nsqS4bHSS?=
 =?us-ascii?Q?Myk/c/N5G9oj96u5CrSdhS4+SkHbMqRWSdJimlNaDyKmTn9btJEOdsNSoQVY?=
 =?us-ascii?Q?r2NC1Xq4FUfUM8htC1Eh//sDT5dofnVpRcs/NwCj73wo7hdVNwm1p2zO6Axm?=
 =?us-ascii?Q?QfgrE+kyVsMMFaxEzkHI3PI4ArXPKChooTbrffEkMa+/YWvuQ2mTB1Rq/5qa?=
 =?us-ascii?Q?m3XAuPC1psuDfyG7t1i+49HMQx5tCw+ksmRWTYeO+1U4EeK8NNN5RB2dI42U?=
 =?us-ascii?Q?Q08SGR2Rf6mRtvrbqDG0tWgc8uWNvi9ANCU55AnzGceja3DoCG2KAm9+JPRD?=
 =?us-ascii?Q?mJfnH75sCbkCaKGpOFFHFy60B9iNHZoS/ZY56EXo6v6L2w7CX98TmY3h0p8T?=
 =?us-ascii?Q?fzOSKEDIhU4EBPeBSpvUgZKWPD4v//IHJ7ZhogtNRa9elOetllA3Ybeiy1Ox?=
 =?us-ascii?Q?RKLKc8RrH6RLA9AOhGV9iIutcf+ARew48jqfxrhZHOibyMNsQespNFl23ZgR?=
 =?us-ascii?Q?MuuODZwTQRz9jBonlmSWPC4I7qw/CeZP1NGbZS5qJKKV2rthC98PM49lz6bj?=
 =?us-ascii?Q?h3JkejFQKpUHNseJfZ67wiIHgJ3TR1Z2c1vGv2WDtfXBWByCvQEvGQ7oHrEi?=
 =?us-ascii?Q?FbAgz7PHtSzeEOO3iJKZiVEMPhezkaNboNOds8mZs9rO0mI399WCyOtKNfd2?=
 =?us-ascii?Q?XZS0+NBTsjeiyRsxOZsHhZNKnB5olUUnTJJaPm3b5Ak4orcj7IpWX8xw2+7m?=
 =?us-ascii?Q?yaOktZDbM/rFN6Kfjg2oCPrlhHfW9D8PI33sc6iw3JWgoZikDdh16i06oneL?=
 =?us-ascii?Q?D1dfG/SHreYhEx4MYMVJ0Y2ddau2tMvlXiwVpK8M2R6OQHkJ/oeDuYZpHyd9?=
 =?us-ascii?Q?XlEUMsLtrqtO6+CnCZTUwuIvyj0DCFZQ3t67Ec8JpnCosFLVkBD/r642yiL9?=
 =?us-ascii?Q?jYqiaI2zakSTWUqeIwl+cYhJG/NrPsrBUePL9ntgRKSw9QxED3wXuL8HDKX6?=
 =?us-ascii?Q?YO+MimkGlfuOBcqE8fX54BG9X7IAis9Mzt6/SdEYqGerHaZFzug1qeX5H37J?=
 =?us-ascii?Q?+wJVOgl0apK9aAB9bK6EYC2tAvGgz5pZm6BAm1tsZc0qT+Nj/KSHxPLZ6Pzl?=
 =?us-ascii?Q?udx3K0eoCUpr5nsshFhwR7Vu0V36knUcdocdG+dYAcqk6RAhkdOkMdIAlKxw?=
 =?us-ascii?Q?bQGgxhda4dCISxQHcNFjpScC4sMk1DkfIu1bbqbHgDYuWypWiW1u6ibBG8Sc?=
 =?us-ascii?Q?6Ts9qWN9c23yEaOGfUr+GQiQMFYn69axHD9qynmt29XI3hBZwraedGOYWpE1?=
 =?us-ascii?Q?+gsbT2DhmZm0maRgSCl/ff22lNOq+zC2roc5qQPv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d0c4d3-099c-4232-a638-08dcaca14254
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:38.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dBH3/qs9LpPbB3tQnKo/RnRYQ+rk4CqM0Gpdp0Gp5sC0tTaYJ72xYPJYwgjGw9ZHMtZKrB3C7YIbUuDZ/Eo5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.
---
 profiles/audio/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bf2215a0f..54d0ca1f7 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1303,8 +1303,14 @@ static void transport_update_playing(struct media_transport *transport,
 			if (transport->owner != NULL)
 				media_transport_remove_owner(transport);
 		}
-	} else if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	} else if (transport->state == TRANSPORT_STATE_IDLE) {
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BCAA_SERVICE_UUID))
+			transport_set_state(transport,
+						TRANSPORT_STATE_BROADCASTING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	}
 }
 
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1686,10 +1692,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			transport_update_playing(transport, TRUE);
-		else
-			transport_update_playing(transport, FALSE);
+		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

