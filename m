Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782641760
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256752; cv=fail; b=robDmkVTm6hU+ZfAgE+YZWbEigiKoaEi7RSiVi6T/8/yZPMMr/aRMLLStmQhtquZGMP1VcYVVUpXnHKYeICN4aka+xmVrgpDEOrvUZLQ4rpXgSYo9VHkKMqI9Zd8RTbAOdHXTPDsytDrsxM/XACIXASpWbOZ+SZE80rJxyD6X74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256752; c=relaxed/simple;
	bh=AjGu/FNOHw3FjW3N5zaEeykSvb349XIfTC45wafPxJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anhSjmgr5DYxGCvMz0FQRM7kCOVTutEm2XDvTBUJtdNqimgB/K4Gf9TCjVZ81XYgsYdA2b57+E3BA9+zokh/YttwwB1lo0Gz35BJpAPVhzYygBkObretWJ9Mlkk01JUsyTxz2Snjr/PpfTtNnGk68LpRXZCC4l2vSSgFYgz49UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qZtoj8dD; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qZtoj8dD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqsmkrw7Pq77q8NmKuFriVaOnqExUIPWsQDD084acFJBf8nvTMydt9NI6ZtYBmzCx00tdltIXXaBU51HLI5tS6P2THSivRi9IPuHLuRF/KR2BNMfJTPQ9zQvu8+JNFZal0Q9PMpGNyF3O+LVLsglqDZbBbcQ7KcyhbLc2kFi0sThWXT0qOxsIFCol8XbaETBXBhnTukVRgb1U7rcEPdrT8CGoa8jvHemcjiitgJo6lCxbzMLMqFzYUhNqeENc50/x4GFt0bJElKKj5YzT3VyYNWkZSuoq/r84GoOcoAHYSNuho6R25+tibcGGseacLRWmsEXcm0gCSH8lZbftLiSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKVwyrq8Ex+NrdjDoE9GGbj2kTwTK/u+/XuFWHDpMCI=;
 b=s9FjL7c6CJ8qogYrhjqo+nUR4axszJ1K7Xwj2NdxZm2iDanF37sOCL5YlNxVlxIz2ysvmKj58fOabw2t7GJGfovoDobsE3jOjgKe+Z0BrbrMp7pgnx0kdcnN0ICjs8XgMV//VNNOdkNPDH3P1Mxsu4w7Ettetn16S7AZyDCnFOtok/OIPsGxFcERVlBIJiBblSz2C3bpXdp8kLC+XLP4AVPN0JCSQ9ETjFWpIS5kNnirLhFH5kH7hdATX/dnZexhllgxgrVlnUR38/gPsAYm1K/HjX+LBLlmYn19CrmuZNeGW6JFB3BhHskppWZ1N+3d1wPfmuHa22PpL15S66UI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKVwyrq8Ex+NrdjDoE9GGbj2kTwTK/u+/XuFWHDpMCI=;
 b=qZtoj8dDSAi3qgmS+N9XCXTgKlkxrohkZNUXeJMDmee5Reg2XMDz/nUh2XmrmPVMw8YINjMEnrKTBAkehL1RGjuhkaSexvdAfFU71HHG1CSDsom0vkaUnlBAe4P8qHGSFhZxgQbAJSafWa9OMyf1q2NXRE1gnIH2/D2WNmxZjE8=
Received: from PAZP264CA0075.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::20)
 by DB8PR03MB6172.eurprd03.prod.outlook.com (2603:10a6:10:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:59:06 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:102:1fa:cafe::88) by PAZP264CA0075.outlook.office365.com
 (2603:10a6:102:1fa::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 17:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:59:05 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:59:05 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 1/7] mesh: acceptor: increase interval for unprovisioned device beacon
