Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E32574B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799820; cv=fail; b=SFb2wn4ITpeLGWTHUckdUyDhF1WvoMMQNcOG7CbQjEEpWG4nooTV4MkmbUtmUZfFU6fbKgYyz5oi1zC3DgTD3ltqKey4iGME19OvCNynR1wTAZPMk5EL3mTMP8WTURSCXaPwGuaqmCQ1iznrcaP/Z0Qf7Fq6iH7DkfT/Zu2Ny3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799820; c=relaxed/simple;
	bh=/iJVfkX3sW0A/dpEKEuYepZQFUloIWEGRvKkpyK208E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RT1c98NJkhT8uRioGMGVhUqGxbj9PO18jBLReIlIkO65aLcXCJz9fWVz2TxuZWGQ9PNofImx25/GuVne+X+qH3xmddDQbspHe2a/02/1tNpn/l0ZVhSg/OQLpreCsyYvAa7gn5FBgJnt00fuNp0XwQ1IhHS96WiZKR+DO5Apf0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=XV1g3iCe; arc=fail smtp.client-ip=40.107.223.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="XV1g3iCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMYLK6KcDow5xKGgPTC9WyaYH5CkXlJCiHEnY2nHEICyU+jjUAorld7+hswsYwurMHhm3GZLorsre47CX2qPg0BOTnK1JM58cGcFzeB8tSGy7IbOXDI/nAPq17x6kHPvAKbt6xfjAvYtEClBamFqVvIMmQ1eV2mZILjb8kuvoiiUefr2WCeIa/lewSY1BrNal2Z5VLv0LwvtxIHFBYGJSaB2imLx4XDUybq4asQt8aZj1++bBl8AhP48H05j6TEGHUb70NSZC9PjV8yfcH+qm5tndu1atgWVqmReIzG4uBTJAB0ZPrzzm8PyZ6MbarikvxQhEyH0hbneij5wmvN36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPiT5os+jxpVlRUJ+CPUnmZVUexMTzMBb6OEsqevXJg=;
 b=TDWJOaOmFB5U4Tf1I91/pfZl+A0BuMGjLiXCiyI19C4YQoTFc3Dq/09ZjxSlYcDY8NS0mPKqgMSLG3NQzXNdvSl6zHrCsMcmYQzyf2P2XQG4rPOzH0OP/F+GixUJqwsZ0hlOlKWw+Ut41KSN9f+sY7B2WN3g4bGs0Bzz2fdd+1LAlxcMdlVMuOXagCrQ8X/MBZNkHfaaBbXCdPuofcSplqqRS1kIkol15opPgc1VnhsF0reGLjV3e5l16qglH05EAVvXlJvULxn0sa9TtuOs+XNOgaUC3GgSgr2k6ZFq5NSN44xFDYntWGWrwcetvyfERM2WaT8O/D6DThc0E1wNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPiT5os+jxpVlRUJ+CPUnmZVUexMTzMBb6OEsqevXJg=;
 b=XV1g3iCe03fAlXRSmNThrqX3AEejDo0W474AZBfhkrJcLJY1hTnxnbRwlSHSh4/30IEoh/KpREOkNKFYKj0pfpUkJk7OFkH8s5hbfRaF5+NP3ebwheO7Qvzlxb/eVpMKrSZQlUc6/Uhoc8U9BUvz/d5zXe4UD8E9Wy12PR424wY5tICeAIc2d0Uy62v+KefcjaCHofDlI0PTySEiCGQOyRpqVRUL8Yscqk9hlCiPvYjwS8yTqzlPK6Mp48CHUj1egfQBaW8WPVoNa0lXaaFDc53GHZ58poRTALEuqWrfAFbpE8PC0Dbx5OZ0BFR2eeGz/d+nBdkLbUkHn7l6TgidJA==
Received: from CY5PR15CA0112.namprd15.prod.outlook.com (2603:10b6:930:7::15)
 by IA0PR10MB6721.namprd10.prod.outlook.com (2603:10b6:208:441::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Sat, 24 Feb
 2024 18:36:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::68) by CY5PR15CA0112.outlook.office365.com
 (2603:10b6:930:7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Sat, 24 Feb 2024 18:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 18:36:55 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 10:36:54 -0800
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 24 Feb 2024 10:36:54 -0800
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Sat, 24 Feb 2024 10:36:54 -0800
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.68])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id F38502C06D80;
	Sat, 24 Feb 2024 19:36:53 +0100 (CET)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
	id ECAF7472FC4E; Sat, 24 Feb 2024 19:36:53 +0100 (CET)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: "linux-bluetooth @ vger . kernel . org" <linux-bluetooth@vger.kernel.org>,
	<emil.l.velikov@gmail.com>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] cups: Use pkg-config to find cups backend dir
Date: Sat, 24 Feb 2024 19:35:50 +0100
Message-ID: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2024 18:36:54.0919 (UTC) FILETIME=[70D96170:01DA6750]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR10MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd548c0-0d83-4eaf-4026-08dc3567939b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4nVpzoCkJ/jDrHW6ig6FhNBpsixfvwX+keQfTH88LfSKjGTdrgsVatpjsVxkiaYyWNllohyoma7sL4YjkoklsflQj9mtx87Igq8J/K4vRJvvFdPUY2Bb2QnuIrLX9q7DOJjJFDZV2SK/enOikcGnLTl7d8zpqsS1+euC+Mko0eV1tyJDobTYnAcLQd6Pyt7Y29OTITb8ZGcEqt1to2oyNnvG0RWxv0XwTwCCi7ljrAiI9OkMPtJ7LPdQcBc0FxNBRobOlMLbYijBJdAQJTwKTwotNHtqqyPZ/Zf46WK7nymkOnjZRbvaKHja8TlsDigTbehs1p59BMJfjqEejvOXQBtR26PouBbihdxOaYLbfoVAZzuZcBTFlkWSGL6uZbIJlKJT9XmQ52J11Samvy42Adumouvvz1UTm02OVxHW7CMEQTjI7Xwyqcpvf5IONl98oNOtwdugW3AdyJzhBHu7IvbTQYzajxKA1obp1QaRqJmjM+Iry2ER/g9l952nPUpJh4RZ/Ei9Gx6CPFFwoOnoC7oWDoesPbvUcK8LG77bWLayUFe0OHxzTKE8pgPcCgEIgyN1cBoyLZ4CxQoybTOLgd5Xl/LspPHP2Rw/2VYLytaOg/z6S51LHZ2XFiDDKmkSd1baF0jbwY1Ujsu1Ly6AVkkhUw5YZAcuMXyzLXU7gIw=
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 18:36:55.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd548c0-0d83-4eaf-4026-08dc3567939b
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6721

Some distributions(Gentoo) patch cups backend path to
something else than libdir. Use pkg-config to find backend
path for cups.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 Makefile.tools | 3 ++-
 configure.ac   | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 044342e29..c17244677 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -538,7 +538,8 @@ endif
 endif
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+
+cupsdir = $(CUPSDIR)
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
diff --git a/configure.ac b/configure.ac
index bb6380f2f..778c27a0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,6 +242,9 @@ AC_SUBST(UDEV_DIR, [${path_udevdir}])
 AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
+if (test "${enable_cups}" != "no"); then
+   AC_SUBST(CUPSDIR, `$PKG_CONFIG cups --variable=cups_serverbin`/backend)
+fi
 
 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=${enableval}])
-- 
2.43.0

