Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F361F3B83
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271448; cv=fail; b=IqkOH8YHI6cG534ESI23i2D1/qghInScLvGTXHQixMuLx1f6zgeuGfkVZqoqUYFijZX90besL55mTbQtfwQgSIAlsJhDpez/S76+Rh+VQFeuBYXp0KlK+BEMiqjFcjWnRUcbe3zSu1QTo+9Jd/MzphGxBN0CR6d8t+wf/earAiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271448; c=relaxed/simple;
	bh=xhO6nT4ptJ0rT/ZrtW8mGJtDiU18u3kONAAriOKg7F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8WApntW9DQ9XBWriHMVK9qfGE3lnoH9o4LNElrvJZRuMVoGSEgYnWgi8jtbTqNlZhdhkvvXb+OTI0X+nqWBwIAJvg7OFhDd/QjApffInMowrHbtRXm7ozWJ34L/2JMObqWATSRsrSdJOQsk5yc45et5Ezefo7IS+1bBhLdbJc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=s/79MroA; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="s/79MroA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pys/I6mQYmOz8K73IeYPHsUKUvnVJec5iYEwoBod7+Qiun87NvTXWpYqT/PxYNgcXvdPW0kReDMtBLnDg5jTjYMs1xbCy5JYenKvO1RrUL0n9uQ+dsqFOCQt0o2VLQhUzsg8z0H/jQxV0WhfiRlVNbVxiM31adc0KvMhE8GRtXVhG2efrMZRgG+pnAQl5KzZnNruuUDq0R7R5Yz9dYUZPsRx4u31bk6FS9HAsmLj9XdA/hNGX8Xs9qHs7Lq6iak/5ze9Xlxvr8IRZ09V1tz8UDTCl8u1fuiK4uwdjImTAAV1VcjIVeyWrsp7wmN/7ogQKQI6zSOEu5JgjfooyyBV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uhY9SmGse4wS/aSlFAYxh2zKpw/x0921X+xslO5k5U=;
 b=yIqFDWklQKtnsoHcAD6F3z9YFv4ucBR5pXbEmXcYuz3CLg1Zg8NHlFFMHfkrDdzcXsIm2JEXK7t0An/dK8vOscAMuN2VCPwsmkO7GZebGvguaWKL7FtNq3G/++1KmtWe/fJ7fxPBXRLty6h0gqlbpu+9K/qQBfoQUhqcEKI3cpASXO2i0HDRfbuOrD4o9SQhO4kNmQbcXYMTNliMV9BgQXJVqeAIXX05kSPC9ZNWQMePIKhhlzcq9k2ScK3A5NG3FOeP2O3a4vZ/ltqnSYhDLJqmHJKuILIGeonA8fKgdroDjTlAUnu2uEhbulGfj4SgltSAb0gGPwB1dqdLFZFTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uhY9SmGse4wS/aSlFAYxh2zKpw/x0921X+xslO5k5U=;
 b=s/79MroAxn6A9XuEXQxltbgngr9LB3oGnkGcOUmL0bdgGZZ0M+/8DesLpvLsa7KiFzf1O5uD7iswGe7hEnSKSQ1VYr8yfn4r1XpSURNc9H6waXXuY9cMasw2vYwIERIC3TudMlQbcrjmWUWMA5x4mV/FNiiotnGhr3XkcYTRhGA=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by DB9PR03MB7241.eurprd03.prod.outlook.com
 (2603:10a6:10:229::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 22:04:02 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::45) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 22:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:04:01 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:04:01 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 9/9] mesh: fix corrupted relay packets
