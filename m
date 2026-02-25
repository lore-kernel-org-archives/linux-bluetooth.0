Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4C265298;
	Wed, 25 Feb 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039289; cv=fail; b=X5Il7EZ7YQx9U3WiP5C/REEG7dWSM3DzNzexhWsYJ7SOkDynyzAEcDkBQbBlQxteTGa2BkkFJMM1F6ivQXPnO/8vTo62ZOKroj99EKUqXy8kZYIMLWu8iJmU0OkrjiXgI6QElaEXWlI8Ho8vCiqA8HRV8jmCRyqOYi9f8R2Sugk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039289; c=relaxed/simple;
	bh=6fT9wBN5XuMXRPjMzYuWRtf4SQPqaFoYFL5UDnrE99g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THiUMOZf9i3GppCvBiv4ExQAsGGL1wubL0WB42Hxa1UlSIp15xUaIP2es0pWOz8D8nptxeCgtEtEAF7yIE5Dsli7rxImvaYzGVu3zIybIYI8aCUzjbYksopp/asC/smWMUgMsAtpVkjsztPHnsRoYVUPXzsRKEyOOiBPRGIVFq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=mEUVo+GF; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="mEUVo+GF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxZYrNH8ZJRH+rAfXeivqk2HIic+Dct4OEbYViKYQbUwwqsMuGmfAteAxAqK6y4nuytjija5Az47e6zyQ3iJAGNaf2rXkxGaorTeXw4p2SYEhF71qXUmKoSFx2wP59Ci16e+Kbd8p/YEfuv4rGD8K9rDXfS5Dmd1wzIdysFDpauclWcZwSgnAW2XhGTMHtxmppQku5tzB4ueK1ezdBoEkbLOilGUf74oIvOE9ogs6wp8NdpBUw3o4/I0fDzZXdQCiFedEnkqZmPrZrSR5zc3k1pRmR06vVX5K8aKLaisrpT6a6HZS3hU3lZBSAmpaqa3DrGJJfQ6N7HECsG++rNdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSKJYp8opA2H5ZWTvZWYcdT0TTA7Znn2A7xiOs0i1/0=;
 b=J0wlC4Juoe4lVpC/G8tqb9e3hvwaHDVYPHJWeiHkuqFypPjH3GoBBCuAHPYHG1/VsFvTI49WhRpK5Dm/sym3G6oDkYHDrx9PmxVX0leJk79MqRKsWjMgcGKS2pXJs/TVzFeVRW1Yx64J3lehqWkIZZ7lG0Z4WZc5fxlaJ0oADsQJv+Du/EGFkhKHPfBE0KzEt3DiUBPA8jLCYJwVcUETqXgVCxCqsV2hZL35qkIpJbGTsRw0H2OPEO+2BTAk2JnW9gOiYci3nrAeOB3PswaQFqBqfMzOMsjBK4fF7/byNoL0JDi3bgAedPLonD5tCmy+3jF/zb2En+Xl4nHyGxhO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSKJYp8opA2H5ZWTvZWYcdT0TTA7Znn2A7xiOs0i1/0=;
 b=mEUVo+GFul09jUI9buUWT1jy7WcB1Zi/GON7QKzAEVaAyIDFevzCLRpIHCMjlesSm6HGJjL7YAynj0LUnhSl8RqeeWFY0XPExezT9jDC1eBlD8rlaSg5fKTFWcmg8lOI9zw+PevP50M1MYItZAFk/UQPaf8QOwKVe3RrAO4ivNs=
