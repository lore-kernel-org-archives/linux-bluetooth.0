Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65922D4C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011356; cv=fail; b=n1hDm8cVYyjLUbEfDUTSM0JAzL0JCFYpUIFs7ZPOggVK7vzLXYG/t6swVDczdEnImdctfyf9elb1wJ2UTD+ciD3CNQD5bbW6jkqGpOSAciDcTcba5Da5jaw/CEiOVFEVzUGFAOBGc4PoK8akv7K7DrH/VjH05sF0vsM/9T2pRgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011356; c=relaxed/simple;
	bh=Wf2CR+Tg+v0RC2Hr1r+wTTbFngsXTdjO2evZEPqR9F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkaVL9f1indtoEdcLhHA2SnjQ68sOB0s9SfC6SyLBKOXJkLSiwpiswjgmjPH1Uv2V72F5QwhrAMeOZr98qvALKMLYj3hnhZtenmUfZke5eF1pDQooCh3PlGEAV2nYIIBWk2501n3nZ/xAMb2DhkIjuRtbd2UsAUauKxAHFeni1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=oC2iuJ3g; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="oC2iuJ3g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnfI6alb1zdO9UwzvDQAaJqTo5xSOpL6+fWMSsAObczNe9TEeh9V4BT8aBjOpS/dJx565VCEA9ycmSLew+FfE+SPGkdN39ICxIv2l7YwefTfE8tsH+MKGbeLAMrwxkjMJeZbapZCjAhHQU7px86gW/uWAKaEgfdFT+DDo84jzr3G3uLRBNkxB+3T2wjNPXPY8C6z4YRNCjgXvGB5Wbdumm7ImDrvv0ENx6aJannHhKh/HJS0Wx/LOvdLAO0OJE/RDbhEgyPsgG4f4U2Qadd5fLpP0XQA1Gn6OA1eVUO5s5XJE4yvgwDPyleGET0f44XuI7t4O1BXgmdZwSgg5i2MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GkkFsZW59sJTK6EGY2uxJpT8nXaI+CiLkT9stiTrRY=;
 b=q2Jh4mNs4Ih5L5AOTIGvndEdj3v9XHOqrP360gp4J9GeavbnyoJk2CGyZ4ww7/FBK3+IqMCtcYiMXSQqpkBJ/liCSN8zXh8zszeTTnLXkY+v3RwlNQQp5HNolpsJDtMyyUIzTUb0zTUiglzc6QEkQGQVb1tu7jOfmmp0DEptBGXWNq01flXnJbTN73i6dwUb1YdIbk/ubrjFwpKuq9RX5BJILgBJ5/NXoqGkAOTQ2gBTSdTNmp0qzIm91CbL0v76JZn6WPIiqdgHV2nXh7W4LbVnUWE/CBtiNJUPGc9iB17cefbBw/yxhVP8sADFDfPEihAcMenLzFuysq0XoUi38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GkkFsZW59sJTK6EGY2uxJpT8nXaI+CiLkT9stiTrRY=;
 b=oC2iuJ3gQPnlhwX5WwbmM7bFiiS4QyEPmDO5U73/HpeWEzv5WuW43OG6tZnWfYBe6UQUhLpzOWT0IaB3UlTIEoTCk6wzktMARFuDcAHrH+15EBUdMV/ykKuLaaXGCGlUMUTZotpANOiUTxP8BCBqVTIk/mVAyxW2foz5yajpp8Q=
Received: from AM4PR0302CA0011.eurprd03.prod.outlook.com (2603:10a6:205:2::24)
 by AM9PR03MB6961.eurprd03.prod.outlook.com (2603:10a6:20b:280::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 08:02:31 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:205:2:cafe::3c) by AM4PR0302CA0011.outlook.office365.com
 (2603:10a6:205:2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Fri,
 27 Jun 2025 08:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:02:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:02:30 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 9/9] tools: parser: fix printf format errors
