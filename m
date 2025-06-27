Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012046.outbound.protection.outlook.com [52.101.71.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC6229B15
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011234; cv=fail; b=aTGA8N0DFYjdsoLJ7QK2Dt5fKU1KRLH3uPjVUw+MV97FW8cJml7RJeA2g7e7h83mxTRRpM0nU2eXl+X7/YjGItMreilLKK3NWQ2HKLU8P+4r2GdIwoMGFnadgYTAM5kLG+FeHOCS1LHDmzTuOUBeplw42PWh4IudhacpBeo3RDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011234; c=relaxed/simple;
	bh=Yyzu67oGvxpkif+RWJ6yFtCL2+/rUg8+d4S8URIrKPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmkWplylWl6wEiLF1Sda2N92Lbp9mlzJiofVEGrHK4UbnimqClZttzj2xFE9JmZgDIOtpYOkV4TD09uNNlz6GsRSocbnWyU4po4ZVFfkWH7uo8qpeoJh2SvjaQT18+dQNr9VemXqSTGibwsAobu32ZGJq6POJ76gy/4jMjpwn2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=PhnxW8ZY; arc=fail smtp.client-ip=52.101.71.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="PhnxW8ZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwoTZQoRRGFzw61VTlDfHb34SW+b28WHSI1euLjWcuJvnBNzrEHEia28yxNBd7mAz+wNNmnk4m21NJStiYSNbc1Yy8RfkQt1DdSKqmCn4Mg/AWLoDe8+tu+9raNvdHMaQAn1di3IdinXLVWivvucuKKHg/pU5gHEQ/9Mm/p2udo1yYsnKqCeK62aNIomnDQIxDTNO70KjMeRADMib8zFune9BWWaCUtn02ys8XfplTZVW3bEzW5ir/3nhVsEJYR9Ra8KDv5T/xVo7EnIdsG5Kt2G+d+R2VRLR1nXfRy+486owWLkeFXusSfEhfSJnwysdDOSzJH975guFWkNxTvChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVocZTm2N6I8jej337LAYsXJPeWiYj29fIxSfQH649M=;
 b=MEsd3FkB3f2eh9GLJGrfJP12DUVg21CqRuSx9TZ2Mho/8vJ48odxmUEcBDVNx8cYnxmLE+j22jgAV6IH6HmZtV8V8rLdtuIDptAtEEfcTbNw2Gsx0Cqw/8U/hJ+jTVOwB8yJRZuClD7ewBihL9X6W42XyOqd0YeaKY4k0viWpeI9gwyJcWtzjncWlE6YM1bSqPH1A1j3kSh7wQfqwAcibKua/vD29hewFkHPGKIDRD9CTBvKRSL9bvo9K5FJtyZNl1CqG6Dd2rtTsyXntV35qEHNvXASixPRCOXCMWB9JXhMItn2iy1iWaU2C/1mC6kxE3j7I9WZr1Q+dEF7wM0rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVocZTm2N6I8jej337LAYsXJPeWiYj29fIxSfQH649M=;
 b=PhnxW8ZYIi6nPKK0krrTIoHYW+oQ8putBFbRqdNwRkmwOi77JdKS2Febk5yG/i0XRA9SAds0/6bJfNRz6nHEe77u94lsq1Bf0xFU+TGSaFr+iJp/jyNlePmzPI8YEwViwSZ7oe4rkEAsn0aAYNvVpTtwdsUEWItC2tEOC/wIWHw=
Received: from CWLP123CA0183.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::12)
 by AS8PR03MB9440.eurprd03.prod.outlook.com (2603:10a6:20b:5a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 08:00:29 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:400:19b:cafe::24) by CWLP123CA0183.outlook.office365.com
 (2603:10a6:400:19b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 08:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:00:29 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:00:28 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/9] mesh: util: constify
