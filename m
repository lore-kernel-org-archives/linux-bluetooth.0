Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84128428484
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208202; cv=fail; b=UvHl1eEUR4FBYXTMeqmytgmvYSmEz5tgS8H4ihplWGlDuT5M21zEQ5CI9nnC1bqdLMoB/8eTWC9T1uBkgO1npVWgSGGurt8/HoIpbSuzXbHTF+oP0t7bv336izPOJdxLuXEbC5PK3MplpKXxPE6S1Q08MkHghGILS+ySCOfa1d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208202; c=relaxed/simple;
	bh=UQMkR0b0AAoydrSdBUorDNJE68N+Z4JahMOcB5rORzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCKKivNVN2w7UdjELe9fNrIfRgmCQXELFmom8r08Ifq6rSSJm6HpK+kv3mCJFUqIilBat3BwycmllGWOOzi+iIzEg9fdKJqk4Zlr+9vMl5uygNuJkOZLdY4yfM+fqZ2fsRKkbp7cZ+Hvx3BuGDM8KMywGKowQgMZn9ze6Vr99Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=g94lhiL1; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="g94lhiL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH4nKegnQOSgyj1qnVbaJZYdkLCkj22KCu2Hi8ZL1FmyZqApRyNLCZKN9SngtMVxwSeYPxXvDwyIwm92d+mmK4cAmlZeHMNsQx2l7DgrDDpFiNNGn/uGYV/FUhdaGKAAdVlbcxN8Or6DMBwfngJamn6RUxlwAdwGmCpHQdcYlKpYaXzsrpJG7Pwj724NF6+LHi1CwgtHHFsc747mFEy65CQGPRToLmn3bjULDDRa5E9UUnThH+PbhN29IdtUmIkw71CcjwywHqfqTmAGUh/zu8nNrPHL9lkx2z7I+Q83RGqOdg+chylQNzkobzFScN/shVwy3cVsx9E9ZntwLArSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tvUui/lu3klhfdZd/WjeD+F94TeFY/5oa8An4WtRnc=;
 b=Ifw6FB9VbjAe2go/evKBY8yncwtfXdqMxax6AS2KVBUtwIM4H4mpd5mXluJQs6J/KS/Hb0YJb0jG8Uwl0gtU8WNLY4YA37mB60nAlYyuXaCNMvT0PngfL5ppQ3vI5MEtMFDMGAJfz/ttwgmjwwIm31kl2uRan4x66S/tD37Ofy8moNgNUD8MvutvLcL1Egizr5rkRmYAoFGyVPN47f592BXeBFRiyFxUvi+I0MNFW1+dxvV6NB9DFrI8ceFZ98hX08bQ3QerNnaNaOaOAO/uUKkIbtqI52JH7sKjEsNcoAy0ADWagwgoSCy409ySsPzhYn1aw9pn+xMeYPWx4NZRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tvUui/lu3klhfdZd/WjeD+F94TeFY/5oa8An4WtRnc=;
 b=g94lhiL1H3aPXa1khTLPV7n6t/tSPicC+Em/6OsTXHFj/I51j35GnAnwgkUprepcW9u4usAesnSe8Zb709MLV1Yrj8CQ9BfV3HpmRcd4sRp88891Xb9Ppg/NKCx0KNb2rnugxF1fEMh1ToFpFSroy9sAhBZGhMq67iDFS/TkjdU=
Received: from DU6P191CA0059.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::16)
 by DBBPR03MB6857.eurprd03.prod.outlook.com (2603:10a6:10:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:03:16 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::6f) by DU6P191CA0059.outlook.office365.com
 (2603:10a6:10:53e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:03:16 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:03:15 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 07/15] doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C
Date: Fri, 27 Feb 2026 16:53:53 +0100
Message-ID: <20260227160022.21462-8-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DBBPR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e53a2e3-7c2a-4187-78a9-08de7619b7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	/wcIrTZ/BTzJrqdyRMmHFNknQVw2FGOc2WZ0ojur6FK2yHVgf+pGJfFliNEjGo5WvrlfDl/PaPNoCB8L1sejDH8IbAN3QB+uK9/PDPpSoDItnFmGYzH9SpvfYNaVhyj2bU9opfL27zR08s9aDYcupluyfAeXCFePnMbL4rWmE87vrld1x1oIhQzZZxAUhjBKUfN5gHh9lZ8Wf9ndvAMn1eDWMuBkO/R0//aFBnw407KzSRiQFd6ju1pNZPFjm47KlyB6LICZOPdZ2TGnMueJ3Y65JpvmdXCMKSCIvJO8y4ziuJwzFstkmLWHAR4We97ADKSQ43rcVW8iMg+Vkoy67AAp4/YPZ7Trbg/b02oJ9TEdSn/MmsZ0ZX709Td1QnRlL/gOZCNLpFjcdykzpxtbimaX/ZxT2b6M4ibe7Toatvo0vaPg4P1NY8wktBgldX7J8/8OzwO7Ljkq1wZBcPFHAR6iOXEKl9zbJCSO6/lR8s0d3jF7IUomv4qHucL0j2HIHtEfdlVnEKA5nmLZq/zhNMSTvgerYLkQyLfwOmIQv2tUQj+QYXHJSb5+kPj6poHtbdCzA+gyGBIRqFyAhupRS7JitDKI1f4uZUWI0gKvOqx2+EcwcnR3ko0j6MChZ1l8OiqWvOvQdgdwAb8RwKJFzVfRtbp4qOdWMFg0cuCSNLV+m4NfF8IYGuF06UpXebANmmqEDOQIYUvyLzfwleFf7xyFfBCb1IjGgjueBzl5a3CXKLz+zTCA9ASx78shqyYLPwIWlEDcfT6Cl4VKto+EdW4aduAeD7q75UQpICAXTfU0U1GH6d9nRahpucJs2eX0nSh0EdhMGRTXNcRF9Co/2w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ayRC5aVj004lvVHyLGgRynN7dZqDlkDB16RB9x6naYtN43f81yfstQqTQ7Xs2lfBrE8YH7bSS/NXp5wq5p2omVFQh789SNEncy4BpsnLzrXMdXh0Xp5viHgkvhAGcBCe/dnzXrgBHnqRoQO7JkxAvlLAC+IKECW7nT30wK2ccNbhVI6XBwgQHxnh5N28IiQ0GdhvXMzAEaLIkRIEbG0O+XeeWNRNg0F+kFs9DpTnG0V0jiMbo2WQGCbzN2tRowDI07YnC5IPwkwTiF01S3p0XdfLzboBDDOHae+RxCWOWkV5XSmH79pn1bv1XxiZJw2mqGui0ltYuhiXsLT17qFu8jYsA3dn0f5w/QQVS2/u/84nLlGTwhvy9LILpL6NKzMhSOg+nPiFlIdlfMGSLYdrSur29XV4+dPj4GMGNeD2dFedQXxhxaRGNnP8/5LOJapU
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:03:16.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e53a2e3-7c2a-4187-78a9-08de7619b7b8
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6857

---
 doc/qualification/sm-pts.rst | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 0fa37fcb0a7f..983bf8e45ebb 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -630,6 +630,46 @@ for which we know the test passed.
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise off                                          |
 +----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PIS/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
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
+| SM/PER/PIS/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent NoInputNoOutput                                  |
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
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent KeyboardDisplay                                  |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | SM/PER/SIP/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       | - Run:                                                                  |
-- 
2.51.0

