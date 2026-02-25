Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E13D7D81
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036328; cv=fail; b=Teo/ISUSFHH15bmI2VkvQ7eDnclKF2L9zIg4GXinFv4eEW6kDV7DhPQDDS9g1xRo7Gt/1rw9FiRAIP7dXWju9Kc5VtXhH+gi2bzAxgpZPldIClZd5XlDJfSElVfkJYyJvGcI6Rat6rj3tKL0WdPtTw4/+Pwgykvz93pqwBwj1kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036328; c=relaxed/simple;
	bh=G2s0UpJdHnDTpBTVsKIx8R0sz1L11/+2FZstpdwNpck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwP3FrLy1QwNmN6PYObid4+8BDOyY519YFsVF0Eb5/gaIqoX5pfSltp4XV8bAP3VbZbbqhBSUbuxeHN5WZsi2qMBdpRrOsz0K6nHcI4GD5GpVpDLdUFwo6huMC+wA9LcVXclYRXbKHk4FcxXoBYfpv9hgglsZpPPxDgT25S+UVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=LxdH/ycz; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="LxdH/ycz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtWr52lznOv+AH/1PUE0A6xgS6PuR+AK2/huHaYApYZsd2yO9MzBppnfpWfKx5wJhHjbPAqAx8JoE86ezaqZu2Jx3UHoDhnMrgqAVfZvZwE/bcvEXizryhLe+x/PNYrd1EocDzF58JxHF5TFHbJTVNyza8iEeOML90FW+1WPousM1/ixz+NY32yPQXwW6ldWB7iSXkgZT4MgR94+AMxp7niW+oog7upSJ907SPag/fbHeJKCuNdZE35nR3/Bwtfwb0Qs5srs4gq7cfLFbH5UTlKwbb9wgC96rTG6OAubojV03WpO0s2exNNrtV8f084TPX0LCNa0ZL9w5ndWPGQx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUJQMTMUxUwKK9aYTHIO4ILTtrIr6e0EUAx0wWTFR7E=;
 b=JXKg73zPM+rqQ6d95CuGS3rvdbpzIb/XYHxd9wri80pXwlpLldVqmhHEVzrCaLjnk4OJoqVsXHJrMY3MLxwQ33ATcbpCJUsgFM8VaXXOdniGqhP9DHOZnmuGL0DlkmsmnJluOyqlZ0rMo4yUuT1U+9DwCXT1d5woXErGWkIVn4e0SS2C1YQT6/si079DDDoyyXQD1f4hJQSt6/J2W7CNQx5+tbDKU1S5Rsicox3pHtwgM9lu3kHilwuHpJqeKzM3h4GajK7Us9ZxsmvpijF6K+w2yAyPUu08oqyLwhGkgaNXdIZ9KyvUwlXDTlZmQAWJM7+qnJNgWSVaoWhj9WzDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUJQMTMUxUwKK9aYTHIO4ILTtrIr6e0EUAx0wWTFR7E=;
 b=LxdH/yczUDljFGEg1rXaxnfk4WVUe0O3L3n76EallcmTjvHSDAx4jSou17kP8N45uCLnpsNPICBQWvueSBD9Zbs31u5TUu7tTjstKEgVf5+UyH8En5mO/5cUIVF6Nstn19zosa1F75kuojE7iqMTEnFVy52dn6yMltrF9KHk0t4=
Received: from DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) by AS8PR03MB8442.eurprd03.prod.outlook.com
 (2603:10a6:20b:528::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:18:37 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::87) by DUZPR01CA0060.outlook.office365.com
 (2603:10a6:10:469::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 16:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:18:37 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:18:36 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 06/12] src: replace ATT_PSM with 'shared' BT_ATT_PSM
