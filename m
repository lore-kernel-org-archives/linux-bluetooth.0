Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E63ED133
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208348; cv=fail; b=hnHWL/fWBGuyHgwx+BsCUZNOUx0rEsHt1VFqQ6cQJ84EX9GRde09790yzhigjKe40Mk1jmwXcgjfEy7ZJHoj5P7YbhCshBbFITiDDp4wx8xj7K7GrdoogNTZI0coBVAF2rqc0He4eTaiqBkS4/NsGVxu5La3imb+MfcL95yoepo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208348; c=relaxed/simple;
	bh=zKNtk5iDbPhIjOZfiVfQNz4UMqaFLRKkfA6epRmlQhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSS5va1ixPrqI9GC/Jeqs4RCny283DBMyGCU46V/iQNC5fcD/BBHaK9q1kxSp/gQs9dttctotdcA5Mtiu2D4n/hUbm08MdA6YMj7L9ACzaQGzfIM8uWbxqWSq9VFIvH+i3h4LV0aX9FMa+xKyi31E7vm6F9ObO6srLSHnknjzVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=C/amyqNT; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="C/amyqNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S32lQGVlT/Z5YmT78GIsyZtpv+V6k7iS0N0hrJnKCD7l/Y2UzCKSUFlOXHAFx3sL2ImEO253V46hqXZTHoin5aiUw87O2wp0LIRvajr+PhApq0Sk1SIMpsgTHxoE1p1tP7Pbc7EowKXEXcNgmgCCV6IvXRxr0NcJ6bYf+3YEO4gooJWg7x5EyrmoYT2dDiRkvIJQ+8aFFJ4NW6iyv6c5ooc3ZUAz2F5E4ehbCOIOK6BVdfr6wOq3PtJAUre7ieaZI3wCNiB2auBfsi5Q16h8upOtij7m3DIUOd9UL9/AxsIP7wK6eV9bM+vOy+tnfskj4Zv5TjnsXKhtIBCKpJBEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI5qkmz7D72q8ULNjXueOiMASWPPpkCNZW/LOfr+QYE=;
 b=i17k/DcXVR1myQTbV+Q3tNWGajlhum8O65jBqCylz/ed7C6Mo2J8qfUWDtMnwN4IpnoWluoM6GoAFt4f+pP2hAIJ6RMyUK02f53/jkNkxDcpKNoruNB601LWgGGPRPBz4KNHuymX4qODKjS307XQwrPTr4EThdRcowlOsBeW5QcVgqQmz2gvXo45RLbv69VmRIOh/Aw8+zj0Kbdk+m17wCq5BGNSQFnoS4ko7vKo6ro4Hz4UhqqdXe2EquDCO98NN5kqYNMuwShFBmHj/426GYgGyvELeCizhTguoZ41jMbMrg/Ls3vcZg5TVWBJ5aSxUnUV3+W2HXMNRqHVzuWzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI5qkmz7D72q8ULNjXueOiMASWPPpkCNZW/LOfr+QYE=;
 b=C/amyqNTcea4W/DKINtlXFNa22h/BleC4xmFHmbpndeO/a6c0Bp03BWq9nqqeHjMnihvRVHJhTEer7YozMZYGBNbSVUZ36RYy+4AifsBCEuD2bQWJiJPxDVmLYK31LGYO6jLtSdbQNcCA8s2LoAPlnA0vd8exCVA09eq8Anj+CQ=
Received: from AS4PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::8)
 by AS8PR03MB6887.eurprd03.prod.outlook.com (2603:10a6:20b:29f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 16:05:43 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::23) by AS4PR09CA0016.outlook.office365.com
 (2603:10a6:20b:5d4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:05:43 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:05:42 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 14/15] doc/qualification: l2cap-pts: remove redundant test documentation
