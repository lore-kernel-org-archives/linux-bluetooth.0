Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F13D9047
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036309; cv=fail; b=jTcWIprSQqhBjB1UmNmzmzfZM4A/GwvHHPxbpzhLXJwAJ4ekg2IPJAZXtjpM2WsyMlesFiPzOb6HmVoklBhLtxadCKU0ILPNWo04B3FmdxYEeeGRxFHDDb/JQGQmF40d4QRsukH3JFonzbVTC+eRr0T+Ri5fAuc7jqfX7hVvjEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036309; c=relaxed/simple;
	bh=GcstEOQ2iNGqxbHcG/1nEyLc9rEI6hyR1TlmZnx7oRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GC0I9cDDUJftMO2gOSGRRBTG0GQEfKFMiqWlJ2AkS8s4qnDpd5gJ53648oH3gzeez9nE/z1iTGQWwXR3ESNChBSTDjjtL4DfHg6G9MKOJTxlNEIi2RXhqGzWEoR92lZT41ScVJ/h0VTsU7OD2Y0Y0bbQeTdoVU8YuuD9va3GDOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=f3sCIInK; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="f3sCIInK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1ONVG7GVn9MoW+GuZ8HQJxOeZQ2HC3JPErOcOIjF5nIRq9ewRkeFZQthrd0f0BM/DLNDYwdn1fYQ4UBLPha33m3Wc6X+tPPi22MAbONJALvZFpva5NI2HVn6coXFiXVsRwpJTa59DHYJi8qGwBHMKLFSkrCrQg5YHZcaAjEXsc6qEzJFboPGpmKvJmnI7BUd0VTTdZq59MEake371W/8vPAsUlVnxzOpwujz3RAzKEBG7KCzxcPiluvB0uot6REsg8Lq4tbY9q9/SWmv54ix4bVYU2XWErMETQ0xTuI0+oK2IqnRmuYYiW8sGHYk81gGrLg70uQTcyUqW/lSBPi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRoB2KoWXLG726mPzeIxHJNDsaQqsYM8nelvrd1Ki5s=;
 b=p0xJEFzt9f4KpPsz//VK29udGDPKCxE3zg/QszroI+VYM1k7nBnVEfmnx/YJVSxTMlltHx30IMpgyL3/EGxhXslhNuWUE8jevtaVBawyNiS53D86iiVEUiUNlEBkbX3nD6d8+XFZTn7s0ZTcv5ahFdBKd1g7Fh2MxVNYPL5HchjN+ucVOxglSyzUUIsPks4GEB1KU5kH7cH/8Pdts4GHYNDZDdRfLkFuDqeO3/aztJoHqPflDKgXu4NllqqUuZhA0xiuiHYSFlaEQkiWQkK17EEhuZwgPMhcD+6zy9U+urkB5DvnhGjSJ00RqymkW7jM3Scbbxkc2BQ78mvGf2CzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRoB2KoWXLG726mPzeIxHJNDsaQqsYM8nelvrd1Ki5s=;
 b=f3sCIInKhd1Ktvrjrd0Ct+5rrgh4hUfDYAupJx2XPSvlDGVCQi56U7hAlR/MJFA2yRfKztTsDmOHxF4qeT0oU+qTMzQzYxRpH3tw7/bKlNiK+PH13RPPP1eQyLHkn2n4+rt1ZnfecqME0PTNycq1hIdQd81DshY4NhU4S8IYuUU=
Received: from DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) by PAXPR03MB7806.eurprd03.prod.outlook.com
 (2603:10a6:102:201::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:18:19 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::35) by DUZPR01CA0047.outlook.office365.com
 (2603:10a6:10:469::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:18:19 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:18:18 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 04/12] peripheral: replace ATT_CID with shared BT_ATT_CID
