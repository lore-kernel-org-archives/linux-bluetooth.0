Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B23E0C71
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459271; cv=fail; b=V5rpfKGHQ+5ACn2f2fDTNL6Ia8l12QKbkg9WxpjKYAX6+TPKNcMWJmmSyY/VBvaFfSnB0yEA41Lj6+LltMeuZJn+TE7J1utmqIlu2pIzunA9OcOODLQc2MmbMdCI14KkRvtTK73MleXyCB01TSiMJss06GBnHoTjCEStbHGjiAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459271; c=relaxed/simple;
	bh=9uHMzB0I+3zxTo5aL5o56ILGXiMFs0HgNqsCaH/ceuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDYd3bRmGD4DfkWwIZ9opj54d08DBlf1rGj9WR5VwBWT5g052H2I9/Suxyl1N4qHPPEmx1fy5ZMX3HQ3iJMagWeYE++ZVgPyues2Xb501s9FB6AjwJ67w4pK2Bk7Zc8JBRcKSTpbROTw29y/Nqqkj4Qe25KH06sS7rzyGYP1FL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=kfiB2xlS; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="kfiB2xlS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm+rIwZZelcqJZR3cWlIa0Y+I0wqUYNDJPZR+uX1uNb3WKe8PZOzQuzU9KwHWQYLklWbiszzQ8ZBo2euv2/sDi5FKXe01tRZY4zqVKCXdKqvttSzPVsOMKP1V1NoKr4kZ/YLSVPsZqJYVfQusS6U3WFucajrO5MDJW5zagPoMZzwSKs10AiTjtS7lkN25LAOi+t23CTVvyTC2Yc03neNk7Oc6z6pFYCkGZQi/sPVG1Z1CINiX0g51itfbPC9CWeqDJ7CwePQOjxGivAMPIefubSReU3S8VNfClcQoeURheefjXOrvBgmzjZFuuPH425vRFAbmU01wCZvmzVfSyLUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbjmQ1kHBEzbvkIbO2fI5nBTuahxbmGLbCr+P65A/lw=;
 b=d2zGzvS4ZTL4F8Ry/1avYEd7pWaFIjXayrNBUoQy3uG9Jex7QBLfj+Ug1M7nHIjA5HPnU6A74dFJEsZVVul0eYNCabERNKwWW6R1QOvicIbe14f7KHqim1juL8k5IPQNlRljIB7bStCoDHWKpbToszMcC0I/anP+dlPbMUyTs37lWuJnH2hWUttDGOXCiC8msGxbPnTTzzTvEC4/IvgBBHD8FA+g7p948bC8Gj60CGeYLkn9FoTlluBd7FBGpQeC2h+YTAOaGaYkX5sjtnuV8ZTSKhefdyjp0GWQk272H6TAjbrzH6+8CobYQWyklqqVeLcThmNxb/6RLY7vZXdfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbjmQ1kHBEzbvkIbO2fI5nBTuahxbmGLbCr+P65A/lw=;
 b=kfiB2xlSrBYSx6q9sOciIM11eUqZHCipdohZBaTo2V6W0EaeNKb+/oXxgU98IU3vMRKzEbd0lvyIZKNmmHC4arRVZ1acX5E8Lmz7Q/3nuoxrEDfwvdkF7DBuX3JIsxf89k2pciI0v0uh23/5gE/djyQ2YwTCOw+pDJV03nq0ScU=
Received: from DB3PR06CA0010.eurprd06.prod.outlook.com (2603:10a6:8:1::23) by
 VI1PR03MB6414.eurprd03.prod.outlook.com (2603:10a6:800:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:47:43 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::e8) by DB3PR06CA0010.outlook.office365.com
 (2603:10a6:8:1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:47:43 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:47:42 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 05/15] doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests
Date: Mon, 2 Mar 2026 14:30:33 +0100
Message-ID: <20260302134540.25540-6-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|VI1PR03MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfb06b1-d5c5-45d2-6491-08de7862477b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	etWfsi5IC60KxTCT2yLe2RA2ytfe8U5R5R0TY8YG3+BIzWwO9beT0zBa5JinbO5R6u2+pdtNqVDTYHrdIYzyWQSDMrhwRid9iOAJlAbCmSyDLc9mzBqsq1CJ2u0ZpMR/rXEBJZvWF70F1Ha1pSXd90Ts5UCW85cLgpdO+JZnPCBhEPX+Op4AuLbm5ACssE5G59wYjngr6oSZuqQgDxzpyg+94DlqnC1lTkSTPSwU2/qXilUVCAvscaCEpfPfFAa8Jn++Oh8L8CT38uryE/CJrD2ySxNxUPc12EgBCEiDfbwROEoqZ7CLAQiR2TUUmU4n5k2n/jCuNm4556ayEP+dYXZXJZwV/OBDjwHmWTBF0cfUmvTfn6quzDaFZZV1r5gX4IYA1k+k19cYdBkkPKAne/D2lepd4NL08q3j0hDvIGwjSOEqIr4DAjk11Hq3AK8F0mspP/Wh1cnoFD1HsebA9lJm4F5+0KwABRC/j3t79YWUyDmRsYR48dGXOr+JVEKyk35cHzuynJzF8x6kgggwAQRAJ67iLc2FlvUZvxL02baJMch5OX6MRXdjCPo3u1PNVSW1MSsCbP4c7Pj5U5GktUEvtjOGslOc/Av0nKhKI1H7ZQczMqBK+27jCFjXBFdRW1Egw78hwubRfHnD0XFJCGytBl97UbvJUeHf2SLUXOYrgCGNDiPsbuIz62/Klr2rBajYCqtFMkQFakQ1i5lkuVjRaN4E2UtOOkGLoFZrWRi78RKOVpt/JpV1P51fsNTf4V5YHxau346qiSmjKgNC49xHbcJPmA53EQ5a1TH3LP7Gj+wke+SC4L3UI05dgjSj3A3GWUN1/TQzu4JrvNJDcA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V9WE6pvHNdxipwWa1VjtOATa/QVv12avcS7E515VZ4BEzLBV2izkswfIAUGSfUJiZRAvVoPZwqwZQgxnK+scRLCVA8eIVz7XRFg/lP7Xf+5Bgsx8MmIft1ZPIAidshSS2GrWzrgaRWUGfCuEFH27Ble6Pj0wr6sm425lmdPD8fEySIJtVDuToKx2CYqSMgNdr75jWHH9f6b6cZh3CYGURWH8OJ1iq2LYoy8kbweBMJCihfFPj1g6aan/0/6eCxFtkxDpJ+BR0KqugKAaL1RoLGgPacdNg3mwr1VtccQf1N5SPTHBbneWRQTwkRL9bI70twEHeJwIsxtlASxqgey/J1DZPeCJ6nC9lJ1ayhAmA5JjZiBHyGkS35OmK4IZoY16K7GXonU8LDJA7nos4lqLhJEW3OKUPf7h4CxTE23HCIAgJyq6Zqtm7IMfDt+ex3pW
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:47:43.3852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfb06b1-d5c5-45d2-6491-08de7862477b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6414

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.
---
 doc/qualification/sm-pts.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 87fb0d7b623b..f961a2613d2b 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -355,10 +355,6 @@ for which we know the test passed.
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
@@ -393,10 +389,6 @@ for which we know the test passed.
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