Date: Fri, 27 Feb 2026 16:54:00 +0100
Message-ID: <20260227160022.21462-15-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|AS8PR03MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: e03936ef-0859-449a-1f2d-08de761a0f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	GI8LjT2CxWV//Tbzr0xa5U4S+rWlTnm5SsCBPaADXd040roccpCFz4lQP1SqeW1/GkK2kNqzQyw9r8cwQqMEo2shmOj7peiuh+sTYhN0pnFBuXZync2xPzxI3i+9+S0+VySqW5N1+v8NjfQHsovJCtv4WuKTC/GQNRTlFrsuhzLdpyR/zWQ3H09SnMaTOC1u0ThfRTBfCiRoyaTAHbr987qWw9MDiX7FYwlzCO61w97w0Ikf5kmxXvQb2z/3s58LarRGMSwZAgEQIu1JKb9DU3S6TbOYIYGHvxS4Y78/SXWqWT+VYI6eGpKx5LAkKsLWtyLmDrtfKyuGfa1KCkjMKhqTaWzR4poNUxdPNOpecvFFFQLjP/u4LDaMMkOa93QkntlIeAyijP2yqQ3I4sVzSGyhUds/TzfzmnR9woL9rkx7FMMXqABo4wP8NNAYUowXu3sAhxeCXf+CthXU6PNDOtwZfkUQ/4oYcQu733gmhFEuLkB6mcFZoxQA6MBSf+6YkERc84VUI5Rc8WaiNzi+/lRzbuPjsyX3mOenO+MvRDG/Y/LcWEVbFdpjbGfVVRNng4TNvTSBjgXqb/Bro5VRHiaKyUWnziy631zkSpcJh2lt4kp6RSpTaglI/TWX7Q3Vw9a68Pr97Ksw2dE6lI57FwgOi/NKgf9w1FL3/oFJayhr7HVqyuKPzPZq1foCnsqdx3Q4yJhXtLJou4bTLblOwBOXVikZ9Bsgzju1r28vOdYipXEVtX3N0bNSd9C2Pf6/creRbK5r32/quWugyVCNvmVx5PHn/sZ6jqStYCG5IOI1OJrTnA9UKKUy/M/LmQH1ukZTgHwmA2FAaedZNFXH1Q==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8sEUGL5smxvyqNzGhgouVqQEW7DSdiz1bcLaJuZyERzuHGPDZTT+92E/mtOHPs7VU85v08pHyCuOmRW+30QWBMyjAj3Dckk8SWoAIFnQ74JR2kirszlxqulyxxcmbkpJa1enCS0uVCtZexqDhJ1OlD5Q7OIRMH9UEIr2vc9dN13i/bpihPw1ZbjStpvggIupUbGi9dk3d9mCyPY+8Xf6u2lf42K2bINGKc8tSp4XFRq2bo5zughUFmEuhxeWLLa+DnI3+kdUmPKFOwsT3BstwsJfGp++47xxae/X0pslXuntNxWQqIHI2q2foOQvMcIB3mLaCg4QjMPv0d/YxYY2S+Y+VYpiAFQB+FzlYXeOAY3tfwpkbFASH5kzM4d1U7Zj38KcTF4TQ/4bJ0HSLQp7yGMqmdYC/DBWm0NkPhH+eWFCzgdNKfkrfIf69+SrOzBy
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:05:43.3500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03936ef-0859-449a-1f2d-08de761a0f78
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6887

L2CAP/LE/REJ/BI-01-C is documented twice
---
 doc/qualification/l2cap-pts.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
index 931df7875189..93adffba81f2 100644
--- a/doc/qualification/l2cap-pts.rst
+++ b/doc/qualification/l2cap-pts.rst
@@ -435,9 +435,3 @@ for which we know the test passed.
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -r -V le_public -J 4                      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
-| L2CAP/LE/REJ/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Run:                                               |
-|                       |        |        |       |                                                      |
-|                       |        |        |       |   - l2test -d -V le_public -J 4                      |
-+-----------------------+--------+--------+-------+------------------------------------------------------+
-- 
2.51.0

