Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E8329C57
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459324; cv=fail; b=Lej7Tc04phEYG7lmnak7VIg8DKob9luHIYTIxqurqf9WxS3LPgG/8FcnFljXg4Z6k/IueXDUn1rXaljNImAkRDcJEYQejTp+DQZA3JLt0+UrnehNSIWXLGo3e9QWB612+ySm0MSLT9z5uQbMPHKy9wjjEOmYOL49U01SD/Ohyag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459324; c=relaxed/simple;
	bh=UQMkR0b0AAoydrSdBUorDNJE68N+Z4JahMOcB5rORzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUcrG0sbTY0I0nVO0JRhn//abjWgJm/EVOy21/D0la9AR7PKe21g8FtRyv117SFhXMCAb9ppLxSwOcehHfHslba718SpQjBlGeEl3uaGGx4uktKHVLLQomdD9XA3TLrJZgQzvR9mlqOR/2UzpZq337eH/RvhxaHKf8V7EjQbw/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=QUfvGXB0; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="QUfvGXB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdMN4+8qpLtiuL3FCUSp3atMeIZ3RdU7YiORhIscAPx0lARTL4mCfnRmXKcrY7HLK6UbMGMRx06Gc+G+JxN0r0VTdv72hV/UNEsKQwFrrpVvXiwOHCmRJ10X6d89Qse6h99TbIbCOm/6i4Tz329lYLCJlOhpFSs5vtjtJWHgVvF9sN+NgF0sp/SzLvm30btgEkx+/Imq9STdd28gfki7Jrykbrdq5+Bcrtd4ougc55r2yhK1YXNOFk0f0Z2wD2kr4n1z9uo9ixD1jGlPZbvh5OND8PQs61WsjG1xC8GNEcvAngzfOfpcLK8yrjZmjgNdKclpgWZI4RDEY7nBGrKQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tvUui/lu3klhfdZd/WjeD+F94TeFY/5oa8An4WtRnc=;
 b=XJ8pPM7poly4/Z4sq1Ol35q38/Eq2EttdztZTbj0rk4UUKXcT6bV/rBsThnqDJ/A3Usa6ruf3v2RhrYRKQBEnZrwmVVm82CZZogyNXZ2C4b8nceQGcGpEI75yTt7SjnHWSd6EJkxhW7De7giN/YDF3lApuFjMg0qxSseKs33q+anNoRpU8kBHYF9pk+uPWNBwDb8fAbxZ1j/gH2RIddfJjescJjJE+1J9GIcW1SjHk6YXaf4nhd8BcxQ5+1PkIbJhjE0K9nZ0AHCKn1qvEcf15IGCFINjeh3eB8nYDbF0lj1lqxlqykxB/odqh81O/d08fW8WfmM7hArS+Z+xU1KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tvUui/lu3klhfdZd/WjeD+F94TeFY/5oa8An4WtRnc=;
 b=QUfvGXB0gebjSTjpZPAIFAaeg+8xcTXIUG/efCaLWrNd/eYuXRyX347ovIz1iv7KR9PxGOhodYNyUMVu5teMxyqQn0HLhubEx8O0k1YknT/lx1Z68gTn2SgLgBttU8WHBIRhxW7IM33aIaYucr1osykYr8SDoe02UWHjK71oGo4=
Received: from DUZPR01CA0331.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::24) by AS4PR03MB8625.eurprd03.prod.outlook.com
 (2603:10a6:20b:588::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:48:34 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::84) by DUZPR01CA0331.outlook.office365.com
 (2603:10a6:10:4b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:48:33 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:48:32 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 07/15] doc/qualification: sm-pts: add description for M/PER/PIS/BV-0[1-2]-C
Date: Mon, 2 Mar 2026 14:30:35 +0100
Message-ID: <20260302134540.25540-8-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|AS4PR03MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca3bd62-dc88-406c-3758-08de78626532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	/ZMc2HVFLlQyEKYsS76+Ik5zi07mrk4Voz2hiXlrUga6A5JgH6sSR2uV3buXX5T+Vv5tLKyT1ID5hoseE8WDWFuCqY/fy314Cm+4q/He4axLttMYu8hpmebyZoY+iJhs7HS35/DE1pIoreworXs4xbtLOiIcsy64et5BaubdmJjmWZPY85DW8itDbCS1S/W38Aooe8Vj72xsWbqsOag8hgTdPKMxPcpSBbjucMDf852x209ZwzdBna6sTczYoaH5OKFEAzK2CyA7BXfNnC+7yRPqF0mY63dL4tOgUyVgCqmTYT6+EOtV1KtV8mJE+/lpgn6hWT4l7DHULwFmu9Ue8S0bLvd74dR8mSbos5gUqJBDYpT8GTZFpNkph8fihVzZnEP2WjfqsI3TxdruMKZbZL1IS96jXEHjfCSWF4ExDUsq+g8hnK7vqiD3VUYgzmHkIY5QUS2JQxhr4JxGxPpj8nMPkrBYwVizq/Ow85+hzJhfCLnwjONo8OfOX2EbOaqd6m5Wy+XaYKKRpQqMw3KFAThh0kH12KMcD1q7GAr+VirZcOD+zYi8zyCY2kr4VofR+qHZ6PTMrStNrdu9Cd4vHjpfCFgp0Pmc+KZgPIbOgW3Vl3mypdkMW0RCoBAIfnKmHlyzjHEt/M5f5IkulwfBX34A4TguLhG7MrDQazSNM5oWyqHs0UbEZR9oxT/8tjUTyf3QdDUMo5qVhb2VcuZNp5PqwOhMoCQqTCEPXycGWeEKWksAyWo2+LPyMZqbJdqPdwFwxMyLo1h1KRDxsNfSMtT8D5Gs/kgxPKRl+bTX+kn0ij+4CttcUI6rv99Jr7PwUtsvfHpjtA50vE67icGXgg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	njyjaDv2gFUz4L/miiLcWDJh5dD/PXIl/r2EnFsjxDrjZSY9mptJeRFCa0G71Fb2qFPdcIc/tO0yV+iUAMuG4qhF+JAUUck4yfwT1jfGue1hWaCSI8f2/eOt1Wt71KzmwOZOI/C2Xx9BIMxaTdFTs0TjNdnXWFWe4mUMq+BwonFRCCFt8BOwkZoHtBgADoT1DzTP/a87RZM5T7TVOFRT7oacqcLXYeyh2SbJKaa8RsAGUTBf3vIuxL28s8SyIqQVDf+RddGEHM0aE71mQcDyS+4tUWhQj61nEd0PcZgoS68RlDidwma1iTPiJTO/kGbji4EYHU5xlIqOEIv9DjX0ixeyyMX9+LWsG/8Jr8cqPhhTa4mg8YsmZ+yynOCP8+oh7iNznLWtf6GQLZSHPaA9UBH3lkMvdJ/WaO3Z5ttsreQS85sTykszQitURYmKwODH
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:48:33.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca3bd62-dc88-406c-3758-08de78626532
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8625

---
 doc/qualification/sm-pts.rst | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 0fa37fcb0a7f..983bf8e45ebb 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -630,6 +630,46 @@ for which we know the test passed.
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise off                                          |
 +----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PIS/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/PIS/BV-02-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent NoInputNoOutput                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent off                                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl agent KeyboardDisplay                                  |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | SM/PER/SIP/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       | - Run:                                                                  |
-- 
2.51.0

