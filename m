Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3518DF6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150604; cv=fail; b=lW5l3AjduJOZXgrb98X3vi+FNf/LHxjHOBULEQYCmN3TWPgvwRGzkyUgu+ZsbzixD4fazO5fkZeyJuqT+APe440/b9Zj1V/Yplp8dEPUzyHGqCWowWKCltJRMSwvRmXpeEBBphT/THlGP4kO0kvd7WGfSmHmsTXBZO8IM03FVpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150604; c=relaxed/simple;
	bh=Pzu+gROpzRbssfrGnlhWMqASjJFJFEjMo3gTgOVB/ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DaC3cp4wnnxtV2VFT89ESd8h0WqHtfVLpAzJDAxUF1q5tKspBZ9ZDKMRNX+o+3Yg4veW2mzPP8yeGnoXQPZwF32A3hmmeYtjIAPLCGMB68iHa7913GNDjDkv/x6C470eEdAz0ONRuUJgNH3ZO7B645iUXZqKn8FUet0IXniGBbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJVdplSN; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJVdplSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtXdgT33xBExq2jPXWboBNv2SDD4zQwN0YFO9xUzcsVnVpsE1O+nB5/CDZWc9zMI++fwpDfVhJh+c80y/4dfYU3wAZhePZKTuaFX3jxQuyL6QFJp0SBwXNIZFESN1LPTvGWGrFI6NGPMADvw6EIjPolPSUmn7WW+OQlUxl9JUyt4bd3/CQQtB07BUtRFvKc8xoOs5sVqwsZNOg3nhu7H/+U9qTXBxe5frp6U4BNjDy+wpjIINT3Yqh63HXIgyf4zN/9ofS58DnyuO9xBY85iOcriU4iSXY79KzjF1E6DeXHucGzVnV8LTccfbOz1SK4pFA4jBEid8UXu1D96AD+rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=ves0VgM/Vt7h2xtK75KuT0JFR3njqbcYSJo+HY733wabUNDRLQS7Vn6IqPyEySm5mAtCigpSpiOxNBk9yza+So875vRy2GSiKwqBOkEPzXkGVvc65o7GLUXEYht4mV75lWex8yvwN6P5A4278o8FFb6gaIj7VcJS4qynXqzqFxC4s2xELBhHN9YwDrQBtYNJuhBcGrmdly5Fn9UzMnaj2orH6fhpcyYiQF9/Odz30uUpCHc+yfzWb9fpkrjh2ib2EJr/V9ozuQ+lEpSzRX7GvOa2I9MX5kogLkqhy7Wx3D5Wo74Q1AJIc4Z9PvJzbLZAnaqdMOd4ylicIoFGrQrmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=TJVdplSNfGwtuLMJ9D9/uWHLxfF8dnYrNdeHFhNmyPYV+woBYS5kUlQBWT6WvAxOFjEWtiBl2RHalk7cgJmaU6SAPsLQlbkcSuQGOen+bPt8I6cvnV0E01dPL0jWHR/QSAUbZHA+p2q8+RLGaFpFpHk8NycqKKQr5WEJPJZGbkN0VvGGitXkMp4rytgOCL4LWm0zeTJe2gMKPTvrHfokpTm5W9iNi2ANKC3LPg85ssMtPmpyDHu+Qd477/oUso0fGUcGLwuWJ+ajHgsSMU+vNrYbXwVgIs+z1F3gmrMzO/MQ8TBT5sh3lIlvh3Xru4en8qIsE7qvRdmdZKudrl+eEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:18 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:18 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 4/8] doc/media: Make QoS property readwrite
