Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF063D9024
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459529; cv=fail; b=lIbmGFrQl+U2VvzOUrH0LK5rEsX7FKSatqjEOZ1bLc36a6JDNPWQKFhGsW1kxfjWmN9PV7j3ZHnxgkbz68/RzzJfuwg3j177gMByNAjagFQRkiK8Tv9WY19tMRZw+/TejMOKqCmjEIReVkRGGyjMqGXqdrLUWtOmabLpD/pMXbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459529; c=relaxed/simple;
	bh=0U/tsJj3EMpDk6ivgAyVrzuuvh2DHfQDzFPZh54coqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N81KfJ8a2cWqLq70pdQxoxPm7Ug06G2NQejW76T2y5PJrq4L3vqUWIKkqqhX+Hu70ljjAhxFbc/55OfC3sLKDFejhzl1ArZ8syHy90PSioKVgjBCUVUHY84OSafCnxr821syP1IR/TYdTpDqhAIa0QUnChrdiFSv0DlOhfgmisg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=EMEll+X1; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="EMEll+X1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzaR9lLnNpFMSKpq8qoUBVws0ZUakwhX+f6jeYCs6XbWVZvX8AhjXNNJdnvCEriatmAb0OGGzBZ+wG2jfzdfUd6CVpSNSe6+XBe7SiDkEYn4xwY9/FqwBXcSvj4FPxPGf+v3+FGTCxURssEDagwuLE5nz6PCI9+Xon/FCcYf7ucF2Fm5Yz1JKSoGZdlQgrgycNp3x2T22zg52acAHPF1d6rQA2sVclH3aOmzyWipFsLL6hHP3JQq2ED5qdKJ0wwAgb3Q9OaCgneCrTdwhWSmry0tKN5F1XF83kxjcYWVgIg+PQT/h81GxK+1pspKvtMLKPQhO4+RL/rGZMZsSD/Mow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqQ/2wV7PZRRN7kmF23L445JA4uhKjIlGHShlN2s0dQ=;
 b=hWKh990xqPHFQcz4vRq/Nn/ZahJ/1kV7ruOoLmJ9+g5pa77Iuonf2hFDJdcCKJn2Ik4eWMkUrC1v6VlOZGFLWoD38BhGEMLhcmZDlIVGnjre5NbgVWKnY6BhNdwcoDYvghpqCGQ1mA1tW6f2iq8vsTqnFKZuZpGB3IOEshJcmy6WmVZjvnGghWfMGHonr3UmzlGcsiVgYYCLE2ZGrKwPZ5UrJlw/JhuyctfK7Zx9CCHNSHyPj3VNrkEXQpa5RbkkoWCE1g2Bhrc86lnAjWToxv0wUiZbxX87hF2kZd5BL8Zpvk6/GhXhYEDIwNEqkuADIsPNRiwwtMN9MBG2NdYU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqQ/2wV7PZRRN7kmF23L445JA4uhKjIlGHShlN2s0dQ=;
 b=EMEll+X1G0XIsfENUhI+vhd9Vot1l+rDq6hDyf33X/rpnELhd5tpFYZSZ36CVarYKpzyudgNwbTlMijJJKZUwjcn4vOQTSEU08SkmL1WrOQKwMfahqkBGVlQukcChX4iMNmCEOOeoW1aJoeksXKmUrz/lc8Lx9UHLN6x75dEriI=
Received: from DU2P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::13)
 by DBBPR03MB6953.eurprd03.prod.outlook.com (2603:10a6:10:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:51:57 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::e2) by DU2P250CA0008.outlook.office365.com
 (2603:10a6:10:231::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 13:51:57 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:51:56 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 15/15] doc/qualification: l2cap-pts: add descriptions for LE CFC tests
