Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC7A15D5D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967701; cv=fail; b=LW5ZCkrWN0J9XCaoIU380t1PNj/DbJ2LN8ivGjoguQw68wjNKLL707XuMCap3VpxIIl7Eb36MOgTfwAcyEW21LSDzftr42lAMcWnrQ5kbOCoTYokbPiVoP1IW8UyNEu6msSi6qVBBz1ihgOSbGgdldQI3fAPVfZMoZp+2npGKPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967701; c=relaxed/simple;
	bh=kCZa6rDedY+yOCenEVm1iWfLZdI7umB4Yn8lmk0B5kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nfq8HePCM6HFiem6qUL3HDtpB+NJkbiW1aW0CQU8YhCibrV7OPKm0LEd8ixW+dmsljU4n4fG6g04DU5rgvuhpTrja8mWpnAKcdlHdfGpqj680D9H6WE1ZSNMgwpv/5N+YhyQTk50syHgoAq3UYS12KftM/gjFFCwHhEYZMKdDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=egwWdn/9; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="egwWdn/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCA5NBHwl6x/G3IIt5Lw8g1mwyiyRXDcnarK5t/crKO36aZED3uWP1l+py64SkqoBqla3Jm79y5bdM93kFv3DRdEu5AFyF2T2UiNoIKPwDtXMGXmvixXBzJY0c0iKEizLRa5zAXzSlKhm74ct1ZDNL4pbGt581tmFIUfqw5t6GuTWcIxMiKEQ5H8+Ap8k4P7KPXFffZ1eoZGhwkLIuh/VLHEl8rP5xyY1dtGWF9pd0BfpYqfDzzKiGoe9yynBQSys3Q2flY/RDNRCnxWMFdzxMY4mG23EgdXYddKEY3DHhwWzNlEBjXpTlfQm7Fs3fyiRFyEAhEbAi/VZ8P1Nu6AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j86YT3G3ebyA2k/zqzfN/RCoZwTdaltCqTWIXzuhjDw=;
 b=hjWGHwdKX9ouer7Fn56p1rCoK12awFwVcO7Kil8vm0SBt2UuSsnZLh9/Ns6TB4P9nzMXTnghz9DgYj/tV8YKfrbtZy3Q/zBYwdJ1MMXTDG9n006BqmpPpp8uj9U99+w4VBe0bqA49yCEsq05TFgVs04DaU0qvyy5nwLEGxb7RGRG9H+2W4T9NxDvNwpHeLZw0AjzYU4MRMPzsbWIRnKbwhYdS/83y9uVZJ28/bOhqlJCNrQ/kJJrA3sc6jaTGtmBzY7ujnZOLXVYoP4w3YFYDqAibbVjUuwpa9YGKPJ/Ttn2iO4jYPQ5yuh7UC3bSj7SBXiaU+sJphL/cRQW/Zr/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j86YT3G3ebyA2k/zqzfN/RCoZwTdaltCqTWIXzuhjDw=;
 b=egwWdn/9C7McumN6s866/Zwfv9WLTqw0Nli4s9mfFuJOepJBj2nNCiWgWvGyC5O8QepI5qUKTBxZVUdulBYMF3M1j8A160tPoS76VHhXgUcHCupxGK6IEmu8UIGcgh2S6/X6uRYLe4UyZfp8lA/aCWb9ZdFT19iC0/rBt2fVnV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:08:16 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:08:16 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 3/4] bap: Improve handling of pa_req timer
