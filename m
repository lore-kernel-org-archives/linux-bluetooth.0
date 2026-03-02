Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5D2D97BB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459158; cv=fail; b=kh10mk4l8b3AUXKAjQYuYtO+ffL6qOkPp/qtcsW2kgClwp7RTtyvlI+tBRXZcF/XLFTe9lBqX3kmyLnh4FamStT7qi5vr5bbjEl5OBNgxtluZZ7zrZbaS+8dCF72+2i9XzyxHBjTLEzdHyVX9tmnWLym/S1dISBVtgHQXGAwYv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459158; c=relaxed/simple;
	bh=pFjzLPrledJUcWlic5mmYu5/cHIaUnmt1o2ckR+n2j8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INEt8oRd+d12lRh2gDl/RrFAr3H1hOD//xrnRJPO+8qqlCO0+h6gx14Z28kvFuCZOI63wP9X5NPkf+dYnuQKyezj7BiKcS7TenEpDriX33jsLndcO7KSH49xxzcRfdQnwNlF99LNyBYapvHh+s78cYLz7xOXCmrnpnmnt5JBiNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Xb0xMK+Z; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Xb0xMK+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNbRoY+b3b9/+ZZ5jKPvMN9pQ4i/IMajiLjx1MXEX+ixgu8t9uncjWXLqJbgqPLosPzwt2zXnkat+OwVZlnod5BtE5tP2517ZGVOJ46+Pb7palE5C+tE6isD7z8ckGjAxgkYjLb7ogl8AmE0v+uFFb9Clm8OSqvyExZUjF2J+LFmscOZPes8Svi+G6/YnR2m/qzPsOXb36AqBqjtcR9LL5gHVeT2nbuyBDncKCFmbYyj9Fn9Z1SSNBxFMnkpuWChJ/HRDyRAU/4l7jeg66n5IHQIIsKgby5TnpyT7ERnNOdR3zZ6XMsL9KDNKy75sz/4pCrotmO0s519hCOqtzxL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+muAHnBB86XM/8EKG4z0ynD79u4XVp8e2XmFrhUDo8=;
 b=p7Lg1rP6VPDTK0lk7hG6BJdPLdHMbpNotf+LX43Dqx52uAH9lGWMQYcZkcGgZITXXYgfMOt49pf/ke5XKbieJ81oWX8AVWWt4VlWfSEookqdOo2TJV2me1bLJZDEKeYWQNsUoalJ+7sqywMLSLeRudOxmkrpXDBe4Gj6HuqgfoGixI6NHxY/nPHroh3JJ5qJENoFWJkzyU3PcfYzRoUZqJqQUWrOYWE8DSkfscA5glA3vqbxsXaYafFxjEzOY1wKSMCvnys2lD4/3EngjPWTN5539nArh0D8DWGeVTkHrvtGm5dtwM78E6PTo7pGsixnWzqxRSMpBCnU6llMluiiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+muAHnBB86XM/8EKG4z0ynD79u4XVp8e2XmFrhUDo8=;
 b=Xb0xMK+ZKGwsSFgX5u04eoO5mllHLL1K8XF/qQFOPLo04wlEiYJnUH/fzmYNUZrGEmFAy4kEOEsu/x/L3ZxMBsPWsKaeuO9ehuJx6WwNhCErjtykUdQuDMVzMalTdNNTlxLvY9dgqQhwaOzOgZy7d7k7UYoob9XReeYT9zUtPPE=
Received: from DU7P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::14)
 by AM9PR03MB7058.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Mon, 2 Mar
 2026 13:45:53 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::f7) by DU7P190CA0028.outlook.office365.com
 (2603:10a6:10:550::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 13:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:45:51 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:45:50 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 00/15] doc/qualification: Updates for TCRL pkg101
Date: Mon, 2 Mar 2026 14:30:28 +0100
Message-ID: <20260302134540.25540-1-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|AM9PR03MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a37fdf-6b8b-469b-8ed0-08de78620496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	cLI+1ENZ7ami0O2pIE/K2AZTKFoXecYP/jTYhpdVBkQSSf2a63SXqAgdwnd48VI2UYka2JRoUqD6LPnm4XPkFPQ9x5Q8DIf6mAXSfZDi+OedBV4f4COl1hwciSBkWNDDDcl2mFgpvjHgmm6GiG2gcdeM9zOeDTlyBhDXdpQAwXGKQxFbKcHTRITnzPjGM1eFUpBv2bTeKHX9Y1HIfVqhY0SB2q65AWLA+r11jnKMo3wHp2vNoorSM+7k50HiyTO7qHtTUZFYn45tNt+ButHq2LI5IeCfF1l5Wt8ungI2u1Xv5NRon7u8m8BZv7AuF7WkbfAYLyC+yWTt7xs6b2tx4PljQqb80zQXuOKUSmeu+TXF/3rGTEdYNTHOIpAnBUg8LhNVn09JiAhMgCVVGHZD7j3YZWMSSscuK9bD6Xb55IosC9pN6ZG30LBbTIr1axflh85k8Zd6SzWwq+gYvCPIP+Y4lzpNobJy3vNAJXNLiVGI14SbHlrpyLcJfE083pV5Y3Yd+BkNNK73W60H22PzzBHoRzkVtQ2L38JhsYwoTtmq85qYge1r6VMFXZSCk3pJ7kMKUg+dBLP5Vz3fIQov/XEvMvdnpz4Gqbv2PXmYFF97jP5+2vSmzonQ3zQIh6f6dRrAVqJA1nYuaSJ5R6Fvx/s8t5Bg8a91qUn4F58oE3oproqOxaM+SDw7IYG6J1CkEFLraQJJN9VLenuCQt+TbhJ7xJBgVk97hoDA3IUpKfc0U8vrGtgG3wtE1Pitu7M2DEDEzFRBoqjgQy90FHctqVN0JhLeNU6LawHTD2AwfQ0hBiYiVh0nFGbO9vtwD517fLudZ+t6xgJGH1hQvVKJFg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CZiW1mRtFAa3zDD31AyE7+Rs8ljIQckox3OL+HtvnOc11veYRB1LIngVlWXi49KPDhbswBCrtWyEOj1+ypnB0FeD/yX9Ojs251WfQ8m9MOOUxgqNxdkdNyBEKPcRbbx0jSYAGDffwfPU3C0odTW4lchp9Au7Zvt5zlj7c4Sd607+VHUP2f81HfNC2rWuP8QGvfFQu7Malg9pSCBvjanuISQTz6yTLYrVGfUtTJQjPMDceHg458rQDpdlUbmeReguDdcvCtFryTiyuF1USZln+eNaU6H814Oh7ltZJdk+duJQkV5sggaYz5NW67dBugwL7dVVpvvs5mrZFe04aTIVoWR/ExMiORQxcrc7pVKrRBF5KI6S/KdUAxC5RsTZe1nCQ0oAT0yn/VpaDP0+GCZKmB/lpGZ202+99pkTg+PnXJsXl2eI1nIuLZAbrCQJgoV7
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:45:51.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a37fdf-6b8b-469b-8ed0-08de78620496
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7058

I am working on a qualification of Linux/BlueZ for "LE / peripheral only".
Due to updates on the SIG's ICS/TCMT/TCRL, some ICS options and tests
have been added.

As I am not able to perform all the tests as Frederic did, these patches
bring the documentation into a slightly inconsistent state (as I tested
with a newer TCRL/ICS/PTS version, but only updated the test docs for
the testcases I actually ran). 

v2:
- Change description how to check for the "Connection Parameters Request
  procedure" LE feature
- Apply documentation fixes suggested by Frederic

