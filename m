Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4456CECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiIWO4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIWO4R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50103.outbound.protection.outlook.com [40.107.5.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4D110B24
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzjCxdvXdSwYilT3PqYV3u5kwmVr0P+ZB4BW8p3UBhBbzVUKTaTijBD5Jc8bEz7fLMXTaGRfFfupuRgAmizYS0WTgpJcWLaHcnNqimkBiwTRGqy9B/GY3IIY4Zprp0nEYAXW9dAh5TIM6EJU+xpenKGOyiplpDNXHxVAD8zJbWGfyGCIEn2PleQVJZktsx5q9Pna/NJXmvKesz1m8RdY7qupdzo0bZrLLlkzLR9BQvGdsgLmLC0xYilfuhgNLsSLaTrkXXMwaSuUj0ry11qcmVR1t2AbHhNUnwPsUxH4A4DXoaVm4ixEfEcTN8vrmaAYxmc0FV2tDuUCicbr4hotWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx4n8Ey4jJHwDiuMCCRfDkEVcTiu6ibOVcG6Lobm8bU=;
 b=joIqKsllV1JjVLyCks5ssgmjxgKek+Q3gr7vclcZJesA/pq0Yq++VDXu78gmdnxJ04WosqPscsVf1wiFPiFn9F1tqJ5J391XvPFgFmMtRnIEMJckvf5Kk1VHuz5sy3N5SgXyDh2mhfoaReCMNq19XryOeNI+M7HyqLyf2LHKOQcSQSEubuFy3i5dkg3r+5TqEtzh5LkT52KnuX4KdQAdQg2ivbAw0SJde3D/sPWP1TUm7i8zUqB5+ev4nGWrwLjjFs90N4sVkefS+T2jtVhcgF8cbXEwNsllW4ogNPXwmnucN7JeA5Qz87SLQGMY89UJOR0FTY/VPVLqymJ5MnfQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx4n8Ey4jJHwDiuMCCRfDkEVcTiu6ibOVcG6Lobm8bU=;
 b=JbBBGXu8aGSqV4DKogj6/0ao7CKeUwJhB4fvOpWLppmv5oO1UTmiC56Sn181hIvJQEQIRsW7oi7VH+Bd6VkRXnTjNqS7JDlowcQ5r5UMQYBX+xCei4UPcAp1kI3Be2yPab77QcSkccGpGLEMgI9HUtRcb7a3G46YgdZP2gpExA4=
Received: from FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::14)
 by PR3PR07MB8259.eurprd07.prod.outlook.com (2603:10a6:102:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 14:56:12 +0000
Received: from VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::53) by FR3P281CA0162.outlook.office365.com
 (2603:10a6:d10:a2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Fri, 23 Sep 2022 14:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT012.mail.protection.outlook.com (10.152.12.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:56:12 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:56:11 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 1/9] advertising: parse_secondary: fix loop condition
Date:   Fri, 23 Sep 2022 16:55:54 +0200
Message-ID: <20220923145602.25872-2-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT012:EE_|PR3PR07MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f89161c-8631-480c-fe55-08da9d73c1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJwAmqaA0FEpAPW/pM6b9wFasVfXU01PuJVRFk5FBwHMvLCEaMVJRpVZmOl1tmBb9WxTc+9JUbmDN9tpHjwohhDFGLDuuMWcj7oy5Ng/pvTa9sAzXbgTNJibSBgCZ6DmAaGCwM2qEyMRlsFKpOALoUtJ5ltc4QjdZlQO3iYVyI4I0nliC+Iu6PlIja5SzYKnEG1TcIRanlUMGhOH06YtUPxF8vUEXw7ITS3VeLETSe3MGJZFx0yxiDjzgeA8GASdcpMsMULBTl9Eb8irdGb0mHpdmKZzTqKc2BJR8eRj+ovZSxzwWr8ePig2QYTAgMgS9KDtZ+jYYP5ontuLgJ2P2rMTHAK3D7lunlKT0nV/fJKmV6WnvrASLu4Gv2NRNS91IyNm1oDXUpDeG7zTmYe5QG9rIgtW6KYuivNbX8k40ATQosa85ig2M2ga3AXgYDqkdipnGBeKWlcQ1+CgaoXAVrt+LgGHkcqIzXYmpKtUH1VKDFCJ9ZZx/K3e7gZ4rhEvDLMKkKbcldULPL/JSXJhX7CDzFQjgq2b/FD/YHHTidFfHoaX2Eqlanns9yX23quDBQIP3tc7oInSlWzR8HPpN0ThhkC8xl1BbpFkne9FsxfWqiU0p/xZZOQFNXjecYPVYWXSzXU2aFhvIbhKBofwjo328uib8cFkyM4dX4EngdleKgYzp2mB/7GWpIVxsMsbNs5wv2q60bmMRK/fzG24D3sQ2VQUDI3EPaQvfYpv6Wt82pfplUSFTV4AtYOc9fm0OOR+fq7AmgGIQGGUunVTKA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(186003)(70206006)(478600001)(82740400003)(41300700001)(8676002)(4326008)(40480700001)(6916009)(7696005)(26005)(6666004)(316002)(83380400001)(70586007)(336012)(1076003)(107886003)(47076005)(81166007)(16526019)(356005)(2616005)(36860700001)(86362001)(426003)(2906002)(5660300002)(8936002)(82310400005)(36756003)(4744005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:56:12.4155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89161c-8631-480c-fe55-08da9d73c1d6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8259
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

"secondary" isn't an array of pointers, so the iterator can never be
NULL.
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 1fe371a9f345..15ef44def031 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1055,7 +1055,7 @@ static bool parse_secondary(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &str);
 
-	for (sec = secondary; sec && sec->name; sec++) {
+	for (sec = secondary; sec->name; sec++) {
 		if (strcmp(str, sec->name))
 			continue;
 
-- 
2.35.3

