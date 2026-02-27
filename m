Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABA1482E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208137; cv=fail; b=aymjgFiSd9M9tjNgef4nhZVpGUcFSwYTs19gd1kR/YQ33MfkDuO6GWflpw702fWaV7ABB899vBwVcuc8Inqn6AenEKshl3vO9L4AU1ZnmfYJNVuS+3F1EwDXCwvFgy3sIJqW/ck/zuopNGbIAqaVKeIl6I0UrsF3OCCfGYo/aco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208137; c=relaxed/simple;
	bh=hWS9q8r9+/BZqx5VTJKX0dDN2MsxDiiGgTz5JGDeBvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkgozM+OXG+HbPyK55/psN0vEIJkxqFDIGSEpdfg4kxOTgnoYWn7xM3rlHAfdauoJXzytmQkIMkjKDIRicbpaWa18CiJCVYXHAL/e8/+zwITz1ApOdIiDW185nX15h8W+uDq5l7X2JZzbMHfSZ39BG7BIqHOoLgZPNfj2Ebf38E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=nJ7sh78R; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="nJ7sh78R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9tLMqSKr8xtToJxQ/RrbqC5/ANV786St8A6EhTc7LIzWuKFt9w/ZGDBAt6JH2AwVU3cYI3ycW4Jv1g8aNHafVMJdvXPExF9Drntk84GlQKonwsmEFS187wU3N5YWitFaUUCUCAxm74mJqvs5JEfnE2B338/NbgK8xL3pYCwmblvl9NCDRrE+S2pXXayyyCmGbyTKvBvvUtMwqfY2RoFjWaMj0Zp7Ei6nTH3X0nb3h7H7FFlrSWgYANKzYYvobYDtXiLiIuqFGI5nyqvoVpIeaMNQfo87I/OVndBdwlseGPpFiysZ6vvQcfAqSvT9mxcxqJ+37lvcMgs4M/RbaE7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS5eWkrYd3nQq2TYfGK6DF/UMvIIz8rx/Z1aoBkV894=;
 b=QQEKf6UWMxWDvI4QI9bEgXtL656/4RopIDsIOoO711YHxW9cy0Nv0Cz75jEnUtjQ1T2PMTL/dEus5vStMLtumYMXUTGSJaZNeQKFN+79SW5Ms/svdQ+yu0kBqHAmVgsumTUPtt5FklgL3qndoC0z6vSjdPTCNt+QQv7v4gGZLiXyi8IAvZObLgRaBI6C8i1Af/sXb7yOwZiGqM/+axXrAcppaeq6E/9xOg7YJ352SoCjdUeVZmwD5Uw4xwRKTC232Vo8+Od+8rO3Lzo9U8mbPgksUWCuydsZ9n++pEPjMNZ5p3vLWi3stHHX7Cm7n1QJv/ZFX55QBuA6Z/0N6CaqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS5eWkrYd3nQq2TYfGK6DF/UMvIIz8rx/Z1aoBkV894=;
 b=nJ7sh78RpGVvM3D5K/bgXKU9PScrVmisACPg+7mtr/fz3yPST4HAX5aj4vBe7DRYAssIQEBKHtXAFEeWwQZ5E8RorO/PEDcaiDWnydBI7e6K2tvg2pABHMwqGg3ft26o/FCTDCKc4DAG7V3Ljn0AD3+W2wucugKyOGBSJr/XqLI=
Received: from DU2PR04CA0279.eurprd04.prod.outlook.com (2603:10a6:10:28c::14)
 by AMBPR03MB11618.eurprd03.prod.outlook.com (2603:10a6:20b:731::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 16:02:12 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::eb) by DU2PR04CA0279.outlook.office365.com
 (2603:10a6:10:28c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Fri,
 27 Feb 2026 16:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:02:12 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:02:11 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 03/15] doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test
