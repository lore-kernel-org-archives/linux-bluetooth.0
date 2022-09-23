Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A46CC6FA90
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIWKY7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIWKYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:24:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2103.outbound.protection.outlook.com [40.107.20.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41429CB8
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxneDeuwIdc5rpNtDDHEOSR/r3B7KjIRymlWGAeVFqOYFnLVVKVVawXUmv0NgWIlNV8WQ8ReNPNIKIOMFD0N0DKIxUSGivLYbnnCnaMCBRqlZbCEjbSUw5mVEUC2StJQWpU29ER60EdIxqJ1U4aRGv9tjmYJzTxK3YzlXKRXmBRk/fOb/SaULZSPXy5qQcZO8YzhJEC9e6lBi0jDzKp9pyf5Wim95JveCuPRfVtxvUI69kdz7Z9hFAszCgkF6Ygl6s1Ck7HY5Fmh22izwlM0EuRKBjb0rng5JpHsKUn59weKCGXb1KIa+Tjoc+XHoBYhyA6rTXXzTLVCoWeKra43OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT7+XSYVFkBlRYE25jkQKl8TL5RpEgPSJsNuVPt5dg8=;
 b=hTqHuqfyxSnxyNzulDLU3suUWg7ui6UMEs1VMErhIiAVki0u52CuqX9u7vthCRXg/Ag9AuIcbyoV+Ozml0xIdyl3J3Dsdmr+H/pnZliOki6VLutkqo7LtJGxBoK5DkDZLTs7wiU7zHodBm5ZC70APs/2NNFPiRyspS5x1+BurR2wOsLgZbvh0U3tA0kOQHoNSJL1Ih3HucIoKp/L6k3AP5t35XfezgzT1F7cEhilYtZPQXt5pxLKcwb2mf9tLjh18ZFSK0tG2EHA7T5NXN2ZTT8z/tV1wm1E5HxHn1yX0uojKsSz3MtULlo+VaW6riX0scxwUUfi4wZZn0Y6Z5edYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT7+XSYVFkBlRYE25jkQKl8TL5RpEgPSJsNuVPt5dg8=;
 b=M1jlcVU0AlHmI0KBLLIRcL/rLvlQuixxu11cZ2T3ICVzR7iDrDzMqWNHZHsJlYToFldZHr6/mzT8QYzlIn3+GYQkd7ZMTMHW0at4wpYELeOBrfSYjUxGrD/NJNKDKiGu05N6nqjmutd9YhIBg6gbO2IGV/ABkfE5bY3jBOsHa30=
Received: from DB9PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:10:1db::29)
 by PR3PR07MB6572.eurprd07.prod.outlook.com (2603:10a6:102:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:24:37 +0000
Received: from DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::68) by DB9PR06CA0024.outlook.office365.com
 (2603:10a6:10:1db::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5EUR02FT021.mail.protection.outlook.com (10.13.58.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:24:37 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:24:34 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/9] advertising: parse_secondary: fix mask value
Date:   Fri, 23 Sep 2022 12:24:14 +0200
Message-ID: <20220923102421.10336-3-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT021:EE_|PR3PR07MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c79fe0a-d74d-4a90-0a5e-08da9d4dd119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOd94vfIMiUCDi/iIEUeR+bC36D5N5Y2Ij/cXxA0hb8fle29oPdXfmSmwQH1RLrex/Jr3lrjM5p4ShTn208W2pAQCXJQOYft/K1G4dFwOfQVZfkyGcIByM5qRdYoPfWYm8JNwwomkTl/z/l+EpEMdM5IoZk6PcCttkUvMIuGB/ohO7YtPm2tdZ6F6C0194q0VtMUo5b22LiIkhqnlf9bGfm+PxnBNe0UDrT+BLs/ithVdwqQqJfXtr4/o+QGOow5ug6icEVChqZ+O1QsHyz3178hq8mxw4R+RyWic57g6FTHLVSn+XGeYckkU2szIAx1z+gub6/5V41RCxu4w+nq+/SzAFLIqpXefl7MZFTSnvkDOSscUoRwoD9BLsSrs5IobN1DV9HSJsaK9/Bsz2qTk+SVi5zykzpkv8bBLUA29pDmfdi1k9dVqNnTvlOQvad9GFLqskaCYehdwUOACEyny9lmvBmFblgUUyGWdLLXbuMNxlHyD4Kxf611dKvWJNR8nYFwGBk8xiuQ57n7D6/AoE5MOgikA3eEKzwfft0op8/+O0u0sI2GcB5wDN7O5mylJNyDV2c00TxPfRNvXO7V9gmegGvnsktSVG54DrfF4qh1irz+uXjvvSveEKe0la7EdfuekA3KMWCkZYZ6KyVgdbax1kkyOqNh8V5rYm6G8oiGIlGXw6rcW5SbsAamUIyIMkaY/wYFE9eXvWVwmUqHBe8gIcRxy99/MEG/lHHBUlAvPTJ8Xb4VENC+GbOInKnWVCsozRSTG/ZOuLfjcjwnNw==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(46966006)(6916009)(82310400005)(2906002)(5660300002)(8936002)(4744005)(41300700001)(478600001)(316002)(86362001)(4326008)(26005)(70206006)(70586007)(7696005)(6666004)(8676002)(107886003)(83380400001)(36756003)(82740400003)(36860700001)(356005)(81166007)(336012)(16526019)(40480700001)(426003)(1076003)(2616005)(186003)(47076005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:24:37.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c79fe0a-d74d-4a90-0a5e-08da9d4dd119
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6572
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It looks like a wrong mask value is used here as only the bits mentioned
in adv_secondary::flag can be set again within the loop.

Replace magic number by preprocessor macro.
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 15ef44def031..42ac627604fe 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1051,7 +1051,7 @@ static bool parse_secondary(DBusMessageIter *iter,
 		return false;
 
 	/* Reset secondary channels before parsing */
-	client->flags &= 0xfe00;
+	client->flags &= ~MGMT_ADV_FLAG_SEC_MASK;
 
 	dbus_message_iter_get_basic(iter, &str);
 
-- 
2.35.3

