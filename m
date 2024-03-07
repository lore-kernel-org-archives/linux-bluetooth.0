Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DD26AF5
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812843; cv=fail; b=iqSlpcBQx4a6FZhEyKzfNdf2ZTcRzX/NplTENuvGJSxSAkZI00ddmUj+HgN9L1OhRoGA2q6dczdo1+eXnI/NwFsYJNewId7ER83+LNpJ1r7dBJLBzG2ckq2JftQBNVVgrrObV/XRiPD99GwtYvqSErhhJpgp68qYCfmoSJiknPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812843; c=relaxed/simple;
	bh=QP1a/vaf9vm9EpBpDkiYnmvn0yn5fF3FCGCDcbPP7X0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1ao6NZ6eZRexTDMS9FfLgiJVGQFeh0TXQpxQGrUb+bqo2KvopxGqLFDqPKQe8MJVvbxppa1K1ERC7PPbKLNdApvaSOzuxIlZVAuNo0JA1IBnFs1IITLt7giFbz+segV3nfUnFmgM3273RgHrCwe2yVCjsHJckQVGdqvVQNBaN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=biFQCV3W; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="biFQCV3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+zclHtFdGxollsNJByc4BGHkh/U/6IqDF+Rs2Ge5ntbg2KMq8cwgqKfHeZ6329CYfh/B00GyahCeK+uxVy7o8LEcUxYTIX5C29AdLlgUeeHLd9VmF2G32yhz9MnTYiIzNd3iIBaj5v+3MQHPSgraC8yLzMJsTeEPWkGkXHvI0s5NOxMDkjbfoFYPLHiC/s8z8HA2ei8tbCs+v+9xBa9rQpRYlj4fv2ZLlOlaWuaELCcpeuoRHpiplPKB7XnzAWJc3J7yJJ+jPgPB/A2OcRjDI/XkKprQafrVBexriu54xP4DzgOngor8d2kdnAN9287wtvnYkJVdIwLvVp0ran42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi9TImWbT8ktARy05Nj1kB4LU4/1m6JVXRbaiq0czwQ=;
 b=nPmYx9jnFO5Ms0lNdsy1QZZFEw88DtHNlvp8plgGWcooowUnkAawbPVH3sZ+djC5nBvKybm/ppOD+tPB5snmadRBNP/8sExjJ/sGlKysGdQgUXiw4fIobLHLKstQQgttdQ0fdz7/xfg5NFA5zhoI8EYN53u6jLRvlkFYAby1yH4eQ3CjUf+IjFKRLgnMCXfAAq0aArHfwCDfPwHHJ2N4ohyYK+jkSIqM+nrDni209CiKjNUixmwK2z2shCqxduVXpHoXane1r0Mr2+KFAIGZI3UytT111+wzy1M4e//L+MBd952KWtjLl6OM1OM/fyvT081ZfpbkptXw1Q3kVo0bxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi9TImWbT8ktARy05Nj1kB4LU4/1m6JVXRbaiq0czwQ=;
 b=biFQCV3WHi171BqH0tTDRr3io5CJK1NXOiWvQX54G4on4Elzvs3E2V4AjhQXDk1OqusSn4NCu+TeXEcjoyHtDy6Z/j9zf5nVlxyD3jLfnz9ygum6W+JvlXtJMxSUMRMWDFi3MKs+bxZSBN8Xi1TqN3fBM7Tgk3LqjSsp8lQFw8tF0405R4Rm40m5btkESFnZZSDOWWyZLiYm1UgNqAgX2oHpoSJZ9eEXsw8pXKYqPUVy9YNJXHxP/jjnpFzYoZMVNuTEO+7C56EhQSQUtofVMmKcTUEomzP0u855bYZ2BXZGMUeVtzdiJW7Rc0DeF/CRRh7XVPxyvSexqLSQDIm4dA==
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 12:00:38 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::8d) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 12:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 12:00:37 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 04:00:37 -0800
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 04:00:37 -0800
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 7 Mar 2024 04:00:36 -0800
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.68])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 40E352C06D80
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 13:00:36 +0100 (CET)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
	id 378D460FEECE; Thu,  7 Mar 2024 13:00:36 +0100 (CET)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH v2] obexd: Install D-BUS service for non systemd
Date: Thu, 7 Mar 2024 13:00:00 +0100
Message-ID: <20240307120033.1327905-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 12:00:37.0207 (UTC) FILETIME=[112F7670:01DA7087]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e187b4-f7e1-4321-6196-08dc3e9e33fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mBgKQynbRbKRfwwofxSJrzq+M1j8Bgc3OcIM00b5UIzVD+V0Qyg7C9iSlCooP4npLX6jnu3zr9J5vhpigQ8tUOIqZCaP4NEhTfRa9+0EX4NBS5QFhZsEdbEHwJDA8JKZbxli1g//zzbrZSf/V+9sLySawGkE1ftMuUpOa+cfnJ3Mdw9wy6RTFk8XnTrcTWcSID/lo+hcMzXTfJNscujW7okNIER+c34pndJgM1E1M3JHw0zVqx/M6VutR4PZwYsdEHvTm0dgmVrElGr/e+GPgX2UPy3z33V/Qc00Pcr8XscUauAP+XFtrbaiUpfFtjKVn2nTPQ8qhGZ4HnUnZSseLm1W/V8AFtrK08/+l5NLfUky5G1Ne9CmvUqEygtfBK41Pt+8moefWc0u93q016FSYNgiDjwQgly5iH42pA2cEh8PeT19kybhl1JW1t83AuNsWWcrFB+ls8QDGZ1OneNkEx5agsgtEYDr3ZIUoqN33VrUdRmJrjEstpmxGzGWkN3ZbXnW5lVqJIbiLs3E4fvRiSwSMuNPKbJvp38cndr8wZBYmrJIyp9n/W/jlBKfOt2k0w/sUeZtmwXGfAe8OfxZkMH1zeDTC7QSTUyhq4y1oi7ObfWsV32wuSQl0CIMemKvJg0tXVFXeDm4H4pKHDsJKK3Kh+PhJNcmdRp8n5e3y/OjBg1+V0cVVlKQS6fxMel1SMV44+vp596uTKv8VqD/Jbg9o9Tl4jP0DfTBovBC8DlKc0Zs8QQMfGBZhE2VUruY
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:00:37.7231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e187b4-f7e1-4321-6196-08dc3e9e33fc
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000

non systemd(like OpenRC) machines need D-BUS activation for obexd as
they lack --user service.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---

 v2: Only include org.bluez.service file

 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index ed4f9dc51..e780fcbb1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -48,10 +48,10 @@ endif
 if SYSTEMD
 systemdsystemunitdir = $(SYSTEMD_SYSTEMUNITDIR)
 systemdsystemunit_DATA = src/bluetooth.service
+endif
 
 dbussystembusdir = $(DBUS_SYSTEMBUSDIR)
 dbussystembus_DATA = src/org.bluez.service
-endif
 
 EXTRA_DIST += src/org.bluez.service
 
-- 
2.43.0

