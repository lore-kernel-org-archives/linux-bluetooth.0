Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23236405DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514353; cv=fail; b=nnwIDkEvwT3L5vboYdL3zp2xflhBVVdwrEP3tD5bmKbfvUqeYk24Rel8YnL7sBMk+pFHR4pWgR3B+hMJtkWpcA+HMLI3TSX4vzT590sypgujUxEFEGk1tH9Nlo+m94/t+doSyOdIPYQHadr5dCaV9LcjJWf2stEFO2UWBfjMB7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514353; c=relaxed/simple;
	bh=gaw1ftyyNfurDzbprgGuebzg2CV0HO0gt1IY+02IFrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex9s/eGqQ15YjOzHBTy/QaON6OMtS4kcCwI9iTgHrisN//yzBHHK9V89BvGGTy5FnNX+PKVpgvgSGuBEJDxujX93fg02gibnkg06kZdBF+6jwQRwXRyCW5sgMqtnBSQQURbBFF9z56bgcL0hc8WOICAsk3hlRkxe73t2/b99V58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=LcJilzTh; arc=fail smtp.client-ip=40.107.220.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="LcJilzTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVFO2iw/s0YfFTlKFh1LDspwyfEKmThkUqgp9T6K0c28732g+nTZ8mP1rok+q0hGhK1/wwZiDKKAsrf+jNhkY4DLcUqNfNzBU+KhI7gX8tFMSQROjgy2ryTOTXnyi0Ft/o2MYCoaqqUwxvaptRJr5x9d2DkSfyqobArRtWfXnVoM49/dkXdURLVaNTnGaW9ye9/JMJui1HCr4R49m1q78298vsdAvIM4Yze52Op0G7jAzmDYHR2404RW19/rW0H/rA6c9nppYnAaHuGSTxsWEmCmB107ROYtql+uYCxG+clxjP5ji7JfyMN88UWFRS/Hup72bD0iO6vxr6vVPXW8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCIivZ/MZfv4/mJRL77s8jSa7aBGDNskU2ce9F1iRVc=;
 b=FczIkVVKFGG7rdJYxRDHDJa1zMoPBrGWPefa9xL0+NSWZGdPGT5WXELpDNF0JBkO29x8s54SmVhagHgDBq3vCOjqCUekaf31G6hMejYE4UaaJG9G4AX4kLIaeNOP12x0zHTeFUGSyYetvUMUckFbq//FXKkOpJ3P0ekmE8YvavojC0XzPxIq1yTJKcvRxiq1qeDRqPnp1nyeTJ0i2hFHNHw4elhcOL/dqjZybsXJThVDmCehtR+GKtileO/vaLySgqCkdpkxlj4q5cJtIdw8h/XBHiUizUXlr2sisp+JPBdpHJnjb37OMmQpJDl6wOuRxWoB/PQknZ47ex575sxKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCIivZ/MZfv4/mJRL77s8jSa7aBGDNskU2ce9F1iRVc=;
 b=LcJilzThWI8R+NxCdcNI3ytqDh3/9sX4NPNToElJzJizp7qI+6zXQDCjodVQVUpjraarSXAfbQsS6+cbLbqFauzSTrtGmfUgewzYUzWejuuQEMZwgBOtMOOPft9VInrMamZgR70w3DEkQ7ILmFNIRVi0rWs6Lmp1vWXcmTiRYgzhcz9F6ieRkFAK0MDx9YGg+40krfQDE+GmrPYXs7Cd4dBufOKTsSewBufgCsMr9yZ67lGcwUukJBMh7wEMhdsQHshkNTxRZEbKjaaZHz4Ts7s7AfobmuBoL9PB18oSWJfhlZxMMPvTM+qeaDba89mXu82qehd7OO7d48+iESDHLA==
Received: from BYAPR02CA0041.namprd02.prod.outlook.com (2603:10b6:a03:54::18)
 by DS0PR10MB7020.namprd10.prod.outlook.com (2603:10b6:8:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:19:10 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::1) by BYAPR02CA0041.outlook.office365.com
 (2603:10b6:a03:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 11:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 11:19:10 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:19:09 -0800
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:19:09 -0800
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 21 Feb 2024 03:19:08 -0800
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.68])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 2C66D2C06D81;
	Wed, 21 Feb 2024 12:19:08 +0100 (CET)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
	id 2A70C4011AEE; Wed, 21 Feb 2024 12:19:08 +0100 (CET)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <linux-bluetooth@vger.kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>
CC: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH] CUPS lives in libexecdir
Date: Wed, 21 Feb 2024 12:18:00 +0100
Message-ID: <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2024 11:19:09.0104 (UTC) FILETIME=[C9F6D300:01DA64B7]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS0PR10MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d058d37-50f6-4772-cd19-08dc32ceed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jKuTMTxJZPMJH3GpjOgOk6z0D6TM41l3tf+wcT3mAMKFfpF+Rvumcg8Enu5SCpLUideT90cvYcBr+3thhSW+hP0aDgDCSpqEM8oahH/kn1/q/JelXBVPAjVzn7rWCjNUPGwpjYlYARvQRUP4MlQ3yxj5KAxzMQVe0ZY4YVZTjzYtUv/wbWZ4YY4C50CV2stqR4uR5yC4pWtZfAFPVY8/GHYB1VkYzSqYGqKITOYWNoib4h5cGysBrrbrspxX3z3ZeMhPpJMkjoQejzlQ2a7exLldfeMXzcCFZXs3fgqyViTOANPXWlyyWwNJFLUDzNoO421MIdFhpiYxFM+EGnkiBDX1g2v61tmlkNgvek0pNXo8OFksSqNHcCZyw11yMyAi64T8NeCNUiSvPlAhoWW1Wtwc4zEZEeiOVIwTPzoXikCGidcickXRrK47+gsNt9FrCCeixTAgg3qjLRDUYbrI8teNKsHBrH4VNy/YaIp4SISQQQXot99duu+K+PjUEdEOl/kVXQGDgCZaqkf/RaXqDYzkiB0D9YwC9FmO79JP/i1GZkev/zLzpaPbWZcod+RzQqiq3UokUtXIoReF2nT8OmuBcs/3blq/3AC+DFkgQZCKDrJBTjiH9CTyXg13ShYRiel/QjDg39roKB3Z4O2nQvbE/ThResQWIfGBXw+pgS0=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:19:10.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d058d37-50f6-4772-cd19-08dc32ceed16
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7020

From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 044342e29..b785ebea8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -538,7 +538,7 @@ endif
 endif
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+cupsdir = $(libexecdir)/cups/backend
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
-- 
2.43.0

