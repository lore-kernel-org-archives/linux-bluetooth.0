Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26892522A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255659; cv=fail; b=kIHiL4x5w1Zhi66hD2EhrlUecDD8pftdKZdgEFiggwi2kieiznoC2BHEvEIy8n/oCdr+JV7Ebulaprc6duDLrw1Xdk8fClIE/6tUe7bzwjDaN04u5Qkyszgqk5tt0DIHZxtdoQcYWJ3xiquNHkl33nVw4pznJu5qb0p6xMOXhrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255659; c=relaxed/simple;
	bh=YZ3XXovoPJAeWdgZ7FyHtWck0f5Go7tUYuKspQoxz0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFgRAX7Z1eITP86Ow/lW2TKqVStNoSGDQA36vTVL/8Nc2UDg1TsohRUk0+DE91L38fSyhgt/svD0YVmw8RlXrxKfpWv2OMNKYbhXdoK+g/eSkyPqllvDVbSbSeC/ltcgQWNtvwMu9fFemUSTH3JcS5V1JYhIhDeOB0dXRH+q1DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Op1UNPkq; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Op1UNPkq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUiwJ08PX7bh4J8dp+JVBeaDN0ttwAIDsfJ8TxIEYfLhCCx4nd83I77NlmDDPQhuCNwapj50h+wkAHoFt4p5TxzSEPB15USjn1o94P+npYqw1C7KCsv43L3ZZ5iHyXO2GyWE2tZDUI4MS+3T3HsAIsV+az3KGNjiSShRDd4Pm8e5zFxCfjdsgkI5j1qEeegDQdxN0MB/lY5DJHAarvbJ5FROhPVvKFshKkb+mEEGfOberCOSOu75TGVjIDNrpSp5PFCqvXarYA0Adzn9+WfI6f++syANDfcTkduRaoNZV+uG7al8J2Zq4HlnOM+UVh1zXCENZenjLlZ4ewhYx93ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro5fcoa0e5TGLypMFt723pZ9v81ci5WPVlZcOED0WkA=;
 b=jZX7WQ+6uWnKZDj/ZE+FAIiVqKR2FZ3FwYIMe8T4AzYzWLg8DWLZb878bIjR+vv4vGA6u27xU5o+iAgr5+3kjH3TJ2A5VU2Zxjjoy0By/FalZVJqOPLn39J4lI8j5/hvALtV7Mro42Xk7UIuenHQFf4n+d9cKfnV4op7DyX0aGVv0K9M0lldo0r7gqDN9ceWv9sS9Q+/m/Lv/AixOw/08VB1SPFajy7XteIx0rEluaARbepqK+NJbnQ/8jPiKF+bT+ot4S+7b+QvcbKYMwvdTJZbYBXj8jhHh7PlXD63Cml5n5JiAeyQrV1za+oyVwpsLiQVFzM6sxwvfC5d+cE5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro5fcoa0e5TGLypMFt723pZ9v81ci5WPVlZcOED0WkA=;
 b=Op1UNPkq4fY5u+OitqIJmBBgwzoVugRoK6FUn9hizyRbYOxistnDF8qUK62pp3tB6uwmp9vQZZa9LsmwdifMq+2Ll7ngc5nkM/KVeIIF64JKsVHXtJYeLo/a31lHaq0wL0WFxM9RZR7XcTRk5JSOssTZncfVuFcBn/HF3DYkEDs=
Received: from DB8P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::24)
 by DBBPR03MB6762.eurprd03.prod.outlook.com (2603:10a6:10:20b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:40:49 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::83) by DB8P191CA0014.outlook.office365.com
 (2603:10a6:10:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Fri,
 11 Jul 2025 17:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:40:48 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:40:47 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 0/9] mesh: cleanups and a bugfix for relay packets
