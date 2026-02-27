Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BF44B689
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208384; cv=fail; b=h9fBiNDp1ZcavHcXbTv9M3CfERzcYEMlmjs36sD+sphW5Bt54JiXMjLuwgj0hLg1pjpA/26ia0bsdiO2FVP9DQa6euep0LqQiFFi2tKvg/W4KSlOgI26t0UZccyupodkbnddj2RR0ov7hfOx4vkt0+EwFIhV8SQSrAIN+bmzG6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208384; c=relaxed/simple;
	bh=tHEcotTxbviS31uPbUFIp7KGoWS7GtIiLeh6OmjUhXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9RpsZ4eXLKN8Q52KVDBDw8UXGGATYleTsitCsOkDGGVbLFCQp6clQiobL5de1e2HAdKH6/5BJjyl9ZPVb9UmKVp5YIFTu8BEWRx1Kr0VtKaLWVTke+QFIvwm/GC5Q7LyTKrsLpTb000HD5VY/X2qFIwsZixaSK5LVjGaRb/n5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=DF4xbFSc; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="DF4xbFSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFIttQ19uXMsDlCVCE9OYZWPnJ0WtEE0oEb1MDd8i7hFDkuxX0bRvVJjeCnUn4IPJRmu82Jnl4QwcW3X9dXuowRCDkiq7bd7OZWLshoba1+9YOFmXnOgZpWMceoJeHOuQR+FXzzX8NZ96nWJPNc0cfTeR3VwOK0LDDXMmxEk5gvAz/Zzy7xCO5vo3jVZSkuIUFjJENQlxFcOCI2cP0sc5zqHRrO80ziuZm1gHMUNKXnmaWDQbcyOkyDWK0YQZdi1Gt9B9dtkeDI15H6txiuSVZ/rZCEdF50eFrgcz8adU437ql4ZXwTSwhtyYMWWoHHt55B0QMSaa11+KN+RYXQuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlmCPiayG3W7CTLmXKnp+ZhNSgxgHEDl+8hyZtS3oBg=;
 b=WTCgCA4rMZK2ngPQNwvbFRIl5W+Z0Us+Y06u/qPuzVJC70bFZoc8HI120RXamGPOcTVIji/j066VZowkwlKhtNb+qi8YRNUgacyREeJXLNJK0fdYe479JZ/ymDRzZr1WrwXEbOZyQngUKsAi2gajcx3NQsgmRk3uRRq9LPg4wnkRnxdxhMAFTCwmEB0y9bJKcGu6JuNG2PYdmmH1A0kw2kMe5rIccSu0KPMe45dZWJcYQy9nP/P03PwVYMPzObGQnS1aHaVVQ7fIqiryUwEkfTnXBkHRKD2UhmnHq8p6t14pNb2hgF0trPYoX9SM5pRA0RWTp7XaQsxt+vn5hhwakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlmCPiayG3W7CTLmXKnp+ZhNSgxgHEDl+8hyZtS3oBg=;
 b=DF4xbFScLojA0lnS5WiNxhEPSYo8PDX87+/oU0RyU+Nyc+JzNA0q3o/n7Tc7y/pCNOXK4G7BJa/HLlxpFc9fDx8CqXxSIy/YuLtusKnSjmLu4b9JgjeLIIM24ft9O5yd6/8mKrq/1tHVXGe1DTPrWYGRz3xpHxz5C+sBeUoTowI=
Received: from AS4P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::20)
 by AS8PR03MB7128.eurprd03.prod.outlook.com (2603:10a6:20b:292::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Fri, 27 Feb
 2026 16:06:19 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::4b) by AS4P192CA0012.outlook.office365.com
 (2603:10a6:20b:5da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:06:19 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:06:18 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 15/15] doc/qualification: l2cap-pts: add descriptions for LE CFC tests
