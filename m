Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021131.outbound.protection.outlook.com [52.101.52.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8149EC69;
	Thu,  3 Sep 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437921; cv=fail; b=Ahs+bSnJGZLfINmAVc+tg7Nsq2HWBfQopJxKdrGms+9nJ91iMkTKFVN4eD19B2uM3mrDlfTrHnp9Qazrk2DN8xvoNjk4BhY1VVZ7Gyrp8icJhorDM1mdwL7P+Slbr6UZQEjbUBBBnTVQC9IFkmrF6emECGG/M91867xZB1lem8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437921; c=relaxed/simple;
	bh=8JEhwe/DEKr0OdW2IYb/17QO6S4idamZPJpaIrGhpoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNdbzh27RP2yffyU4IgJRhHXsmIxFwsEqd/pH8faWQqAJkwddfUAeZeMHJjo0AGyjEQ/Nzn5OVJmhnI4GuRzJNPjBDCeq7Z6Y3B3zwtNpRX8Hurj6EAnLdpPLXEJGtKyL7r/vT1Bsy6QE+AG0+JN+2eupuzFmWufSqtlpyHW5Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=aKjiPDyP; arc=fail smtp.client-ip=52.101.52.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="aKjiPDyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPwsolK9ymd6UGniU7R7iRlrFdcmOeh0vJClJ67sefia+0MeVMVT3jRLrtEYz6+QrBP1X/1Kqv5TvNRt74HLt5XGzxedT9tmXbfON3HNWWA5Ck3tsoWR3QKZizYyHlHpwUUBny7P0LXcbA6ooykzgLf1ETejenBKS9YrZgFkxRj2Mw7xiLvelUTUz34HW11eP04sRFxLHLRoJtswcoHl2i/3Lz88PcuH7GkrmMiYH8Vvo9OzO+M5tbK4fOWXj4sCS3fqCrJJxpSr0Xgb3TD5pYiz6iNbtIXv0i1c8TCDmqmShA6TPGP7/IPTX19IGMmsRAj7ePf/7Cz3tCOpKwYl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnijuNMnWdsM4h2IqDVU/CdoZ2CvKVkuzFDlljVBnmk=;
 b=mchs1MJimFamZnUnEkcxoNMtTymumDimVO+2Ooh0z+iC0Ali3wJLx/2/nqXLe6Rq0XERZjLHNpnweuQywXEpaa7Oo7p/elIQRHyjnQ4/j6s5BA+zrXrSjkrzULIQnuLZhWOo7yqk+9ae3XtMJ3K/PqTyaisXA3gCrB1lF7EXPnbefNyYOA/k6rLaUA4hSOy2s0jWMI+Rbd8SQUH5DaJwhD6+Ry20qi2zzpRYKjvA3JAZ5So9r0y+sELe5TDL6ive/wgqEwX9EFfvARe/a7NtDofI3HqSLj2KU2wMnotmWSqNwhPk3bMjYsmerqJ2GmOFJ000FXn6E4sJV24lBXPp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 59.124.75.172) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=synaptics.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=synaptics.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnijuNMnWdsM4h2IqDVU/CdoZ2CvKVkuzFDlljVBnmk=;
 b=aKjiPDyPVzx8uCTA/KiimQJjyLtqFc6+dCBjWkRrdpvdIBL6w6NExqrZQiKZWKsF8Djv+8dNVx8tnz56JzArvNyRTRGTuuolERLso4QTHRjODDbcLnXlQkVahNqK5zWkhnTiZ4aPyAh6DLLI+VPj4FDMf4ZUraeKxTF9K6pftCAfylYdEGhhhuOybqRxQYtJi7SdXc2GKg4evGVDK0Ew/Ve3ilf1LA4EsE9ARh9qgOGqNDcNAmHrQ+gwaY6a+wHdBRKZ9YQCt6Z+eDLALrmreiJ7vXLzln63PeuSj8hhJhi0YDHws/ant6dR0OYSUXecimoIyzQK4prvKjS4vLVEEw==
Received: from SJ0PR05CA0195.namprd05.prod.outlook.com (2603:10b6:a03:330::20)
 by MWHPR03MB989391.namprd03.prod.outlook.com (2603:10b6:303:2aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 12:18:34 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::81) by SJ0PR05CA0195.outlook.office365.com
 (2603:10b6:a03:330::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 12:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 59.124.75.172)
 smtp.mailfrom=synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=synaptics.com;
Received-SPF: Fail (protection.outlook.com: domain of synaptics.com does not
 designate 59.124.75.172 as permitted sender) receiver=protection.outlook.com;
 client-ip=59.124.75.172; helo=bt-tpe-server.synaptics-inc.local;
