Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2D2C21DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036383; cv=fail; b=X2onspCA/7kChhGKMyAUx+kZ3Kd3wmDIpeVXMzcl5iColXuKWa+H65/9OVSLE2yScKT8riBPPM1c0gMd0HHOpRoKjZ1dymHw6CQHtC9PLNDdWEbzpoy+ydn0QzCI9HP1YPcpJa47ytQxHv5BM4NhsqrHU5koUrXqZjyRNp416xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036383; c=relaxed/simple;
	bh=WLpLjjB1ji9iaskG+rE2OJyuP3+IdhevajXuTtjWWBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCtfm39i96OzTQjKBvew+1ChOAEcUs5FSrgxvsLm1YJyVP8GaXYCJbCwO+v9tMTrW5aY1j9hrIaqg/IYLyAu02DLQtNdYRVuFOA9RgdwlnTvG5MuLob3u892c3W6+UGZxDC5+2+DwfbpPrpOrNwX8MtmhEPoZiWidOzq0SLRxPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=KY0xwcYf; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="KY0xwcYf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH4iyTbBU9KKEdgl/KmE5cnoxycXBt7A0LWDNlHt1NH+Ux1mU9+6iXPrUEmk7OC2XhioJsb+drjb2jdRBjsOVACDEcqXQN++3fuQ2vM9pv78wtjMuMbac+hq2EsgRqBIOqIgDFYtsYPFGcGKJQnM14cSc2evA1S59UO6Njwl9VdJ1vuXbjC5HgJFgb2DSnKXlJUqEAPJ0X4PxfMqp1dzoIIWkSrfLo3kwYmNoUBHcgD2B0UmdAdDx4hVPYe9pIKDFH6Vnt+NyWCFYwd/6ylgIoo6XzNjieJnezr9durpfAYvVICg397pKJlcS/jVBsGzXoc58KuJl+ml6TuJeW0rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+awnCZFCyVbNyGo0o4xLlO6vxlJiuiLdaOUE0B75zIA=;
 b=IIEBKb70rhJI4tBkMiXF5HFf7qo6bLyF6NkmxMnm0xz8aa1wE1E0XFV3DV+rllssyj4IA5/qnCYVmt3wuH5xV3ZuMRqMkYNiOExScD6C0m4kafnKsOcU0JPN4CPihpAYwyjSkTjOhtwGfTSFOeu89pHMBfPBNBmX9nBVAXZQU1t2Zmdmpkhdtjm2jYBEwyF9XFR978rPOVZQRHuIBd5gn+M8WVZV4oOgv4iy/y73x0aU5OWnRzii8TMEwreRO8MhmGZ+FBlcJWLxsofCw8xoci3bRXE7gRrHUMoYsYCPAmIi/clg1RozQDObURUnWBuhjfrGaanRwzq+34safiq5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+awnCZFCyVbNyGo0o4xLlO6vxlJiuiLdaOUE0B75zIA=;
 b=KY0xwcYfa5BYeJuxe/9QFIHfh+wc1m6MXQ0BZ/rajxju2mgIdZqIOM37G42ORSFyaJFurVZNgqAx9b6r27qDUGlAtXt1rf8/Pa4ej3/Tscejiwft7XKqiDPSC7Xyk7ETbF+H0uEj4V7jrN7h0ZNrSYtsG/9N8Y2DRO9ZNwVWbm0=
Received: from DB9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::12) by GV1PR03MB10425.eurprd03.prod.outlook.com
 (2603:10a6:150:167::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:19:33 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::82) by DB9PR01CA0007.outlook.office365.com
 (2603:10a6:10:1d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:19:32 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:19:32 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 09/12] l2test: add comment to -O <omtu> option
Date: Wed, 25 Feb 2026 17:17:12 +0100
Message-ID: <20260225161715.20394-9-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|GV1PR03MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8afe1f-041d-4a37-584d-08de7489a90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	NeIt2r1uaNiDRr+xhudfJ7NvXeilQnYeclNqUobpUR+RAiEhjCZE0n/zeBAL1kEEGza4SO3FrwjN/fIeJn0CywN3F99A/oY1JPijXxLIC/vNgRmI7fRh6KubUZ6qiQhWMsvJlzAiN8K0YUY9oNQUwDYNc66o9Lro0gYvY0m9qCHkdMWsIprrBjvMTmtGIpGu+rtbOIQBua/HSEtgTUuSqL5gOOZVJ0gK4g4tw9EkWaIuTYFv+8kVPgXEjvW8GghPM5/AmXALFg3yltOtnHQPmygKM2IEt64u4FgI5u5fN1L0EnuBO7v0eHUwfB9MjxZUMNjw1bcPh0sTVPRNGSGY2Dcs2MYRTMuPn4Bf7ddrsAewxFKV+h2YQaetmGKGOa1Gl96gigHf3FIm1VtUgHDAPRt5otK9nQX/j++7/2x4j81qPJqvyxsNAm2EHxlEmLreV53p0Nrw3OTul9HR8005+sZfwwpDG2E/sRkyF81FAvWJigu1mdNvd64gLHyJnaAHoqewNa9z6lXsrlWWmdmV0alIPBcaHYb0njxxrxnO75XAky191OkkwlV/YTFktOJV8YpyIt2+EOcmMwhGlk1mXQMCTlHtBq1rv2yS97P70lhMoxGRm6Yw3SfM17TYOut5wQBo2njgTDQTiJJFvyo7+Gas5ldk9ZvPpzLsBSMs1YEF4pI7ZhGWdpIej6N7Q0mX9IO65AGVhzTFo2CIboohp2Pm52s1kJExUF5v+iUqfP8/Z15p38C+Iit6E6kyiB9Dax6lefyiUFhYcKFvvmfw0FB8fEIelWMgksuNMquo6FbDbjLObgktvzo5Gl2AcU/j9F5ES0ujq33d39L4iexP9w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bVrWDE2vEKAKCKhrnFjC9k1+5Gpu78ojrrBO6ti7iXs1RXLRnUeJoYCKNEaldbWMxwvsWzNEOl1RhquVew9MIGJjToE0/L+P+ZFUy1bxKXiRc8YtF25AYtE8nixX27izRFUBtpnyw/CJP2ItIIzYkeU0RzncktZpxOlLXfsT5ZAi745OKf3e5cGg5vRMjqJEusoZsu01EAXJNOfS4D96TEEirM9F9QFN8jgGK4ztJCo66ysMCbFsGAXljvB4WUGLrO/WvhusEsf5F57DSZP9zEAIZTY9FiyjhGKZQuUdB1qJxLVB3LZLxMjSqe9Ydib8M9kPJQIZByyO/AnMIYSA3vZV7Af9gzFy0Tg5/6o8LV1x/8lmxjC48JGsn0BFlFrbcjPWvvQFh/hNRzTEntsEvdb9ohZt6BbbcmESGYlONfKJ6GQgS/d3dc92GfxnB4hd
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:19:32.8032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8afe1f-041d-4a37-584d-08de7489a90d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10425

Clarify that this option has affect for BR/EDR sockets only.
---
 tools/l2test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index e49289a4c774..7bdf58f0e776 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1338,7 +1338,8 @@ static void usage(void)
 
 	printf("Options:\n"
 		"\t[-b bytes] [-i device] [-P psm] [-J cid]\n"
-		"\t[-I imtu] [-O omtu]\n"
+		"\t[-I imtu]\n"
+		"\t[-O omtu] (affects BR/EDR sockets only)\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-W seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
-- 
2.51.0

