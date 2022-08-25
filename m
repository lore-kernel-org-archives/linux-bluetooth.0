Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FECAAA0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 20:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiHYUja (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbiHYUjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 16:39:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80115.outbound.protection.outlook.com [40.107.8.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112BBD14D
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI5sDNeFr8vOkcLwzbFEmSw9g1704io62qAxf5VTRaaXchlKzcwoyLfuoUwNlJui642O8qyFVVLSYtArK+bDxyCYgMeVgPfmL3C57P2cIcHQIY/DNe/VQH+K8Xbk+sJJIHX/klezDZ2fFWV/fwfEQyVlhvVSa+JhU6ZrwUlZCiJ6NDqaQK2BCkeyZNVjarAFJURXBAnQvvw8Hbil+sDy+T589qqbMn+QclO7UYEPnfAR2OSESe5pcAQr5CEmPe6QvdXloPY51DeTwIaQYjMS7QV5LCNsZJXtqi1ImF6tKAwVPO6j/vFpm+Kc9VYXt0vcc1BHLhe8m7QEFhWS9NZF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4yZH33TfayQ3CfKxML6b8q4PQRDGTdME5dt4lUkDMM=;
 b=l3YLAd32C5yO5dI2HLwzQsKI57qdRSs2pOPrVpZ9l6zulLq8KVUhodKYLvjVoblCJar5/LWVAUa2f+vK7XDy0ZGyEhmKdi4UeyEApT7PKfFbwCV29mYMBw1GcbcaO2ubDNWOq3zRg4ej1j6/LPeAV8ZhBnpeXusaHMqaOYr+pgiK8dWa3Ui7QjVRtSXBy8PsF7t6hB70rQU1PnwWyoAEl/XBAqaxUE2z/CycOIBEHH/CP0LOEvs31uiBN5hNddRTt/lJNfDsmmsG8ZGkri65LIyAyOIW7rzlNR6g5CTLSaBz1dvmzySqKkNxaJywd3egd9z687sEhjvTGEAoMRoZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4yZH33TfayQ3CfKxML6b8q4PQRDGTdME5dt4lUkDMM=;
 b=cRNVQVpBHxMJPmZs7fQ1t1R66Mm9vGtg/U3g8/MZdvnlAPYAJcYg6Ew3c5PvjLjsRomDj52+ch55+7sxn28ie6zO6U7oBSggWn7BXJzHkm/pfhtN/BFpaVcCQOVoqjIwopN+xUosmiCz74uIzfmuOIoztyIuzbJHGU+tKAMkdE4=
Received: from GV3P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::9) by
 AS8PR07MB7128.eurprd07.prod.outlook.com (2603:10a6:20b:25a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Thu, 25 Aug
 2022 20:39:11 +0000
Received: from HE1EUR02FT067.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::3f) by GV3P280CA0066.outlook.office365.com
 (2603:10a6:150:a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 20:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT067.mail.protection.outlook.com (10.152.11.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 20:39:10 +0000
Received: from N95HX1G2.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 22:39:10 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] client: Add missing return statement in error path
Date:   Thu, 25 Aug 2022 22:39:03 +0200
Message-ID: <20220825203903.3526-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.11]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d905db8b-8765-4c31-2a1e-08da86d9dd8f
X-MS-TrafficTypeDiagnostic: AS8PR07MB7128:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XwsiTYdQnW7bB3d/z/+NDW+7BFBvd29kDRXXwBUO7xi+oUq/evak9flaGlylRIlDWrOw1nCA3B0YdI7XhCRcWlb9WutTT12pJ5eqvBRAmY7gIDNqxIxxF74WneafA3z/9KkzH6FX/bGIiQQtwacgMrtvnVd+he9GOTNh+GMtT2QuMjRkT8CnxwYyY40JUl8bkPpajR9t64h2mIHAt8oURnofZ7fB73ZaEORJIsykvWY+ew05U9AnuAg0ekwplgq1+jyO3jFSYQ8Gr2nn03f9VszCSLDuG40/z+Haf3ZYCekJARyKzDg0WJBQOl3M/xpEKV30Ya9SuaUd3au6G346AqJxej1lVGEi9COpyhl97V7N/GrtwB/z9Ij70hFFzBuet0QjhcPCEOk/GGdVJnYlXsfS4wdDaQHtFLXD0KyLmqA76XsCC7eLOjMsbCWAxOk8PJlQiD7lXx1BrGf4E0Ie25LQXM/y0d1nRvkNsEDvAacx52F8wyc+lihE666tlYyKHP6uuq57lQ7n+1nt05iN2UO9jf89ahZM6wu2dr5BNPdftXsEE5Kn7MLAiy7G7JbwDD9voM7JKDQCJO62A5ny3yu6lsYNwUolAjm3H39d4NpFpnryjdFYNVzcVrLTgTbtSaCa2SPFHTw3+vLt8yRy7vFsLI9bUp8U1YgZSghL7z4bqmLFB4jOcPo9afVNzel/VMPGem9IcA3YwhQ9ZidwHYb9fJPj2CxtN4yrn+Gb49LLmbAhdRQl6xsw097hMRvJ5YUk+n6ty3bz5lWpgWEjg==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(46966006)(5660300002)(6666004)(478600001)(26005)(41300700001)(1076003)(7696005)(107886003)(83380400001)(426003)(47076005)(82310400005)(2906002)(16526019)(4744005)(8936002)(40480700001)(2616005)(54906003)(186003)(6916009)(316002)(336012)(356005)(8676002)(4326008)(82740400003)(70586007)(70206006)(86362001)(81166007)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:39:10.8765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d905db8b-8765-4c31-2a1e-08da86d9dd8f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT067.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7128
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Client will SEGFAULT if default_ctrl==NULL

Fixes: 936ad5ef7b56 ("client: Quit when done with command")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 88c7ad799888..754157b169c6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2546,7 +2546,7 @@ static void cmd_advertise(int argc, char *argv[])
 
 	if (!default_ctrl || !default_ctrl->ad_proxy) {
 		bt_shell_printf("LEAdvertisingManager not found\n");
-		bt_shell_noninteractive_quit(EXIT_FAILURE);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	if (enable == TRUE)
-- 
2.35.3

