Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8EB288D6
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979672; cv=fail; b=bpQze0DC6sJzsxqxf763TfWxfIiLJEihzCfLE3A9iLXIlWSiC5SJybF9a43pu/mw+nMIlObRdeCb5PMIKn7vOzhU/y+bbEORoEMpdoy8PrHS9wfL/Gg3LEKEwSxgkjLfEtDW27Azg2UBsq4Gr04LRGpRyHHEUtE3XxT44ytuGIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979672; c=relaxed/simple;
	bh=YlVi4xP8NmGcCqUJeokWUrn6za107klQ86nSk4X0oZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqsa3OHXfgowbqV/XH6RKz5BK/NcmfQ8XUEEww3vVuHPRhCaF/IqrEPC6mYZR3BykQYyE/qdRwdMMx9rZpMcCCFwtPswYY1VhbKxEzhKfPagjZjrc9cGsaOwYmDbVaIgdIqSu90XeIhLjL6WYhrVlSD7rBlMmr6ahyxHUo3zDKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=SyFNs7hE; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="SyFNs7hE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFjgTPBLptFob+RReq34Gp5FGyK1L+mqJszWoQ9QA6xcaA7fs0b6Xym9I7T00zyAVu6IP1eSv2ST07n6M1pjFcDQ0W35BcrBmlo6gC0aUkoFv8UnhyL+KA1/ub6j+FUw/cyF1xG0OFg96WifMOcq1litFoI4dfMCiJK0LFmCaiuq/5pAHob97V83fDZLXQ8tUPsHNcN1a7DqKoTQj9Zjd/psM2RBgmHeZNnm0BW4WIrgsX7DYr5V54/QZ5923UFj3hQh4yE6MSfPjnaNKm83v2/ciHd6hhWgiyZjSIAgF5lchc5RTD527P4XBxISOICOupA+rz51/b3wQ6hbCccUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzaZAP15PeXIeFHw9iUG2aZkeG/8MOUnLZlDmCHOoP4=;
 b=Anb5iRrVm41iIe6OHoznkRFCuntXLhITSw37HOrLCbLZiNJpZ7kjWqWsUcmdbMv1AGkhIx265BJRO+wNeQ3cbg+eo5j1/wZWcoIM4mOKMm9IHejSUp69AAxaTIMdzOh6SvoC0LduyPn0GvUtRSWp/q2A0hy0gPUB69gif6jS38BHsDQeRLd9eeqd/XqIomdSop4jUM6niwb88yTaAmJh49Ai+iYcblDBvSEfO5+u2F37M0xx4TckKZS+7IBK02UHe8lK6zZt+YDA9OLnFw+SrgDxmgvPu7QgZVoBW9ufgPEa85Wbzeh3nGaY34DbPe1WNxEl3VCFFdk3rJyiltoppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzaZAP15PeXIeFHw9iUG2aZkeG/8MOUnLZlDmCHOoP4=;
 b=SyFNs7hEH1/IlY/KSUuNRZ3zhgxUVGnVc8itIosFT9ojjjEhUBwVvrOLmCFU9ueezGxduDYXb8IfCch4cV3VA+GWqmHFHXCAiq+zagITX1Pd2Mr0oJkMIYKjfL27cwEFZxIm2VkJsk2j6s5FeiW5jIS6u7G+XpT8ztfF/2IgNzg=
Received: from AM0PR02CA0032.eurprd02.prod.outlook.com (2603:10a6:208:3e::45)
 by PAVPR03MB9526.eurprd03.prod.outlook.com (2603:10a6:102:304::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:01:05 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::61) by AM0PR02CA0032.outlook.office365.com
 (2603:10a6:208:3e::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:01:05 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:01:04 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 05/15] mesh: mesh-io-mgmt: Fix NULL pointer dereference