Date: Fri, 27 Jun 2025 09:59:28 +0200
Message-ID: <20250627075928.19788-9-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|AM9PR03MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 108267f7-32b2-41a8-3ea6-08ddb550f73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0eTA22W+mtQra/oIQjyqmZ2cw2DidjStmmE8x9068Z8v1Y5eeU99mMi+wb8m?=
 =?us-ascii?Q?Mkyu0HzPIlb44yNhiEAAmqtKFWS/VWOz73Or88tHXo7jp7/uq1mFAWdlYNp5?=
 =?us-ascii?Q?7pj4xyXOJFSO7Jk5nRn+HA3YZCBYxxoH8rQNsX0bv0pgRAfL3TM2YS95Rd+L?=
 =?us-ascii?Q?mXKcSn9ifrtvTOMchCNsUgtcEkA3Z2B1Zbh+XEd13eQP9QmNrhnUq+vSboKg?=
 =?us-ascii?Q?+P5JnHVHStKrUEu4J/N8q19QJP0vKa27ky8pcMtSCk8cda3r634BLRPdgC14?=
 =?us-ascii?Q?SO4qlzfWEqcHfv47hy3S2kJJpKiK56Oi63QEYjxQgsk04oJM1RpOPF0Np75d?=
 =?us-ascii?Q?LPFg45WYd2UJasQB0sYVoM8jAxS9jr7VKTIo0gmV1Xfpfhw1CbWN83XpUDy0?=
 =?us-ascii?Q?zS06zEIWDjgmCH+UNhw1dVoVLW3Y15T5SlzyUKpejvD936aAtrn7FFYNzoGq?=
 =?us-ascii?Q?9qbvANHh3xgMtlgLw9AyOw4R4QlvT56AYdK/FnPoDXwnxxxOyh5ERf2SS0nd?=
 =?us-ascii?Q?JTlqNoLYhMIvZ4qtBEC2js6zIMrCZiznMNIi75EtxH7rkpfvPlm1GghFop4q?=
 =?us-ascii?Q?zcMVB1SKylWDO/H8ZFDrZNla+cGNkEi1CfTvb632snQrJlPucghga4or8YuL?=
 =?us-ascii?Q?QMEwzazWJtimfKKz3+E1dsBaHx9gP5Rw+hCNg8w0DHcKBWaFBPg2GJnDPxG5?=
 =?us-ascii?Q?MXUw0FXk5tJHuN6128v6lGIZMkgG/xP1iG/gZJ4zedEUUWquYyJXH2djO+Vn?=
 =?us-ascii?Q?8xd7yv15hR2nllUe8KqlUvYmxHY3qgSQy4nQGyqnKXyVvLORjOBJvAcbxdE9?=
 =?us-ascii?Q?3GMUv1wWDpEBSZR/ObkTli8NyS0VsQHcr3R888vuqhJ5AWwLsb1dANOUPbp7?=
 =?us-ascii?Q?8vEK483rj4pdJpsWI2x9qX58Xw6P/H5CVjPPdH5/qNZfHOx+lv+fFD+NNoFf?=
 =?us-ascii?Q?zq1FPFn5ZDuFapY5Ey8JvEJ2ogCsv9t82aeXYgPz+0I1tsaeeVE+9AeOHC4F?=
 =?us-ascii?Q?YDfUg0p1jqwfm592ygrEKHwcrZVLuczeWaFijuKVIC+lR5Nz0gjnx7aGdQIo?=
 =?us-ascii?Q?lzDjWfvJMQMcTqyXqXjyk4Z+HzBOZX0b9GwoEtqHds4HOXvy57om9TprMUjN?=
 =?us-ascii?Q?zlVXN4CXQN+pS1PVTWC7S/3S+NVGldi7cdDz8o5hTyR7OIGrWkTO01d3Ux3z?=
 =?us-ascii?Q?59QtO2e89F8+Al8+y30C/XsmxtwNCDsYaIyNZcv4984yhJA+6A9+BD1D23oT?=
 =?us-ascii?Q?kTvpM7Cxtn5RobfO8WAbZGlTFtFxPvkvZPOz+okTc2ONGoWJ9FwTlRH/RvZi?=
 =?us-ascii?Q?kYKCHNhHy4sBtxPIC2SzCa9JSBDdf9FGyB1s/0JyTlt+Key3+F1vcl0u8I95?=
 =?us-ascii?Q?WNekt5hsCyNKCekgZ79LlZR4ST6rGuazftK+Em1fsKwCsvNuIt3TDNpZOwA6?=
 =?us-ascii?Q?zXC6Ncon+VQQ+vcL+EiH7jLW/wcxedLOTnNwlpOoYf0RcB/O3mX5uSmTuL1r?=
 =?us-ascii?Q?kigFhFjs6E8zIn3p6f9f2qKGdBx6ooR6coFu?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:02:30.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108267f7-32b2-41a8-3ea6-08ddb550f73a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6961

struct timeval members can be 32 or 64 bits which results in "long long
int" on some platforms. As there are no printf conversion specifiers for
time types, cast them to the longest possible types.
---
 tools/parser/parser.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index 5f65f1689447..cd6268acb893 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -120,11 +120,14 @@ static inline void p_indent(int level, struct frame *f)
 				struct tm tm;
 				time_t t = f->ts.tv_sec;
 				localtime_r(&t, &tm);
-				printf("%04d-%02d-%02d %02d:%02d:%02d.%06lu ",
+				printf("%04d-%02d-%02d %02d:%02d:%02d.%06lld ",
 					tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-					tm.tm_hour, tm.tm_min, tm.tm_sec, f->ts.tv_usec);
+					tm.tm_hour, tm.tm_min, tm.tm_sec,
+					(long long int)f->ts.tv_usec);
 			} else
-				printf("%8lu.%06lu ", f->ts.tv_sec, f->ts.tv_usec);
+				printf("%8lld.%06lld ",
+						(long long int)f->ts.tv_sec,
+						(long long int)f->ts.tv_usec);
 		}
 		printf("%c ", (f->in ? '>' : '<'));
 		parser.state = 1;
-- 
2.43.0