Date: Wed, 25 Feb 2026 17:17:07 +0100
Message-ID: <20260225161715.20394-4-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|PAXPR03MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c0063f-c787-4412-56fe-08de74897d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	/gfGEMBK1pfEzCXDHzmKb5yBcw5kHGHC67w41NLELSPaoAEKsGyenlIC+dhGWGoe/CUmGyi5kpUIMyb5uia4pYvjds1XOs4zZWLrhw0fbFk10ntK9bJ94TybB2/MahJHN08pWfg2Aofl4zk1iozOb0/stzlmjSyO7a4LxRRm6TFMMXkU2NrRTxwMMgR60KjYhdeIeRdqlO7sP80R2GSAbKDdQ7JHxupCGki0Mn7OGUu2DDv9IqrbhM531j5f+1NOFSRs3rz82+ozLl6mwcpl5Q7RnZxbor+UHuOh09uKdPgaTAYs1vH1X8ztKVmIf77yTkqH+usahOQ5JsGh/Do5LBwTVuBeAvwBmzVjmxCXkRyT0I28ltmVWL+PpMsnxOasFRA3SOZMNNTysbNr3sRmDpnlb2gY7YyIOfbipebjaEwOwPDbfGWEyz2tfrGcjN6cru/fiSZf+2r7tsZ3+ER1ZeyYcvlS3Gchp7C0pbBAb31JAISL2pFX5Z8NhYwslTZOugDu9NJfrpPVe+AxPZiJwIgd6NfYhnXz1hAjLyejWZRvOF6Pj0o8Tt1vX5Os3lnpkwrO5hV7iHI167XyVZ4+L8/e4mP02h7fcF5kdUYGTwMVo8HGggolfcG1FvHLZPQrlnrsG+pqdyoesbes0VziVCDJ6Je8uk17CpMmHRn9U7nlPleDqeKqSEbNK2DXm5bksUZjEtit2h6/XDR+DK3Tpy8iKKRmYmMPxeGS0pdRdbv9RSFCrcrP4WxfL2dez+y1yG5nHrn/7Gsmo4UpfjUeIihXjJ0SGCozCroUW75sI/cE3Q6ThsLvLfeYKskxtSG7S7Bz7DTY+ZCRPzlsjt5UKA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ViToiejn9B9Egm/inHG5py/nWVD2SLTO0iHyg1W+ctXgOXyw39A4rF+BgfeXw3vqtFgRShPHwFlP4Un1nGHe2AMqxRRrs7wTG52ne8UDO+p94pUjnJGbE0tI8d95k/7svSvd/fD0bvSLlLU8cntpd2LvH1AMQ3bgyC1oQCC8Jabj5mymSwBQ7LreJCiJ/WGT3Sz6JMGnWr5+MNneb7oMDSPqrKCl44SiyIONlMLlKhgf6ToRK6jtujLMcHkvjQsHwArut9N+0n/Fe4zE2mBW66al55a7H9y3kywN/T2/CjrIlKdI8uObzJrlSuV3UYZ/ZKxsjgkw4Oa4LcfIuvUd43o9/lub3ol6P4a/cdczkXb/98liHEDxkoD5yOxP6cPBwzXXRgHKLemQmzHEKYbRd9yOhmwyLuhunLzXp2UHf7ZEnssMtOZ7+1MtrGKL6lfH
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:18:19.3141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c0063f-c787-4412-56fe-08de74897d40
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7806

Avoid multiple definitions of the same value.
---
 peripheral/gatt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index e3dd24632c12..d1ddf0c97516 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -30,8 +30,6 @@
 #include "src/shared/gatt-client.h"
 #include "peripheral/gatt.h"
 
-#define ATT_CID 4
-
 #define UUID_GAP 0x1800
 
 struct gatt_conn {
@@ -243,7 +241,7 @@ void gatt_server_start(void)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
-	addr.l2_cid = htobs(ATT_CID);
+	addr.l2_cid = htobs(BT_ATT_CID);
 	memcpy(&addr.l2_bdaddr, static_addr, 6);
 	addr.l2_bdaddr_type = BDADDR_LE_RANDOM;
 
-- 
2.51.0