Date: Mon, 2 Mar 2026 14:30:43 +0100
Message-ID: <20260302134540.25540-16-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|DBBPR03MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: af6b1bc5-9ea9-4a89-8095-08de7862decb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	xv9vj1gL0ImXmct1iHVy1bjYdN7fHyFl/prMgwiLtc8dYcPz216gg8gu88G1DWIMCvi9oAmyXjQ/FttLpW3O9rXFnUBVcfP7hDFk0rNA7sWJdpkcLc5fPON1aCvbgtW7snZYi3whCJ7wDb2/OPgYBvwnzdAiXMKQxPHcAy3FUSPTfGzD2ybUSB1tssiBqDGosb/qWOzbmCeXdcdbbmgvugiMRmjZVoL4Olxg9PqQRvaZPAREMiMgyh8Rp+T/fijVmjlyodgqFzDEMpxO3bWEzSCp+CHVafhZAR4BKpKPSCai9znW4HBN0Bs6qn3uPGnC58zcf0R+dq8GIyu9wZgmVaIlV3BzFOQSfhtLL2lZnK0twqoGgGSzgejV5eBOYatGqoGhQmxaao3PjAwHPrDmEUe70ysn4vKNlsit11VOzBQL65MrdIrs5zPQOxcUD7zMe1A8WezcnfZYCL+vaDlguaoihL7y2YTOO0WkU+E/bn/JlppBjFjW1F6cniPMSZXGN1bWQHJcHWxGS7iNuxUSLG4zMaUjXNimyhqZl/BhPIk4U1FLKlY45danHquyUXqiXs+YEh2RjPG/y4Wzleq7XFgOq8hdlsNmEckablICGb18Z+7xCy/ORxuUOZs/qlaP3FZppC3pIn+CEAkeaVcWJD3w+gMOm9I/QStvnwfHg4AFxmv1PfHyz5IPK7ma84VKZu1W/sKHWACgJDT0Cb/dKOyyDWZPKz9XKaFKDcgS5qwtxdS0qfV2mUMh4m6H91DnHQByprPKIFgr2D70Xg964+vuKI8srMF0Ftd3JKOQpzP/gA2layVnJd7PemOeFS0bH8Bev+DKrCxO91IqHlGsyQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6FUGgVLzpjSa1w7qEHkrRMkrMU8d1zOHy34CBFanfXJg0A292S2H9m18y1Jas6VI+4IVqcPEtu/FxKmR52ovw0ZzSjj8RNL83sYD1/UaVsps7rYLKE/hUR3gkR5XoUOgPZWLps4N1wFrS2gVNmLtT7QZF3H8KfWQhwrrfIfA1JqvbxSlm5Q+NlchA32OKNRMMlMeivE5QgNG1Ky5i4IchC5U6y7p4x78GSoyOGu6+UiNncDIYwOcnWM5cNlPuhiPLYum9Eb3lu8dArqQJxsen0fqzeejnIia6vDWX24y2uevIgo73sTfnKXElpQsfPcuvQIRPw5uEIAcgKNs5qOULzCDBL9JraTRL6Y8qBIx3VXeAPYQic3fRBMtgr9jBd5Etqe4GYRttDdcT2zJfqRvpy+4fe/Ega3WyKcBYcwL5+G9wvbEIALOc970oPZpKnUZ
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:51:57.2479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b1bc5-9ea9-4a89-8095-08de7862decb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6953

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
index 93adffba81f2..f0e7aa5eea40 100644
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
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "frame too long"                            |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Answer PTS question with "yes"                       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-09-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Answer PTS question with "yes"                       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-11-C | PASS   |    6.1 | 5.69  |                                                      |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-13-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Answer PTS question with "yes"                       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-16-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Answer PTS question with "yes"                       |
++-----------------------+--------+--------+-------+------------------------------------------------------+
+| L2CAP/COS/CED/BI-17-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | - Run:                                               |
+|                       |        |        |       |                                                      |
+|                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
+|                       |        |        |       |                                                      |
+|                       |        |        |       | Answer PTS question with "yes"                       |
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
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Result: 123456780A007F7F7F7F                         |
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
+|                       |        |        |       +------------------------------------------------------|
+|                       |        |        |       | On request terminate l2test                          |
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

