Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B575C6FA8B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiIWO4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiIWO4R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70108.outbound.protection.outlook.com [40.107.7.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3E1129CB
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1BnqZAPSQFGje4MfvVngnxAxQ5jyCVe3NrGqx3UU6/o3GlVfNFp4RQtMbeGAZ98+IhD/157v40quHHro5aUa4lh1cx0hyQ5Dbe8vgNLJF1JS4+8wPDeeXnHLlLG1SrziPPrrKhGGT4EmHFQzBUpEktVjnJxjfyPcGVwyRQcFW8P2HEu+cY3QUUsmwvpNbsg60Qlf8arFPVsLFtLd7aVOH0fye0VMZh9eQv/jjAWIDdGmqoYu7+7U/poezXx00494MKEmvCLxikhKD1b4pLCy1jLu+cVXYTM+nFtcAFYLEXU0HkiJil2IWqobuVo7llZ1+ducI/4GTwOLSOZFGfkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT7+XSYVFkBlRYE25jkQKl8TL5RpEgPSJsNuVPt5dg8=;
 b=enlVdx+mZ5nuUF2LP96U9sVLlQSMtKoUELcTttI2oOtmSqjp8g/bGOF7u5XPfDdpln5RLiqpJ7JaHJJgj71B6TpEa2wJY8bBZpFckuoYL5OwhusuTrL0bz67a8+nFRrdz/yphtPoAeMo6FKvp1FhqeKuYLZTgxuChPOQClfxm+Wx3CTXKKW0N6bSp22COWqLj+cfzZjFW98TwRwHqbqCWiIvOKu/6q4zr+pYilnRYQguF0PbCLV0tzraQ8WSeE8Q0pkJ8APnuZfIuqxeUd7fJP663ODbB2WGrpTQAQk0oa3dXXLErWaOfrtTXOUrFH+WyGQQKBE+eSrnUHM0wDor9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT7+XSYVFkBlRYE25jkQKl8TL5RpEgPSJsNuVPt5dg8=;
 b=sRsxezjCloE5rGTwvrxsUJVcO1i7JzKJoNGqXiqcMbwnn7HWN76yIeE4mpsynTMhcPhE8+VGq2xGxhpQjidPRDFBpa+U/xaye5HbKtyVQ1mxD9Fjl8rW06hBZ5Ub3HUW0lSddd9UJs9IYF8ra5QPh1OhQlXMzKHY2ZHNAkP/Og0=
Received: from FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::15)
 by PAXPR07MB7758.eurprd07.prod.outlook.com (2603:10a6:102:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Fri, 23 Sep
 2022 14:56:13 +0000
Received: from VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::f4) by FR3P281CA0160.outlook.office365.com
 (2603:10a6:d10:a2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
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
Subject: [PATCH BlueZ v2 2/9] advertising: parse_secondary: fix mask value
Date:   Fri, 23 Sep 2022 16:55:55 +0200
Message-ID: <20220923145602.25872-3-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT012:EE_|PAXPR07MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaff608-b26e-41ad-577f-08da9d73c210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0dRkZM8wm7er0V/P4O+pkr6fTWzsu2omgUGqiyh34c0C0/pAchsja0s4tFOx8AxDEnXy+rQ+heLSbhPYrYIhk/h8K0FTzBZYJsElopJiDvcWSGoCQNdxVUP6AahxJcKt0LPX//2OuPp3cYtsDKnl6b5eVJ/B5bnLkLM0cV4gsgnryHkLbnP2DZc0oFZ5NyXGyV5QQhybaGRZmBgQlQXzecCYP3v0R0TxAmaNqQ6L+qt+7IOxdK78eBQ1ikxPH4zzyI/+N5PXvqXKOzfQrmm9D8z2Pm63frFIv9zNlx1A/ZXxl1t1DPNxUi8s3nD0c44r3/HeFaOy67illDhwRmHDUse+wqOq6BIOistTiYFGFV2opy4zxaJPVVi45iLD8/OxVQ4RCBCMYRrJMapdjxk0wtXL0Re6ncM4rR1jhgAtTX6jlTrHolIVJiIl5Z7AWxC2xdRxupGiqiGIqyh5Juc57n4YQ4vclNpJxLEBgOj9EgZmk5ILBr/WPtfvwJAaMHasiE4FrBJronqh7RadQcf1KKaRQtGmlg6p23yOip2c0cgMkXvKBaIMcsMb/R5+L64RjXYHzcbQ92oAdQQxrttcs8Xf6zsfYGiWSy1ALQqQw1LHAHhF1CnBL5a44sYBeEG8vsGEut2ahq1oPznpIb9bC5uwaCvFJMO1n0wqZBOrocqpf2sM6P2bIH+os0hXN9qLK3oTInhFzEeBuexmyJpYeoSj1CHuk0zyaFU8X3648RJFuKE9yHx//xNTGsaTtSuOFdsfIWAfazM1PIUdgPaVg==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(41300700001)(5660300002)(8936002)(4744005)(70206006)(8676002)(4326008)(36860700001)(86362001)(36756003)(2906002)(426003)(6916009)(316002)(82740400003)(2616005)(70586007)(81166007)(356005)(16526019)(107886003)(186003)(336012)(1076003)(26005)(82310400005)(7696005)(83380400001)(47076005)(40480700001)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:56:12.8478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaff608-b26e-41ad-577f-08da9d73c210
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7758
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

