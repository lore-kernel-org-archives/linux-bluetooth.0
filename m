Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBA1D4142
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045358; cv=fail; b=HmbY44rMl9Bve5hcp2yBjMMuikvd0WOO1LXH4jDSJYJcG6+V80+g/OFLFzcsOVkN9wL6CzD98XizXqs/CH2UVRK2BFGOzDe03+8xN1Y4dH70ld0OBuQvGdla621F12r3UaWJN8cH1wl7vxVWD0I8go7dqbjPTASJ2E0Jn7dczZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045358; c=relaxed/simple;
	bh=3LiWh++nUNfozu/xEC8qpB66kBrJTm3+3CNJYz5nMeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8J2HPgbcm3N8qov8/VNv0EkmEKJjzGPIop7nkTTbxpJd7tyA9GXpDgToivQstIB5zByWrkzCOw+mYYCBZIm+mDbgATl/KbJ+Ge15ZL2jyCmM56Dy3Mnf5NW5W1YT2qHZ3j7FXE+cDksLI2etTh8EF5T5gb3Faz6NaDEZ9lWuXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eUXbYvFz; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eUXbYvFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb/hRW+/wXt7ZWaegUrMJITCrJ9wOtX7HXgfhTjESjtafwtvgwNGq5EwrKWfw7MWVxJYNGRhMKb2gFEqYDD51EoFGEZNo0lFA0/02p6bq0wlKvk8vuArl9HB8r1NcZce0ewd67akIKPk7M2lggo0bMJBXa1YkoR8bT17VMQ/tIMbuXgWUUbmKwGQmvUs45amaFsUc1wSS+YmEl87V7bC4Q3VIXdTOjylqCipeyT6VzBhIBdcGLeopACDpybXWfIg7i/YjE0vszQayKI8WHaFRwEhsLBsxinROrBUJglp2Dinc593BB9x8ss7vlNWjjOpWCL93nB2qdQe+YSCzKCUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txo2QgUQjI1rbyu+smT5jj3GUgKx9AvL0ARgGXhFRls=;
 b=Nc/+SWkfhXZR14LQI+x3/HO3//4sSb1rM2GZoPtb/6fP8MOm/joYuBrj8DYEPZgBUTPjVP1oGrDRWSeB/pue8qmbpqlkswOJFvt1hB6/eALeMefyVEb0BA5qZmwk/+vFPd/zQ7iTVWtLeLOrA8fDhdOyfugepIqWVmR7fyzQ+OUwv/qwwD7+5fPYYeVOUTNxfOYD63BsClEMXfaQCIelgS898u+MCt31Qacwh1wv+IIN1KLuHWKk6GuurG8PxoJHKuM8iS8yYClIGBfuHesK/G4RZq/pXw+w4PS6YfKOo1VBmYK+hiCfnQ7EF5z9guerq+7clMBSN2KqetMhPiH3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txo2QgUQjI1rbyu+smT5jj3GUgKx9AvL0ARgGXhFRls=;
 b=eUXbYvFz8btDg3707qbyTdpcGw2pwyRJQPdh8J2rimeL4uqtWOL5eu+3eM/oNGuxtLhaDI3w4gfA9fPg4TgIkSDgS98ZVO9cOu37tJt3+K3cvZiz7/C6sF7T3kGqab8bRQFwtAvZwDRwVWxjLLPrCGQm8asS9/WUsO1wVKgqlBcdRDUVdO1Ubs9L9AVU+d83D69i5eLuebFoszaqBSJm9c+byiQWcXs+024yotIrcFm+KLD0IPeB+mUWNuDwlfTWp5XZB4LjEZFzBGBr0xj8ujS5MOk2Hoopvl9/OcvpdHWrysMsqG0C+RzWgyFE5st1E8usIuRjHcJPWOyPR1y+pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:52 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:52 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 8/9] bap: Update broadcast sink state machine
