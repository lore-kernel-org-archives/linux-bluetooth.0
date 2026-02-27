Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C72D77E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202843; cv=fail; b=Z+ojax3tPTkacReCwOya/YiyBNFY2yILo7p/ll79b5BkvkSZKBAe8BD7hwDADCPd7Z4rqoA3pGVAkuiT2e71uJBNA8PIlelN5lIxW7npDHg/Nz5hPR0Z13L/0pqiomJh0K0OqXmXmsyshtWtNkyFhAiSMSncF0iK8+uEh34RLec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202843; c=relaxed/simple;
	bh=UUXOm5SokxE63GdHDa2gEFuPFvT01XpK23G1BytIziE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxwN2k1kiyhV1t8tF6C+GF9QY3qmbHOU87E1eA2Rj63tOCn4xpeW07xHCmoynFkG+Chjk25bzELP5RHJpNzxagoP3V+gParXyQ9XY1h/Ev+kc/OepK/nRY6BsXIHWFeuJi1mR2UdyNQpgzuSICTpdhMNLKk9EW9Tfz2EpUzCTa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=js4UdWAD; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="js4UdWAD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOnxpDygkNugF0Zjhj1T6n2EXWpjRwbdARncXioCbvZeM6uXp0UmNEU21SN2nkgzJEdJrYdx+xdGmzzO8PUb7r9qj4azCe4wN+xDdw3Y7643kRsr3Ip56xV+MNC4EbLZxh12f97BU02hKjZoUu73FPf2dek+uvSGYNNuZ1sqSbH+mIXmvyckPmZyVElH5hhfMD1VFaa2+0uLCnefM3vuKo1H/udHH6TrJ73dzNC96JQ+02maqwmWxGtvpy/kyKz87VWtuEjzRZMxmkV3+uT856yarJ7Ms/5Fgv+0r9rLhZxPd0GYIJvKThpiXZJeN4JQCxKyKDMtkg+Q1luxDQaylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLZ8CB+X/DzW6jaFAkMKa3LcMAu1GFDG4QIuaR1SrnE=;
 b=YXMgiZTk9KpLco0Qk6b7VKPJUfcqNCh8JoCZYrgPtjgTSUwPOV1X+/GPhTTA3lYuQUtZGMWinJufAbkpHycbYzEGssj/baEovleRnmtX7fXNztd/IxrqiAjdeEBEK5Wn3X77HuHq5/XGfZPnHNaGJWrD8eJF63IdSrFGaI7gxjWZe8KXb9mIGCQm63p2NRUGX1heN5RJnY1U1hqAmz6gCqu8B7rh09Dcp0jKgM95ZOcu7z1i38xs/o8GglrBWn76cKdm8xGM414hXLXEUHMynmbh+RoNSyQa8ksE3+eFAD0CjFgmE45CZiQ0l2Q+KnKPff3QLsuXKLGxPQ5LElgfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLZ8CB+X/DzW6jaFAkMKa3LcMAu1GFDG4QIuaR1SrnE=;
 b=js4UdWADCXGvt/l56LL1XsvSLbZqAGNTRU3cVpk9SGnC+5/aLDRPlbbbV8Z9gLyNgGTzL97Lf7Qa1t2EAz8+iizAmzN1LHFlYub5oe/H0K9ZmOavw/MbHXgE2X0WhvvxznDw8QviBA11fRRtSLMnsmBuKEwD4IhOWHugfeegVWA=
Received: from AS4P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::12)
 by VI0PR03MB10686.eurprd03.prod.outlook.com (2603:10a6:800:25f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 14:33:53 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::95) by AS4P191CA0029.outlook.office365.com
 (2603:10a6:20b:5d9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 14:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:33:51 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 15:33:51 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ 3/4] client/mgmt: align implementation cmd_io_cap with its documentation