Date: Fri, 11 Jul 2025 19:39:16 +0200
Message-ID: <20250711173958.25689-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|DBBPR03MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f97979-9ece-47fe-37a0-08ddc0a2129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nkt/aDQM1zoIXyKbFJm6U8lgcWUi8hGFXSDgbDD3Tr99yhMBCazeQRkWmPvD?=
 =?us-ascii?Q?/zcMzYEX6bmSZctN5mns+RPGcN3XEmgWnXsao6bKFk+vg2RWnFTzArYPHvWZ?=
 =?us-ascii?Q?tqRbkKQzRRHxFhgYtVflbPR1RHnSDIf0vnLhK5zgtwLMSMw5WeKl613HcBDy?=
 =?us-ascii?Q?Wbqpx3gxrNEi6ISTAtpQSNwQjqyESOCC6gDBq20upqYK+Fpj32ihtL2i3MX/?=
 =?us-ascii?Q?fAkWGWDpAhnf9+Pkmmws/s5Twa9amJZqx3mCbNCN+q35k7aAbgzq4MqbdvSJ?=
 =?us-ascii?Q?Ixi2MAWAZaC74it6HlcF5Dza29pDiGcNRxJHM1dzWjhsr0zPB4fVs5fmZOIL?=
 =?us-ascii?Q?Os86mM08h7jBpn6/NYxVivrurFRH9kVHw4tGlXPNpQEC77vCUyMquY1yj49A?=
 =?us-ascii?Q?DvYJA7rIxjAadLUrDNbwyT4+0vElJS/gTlTrPI6M5UfftWybQPyy1Vx2aLFB?=
 =?us-ascii?Q?sDDtLo/0shfi64BQWl1pk4AnaAHfHr/KXQ5FRgsgvXWSartHkPWBzhXFLyvO?=
 =?us-ascii?Q?prZ3FFdBsBiCQ2R3/QP4mg384rtHPBUyQhYGq4P5rmUSH4gjU64XcCmMywtM?=
 =?us-ascii?Q?6xudtYgEuk5SzrUbM4J0iCKNPq+H890ZC+56irjJMYaQhlxXkSl2lbBHrNTn?=
 =?us-ascii?Q?aS6YfO7GWezE9+6UZ0exUitGcG9CuNyLNPr42ptg4HZbPQBbvnvwfobnGy0Q?=
 =?us-ascii?Q?SDj1gdHCuTqqSCcZ9+TbfZhle0wTi7Zns3CaSP3YHatrT2vV2IrDnRXvS87s?=
 =?us-ascii?Q?Mzhr6ztFMj8kGu5oSjzuW4VVNOMeXUpUPxsl0hha69KOCoP6AO8BlckWH9nn?=
 =?us-ascii?Q?RHMVWFaXmy55HaMglKb3fywgupBm7i2X90kUPTv6hF6NWOeZpAMCYBANWKdO?=
 =?us-ascii?Q?0gpU6fTMDT/ASlqYOdOClvTTGsUoX0CVZvnYIRJdJLx0mOgDvXQV75qwtsA6?=
 =?us-ascii?Q?E7y9nI3Cu+Xjwl2zvCQe0Xst8rVM+b6q2fcEWtmH0CspT6g2BQ1aUo2jyb2w?=
 =?us-ascii?Q?c5wFK8QU58vm2U/78OvRTTZIoyH/Tv03RQBvIIXipApXlCL1OHqghpCzXapK?=
 =?us-ascii?Q?T85jWyssmV+44Nl5C7OR8Xk0XUgwtj0d+TPbESL9zKI/dJGXZQkPDKjQKozo?=
 =?us-ascii?Q?PfgJRefZ9V225gGy+fJAvCZ6jmP+qsSU6n2TEC3h2HUlhczPPOdqNkS366St?=
 =?us-ascii?Q?DH+nXJcQi6AQq4FK9mCItfY5IQWEazuxGtkw8tFGWSH8YadBdgulnjlaLecF?=
 =?us-ascii?Q?TrjhEZm9Ori5an1dSwn5R88ij4gYScWF+2IrXGwYMJHFCCIS7uqAX2T8T9xR?=
 =?us-ascii?Q?EEWvw1LoRertVd0tHJj1s93E1izJEk+vnM7ft2Ukl8SqGmEWNJn5d7xLq91+?=
 =?us-ascii?Q?hS4FWczCXKcvz15FP2iGAV1g6VqJJuFNxpwOU3gQaAqjYPHwq2RbDowa4tOK?=
 =?us-ascii?Q?HcH1GpKxgRUTEI8c7ZcIJnVPFxtcJ7v7oudwhmpPLVYA/x8TCmpAiBBej/Oh?=
 =?us-ascii?Q?4gTgaIyqFkifwJGcfavr9Gyw+zgkEWyB4qcX?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:40:48.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f97979-9ece-47fe-37a0-08ddc0a2129a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6762

The first 3 patches replace further magic numbers by preprocessor 
defines (no functional changes). Patch 4 tries to improve readabilty,
while 5 and 6 are only cleanups (these patches have already been
submitted in my previous series, but were not merged without any
notice).

Patch 7 and 8 are further simplifications/cleanups, while the last patch
fixes a serious bug which causes corruption in all relayed packet. Maybe
this NEVER worked correctly, although this is a major feature of 
Bluetooth Mesh. At leat this one should get reviewied by a Mesh expert.

