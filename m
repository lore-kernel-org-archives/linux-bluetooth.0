Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845B263C7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036434; cv=fail; b=PEEHnSyw5CgDGbtp2AKz4Pm9G3O7qqj8WSTdv+xMP8UIkayXUADqhQHgKaewQmJEZFoJtPyFydgnAULSROHDKx393rSBhvRX3pbeySiYKnRFr+iUvsa3jWumIfnygsyge4hz6pnF9D9ktRjWGifhhDFBsqO7+6mQmn3e6sWr7h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036434; c=relaxed/simple;
	bh=C5UkRbGGG8C2Av78IDRfesTg8k1kdp4pmP4ZrS3FPRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2E1n18VWG/G6qv2WxVJXcvhr79fbvCJT0DogLiRhhAHBIgmBrsPoNMzQlqQYQlhnxYAN0WtH+AMVFTPWOT13smAXAfrmdoTvXFHXUl9+FKOwIqfkkz7lCbEVehWHo2HVNYjtAWk5IsOlYHok3uDLMUJsX2xQKrGAPNtusNGz0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=GkUnTcYY; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="GkUnTcYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNuKe9LDsjQThnCab7HzA7umKsk/cS3dZd+HnwE9TN92pWesCn8kVSHR4+rXM/KOszGLyAjTtIQQCrCJEegiBAO8d/IHDQXw4bg1ODNdYxYuY7iKGDM/XTTpgAzvufRmlDTcOg0NEMyBdLlStxKggTPu13QaTsOuDCEphhYJPEwqbMiw1NfN52l2AinBORX/aE/JxtjwLheH31Ckv5yAPJiDX9fX3HlBB8otZUXbR4F0/w+m5bjapp4a/y2wksUKepP4X1DTjhViIkpBpmoaM42FE97JRLXkePdnOz9x1iWJL0gDWKmsppmmuXS5XheVcA18fFBoYFL9cKsL8+zjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeRg0uK7kF8eM6aiMeJXyeon8SRWgR1E+3oMtv+nP+8=;
 b=F6mfDrtjMG7hekxnXxOBIdRwVOorU+vxHbmUDjn3HB7HkyLM1whAmAywzNI+g7g+GaTxHD4AF0q8mX4ZishxJPW60YhVUcnQsenm60s8RNSp1EZHZWEZzqm7khiqRCtjouEJugxnj1zGvGm9DNqosXvN7lWj28Z2eX+p1OMjuC8LS55nqeUW4N17ChcLGRSUm6P62847vvrOukblbzqEbtq1zQte1K45dLK8vfYK2xdCmlEd0tYb7K4kfkoTdB7AM6TswuvtTRtJpcT9Ornl08EydP+hvDkz9RX3sdb3/dqA11ps4j0LT7bzXvmo3HfzlN3tGmrZscraMvvzREl0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeRg0uK7kF8eM6aiMeJXyeon8SRWgR1E+3oMtv+nP+8=;
 b=GkUnTcYYIrR8j4E8W2UmZI6Dcj/IO2CskzLUJolHuU0LvlF+vF7KK4XmA1G2JbpmJbIqwiH62pcdstsSg1cPY1WIXeI6DYAWcdZr973bVU/tYESiJ3WSBEW0qqUWEMUzmPmmCVSSocCkwS/Nd74l+6tG4jRwxxYSP9UW3FK2f7I=
Received: from DB8PR06CA0037.eurprd06.prod.outlook.com (2603:10a6:10:120::11)
 by DB3PR0302MB8992.eurprd03.prod.outlook.com (2603:10a6:10:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:20:30 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::c0) by DB8PR06CA0037.outlook.office365.com
 (2603:10a6:10:120::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:20:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:20:29 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 12/12] client/mgmt: align implementation cmd_io_cap with its documentation