Date: Wed, 25 Feb 2026 17:17:09 +0100
Message-ID: <20260225161715.20394-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|AS8PR03MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7b41e9-a932-48ad-e0b0-08de748987ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	PJs013SqzON/oLJ4L0GAIzMElnxR1jIJy/dmPtsM9uwpVJ+Tj5AlSB8aSV1YpSUpdQ4NPQUBt5pUPrP99z0zxOCxbEPZbLf4rNDhhFI3gRYbHssxRXIrY+b5JyUrRwWRT+VyuYU0OsrxySCgjx7T4eyfhoG1+QIejNbJQbEYkBejYfzsAYFISIQhqHu2wrWghMTYnNKKCt/BgjRp/4+yTKK33UOcfWM1mGSkiwLzFOR5BCT8mKgLQfFCtnGsUl+yE0jFHoax0krqU+VqWIZecDHaKmT2M1U4K+lhx77gRFD5arVAubmO8dFqXmqcpDTb64MZDO5jNMKbcNY9zscRY0boUEU/IbWWxUL1Fv1GfGx2AC8HoRxjcXjIsKxauJoxMcsCA6GoaPC0QunfvW5Ly9gb1Rq2kJeOTB1RoNVZxIKHgm1LKbOz+SonnU7oiqQMV8aP9xrukmstV8GszYLuCr6Uv9Ft7NLTLJK05zDiDD38drCD5j12yZY/WXPqtIuistLfqRWVPN9wiSE8GDv2rcIk8iNO6LI0n+npsOwmvrVQFWpZJ6dnBHS4Rb33TEwZYOFS43c9IMC/+rLvnSQIue7mWEI6YfR1B5XUZKxQwQuHQbZfF+ZpjQ3v19IjkdHtBzz6MKbGVJGUUzv502dwU2XAr6MxA5a2+nuNcTo/sYxoryZ48YGWPQ8L9RQJD2GAmlIu/zBEIgCrSMxGDbG9vuK0+6REF1JHWMgXsT4CohXumc6O0ehlendrK4TH4/PbScDNf3GkfXsefyYqmnjeQn6VOaqmkXIU8wUDuEXzmBQ5wE/2Cn6F2/dOB+BFlUSaUxAJWD7XyjxGUH3G7sQ4cA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	thw+D9sXbXf7cxR04YDtu8qZjE3juU45OUsWQm9w7bHgJcDSKr2YDXpv7y+fvGkdcW5AFo5PcNGxn4I0S/tVCdyQ67P4fpbuvsv3e9bQf/bMroRR4lg1SXmuBdvys5taJ0LsYj2QfSKl+2Tdp/pYGu+y8xMWB58AkhATxl/vLzx1CW6F3GVO0SJC+XPkuElqdnVvbCRO5QQE3R4M2lXe4iRMyDpowXTNQBVi+nnr2s4YbBOXBT82zjzEW9M3QINFjyFN6YPQ5vACltF8LThvOIDcRZ8tWx8cOw8tySjBkl2oNbns0Hxz4vPJm4k8UUrG4z6YhdcnXRFEf4PFc21XRYXRpzayh8BLEKINRBXplZ51DMhrdrO/gSC5sQSGnZlhnTZrmloec6DGy7t8/qjNSCwsNeahIye1FMuf39H1dcGash82xcBA5GI8AUHha2ct
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:18:37.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7b41e9-a932-48ad-e0b0-08de748987ef
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8442

Avoid multiple definitions of the same value.
---
 attrib/att.h | 2 --
 src/device.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 613a018ba2c6..8d6ca5930859 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -71,8 +71,6 @@
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
 
-#define ATT_PSM					31
-
 /* Flags for Execute Write Request Operation */
 #define ATT_CANCEL_ALL_PREP_WRITES		0x00
 #define ATT_WRITE_ALL_PREP_WRITES		0x01
diff --git a/src/device.c b/src/device.c
index 2efbc1e148a8..0ef7dcc244d2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6097,7 +6097,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	primaries = device_services_from_record(device, req->profiles_added);
 	if (primaries)
-		device_register_primaries(device, primaries, ATT_PSM);
+		device_register_primaries(device, primaries, BT_ATT_PSM);
 
 	/*
 	 * TODO: The btd_service instances for GATT services need to be
-- 
2.51.0

