Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBA262FEC
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202796; cv=fail; b=ONLppjjtKyIAGlO8iDJ092CWrQ99/RcJXmaDTfwfL48mFVawia4rarg9DDmSQ9+bvPjvEGcvdTbg6oTlEp+9K+YHz4ZY9dhp+1gcUCqgwUE97IA6I3bHzX3IvyDNTMzxkQ/OFFHSnHrzzKsydCS2MmF+lNu6QrSlIU+aKQbsPhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202796; c=relaxed/simple;
	bh=2xFUblE1/20isZLoU8kFRrB40YH9LGIMYsEXd+fEnZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk9yj16CtnsDBbRGEpZG4o2BX8VvaOU9WNkUOJbSasus+FzfwVrOWnYHEROreNj3tdaWZ+SMx7iVLiijpBEudVQ1Wedv8jCUXdF7A/kp61gZ6kFdnR1PzZA7UnYeGnB1l4B0bbVOjHHu9TxptFfCok+e304XgIQYfdBUhYAR97I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cyjC9n/8; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cyjC9n/8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmuxzbzEh9543gM0hZbDLnbLaqc8n/PeyhLya3ihPammoU/XakJd/MeXXq7o4ThB1+AtenYZ/CBouEtPENXlS5j7wdfwwUPdslsYPYNbrj1xkh6Kwa1Tcx7naSxIuxjMXqw19mAM5DYtIkRXmb5XFrA6r0teH1MvElSYYg/XuyXeVmjGgi4s8Iab0vDiAXqiiNNj/KBWtQM1vvL0YtKfYq/MkZAXIYnGUo5EXhHKz+nNI3zM8oLCWW60C1oi7yEyLv6314E9vDsWSUYisuJAwQtC4CZyJd/DAK+nCKEF4zzuAZ+7bdwzyd1lI8sphity81tgzWoiGdxn+iV8fcm6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ATthFnJOqevpwWLb9KReprMfF+YGv6xBdTwVqllMTQ=;
 b=itq9ft0ScxyTZZx0t0PUUWSi4u/ZDHOuZ3fQpvMzBhT2CMVF4LVAjxKlrHHZawzSqpU+olsFWzhdejyVy6F7dnW2lLn2zxtucxgW+fd05kXiYAGOFgnKNtv2k4tRsBCxtPePkLFgIpQhaqgHRPwwBu2J4ZuyT/ckUsEIRJ/R6X70t1xGzVdoxKNq/9ykTedSw3eS/OuVpe+Lh2wGwALUM5QfR1Cx7ACXCV5CPlkQ/lgSskUjf559vodBMbliXQWyaOZO+0+0PjTfneQ1XG7xLboYSj2thkj6qlGuCssRakdVy0S22/yx+wgLDniB8B8KaCqKh17gzEwxOlJhMRyvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ATthFnJOqevpwWLb9KReprMfF+YGv6xBdTwVqllMTQ=;
 b=cyjC9n/8XQL6A4gRVSOWQ4lPijLJZxXQy8vX2OqnZg2+BQe4yINCZltoJUQHUKz9EKuu6BBI/uKlwQJeYSyUbyWiMQlzpzM6e0VUTf2gPpObl3KuvB9cLOmS9nRD4sxq6Afs7zZPOmTAUe5rG20+4LQXSiizmc7zBpYv/dJm5EI=
Received: from AM0PR02CA0181.eurprd02.prod.outlook.com (2603:10a6:20b:28e::18)
 by AS2PR03MB10112.eurprd03.prod.outlook.com (2603:10a6:20b:578::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 14:33:11 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::33) by AM0PR02CA0181.outlook.office365.com
 (2603:10a6:20b:28e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Fri,
 27 Feb 2026 14:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:33:10 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 15:33:10 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ 1/4] shared/mgmt: Add mgmt_parse_io_capability