Date: Fri, 11 Jul 2025 23:57:21 +0200
Message-ID: <20250711220035.10065-10-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|DB9PR03MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3d08e0-9ff8-4ee0-8461-08ddc0c6d837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAZ7KBDmRQQi39qWWtKUva4BM2ig+CfHLYNO4whDeP2u5+8r0cHvbjmaMnNs?=
 =?us-ascii?Q?xgNJd2fcsyLNnsyRpm2uIqwwCMfN3J2nuqgDiV17pfn2V35NXv6EAYLcNnBQ?=
 =?us-ascii?Q?3rgzp5uoIYtGM5hZjETYPmKLm+GOb3GCS8fTpLgsOr5LIZzA66Y+3ThOCBFN?=
 =?us-ascii?Q?2LoYCXPBmq2MbvLOH+T4XYDPgREQzQN1yolyOesMMXmlH/3p0XafhVNDhfLt?=
 =?us-ascii?Q?4gm93mqt9xAvYLl2C851S9ayutsJbyVBV5YxcJO8ACPxyHf9ZeLy9HVXszNU?=
 =?us-ascii?Q?7JtTaE8Q/ia06RaKd8RMDP8cCKOmjujSAQzLaT2HfRjTjvMgw0PAMOU7XUHl?=
 =?us-ascii?Q?hMC/YMptqdgZc0IyfYJtjYQ5M/Speti0dS4cV5bBaRlmnLq3EhjoGa0V/pgt?=
 =?us-ascii?Q?L/5REc6DzU+qMSpc23JEob/uXZNKh4XzoSxnux+Pco7WjT1MELwQOWYyL9OJ?=
 =?us-ascii?Q?E19Mq4hhP4HsQNG0R7NVMp3y68ulnfIW4jWUE1U5+dLg4L+cKb6jtVLDGAOP?=
 =?us-ascii?Q?QaP4Yi2WuccXG2qGnrW9bfltmeDjjqqZz4lZBlb0lEu7nofItMJqRkpO4Vbb?=
 =?us-ascii?Q?742Sfa7E/X8DOPcurGVFXVpuj8fnmZ8DIofuk8DlT/E2Tr4fgiBdPzkFvzRA?=
 =?us-ascii?Q?G3ZaA20i1Ygl9w1NqvgXt92XxoouIeFUtxyJ2WzK//tOBw6PiPdBGSPtmyYT?=
 =?us-ascii?Q?w/c8Zb9f46N9r4CSpHjzGW8AuZcGPmJZCzsyVKO7mxuoxU2zPSOpUbNYGTO+?=
 =?us-ascii?Q?EiN+fpCk62MUNkutuKeUPWKAuAzzC/UBakFkTJ7Li5SKREj3O5r9YY5d0uIC?=
 =?us-ascii?Q?63ml0Bp986+EI1Z2p0SI27G3LYUY5R4143kYd2HKRGLa3yGDQlDJ2zbiOtD/?=
 =?us-ascii?Q?vfqzgEGq5JnBKMUGCGtcHSDNAkMT51e0P2LnmB2nWMfzJeeN9v3cWsk57j0K?=
 =?us-ascii?Q?NBAhdhaxuxK4iAhVyDUJEO7ImGT9jWZnll87ejYw86TVqIX/M8HBCO4E0VGx?=
 =?us-ascii?Q?TmA0yzUWBahKOwLfkbWXfHyXTl8L4PK9bzLXDZNCLcvscfScsbfYQcdsne/c?=
 =?us-ascii?Q?I66nlaOHnphoYeKPopIEUrgBB58HggydkhF/ZwdtjqHd/6K+Z930zLK5ok9k?=
 =?us-ascii?Q?pn0LRK7bakMbu1AQMM2jW/qz3/gxDYm2APFCqfahrC9NHACHMY+hoF2kWC82?=
 =?us-ascii?Q?K8Qte01Z93uiyboszGWB71N3WSVNWX6HoX81WiHqbjqTr4wV76LvNfhQeYoP?=
 =?us-ascii?Q?iwocoMTq24Me6NZ6II0A4zbBxQBJIyEk6H8idPo8zXBYme+V8x0SimhT1wmQ?=
 =?us-ascii?Q?Hia+Jm7zRrBmgw1qzOXLii2PopSweJ+MP8/O981c4DcRsm8HSb1riJIhEigW?=
 =?us-ascii?Q?lEYt0MRtJtHdeJE6gHXMQ+3XyoSajkHoZ5/F757vfR0GbrKOfsgWQBYfCdXj?=
 =?us-ascii?Q?xzDO9ugrzDCuwrMpe37YpWwDVoj9OkwsTZ+WZZjSQCfv/5Pt+44rxPSoIfJl?=
 =?us-ascii?Q?bPenfmPBTbkbgclvQ7TMH2hA2ECzdEgSlvEX?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:04:01.9337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3d08e0-9ff8-4ee0-8461-08ddc0c6d837
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7241

Currently, all relayed packets are broken!

At the point when net_key_encrypt() is called from net_rx() for
encrypting a relay packet, the packet size must include the NetMIC
field. But the length of this field has already been removed during
decryption of the incoming packet (by decrypt_net_pkt()), although
mesh_crypto_packet_decrypt() has correctly reset the NetMIC field to
zeroes.

Move stripping of the NetMIC field length from decrypt_net_pkt() to
mesh_crypto_packet_parse(), so that the field length is only stripped
from the payload message (but keeping the field length for the network
PDU). Additionally add extra length checks during parsing.
---
 mesh/crypto.c   | 21 +++++++++++++++++++++
 mesh/net-keys.c |  5 +----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3dcf226ad8d3..a03dc9483862 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -637,6 +637,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (dst)
 		*dst = this_dst;
 
+	if (packet_len < 9 + 4)
+		return false;
+
 	hdr = l_get_be32(packet + 9);
 
 	is_segmented = !!((hdr >> SEG_HDR_SHIFT) & 0x1);
@@ -646,6 +649,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (*ctl) {
 		uint8_t this_opcode = packet[9] & OPCODE_MASK;
 
+		/* NetMIC */
+		packet_len -= 8;
+
 		if (cookie)
 			*cookie = l_get_be32(packet + 2) ^ packet[6];
 
@@ -660,13 +666,22 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
 								SEQ_ZERO_MASK;
 
+			if (packet_len < 9)
+				return false;
+
 			*payload = packet + 9;
 			*payload_len = packet_len - 9;
 		} else {
+			if (packet_len < 10)
+				return false;
+
 			*payload = packet + 10;
 			*payload_len = packet_len - 10;
 		}
 	} else {
+		/* NetMIC */
+		packet_len -= 4;
+
 		if (cookie)
 			*cookie = l_get_be32(packet + packet_len - 8);
 
@@ -687,9 +702,15 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 			if (segN)
 				*segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
 
+			if (packet_len < 13)
+				return false;
+
 			*payload = packet + 13;
 			*payload_len = packet_len - 13;
 		} else {
+			if (packet_len < 10)
+				return false;
+
 			*payload = packet + 10;
 			*payload_len = packet_len - 10;
 		}
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 0daeb9209b86..98e6d23d3f87 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -238,10 +238,7 @@ static void decrypt_net_pkt(void *a, void *b)
 
 	if (result) {
 		cache_id = key->id;
-		if (cache_plain[1] & 0x80)
-			cache_plainlen = cache_len - 8;
-		else
-			cache_plainlen = cache_len - 4;
+		cache_plainlen = cache_len;
 	}
 }
 
-- 
2.43.0