Date: Fri, 27 Feb 2026 16:53:49 +0100
Message-ID: <20260227160022.21462-4-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|AMBPR03MB11618:EE_
X-MS-Office365-Filtering-Correlation-Id: c69f1a3f-30ad-48d9-7dd2-08de7619919b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	IlesWWma3Z9vagkwDgmEBApLOruG3uuylEerbgf93bhu4EnRqBp98tr5wlFjygsNBr61N+cGIL45kSuPWXmz2rMYnAPaq86pV8IdU5j0GI1PTlIBy+f+iaURbeWNDcJPlMWW09wIqJPDqs2xuRsY/zYCcrB8ni5fIyoUWACkMMU066R1wJUJV3TUqSNBvqNDNfwkD08Bn8n9NMIAZUzohHxD2XlXh0ReRRYfyoCxKx41Xjt8TdYuAbgefqJHIo+ZYSjo26zDjHDM8yEbpLeNPKw7GH4WLwJNMjB6CD75haeo29jpSxdeDfmfVPfgsBLPalCjdAjtOPadT/LDWN4lJovW1ydBhwBSp6tHMJ/bWj70xKveAgQqI6piqHimKS9T2mbi3ftvu2Ia5m3anxE6cVSUHxE1CDYVGLfCZziYw52aVTK39JJrN5hK/tYM6K59aXHY4XMVddOO/eX1nV3UvIYA5Bzc83KATPvlZCSvsZ9ssnfdc/OkP6H3Y8GybjLK5oxbOgDr6sgs7MNFBaTs5H5/UZhW54cK8bN5trnzCAzbexj8aSes3hl/ropemjoJWRWNvy6zcIdhIeEq5UP/lCKtJ+tC+Oeky8qXp9AwlMu7bc+n5dE3ywj3SKJ/ZKGIVxd2h4qO8461fkh4Hl1YEJhen7Cb33gM4bjwdz3zMRrHxBX5gmEw/8EcJjM++hiUFv38XU4/JK8r43E6FTg0us5e0NovjngdpSot/cYvfMZFnvk/H1hkcVR5Av+/33pDRzbD+NvMk4j2bsZas6Ua6b5bKIAIrsvkZEHYPVEva99zh5yvMWwfnbh7pcda6H7h/ucBzfM29iyTVUU4ZVSxHA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hU1bqJTKrr/BmDM/1yqcZQYljzLxmYc3E+pOc+A6hdamQLjR9K6aNFJwKtFOvHi9VJ/zPLcKwWqKaf8VdbX37wgsgyTJ+pv7ink+PJnkiZnCszamVSz4qeXbZ6OOMMrpfzEuzalGfhVnnSbrgEHwWN154qU4mFmmHkh43VjPKlw8qi6xN7bYiH/Nv7FT0+EJWloYs/6qyQiUwgs6hleHZlvSHllojYVne0MsccY07UFc1DlkzEbAueIoB/vZQOo5lNhRE8OlocAixd6x5L5CN05JeNveU5UvFN2DpjbqnXgeQ3cNYmPj7o38QZ0ozhZXGNXdFGn9STFYjhoLqJKd5wCq35JkaQvCjriKGtBLDpk2V45dXvpEdqXi8MuDZHoNkEMlAeWBUx821/XR0HvEH3ra+YvExyJ61AL3+cQIJQl5cpQJN2r5bAGOQo43QJNq
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:02:12.1409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f1a3f-30ad-48d9-7dd2-08de7619919b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR03MB11618

The test complains if the characteristic is created with read,write
---
 doc/qualification/gap-pts.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/qualification/gap-pts.rst b/doc/qualification/gap-pts.rst
index 287be6c3460d..6b42e3090655 100644
--- a/doc/qualification/gap-pts.rst
+++ b/doc/qualification/gap-pts.rst
@@ -955,7 +955,7 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - *yes* when asked if primary service                                 |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,secure-write    |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - enter '1' when prompted                                             |
 |                        |          |         |       |                                                                         |
@@ -1917,11 +1917,13 @@ for which we know the test passed.
 |                        |          |         |       +-------------------------------------------------------------------------+
 |                        |          |         |       | On demand run in a first terminal:                                      |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - btgatt-client -d <bdaddr>                                             |
+|                        |          |         |       | - btgatt-client -d <pts_bdaddr>                                         |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | Pair to PTS on demand                                                   |
+|                        |          |         |       | On pairing request by PTS, run 'bluetoothctl' on 2nd terminal:          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | On demand run in a first terminal:                                      |
+|                        |          |         |       |   - [bluetooth]# pair <pts_bdaddr>                                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | After PTS requested a disconnect, run in a first terminal:              |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - 'sudo grep -A 1 LocalSignatureKey \                                   |
 |                        |          |         |       |   /var/lib/bluetooth/<iut_bdaddr>/<pts_bdaddr>/info | grep -v \         |
-- 
2.51.0