Date: Tue, 8 Jul 2025 14:59:37 +0200
Message-ID: <20250708125947.11988-5-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|PAVPR03MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fa5759-1cce-4bb6-4285-08ddbe1f7fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kV50xif51fRLfMNwBoYDnE9sS0fk/ujybVGREaql/7myrLzyYXv2zLKWhAED?=
 =?us-ascii?Q?CdBYGUW/8170k8an4y4mpqK4EjWPI/IZKGWD0F/2Riz93E150COmzZ7xBaT1?=
 =?us-ascii?Q?d/POv0ZyfjLf7UljZ1Ry3Ed8fIzZPX4PBjGSBku+0mVXQir9h6GKmBzK/QrS?=
 =?us-ascii?Q?rvvJXjN0drhXPlHry5r4cl2WdvmPBtclDI+cl6Z820kEjzD6fGjC5DxvKEuw?=
 =?us-ascii?Q?V2FJFZE8UgBUZB0Wzt2Kg207x6MXa62/22vYfyv+ejsyA14Bitgyubo6lwAr?=
 =?us-ascii?Q?4/Zm+AT819BZKOuOrEvbylxTIT+20AHjmMLHlTKl8K5GiXevAJ7+e4tE7K65?=
 =?us-ascii?Q?H0Q/bZRpo74y6iaIQfUyg9WhK0ywQoDZim6FKu/V0p8cvuPVpsqdx0uWUPQy?=
 =?us-ascii?Q?NMfUN/CVC3PctKZWN48hAvm0aufRg5q+eO7qFvHEgpEdVPZ12f31On3u1/1u?=
 =?us-ascii?Q?WpPBhNOnjGnqewVSVDkPGikn13bNfz+XgL5MRGGnRcgpp4g4KPszW2bI9XTi?=
 =?us-ascii?Q?L+q32k7aUl1EgLIwwLwYP9JbUpBpVUQebHwfURX9upPEyLVY1xlcUKG3BQ0V?=
 =?us-ascii?Q?LLzvF735mYAPCvhJyLIW+gDvdzIgon5WZAkHCXzk13YYUCiR1hZpMT735qAB?=
 =?us-ascii?Q?yAjD5zuWGMePulSrX5v5nACBrVjQHeR24annRd1RPRy3QtlAS4ynDVKyx09c?=
 =?us-ascii?Q?f13M1rQWiDeFL7+PN5CRbfZXrRXrQ8G54+ohmbEKqJjJeFSjUQM/fnbHyZHo?=
 =?us-ascii?Q?WsCwxdzZC440p6YCEF2kkFhGRskOu7FH1Tm2fmc75rp+hSo8L0KDQcOTVzuK?=
 =?us-ascii?Q?uLhEmye/etIwlpdDcyVC6hZHMyHsvjSdj039OU1QuhGtCsnVVTmFc8hceZG2?=
 =?us-ascii?Q?FFxaSCgVQK7nZLoxDtZt+F/0WJgx2nunQVqaO0JzFowBWJIMEolehI66No7u?=
 =?us-ascii?Q?KRgHFQGjP2HLWOF7wXIiIZz6+/yJTollxGqBgjUx4VD0qdP6ODAMoE+nd6yD?=
 =?us-ascii?Q?Bubiyx7ctWdOJLQDVFSCgz7ONFsEsi+dtNkANNF5ynRNhFL6CBhknnvL1Ro2?=
 =?us-ascii?Q?qK4XqyUL6lrbzA5fyeQctJ8E+gJ6WPSJX8fy7Rn0MVsDsn01O3Zn0AH1GGbX?=
 =?us-ascii?Q?3szgmyZsjGCvaCyu6FRPI7trzLwhPAiATsURw6SJ3NbXpTK+OR4sTcZxPHh2?=
 =?us-ascii?Q?++eWbsK+GJm6N95jRXxkHRFG4dCBv0Z1mbg7JABFhezVEDeaxSanij2s6SqC?=
 =?us-ascii?Q?zkok0U/ne5YZsIowd289SNwqDCQSa117JJNW3YP2lCE3E3iJLEZ5hO8WSTC/?=
 =?us-ascii?Q?qOtlvns+sWJcdmOAb+cnndfHDcWYeoUwfgODNUvxl0OMU13TM6kq1GAIJ30U?=
 =?us-ascii?Q?bZ1AHst1aLAHX1sH10EKtGTck4zfafNpJ/Wz7ZLOgYgP6xRI8cNG2ojBBv+o?=
 =?us-ascii?Q?+xlgLlCUYS4eAv40UvAOo+Y6OFd4PrP9fAd4dB6cIMkwS+wnay+AfplS6VvP?=
 =?us-ascii?Q?2iLxbgIxY87VAY9g3ciiRgowDCwLaZB4z0Od?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:05.0568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fa5759-1cce-4bb6-4285-08ddbe1f7fa0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9526

Don't try to dereference 'pvt' if it's NULL.
---
 mesh/mesh-io-mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index f33f64124bd1..0d32859794d5 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -138,9 +138,10 @@ static void filter_timeout(struct l_timeout *timeout, void *user_data)
 		filter = l_queue_peek_tail(pvt->dup_filters);
 	}
 
+	pvt->dup_timeout = NULL;
+
 done:
 	l_timeout_remove(timeout);
-	pvt->dup_timeout = NULL;
 }
 
 /* Ignore consecutive duplicate advertisements within timeout period */
-- 
2.43.0

