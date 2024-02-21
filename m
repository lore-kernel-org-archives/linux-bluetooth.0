Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B403405D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514353; cv=fail; b=i2Dp/EdnQNlLhNfB3g/chS/4Zvb8u0Tm/483y7qHVpkPJEatY1fxOuB3w+mQ2th/uwAepoIQaewoXBni0F6tuzBIqwds3oC9OLnilkTReudSWBjDTTNf46h9lZohsO8ihPgroVQsnSzdx3RVr2UCgnp0FV6snxBsWMWZ86v7Nsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514353; c=relaxed/simple;
	bh=77L5sBvtA/ALW5ll6XFI7QHLfDYSUHo5CzhAgmcKDTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnwspiGf1EoupdOWwWryq2hPtQmFv1oZvyOPjl/YUKIsFsyRoahr14fL6IS8gt4D0mUjiNxwxjeo2HsoO/TAje4STVZpfkbe27uTabcD/mM5H0jIcVzEdRfes5hazDouE60W7B4in8g3SXsrOS/wNDCkIazYZo5vAhIFO6UvHb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=dR0h6hLC; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="dR0h6hLC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTJZpAramXSJA7+nNMoAKTHz6Up6lKFcOX6hnVp77uCv4YvJvOAdJkQMogrDykpNVH1Wstnqp9GwDYkwD1hdAIZ2wC8pxxQ7SnPQU5F3d/dlL4cz0Qej2y6Q+A3JbbmYtT4RQWqz2j1nQw+nQeMKLXkBJAcpA+EiJO3Z2U/7eMDmq88RwZqGD1weKspjdCPy9pX+Y7D0KKKIAagS94UiwRn4H1sWVBUL3iWcezds6rFqBTSbrlN+GbWqwHyhUx3VL5XC8deOrDwlkjePpwaM7ngZ1O4q/4Fh/T7ccUDEfbgoqa0yWVodslD/iWRCUYUuIKfadPMA51A1BV4ryXy0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTVM845iq+F3b3U7a8XVzt2XzoVMSH4BWbga3R9aaRM=;
 b=lwtsy1xRKbyYBnMFttVH734pO+O4qNEaK7avPUM+yNEkkcyklitgoN7CvKAR5SPQdpIfX8WtqiXe8dnxo77uUpNYvZtfRJ4806pedR1vrh6sP7Ttiy0qr7QpTNKNZ/yaRUdJL3rklaeVZR12VlYT1viQjLor+MUXpGWTxli67/RpYo0IVNcjehkjCqPRAGs27M4PWJwuA9KmyDrhNtj5VSNUPump3g4N5Buo/r0MMfRAI5kAB8y38MT9d39fBhKDeeEWKvORiarPNj/6M9U4NcSEhSpz9yM8dnAtr+JaoLxHH77FHGeJhawO3dUCLCQT1sxUvv1aEwHQ/NVfXQKy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTVM845iq+F3b3U7a8XVzt2XzoVMSH4BWbga3R9aaRM=;
 b=dR0h6hLCt8HkhtLTVaroed5X2Mgr8X5hWL1d2LrkdtRqYDw2T3ZwGxqa5IupZ+7FagIG50x2ReyTXf5VYkxLJgxVeWPF/FaJUbmDv3hNdIjknCN87qYFMFlpgkapZOWMu2vuRoC2ehataMr0Tp/w5p3606ugHPaHsD0hKywxzXwmMvLIsL5yc1r5raKbuaW3IwXTnzY6JtkWDkyiV79YM9Qa9P3Cax5d0xd5zz+RSs1FBvhfk/tutABpRZ9LRjTp+y78Xaf5ZoxrRx+Y9brRhncacSrRF7CYjPSxhFqJm03kskKBqwqtmi4F61rAQXVwCeVPVeoAqrxKz4JBYvGrxw==
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by DS0PR10MB6749.namprd10.prod.outlook.com (2603:10b6:8:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:19:07 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 11:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 11:19:07 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:19:06 -0800
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:19:06 -0800
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 21 Feb 2024 03:19:05 -0800
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.68])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 617952C06D81;
	Wed, 21 Feb 2024 12:19:05 +0100 (CET)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
	id 557874011AEE; Wed, 21 Feb 2024 12:19:05 +0100 (CET)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-bluetooth@vger.kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>
CC: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH] bluez.pc.in: Add definition of libexecdir
Date: Wed, 21 Feb 2024 12:17:59 +0100
Message-ID: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2024 11:19:06.0326 (UTC) FILETIME=[C84EEF60:01DA64B7]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS0PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b26a660-dd23-47f6-4160-08dc32ceeb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TPS7mf4ed9Zxp6nOneOQpV+vgbNS8xAuk7nwxauTdZK6euQpzI43YQWBOxDd6/6jg9EfZ97FfHzR3+Q+AirW6famTOgEBz5C1V9FtzizfNIZHjUnEOfPLAY5+3jjhiUtX5g9HoaFkNug42+LYMR0aj+7jePCw2h/3vTpEP6QAPaYBxp2UirOfmgq+qnQ1TZZPlCjdV+Jd+hwQmcqGsPDSzJaCG9VB0h78tKAidzsItlL33VN2Qd496uvSipHnls/BRg+bbZaNLH/0pltWH98nhUXKNkVMX1PRUsENZDjDOaIIzkpJrVIGm7E2pQKAUUIukbvQqxK/S1RVccrs1dRIOcgj9+7fNqHyJlk5pm/M0xeGdylYCLhHDRithZbu8+wf0FB+fy2XJtfLxQEnPXjTkVTl2jl3XBNYRHoU/f+nfUTKi4TfNryJbAbaS+dRNh1XNnSNk/bX0ALSJmDlxoK6DyBy+4nHWyJAv2AHlQDgclFo3AhfnlzFuEbb/GGDFOOtjfYIupfbSnHMXg8VKHyf/sNbsizd5hfLQgfbjLjqh73jmh/EVDdt/EM4jr1/9WrAEyF4wh+9CvoUCR6SJGJDERk0GPCsEBiztqpwdl2eB71S13UV1q2M20gRPvJJf8Q7Pxq4bwGt4gIkFsQWoXl/6zOT6zE+nsuF/Xq5DxpINo=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:19:07.3151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26a660-dd23-47f6-4160-08dc32ceeb5f
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6749

From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 lib/bluez.pc.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluez.pc.in b/lib/bluez.pc.in
index 3d6e59616..1c2f30b33 100644
--- a/lib/bluez.pc.in
+++ b/lib/bluez.pc.in
@@ -1,6 +1,7 @@
 prefix=@prefix@
 exec_prefix=@exec_prefix@
 libdir=@libdir@
+libexecdir=@libexecdir@
 includedir=@includedir@
  
 Name: BlueZ
-- 
2.43.0