Date: Fri, 27 Feb 2026 15:24:24 +0100
Message-ID: <20260227143242.5204-4-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227143242.5204-1-ceggers@arri.de>
References: <20260227143242.5204-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|VI0PR03MB10686:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a01849-b3f9-475f-8fb9-08de760d3a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	d2yFY/NmAKqxMnR/W8TA2h2xG6NoB6XBYJIPDC+1pNhCUjIkSA1XBIgBZYHtxN3yK1Quh3408Pj89fLRle/VTjLPqEz1+MueQZCe0Ay4BsUjeb7Y4vXTtaMeyMnES3QNuIcwgjv7CwQ878CRWbVE4uQhIISEW575K127SBJRk5ki1bSrcn+4yg7ikWCoEHmb4wA68RjFHHH0yj2B0Ot1FELfB8bAlKZYNMQB9KTjvuqAIpbm485AVjMjjn5ET+INMMWReclIAeEBC4+93HsWrYGKD4xF43oMdarfEd4gcaOJ+ddgf5H6uqxgdmsqWfWarsT8IoLLBfHJmRqodQ9xiNiEAqn2xsfhM7+hQJQ6pf5xHvdYxYMQIUpAhpBTAazjlx2kFv3/lrmaE2R+ZXh29gVStW2CklqwFT0wPcFRumtvsHrCviRAc42gpQb3lujOAIKU7QKNP5tU5BDXB9JQ8DDDoWqAdbeeQRPIYWf3TdX6UCIJjkwMrHn6bJcpsShMlygAEZaypZwNAqn8tpjqKel+HWjh+AHep7qgtZ9I2VelfkpkrflPUPmNLXvGxC8Ol1y885HKPqxzl9XGka85qJcurMcq2EaXKz2p+jyHtOwWqAUcY28p5mX4bceT+A4oE4IXxuoicSr9NYdF8rP5rS9oQ3Z/Xlr2yP9zJGY+aFo5ruU+K5YzAS77AHsbaRgR4KIpFPqQLmpZkIDrc68A1KBSz6y9sAuCkpW5wxN1+jYGJrvDJhjl6JQkAxdZr9X1IlgHPBdaJuEI4qRwI245DK6t1s45TBnnxvbbQa4jPqIBuSaI4xuuW42esH2aXv+3I6hyBFwprnBLq1VHSHCPpg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RgL28BrMBz9A86ySOHMoUprmMO5tLE845LEwmtLaIMQfkZTsNfjSBErhuf9dn9L9u3luLce+K9eGqRx3ZSLFI/CFzg2V8A3Yr+U6TAFT89gWul+7CXtGl9MREfTVeCksB83KPp4TUvwk1g4+5qQlyDiVWXqvjzK5+t5w7DMtq3hRjq+7NCG4JqVSDGeagfppi+tDMz2CgCS/M38x0rj7oVTnH5ry06ZcjwlrwgklMJQ+LULyPKuLpLG1mC3kLcwUaxjjp8c8aDZXq55XmSehyGikpYZyaFasK3IAzqn7HZmYum16zrCarh08rhhTFFiO0xwzZ133d4iXyTEmzfuePkZFDNZy/IgRswb1Vbql8PU7qOtrAqDjqZ4NBqDmgwL5JT21PfvseySx9tnVuM2iPoZPsW7IW1HYW2LgFEoiNkJhQVUW20ZPug/Myclzy8/H
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:33:51.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a01849-b3f9-475f-8fb9-08de760d3a6f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10686

Documentation of io-cap in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().
---
 client/mgmt.c     | 18 +++++++++++++++---
 src/shared/mgmt.c | 20 ++++++++++++++++++++
 src/shared/mgmt.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 1d3a842afd55..430a96a9e4b7 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -4226,14 +4226,25 @@ static void io_cap_rsp(uint8_t status, uint16_t len, const void *param,
 static void cmd_io_cap(int argc, char **argv)
 {
 	struct mgmt_cp_set_io_capability cp;
-	uint8_t cap;
+	long cap;
 	uint16_t index;
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
-	cap = strtol(argv[1], NULL, 0);
+	cap = mgmt_parse_io_capability(argv[1]);
+	if (cap == MGMT_IO_CAPABILITY_INVALID) {
+		char *endptr;
+
+		errno = 0;
+		cap = strtol(argv[1], &endptr, 0);
+		if (errno || (cap < 0) || (cap > UINT8_MAX) || *endptr) {
+			bt_shell_printf("Invalid argument %s\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = cap;
 
@@ -6149,7 +6160,8 @@ static const struct bt_shell_menu mgmt_menu = {
 	{ "conn-info",		"[-t type] <remote address>",
 		cmd_conn_info,		"Get connection information"	},
 	{ "io-cap",		"<cap>",
-		cmd_io_cap,		"Set IO Capability"		},
+		cmd_io_cap,		"Set IO Capability",
+		mgmt_iocap_generator					},
 	{ "scan-params",	"<interval> <window>",
 		cmd_scan_params,	"Set Scan Parameters"		},
 	{ "get-clock",		"[address]",
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 930e70a094d0..f56bcee14059 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -1054,6 +1054,26 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
 	return mgmt->mtu;
 }
 
+char *mgmt_iocap_generator(const char *text, int state)
+{
+	static int index, len;
+	const char *arg;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((arg = iocap_arguments[index].name)) {
+		index++;
+
+		if (!strncmp(arg, text, len))
+			return strdup(arg);
+	}
+
+	return NULL;
+}
+
 enum mgmt_io_capability mgmt_parse_io_capability(const char *capability)
 {
 	const char *arg;
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index c1f62ebb9c9d..417798c1718c 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -101,4 +101,5 @@ enum mgmt_io_capability {
 	MGMT_IO_CAPABILITY_INVALID		= 0xFF,
 };
 
+char *mgmt_iocap_generator(const char *text, int state);
 enum mgmt_io_capability mgmt_parse_io_capability(const char *capability);
-- 
2.51.0

