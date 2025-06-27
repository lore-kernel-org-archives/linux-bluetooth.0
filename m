Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3E1D79BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011139; cv=fail; b=gCpfp4dHUCaXZ6tqcEkJQDAC7Yy7ci6racVuzCy533x8oTtE3eH5kfKjrNPjqTTzJEOpi7LsQbQgI7qF4UNZ8s32Y8QxrNCfjcWkhDN9Wjh4RWWwjP86InqB8Yf2od19Po4nBEOaTa2/ZMq02hwLYRGmmR/Flcs+YTcNYVhdGQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011139; c=relaxed/simple;
	bh=Yyzu67oGvxpkif+RWJ6yFtCL2+/rUg8+d4S8URIrKPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyJNB4bK/K/UXbdH33K4b/faZZsKmTJjanQhQpzzwROmyydtoCW9xQLCXtoC5Urukpa3c/gVuTrwKlRepAAZFXLwVa9Cg3jHxk/m5nn6RaSzx4An6hPHtnsGtdG6TozKaeMF/YT+ONCPzpFvTyDYEHzlrnXSWfIN72K6WMb3YeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=VixJvs8a; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="VixJvs8a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p15LFs0hFmITRxq+IYytphiUpmj8i1FUNk1FF/Q+88B1BYGDR6yKbOobcvxWCh9XHE3RE8j+CyxknGRd2GMBZ2rDupf/2AS5sAcVHSLOHKjfaYJlLYuCOv+uE17DOLe8hewR1Bl87+cLX+G7zc1NdMAgbdVTM1hqAn0PXBwuYxDKodoprewgkEoJQkOZKFu2t/VPusrvc7B6qZtyxsYU11AOU+BuU6OrkbyNfwOONlEsYTo6eghRxWfOyf6l1NsWXkUXLYMnHeQbpDfoleyUaL+be6W/LKTdYSt6dd+gy0ywE2Yu3lVytBXI/sq6NbeCQZthUhOJ2pHtRoEJJh6GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVocZTm2N6I8jej337LAYsXJPeWiYj29fIxSfQH649M=;
 b=Kqrc/RsCcvjKMTsy7VCr2hEGEjQOr2p8qLm+TOiMGd0BJzwulnX7cZY/0ojLC7QoIyhvGSH7RJHY2qoOoQDLCrNlC4nwn4EwwiQ0Sj9JzaRK/nJg3oSBcrtjePe5CbxhoCS+SguwoG7vXbEXgLTVA94kmYA5t0xIpsJmAyszB3CRX5AQGG3C1VusL5zEk29npKqFwBNwZ0CRc0R5b7rWQA3Z2N0Yxox6zyh56v9uLx27hW1DLNtvNCILVuzIsIHH7WA8mw4jGEMV4UmJBwYbaNS0ejMavc3zsfbSKNIGzPTOuMd+0vARsb1wlRPRRcLnikcvqG4oAT1DD6ctVOThVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVocZTm2N6I8jej337LAYsXJPeWiYj29fIxSfQH649M=;
 b=VixJvs8a4kWVebpSEzH/6QjYWPI4h3TC9sSdjE7QAE7CIMQ5NOOA2ZDb9AKmyHM0R8BcLsIUqqt7JnoZftTOVu621yTXSMOr8P8KPCpO2Mfqv+gkPQRGLwQa776NW0U0sBKThM0ZuI4yEtqH5PBZNj1tGtklo+0aLf1NFVtDK5I=
Received: from AS4P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::12)
 by AM9PR03MB7694.eurprd03.prod.outlook.com (2603:10a6:20b:41e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 07:58:51 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::46) by AS4P195CA0015.outlook.office365.com
 (2603:10a6:20b:5e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 07:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:58:51 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:58:51 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/9] mesh: util: constify
