Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A62DCF58
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814179; cv=fail; b=AH5rSZod58sBZO5540cE8DjPM3VJK8d+Q4xaEK2pIaHYjAhrejCqIJazP3hwMV49DDAp3L3tOOyNXjFTDkGhKeCGvNzcz4mwqHYfVlwRnmpiw6i7v8gAxyKkKbS7PcmF7Phz6zG1DFplDibt7UOsdXVZfYrH/ih6OVk8wj3WvGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814179; c=relaxed/simple;
	bh=jzMXieK6Imf5eowt6rSInkoR8w301fCUwsDz6Q3CHBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/NnIGonkFZB9kWdKPaF9Z/Ny9M6kbzHBYx7P4XIiXLwohp7R8d6XFyw1Z7A2tp/x7MTRl6a62+BrlVDU5EWxag7oXBJAW7QCvv2smKnXCmfUd3cxg6pK8wY3yEbgu4TA6uHeSMrMktpC5ra+GjJyiisrsalDCyMsK26hasfrPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=BdJ7KpNQ; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="BdJ7KpNQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pav6OMBYxhRhUAJImIkgUr5EEfMI9BFOwIvIOLGH0GUid9r+ZSMVQEbVclaoRbqR9TJ977demJ6xHQYhw+m5G5I1bpLphjJeNxI2N/A0EuFEfBl1VOFCbJp7Do8hiewAApGXqnL0DcOJ9g4FG6kp66ScElhzs0LXAEVit196rNGBO8z5zey/kjx6irmPbuqNnaos3zUAn/xWg5tAtmxIHlIx35IX8/K1hGl6S+RP+ipGg8WtBwIJhLYAv+YC4NxM9MmC9x87Pz+RRKPXmwhfaCackBsolWrxZxx0ZUc2rOFN156dccxg3YTvdwWiR9eABQOWFFdtPuqIYR0zXK/NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZZb1pKtyN4zouyGaFPa4+rW1qHq3qYJHQaCsMVGOks=;
 b=EKNW/kH04WaXy24E5w3Ej5XSQE7MfgdLuCzGYR7AoKgyo6rj2VNwMG7ZuTbwALloN00Bw9/SF3JVvQqRL1UjqqBMcWVhU63si5U5SVzNxQ7ulFLULZwK3gv9vRfvPRx9rM5p81s2WZLqf59kSZHaidOgGze6qg4ApBYlwWkargXzt5UyZ/ds3g2++Ixa8hpEibz5tIaZNN4HF/WL3jfp5rNRcVG1Y7QHf+YCigXTpHlf+P7f8opwzR1NL8ubT5OnKFjq1OVmAkQpqoUXfi3in5sn7ALYTFV74eOhozsMzOFzk6/w2jlvkOOikFBnrQulnE1pSSUObF1Xh+IUOkU6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZZb1pKtyN4zouyGaFPa4+rW1qHq3qYJHQaCsMVGOks=;
 b=BdJ7KpNQQUbiuxhVMYIAYMbE0zmF3JCiLxnbX1UwPJdd6OrtraiR60217ySSOh49qBcuqagt+xxbACRl96W6n19U2rBGWsv1/DtFNy5KpZ30gW5gb7Sx6pkX9Qv2FzTZqYZ8MdKpxQQc3V0TaZzH2sBIrozaJTy+wYn9kJkIPlA=
Received: from DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) by DB9PR03MB9805.eurprd03.prod.outlook.com
 (2603:10a6:10:456::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 16:22:54 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::27) by DUZPR01CA0054.outlook.office365.com
 (2603:10a6:10:469::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 16:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:22:54 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:22:54 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 5/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAI/BV-02-C
Date: Fri, 6 Mar 2026 17:19:20 +0100
Message-ID: <20260306162058.15154-7-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162058.15154-2-ceggers@arri.de>
References: <20260306162058.15154-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|DB9PR03MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6ffb56-06e0-409d-c046-08de7b9c9f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	5qcALGuq10QXEIZsSByghHZI8SnBSfEjdyQaeX/wVZfC/HT47bE4K1Uus46Qy6XKOc5Ejf6Ne7Ebwjc1zZIJZ+/uBP0GxnVVWLezPB3pf3Em5QxzpphrTcqeGUJ85TGwFLCHlBarepXpPtr+/tt9k714W6V/f7kljS4dd+uPLez+uDU3pewZxG4eB+eLC9ZQvSqM5pmWSjpLzE358nCpiRueBdUV0TJ24qT/IAo3Y57lyuSq2kBbdDFu1zgFNEAmjhC3Mh9O8GLVPTBJnMuAc0r02yEbww+8gv09vAJJ2OMKj2Ez31PWObNSwwu/ijXuXstThv8pPjVfZIQmHtkRylImO8UemdDBTE2p3w4PFuUfs8I5LNpQjYqsyhrT13StYl8XFa/RVSJ8Bl1e5Xi5XfSc6B2a+27FO7NsrvrmpVWE9+ttvNUEQDK5X3XpQigg3bS/IPs7wtbr6iWpWEfQICunaw7lnCMNmuxnIsave74ME2n08ZNj778b0tY7LLa0674tQwxk/irt57hmbGQKUMgCt29WIknyqp0yvIwAK/SE7AngxXaa51KIblnSzRsRuwVCWjLz9LzUDJxZnuwbkGSgE3pz9+XuGNSS7T2AgZU0qlApfH8AJuZwEg+c493T+xSiZv5bZsA9L2kMkkCqps6Av7QHYD55Sva2/65v2hGw76ud2y8Bp7C1MJENjvOIUpr/r9mxWytPBIUn/wT7L4WHqq4sLbWLI6Sf/k6mGuJnYdMjslu0irgE9UFQzIE24B6MbU2SAF1Yxp0OefZkvA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x5HLgSxxcIPmNynpFpRJsKaqFJWHPL1h4lYki/l7cbHA4r+yZKfVItl26rv+Fn8xrwlFiM0xwHoz+bJtdMmEVKCZ7YzH7n97iglOyCdOGHUZYjWds0U4rJeq41FmpV3Aj5ITVC2tP8B51utNzp3x34csuJI+nDIDYyUkxOhWGzpWwtS+RP0t7oNss+ExWNf/ce+WHlHfkoCph8EO5sEDm0MUwi0U2iOXZavUb6xw1lT+4sw7GbDer1bZLs/1R3hH37R9ghScVje7uegZmyQTz2k2fcAU5LZFnPm76cfnqAxBO3qcZQjCuyOku9HA6c0mEtltDi8Jm64OXMVoqQnxjJzRQDC7McwcBdXAsb/tcUmvAAc0ohMgQdpDLnW67pFxZJUBW9F4IBYPEmeN1oLR71GX3INu7jMJBGrLZqiilDgW1P4WJ8Y9YAt2d/WUYEkW
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:22:54.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6ffb56-06e0-409d-c046-08de7b9c9f13
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9805

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 04af0bbeca63 ("doc/qualification:
gatt-pts: add description for GATT/SR/GAI/BV-02-C")
---
 doc/qualification/gatt-pts.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 79dc75118451..d01525464183 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1183,19 +1183,21 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Enter '2' when asked for handle size                                    |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA read,write         |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.51.0

