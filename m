Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643A22D4F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011112; cv=fail; b=lYRHWen4OnjMgcy2wZBHUxlBKiNyyuTKsafMa5MYoSiNpJRt1+I35Qy7hRkCl+Me6WrrGKSowHDrS0AdOCNoYxTqQ76Wp1jj4zYNFP64QXk4Vw8/bVI4XxOqM/BoMV3q18lrpbJM9iR/zsuQ9qfw1OISW1zAN9nYWRzpe5Q2Akg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011112; c=relaxed/simple;
	bh=fX4V4Icr/O1C4eVbzRVkoHsrEv24fUdylG62HHA/Nz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLtBjqz25LsSrLlQf6oMqXtbktOPBymKCINuJDytl6Pw5CfxxulPc5UAvXNIQBC1mmAGF82o90uLcBUdFywhAXtKGOCqqk9wYRMsqyNsq2uAhmwRIcWqbAI9k6pU2wKMlI5YXmkJIIAdGIqgFuLkxeXXIxlPPtVeHdhJzZpXgug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=BgoweXgA; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="BgoweXgA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJXdqJuSA0crWgXac5j4z7ZMh4AezSRnDDzHh/MNvsBUe4lsMqdqKIDSMCJ/ee9cv468wVFzLWJ6xpxGdlQ/UScpjzL0z+LiekLvwvgQtCIg3rypXvcpAGJbE60WMj4DQHLI9RxdCX3aSNaxcty0gD30xtgpDcbNjAvKPY6stNq4RvzMKHZoAJZkZCl9XtBi/Q8obfX7zogd3WL3tm//k2Wm1sKUETVncuk3QSu6dw0B1gZHD2+PxdjtyusAUFkTnNnQVZPlJE9pmLazoh4G47XL1z/kztgUbEd0zqHm7viulxwkVoqpGV89aWigCzE0P96pmmbkxpIY202vbqi1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vQ+XqeUp3/d4LjQbflAVEWBaiIrmi16OQkBoQd59s=;
 b=DZ8l+zXlfrpGZqetjspMLVRi+Bs5a+X8C45q2rA/x+72W7KVstLP6a958dupd+JnjBfGxGBApWxKz6344MbixqCkWrjHOHS1QqJei+yKSZF7Dm5UCCCObPLTaYJCxZNJ8luwgy+7HDoHlynRDBI7MXWbKnlqSv4oevDRisBmBckUl+4MNl1kGeeOqMsTT4rW3r477vpChZuLktGifohE7KYx4WE10oS6HcqEQz8eTKEmPaqs3h2hR4Mg+PV2C3SCkkrSJt1pxC9a4NFPrlPPKQolg8OsJ+pXBeMJUs1LYTW9A+kd+mL3A5zZkjqf/76nV5PQ7FrUVCwQyGWmJDLJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vQ+XqeUp3/d4LjQbflAVEWBaiIrmi16OQkBoQd59s=;
 b=BgoweXgA7XR6yimRUPHWOb9SOh5o5BG6SUsQ0SzJunykoXg3IS4vIAj1Z8K4FCa/tzi15btsoulJbCM/ygZX8hcT5iACFkCfZlEIlna511r8E59S94Gyb3ursF5MmxYfQrbc5sFvgxTTvQE4u1xNb55NQ16zE4CuMiPdbPOZRp8=
Received: from PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::14)
 by DBBPR03MB6809.eurprd03.prod.outlook.com (2603:10a6:10:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 07:58:26 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:102:371:cafe::70) by PA7P264CA0248.outlook.office365.com
 (2603:10a6:102:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 07:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:58:24 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:58:23 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/9] mesh: keyring: constify
