Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6C128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271411; cv=fail; b=d6J9lico+Dcg8S18L8epoem842YdoFFk8TkketXkzVc7ZA67SwOc8eEntDm8SjNdiDH1c69v136ipFN2VPE2OHBqvpcFwYmkG4zZguVkygUQm3PxYph1VeRcuyDakpbd94PaptmKZ/mAt5P3GVu7zSbwtV+l3bBAq8MMhSfM8dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271411; c=relaxed/simple;
	bh=KfwtjEbh/TofZaABtpRb0yhb4TXeNZjpU3IUG24BoVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poY/KF888XYTc34BZNJqyWBBH1teFI7PpGajlWTxCHJy577mDboXbcV5HtIUKyicZ+3H1L2jEi7pOsijJ/x/ewF/c+lKXgB5A8TR6ZgD4HBaKgDkO6ndWqyjfwclgIyO75T02adGROhfndEdWbRwb5S3eF5vPgUnFvgkT3QTF5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=U7NDo3W2; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="U7NDo3W2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHJYZv5oMG6it2+NDBhCbWNbr3hiZAimVMzaXAOPMjcErKI8vYbk1XuXgmqO4AaL40P0K+MAkByVReVIshfNSafVRGbLJsAExlAhPMGCfyNBa1+k77ETMeB27bWmpivyRxnix0prDjiSM43q0K6mWm2dY0qDYsS/CTDW/4vhGhjBrtgQ21W0bdsN0PSPC4vadl6McHMrZYgUk6e0d9sm+bDo1KnAkMIgX3iwdrXBYycsK8bg7z/D4Vu/DZmHZWbezzPS15OsuYUGvqeCWrg8mM2RUAlSDdJhLYmMvBD10iqr/5Qu+u/gPjW7Rvj3Jh1hN2RZxd/1YLlhjDdyWlCddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcpgtka5i+yOc3sHThhdVC1k0rlrHG7XQiS/APkli84=;
 b=PBpvs3+kE3K7+Fyb4rMI0UgH/z0BKMmlqRvwNPo9EULevjFSzr7OcjsudCjbCMe+wcIUfe7mwxBj57KxiPtQf9o+cq2rkxB08dK5N+XDnqpFK0Z5HlwS7AM2ZG5IT4qfwPONsbnvgPKcW8n8UoLe0XM4K2t2HyaQt8jV6yKmNwwoV7G2e1AZ1Z0qF8EmUK0AGeB+Wl5/F1tBBXqpJ3JzvKGMUUeYOA1+Kf0ywrmOdMr31T0U0/WDNkwg1F49klvIf1VAzreU9ZY14kAGB2YCPGVq+Byr404OdFJBTPOA3+7IHepoxQb7DoBtCihd6pxk7Z0/L7xl4Nw1L+IF2fQ1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcpgtka5i+yOc3sHThhdVC1k0rlrHG7XQiS/APkli84=;
 b=U7NDo3W2UEbgdDvJUemlPXxOVcH4AC4IEeRAig4tBVXZo6XvHWsESW1o8ES3Dnk8yXG7d271zYzDnkC5SN6N/X1VHDPOTDMqWZ0PIMNUC02swKsR6UuAbH5LgxvXtPBTpolNir0UBJJYZyPw+6XzjvOiPPtQqV0Aj9WNI2YNIQg=
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by GV1PR03MB10576.eurprd03.prod.outlook.com
 (2603:10a6:150:168::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 11 Jul
 2025 22:03:23 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::52) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 22:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:03:23 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:03:22 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 8/9] mesh: crypto: simplify mesh_crypto_packet_parse()