Date: Fri, 27 Feb 2026 16:54:01 +0100
Message-ID: <20260227160022.21462-16-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AS8PR03MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: d59f843e-b878-4715-1477-08de761a24ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	sRuXnxj8dfZwJ1wn1Hxi9pyLWbCmBiOCOJuvMWKqNavh74leoaOSoB+igvjlUEXMRfa3KJ5b5nyr+wkrYClbNzNVVTH/P5gm2T1hRC1EuGMxbz8ISTdV0X0m3TgLsqyouS1GG7aBf1gSTbDeLUVaO6rtuS8DfOX9oWThSwPTyG48sWYYM9lDOLG/lSfrzrP0FYdw/qVCTtWKg6rRPq1eeNL96dRvk98mYRRifDwjKffHeTRHC6Ef8UiKqJmuTH89E+NMBuPl8bT5/W+2ZRnXQFuBEEaeMRyV0eOlWfgiBCfPxRRtQnhC8HTH9Gc/HgN1M5/OMslueDdBLxvARt7A5U5LQu5BmLD2Y1WfGX/L9ATdct8w6oys3ShbezTeiYOSFkeebmIzUCrwedornD/VMYNDuiVXgCWqGB+DI0k1048Wl3qRe7M+yCh7o/cI5AOhGDxPwM5bPuhBs9pWVSbmYOAFg/yR6JPo/3Zkxd0TsLoT5UhuPvLl+uaezvsxCDxpRrfrZKXDSoa8y1bg75Nq/a1aqteBvdEzyJfuvO+vOkfC5ZlLu9l0BEKXkzLoyV73WG+QSgNrJfwfhmBA/by0RiH+2LWvDpVKODIePokneH6svhIh4uWLSP4yhTSne4lFFPh4ba5jyArWaiU6uxm4bkCryYImzO/2O4CiOXWxBvVBhaDRvvT5cOZIs/vF1G4vSyXhjGt6xla8m6MM7MoPaD2Pdo/gQTyyZBnoQ84KepiO7NMhMlseC7ZbQt4TUhqiQdFKsb8DLq4bXXzKukJyOHgC10ocaLmy2V7TnT4gecqohrkOYkFOSm5UepnqiAh0n+ogI0eZXv0whxQH50c0Jw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsfBBfJj3CXCDU85VunnCSJBfQ1AvG4bU/8GGzIJD/C5IXas0ZEVc7Xqx/YBR1aT5+AC9DFQdeG5Arerw67dERdGXUxvXxtZ3tnlDMk/S1gEgYddoPZxSoArqMl0YH0kaEaNLyqk8Q4V0HeaEtYsInVXJA7bug/pFYIyxXOxPfSwc8zPiM6f8j3b7q+P9oq3jQQTzkcaHY4J1j3AcSjReV/7jhDxj1bLXQJMHBFo7eobKaQj55Zbg8s7BB/D/wCmuQpegs+Epg9Mae98VM5xTuieO03/u6+yZauc/ndHWlHhXSkBCrc0ktHLXJ/qFSFD2TtpGM7UsoSZmnGlsDlPJELOHzQxPmUTeOtZkTNxCTbQjSrZckZ+3kuzXU+jDrvNuh9jr0u4VrbA2scE2TBH8Sa+OZ1LHf47+mn47fBGC7JYayexh6rLu3618Hpps898
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:06:19.3630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59f843e-b878-4715-1477-08de761a24ef
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7128

All these tests depend on TSPC_L2CAP_2_46. Some tests require kernel
fixes.
---
 doc/qualification/l2cap-pics.rst |  10 +-
 doc/qualification/l2cap-pts.rst  | 215 +++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 5 deletions(-)

diff --git a/doc/qualification/l2cap-pics.rst b/doc/qualification/l2cap-pics.rst
index da7de524181f..31f60e144ac4 100644
--- a/doc/qualification/l2cap-pics.rst
+++ b/doc/qualification/l2cap-pics.rst
@@ -46,7 +46,7 @@ Capability Statement
 +------------------+----------+----------------------------------------------+
 | TSPC_L2CAP_1_5   |          | LE Data Channel Initiator (C.4)              |
 +------------------+----------+----------------------------------------------+
-| TSPC_L2CAP_1_6   |          | LE Data Channel Acceptor (C.5)               |
+| TSPC_L2CAP_1_6   | x        | LE Data Channel Acceptor (C.5)               |
 +------------------+----------+----------------------------------------------+
 
 - C.1: Mandatory IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
@@ -167,11 +167,11 @@ Capability Statement
 +------------------+----------+----------------------------------------------+
 | TSPC_L2CAP_2_45  | x        | Send Disconnect Request Command (C.21)       |
 +------------------+----------+----------------------------------------------+
-| TSPC_L2CAP_2_45a |          | Send Disconnect Request Command - LE (C.22)  |
+| TSPC_L2CAP_2_45a | x        | Send Disconnect Request Command - LE (C.22)  |
 +------------------+----------+----------------------------------------------+
-| TSPC_L2CAP_2_46  |          | LE Credit Based Flow Control Mode (C.19)     |
+| TSPC_L2CAP_2_46  | x        | LE Credit Based Flow Control Mode (C.19)     |
 +------------------+----------+----------------------------------------------+