Date: Fri, 11 Jul 2025 19:56:51 +0200
Message-ID: <20250711175842.28860-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711175842.28860-1-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
 <20250711175842.28860-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|DB8PR03MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 307e1d1c-162c-4f76-5e08-08ddc0a4a0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tSf4XKcBolGIJHEXpYlxiCw3mxyHxyP/heSZX8mi/a7TGlt82nVaJ2CPZI8s?=
 =?us-ascii?Q?SwvxPkXp14M2CQau0NqEDEAWnlucRWGeL+Dg0TCIS0QH2N+QP9htIlgT5xiN?=
 =?us-ascii?Q?jWSV00W8bhut8ccHEUjo/Qvpd7OMwiGB10U0I+MaeDSx9YdeFPOqEl078qH/?=
 =?us-ascii?Q?wCoB4nVQ6iNHTDLRO71LmH3QKg9lC/3PXep8HK66E0aBVx5uohSaDedlG4Gy?=
 =?us-ascii?Q?bMRU9KspVeNdNZWSecb/1FlXHAfwfZ/zKi6ePBjSMJ/xOoHNveYtPzkvVoim?=
 =?us-ascii?Q?l0CDEjSAikXfxj9IDR4/pq1PnJU6bOROPAkdetSeFrJt9U1LN9JhrEfzxl7o?=
 =?us-ascii?Q?JygOGk3CLQxksTYHjSOY9/0A/ulJPmjiLbuiYv9XPaCvaq2nv2dIWqi+IX5g?=
 =?us-ascii?Q?zBWFh7FRE0r9xxHAT33ahr1tMdwIuw/T+14x1kHggSvT2kFIml8ZgSHC8pN3?=
 =?us-ascii?Q?XYVb9geeGJhGa1JAWP9B6yTVTu63Ww7xJE9gozRFgCY1H805sC22R0ofvKq9?=
 =?us-ascii?Q?WON67DtUUee08SpMTRoL2Sba1tSGlzylwZPzZ1oHJu/7jCqDvHI1cd0xXdGm?=
 =?us-ascii?Q?WsMwHDDtApLmdObK8IAz4ZiSDB3HZr1YyUz2NHdXTEwJhR8YGcJTIoTZjriS?=
 =?us-ascii?Q?YLvO0h9o9OIW46YhHtSojhDSlWjJZ3cNr1gCLQ4xg0ExtI1rKFfq4Vo9aS//?=
 =?us-ascii?Q?9JfPd21pNsoj/Of4Q9ZqYj10i+CedvJFPWTmHlxjrEVZdS8lCzR++Wodqa8i?=
 =?us-ascii?Q?ameyNHm5alOg5677Tqu8boTXSzOByranlkHVSVcF4EIrZQlN6Ps8Iw+LJLDo?=
 =?us-ascii?Q?2Hqe+n3RU4vcZ+a6znHoCMcYz8ZQT1+6OBRosYhhc2d7BCEWS7hHQUCQmOjy?=
 =?us-ascii?Q?oi4Ge8eEWwqykJDEKTG10dgwJQUYtAG3D8aFo2fNjjCUbWKrJywhqytBO7uB?=
 =?us-ascii?Q?mvGsXRjuOJMhizn29PI7u95W2LDB4D0iDXxH+CBzm0V9tA5uyRIqNWQTDT4r?=
 =?us-ascii?Q?FYge3hzdDbGpNnmF6rakV9z51jI/SqfpjFrb2Mpwl0IDAu9r2kTyjUt/zcIB?=
 =?us-ascii?Q?ZgpWZnzZYeX1gJxj5znW4nWGXrlBj7KT/YRAQ5blSGkXzfdFfDQ4eC1fvcps?=
 =?us-ascii?Q?rUhTqWVuKoT5HwLiL7idRccgxmpQaHMOaV0YCyvGC8WcQtMxiXdDb56vpOay?=
 =?us-ascii?Q?ivUMv6Usyj5uKr9ak2Mcs+RjdSySjtrmqqeD7rz1KNxGFVP6jn3FueQ9/Iw2?=
 =?us-ascii?Q?OOP2RwnFM/1yY6za/mMrTVN7v4KSFaPHj4F92mhnMLOeHIyWeDxf9JUOHHO1?=
 =?us-ascii?Q?+dBd1UuXpOB4ge/5P2vsCMQxo2vtE/H2Zo+vd0mrNjZouojDDXMp3YT4yuF4?=
 =?us-ascii?Q?au41nw21JPC8SxLd+p07sFzSRMHMPpEfrDCN0KeOdomgOlazYOBxFZtrMNqE?=
 =?us-ascii?Q?D8UAuktd0YehH4jHbqplagYFhTDA9Awl4695Wxt3anco9XgPtkfJCm5+Pvyv?=
 =?us-ascii?Q?H744wCox2IMg1Bd9EJnEG3GZR9b6J69kw72A?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:59:05.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307e1d1c-162c-4f76-5e08-08ddc0a4a0a1
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6172

I cannot find a specific interval for sending unprovisioned device
beacons in MshPRT_v1.1, section 3.10.2/5.2.1. The current interval of
500 ms seems to cause interferience with normal advertising messages,
maybe this is controller dependent (seen on RTL8761BU).

A beacon interval of 1000 ms should be sufficient for scanning (e.g. by
a provisioner) while allowing normal advertising messages to be
transmitted.
---
 mesh/prov-acceptor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 0cedc227ad28..a83636280dd8 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -793,7 +793,7 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		memcpy(beacon + 2, uuid, 16);
 
 		/* Infinitely Beacon until Canceled, or Provisioning Starts */
-		result = mesh_send_pkt(0, 500, beacon, len);
+		result = mesh_send_pkt(0, 1000, beacon, len);
 
 		if (!result)
 			goto error_fail;
-- 
2.43.0

