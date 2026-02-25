Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC63DA7D9
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036264; cv=fail; b=mFpj8HBXEhOiFzvcN8llVe06Pq7V1fkFZ0tSUl27r6XG9iPWxVtAzUWN6N4WRXQXdY6fWdT+osoiVhAYUHIjexyYYa22Hg8ESkqXlDoFntksk7iLV3hhkdhEia0QCPqK6jkMlnJapT1NEghJ4UsSogg1DYkQBR9NvWsHjMwxXMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036264; c=relaxed/simple;
	bh=3EkkC0beJXhBVOfjjhy2FuhvHjX9nxlxKo8DmSA55S4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/Pk9O4iNKxjF0X2IQLBl8X9e8/WNiJwfKeAXrsO/PMeFycOZqQ1y3B0I79diiUNzesdkHBtZTN3D6+goBVijO4v3KVKixwK+TOQ68T+p5MIRjGjTa8dzUL3yrA+rYfKz/GkC2OkePdiUAFnW5/btsp8DAvCNUY08bZYqK7PiHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=eE5rPNMC; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="eE5rPNMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orCHHLekycoC7dfb7zegNBjAbwZR2SooGUglUDv6Zjai9+Pa8I8cBbuuMQNmX1QkXazIraM0tED5FCGRxT0kRHLWw9Aqj0VRDrk5S5GVknLepe8uFRUI+HQQnFg4iktMPVJcYBJO8a5tjC7pB2Q70XPgAqmkgnGxkPuCm5XeOaDZvumytxBB/0edFmWEy02qWgVjIYJoFCj5Rifo3QHExpwFIiGUt/JE7FRaYtjNy73Lpw2q7dVMyjhVf9Oh1tckkyWqYXFZxfEner2jq3xcMJ9AvoFwgAM45ybobyPRugY0VkdAbeJdAsK83ldzrhQrPtEgdOXPYW5mAbLFJwn2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x8AU32bJB3yoz5ie+/4w9nKaQfVc8dQS7x4iVyuED4=;
 b=G8AGL69sKsR/jO0tV9YOpE14xffVm5fKs1g8V7hVJRhEOHX/it+UZg4u7VurkMhP+AaOlz0lcZbZlLdx4Tm2gGBoiyBNed5y0GO8SRt4fBv4IOtJfLetN/qANHFKn5ptKM9GILyv8SYkml5D28IHxLBBS7OoPBrr//olcjck92CTcSk0xl6Pno5aq5SkFZEBWFfAcEBxZpifbegHT8GDg3+ffMfBqpK7lW9TVbbrSMF1Ch/CMsyOykyH3pKY/zDX9cLgSlBiwCC8r9Sk25sIhE70nZ/Th+eTn2tcyXe8vTsBh6pjB6epWpa9aanNno1GEWcRrON+ikfz9UK8I6B5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x8AU32bJB3yoz5ie+/4w9nKaQfVc8dQS7x4iVyuED4=;
 b=eE5rPNMCSP/Y2JRblU6TlvnrfL8kJUtcQCtew93aNrg5AI4CZp+jllwHE07WlnFy7Ql3JxytsQWDIMCAkrDF2uMP759vJ4FxnIHz1Pe6aFm716qPv711Z/qxFizKYoIv5xj7oRIw1HXBMoJCtG1M+dVL/0EYNpwOgEnOga0hBkc=
Received: from DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) by DU4PR03MB10911.eurprd03.prod.outlook.com
 (2603:10a6:10:590::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:17:34 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::c8) by DB9PR01CA0008.outlook.office365.com
 (2603:10a6:10:1d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:17:33 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:17:33 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 01/12] client/mgmt: fix compiler error