-| TSPC_L2CAP_2_47  |          | LE Data Channel (C.20)                       |
+| TSPC_L2CAP_2_47  | x        | LE Data Channel (C.20)                       |
 +------------------+----------+----------------------------------------------+
 | TSPC_L2CAP_2_48  |          | Enhanced Credit Based Flow Control Mode      |
 |                  |          | (C.23)                                       |
@@ -282,7 +282,7 @@ Capability Statement
 |                  |          | 'Guaranteed' for Extended Flow Specification.|
 |                  |          | (C.7)                                        |
 +------------------+----------+----------------------------------------------+
-| TSPC_L2CAP_3_16  |          | Support Multiple Simultaneous LE Data        |
+| TSPC_L2CAP_3_16  | x        | Support Multiple Simultaneous LE Data        |
 |                  |          | Channels (C.10)                              |
 +------------------+----------+----------------------------------------------+
 
diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
index 93adffba81f2..043b8f20cd64 100644
--- a/doc/qualification/l2cap-pts.rst
+++ b/doc/qualification/l2cap-pts.rst
@@ -14,6 +14,8 @@ Setup
 
 - In IXIT update "TSPX_psm" to "1011"
 
+- echo -n 16 > /sys/kernel/debug/bluetooth/hci0/min_encrypt_key_size
+
 Tests
 =====
 
@@ -89,6 +91,103 @@ for which we know the test passed.
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -d -P 4113                                |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-05-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Look for "frame too long"                          |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Answer PTS question with "yes"                     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-09-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Look for "invalid signal packet size"              |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Answer PTS question with "yes"                     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-11-C | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-13-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Look for "invalid signal packet size"              |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Answer PTS question with "yes"                     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-16-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Look for "invalid signal packet size"              |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Answer PTS question with "yes"                     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-17-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Look for "invalid signal packet size"              |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Answer PTS question with "yes"                     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-29-C | PASS   | future | 5.69  | On request run:                                      |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - for I in $(seq 255); \                             |
+|                       |        |        |       |       do echo "$I/255"; \                            |
+|                       |        |        |       |       timeout 0.1 l2test -n -V le_public <PTS addr>;\|
+|                       |        |        |       |   done                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | On 2nd request run:                                  |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - l2test -n -V le_public <PTS addr>                  |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Note: If using 'timeout' from Busybox, ensure having |
+|                       |        |        |       |       support for fractional timeout values (requires|
+|                       |        |        |       |       at leat 1.37.0 + CONFIG_FLOAT_DURATION).       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFC/BV-01-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
+|                       |        |        |       |                                    -N 1 -b 200       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFC/BV-02-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
+|                       |        |        |       |                                    -N 1 -b 20        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFC/BV-03-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFC/BV-04-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CFC/BV-05-C | PASS   |    6.1 | 5.69  | On request run (2 times):                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -y -V le_public -P 0x0027 -N <PTS addr> & |
++-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CFD/BV-01-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
 |                       |        |        |       | - Run:                                               |
@@ -399,6 +498,120 @@ for which we know the test passed.
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/FIX/BV-01-C     | PASS   |    6.1 | 5.69  | On request run: sudo l2test -z -P 4113 <bdaddr>      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-03-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -w -P 0x0027 -V le_public                 |
+|                       |        |        |       |                         -e $((0x78563412)) -b 10     |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Result: 123456780A007F7F7F7F                       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-05-C  | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-06-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
+|                       |        |        |       |                                      -N 1 -b 200     |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-07-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-08-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - On request terminate l2test                        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-09-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-11-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x00F2 -S              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-13-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x00F3 -W -1           |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-15-C  | PASS   | future | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x00F4 -E              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-20-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-23-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-25-C  | PASS   | future | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -P 0x00F5 -V le_public -E              |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-26-C  | PASS   | future | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-27-C  | PASS   | future | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-28-C  | PASS   | future | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-30-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-31-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/CFC/BV-32-C  | PASS   |    6.1 | 5.69  | On request run:                                      |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - l2test -u -V le_public -P 0x0027 <bdaddr>        |
++-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/LE/CPU/BV-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
 |                       |        |        |       | - Request a LE only dongle for PTS                   |
@@ -435,3 +648,5 @@ for which we know the test passed.
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -r -V le_public -J 4                      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/LE/REJ/BI-02-C  | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
-- 
2.51.0

