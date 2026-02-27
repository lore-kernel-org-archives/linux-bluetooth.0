Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE02D8773
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202860; cv=fail; b=JWzPO07Ds4aX8hARrHb0mW4RH8Th06Lke0TXbzp92qo8AqD097TYswF5KBrQqFQS4DEqRs3jpOvcXq6MzkKvwR0XW2xJQvwG9bxKX/0sW+LzwCoH8jBWcP6qf/UAMqjNkcRMP6RkHiaTPd8hhsgQCtB63OjZDG3hOJA9lH9V/rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202860; c=relaxed/simple;
	bh=ok3ZQZ8PVVTBnNNLsPXK60x0Hyy8p7oS8JfOS1GWNgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onBr2gcI9KJ5UlG1DbxIbhcILFs8s0A7mEomIc9Qxp+8WcV9kQL0DcYQvxNMYfcCbAFOq30pEjPNGVr4mOBzP4ggm+UDO1XtMo7k43rjTAxzi6d1sUPhcE5lQ+M/VYDv5AYJGpC1raSVZWyqUgZ93MN/7hNcNl9i01tto1LR+yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=QUtzsADu; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="QUtzsADu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtEKaEV9oKwnYfPKA9fHSN6A/4EP4VUtYhNBzh3TKqIbVnWRApm1GAWH3g+sqj09zTaVccsaJ/mgkUkHVNPQsbxpFMbGWB15lXmBOxEJQ0SZJz/XeTlGIzCqVFFPU9/4DPkTWZb2idP20EPO1fT4CUaJbReMtTUA47xNVUFJEtR+Jtp8fUVFCz3tSInPJA5NuyqVkxSalzeH2RfzHds2NjkoXgzkSjbofrUAsErUX6t+RG6byT8+PjjYJpm8QMBUwUXgXHeQH7NmC4GeW4mrlGnnUvDxoA8Ak4CzeIJgAN1cN6Hi4oroBfFGXSUhn5uOgS5PSSevNINU3Me9005hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8XsS60216nv1Hl6mm3zFjVs2i/GT6+sL7l2EH9E9ig=;
 b=Jv1oQTNdHhnWBqWBpslvwrIp0q/8NuQmcj99WR1KqqA59pEaockXikibbHm40HPThYtkhEl+lB3pRXXgXd6/jLFOpKEPv5R5TVDM1Hd2BMsJ8xLnwlaw4OHdHbQwkxTU9X/BIEdTy1ttkLZGSm7SVfyvHeRaLHw+yMVcvWCXV9t7PKTxCFpmhmtLHkqh62mAbgT14qhdQuzlYfvgVSmFGuf49wE3h/oJPGj1M+qIBshtRKSrfqATEuddJ7hvio2Bnp6e0krICR3DetCe25wQpGWkgs2Pu7Fc4GPamMcfivZz9ykEfqP+W1++pKrx4Zwqo+Vl9zsDd7t2XcLH8KorsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8XsS60216nv1Hl6mm3zFjVs2i/GT6+sL7l2EH9E9ig=;
 b=QUtzsADuUQMAca2fWtba7WX/vAZsZMyjw/b2CU6vaBS+46EVzNS7n3zQr7RfgXh7LPuMoL94AxadhHJ2g3wn9T9vr+qOnyrPu7yq90VFA7KfPtLWC921xZ1tgzOotBEpXfJsVa2Als88ANtdUmDBVMD9C7X5DBPdQWhXb65U2js=
Received: from AS4P190CA0034.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::10)
 by MRWPR03MB11616.eurprd03.prod.outlook.com (2603:10a6:501:80::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 14:34:12 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::29) by AS4P190CA0034.outlook.office365.com
 (2603:10a6:20b:5d1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:34:12 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 15:34:12 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ 4/4] client/mgmt: align implementation cmd_pair with its documentation