Date: Wed, 24 Apr 2024 17:07:40 +0300
Message-Id: <20240424140741.73899-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
References: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AM6PR04MB5384.eurprd04.prod.outlook.com
 (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 929cf3d1-9bd4-40bc-a0cc-08dc6467fc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1wookv5nCKfKKnRkFGczII6LAmZeosm67/Cubzuffek0kGp8X4RuiQHXCL3?=
 =?us-ascii?Q?biuQ8X2MDStAfGtXlVrEx82ns0IZTPmT+Nf6dEe0rcvEGYFMlg8AbuUhIhD9?=
 =?us-ascii?Q?xTP2+a855CBdd2+9WtpgObERmzoibCIfY66MTA7rhh2OB6rh+ZnSnEji5a5e?=
 =?us-ascii?Q?pzKfAwg+c8u/AWPNvmXJGZHI+LgLxrf+slB5xnBu10xgk4ADofiE0NaYXuJn?=
 =?us-ascii?Q?BJg40/SKpJQU3BmCfWe7VIIsY0iWO/KvAyv82ewNfFnsmjX/5XjUKRJ8PuTh?=
 =?us-ascii?Q?ZDRGh035OJAVsdM24YoGPKpuR/qKy8yyiYJzJOU2VArDb4uzHeauWZV7RCis?=
 =?us-ascii?Q?s1sQ2hLrqIdRn3wMrOUqYsAPvFLgvy83WB04VObQFQuFQhUuZQn34TSjlVn+?=
 =?us-ascii?Q?S4RDoEia0XYT4jEeccDdpog3OJ4Rtxekp+4SoMc73pXnopW0BN5xecxAIuvj?=
 =?us-ascii?Q?qm5uACBWZJUVCTd68P5T3ImZF810kbW2gE9+iwLCK2wHr+ks35lleMwFrZs0?=
 =?us-ascii?Q?sxsV/vLkJ/BhQPXfY2KAAETbp3scXB4oNTjjvuiGemTvchzQPfB1YWGThFbV?=
 =?us-ascii?Q?etkJpmfGsdghE48zn7WKCh4nCbZ/SVS9x3c1YU9CV+QsnX79vpE1NM/gEdmL?=
 =?us-ascii?Q?GLE99GBweLOS/HyEx/rCQ4dFU9K+vhF/emButS+seg4Q0qtb4Am6hRX+NF37?=
 =?us-ascii?Q?gZI+gmw5EOHpZG4md9NaCrNGr+L5NCcbs8LN4sYQ4ocP90qvsqZc7ShNcEet?=
 =?us-ascii?Q?PipYva7Ups4WDdGgIJQt2yxRDvvYn4v6A4Fatgv2T0xBEMgDJp9z78tC/2tu?=
 =?us-ascii?Q?kdY1+HzIlcHkPozPTbtoZYjbqpqCfdMuJ7SXOh0CM1YU1xv/dJzksub4ddiG?=
 =?us-ascii?Q?e4mdar0kp1JEQRxyBuMWClsMjkoogZodDyRoLsuBWgJR4/xQTbCcqD1GKCua?=
 =?us-ascii?Q?YRpMT7XMeFSZw+c3qeHE1xCkcdui5mFDH24F658qlyMH3N4z62+VYem1Xlxz?=
 =?us-ascii?Q?4lQGx412u7YAGw3enEcekZkISkLlWpd7fC3zs+d47G5SE2CH7QoHSZIGsaLS?=
 =?us-ascii?Q?abBMj4j8qHLwaF4RdKS2TZ3XU3vKax7EAyxoVjLAP0Z37D1iGciRd2q4rLKk?=
 =?us-ascii?Q?jl4sZtcKl0FGctsm9H47gwCrU+A58LIax/AWORri1PjpGKk/OXMUcHmLKC75?=
 =?us-ascii?Q?19PXRIlQhEPsOLRX5/xpcLxREEsDBT9xH8X+hP2B1lGWhvqAbaakePyZP/ho?=
 =?us-ascii?Q?roRaUcw36auaSYEE1Kit09MBVGc5m1T6xJ81JL+EogLnLtf8/wvssYNNx7nK?=
 =?us-ascii?Q?hWdwdxlEaUpRjhnoyvmIdfV/Rd/13to3aD0o0N26qT6j6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jc54cLoifD6GtifKKo960YvY8r2yivYu+OY1CvnuU0oQj0FlDgzbnHSq1zdb?=
 =?us-ascii?Q?QOXGh3FAD2NDfUkisJvlYhXje3V1zRl6Un8deVRei5OyZ5sMAKsfFi2UCcY+?=
 =?us-ascii?Q?uZklhy2ksDSUhHG3F8z7Q9D1pSm21LQuGt93994qUuPzZIaw1W6XSybJl8D+?=
 =?us-ascii?Q?rodcGq9I94jNLbY/Mx52rAiwdzfL3o+in+uWq9xXBuWO+roZ/GVJLL+DO8Jl?=
 =?us-ascii?Q?RwP+13AnWE7YNFfvjzZy1/MN09V/Zb8OFjzzJAvavBgxu1BezelhbrDO5qer?=
 =?us-ascii?Q?3I/vU4ELD/18dGXJkcKdvbfdfl+gK+ETHCadskGZ4a05jjjvQiDTmOf8Fs96?=
 =?us-ascii?Q?0FpsTryTUgrlsNOiif54SWaBTq+u6fn+2yDrsjNyPOPknyz71te2s2DpLkY8?=
 =?us-ascii?Q?fpdvRdhtb/qOX/sksHIKnViiw/xm8wW02bzA+/5LwWCMwcpqa4ENjMRSeQ38?=
 =?us-ascii?Q?BNJTmRAoiq39fqG3YzPqH09pzf6LlP9HPabIyvMz0+E3b7JdOJUgg1YSMmyU?=
 =?us-ascii?Q?QHXMxs53tAa8QcpT97FvxG63ZHyh2Pa/KT2djWL1VsgZnNjwNq3nUTPIi63h?=
 =?us-ascii?Q?DRmGK75HCxPgafhWGp2lZlXNi4WbS/z7yttP4pJUjGloFAyIKxha14499z8h?=
 =?us-ascii?Q?pfYZr5n805SbdbvjOWAtql3eLIouTkqVwJdjugxbO/U9Ru2tyEf+jVp1vnIe?=
 =?us-ascii?Q?K4A6dI7OVpt+h235dNb5EzicBt2cKVYz5R92Nex0lfoiW6ZoQnd1vLpNaV5o?=
 =?us-ascii?Q?BeS5UnvcCqrwJLHNxzgp8CitE4Ya9ULMnMRTRTPkI1E/sH4bwqI/o2AE+Xo3?=
 =?us-ascii?Q?7wzP+aSgrjdiUGbQhXikAPpX1ysP8410x9rTOhBQenohSGX0KgPHBMvHSnvq?=
 =?us-ascii?Q?eA5R+IqS3cCQHg/72YihMg3Pjh51wwpuPax0H0jgg4S3i7WshLHJV58a6LgY?=
 =?us-ascii?Q?PEK5IPkT/rkZ5Uj1RZzW64fjRhHpYx2IIgYx5U/7nNgxo9v5ZEEXDz8WVb0K?=
 =?us-ascii?Q?4vxLjB6LhK09UDQHfSQNdWW3eU0LKdPUFuMEbNOuw3pG3LAs5/Gd/Vfj3gj8?=
 =?us-ascii?Q?HRJ+eXb0jrmf9cXEVQriitvryK6B/VwbVxpMofy7d4b1eM77ZVz3uNMSS1iT?=
 =?us-ascii?Q?3aMExEyN7HU5rXRTBfi1b3E276MgPvj1bWFzYnMaVi0Zqm8CasZwAahw4C0R?=
 =?us-ascii?Q?Ihc+N8WpeuYP+bn+0BFrHiuwyERljZXCDG4Y5eYPZQAcpLj0qdLU2iU81N3U?=
 =?us-ascii?Q?7JpzdCP51xn7wXtIpeuiOffZ7lcVxMFfP+pGmtcPEr8Hgw1765LaGFD2wAR4?=
 =?us-ascii?Q?3e9jZbwuhe8dcE17+j15W5ahCneVqUM1Vb/1cB3JZbBeclkpfKDG7bid+poM?=
 =?us-ascii?Q?1EFpAyELm+RPABLyMpj8GDC2ZJdtpISpVGz/Xdgxa/3poUZFJOkqzGQrA8SM?=
 =?us-ascii?Q?cWCgAThnA1tU05tAx93k+/GSShtoMAsdRDZYtkQO0eLm+yGfO390MgUBYEtt?=
 =?us-ascii?Q?R7Uu2MTpYIHw+Av9ESj/YiEpwPPOQ1YTAB2+G+8ykawgC5w/+SMxBsVT5GeB?=
 =?us-ascii?Q?t5hOkviuuGONwIzEzkOAfSocaYXa4gzo953d5dsk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929cf3d1-9bd4-40bc-a0cc-08dc6467fc73
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:08:16.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmYm8PK5cpSfWliSsB+r3IaYXGg5hxhraEboVpRkOYc6hDrxShW4tbnsfxi+cy+jjbufIOvIZLOQWn7n7vl0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

The patch handles timers on a per adapter basis.

The timer is now also started on setup_accept_io_broadcast, so
BAP_PA_BIG_SYNC_REQ can be treated if the timer is stopped in the meantime.
The timer is stopped if the bap_adapter's pa_req queue is empty.
A pa_timer_id equal to 0 means that the timer is stopped.
---
 profiles/audio/bap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d8cd05f26..ab0b96222 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2087,6 +2087,14 @@ static gboolean pa_idle_timer(gpointer user_data)
 				pa_and_big_sync(req);
 				break;
 			}
+		else {
+			/* pa_req queue is empty, stop the timer by returning
+			 * FALSE and set the pa_timer_id to 0. This will later
+			 * be used to check if the timer is active.
+			 */
+			bap_adapter->pa_timer_id = 0;
+			return FALSE;
+		}
 	}
 
 	return TRUE;
@@ -2098,9 +2106,17 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	struct bap_bcast_pa_req *pa_req = new0(struct bap_bcast_pa_req, 1);
 	struct bap_adapter *bap_adapter = data->bap_adapter;
 
+	/* Timer could be stopped if all the short lived requests were treated.
+	 * Check the state of the timer and turn it on so that this requests
+	 * can also be treated.
+	 */
+	if (bap_adapter->pa_timer_id == 0)
+		bap_adapter->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, bap_adapter);
+
 	/* Add this request to the PA queue.
-	 * We don't need to check the queue here and the timer, as we cannot
-	 * have BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
+	 * We don't need to check the queue here, as we cannot have
+	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
 	 */
 	pa_req->type = BAP_PA_BIG_SYNC_REQ;
 	pa_req->in_progress = FALSE;
-- 
2.40.1

