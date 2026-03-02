Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51681430BA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459377; cv=fail; b=IGKi7B2NbeKAOVStBmuHJGFxir6rvSBU2a3CKWjHrVRVEpyN5GQcXDToqF0s8jqjquHWMOnkPbFqbKVxyg/L/SYu/mcveGjCnJp5cmo5L6zRFdEBSATmuJibs/RvlnZAibGk0pAfJ45i/NXUqVmwUJoWYBJCg5Vp4E1vMFrpDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459377; c=relaxed/simple;
	bh=284J0S3TkqgtTzIMwO8m0+Ga5UHzE6f6Ggcl0q1O3Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJSXhObmCHz7zISra6CouJL3cNJTVCmj9FYPsAUQ3qRWMhKy40n4SRCFRewozmuvSld2QtGW57xf30zDuMlGS/LVlRFsGuKm0m6nK1myYkW2t4e3YaihfTR93JonSOAcheEFTKiM6Wbd5fWBs+oOoPkvmrl/vYdNWLprMPs7VUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Pwi6fc7e; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Pwi6fc7e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6ofdp68xJ96dVX8AzHxBmmcor2MKV7YLT9nwOYSL9D6cmDClwbsSkNmMcFFCTqZIQ0kXJ7w16zF8aruuPk/yVBrIsoNk9uzVWaiDT19xUUa4KLIMknV0H1D1XrfAkbytTZnYGdl1V32ExpVg0W09NBdaTduvSMlkiynEsjqn0Jt4p5pEAHJpBHZaZZs8L7PWA5CDut+q313qr06JL3gNBq2VfwDmcFYrtQQj82CO17k1jLBaYtRdFF+nQ7ybcR8TTCSii7oG8Z46VVRuKvJxM+vQidWgqP/gy5ZbjT37HupogZ5R6GV6PvI34sBDVE1Ikg/j5ILMFIkUk8pXKvATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNOiti+liRLRAo+Sc6HhV4rIur328yQXEyXnJfBBRDs=;
 b=TjeVhZiYI3N9r7yYIinPGF+mRPmgkf3gamxcc7oQOXi1vRz8oD3Rp3rKtF6FtZS1/jbU1ShViB9x49v8K0Qy/wr/mVfryUghhi4Tr9P58xkhptOiRBVGby5b2CmbFUcq8TN0MgRPlnIrvNE/FbObv1ULu8Kq7Gq7UFlUI74zL4GWVwwSkQwjHr5ZDcoWMdpZVub8xyHt4UjlVTmh2QrEzvEGYqZz7etAVxdMfYJwzsm8SvONQ2o75xAzW3dxG5WuBxFKL1ApUEy3QIErSAMtzmWfI9H9kZV8W9q7U7qj8uxs5w2gHtMeaecZAUlED66MP+q8AaSN07DpD5OnoG5iFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNOiti+liRLRAo+Sc6HhV4rIur328yQXEyXnJfBBRDs=;
 b=Pwi6fc7eF7kZiU6icyifZClUxBr7KoETXgx9tZJ6oRZlG+YdgvrxEt8tUoeHGwrzXz0D50IKLNS0sEyVBLAlFbPnOoTkk0CcQfcI9pNebWvieaEpTSRKjMnbzHNqG+VzPEgx13TtFu1OP+101a61yyIv5ErCZUZ+8FAm9R7lf/g=
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by PAVPR03MB9092.eurprd03.prod.outlook.com
 (2603:10a6:102:32f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 13:49:31 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::b5) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:49:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:49:29 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 09/15] doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C
Date: Mon, 2 Mar 2026 14:30:37 +0100
Message-ID: <20260302134540.25540-10-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|PAVPR03MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e49a690-95bf-462a-c769-08de78628714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	iATkfApFSsnuk7yfdM7o86GMi/2qCOHtYk9CMtvWRT8SkjOy45ocqE3GwIUwd85IdGW+U7tKBTwpaaV68D/8RLChhWW42qUJIkymRPjeJywXhPNeNW27qTlS9DVTCvDtDYOCx7q6bq9ptkKSTo1NUMZAXdwzSZnPZDShnoYQe54m5moYbz1Dft1BbOtowFS/9TmbzsRaSWhKvikrh3ZpE1cuMty1IwHKF/XOSI0KSOVCHV5TcLc0a+oCG+PYxViu6hL8SsMn+9ev4XpsTLk4eYy3o4ZFtpiSQOSlX9KJaeYzuUoB7/hWX2JSpVQlK+VhtJLmjwA+SnSqdxOCCn18wOGpoECQy4ehJqJQuM1oEIrYjDc9n76mnFgzIf/00E0i7t64LgbJ2fLktzbktMI2jOLWStX5fb9OCcbMBl+0RFhzuidxRNGFAPVGB9/Ji51+nwKCPXhp9EVCf+8A6g0Ag6FK3JswRM29yr8oaQ7KPacqNxJBVbGNUV+vR0ytrb1is+ctr8kYa4Qce/SYFEUro/5nMnVIcznfU3B56LgTgJoce+knjql5Wghg6E2af2veL8r8SiINy0F1boosp0dBklR3V7fHgGzJhTcw+LsKvaEHeRzg2cPJFV5i1EiAx9BogSONHJU5ECXZucQkbXraNOZkp24NwXxUF9DPueS/cSH2Y9cngFdFmHiCmHRY96Na3xugCTb1cpAuK15a9haqIHQSJw6n9Rj69gg80FHkuoFDWpy2lOuUsJwJm/zxauMHWICdd10BszuBUUi1qMsCj/C0dHKp3dVI2e8DeIHXGSAfjqYzuEqJDjIZ4P+qHF6SVyVv3NH2yY1BmFT9j5cnCg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PD2PRinwQa+rhl2wDWQazmt22bvCB5AR06UhSPzqjVWSb30SKdgRTJlPyKpSEbOO4YNR+TaRG66OcLK4fxOM+ZBU2bql3F6JNfEt+oOMDciMuTnls0tPvmQWScuxUsfq3N83BPYjZRolki/SVYZMm1gmoPj9GHzktdSqfsu023YDgka3wHcwBHYNJV0maAzcUcW9k2DYY+q5Uejn5X7UTYZD+71SPEz18OkvETMCgV4hz31uoFvs//H31LbhcivLW089nT04ie7a0HdVIs0APmWFcdkKo3//h1YQgZjY+Lg9W27fsChqbW0kcf/BClBBCihsDx71JIsCGgOYpKL2yihq/eGM7wLhSoDPcbFQJ6QvzF76AFp++YAdJgkuae7Kh7h+QVa4fQVakh317uSqyJLNIy87t4Wrzt4sDayuomQzjiiHk3w1dnH3a7tWC1UP
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:49:30.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e49a690-95bf-462a-c769-08de78628714
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9092

---
 doc/qualification/gatt-pts.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 447cf4a66610..803b700d97e0 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1099,6 +1099,25 @@ for which we know the test passed.
 |                        |          |         |       | Enter the handle displayed for the characteristic during                |
 |                        |          |         |       | register-application on handle request                                  |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-39-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA read,write         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter '2' when asked for handle size                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Run 'btgatt-server -r'                                                  |
-- 
2.51.0