Date: Fri, 27 Jun 2025 09:57:58 +0200
Message-ID: <20250627075805.19597-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075805.19597-1-ceggers@arri.de>
References: <20250627075805.19597-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|DBBPR03MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e317c96-05f0-48f6-ff32-08ddb550645f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cb6k30pPdsFo3L8fMFMVi1o+yc+NyRHcIiStQVYANb5fVxqeFxK+bQqaKFkk?=
 =?us-ascii?Q?pyB3KG/cl/fLbIFNGAzMrGjVey+7W5ta28tICLjQwxqQQojUTbYHOWQk2+gY?=
 =?us-ascii?Q?nIVODeAF8rZcC8CfGGUcrtXmoDuiLlcLyTGI+tbI4xmhzsfG/VsFZ6g/ves7?=
 =?us-ascii?Q?BInhbcL0GbXGWIxZFMTClvvp/scRD4nJ+XYYxWtQHwNDsnPVif6psOD1E2n3?=
 =?us-ascii?Q?sJL1+EgdrGFGlBNAEqigySZrsKiGEZ882m29eNhD4c7/5vH+j5Z/rqmVKaJN?=
 =?us-ascii?Q?4/MiWd5p/9IGk0nO29+2iUzGJjvIBDx53cOC0umwU1v6Au3nC5jph/jMbct5?=
 =?us-ascii?Q?zgCwaapWHVIEQYQkQ2VWwN56hKNfs+qMihH8VlgHsIwoKfZoISfZtv7tbfDT?=
 =?us-ascii?Q?tdn8NBgeWI/T1nj8nS2vWkIfZg3vGPC/Oe7JgN6q0RGJK8AHrt+V53eaYXg3?=
 =?us-ascii?Q?+ImJO5Lv2sWdF7kaoM4K8PQj3MwmzWiz+PwlMn9dBbCHuu9LYWo9lWlkgS1i?=
 =?us-ascii?Q?3x/uHzv0LF0QB/phOjS8E7wUkB1cMdKShqwr7AvCv+ozXZVtwfe21EEHZXwD?=
 =?us-ascii?Q?AKKS3ZR1nJnhfKA9ykKxUbMa7u10IsoX+2hiyFMyoh5mE8+Gm3E/myB0DShB?=
 =?us-ascii?Q?ZS8w8mSqwvnBkn6NMb+LEdc90YedR1pIw9NbDocre1C4Oy2hRd/gAPCqNTzL?=
 =?us-ascii?Q?BGCDHL+vNSoSakWEyBdwuM1uU+MIHwdgX9d2RtwVpehAPODKOqhCDi4ABitg?=
 =?us-ascii?Q?Ni7ZHOXmyuZkGccxRbkt/ixs3t+veiCy0WZ4KY+wWSkJGqyx2Z43XGpFHJUo?=
 =?us-ascii?Q?n2RPkPUONGcJS0suPyP/UDYg1JV5GTSihcjC33zF3r/u/tQSqiTs3m9EfjA4?=
 =?us-ascii?Q?H9Lu26nQ26+2e8rFOyWfvu00yJRCYfNn7EQXuoLT2a1fQuyq88lNLxyG8wKT?=
 =?us-ascii?Q?yoyI3SS2UEaxgNStNg9FlYU/ukmzfmuDvIOwdHbvIoQIiA//ogkk61v7FMGg?=
 =?us-ascii?Q?7mYS9UHJOg9yC+WTV2wOxJxGNjslXwc8Wd0cPbdWpI8ehqses30qWaV2sumY?=
 =?us-ascii?Q?RmLEcLQ0c4RX1e0/3UjHLXpM3+kGgJLigfVoX+ZwUUhDC6xJuUpHG4TsEoHV?=
 =?us-ascii?Q?O/HtYwKT6k5dxbcwva3FIqc98OF26AXz0pVnHg0BXYnKo7QrUbwjzwaZH9Dk?=
 =?us-ascii?Q?qFLur7sBLLAHzxc3zqic3tyYVIIm3hAfDjk5z7dX9a1w7G1QtNa5FKm2vnDY?=
 =?us-ascii?Q?c/Gy8HrnFcJ8OMh01QJkdEnzOfyyKmGTyeh8I8T/FY0Zc+0lWb/KbEhUMF+0?=
 =?us-ascii?Q?l3BJIEz/SkxwVLxA7cxAj8TyQ5lTDCYbCvkbPGX6KwppE8E0DA4jOQxrmI1c?=
 =?us-ascii?Q?UP/9+qcg2IHxx/u5/6kF2l18BEH+zVP6lCJoZX36q/ajiL9Z3oMla4XAHnS6?=
 =?us-ascii?Q?CxP4VhQzdVIZI4ay2C7RIQ5dAAkNzii/HAelw/VnTXIIMBWx9pP/G5pIGN1W?=
 =?us-ascii?Q?jcAPKdvoq8f209KaMeDNZ/eaD/Ml76RxDWmO?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:58:24.2065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e317c96-05f0-48f6-ff32-08ddb550645f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6809

---
 mesh/keyring.c | 4 ++--
 mesh/keyring.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index cb091e15b613..3a09876777fd 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -67,7 +67,7 @@ static int open_key_file(struct mesh_node *node, const char *key_dir,
 }
 
 bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key)
+					const struct keyring_net_key *key)
 {
 	bool result = false;
 	int fd;
@@ -191,7 +191,7 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 }
 
 bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
-					uint8_t count, uint8_t dev_key[16])
+					uint8_t count, const uint8_t dev_key[16])
 {
 	const char *node_path;
 	char key_file[PATH_MAX];
diff --git a/mesh/keyring.h b/mesh/keyring.h
index efc499ac267e..e2088edfde14 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -23,7 +23,7 @@ struct keyring_app_key {
 };
 
 bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key);
+					const struct keyring_net_key *key);
 bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 						struct keyring_net_key *key);
 bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx);
@@ -36,7 +36,7 @@ bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx);
 bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 							uint8_t dev_key[16]);
 bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
-					uint8_t count, uint8_t dev_key[16]);
+				uint8_t count, const uint8_t dev_key[16]);
 bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 								uint8_t count);
 bool keyring_del_remote_dev_key_all(struct mesh_node *node, uint16_t unicast);
-- 
2.43.0