Date: Wed, 25 Feb 2026 17:17:15 +0100
Message-ID: <20260225161715.20394-12-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|DB3PR0302MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 495933c1-605a-44ae-5956-08de7489cb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	yHs2N2u8QP/zE+jY4pZwA/7Ws5Zxh5N7DcIypCseg8r2NTC4L9Q8hz5fmeWRQrj/tz+HIKx+3+T+SEO5k5/bmTeM7SGvirb85+RjjyrHc2v6r7VzMMDIB+VkgpH5M0royt6vBTdCMrKJJJFOsvPE7b/9ugDjA/UjTuF7wsutIQ2E7Iqm3mcd5eWYTVm+06TC5DM5NIr6vw2AUt7dWK5CbYZpHVIGf+6iBUuum860eSCx1jII+Et+1r98uMRsO5RY8qZy1hOW3kJrmwVP0wqkzq9lODRY0pSJChOj6CDZZOGAMUPlQ4ljz2iYZGeJK5HW1Uk5JgcJS7tM4LqsprrSzAIaYMVpjnmmspvIQM1/FHUhTaZtytx8Mc9ddiZIXhGjb7EQ7fmfBGp06drjOxVLLxqCctmEtxf1/Q5KK+Y3DPPJFU3jWXh/eA3CPDC6tclEQ+5GwFuHxYgsJCMOJulx70+jIUXUDAryc6ijV2PiTvxerajUIzqqiSnmE1ZlpEK3AsmcCI5m/bxIIVqeBbBERohKtznbSwG9WbFDosJuiTSZX2sv0zbfM3ND3uZMk0bO3o0Uq1MGQcyR+asgQSsRyfcx9ep2jM+JjrBEzvOTrpmGwxmFjIcp3Tz5PmRkPigWV3tFmCgYLlUcnUOmUCyNfWzekX2q99NwEmUY2ZuNTzVS1wH5S1DcmKfd76kiaznJxZawFpkFsTvVxZIweooloJZUk1BWudINmoANL1OQl3om1PmqGMMWYCZa9j6/A3pCYaWY8cVgwqJPYPFXXd+CKfwkqecoLYpEr6VZWxvd5PdQzZQl+hPeL2868UDFeNgWpedtTGpImt/L339DOkpEpA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bxprlZVcrtG9hgPm8eVvclN5IUCg/tX/VPfHchBbHGcpV/VxR4+BbCeSNWNSf1rDHvPtaSLhot/yAAwrP+2LVg3sTOO+QoVuVZGiH4jAFiWs0JbqUm+cAmerL4sAROpZGgB1K7SGiZ40e1Lw9f+AAGAKebikZo3VJiLC3whlBVCHWWlftMCq7SJo2y4CAtjmgaZoLdtWinFlC15qJaIxCs2TmfJgNZ1TSvOHoMH2RfzgqHXscsT8/AqGoYb/ouky2/XoZmWGgt3T3M21DqlBWZ8+oPs4b4AhGgRc5JA5qG7EynKPLUnXXIGL6yeOTMKTJ4mF0vu8qi3/T7Agw/ItVJZIA+QDz1xYYSZz+5YKLzcoOdSpcWy/BiCg2xkmIoQ7Z7rilGJuI/nHewu+vl92cV/ZudN2lF+mt9HLvL87j+KzW3UrE4ASXfTx5VBMlt57
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:20:30.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495933c1-605a-44ae-5956-08de7489cb49
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8992

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
index 300abbae1c50..618bd349fa1c 100644
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
 uint8_t mgmt_parse_io_capability(const char *capability)
 {
 	const char *arg;
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index a4c30075f7b7..58db09308c51 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -98,4 +98,5 @@ bool mgmt_unregister_all(struct mgmt *mgmt);
 
 uint16_t mgmt_get_mtu(struct mgmt *mgmt);
 
+char *mgmt_iocap_generator(const char *text, int state);
 uint8_t mgmt_parse_io_capability(const char *capability);
-- 
2.51.0

