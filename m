Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3E326952
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208192; cv=fail; b=Ev3KO3JQ8mdHoXMgpPZd/Uvzwn77OigSwEt6ZfYPXuO/mX1lIgUTOHigUPCT2kcMzsNdxJ0leWjZGm8LZ6xwGd/ADTVqeIjoYBhyNIzeHtg8WfXkXp0M8Wju9ux33/E3BtXK3n7LwbLAmrOx1w+4Su0sGwuUXN8IHUbWPtVWQI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208192; c=relaxed/simple;
	bh=R9fj/18V+QYFC4btnyUuUqVH+siCLv/WovMSQqaJGlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGDKzdX+K3d6dYtw4ldRRlSxv5kJC0kFvXiMKRHAU9zQ7qzIb9fcrd9DswlsBMOJM8lSr98AI2bVkuKymOcUPNHhGDqzNqTeDcP34q2ERJ/xULQqB5R0ltVOBIfKpJ1M5nZruKN0ROEtnCSlPRLyPzv+1U4MsJqAYMHcHiJxssg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UZrOMYVe; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UZrOMYVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDAUs+nL9QzuLkdpAfwJgY+ZamtoAGjUTqcssy3ea5EiNwOqUSVHq5ibyHHT6K/I0r9ccNoAI1Z1bvwaqPbgZdJbi4YL9pckEc2+B+boPeY1Ps/d/8hPAVbD/yTcM4Rs2VxkA4rYEG7JiQ6Ks5surtRAKG6zp+Y84pjGCDuQxyydpCSjtrYTOMrmzdDLQIPxcpRF3g+d5GIkfo3APrvXBntrAytvXUHb9pBH3E2KCw4AuT0FiWKgjLKLwFFFkkvFBZ4BlTtwE3ZbOdV+FgbVGTi5E+A3EDLPduj0W+dcwEKlUYuKjlK5EwQZt4if08mlKkllJLSm2jEOYAwT+2KrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKxEVtnzTvf8O51MAV7jObRwz26WsACRkemaWRQLgK0=;
 b=FOkQt8b7sca7TSIg+wVGbtnQ35t70umVsxn8DcuT10JN+dNriWHJqjEUPgAl40AKxqrCuzLNAaD55JWCBjPbnF0aMYrywmwZeHp+8Y2fqtH7RuW7N33bRzFC8QsugI5aQJcPxBkA5v15BNwUK14soghukmti/A1t0iKaBOxi60KD/DrYekPPkHIyWBoqkm7jxQxSNqlsH46tdWZNr3o1Muh78WOkkLfZ5p655OpmJcC+Etm4+mjnqrbAEbvM3P7X1qfiElCKvYNyaB0+mHjQxliG8fcgLOlxrhS0UR7k3e7se2r2XnNGP/v1muw0L2blv/b1vV9cajA3QOAB+J/hbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKxEVtnzTvf8O51MAV7jObRwz26WsACRkemaWRQLgK0=;
 b=UZrOMYVeRiy++T80gBcFLD/5pAokKK5oe8PeIChrozNq3aK20wY6BcEn2zJvc3kpP9oGqyjJALuFqY/SgnKL8LTACNSzkFjumK+GG7S4P9SZCaHFW1MTu+72pvymYdG2zjw3c6A0AOk/8QeXrnxQ8pQSY2gF5F51pZqs/wbtJ4o=
Received: from DU2PR04CA0208.eurprd04.prod.outlook.com (2603:10a6:10:28d::33)
 by DU0PR03MB9102.eurprd03.prod.outlook.com (2603:10a6:10:465::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 16:03:05 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::c6) by DU2PR04CA0208.outlook.office365.com
 (2603:10a6:10:28d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:03:05 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:03:05 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 06/15] doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test
