Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514F2749EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202796; cv=fail; b=MO1ga+Na9K+FhpvgkKdVqZnag/FmRQnco6/LLTLTD6hBI0DXg/XGHCM5ZOoxp/o3GT3MalifVCjSxFlQFpOd8QdkXAivHfsFNTF0y81lDh9xSkdD0JiqW+aoJG9TyPK4PdU43UXQ98dGC+8b9cCDz2sUa9YIbQp12UQrbXL+spI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202796; c=relaxed/simple;
	bh=SHJ7oBF3YTrgeaOX4BTGdfzYo7//8DAdZB6Vj0/gDe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuIL6V4tFYak4KtO8R3L5Zutlgb6eYHYvNDIjUXCq438wUH3s7S9mFA5LjO3CtpCd3CYU6DG9PAb8FjfqPGKHO/QLtyKnOJTXXO+jziW5Wpf3ONZplDauM+emsytmljWnycAgxI2S0OaLkyg8J834F6vAGT1wDDlMv/eBoX19A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=hO2vhUSN; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="hO2vhUSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJVE9XYOYf+6DWzWBu6BBiWwRQcIlBzakuaFbv3M/xloK9k/A4xxvW56bdDzek3YHvvUYLCkT9EfPG98716y0/6dEr7QsPrMKkKG4LARy49SpAafJiTN4uQaorGOoVNt9DvP+LKngzU0ByKNChDssob7Y/fYlfphO/RFjBbxqwhxigGfByE2oMlDGatoc8ERcUlpQOi25KvUGQH+Igl5tWS2WoQ7Rno9J7c0eM8F8skVwVE9x8sV+oZppFwGy5GNekPRc0xRmYsfS0TmbvWcoEgLDOqIVOqV1bSBfsvtcmbpKys4FfelQ+pe4naVfyaIJc10cq46TBOL/B4Tui2R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHJ7oBF3YTrgeaOX4BTGdfzYo7//8DAdZB6Vj0/gDe0=;
 b=xrGyESFT8gcwVuO0HUry9gWMTE1DW8qChryg4bDv8jyZ/g6GC/OgzICzIxEFj3b5RgpxqiemJS0jk7Rq9YDYSHBjAyQsQxR7ixoziKfV2DY1h/pHfyb/p5UJZ0Yc5d3kJkztliNOM2ptQrczUHDvjnHmBdDG5NzjsthpldStWD9Wqpn5jUcJaajXrJHOFjfWawn4wX+3Ig5HhCN/5jLcSOHRcWn0AKhPoX2mRBmWT6GHsbzUNdnDmKiEBQqdhhFF21gIkdf6kqB3JlZwFjM6xZHu1S9QGNvCGW6rUZHrmI1HtcOdmkvjwM1wxTSqEvGkR9CVnS5h1lclywzx1eqngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHJ7oBF3YTrgeaOX4BTGdfzYo7//8DAdZB6Vj0/gDe0=;
 b=hO2vhUSNUZiRrmwP4idEdGTtLYIfNlsSO737eRV2iqg7rO1RWUyR0qNDf+TfTunYjIR9GfoSpf8Na16KJ6lVGrqXfB5hgb2JL60kRbe7ez/z2nkqlbOMKNAW7wccHaNX/T3Yl169JabbMCweuWXPdKdIrtxq23B3a0+/vi2aSMQ=
Received: from AS8PR04CA0170.eurprd04.prod.outlook.com (2603:10a6:20b:331::25)
 by DBAPR03MB6359.eurprd03.prod.outlook.com (2603:10a6:10:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 27 Feb
 2026 14:33:07 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:331:cafe::2e) by AS8PR04CA0170.outlook.office365.com
 (2603:10a6:20b:331::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 14:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:33:07 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 15:33:06 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH Bluez v2 0/4] client: align 'io-cap' and 'pair' cmds with the docs
Date: Fri, 27 Feb 2026 15:24:21 +0100
Message-ID: <20260227143242.5204-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|DBAPR03MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: c55c5fe0-4524-4253-0339-08de760d1fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	JUy1o7e6Cd/b6jwgGRfzZgFKkbZIyh06SYKlaySvm4GZ5NJra4Qm16hYAukcYZpfZSQ+xsl6h/Bmev5hcVwS+8ipKhOyP7sae5GTpMJgZlDJqTGHRaUiJi3Ceegkucn9kl/HEvA1LmlRP5cWSDySm2EdFwHptSKAdE3S0bZdxFri8WbQiFqLCnCQQKvfC2b56gzAyCrt1Fg1wKpeapNo4CQ7AVAkCohgrKb4fLZfW+QljZioXTWJRVhZiI+f19z28bo17OHQeALrm8bWGcF3hWpt2l3L2k0PjU5PnmprBoXp05IO+tN5jp12mT5ktzFIIqCUpMvF8OsWLBg3wt+CpNI6R+rgmw5yZrjocPCpWmB5FRk+Xgt2o7CJ8OWZMKtrc3gWLkOIurqn5sLGrr+zDm105OqKunxWyqaIQS1xoZ6awSLhKDJz1XqM22lGfhY6R2bYCQDMQaccfPP7xa0QtOX7+QKbG7zx/9utbqyuwreoMjyvCCe5PJb11j00/GsUsO9ZWJmtWkH0+44jV+qCC4zrKl3mwmKnqaHI7aXTLzzeePZquBwubixf+D8vD3PSrGqWMjlg0p8B9IIm8OhsAaX8RuShe6e37z+wDwzUaQjjfUIa3rkJ1NKw/dE891KG5huB1JNHMe3LAJqybDKdmXNWA4Zk/QmJJ8k7xqpFzqGEh/SZCrasY09BaQoLZp6dHWs/swbEwUnkfzqelMhEkRZg/uspjUYvr4KBHPpBGMkh/ShYKSz18bv//gozgMhNZgL+m+Q6yq5Q4oyMfL0KWBBmhJ9c/fF4jCY1gsuMzI6MPYLPANxG+UhgfAtI0w3fNkT47qWhQbIoFAfSuFFNmg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+M2b0OwUrSMeLOdv03fBG6QqPS8DINZZTy/U/pBrbnGSed98aT3ewhAujppEGLYS4L/jgru+ImTg6+GoAnOyq8G4g9s3WQ6RJHGdlpUy2hcKUsJT4/bd8FL2kGHxgixsyl9a10SH2fe1uSxcNXAXl5uQaqCGY4PAyXrPFv2Nm7Ms8CueD4e7hJu6YW20zJo+9IGz0VFPFSFfiKSLzFPE4liwP0+/uSQQRdT4zXnkduyw3aRTRKrTLCoQhAKxdfE4kB82l2JQlcfTeXPzV1ymDi+Ju3nUa0xQel0cYprOD/SkUPZGnVBI46g/8pL9dpqtc4V5nEQW5EouB/K57vG64+CaAWUEtwk58FVtYv9rs2KFU1eNIfBmGJDHl0GKzGFsd/tiNUwFaOiWeGlIpYnE9SguXQldchJ3vEwYOUS0940VWFmjVlOTdkQ7Y+NUw7wn
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:33:07.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55c5fe0-4524-4253-0339-08de760d1fc5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6359

According to doc/bluetoothctl-mgmt.rst, the 'io-cap' and 'pair' cmds
should have a string type <cap> argument. But in the current
implementation, the parser expects an integer (and doesn't complain if
something else is passed).

v2:
- Split the first patch into two parts
- Use an enum instead of preprocessor defines
- Remove obsolete documentation update for l2test's -O <mtu> option