Date: Fri, 27 Feb 2026 15:24:25 +0100
Message-ID: <20260227143242.5204-5-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|MRWPR03MB11616:EE_
X-MS-Office365-Filtering-Correlation-Id: c87a9a1e-d724-4501-c628-08de760d46cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	OSQ4le/1CKQb51eUskaZAmw5Jc2cNsF6kDovLn/ofm+QMqFQv+5mxxsDtMBZw4lKejeQr3NcrOYsU3FgcxIaZKOj3ugsujJ6DECcgQLPcYVg5e4le40l73YLfsTntGCoXLhoAcQiZjtN7EMO3Gei1vDzVPDWRoCJ83vhpnXw7xt8zg49S0T486u/Q0qejc21T/jSLRXi624fX6ke2tug/w1mci09uvSH9x2Qo55bI+rh/JAf7IT4Kca14+ywpO8a0e3neGYmSc5p/nyB6Wd2AjbYJ7lbSKBjpagzXP1a4D/WSXKZF3MNj4DQRpdd5n/CTKdjPklhT5Xdruhn5mNQ6Xtby/pRqQriWjPfwahee0ccAAjuqStJB4PS1Q4INxixy7vcb7uMr5fWuUcmeo+5d3Hmc1rEtKFfImjy0PikxhYP+ZarcF8vDh43BILeCStEdEKovLpVyY1EDEw5c/F1jx2WGmapfuR9gJ1Tjn60WtEsJ+q2S9b2BLn5QSA2mtAcxqa1SYjWFiHZOOFUnX6vBn9Hc3zzwdNICUMe+gpNO7AcOEYT62nw7KsqIKtoGHxP+BsXOVgHg19iHNQwf3Ivi0TBKOKpcRPAD4GwAzNITBArep78UxO3Zdz4w02whehrzoOiQTqO9Df/auep7X6momj4soHj3MTV4//9HmNJTsL1+Jhem0qoGOugnXZok1vjk4LesA8/q0mlygs/w5TKFMAAOSbRPUBB7VGAUOACzTB0EABm74xBDYNyqQBmRvfmEw3q8qnRP9QMcG4UIOJ3ilOFZ2grWmQxL8GNjyTxgtB1qOpxqYfhOyDWgUzYs4VM
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cr6M/0ifOjyIs5Q49vGmLMqkD+8Yy7rxW9fqj9HOIqZnUEGii8eMkPGSAzOop3KeHImFa1hwSzpeRyNPMTkx7ep5Wp7mWvtRO4PlZJbsh4+ivQjmaCE+Ah93uj9TkdsoY9Zwsttf1zP99uks1NHNxw/nLrxInR56FEhUHo4Tk1rHr570xZVe1bzOvT6Y15emc+rIAJ0EF7y320+uOmtRnLd6NeEqbxVLeIqXeLGGfNW1NLdTnZvyPXw4sAh1EtDMaHQDLhIzo3ZDJHAQG6NAysgNXtWa44DN+a3WQs4+Sa6FIw/0q0jwLs9FTYKMr7dZxd+7ojaSB5LHNLJfQBTGdVqFdyPpXxqx7L7wN/5EhEmRBQcYirjwdiUr44UUg8TCzBQpprRPubvqssIQzz5RQlZ920n4kTH89kPVzgtZjx/6UIXOiwXsMR5QH4RnsInM
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:34:12.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87a9a1e-d724-4501-c628-08de760d46cb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR03MB11616

Documentation of 'pair' in doc/bluetootctl-mgmt.rst states that the IO
capability has to passed as string instead of an integer. Additionally
improve error checking after calling strtol().
---
 client/mgmt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 430a96a9e4b7..71fcd21ffeb6 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -3262,7 +3262,7 @@ static const struct option pair_options[] = {
 static void cmd_pair(int argc, char **argv)
 {
 	struct mgmt_cp_pair_device cp;
-	uint8_t cap = 0x01;
+	long cap = 0x01;
 	uint8_t type = BDADDR_BREDR;
 	char addr[18];
 	int opt;
@@ -3271,9 +3271,22 @@ static void cmd_pair(int argc, char **argv)
 	while ((opt = getopt_long(argc, argv, "+c:t:h", pair_options,
 								NULL)) != -1) {
 		switch (opt) {
-		case 'c':
-			cap = strtol(optarg, NULL, 0);
-			break;
+		case 'c': {
+			char *endptr;
+
+			cap = mgmt_parse_io_capability(optarg);
+			if (cap != MGMT_IO_CAPABILITY_INVALID)
+				break;
+
+			errno = 0;
+			cap = strtol(optarg, &endptr, 0);
+			if (!errno && cap >= 0 && cap <= UINT8_MAX
+							&& *endptr == '\0')
+				break;
+
+			bt_shell_printf("Invalid argument %s\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 		case 't':
 			type = strtol(optarg, NULL, 0);
 			break;
-- 
2.51.0

