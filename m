Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577219995E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271265; cv=fail; b=UPVEdODeOdqO3EChGN/zMutXjVVlOYzLBu/CexXck5SRadpA1HrKLVp1tvYnIWtOcSqkeXeJRbP03fT552U0uZ1B8hgxK0SP3MheqcKpBlCf2cwMA5lbuTJVWL8qFfxe/ykzX9XmQl5+h8EbwI/BNVXVnaJQlpaCUoXVnqqKuN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271265; c=relaxed/simple;
	bh=kyi/OKzYNg+MHLZYwPTZhYGR48b6aw1qWf7ACN8/Pi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxHVuLtehraE9daXw9zAl83a2xGJs7xEAnPUAwP4d7GSu8FNrp7POYdctEmORx7LBfwJ3m9zNg8cA9uTuavSncu3MY63vPaGr2fSI81l2FxS5sWFlwRfQt/bPmN7EwAD+jaVvmKk0ifJfSiqYl/OI+R6gDKjnIzhyo1QIFrRJoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=IAKdnsX5; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="IAKdnsX5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkkA926tqZm7lQWkX24nkMU9OKbYBT9mEjQ13Kr+/dTprx7CeGgzcwiSuzb5rliTPvP/mgffauvn97Ltcea44Pz7DUfZ+lM7DfkQTfm7vT0pEVTvNZXVt34o2WjJSvSH1rSkR7t+WhnWqEyCj67W2fikSZL2Ly101sR7spMq9ePwwMpTpGS2jYdyVr5hofxLHFDXzpNkSaFanCiZ7nuedR1SwK+vOd2rk1kEMQ0SVmohFkhq13O16vn0QXivsgPKXcztF8F0cHaVX/oGSo7KpOY26nuXHpBFhoad6O7F387ApCtFu2WvnxBWWiFP0MAi/kA/fHjfVpmtmXEhP82QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1vtIAvrYUbObgC9OY0ggfMz3xa01T6WyMYZHun7qUY=;
 b=Nvq18vMj+U+4DS1WwOqR5v0TPiPJA2NI134XJYMlGTnuKFCUHVb6Hc/brMCCq1ipysne63zCfJKRDZgaEmgaB8yg1RiXG6+B8GFGdJ5OcljyPp8XbexLzBZqI7Ltbk62LhwO22mSDGmrW26Rxpbi6pQDcvBKLAYTesXuoXH3h4rvdDnfrcy+nZNlphhpbqzcEkwNbUUwbP3oBqrpxJOykFuIlSoWoWanUKnWTNw5DDHRIb8Bki4hYei6MWzT9s6/k8xEysKMTK5gPuUjfXKaOPJ0pKuWG3y0PAERiGoPxvWMwhxfwrg9VU89yFQ9D9aBigqXtSvI8szOW3QOpfDkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1vtIAvrYUbObgC9OY0ggfMz3xa01T6WyMYZHun7qUY=;
 b=IAKdnsX5u83SnxeWb/IP0JwIZ8g7WzHk6OioAp5RSYTB2bHOWhk75N6vTorOw0mU0Otd4QsnA5OsLY4JYZHHLL1Ngg8E9k5vIvytDwqv96UPZYJQ/5nkhW+fbtV69XXZMNSLb3sGD7BqoARP+VMDDDEyRIMNXQn19/FzztvUMyQ=
Received: from DU7P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::30)
 by DU0PR03MB9684.eurprd03.prod.outlook.com (2603:10a6:10:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Fri, 11 Jul
 2025 22:00:58 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::b1) by DU7P191CA0020.outlook.office365.com
 (2603:10a6:10:54e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:00:57 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:00:57 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 1/9] mesh: net-keys: more uses of BEACON_LEN_SNB and BEACON_LEN_MPB