Date: Fri, 27 Jun 2025 09:59:23 +0200
Message-ID: <20250627075928.19788-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
References: <20250627075928.19788-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|AS8PR03MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: f00db4c9-dd2d-4e91-e9e5-08ddb550aed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRkZPlXiE0V1qT/SAiQPkvkghcb7sSR5DWoR0dpTiSftDvoNaw+RkMWXtx/W?=
 =?us-ascii?Q?+O83WEqqUci0RSAgFGABs+g/gvIkjl/vQ8vYNUSFo3+9ldU5xZSK9VA5+mXN?=
 =?us-ascii?Q?Ew+OvN/AskKCkvRBN/Aw2DHKg3n9qAk9CKJ5wWQeMCgWHc6DHjb7Pf3q9d1o?=
 =?us-ascii?Q?KYRxaGUaFh7+FYof7cQchC7FJCVCnSZ4WjeMTaAEsDD/w/KRACr0I+gWQ8HZ?=
 =?us-ascii?Q?ulRFNXhBANzEnbm9rWMpGp3JfkDf1CrlzDU4YaQfVZKtyu5Kg3yuIdpoQiLH?=
 =?us-ascii?Q?pUG65XbOnM6n2Q8P0amG5F6mkmtKyk+oCSinYUfJ3wg79VYJTVOga0osES0x?=
 =?us-ascii?Q?CLnHPSW7NumHEQrb2unpoVijO3wC8xkXGZkwMamB61mhlBZkldZ7RN4iItTP?=
 =?us-ascii?Q?+uIfypOKiDQFQGKhz0MR2Jt31dJ6TseVhIhke8qrIQO6kRDgHEssP+/kVBZX?=
 =?us-ascii?Q?MgFYJM2Xa1ik+aftpuZz5IdsxpWrsHrZF6byAEX5SLckwtLAR+g8xHyj8r+C?=
 =?us-ascii?Q?LfCmOWcEh9C/fseAfvb50+dQlnjr5OKbruSpce9JcNqbZQNAp5s/epF4dIkp?=
 =?us-ascii?Q?MeNCt9IePsqBtmWTcrIwmR9PrJ6Cwvi+deO37hTlkQRaU+ABEonKCV/Con6H?=
 =?us-ascii?Q?QrwDsqFyhXa6HNGPWj1S5f6VIXsmn1N3RIYfgzoPzUoCQO0Syd7/4TBUOUBk?=
 =?us-ascii?Q?LubuG1mFv/J9kON0xDnOUPs5N6pBRlWRp+PDKiIiUnftMSKBTf/+cZ6qdLQ8?=
 =?us-ascii?Q?ElWoJKmNhN27sKd9RfYYMUdo1vuR9bo247EgpzaXgHA5f1tCNiIN1P37t07O?=
 =?us-ascii?Q?6sCt6Ooqz2Akyt4wLxulZ8qpHthJeP7LsSeyIz/M05uM4xfgi5fHnCe6sE38?=
 =?us-ascii?Q?zBUAOl4yffusITLz1EYo0r2sgmde4/8NqDQSQlf3munmD1jSQ1lxt9nS7hg2?=
 =?us-ascii?Q?DMMm53MOxnQmEEs1Pi3PShxChlZhJN9MRcBhGP7R7EdqnYEy/Z0nlx1ru1UT?=
 =?us-ascii?Q?fosyt3bN2gbC0ws0fYoeUHtbfBFNxie4yeL+GBfCNkUAdETt1BRrnetXa/1y?=
 =?us-ascii?Q?2Gtjt46Rx2wzjZ1226jo/+nmRPN961MpdCwcb4yDQdVpDh0CMVsbUAh171Xx?=
 =?us-ascii?Q?JgITGJ6Vm9mUSr/jmktJraJ8v+n1K1rSdk8tJ6SzyTycZrAMfriwJM3PTGj+?=
 =?us-ascii?Q?fxMC+FiZbLDkiEcBaTkZjLEsPK3Q6v6TTpWxUCV+FAWCXRV7SyMfPTT/0pzU?=
 =?us-ascii?Q?c1rJ10gmnLK9ZbB6O7UqSgxuFinx+HP+QQ53wxZrJPmuGRGUurc19Kq3uzjx?=
 =?us-ascii?Q?Uk2/S6fKIX7eshke9muNwZMarI+u7u2enwi31GuRfD6Li2gY2+3epYJ9C7kW?=
 =?us-ascii?Q?XN8idnvz4WLZarZMdB1gFki4fB9P7zEKuI0TDUJgTWmn+WMb73C8+WLdaMrH?=
 =?us-ascii?Q?mx50a0YJejnZ0Wqf2FvyrCWyGWRlEjquEAvd+J3X168VXElYu8pRJSmhtx8U?=
 =?us-ascii?Q?Z6x7ktIVuXv7atSy4NUL14Lvlrq6Wat/+yOa?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:00:29.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f00db4c9-dd2d-4e91-e9e5-08ddb550aed5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9440

---
 mesh/util.c | 2 +-
 mesh/util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/util.c b/mesh/util.c
index 73f13aab7d64..348401ae5582 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -75,7 +75,7 @@ bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 	return true;
 }
 
-size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len)
+size_t hex2str(const uint8_t *in, size_t in_len, char *out, size_t out_len)
 {
 	static const char hexdigits[] = "0123456789abcdef";
 	size_t i;
diff --git a/mesh/util.h b/mesh/util.h
index bb417dc40f16..36247ea4d6c3 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -11,7 +11,7 @@
 uint32_t get_timestamp_secs(void);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 							uint16_t out_len);
-size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
+size_t hex2str(const uint8_t *in, size_t in_len, char *out, size_t out_len);
 void print_packet(const char *label, const void *data, uint16_t size);
 int create_dir(const char *dir_name);
 void del_path(const char *path);
-- 
2.43.0