Received: from AM6PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:20b:92::36)
 by DB9PR03MB7244.eurprd03.prod.outlook.com (2603:10a6:10:1fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 25 Feb
 2026 17:08:00 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:92:cafe::97) by AM6PR04CA0023.outlook.office365.com
 (2603:10a6:20b:92::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 17:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:07:59 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 18:07:58 +0100
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>
Subject: [PATCH 3/4] Bluetooth: L2CAP: CoC: Disconnect if sum of payload sizes exceed SDU
Date: Wed, 25 Feb 2026 18:07:27 +0100
Message-ID: <20260225170728.30327-3-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225170728.30327-1-ceggers@arri.de>
References: <20260225170728.30327-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|DB9PR03MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f7053b-acbb-4669-3ef8-08de74906d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	r4nM9wjhnspSV7Gq8scwUrVL2T94h1doNtO8hG8IAp23+ukgtBYh11RW+oNZgExbuMabRTYKDMAorkkyUfNt5F3hzKPkwVaYoky6+DgJwUsoLtPAG+o9iRNRZCReh9qjTjH4XzIY0zy/ZBaMekhM0AtrxpW0QrbVq3mUrKIq7ypRWwVMHfQ7y9RRtn7+WGcRkbhl9829sbaMvg6GKsBoE+lh0aRT3V6UzTXSIqCryox8++LaBtXu2/6GCfYxR49DE7Hnskg1ja4x8/rps0wqXWF8YvkqqtTcs/AGjkHWQ2yOGiDSNyPA2waTRLkoEdgvoWIAx2i0WTF8PqawH1knhjSCnYm+yIm9oMifKlNWLhemNUErczNi6wy/ygkn2p/+k7puX8zM05ItDnrvRvm/Ud0B4LeGk3kdcS6iR4tydNuvdtXSkHV0zGmRf5JFMw+RmiM216+xTnAVhhC2hKB2oaVLCiUN3dOjAOVlcmi6SkfWE42zhz249/bvkvdR7CPTBlRaOYgCNdbLCRht2xdye38n61dhXkdtOvBKJ2Q/dHQOrYIwWGqXC77g17YDnDRyKFRCmTwAm44/SSNFJbkvsSTk6gD56OEIBNq8/1t+s451FKbv+e2UHj2WAVg4K4tSTLV8lr8gryczeokRR/8voUcOXhtjY7HGZtR42qD+SCo4aEqWamL+n/QWILpoU7C0KN+P7AHOJLdWcHwFFPZ/Yn20U/Pl/RoJXOmN8uULnC6hG0XaenCWEBxmvU5fTCigGn8DcXBhg0h98NLl50bRpRt7pZwv4DMOsxAX+xDWV0FzTWUgkykRA+q0w9laaT0P5SaVaCeX+UbhA3OLsTtzJQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+fyzcAKD0ET5D1Vd8EoixpTrC0Eg0HEte3hjGIKsVAODvIK1tA7CNRMyWlTVn+VQj/ZwYbT3AbkljZF69lBk99vFT4cmyuhbzS/saaB+zXFUQz42ORKKEmhzVo+PVXKVG++rFThsB4ZmWnoVCv4dNhXAm5WSSc+czIWU0PIMj7BXfBG4v8PVLSrG3KRUjKzDvbxMUtjT4Ovp+6aXUxLRYd7u5mMFLTHDclsb7qE1wneS++iCloDHbvFJl7a9N7t+XbIbr5649Ahd3mIF/vCLdO9nv+3fRctHcZkGCUv2u8jIRvwRUcmQynJiMHJUBFhahY57SjVGPIGbOe5822xO0qdHj8Q5WLNj4eTNRpy6VS1cV98ZbxMrsfKLasuFt9XfBqUNjQS/1PqotOX1fZ/YcZZAuvwn7k19rrGOxy183pTwJWJp38p8m1kOTLWQgRDx
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:07:59.2638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f7053b-acbb-4669-3ef8-08de74906d77
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7244

Core 6.0, Vol 3, Part A, 3.4.3:
"... If the sum of the payload sizes for the K-frames exceeds the
specified SDU length, the receiver shall disconnect the channel."

This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
0x0027 -V le_public').

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c9555b0a3461..69a57b956895 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6729,6 +6729,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (chan->sdu->len + skb->len > chan->sdu_len) {
 		BT_ERR("Too much LE L2CAP data received");
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		err = -EINVAL;
 		goto failed;
 	}
-- 
2.44.4