Date: Tue, 20 Aug 2024 13:39:14 +0300
Message-Id: <20240820103918.24246-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c27358c-6da8-4802-0603-08dcc104e729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qcjHBG2o3MuZCGNZei27zDFBnGgJv2orW346shWIzfy9tQ3U7r5NSkNBxy6Q?=
 =?us-ascii?Q?LdLpiSYFjRc05PVrF8qPqcGW6sEM2Fq17Le5c9SyBKLAUOy5y6QHiC50/RIt?=
 =?us-ascii?Q?NFssX7A/Re5254N7YHU9uSkfTaPiXiP/QvUV2MAD2DXWW/TdrfOK6VL8XBg0?=
 =?us-ascii?Q?+YWvg5yrMW9ufxfR08ghfqgZnvGRk2/8hhxKUSJ8S3Ac4w7EXX4AXg41NK5z?=
 =?us-ascii?Q?i5RsCRhykZPFpRJ86o8u9CLkytGBigozV3BqGZa3ypbkglfBxBgNH4nef/tq?=
 =?us-ascii?Q?JKMW23V7me+sMJapZcHDXS+e936sUXl0F/xhzwc3zn84GRjZfmOwgr9+TiqF?=
 =?us-ascii?Q?kNzVpbVrUDuZdDgloj8T+ARme0ShLCVX2FR1M3Bbgbr9yj7LMFvsk0c4TdyD?=
 =?us-ascii?Q?zlSXFHTQgcZ0kbcGCTy5ECmD7ZX4S2ihuks8R3cdGB4uqOkIxddTQNUPFpTS?=
 =?us-ascii?Q?2BjN6NEZqYkpZIVMQIzXakA2QHdU+Z/U4OZvQQAN5lRqqSyyjCNs5b4fLpd3?=
 =?us-ascii?Q?7qp26IEvv8dioGSJSRNgw/zXiVhTpBdB0l4aHDhlVu9q5Y4PvKLO3RUntLAZ?=
 =?us-ascii?Q?KcdBMnoXAyh8xh9ZVomPK30aPzHUXdRHNeDRekP2VNzdYsbT28XHPGG7RBoq?=
 =?us-ascii?Q?zJcyl7vJ2fqicKioi32Iu+cN04PSqtsvqtUOMtkANgOFAJT9zE3FDqel97db?=
 =?us-ascii?Q?pWQvursUqHcZpL4zlFm/2I9q1qvG7ypOSbwEy7oBnd3BR50hXqB/fECGnPWB?=
 =?us-ascii?Q?zjM+Gdc23naSlwna/v7TsXQASxqb0U1m5uNTyJtQK72hMf+DL5M2i7nzIbj1?=
 =?us-ascii?Q?0R79d3Geomdnd9yeYFdEoSMMuQQH8D79XfOCVaWM+yKyJf0JwiQD62r1AHXr?=
 =?us-ascii?Q?ehgVkyt8iRFWQlG2hRIKLI0XI0y3cpzzz6IE5N2iL6y8TLnv/npRdvnPTym2?=
 =?us-ascii?Q?YPFi9g9tY2gYMM+S2rxGRE+ZJVz/F2IFpnJE94w03ZP/LGEePEXMSKlRxMeb?=
 =?us-ascii?Q?SmhDTU9EovnRQZ3z1oo4hPgTzqrymoc53D3uomnrZYgPfGeIW7+RHzPEh7V6?=
 =?us-ascii?Q?MSpUSAKOttcVbVXYzapeJwFhi60WJk2cDl8aC3/EzZHk1yqVPjJ5NS4cU09l?=
 =?us-ascii?Q?CNm3RGEHo2I6IyrTEz2IHoH9aGjYW++9aV6MTafTjt9W8Y71+FPf8dBf2fUD?=
 =?us-ascii?Q?Eq20y/MZA0oQlSSm9+rD1nAoM78kgRXLvtQvkI32XxlDA9XqhaORTN3DkCeE?=
 =?us-ascii?Q?wpAy0t93GNdwQ+2cgK6zyOQ/Imdnr+h55rTfQtqr3DeApP9ky02o5EhJbeK3?=
 =?us-ascii?Q?qjZVjQENLwVq08uTj/zugvtiMhe1omPdDhFbexpG4oGy+g0v+jnC+rHqvxbb?=
 =?us-ascii?Q?25pa8jOTK7HCLkdwDSP8mTWRIbvxX6onGDyOIdzRcvVwq8iILw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oclv+Yt3VRi0oDfQoWs4JFvUb3lj/LwFasV2/XZlo0ejWuB0uMctV9QHmPU0?=
 =?us-ascii?Q?oNWTOThl5jWz1cqo+hJnop93bZkBRSQnwuwwtTGlifoaJNIbeeODf3qjSs/F?=
 =?us-ascii?Q?UjFrdWooxVPO7jxBvIzPlUvuAKoBoNK78HHwJJYKlFztaI3PSyBuosHPi+O2?=
 =?us-ascii?Q?Ldw32okVLOI/cECzU4rtKXvy8u8IXEJDrR8x9KzbKNEdQizWtQEnZhnF2DtC?=
 =?us-ascii?Q?tfTsTJwZYsIWcgAAikMdvL0f6EnyAd/D7CU/uKCSw9SUD/rof8jTHU1UODvb?=
 =?us-ascii?Q?tqpbDbi+RlqAyHkA97RVjIzNvqpHpMGoTgDN5aZUiuVZmAEO8QyYPaCkJTtK?=
 =?us-ascii?Q?tuUxWhpxU4jRX4mKhh8SOmeCNB+tPL6QyGYyteWlzZ75QrLZZvjRJxJcNZqF?=
 =?us-ascii?Q?7r8fjZxnkQBODYHrKJLsiC5j3hSpMcUXFnZNdYIVTLS/c/K3aBI9HxnzddGh?=
 =?us-ascii?Q?4RAXmZmG+FZyttMO3cwAHupTPkiZ7AFt4kNzRl80occQO5SwvyUn4fbKG0ri?=
 =?us-ascii?Q?8T6PSuG4qspw2L5DO5r3a/PawJsL48hGBvyugnPHKK4bi3xYhUVSGss7JO/8?=
 =?us-ascii?Q?DO2FOsyjIP/g44ZAr2ez7NUfBZQpYhKrAc+tAL6KoIoRnI34f1EAAl3rvfVl?=
 =?us-ascii?Q?SlSXsYLP9/6nvawioQtxI9sWBIsapAY5K7QZTNhor2DinDWwSmcRAxNnEVgW?=
 =?us-ascii?Q?/QLGIZIvXuEJeeI2o5MGg3lQGs06Igo2kom9Yf/P+e/uM/dzlOx7RgOCYXWJ?=
 =?us-ascii?Q?2d0AP4zeP/V3pQFAuoOnXdPIzKQ0JW0No7hOKnePoHqj8Wvb5Svv1EGqX8RF?=
 =?us-ascii?Q?Kg5b/ybF/NG3/FLOh5LzIIyMtpx/9+99pYqL0/x/sGAV1OCsL9W68lmNav8c?=
 =?us-ascii?Q?eL+4xmGpu0jP4qrtz16P/ne1V+nh6X/pyAGO/H1YFuDkUSN30683dhx4fhm6?=
 =?us-ascii?Q?LOmeK3oS0HYN9cKU2juyEUvh0kD2xxeXzJqowpx7KaRdNvzCI1z2bsnkIvLO?=
 =?us-ascii?Q?V5fjrGQnSCb+vcsJjCEy5ZpV/xBUEhZBPHbZ+UDB+FTmcYOBZfWOF/Rdf9CM?=
 =?us-ascii?Q?1xz6opILyqrzpyxmWymAEJ6uteEhKcDTcNOL0zJcZ3JtyPl00Gf7RmGtBXr1?=
 =?us-ascii?Q?ALvSvkxtlws9sOzqcsHhqae0g4eHQr6wdUmpGrZjrO/5cu4Q0QUyRHORl0DL?=
 =?us-ascii?Q?Zx4zwyfG1yk2dvE7o0hicoeRyPBdKljFnvDGkqLLCGtGMXO/Y1XKCUW4abtf?=
 =?us-ascii?Q?ga4jKL3xJGe02Aga60pvQIMkDjLY9GTokQSSDXYYRz25r6fjpjJfgUqCIGWH?=
 =?us-ascii?Q?3AYWFRhKnvDEkS2QXpTZ9xapu8QtjMZvPQAJFgsnTyuiOLJEo7Zd5FW31KQg?=
 =?us-ascii?Q?nN/37AHsVojfmOD8lOiSVFlnwTlB2Wcduq2capNLUxuHjOPIQb/kYLcoAWZ4?=
 =?us-ascii?Q?/R199OR8P9bHSm/OegBH0P+/zvEimtPOYOvA/9J2aJPpwltRH3PH3JpTGQ9n?=
 =?us-ascii?Q?HvGaDZfA59NaFwJ9LFwHUP66Cj3+RWGB+Eigi9EUnrZFweoEB9WycAZUD40j?=
 =?us-ascii?Q?lPbgihahHhWxqqylSoL5dRI62T0JqjM+DLCgk47a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c27358c-6da8-4802-0603-08dcc104e729
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:18.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22SN0fKTiTGCZYDIt8Epv+r7tL+MQ7tN4jr4OTEdrcIgZ18c+qrP0PsYOipa82LtQIsokTI61G0SCl71w0gfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

Update the QoS property to allow for write, so that fields such as
BCode can be updated.
---
 doc/org.bluez.MediaTransport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index b53c0cd26..4d998b2a8 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -149,8 +149,8 @@ array{object} Links [readonly, optional, ISO only, experimental]
 
 	Linked transport objects which the transport is associated with.
 
-dict QoS [readonly, optional, ISO only, experimental]
-`````````````````````````````````````````````````````
+dict QoS [readwrite, optional, ISO only, experimental]
+``````````````````````````````````````````````````````
 
 	Only present when QoS is configured.
 
-- 
2.40.1