Received: from bt-tpe-server.synaptics-inc.local (59.124.75.172) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 12:18:31 +0000
From: Andy Chang <Andy.Chang@synaptics.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <Andy.Chang@synaptics.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Linus Walleij <linusw@linaro.org>
Subject: [PATCH v4 1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
Date: Thu,  3 Sep 2026 20:18:23 +0800
Message-Id: <20260903121824.3080796-2-Andy.Chang@synaptics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903121824.3080796-1-Andy.Chang@synaptics.com>
References: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
 <20260903121824.3080796-1-Andy.Chang@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MWHPR03MB989391:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05310d7a-87e0-454b-f885-08df09b57931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SndUSwa2uMoWWdYCOSxm7hkuDmT1C1jOAVxF7M/INOqOP/Zf7WuYBolJ4PY3UzVnAmcH6uX0lEoCIw9NnHNkXCCmmPtJsXB25tu2m/gOJGXBdV3awp8lAUBKED5qnWfos9cNfh/1M/R/R16udHgJ549K8syDy6UGbPSlUbna0HUcreyqxzzyV3GwbQ1BQqDILMtn3Xx2qUprL0GELC3mwm5FGa/ACR05Tjc1IdMglvLl5AJOhfUd/Qp8S3kSKvlIFxmD21a4RUiwFQB6bZ+ALuqhFYyG8xQPU4Js+u5CXPX4gqFlUn1/AJnhsx5f+XYDiE8alNUIvWnd4nvvL6uRPz3NmEUVj1mn5JTCRwnP/qGMMeCw+7Rk1WE+uA9YS8HT7rOj9ZpwXwKD716ZpA2UckX9S3wkvq8TajSS0y74Qdja1yvE1NVj4/P6mEa1PQOHqcmZ/vEWILklHD5PhFtWB2kExbq/SwLSAJduuLdrYWdXbHsNFNOAmlejQG8iYwEx+8sl7bkgI66JAP2PDj3381s8Y9fjkdPr3D0OpiPnizYa+rqPloRECxHbq5RmgleyCctXkIq1o2EHdXFsSY9lTYB0sI3Q18iYqcjuWUBW8lJmNI37osvahlYrjRxGO9howgti1xLW4nPEtubHssoer6jYt2xbZi88XQ3TOxZ7Gmkjcd4gPdgA4o9wWUZ3yqQKFK2din2fy/CtYuQfr+XYxg==
X-Forefront-Antispam-Report:
	CIP:59.124.75.172;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:bt-tpe-server.synaptics-inc.local;PTR:59-124-75-172.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GoU+lfDNzykwWd9UmfHMXKOgfGzuxn5wUFdm5U4RhCdPeFomPOhRt5kLAoKx1pCbXB72O2T0ExEmph225/pZB92Oj4Mv3MQUhS8iCXCHd3Y1iHtszEzfI5/4Er6Q6i9ysCP7ClDos3a8h6KhOtvEJGRfg+e9dfLZIjIs89tqAhGJ7UEgpsdzjY46bSh9BmqcZoi5lUXMeoKlAUNfWnTl2KGJWEeN8CP5GkpvZqFvbuSzKz5AzmXHHM6NsDbxuCF07TWJMCaLtSDeEsokmopjpWlIfeVd31oL3AsQaBkQ0QNjHgeRRnnh09cCmFa5FVSWwPGdD+n3g//L5O3u/Z7fdwNhBwg/fsnM+cdy1RO3YjSMpEkd/f1Q66m5eFWo6Z+ToWKxg+sl+eiJBtokgOGJRE12aP8AvAXuAAM9X369eHVpY9LTSMfpzQNk9xBIiMpe
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:18:31.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05310d7a-87e0-454b-f885-08df09b57931
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[59.124.75.172];Helo=[bt-tpe-server.synaptics-inc.local]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB989391

Add the brcm,bcm4384-bt compatible string to support the
Synaptics BCM4384 Bluetooth controller.

A fallback compatible is not suitable here because any operating system
must discern the proper firmware to drive this specific hardware
revision, and the compatible string fulfills that purpose.

Signed-off-by: Andy Chang <Andy.Chang@synaptics.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Linus Walleij <linusw@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..612d21123aaa 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -31,6 +31,7 @@ properties:
           - brcm,bcm43540-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
+          - brcm,bcm4384-bt
           - cypress,cyw4373a0-bt
           - infineon,cyw55572-bt
 
-- 
2.25.1

