Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684422A813
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011185; cv=fail; b=BT8UWOfZpQ9cMFLZqfUQReu/VoMC86IAtwevzswT/tZHYH8/OA+MnBrkM5+9p6TMFsZxZrO8V39g/FL3rIDd3K02/x4FFe+bbpAGIbFleYOmDS824BIvXkpPJ9TKG5y3jh94LdTZhIJHtMJfoP3GSs2tsTmtsWNDhAXSOJprKrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011185; c=relaxed/simple;
	bh=MDki9oxDyrXE/MgWCqX3GuaVvjMWx9lfwii9eHxiUbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FP0HdwOQ8dNuCmPjMh/qAeJo0eJRf9i+MsEWeNsFXqcIB2ei2BnOeQ86tiRFg8BBIRxDObzo5dWJIZ/zPl+Db7CMmI4aQ4LICBBizb4ypaj1t4QVHk7nl7t9ZwIXn3K42Ll1II1CjkpS0cWX98MxENHYR5BIDnEp+t3f676anDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=uTJeTsWn; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="uTJeTsWn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqXlxtkDu7C/wfu68Crbq49pSWVQ6YzED1IZ4fgO0ApkfQS9LdRe0aUgBKB//o9eIytnU8sJBXUm3iCf/KzNS5mMxjZlMDNbQoA94bs5cRtOCnwh0K1jr7V/miOXBOWV7ebw0PR9pB/Dl05dRXniN5zixrnRklP0v0AQtMSl/56HN+FO//As1b3bbxobol7SBcYJPdpDvYMXzq+BRXfu2XY2u5KOolB30+jmyZLJZzcpTy6mQcQbwrlXCwG6FGVS+zS8yt/cJEJnoPPr1yE3F8+vYW7E8qINb/cCXKGPZFUmboESkcqmonuIXc5hLwKqNjdUzfSS+/5Hu2YGyPkvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/YchOAm+HvBJKBAVueuJBvmn0D/LcCrhzlI3TWYC24=;
 b=GY+x3oRmdlxnD84c3AL8hJvS9wYnC25FiXeLk+IsW62jc76Z9gtDwq8wgrIrJm415THMOYPZUdhH6a1OolJSBkWYAJetltCRaRQqMsMSGJCRiN1RmN5+k8VRjek5sY/XOMoWD+3zhZrz//PjQ2vrhYRyvu3+IerJBzbviFLjrLF/CUmh8m1Gwr6Hz46E9+0FtbeThjRyEd1nD6jeUvQfR41Qq6NF+O7t8kuijSZihVDt7mI5vjuh/AZ/oQogTi6B3OrVF/qWNGp7GTUd7A8w5kajlKciigzEGOaTbIKQWSwscXqT3reMKawiz7q29lx8FowgtuLIbEnKWFc8exc9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/YchOAm+HvBJKBAVueuJBvmn0D/LcCrhzlI3TWYC24=;
 b=uTJeTsWnOQnxjXv0V+JEoN1eto7iziMMIt0dbixOhWM1buGThy0c1LIa24QbRuVYoX9lYR3bofJ9q04PVqXmqIDnZZKu8IzIHaso4fTx5wb7nrn3degX6NvLu3B38hckr/ej6ZkwaeCvn3CGlqgROb/itmrpCwGgmK9y5xJ0wP8=
Received: from AS4P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::17)
 by DB4PR03MB9532.eurprd03.prod.outlook.com (2603:10a6:10:3f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 07:59:39 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::78) by AS4P195CA0009.outlook.office365.com
 (2603:10a6:20b:5e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 07:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:59:38 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:59:38 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/9] doc: mesh-api: minor copy&paste fix
