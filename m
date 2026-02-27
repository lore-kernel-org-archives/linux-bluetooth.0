Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE60326952
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208220; cv=fail; b=RtCWXhzT2MOFt77EQTjcsU+FGEDDoH+nFbadUYDwI8fG6w2KlyeswwYbGledYfFT9I9RdUwuyc5sqDwNs0MJH4HL+fPk1j+qX5liiL81AOQDSJ3pnoufVFyQxhvF5QrK4qrzMt5Y5ECSuTYilNbK/yt20tjANV+9isWY+ANAPH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208220; c=relaxed/simple;
	bh=l4YQ+zxlvFvTmsnwyusMr4p3hNqEpyeBMtVcUXl/B1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rirBqalDlgGERzEGzOX64i0WZOeHWBcuVDQ9FfRqm/YyN7lYeyfPaAQqbSZuZOzMfZKa1Vd/qS/MuaatcyMcmQc6UIZq8evwjNhCbHmUYenHoAq9w2te+Q9P5bQCm14J192fP5R00xzM/NyXNZ/uCKdkVuoYbP1qhoKQ2Xo7/C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=DuMl+vSJ; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="DuMl+vSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibrdqO1JQjRkhihSR05q8+GO1qNq/mCfqoqjD+ah+UHai//SVv0V1f6l8ZWKRamfGqmyvlH5KLKv7kEelMvJf0YfqPzgxanMr3qE73bfTPLZi7IIpjpJCaIUd+y6mjmd9IYIysyZrwqV+tIVeYqk268ZdIR3QIlWpWD3NcjdvJIXAX8rst2Fl5ky6ihE6ae9HMuyieVQEasp2Qjolk37J8eYL7z9pxgJiaKAdaoqVDn4dJNNonE1ZKrjDFFjWpi8xrS+tJHLNbsZi7EEv4Of/ElqGFxxHAa/h19i0q3+Z7HBdbsnt/qvSU+2I64Owxc5bGU72Rcc8xQ0O+GMPStG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci/9tNzuVMVHhbDHzxNQIGAbVnGO7ZV1POyFBJ5G3J4=;
 b=P+Qz+G4zsfti9qePM/395EnpEs6YXl8aAK7JAH/JJod0gT6onzjak2L5QO8dqolZshQIrura3FvcPDao7qxmJh8rPmfgc834LHaGV0/lMtZcT70ZugVcTpvXYi9zN8ENh3K1CLGXjD5Ft3xww5yFnvQgcicKcrJMk1UkyAf8L0hxpWQeFAqtDNwPpeSOZVVjQRlSQ+s0uz9DShV52SFo8Rt90pRFjAtiFvWDP7Mh7Ph0oj/GmBe0zdZoaRvTUDUKjtlR9c9n7At2LYfLwsm6coNUR6OEKVTtV3GgaDZMjzDsd8UehjyArmYT7sOYJ734J3OC/rSj05oRDNCMhtgA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci/9tNzuVMVHhbDHzxNQIGAbVnGO7ZV1POyFBJ5G3J4=;
 b=DuMl+vSJY42PR1udDpefimrdOlc0u6QQNJ6dq1xhCNv4MuAkJDz+u28HpD1ZCm1EqSq5B/Ze4pB1UuLiPZEq2Y6E4Q8pIwGzuEbjXlXaEbVj+eTjCC2J7MjzIN3JDJ1785IUxC2i32+5iG2gqb6YnjQPYBlARIN9EdUHjBJ18D8=
Received: from DB8PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:110::30)
 by GV1PR03MB10821.eurprd03.prod.outlook.com (2603:10a6:150:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:03:33 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::e7) by DB8PR04CA0020.outlook.office365.com
 (2603:10a6:10:110::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:03:32 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:03:32 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 08/15] doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test
Date: Fri, 27 Feb 2026 16:53:54 +0100
Message-ID: <20260227160022.21462-9-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227160022.21462-1-ceggers@arri.de>
References: <20260227160022.21462-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|GV1PR03MB10821:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6585a6-dc95-4996-5e08-08de7619c1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	zbscNUNPU+FcJXne4t8EUgHHTTNGmI8RqBVhLuFnXTc6Am8wDzketo8yBiUEhhVwZk3POkVCfFph1IMNW9jKRTOQFDhU9k3Pk+XGS5TO9L0kgUhLxna0M3O8EmQDxRKztMGWkUbEqNUhq/LgC0zORzC4GsLDKsR2bsVvIzA33oAQhJxT5rAgkMoCmlrtPB6nvD+khoe0Wrz9zW06f6jivvKST3Wsm2omQLte1E6/pklEPCb1Fpb+SoHPjx+kkhUYl8lRqFHWnH+MkEI89UV68OYfmT1z7EGoDGyjnzQg0Wjvi5/oYkJqJsBPphDUC0aP4rV6E8BsJMCgF0x1jH5Lku2x1A15Wa6EgPTCDmCus1dBJ2vN5OhAFNJdhwvbWeE2dD6Rennx5Nsdh30qV4hNU7Ebnf9HGILwBsncPj3KkyYODczhcBn0LjNZ6osd3t35+q50rXoDBrd8F93+S9R5lwCdjuBdOLrfo13fWQizBrgWF0+FIYt3JcRIw58BvW6CHmRN5t5NzDFh+8P0gu4DDcPTTV7LVtZbk5wNeuIMW647rtjIY37cXBsu7mIZYwonossjKevvtpYDPqIXd8IbgSGieFCZi8EW8JhvlQk/q9rQhLowgKlgcX2cbxnVk0EQtWRDJFxakEYkpB9qCkn/nYcOvgODXUxL5wxPExK3QAKt9gecX5B/5NLdgap3UCDhLSH31AmV9UV7NyqY8cDvRwYedrZnX+G6mVcQbIIZFV4d73d1m1EdV/wfuxGya/vVh9pYDKbFcj025rbbzhNtWkDD7FwCzRo/60mo0FvkdA1bL6sPtpm18GCkFZoPjnepiA7VW1ABxjwXlW3Dg5G14g==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hyFRXp0JgN3Who5qM+1Vx8QQf/vczV2yRe+0d9LwP9Du5wKaKO63Gi9ff3z2jAOaNCRmflEWYOBmUT4HeLCYKwpfFYGldS042lK+hFP9DSsmpIQF2YdeW5/yKvBrzNBBQrgwtnhALXY/92G1XBCJw35BW7pagRdaUUjk4p3ZBaosMPhaZ/x+EeEBWikpmfx+LtVKaFnxOQBk91+gHOW4I/K3OsJ2JGmXT63PVTqUB9uMFzrkBU+F1nHOkI4tsl0xIQft63BSdBTI7yCHRURDNrrFxr0mfBz19gE445J/EWgjCz/s+Fd/OfyWxAVYz9G7OVr9Ezf32hwU/VtCNn43zzn+7eQx3/81xx1DXhuVinASo1BJv1Bu/jpuSPmwAfZfB9tcZSbkrVu7HfsKvR57tAVJCP4Yc6FRcFJm8Bo2xYz1W8wK1VyRvmhYKIsn9had
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:03:32.9926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6585a6-dc95-4996-5e08-08de7619c1c9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10821

---
 doc/qualification/sm-pts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 983bf8e45ebb..38ac2c5babf9 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -630,6 +630,22 @@ for which we know the test passed.
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise off                                          |
 +----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BI-04-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | SM/PER/PIS/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       | - Run:                                                                  |
-- 
2.51.0

