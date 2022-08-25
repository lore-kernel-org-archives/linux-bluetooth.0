Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82076ECAAA0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 20:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiHYUjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiHYUjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 16:39:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A414C0E50
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVwJ/Mm0MtOdupsGT/pH/htsGc9SZQEolWG87FoWfK3gw7Kz0NUHgzd+zmEp9xbnNu2Ic9NkixKAIzk260Ufd80dBAO2Ngsl0rvwRtS0LCe8o2dnGBM21GqZ6bAgp9lgIkdmkWQF+N6+8u18XI/KX4VYfFdlsPEZpECFtoQDzEnofjDATNZTIcDCK4J+C3u105ggY+PXb0DsB/MI9Wa/IQ2sItsHaa1Lqx/TZ5P74bhvSmawYJvZAdfKccoCp/7LmRetfZuCdTayGWlPH339Gka+U77xAIRHF4EgMX1G8uyOfGPSXKszoP6oCbdXoJ6nqzLoj9z1u6uZj5PYBmaYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7uoXsMb46+KIJEI6pKRZ57kWB1mGC1oyicV3n/cBPk=;
 b=dm0A9m7tlV5osSy0NhRuQ/fH0fodW7vBXFXQywaYAbVl+Ay3w1ojF2kiYI6nbGuVPD9rqDMWbaEnJzjexIvp+sKJH2qu5gkobJMjDeXpLnYwESscDuO0lI/6MAvw1F/+c+jBReG4X56PTzMysnD2a3BgN66k6k1x/5ldMIIwTHbBlPRyxsyZRkDkaVUAZpwSZ9XaFln8QgX8NLPlbyk4zK1a0hmzCn/xZ5n3rAYJ936V2OZQXLT1X+NTnPut9o/bjGHetCV4XuJjt/lhODxCUAvXAkferAlA7uHlqba12ZWudMIsQql/agfArd2cGIpmbuSYD7xh9LcYLboOx36YQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7uoXsMb46+KIJEI6pKRZ57kWB1mGC1oyicV3n/cBPk=;
 b=wzCEJmKWJng7dsjDZCv0gOZi5rKoy8wMd52X564VSfKQ2dgusXPJzw2/UOOIn/QEAJP0NjwRAVuK5r2/CKVutBKz+LRutx73DaCQVj6pJvzJfqf25QNPdb3Me4DQUG4fmjG5mi6iqACoGS2RE6Oij9PeGOva6JGGD5Yd13oanQg=
Received: from GVX0EPF000013E2.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::21)
 by VI1PR07MB3997.eurprd07.prod.outlook.com (2603:10a6:803:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Thu, 25 Aug
 2022 20:38:56 +0000
Received: from HE1EUR02FT081.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::208) by GVX0EPF000013E2.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Thu, 25 Aug 2022 20:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT081.mail.protection.outlook.com (10.152.10.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 20:38:56 +0000
Received: from N95HX1G2.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 22:38:55 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] tools/btmgmt: add missing return statement
Date:   Thu, 25 Aug 2022 22:38:48 +0200
Message-ID: <20220825203848.3499-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.11]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63381e2-c315-4872-6c17-08da86d9d4b2
X-MS-TrafficTypeDiagnostic: VI1PR07MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/TzeF4tHZvrWgskjTc1MnIV1pI0HrdILtVh+8sYPCflvzlxONZRrdYsgRb0GcwVHfCQoUn4mMK5JUDwt9YT9wJ5ozoy75HC5hzP0wI1RFnhoy82XLt/AvO1vG9Uz5cZ8QN6f55N2/ZJMO6L/QJ0SoQ7CicvxetI0XM7nKebZ5/UIIj+nWMLvzCIoBKditSHYsmvJplDgmVw/MPxkE24KaUtidzKKS9GMtTU+rJb12hsF3s/ALI/ZUK5VjgHFoiqRm9mTXW/FeFd4T7dGmtZl1HaFy7GEGT03sOMBZ6FE4GrNNlGGtNDVHAKqHATVBAoP77Ny+OeqAovkV6hFrq4uw6VbOmdbRWkyOwn7sYKg61XtNqfGSHad9heSVvsimbi5ra6W5b1fU/SNDFSYmEjVaNkb9bhknBKdYK70GHzylOXye0ZUBECmGcvRJ3BDfzE6A007D4fdMwyp4mYeBM1FOXdLe5Tuo7cc//8WR1adJJM1t4/6qd2t1hc6Y7NEIUaNKTyLcKKZwyYLQniHKsulD+9CZUlCVCilFWFbBdjC887uI/mrD91hmkp9J7bPmR/IylZj4hTsfLFH6Fk6YOhLoCeuigPuG5rRJzsHCHLh+h8FfEAKMD/2A/tRMvgrskvwVstbyoPtWiIYq24RzdhIVOCCiPqPrwJ8yn4XTwIOpU3Bwf5DqOz9hHtbsTxm+9SWMy6XvMrGDin3uuEaEwpxUUychw0enPVlwzvX+FpZzAnKT5HJjYIgTrGm0p8xJezJHr8DC0DDyqXF/pPKyyXVOKzmemhtyc5+Jt6vCohZ1OEjBR3w2ji1/JsnoUlHbur
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(396003)(376002)(346002)(36840700001)(46966006)(83380400001)(81166007)(356005)(82740400003)(6916009)(40480700001)(82310400005)(36756003)(316002)(36860700001)(70586007)(70206006)(4744005)(6666004)(2616005)(8676002)(4326008)(478600001)(41300700001)(2906002)(7696005)(107886003)(5660300002)(8936002)(86362001)(26005)(186003)(47076005)(426003)(336012)(54906003)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:38:56.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63381e2-c315-4872-6c17-08da86d9d4b2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT081.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3997
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Leave function on error instead of printing (possibly) invalid flags.

Fixes: d70618e49461 ("tools/btmgmt: Add device flags commands")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 42ef9acefaea..132ebb5f5b44 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2183,7 +2183,7 @@ static void get_flags_rsp(uint8_t status, uint16_t len, const void *param,
 	if (status != 0) {
 		error("Get device flags failed with status 0x%02x (%s)",
 						status, mgmt_errstr(status));
-		bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	print("Supported Flags: 0x%08x", rp->supported_flags);
-- 
2.35.3

