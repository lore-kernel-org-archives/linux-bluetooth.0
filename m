Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F2379EFC
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459247; cv=fail; b=r575jPhy9cm0bdGNjNBSVMIC32S1iKqqTeBbBKpZcoVpD94jKoP3/1DIJ7toJIZCJDawd5iRIHYoeWGMxWJKVob9zXYwwEq0rbkczH5iCFr03up16hXFQPSaOZ+Uq09qPq8LQHDNsxo+w/3mDBQDvc25ue2dOCIwq+Czy2Y9yi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459247; c=relaxed/simple;
	bh=hWS9q8r9+/BZqx5VTJKX0dDN2MsxDiiGgTz5JGDeBvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oanAq0VnQhVsSkVDdYCqGBOW5Ff1/h6tz9oT7jck9eNvpaAXJuXYI1D4iOoXlSPjEuNsg5EubGUkopkAkdhY7jrSLZ6HEXzazhpyFVvWOS71PHa0ZYGMz8AnCEJxoIQHrKtw3reifvMshaAtZV+AZdW2uCr/vJpRLnzgX60rrV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=VvnoxpDY; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="VvnoxpDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+A3+dzdKnoDdgebKkpdULs6JnjCxhk1/mQBBOsrltUW1OTjk8fW08OH+d8UUyX6TTgAkXdHzbE9Ica5Y6hwYxi75rBrLjVN4GRvYP8PfivMMUMRu+KRtpYUWNArwhLFGO/tjE+z8YCNPYm+OXEimV6+X+Xk9HfHBw49dJ9uzptvNQ9aCXvQw3CGN8cf1pWcVV6q01+5LziALWfXZPETJ8arR3t5bMRzr51+97rnDlbtZQPwTsyt6q81AZ2zoo27ARN1RT0G9UzyJcEoMH0+tHv6+WhcjcsUR63AW21RNEVE1QVc4RSlVsqyOhBmHuPbdj9kL5EtbG0xoWvaDNIyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS5eWkrYd3nQq2TYfGK6DF/UMvIIz8rx/Z1aoBkV894=;
 b=cpIPzJFG+yTJbq+Rlam72H6iOXY0k93TjMVAcWEWKG91/mXw9zC2j9qH4qEDi3lItQ29NrqCIV+Pm54rBjgLrcBKaXcqD3OpZXsO832UtvdIEH+Y1RGjGd3mt4jNRMssiPMTGYiWI99qRFonDV0XuIwzZdd6G45XoZ1MzJVNmzNNshb6XpbaMz0qymzHDH2VdZDgzgdCu1f+sW/Tj4pxFwyk8/J8TLLBU9y2soMrloePMufOX0KQLSyf+mlNHJNn5jqts8qDY2EnedMmql9d8LkKv5XAO3Y7Y3sX/wyXXYowjItn1CviRy5Weoh6dRBWG1eqzDX7DMSH0l3nAhfKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS5eWkrYd3nQq2TYfGK6DF/UMvIIz8rx/Z1aoBkV894=;
 b=VvnoxpDYoeFjerpTe3gyC0UAdYNGP9PBYxDZ9nF67d1Ia9D4xgBpgrejUFSauVqZSh9zNM2SF6vOzAh2xA59K7fXPTdVZJEyt4XW/bIFbpNXqsg1OW/ZH/navixS+GL+5nCpYu5TBm13vBGoV41wSG9dMwjNSPM0K+PT3QnvCjc=
Received: from DB3PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:8:1::22) by
 PA4PR03MB8224.eurprd03.prod.outlook.com (2603:10a6:102:26e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 13:47:19 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::c9) by DB3PR06CA0009.outlook.office365.com
 (2603:10a6:8:1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 13:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:47:18 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:47:12 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 03/15] doc/qualification: gap-pts: fix GAP/SEC/SEM/BV-24-C test
Date: Mon, 2 Mar 2026 14:30:31 +0100
Message-ID: <20260302134540.25540-4-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|PA4PR03MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 89665d5f-dac4-4101-4ae8-08de786238de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	WDGdExXU1oxEmjzEaMKXsP8kTq0b8077mbDoLaXw6kUy3EJ7Vl7cxLSNeDcZR2CuNLIFrgrC99Afu4N5TYi4Lx5oP6CiA9DOHbf2pSsIznFv7tpaa3tunIPS7Ox4BKsaNvUHyo5Edb+Iu6nUkcG3G3ks73k45CdBVnnMyJ/SObh4WvABRDAwO8MaBvGfO+8/5GQ9igPv380EpLosNsmiemqfIF0NWcb3QUAmPJ+U8VN/T+UV3NND7cXba5X34mZb1rRWDitSNVYfo0wCmCD3jwzFSwsTd71aENvXWpJk+NEDw6nELFjvGqtBgVkOP9EK57UICbVEaPRc4yh1GYODsiYvzW7iE1ZvaoZ8iK7lKs/6vjAbqgzRKSSPL5n+ffhYy2bnhlCJBf4Zm+uo69p4MnuKqP3AF9yU6T9ACyD3SfvzSEoZvaFgN+UqIJve/tjNTSqaR4nOFLcmwkPWiTpe5srRYceOpEhsFyZoYz5V26nPX5p2/QwG6c5U5IPMaFLAFI29BN4eZPvLXeyFRH4BtpFSuqJGFw7cGQlt3pHCgqsqT+spw78/YFRbqovkgH5WKD+1tVugzfaCJ0hRoFPg9ffv/bxqkGwpcKAlPrskkN9RT01gvJJ5m/5+RmgLD6RVztkQQF0Y9cxTfVvtVohuom7S9Jy6twthqARyEHCHsolYjcmlWMyFKsrzM0QTxIP9Rv8NkYgKh3BqiCI133AjJ92U2Jz6qHAcqm1/tK62dwNVhwiZxPXwFkk7bYmcD6/r7g3kKjvVdPm13/x+DHAA5oG9hb85yypI9uFxJWsc8GXTZt/Tnt3jTimpulJVkatuQgPJkhFedg3XEwfYYp3j4A==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WAzrj4FWYQSnOR/A11/x2MHVIyU5OuYFlNqEM5yWria8L+GAEQnoO576kZtPIjV7boNNE0gOlvy3DrAIt5zPb+rauCzwEqICae63FnuLARxXw3/Y6XDXXbnG+2DuowWijRER3w2joBfMr80U4QU7YgHfqo9eptn7SvZ0KmKj6Vy6OmULzbacruQ5aAr2djipBSRue7D8YFNEZ4NMV1ehErX1jNwYAPr8ROPTwHHMUAASBkb9MNDdc3IwHS36OKN9G7zN8AcAf+Kd5/Ix0GZStPeYt4WugqCyYkOi4ku5BO5FDjHT3BcJ5HZ4V+HWsDfRP2FZ1ZOjJvmzSIBFZpQRpdlclC2XX6r7SvfFa/+uvikRxhGTAuyVn8H5sW5SNHFBPes0sQrgXHag28Znp3rNzGB8knBxt0x/n6ZhUBRAOYwQjv2+tsvvvQhakIiGNbC4
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:47:18.8684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89665d5f-dac4-4101-4ae8-08de786238de
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8224

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