Date: Fri, 27 Feb 2026 16:53:52 +0100
Message-ID: <20260227160022.21462-7-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|DU0PR03MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 9525a9ec-9f9f-42d0-22b0-08de7619b171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	wyjJTT6mYO6ykTrGlj1HwHDhxjcUf1usYEXAy0SkuSz6CUSngUpq0lFgs0VRaBlbTOmSZJZ4rW2GmgaiixKsCTZb/1OcxtirYReGI40wPasQuSeuLgxGY2Th04uj88FIgBz4dXg0xmxHKA3oPVAOud8yuV2u9zJShzzUuKKfjRnb1Lj8P2w/LbY7PnZQHn0wgR4N5ftPbP48Pl+3k1sZJc+IbvgsaHcFKm6gv313vGMveAevXlIUAabaaDShbpri5y0qUUsRhRcz7wSZ3n0e8pmhO0JR6e1BP+GI1mCnS1RFIaNJ86Ua+FlRJE+fQjJUZ8ZAfScndhb4w6jvfs236/O2PoCItsK9+EP3HDkWYFFi9EYv2lH0UXTXmbtEVkf4rHRYX1r03jlYhbWlfO8S9CDM7vyG5HPIhT4jPDfUUP+oUbAZ82C6YGSCmXIx+4UBd/RRyFAH5423HmovZLSr8tk20R2cpDHQ+LBsI5T2S33iDCEHG4K7T7T3YxEWQt2KmLDwU0vbRZKSOCxLwhGwRL0Y9wS9sHiRlKG+S0XPoba/fcYPl4oSMnNiLI4SEHZidyraMO1eH0o1+1ua18ctBTl1vxYoeTmf56OJWHPiKWW2bKK9c6YkwtyUIEFjp0dT2aFmDReIu2AcEYMWtjix9QoDxoJnVwL73KFJFzzGrZivJXup0qSunhMjbcqmIdDaLXXQeQzRmQN3SLy01DP3OtyqTbBuxq9X3lx4Kggu91pAfQ3wbeFwqAeNooP1fU+PdTqUrhWaBdbEMR3TI6dN2LoBf8ohuDiDP3TLVCHUplISsuOPpxY7ohgMveou88XmXxr6/6Y7mVZuenSa1d1sTw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EWGBsjr4aUmtW85BlzbZ4eb68t4Aw5J+kocFCONaAAJzfmtD+eXSw7RKMhDI4GnI6QjXfGXcELYA9fn5BxXFboyWzqSAkU+thRuJAk7z683iKr6QALBM4/ogR4Usn3Dv7wCPGdwv1AZoV8sGD1wXxjyCR/bgrkLOs5NwhzrRrS+uIGfXYEGJbP1TLxE6xu9RtapwrOikibjq6tXgabTuW9GiRyCxEwcUTLrwFKy1T3xBib0xPBb0yGtSQ5A2irTTmovHx9cGEhBSKVGyzPp0fzbUGqHVOLwUayxhtzbs5wQRPHqPMEyFpxNgsop2jv8Pdu3TB+H5g/8wA7+JRca+26IYa21mtkDxSpkd97nC916D8Gp7Djj0yKcR/n5UgDg7hoijjMoyQXYeWjWVlaK44muAYRgD3DoXc0EBYwKfiBS+3DbeWrCUrshhxpfYMOBj
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:03:05.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9525a9ec-9f9f-42d0-22b0-08de7619b171
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9102

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.
---
 doc/qualification/sm-pts.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index f961a2613d2b..0fa37fcb0a7f 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -767,10 +767,6 @@ for which we know the test passed.
 |                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise on                                           |
-|                      |          |         |       |                                                                         |
-|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
-|                      |          |         |       |                                                                         |
-|                      |          |         |       |   - sudo btmgmt                                                         |
 |                      |          |         |       +-------------------------------------------------------------------------+
 |                      |          |         |       | Post-condition:                                                         |
 |                      |          |         |       |                                                                         |
-- 
2.51.0

