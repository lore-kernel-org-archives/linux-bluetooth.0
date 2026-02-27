Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4014418E7
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208318; cv=fail; b=h3JZO+DfYI3dJEdkXuawzThCuIfFPNXWqJDSeJonwOu9Z70adzU4yI2RDBgV549k/6pFxUjvyywSwyh4YGOUUwHQonfsMlE+opgR47nZyT0X0gI9FgXLSgpLQ1Vf/VHDrpFaF/V5EYrOIPaTREb8++lzh6VFNJRiySDc12d+/lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208318; c=relaxed/simple;
	bh=ifYhengUyh+UKjb39/APS0xgKnWRx2xulvDJU+RD5cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJNWY3SmzXjGUkHYJ+6+uWNP7uB1sjrEfR+dtOe+Ww/3pjwWJV1rfN9W3NHhp2D1/Z6qEbKvPCm16hU7xuD5t0Bau3dm6C140HH/OI5C57YUbmVwgJaGjM5t+ODvsrisDEReb/BfpLq6ykfb76uqLMlc6WCTqxuXUpI5rOtbpQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=d9sSed1A; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="d9sSed1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWmJK6JS2PKE+oysttHZ3/nd88stKnUvcAEaFG3exE8vN9unQElhbWzAreJswBBtVduAxnm/9StWGAZyHwGEp6KNokAfJXf7NilIHuocleWzINyXEJtXYA4sOMUjBXGDCU/fPoXScXyIvp0dUUA1znao6hv1UcbbMaBuMJcws1j5y0/TKTtcE0Vox2Dk3JwKoAwgv6Ju0qAJQGnQLmep25NQjt/GKERYHDBoXgE/ZQlOIPCDxMNu1fa3S9MdC3P0RQuzvFQh6bYH+SXpZMt4JAlRutWECCNYas6JxPLTfrH1Sp+rDOiOumBaWojPojKmkyBU0OgkMCz7UJzf19zAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI1j6ePc0PcTiJmpOEhcmsfra6ENV5QNoPEpPZDYxQo=;
 b=Jm55sS5UbM9G4ddhR0PAAH9KkmNYThY9AgiZo/2gdxRdYg/fLRBDCrtKBcc8r/gLblzVlczHK9HvBiDsDPheeDcVKFuYFW8ViHyBvG2nASOLqK4yYLwju4bHsV762U9qh7AmBTZ4r5zVCtvhMxbtQ2Jxwkf9WqNcPD1e9gt9l+SOSg2Yhk2f3doxs9hmHUgA0Q4iNVX3qujU8Rvj6r+eaqqNlbxsz59aRtedr/ue+mtvUjLNoFY1FFDk6/d1X5S7dlu+a7OL97BRNgC46AAzGYlLsasqVLQ2r/7P0ogRDti4rNMZvaxDQP23vJId59bL+lS0anUwhiBzwBDR6u3xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI1j6ePc0PcTiJmpOEhcmsfra6ENV5QNoPEpPZDYxQo=;
 b=d9sSed1AcnllXF55+tPaSofnTCUhPPMRUhE9PqRAPfq/q8qd1QIJfBfSN1WflEo4CUHK1e6q6wZysRVPjgYjtLmzE0z70+eHsalH3Hb+RwhtHOnc6apqVHjk4Gwko4+lFeOezhikh2BeWrV1ovUFd1ztNuh1uTkz3UUqmzJRJ0A=
Received: from AM9P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::26)
 by VI2PR03MB10936.eurprd03.prod.outlook.com (2603:10a6:800:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:05:12 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::6e) by AM9P193CA0021.outlook.office365.com
 (2603:10a6:20b:21e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Fri,
 27 Feb 2026 16:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:05:12 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:05:11 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 12/15] doc/qualification: gatt-pts: update description for GATT/SR/GAI/BV-01-C