Date: Fri, 27 Jun 2025 09:59:20 +0200
Message-ID: <20250627075928.19788-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DB4PR03MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: e075ef68-efc9-416d-d11e-08ddb55090e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2GPi9Whscvj5MiQ1z3wTCoyVTI1Na0+lwsoYK4j6cEHJZOOTjW/frezXBusV?=
 =?us-ascii?Q?Alrk0rHh5T8dS6R+iU/dCG2n/Qpai4le61ZQGDnYP5teLazlOscKFrZqhJ0h?=
 =?us-ascii?Q?ZrqgCIhna1PAMh+3phzTszVN87XN1NhmN+kmYhYe7sv7vDEBlZPZZRlgQ8WY?=
 =?us-ascii?Q?oYNpCSBJoTOeL8a0zfD8Ww4D1qDJo7aSfAGzI4EG5e/zCyRumi9kOixKfySy?=
 =?us-ascii?Q?+YiUpc4iaIaMSvUREGtGzEBn8EgV+wZVZFXniO4vPWAJlm9qBUVoE/g4qGRM?=
 =?us-ascii?Q?7yk/mZah1kqiIrysYiF+RzAplrwo4/U87Tpw9H+lhHrNm3fPzGtTz6DatsMU?=
 =?us-ascii?Q?tB26LESZ1j9OUK1znWtXB247ODd9oGD+8N6H1r7EG6xSVtd8Sy/hymZFOPLm?=
 =?us-ascii?Q?eO05MNxNncYVq1XP8L8Jj6JuT1pE5390k+W4hacjGD2nP87GeLOAx/L+zyhx?=
 =?us-ascii?Q?SV1T2Fd0rUOsI4sD9WubOcp9C8iHIHi2VdM+aQSSO+G9+1NObLSGaiu5BC6J?=
 =?us-ascii?Q?/lF73PW/6Dsr/uCnkHuLKAVIIrZvDNU89yyckeKjPi30Tlj6r/EGtlYjgw5n?=
 =?us-ascii?Q?zW2YaS5l9VFOmI5PLrJu1Z4cNc2JLppIDrg9ZLSMORzg6wbjvMs1CEZi4Z6b?=
 =?us-ascii?Q?gs5oGb7dHyMJm3Sp/kd9JkhSSj+ZSfYME0c9FlGSFVOuVYe4mLsjVO2DW+OE?=
 =?us-ascii?Q?kko5wbgMB/4CjSL8fQthcDNtH60BBPfq31s164UnmB2I+SuDogDK22fT7p7H?=
 =?us-ascii?Q?0F1434oQ9IscqfZs51SbOsoJPdk70cimGGrJ4lEBQg8FBcv48hbHbWftPYlo?=
 =?us-ascii?Q?n91ydNi4g8dVP8KuGX6fHF6nzGCWpHpmCSx5/3euwuy70TcBBpnOIjZdNqqb?=
 =?us-ascii?Q?oUfa3S5Tu+vltv4SZcfQ9uT38Oi2268dkNM4HNWeCgYDyzQpYcYpYrzPEnGs?=
 =?us-ascii?Q?be0OpSyW85xmWQveimxlkJHLyWHjYNfYBQGC4HmL2aW3pjGPhoPQBC/SXLDo?=
 =?us-ascii?Q?Re3Z6Js193EGPeXZvIaqi6csK8cifGrZs9mV2r1RbQxWODoWUjy9/G2Y75Qm?=
 =?us-ascii?Q?/qAuK1YWx4jvV3QX8PQPpdCwll7xGMgRzwJmPJtzG6JXUUpl6/qoNoDsbJKx?=
 =?us-ascii?Q?k7iK1MBy7KU7lXFKm56Djg3JKAiv2285BM5qrNEceYzW/PrBZZaPVavYgiNX?=
 =?us-ascii?Q?6wTo7Zbn2mQEZ+20rXsVts6D3PK1Dgv9DOUd3sj0Ta7u4/LOLdvtCAntJZHf?=
 =?us-ascii?Q?lBmSEPgVjbEO7iLjtWiwc7P5F9XFEEOHnQFbSARuWxOacLY1jJzA0XdRyg7F?=
 =?us-ascii?Q?eZNMSNewbUmcXD5BRIQhLo+s5AE+9vs4Y6/5+S8sH9OocrmC4vX/T/EETPL6?=
 =?us-ascii?Q?WujF2U+e6CZiEEKQcP2CiGoKfu55z4zO8lCh6f9pVkMC/sTOI8GiZHKqdbu/?=
 =?us-ascii?Q?Gkddce9Lf/oJUuL7N6Iy3IF0ft/JWdxzPnFgnH4z1y0N9YjuZGh1TJdZPglY?=
 =?us-ascii?Q?n2r+7nlqyu6a5DvgIY3pUKwhRFJCcSoJfw5o?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:59:38.8200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e075ef68-efc9-416d-d11e-08ddb55090e1
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9532

---
 doc/mesh-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ea6f034db8a5..c67b8411d797 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -1018,7 +1018,7 @@ Properties:
 		Element index. It is required that the application follows
 		sequential numbering scheme for the elements, starting with 0.
 
-	array{(uint16 id, dict caps)} Models [read-only]
+	array{(uint16 id, dict options)} Models [read-only]
 
 		An array of SIG Models:
 
-- 
2.43.0