Date: Fri,  4 Oct 2024 15:35:22 +0300
Message-Id: <20241004123523.1012743-9-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 309f3709-a19a-47d4-0e99-08dce471159e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVtZE89tIdRLUZGpnoneOMa1CXn8Z8BxtpRFMFZCtwEmDFRmLcFu5EfY7Zj3?=
 =?us-ascii?Q?iJf/90Vcp5eqewo8tPVRP7poVRsD660zFngTjwcgb3lc6fz1UnxgnFtC2eXR?=
 =?us-ascii?Q?6lATt9sdnkP/3NEUTvHmWpFXkOJ46PQnwKBZ/F6eI/sw2lSPdI7s6EHxaMym?=
 =?us-ascii?Q?/xb0wH+X9bTYxbbbHyhqoswQg66yEMLuXcloP9avyyp8tRN3tVZRr/rwtTuA?=
 =?us-ascii?Q?AXqPb4W5xUlPbZHN+otWl6HeYu5L5iX7UB5gVgT6/ZsWoHw1gbmQxyJ/dDW4?=
 =?us-ascii?Q?zzp2ZUKTy/jq/cvMhziyS2FUCyGvAFn3DDGgFebUhz45AOc50GSaC/ogQMYE?=
 =?us-ascii?Q?A6mGFW2y90NoelvmQ99Es1Wx3iO83JuOA7YT9abAYGXf2zbEPjPRNSwB/05z?=
 =?us-ascii?Q?aL2wQhWxXlHDXU/AVKS7TXr2Mk+LMWhoK61QHjYPMuHobA9p8Ux5eCMho6pO?=
 =?us-ascii?Q?kew4x7Diw6zwq8eqiLAsCfR6z/dw3KFELAcPYZVvPDK15Jw+qkuL4g6UwaTg?=
 =?us-ascii?Q?K4ZKG5+zeW2X2pouzvooG56Ejn3dc4rtLGEdz7NKq/GG4eCyIUX+TiD23wGi?=
 =?us-ascii?Q?wmDSM8Ig/wh5xyoUvUGhCfXQ/mtDRFhwjNX/waKIOagXSE7RoUpBMA+K/KOp?=
 =?us-ascii?Q?zwvPhTK+AO/9dMjPqV6ZpQna8beT+d7CltAIcjKl/VMVXSrDMWuXTCvFmYNP?=
 =?us-ascii?Q?RAXUWC/YydP4cgpn69B58Jz/FDErQhxVTeW2Yw4sKC8+F359PwpJRABgm0Xw?=
 =?us-ascii?Q?AI2Le2etcPc++XOC8wicyJJ90dgpmhqBK3bqQ5J5c92HD0IkX3z9dd/5e+lu?=
 =?us-ascii?Q?vYvo8Ls1dCSJRUQR1FDUKKzD7TdclQEYgyMU2/ilF/LNS83mwrQrfr9ZjqFO?=
 =?us-ascii?Q?nlt22o/bVwkbFE84L2g37mQ6OuKFvq74C7NP4ijbhd2vEoAhYJ2h3EDN8u6M?=
 =?us-ascii?Q?aVGuT4ZJpqAWIoxv1R4sjAbofogKfTrRYQUq/pLlQsJp1E7QGLfJCnmbfPjC?=
 =?us-ascii?Q?XMK0kHTFukYXo0wAHc2XwjS2sqNYgTYhq+23KARrL/2bObQr7/hJE0DAYoXn?=
 =?us-ascii?Q?owWsu5kO6+5BQwi2RYEEI3JlXByHH/GX7dqFGZLtAMQ/spJZ2R/9jhjmZor9?=
 =?us-ascii?Q?atx2uC8tr2TUItfXBe+8pwOnyxUM8TcPsI++/aRTBuOF9cIgUR4K//tKj3h6?=
 =?us-ascii?Q?BFhbnc1ugsdAnsg5AeUvq1hsRkBwp1cJc8X4LwC3lkyKdgmSfuGrkClQEvf8?=
 =?us-ascii?Q?+HD5WjTEmViC52NgERm3smMbdmpEHStMdUFkR+IAtsC9zoHx8qCfKpmsqIBF?=
 =?us-ascii?Q?K0y2rs7n7PxEUKkQaHgzfrnI/nu8SvgZPS9XuoRCDcR5Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrimCrp2PjRKD2oWWhGfligv7OIkWFFn/2o+yTjtNybGFKToPmsbPdJT5FOD?=
 =?us-ascii?Q?nkjXd6wksdmbJ8T9VVar8G8NfNZ2RrDL7EpXnjAm137WZKSbjdocUMXY8drF?=
 =?us-ascii?Q?jhwxQqe8lEzIQEwnu/3xPwRkBrdy+zZeplVYO52TGt0VyURYTaWCwU0CmIbu?=
 =?us-ascii?Q?uue8pSAocj9JABfoJwdKqsHEkMcDRkdr8wH7op9F/QAnpWLehX6haymfKhD8?=
 =?us-ascii?Q?sgoScXQ+EHSxzzbkWnJfRoVJ8EXuA0KN8Al+KTdCaRxuJt5CXDE+ST/ZTCRS?=
 =?us-ascii?Q?NnpwBEhlbq3oTMfuXEvAq9LQdVae5ieFvG8DyakAsUHU+JzhbeDq10l3H0E+?=
 =?us-ascii?Q?6j+U3+ltEeUQhgY/nqiCBHWHIc5W/uQ84fGg/gd3D7XhsygxKviyGdPP7IyH?=
 =?us-ascii?Q?LbQG3yrDgpSFeF6tGe4CzZVsdT16f0mozDB4HTH4En0YlpDnosRYrhfWXmwu?=
 =?us-ascii?Q?WuWAI9G7WWC9LnVhpjXYQzHcAXQ7SrDyr7oLW31uuwnMF0xpCOd824mfXl3Q?=
 =?us-ascii?Q?f/J/OSjoy5Vf/GWqcIa4Bc+UMD2TlTfjqnZU1gXtrq6P6UYdPlUJZdxxheVe?=
 =?us-ascii?Q?+5OSL4ZhMKvqyM8dOhUvtgXIQA2hXC7lTI/LH6y9cpW3QJQWfOggrv/nM2Nk?=
 =?us-ascii?Q?sgUlcdVRSsxa2MeF6Dzwkp5wiiD99j1tYMIz3WAbYh3+oa+wBGOvN6j/fdvF?=
 =?us-ascii?Q?CY3w6DHvOezcmz1T4oNDy+HOnz9SDFie6vsTEWDI5eFUsWIKn9l3N4YInbMy?=
 =?us-ascii?Q?9zAvpYUjteQnk4vG8g1M/Mt9G6dcedyE7H04xM+EDvgWPeuC48n/tlXCoKJR?=
 =?us-ascii?Q?mU7ESIMH+iVFmJLflhcA1JrWhDbCLlDEmUnD97zvKbpkLdfoUCd/29aC91vT?=
 =?us-ascii?Q?POYea+vFDOAXGotKQkfmOT4yEDjScfSiabWtS7Dpydt54bRkNcURAUPgDyWJ?=
 =?us-ascii?Q?ZAnqHhfBcsvSKpHCihPmHu7I9LLwDYD1s1h5ttaO/WLUR11wn3argUnzq5W6?=
 =?us-ascii?Q?6g9Qljc1I6oSk7F0ZUdBu6Ifian8p9ao964/2gXrTh4i7tBuvwrpDjvKq/1h?=
 =?us-ascii?Q?9dXS/lvHNj8Cu6jrdKirMAS9R9wBn7sK7lOw/3wCqEsPc3nJJ5tJLXFq/rYK?=
 =?us-ascii?Q?3ymNgopgTF9586PeArF2lwWNR8Abyd8lObUYLDcjkxL2Kymsji5jj+Vv6RIh?=
 =?us-ascii?Q?ePSxGXBchKIXYHifk1omvkRK526WgyKwn1D7O9KaOAVL2rbF/gWxkuRgR0P8?=
 =?us-ascii?Q?yS2spxAkJInstub/dFxosaYlq2TgMFZa0VTtz+sub/PIkrwUL7ZHYASl90ey?=
 =?us-ascii?Q?04MdQcW1pQD8hYBjiDk5XEbfE9pLFi6U5cj5QHiAXN0/SGjPSZ0HhoP36y+k?=
 =?us-ascii?Q?ENVGapVJBdNKurOiyPTAwRSNDNoOZG3CD7jhGWTANyALRuGEL55kyR4V/Yml?=
 =?us-ascii?Q?LHMngEj9DdS3Mrehj4LU7lP5x7mSiP5iPn3oUZjVeAfuVqoWYeXHxjnLXAOM?=
 =?us-ascii?Q?nw9BGVPIv1zmX8PTA4QgoUNg4TIgMbp8+M82hI8OEIHdpJnGNkBDwKmyaGKq?=
 =?us-ascii?Q?OXl9nLsrjx6k8AP6MQ7GxrOr5DJa08H7DM0hbpiN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309f3709-a19a-47d4-0e99-08dce471159e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:52.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4b6/rnlFaCCutCNcdXr734WUGIYhYBIj/OySU5Bs3tIa3EoIfCFmM2HwkGbFUGzXpi31fCoyQEoUIbQpcEDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

This updates the state machine for broadcast sinks such that
setup_create_io is now called on the enabling state. This is
change is required to support the new, sync to multiple BISes
mechanism, which will change the stream's state from PENDING to
ENABLING and finally STREAMING.
---
 profiles/audio/bap.c | 8 +++++---
 src/shared/bap.c     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7251d8759..75be494af 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2748,13 +2748,15 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup)
 			break;
-		if (old_state ==
-				BT_BAP_STREAM_STATE_CONFIG)
-			setup_create_io(data, setup, stream, defer);
 		if (old_state ==
 				BT_BAP_STREAM_STATE_STREAMING)
 			setup_io_close(setup, NULL);
 		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		if (!setup)
+			break;
+		setup_create_io(data, setup, stream, defer);
+		break;
 	}
 }
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 122f72665..49db341cb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2116,7 +2116,7 @@ static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
 }
-- 
2.40.1