Date: Fri, 11 Jul 2025 23:57:13 +0200
Message-ID: <20250711220035.10065-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
References: <20250711220035.10065-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DU0PR03MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dac6a7b-7df0-4381-519e-08ddc0c66a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x2Us2DdEw2PH7qsw0WjaaORd9BPxI4+hHGYh30ib6KsbUnv+FrxQraaj1oHc?=
 =?us-ascii?Q?MoRXGmXbP7cYG9+5f1AWop2VQ75gc3zitROnGbE7Wg6QeKuV4R99+pSEtq4f?=
 =?us-ascii?Q?kQqpxry85Rxxe0R1jXu8IIdScIxRxPTU+cAHPD7sRZ6s4unbRc+GoZXsTH1f?=
 =?us-ascii?Q?dX8BdQyP1LwpqqJnj3oQDrSiIP8Nmvq0JD76dCyd1pFG4F0VQGU8XlbVajEk?=
 =?us-ascii?Q?iYr+HotiLW1YWgJRHiNzVNDDD5ZfrDM13l6C0QSntnpZ6RuaZCIhPK9kkyno?=
 =?us-ascii?Q?BNa8qb4JI9nToHzqda6Bh8SevFUiO3Gqp1NM6X99AmHjTYKaGMoOt8V8gT7j?=
 =?us-ascii?Q?Giv9eJTKgDVhnjbjSsuMrCgL/sD3zDIFRP7PNomhiEfccEvPpzEjUyfpVD/t?=
 =?us-ascii?Q?sgWPr9AJYdL2E0gAf7GYE0WRUYPrRFIihVXVRdzmYRM2AQm3xUNrrFiSOCTR?=
 =?us-ascii?Q?RyROpkZ5Y9PhQGIboGz8sMO4bwKJ3DFLnDC5FwMi7rFz020wwNY2zagMqSWF?=
 =?us-ascii?Q?NKZqZWCIOVoYvzt04m3hKhlcy3Kw7m9Cnzt8ze2IySdGzYyEGzTIqPpRBO8w?=
 =?us-ascii?Q?6DSY8wD/seHnOR8Xo8p8ABi9FhJRPr/MtRNoElaV5YBUGkX1Ilez8gpUeo3r?=
 =?us-ascii?Q?2zHshI47FVjMqqsN7kqOGXKkWmuIUp9NOqjo2twsBrB6VRasQQYvFVoijpCq?=
 =?us-ascii?Q?JGglXMAzMnlk1fwmNIwwStwa2HJOTcx+roG9GVZ635BSd/FvpzAtia+ahPki?=
 =?us-ascii?Q?SUpOPh/YqlJmuxllQ++DVV6X2uHJkJ6P3G10DUpgbBqvQJ8ZGw3N5sJ0zOSX?=
 =?us-ascii?Q?QeZBXkHLe06GUfLFMt8hfmxhnL24fUdHY+hKdR3BXijkGkr1ax0T+W7B7qBY?=
 =?us-ascii?Q?j8ka2UiCxfWhsjQSsQlb898qJZdk4fZLXMiiWR3svQWpGPX74lQnYiWJJ+Vg?=
 =?us-ascii?Q?YuoMjAMfz8T10QRLaqc9FrbSGPykTw6OOkhWJp7MP6EFi5aYPBqlyfkDzESM?=
 =?us-ascii?Q?psLnI1P4+bGYZt8Y4qKs6hpxzcx5I1/Zhvz0aJGt5E4XKyzPoyTrlmTKykaD?=
 =?us-ascii?Q?lNwu52/Zg6to3C9RX+LB7DYvDjzH4sSMTV7+y4UxxvO+DhZQnxAKNx+aVsEB?=
 =?us-ascii?Q?007QujyjRyXPQ965QbeuGJ0Xz6E6tv4JpyFVtOMyjRtJKQV7zrn/RQ2+bk48?=
 =?us-ascii?Q?shuAJCuJhUDBGukTpMDTuJ2MXyc7X4mjSTpsixiM911rBqgxSHo8hUHWntwf?=
 =?us-ascii?Q?/PGjQviV12VHXDosETC5h898NVe0nbkDNX4pFO86/6tuNDokcoGa2Pb9h5rm?=
 =?us-ascii?Q?mG1SPXuGpdEBU+IprxnH1fyiDeAHKe4Yv8KX3VNfYr5t26L+nuZcW7LFkPfB?=
 =?us-ascii?Q?6K75mXjfalvB9fhaV2lj6DWNyVnse/5hLnQF7s0IbESVkoaMsMAMIlVExZw/?=
 =?us-ascii?Q?uLeueOnVTwlWa3/ZHFj4n4bg/rgnJbcAK3r5Y2yh9rbtUT738GE+6yf8oc/V?=
 =?us-ascii?Q?p6Q4eOEd1UELp+OCUJxwzdkkQcyg7YAIE77x?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:00:57.7358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dac6a7b-7df0-4381-519e-08ddc0c66a6d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9684

---
 mesh/net-keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index a10f93ccb03e..22ab5b626a84 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -442,10 +442,10 @@ static bool match_beacon(const void *a, const void *b)
 	const uint8_t *incoming = b;
 
 	if (incoming[0] == BEACON_TYPE_MPB)
-		return !memcmp(cached->data, incoming, 27);
+		return !memcmp(cached->data, incoming, BEACON_LEN_MPB - 1);
 
 	if (incoming[0] == BEACON_TYPE_SNB)
-		return !memcmp(cached->data, incoming, 22);
+		return !memcmp(cached->data, incoming, BEACON_LEN_SNB - 1);
 
 	return false;
 }
-- 
2.43.0