Date: Wed, 25 Feb 2026 17:17:04 +0100
Message-ID: <20260225161715.20394-1-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|DU4PR03MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf20691-8449-4d38-07c7-08de7489622f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	b6c8Q9YJpaCLNfwkGHxqhOLBOLwKpfQnv5MCGQR7VrJJfqDOtMJQ9EYcT/W3xxHweQU3VDu+BJ991MvKw2SGfZV+zcTYcAU/9IWrPwoaUoMopQcztERj3JS5C08C0h4R0iwZjOXwJYw5qAxXkDhC82ft7bltZ57R0tl+T5lc64LBXn0wFgtAai/Dy8nyfwLImzB9ZqP9N9B10A6ho6crZSswCpg+Gpg8rGaANLUhoSsjCfdPLpEvnibDab2Ln6r38AAZFygCdrw3fawFYK7VlQa8AYGVdG4XJb2gTU60QtUEhBxPHgMCh0BzkOGxZa/alEJPxzCKCi43rwI1AWXm6meQeuw7WccGk4NDeuzBO0dbr3kLHTrqBTwBIlw7Ov+Ey4Qng/eDwk9rYV461iR2JSJTP17zNbbQrdLL1W/jY8in1aP37kvZz2BzliPm02mtmYrvboNklxU2J2yZSFQZmjoimwvmpH9+VaKb/RjZt/wSWpKthiz5aEJkZkDu0qIi+zvL9iIwJhIHkfbWijPG9H4Yoiufh2W8okmP1I9q73w1lBy8EHlcmqLPpeDhn80GoCsWDsoR7lIrNIea5m6kzhbbI8nIA3vsY9YGlLLJ5K5qSRBC2vhpnvHG+/qW+p4IEiFYwivlemZO21QSh3jsy3CuiEZOdgD/2TlshZiMY3CNdHde0nbxeOe3lrCoidN/ShoTuBqctRK25p8272e1gGX7LZGDIs2eGJnPs2g9QwSfqLzdfeGs1O5sG+fsSJTMk7YgSXnHA+boJy9A+30gkHd6j4EYE56PMkc/1FR5ak6dMoYdVC6bVS3EDuQjM3cYZr5AfoHeg9Nw+jf24B1EAw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	htrl4NLKdVGEtbPy/8zxfJncxiPNCGobz1V2U9GJfc0JKtUTnFXUTQ98hNf55mde7ex0V4WYSbhMn1FbTC4Si8ib4mOQqtDxjegXF/QAI+mnye+YjCc5jViSGGuDHx8oLFS0FKg1z9twDH3+lEPLDpWIniv6IBfh96/qQkKU3yYKovv9eSy9S/5mRq+SPQQIWWfX+gLwpwqz4WiWb/UX/VjHwz3tIfFTjLWAatdYcEZtJ19uihN7/F1RuC11ijAa6T2rVIAkdRY3w+4sWLI53q9oSjAtxK6vTjJacH58/sInfth25d1VSntGtd2eSBsdxdu0yw1aI5wNTazm+FibLowiKYjWGAUIiQrlQlKH2vZE2m72ndza0bP8QmfzB6rE/7nw8gX7PhTmW3eT4u2bvSnxkFDW/CJILspuoN1ksovaZuXCXX7bIcco1H/mutN7
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:17:33.9042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf20691-8449-4d38-07c7-08de7489622f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10911

client/mgmt.c: In function ‘str2bytearray’:
client/mgmt.c:2385:23: error: comparison of integer expressions of
different signedness: ‘unsigned int’ and ‘long int’
[-Werror=sign-compare]
 2385 |                 if (i >= *val_len) {
      |                       ^~
---
 client/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 4e68547ed33c..1d3a842afd55 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2373,7 +2373,7 @@ static void cmd_set_flags(int argc, char **argv)
 static uint8_t *str2bytearray(char *arg, uint8_t *val, long *val_len)
 {
 	char *entry;
-	unsigned int i;
+	long i;
 
 	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
 		long v;
@@ -2389,7 +2389,7 @@ static uint8_t *str2bytearray(char *arg, uint8_t *val, long *val_len)
 
 		v = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || v > UINT8_MAX) {
-			bt_shell_printf("Invalid value at index %d\n", i);
+			bt_shell_printf("Invalid value at index %ld\n", i);
 			return NULL;
 		}
 
-- 
2.51.0