Date: Fri, 27 Feb 2026 16:53:58 +0100
Message-ID: <20260227160022.21462-13-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227160022.21462-1-ceggers@arri.de>
References: <20260227160022.21462-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004A:EE_|VI2PR03MB10936:EE_
X-MS-Office365-Filtering-Correlation-Id: 67edd10e-f967-4071-f908-08de7619fcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	zFWuPPmQNvzEXno4SpGA6lK/pX1Y4ONWr7o7xnS2y3OmYiV2jyN0bn8hdo1GlkWm/pV9PeZwGAsTOubgbRAVeTNT/8gDrskmJOpTz3O2AqN3T+JR6noiKru8B0kNvk0jvFtLbpPrZlnRHTSV4JhK6B4nWj5lkX1K903NcLMhyeysN8hhfJ9Yki03zPvjMcBpxM+LQEymp/qlP8uuUlCPv8E//4ENiFT5m4ARXJe48r8emGJJq7QbF70QWaapxJpdwmk6+LsQ+wowEFUBMfeJGAjX3GGFehk3UrK5HY88E/MokdYWw6Aomt7jtBQJ5EE5lsI6ozPGtaJJZ3784DzlR4mTYvM0kU57wxUbm5CyQ8+Yk/I6tjjBU8O6ytjvDGHX4kvjdqRClvv3YLj1B0428u3akloil9xzPNHGg/2uIuP4MtoRqY2s1kAq8M+1mWEQIV51sKfNH2B0tI48jZcH6poMf/Lf8UjGAJXbb/4F8iHdOrw151Sa8vEpRsrOX9SDj+iDru+/pKvUD1NWLU0+eC261A5Em6QpJrEMR7QZbZeDGO1JoQkJoNDUXuGYnFNOzZLQ0K3W5TmB+N4XU5ChndByG4/4OXiMDJiBNljBVgHP6ZbuMQ5YsrGa/39I+lfEkxNAmUdXKXbOPGzqblbK2RzJNS2J8U/JwGlfwIBGxsGls9c7isQZ1TSHmd5b5XrsGE76rJkUmJSmMq5B+yKUky68sOuAXBBeHrJ5hb+BDIRrzgpNXMbeP7M32eroSH8sA7nIPmdUkSJG/0O6LKK8evZiG4+h92IIzWal7vl4CmI=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5PrFyg3vf5pEx5mVH1mJAPBBrq2+0tJnuHgxIG/5WUXlsEpJVpWisC/ksdMJ/bubfOT9nWc5CObeu4N7yV06uZkbry/ylHjZKMf+n4yf2QYioWULMPeGjXur4iz9OD3XooqdQE+4V6O9YidDAjA2fewVBQ+IH9zEspe47BtcOML1pkcqeOCr5GKq/kueerxuy8qHGFONfl8M5KiSxBKqaMEv576Yb45mVj9/H1LJkwzzl7n0fevfSG4jMEOIYIGDemsoIFq4qwNV2ilEXQPycfK4JOaCUoV48T0hT5kJ8wNzeFAJdWat7fQuLm7e2WJ/wI7EgC5C2coV5JEj5u7oeOr1VUegkrIdOBj1+m1BMUgMxglypC5L8oQ7Gux/wkTftn+IIswqbi+2vKXvIR+VnxErtAq6/0VzGRdfLuKhUltWLVsGimKjX662R8U9ZCIO
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:05:12.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67edd10e-f967-4071-f908-08de7619fcfa
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10936

This tests requires an indication on the "Service Changed"
characteristic of the builtin "GATT" service. This indication can be
raised by adding (or removing) a custom service. Of course we have to do
this at the point when PTS is expecting to revice the notification.

https://lore.kernel.org/linux-bluetooth/CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com/
---
 doc/qualification/gatt-pts.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index e9acba7e7cd0..3959e70ab73d 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1158,6 +1158,8 @@ for which we know the test passed.
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - *yes* when asked if primary service                                 |
@@ -1166,6 +1168,8 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - enter '1' when prompted                                             |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |
-- 
2.51.0