Date: Fri, 27 Jun 2025 09:58:00 +0200
Message-ID: <20250627075805.19597-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075805.19597-1-ceggers@arri.de>
References: <20250627075805.19597-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|AM9PR03MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 788ba742-078a-4f98-b8d5-08ddb55074af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CskNqpXGbnRKk1nNFJpGY0J98wXk5Y9IqSoGCLIvqXpvUqo36lQVom/dgOCr?=
 =?us-ascii?Q?B8R0K+Woc8S1e9hsMHqGfC1MkKDb5tU9df0ExwTaRromTT64lrFLsmJ1rM1p?=
 =?us-ascii?Q?zi6XCSY6ppo5N+D/EfC2afo8OwcIKe2nIIcCGaKIx1F4TzVoE8ESiuFucOKH?=
 =?us-ascii?Q?/aRlQUTgsDFE39Y03XyV4efydryQKdTIzRFlnowjV9ZKKaCG9Gz54bZ1t6ZY?=
 =?us-ascii?Q?6y9QNYrWY7kn2IL/TqtnbQsF6ClRp6MyabOU2+jGB7/3aPXDUV47ZeW3ndg9?=
 =?us-ascii?Q?RIi9tdSUcnQ+NQB4KabbXvuXLyvcM19Do/4xYYq1V1yyAI0CNkJH7YHjqyi9?=
 =?us-ascii?Q?taUfY5hL8BzKiiknX1JDyMXuTkMszN91J8DXWN6OFKrN1S4TPWkN4E8Vqz20?=
 =?us-ascii?Q?brm7WhOBSWTdLppnvh6+9Hx+BG9ac7QYxApS14QvnV3lI28hEEnzkSmbhyfE?=
 =?us-ascii?Q?cYhhk81sXRgPTJwkvgNJDmTL9F9jT+SiUihXzSOEIGXJDDlWSVz5m5AfA+iN?=
 =?us-ascii?Q?HzqFgm41bISinv4VXaMq9KgssUHyj0tmokoY5M3jd3iQUIcMMt0BVmGZ704p?=
 =?us-ascii?Q?f58Or/I1TScvM9YFi3LSk0JPozconfzJjtcxo5gqYpKh5i8ObQqoNG+BWjOV?=
 =?us-ascii?Q?UdpuAC3aLCOmmqPClaHdaDSuL6qXH3oNF/X3AfXF7DSoSuWgpp8vw+0ryskF?=
 =?us-ascii?Q?SAGcMBUVmFGNvyoHt015odQwv9KLFetQ44uzSLflP4NvyyNUvUTj46nv6DQ2?=
 =?us-ascii?Q?e7N3MGbiboeZ63tvFWiGokhZIXmMoDE05e8BSPFDvCIjzaMd5/Fzavlk0iQB?=
 =?us-ascii?Q?wD79xUt6m75fNd/OKMsGvgKmR262fSzBbtrjJ4KngHPpWLyTMCUpa/m9A9MG?=
 =?us-ascii?Q?qLQNC0cicWj5ibo8cYPUcjcJdPTQAbWCkgomZHhq0cAKL86hZlynC6jfARdI?=
 =?us-ascii?Q?fOEKHEPczDiZFC3GDNpzs/GoUJXlNLwQ6j+mblX105TBoFpVBTeimwmcGI3S?=
 =?us-ascii?Q?8+hciPyPnypzisSgZqByLvAwe5GDQiconCDQ6Xeh7c/RLY4jsvr0CtHh/vJT?=
 =?us-ascii?Q?qr40vgH81o07z1QiRIk5vMPtkAU3vSVr1cvuYW0SEwuIi9Qbh+DGdzj9BiSP?=
 =?us-ascii?Q?tHbEsGcQaXAFBn4JI7Nlg+rxITEm3V2C3bA1S8oWJN8IuruFsfSf4LIJSmXG?=
 =?us-ascii?Q?fZUCNPsN1WN9rE5ure/qFpaZa5hi8NDDBMOF2OW7oBmGOk632O/qt1yNNMlh?=
 =?us-ascii?Q?qF3WdUWx2hVEim0WSI1okzF/reL/YmzCji74efFWzIHpxNaUD1erYIRklBVY?=
 =?us-ascii?Q?hb2f4c3IyQKGch4yrvvqtJkm0JJCAcRIRS5+bGhXyrOlJKiZvZIcLC5/V9Nx?=
 =?us-ascii?Q?ESd899+Dacb5OjGX/zzfXdHqTXdeUtjMnkLkLfD5JtOZIdUpC4NT25aOab6o?=
 =?us-ascii?Q?gNXenV86/xbD8XRbyjEfMWAdcAW9/ojDJOt0fIhoBufB3NZUDffIjKnHQawd?=
 =?us-ascii?Q?p7YroSQRGVcxlbEe6Yyuc2fYOTDgd+j+QLto?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:58:51.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 788ba742-078a-4f98-b8d5-08ddb55074af
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7694

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