Date: Fri, 11 Jul 2025 23:57:20 +0200
Message-ID: <20250711220035.10065-9-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
References: <20250711220035.10065-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|GV1PR03MB10576:EE_
X-MS-Office365-Filtering-Correlation-Id: e953f644-5a3d-4c3d-df8e-08ddc0c6c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuvZxavCYbOygV05fYdhJSfKjGVOsr2Nr/STbyYtRuPd9JbjqA5N4bxz6j0Z?=
 =?us-ascii?Q?FQ+p7PMS2XMw0elmlwfauXIUG/kkEPsPPVuvKpRYA2hyoZ6lvzexDg5o76Yr?=
 =?us-ascii?Q?GwDYbBy4B5P7ZzMOffhhzNdv36s928L2DOwMTSFw/30tcgCXPJzsTmp8rSjI?=
 =?us-ascii?Q?vAYLTw5HheE5CD8Eq6Ja88OuYavbB5ZPp64M5WXhXiYnUW5vb/3/CmYXarUd?=
 =?us-ascii?Q?jAfAPs7iOUL2AnMJrenOtopY0mC0ZgafRsVzlAh0rzmkh4udgc/jpEuCST3K?=
 =?us-ascii?Q?bmH9CHbbydCvoV7w1FsUFSPrGeNMZZMOW6gcGYcyPQYy2Sb8h78ltesIuGnd?=
 =?us-ascii?Q?k8pAd84A6ytllBQC85SQSAScvBOuBmKS4AhbR3GnUfKF8ZQkntDc6rB745cb?=
 =?us-ascii?Q?/vh3n6W8Xhyir+VyckDP6lSTtPauACYh+WZxFPSeSvhtm8EQdLjuOYF67ppk?=
 =?us-ascii?Q?Kyi6jMI6A4Qu8xpKPhRJpGqwccwI+Y7wM62lrVn8yTdz6cvi2f+uyubTxpPP?=
 =?us-ascii?Q?Nf2aBLi+gAl/j+ghYNtlwC44j4Gx9TqYFZ3s5tjy7QRz8Rsb+DOtg41mSJFS?=
 =?us-ascii?Q?1xmn80E3AFyZSLsY8PTH1BG2Fws+pAl6ZaJDKX7shQLK55Ke6t05n5dr1NlN?=
 =?us-ascii?Q?7jb2x5Gg4O8gJ4gC7DHNMJj+6whs0WHcO7RPqJ6ckLWoR8OICGrRe/OXjnpd?=
 =?us-ascii?Q?hID5uIL8eqDlDtuxSpKVE3pELpW1hZgZ1T0c61vBOXj2cBCZ0+dGjRG46v9p?=
 =?us-ascii?Q?YBO3fRuxhHrQXoyLy3wrLweuXkiXfF+0tu8jDvuzbSmpqvunovZfEltzg/D6?=
 =?us-ascii?Q?f9MusQVJryrM9JXYOWn8UCE7h72TciHRmtZLr1fTfMlfDeRoLWsmu1aU7t3J?=
 =?us-ascii?Q?Xj1cfy6qZh1WiTJ0awLVkGtqTVCd0/WW03CP4g5JRSbt8CbY8tVm5t5kD6IM?=
 =?us-ascii?Q?/MyPRIAZg9HYM0zS4vrNDCQ7/MCAQBZAVcqt/yOk8CzsFhmMmgpRtL5nU5NO?=
 =?us-ascii?Q?ttNcFmsrXgUhMRTv8F3PX30+SXO/ZkH6Zo4LUaw0+nT4z+AeE6pTX7fQSqJg?=
 =?us-ascii?Q?j1kmgIf2lo5nac+hvB0cQbijacC3MnuHG6voHPKoH7u/V/GncJ6o2H721Qsp?=
 =?us-ascii?Q?Daxl2ek71WodXp6amNZ8DaSydAzmiycVUxSBfObfBpuYtQYbwv+0CDiGC13w?=
 =?us-ascii?Q?VE1fsIix5XNdIa9D7+rxWBqSnfkMaea8eZ9yA1O88OpdKo7gL2uQJ6lGQSnc?=
 =?us-ascii?Q?6WCNQV2qAKh2o26qRXdFjeTFnUkN00B9WyKFFRX/5tHYQa2nHTJbkhDJXuqN?=
 =?us-ascii?Q?tHYjDH8iyImn7NGISIjAGj4chu2PL+tnHYnDz8cVIBlj7SXQptrpMeCiKDse?=
 =?us-ascii?Q?N0R/22M/1CC7jUNeQwVY6UCu25PYa4xTZReWxS8kceHIXHWUDFhKygF2c6ax?=
 =?us-ascii?Q?p9j24q92pcwyN3jDU/rOW52ZX6Aw5I3hwNhrcnBNcVifq5ilowFWxst/oIql?=
 =?us-ascii?Q?F+D2dKAqF9x55HQE0vTWtEUhFVvwlgWl00eT?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:03:23.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e953f644-5a3d-4c3d-df8e-08ddc0c6c14b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10576

- NULL pointer checks are not required (no caller passes NULL pointers)
- reuse result of mesh_crypto_network_header_parse() rather than
  determining value of 'CTL' again.
---
 mesh/crypto.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3200d1231f1f..3dcf226ad8d3 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -643,7 +643,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (segmented)
 		*segmented = is_segmented;
 
-	if (packet[1] & CTL) {
+	if (*ctl) {
 		uint8_t this_opcode = packet[9] & OPCODE_MASK;
 
 		if (cookie)
@@ -660,17 +660,11 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
 								SEQ_ZERO_MASK;
 
-			if (payload)
-				*payload = packet + 9;
-
-			if (payload_len)
-				*payload_len = packet_len - 9;
+			*payload = packet + 9;
+			*payload_len = packet_len - 9;
 		} else {
-			if (payload)
-				*payload = packet + 10;
-
-			if (payload_len)
-				*payload_len = packet_len - 10;
+			*payload = packet + 10;
+			*payload_len = packet_len - 10;
 		}
 	} else {
 		if (cookie)
@@ -693,17 +687,11 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 			if (segN)
 				*segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
 
-			if (payload)
-				*payload = packet + 13;
-
-			if (payload_len)
-				*payload_len = packet_len - 13;
+			*payload = packet + 13;
+			*payload_len = packet_len - 13;
 		} else {
-			if (payload)
-				*payload = packet + 10;
-
-			if (payload_len)
-				*payload_len = packet_len - 10;
+			*payload = packet + 10;
+			*payload_len = packet_len - 10;
 		}
 	}
 
-- 
2.43.0

