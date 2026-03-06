Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0123E7148
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814090; cv=fail; b=EEwcPXmM3vNExVkToym+KpIRc6mEK1TFQsoBRhp/MqmBs9/polMBnR7JiIivMfXWvCya62djQKTvBZ+gzZsJP5qv2JByNXeGrwvGAP1s70+cNqCR59w5TdJ3zVyDXNUpZYp3iZOwq7lzNU7GY01SCIef3vPfCmEva/8MM5ZqaSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814090; c=relaxed/simple;
	bh=b/GvoMaAEagjawvyr+2tdkb2WCCVsUeBGbPBON+baPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GU5jTAt0eFTLHiP6F7gqJrwv65Bc9FA1y2e/BtojrGr/KhVWo1CvdGz6f041h7HnFUTCUE+I1Xbu2ikHKLuRxE+RM4oEAuERIZW+fS1gphL3+twk2+NYEvaB6KbVv48Cq6673zx2UJ51wZvz077NTXCSwlTc/9OA2lnTNAC2frA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=AokBCd28; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="AokBCd28"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEze0tWB4mx/vw71BBO+NruTbGSiXZOlKrz5xAq2e37VWdD5ZWPpnNYAQoY8y5alcDeL0kGdAx0Bel6e6B6D4TgY0CQrNXW407q6PE7jfC+RekprEtuHdC8hsbTLMMJqGPKoLkhxCSw9BgG2IJEXWqglWpusKopz0ekZoAUGDY8+DF3DwaP7s+MWQoZtDdlzPRy7P3W1Dh1uUdGmL2e5GL1Tstp6nL0zAO4ClIovNdUaiELweWdmcw0HKsL9LR7Ws/CqSanz1fVVGmGdu+0pLOyaU1cHVVnB45MfsJ9PTiJep1ygOLDR9n5rlkdt8FwMouz1CPijVGGInZCx3aqACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/X+6HLy6f9DRhkbr2yt5dD2cGkD/ee8BapkH1b2CrA=;
 b=qqflWMh7uccwTi+FbezV42JWxjZaqmcZSWTG3AIKubrxgBRR8JKQeqhwUkOMqYsVANWQWi8K4T/kv/wBKuTBT8pfFMwnHV+qZitbJ9cp7QdXVWayWKVF6/i2yo/Qt/BsunPoGfhtdCZjlAobJc23mC0CI5C4yV2Rj+ai85RiojI0uOmZn0fNLmEXXLM9aX0KJQ96nmqhbNpJMH6t0sPf1fr4PEmfja8FAJB/UOBpXnRd16+SbZr3z9+cUHlEv6dOoS/9TeExCXZJqt6SAGZAIMDQKM8OJWeoKnJD7MbwLsIjaRoLvqzBWgAronwIyu1R2CXo+q7RpINudYBSnSmhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/X+6HLy6f9DRhkbr2yt5dD2cGkD/ee8BapkH1b2CrA=;
 b=AokBCd28++FiEX6T80knpOUvKKGstqxYAqpT38czXseaE3rfH87baRtFnSQb27rM4tnE0bKWFim9qma1D5tu5m9kKoYgWK8+dKtOVTWmLS5QWh7X3PxMnKo5y2AosnBsyZ+y30FSw8+VJbkmxUTLiDw/AqQcsaAEgN61EWYF2yM=
Received: from DU7P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::16)
 by DBBPR03MB6907.eurprd03.prod.outlook.com (2603:10a6:10:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 16:21:24 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::61) by DU7P194CA0001.outlook.office365.com
 (2603:10a6:10:553::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 16:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:21:22 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:21:21 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 0/6] doc/qualification: follow up patches
Date: Fri, 6 Mar 2026 17:19:15 +0100
Message-ID: <20260306162058.15154-2-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|DBBPR03MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 968bbfcf-ff18-40da-6c3a-08de7b9c6803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	GAKQ/gA33/xrUxF6O3QBlZeW0mCU0yrI3dgo0vc3XrzyOllaOTkRqjmpboX7LY8pr+daw1ZWHTnNztmMMEVlsVWGxG2PdYUBGZ9h0i4bN9qnb2WYRCLt+h48IYL9Hz4F09XIUAsPkz5P3JCdBim1EIT1OcQ+XnWOOuy43CP4OB9CelAIeU9ZLUyXvbfKOlEVC/gHBvsGzLhN1Sr19z+qal8dtAk851lLyWzVwlSjTtmpoTsj/xDe91n5MYGav3JVsAMxiZBUjY/k/FW7zWEkfHNzy6jvMpw5kpvkDo8tuGc011cjF8qAzD7TliwUEAmwNrsEJ5P1ipkDxpU6Oyy4cjt0JAPbDIrUOkn1Am7wFYeOSfIgATXnPXP/4U6/FxeGAWlU9b+2efsqwlYUOe5EKXEGJ2Uf6l/ZiRA3YzvUU043I1WKT4xNp7ZN7bMe+/LSp/6H/xKD9JMd9hPEwvpfcN0ZYBc7SgtUcWAoCMx15DChhonHfZiHY+/JVJbeg/vsWsgSYk8bqQFBE/Iro24Uagy3+s36EYjvM8QvL4gbN7kHBBdbSNKfKt/N802IE4/qfElaBCuRgIY7Y28IEYog5+oTBfHl/qiAw5uR4SZJl6iFhhg3sWb/tIRxThExmv6hdPDv2m9ZqVQ0CpIE1tLGhI2ma5KazLktJBq3PyTk3M7ItmKkh7rqqSHt7qGgiPXgTca7+SWMJndVY1kWZQsxsnSoII/IJ76Auz+5q4YOkB8pGcbcGog+pjldzU2cSUn8hKT4UehB1U8m1PlKfhVE6w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VWwMwI//hcC/R3kvPiezBtIxW+9+VMJHnO8eSiXaX25A0JhOFZTwF8ESlHMEZnzwzEM6i5V5JR2lEcKQsjnBCa3PXVaf0ZNcRV2r/BcHkDlVHJH/74t++LvF/tWa83NLcoJIosQz+6ISKxPurw4qo2q3Jfh65NAh8xpmKtq6KskzNjmG1NFNmm5vqz+48tr6XAXIlP5OEQWOWDyT0Xy8VGW1SGwOaK9wZ7WGlgXtsXO2BNGqUdzAt84Ba4JGXYZ/uPww/Zg6g2/cunpLA/fRLYfpvqmBw4pxZRXsoAEcXT12bJkw22AgN3nF8g/NKE+5uyfNsvziz10Iu4afSRm0oE3jm+zn97W0+zSBRZn98hDt1zID81MDgwR+AqZSn4/PZF8fXRPjJiVLUPQR9DsPSezPCQWJQiMR1AMgHZzsZCKH440Zbz9rL2xvsnBn+rG5
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:21:22.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968bbfcf-ff18-40da-6c3a-08de7b9c6803
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6907

Unfortunately, v1 of my patch series has been applied to master. This 
series updates all modfied patches to v2.

