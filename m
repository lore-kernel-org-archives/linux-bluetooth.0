Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F80C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF61A2082E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=technicolor.onmicrosoft.com header.i=@technicolor.onmicrosoft.com header.b="OtOtZoeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAHLqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:46:23 -0500
Received: from mail-bn8nam11on2108.outbound.protection.outlook.com ([40.107.236.108]:3521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgAHLqX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:46:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QInDIZuxlEHZ7RT98gS/X9GFxlxvk+p5Ks57xEn9iCSz5402HrrKgP4o6m4b03yR97j1IjkhDFND5imNeWkNzLGQJOF7nF98cRlA+NnmBRahNivSOGvcDk0YfXYCTplZW6zifPvVd8qQxQw6I5X1BaEDtB0T8zU08TvMAxvUf5Zgl6uITk6Ru6HsAciDhO4tJf96gu4pkwUPNr3ahfgGA2qqZodAfR2/y39ohpNnx8RukSx8kwCeRiEEseRm8iVNibuRqnqLti139uXKcUaAbX3q1jb+JIipL7brHXFBeDfrQ8cJfa2opd5SSW1g5LQ6/G6Ub59RLPwwb4+nLuGX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxCKboUo8TKA2/dF0t51/JK0XDGiT5SsAwXd4ksykkc=;
 b=ZP2wJ7Nx9pImQnqv3S1UT6YSBkmq1KyjLHQVE0sudi8efQkzqvN+BuJZi7m3PBkutF0MJYA19mjRja4144q4xqvF1g16Lm4dZj4czY3QKrng6pPMFZefsAeeqoaR4NconLQhESQUCNI4VRDsoWZjA/+ZP+Ep7rtCqmn/PcAt+Qb83hAZBfXlA8eMRH8vHs3cZUWi+f6pHQLJ46g3Go73vT/ZTxZdtih+U7mpReWysQe6YhlcjiemaGnF5z/qieneD19GUKfNC1gc2PNbml8izl/TLv6HU+aGkUggp8ScZvElI/UxHzNy9WUaD/6nRqI/sJWuE+3buszhMkb67nPZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.203.95.25) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=moving-picture.com; dmarc=bestguesspass action=none
 header.from=moving-picture.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technicolor.onmicrosoft.com; s=selector2-technicolor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxCKboUo8TKA2/dF0t51/JK0XDGiT5SsAwXd4ksykkc=;
 b=OtOtZoeVu48ntjfbuzSby9uRPqOi56Y80HazrMC6V0w2YLAH/nixUjslbasJizA4QnKNK7niT5sjQczTb9YTZ76PFLkSbqCwqcroFCCOVMKtjUQ0hmydCamzMU2k5gAwnb6Kw/gxsHSFB5PiW52sOXp8Rgy++hP/mpAeIfOUGDw=
Received: from MN2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:fc::29)
 by DM5PR02MB2267.namprd02.prod.outlook.com (2603:10b6:3:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Wed, 8 Jan
 2020 11:46:20 +0000
Received: from SN1NAM04FT013.eop-NAM04.prod.protection.outlook.com
 (2a01:111:f400:7e4c::201) by MN2PR02CA0016.outlook.office365.com
 (2603:10b6:208:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Wed, 8 Jan 2020 11:46:20 +0000
Authentication-Results: spf=pass (sender IP is 193.203.95.25)
 smtp.mailfrom=moving-picture.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=moving-picture.com;
Received-SPF: Pass (protection.outlook.com: domain of moving-picture.com
 designates 193.203.95.25 as permitted sender)
 receiver=protection.outlook.com; client-ip=193.203.95.25;
 helo=email.moving-picture.com;
Received: from email.moving-picture.com (193.203.95.25) by
 SN1NAM04FT013.mail.protection.outlook.com (10.152.88.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 11:46:19 +0000
Received: from LNDWSMBX02.ad.mpc.local ([169.254.2.217]) by
 LNDWSCAS01b.ad.mpc.local ([::1]) with mapi id 14.03.0408.000; Wed, 8 Jan 2020
 11:46:18 +0000
From:   James Pearson <james-p@moving-picture.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Limiting what devices can pair over Bluetooth?
Thread-Topic: Limiting what devices can pair over Bluetooth?
Thread-Index: AdXGGLAzLvGXYq9xRBiUKhhPZc5Z4A==
Date:   Wed, 8 Jan 2020 11:46:16 +0000
Message-ID: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.63.0.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.203.95.25;IPV:;CTRY:GB;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(9686003)(70206006)(186003)(336012)(6916009)(70586007)(316002)(55016002)(7696005)(55846006)(26005)(36906005)(5660300002)(356004)(86362001)(81166006)(81156014)(4744005)(37786003)(33656002)(2906002)(8936002)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR02MB2267;H:email.moving-picture.com;FPR:;SPF:Pass;LANG:en;PTR:soho95-25.sohonet.co.uk;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf77bda0-6b80-42c4-4f7a-08d7943060d3
X-MS-TrafficTypeDiagnostic: DM5PR02MB2267:
X-Microsoft-Antispam-PRVS: <DM5PR02MB22677559B1B9A44FCA5020FFCD3E0@DM5PR02MB2267.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOvXZ+RyaeWK8QKdg+18HYNbKV9f98GFZM0D7z3MDYsB4PH8Lt8YexI5SKpGQppPc2sZa6Xeeh2LEDEG9dpXA+Szq/KfEEPkPbseAmioGqlZoIDxjPdCvyYdUUc38zhEimnZK85X57MK7oaWv9i+MneuGzLP1KayukmwwmqfYIxcqmd9D47LenTzNJ+w4JWdw9YG/+Tbn2bPGE+M1jORzFMMXfX35iYDG12Mx0riwUc+Z9RNGgGfeVOWFrrznmFu0EKgyyDKT3kephfoxGEt1Wl4bkOTqPcZzQ/aZ/yPIbH9JVPUGZdArNRo+OhRLuDKWw6370iqVapFt+R+ArD4UXfVJAFaxuvfVEEE2tP+EGmqm7Sn4Mj0+etkahw+08/8JC1k4IafQpCgHt1FEmUIo9lRGQ0XjdwUt+WlXG9icArvYJFX7tMXrgnTNPIBuF8Q
X-OriginatorOrg: moving-picture.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 11:46:19.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf77bda0-6b80-42c4-4f7a-08d7943060d3
X-MS-Exchange-CrossTenant-Id: 036da35c-ba43-4e4a-9bff-72ec0f508621
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=036da35c-ba43-4e4a-9bff-72ec0f508621;Ip=[193.203.95.25];Helo=[email.moving-picture.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2267
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We don't normally enable Bluetooth on Linux (CentOS 7) installs for securit=
y reasons, but we have a case where we would like to use a Wacom tablet ove=
r Bluetooth=0A=
=0A=
I would like to be able to configure things so Bluetooth can _only_ be used=
 to pair with Wacom tablets (or just HID devices?)=0A=
=0A=
As I never used Bluetooth in anger before, I'm struggling to find out where=
 to start looking - does anyone know how to do this - or any pointers for w=
here I should start looking?=0A=
=0A=
Thanks=0A=
=0A=
James Pearson=