Date: Fri, 27 Feb 2026 15:24:22 +0100
Message-ID: <20260227143242.5204-2-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227143242.5204-1-ceggers@arri.de>
References: <20260227143242.5204-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|AS2PR03MB10112:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ea9995-71eb-4b2d-0b19-08de760d21f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	ejhdLYCj0BMrLSWgWr40RzGu4SanYe39S6w4U604Jrt7ejYv7+RzQ0hgBFrMH8va04lnoQMU1YmC/7Hkx0JGCnKoyM7iURVhFj2Eu+XJ2iKunhNQBRaVNCyvk0CW2qhEExcS6T5+w26aMWPUrXGIga8BFGnTW708l8r1iven1kAkARwmR1md0pZsijbhauT4RUZzJUo5ifzVhAg7KQgDN+9if2W3cfapfpeUo5Tci6+8SJsKU4TRPCMoeDz/PtHfvII4lyVL1IuY7Mt058oie4qLsK/FH68jsodUOJRcK6r87SphTl3EEKGNFb/LfrvSM1T2J6edvxcDTAiigj5mfiobvemUorsC7AOkkLS65tofGpX/HZpTzudigvkaW9rGlquPan6RrarcoZ5HJAmtF45AurxLy+Jwl+IdsMJ0UrOgGyG9P9zfdpEScir+C0qyDYCEe/8bqdl2FE1tr8RCaUgsaezVH9WkoMWUWPyRLuI9A89IKvRluTsN70sHu2Rx4lMSKbrRQFr/x3TCmo4es40P3AIZUwVVmTpMC4SpGl9M5kxw+3l0TRbUzVKF/UkORrstV7x0ol1gKgeQEGFaB/03uD63+q2TugcUnLK+H0z28YBUmioJK7LFMdM0cRDdVZUOoZ4lpmSZsSbQoGa0onIMDlVGQDhtXmniign01l8grdrrjP7eUHeHr6SRQkHwohXVf3l+LZlWJPXrCFRgVMCj1ntscnDKl2w/bLaX1RMLBpkHyZIoXTUk2ZLv6dUHCDhUwUTBIA1WDp/sCCTF51PBjeNRu2nM8Gv5Pbwb+B5GNLFJHlqMi9vTrnpbON07S4Gc0oBVhqGF/x6CJ6EgYQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OZU6thZZaAUZwOXnfmk5EglGd03YZXyS2L/HuaQdSfBKtGdgVQbZVTbPXXymht39tnF6rtSOp2ZF0easwQx7LvP5GOi4GfPq0Y/6TrU2HhDu55wSHtTSf2Lwr1svhVa5uO1oTFMmmkN0klTROSnh4XXEjaXUrABO97z6yCF35Y5E6X63CSSiKFmvg4JiHI6XTrjsWkgWtFgH7F6qiEuymnm/LjCudIhsqj77+Hl5G3fFEklVjS7KxboyuveQeC2Q2KYJpf64yG8iX8hLFM5tj1+yFLoZzHm0+ORbdl6EsPZ6ovMp7p3b3CDmtiSnY6oINgTtz7+otd7vygzXbBkD8+DwMjsPu/2Knpx0AGlkAF2RFFdPHrzOb2jJ+1qQ9C5stpMDx9Dtw7n4UmTPcQFwCj5afUKlLtF6UiIttwPKbH/SpTPeOV+aXPMTlGpiau2G
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:33:10.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ea9995-71eb-4b2d-0b19-08de760d21f4
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10112

This can be shared between bluetoothd (adapter/agent/device) and
bluetootctl (mgmt).
---
 src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
 src/shared/mgmt.h | 11 +++++++++++
 2 files changed, 43 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 6a7eb5798cb8..930e70a094d0 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -81,6 +81,20 @@ struct mgmt_tlv_list {
 	uint16_t size;
 };
 
+struct arg_table {
+	const char *name;
+	enum mgmt_io_capability value;
+};
+
+static const struct arg_table iocap_arguments[] = {
+	{ "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
+	{ "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
+	{ "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
+	{ "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
+	{ "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
+	{ NULL, 0}
+};
+
 static void destroy_request(void *data)
 {
 	struct mgmt_request *request = data;
@@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
 
 	return mgmt->mtu;
 }
+
+enum mgmt_io_capability mgmt_parse_io_capability(const char *capability)
+{
+	const char *arg;
+	int index = 0;
+
+	if (!strcmp(capability, ""))
+		return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
+
+	while ((arg = iocap_arguments[index].name)) {
+		if (!strncmp(arg, capability, strlen(capability)))
+			return iocap_arguments[index].value;
+
+		index++;
+	}
+
+	return MGMT_IO_CAPABILITY_INVALID;
+}
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 2629fbd59cf6..c99f2ff0620e 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -89,3 +89,14 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t index);
 bool mgmt_unregister_all(struct mgmt *mgmt);
 
 uint16_t mgmt_get_mtu(struct mgmt *mgmt);
+
+enum mgmt_io_capability {
+	MGMT_IO_CAPABILITY_DISPLAYONLY		= 0x00,
+	MGMT_IO_CAPABILITY_DISPLAYYESNO		= 0x01,
+	MGMT_IO_CAPABILITY_KEYBOARDONLY		= 0x02,
+	MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT	= 0x03,
+	MGMT_IO_CAPABILITY_KEYBOARDDISPLAY	= 0x04,
+	MGMT_IO_CAPABILITY_INVALID		= 0xFF,
+};
+
+enum mgmt_io_capability mgmt_parse_io_capability(const char *capability);
-- 
2.51.0

