Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B08C6FA90
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIWO4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIWO4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513C8126B62
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeQyxRXBcDhUShN3/KCf8arUIZXylViae+gFBTBXHOZSfXsr+Ba3MOWdO9G5sZUuaBv7lhaec/eH3fZAda74bXa2dNwwk6v5CqIGQN8CzbhT2amsao/hqmsGSboRIlfqQL6CqGbqhTcD7lQa17YHMR4JVIVC3BibI7FNliOuol5SpGQR9OIUboPcKcfMG57dnEdEanGAhv8ch/SJ9lp8u2Dim8V6wviargiaRvzc1B7bIRXvi9lu/j4u81GsW9Ln+74S0+NUucnMw6+IQ9jtacFHmpLiRxxi9O7wJN6gANjwrkkGzvRtsFYLlWQcNyzLtWDRGXVbxpxy/joLCLO+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=ZoOnkjn+K4odxxZizMh7StFmxBz2KV4amfdQ0mirMuXo9FEz4840NcHMlDecj6/fAssl2PXcw3gS3QKI0wQFCDCQ/YN+GZEi2znjCq2/AgWzVzO1wXMXWOtH7Necsa3Dj4SYVoMAK7/358SG8jjnFS54JUHVxreso2qWcxjohmspRJRs0L1nR+SvgPDNGgztqIzoVeXTDawxY1fC3YBLgOF+MDH7RSjp+lzakrnjH7+K1AofVsBUTLhrB7Mk71HitEFecwlATzgCxqdAf2zTUSdGRBFCk1U7xj3ZARXkuAo4Zi/YMLvRzn+Z43vBZGJHfzoUfbaDnC3f//T96QleVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=zicRTuazScWGOH8DuQX2EnVkYtm0vGuP8c4PcTiLhIHPsFXNrwLh1KwNvYmRq1O27dbFZ5zljIvXl+EWSVA3xanYD4k088iXO+CU0cbqqb/gpfu3TJs87iWYWnNb9A3dEhl9mfAhhLTjG4L+fyJld2izWkqugJ68DpE9906+jW8=
Received: from AS9PR06CA0654.eurprd06.prod.outlook.com (2603:10a6:20b:46f::30)
 by DBAPR07MB6487.eurprd07.prod.outlook.com (2603:10a6:10:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 14:56:29 +0000
Received: from VE1EUR02FT084.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46f:cafe::77) by AS9PR06CA0654.outlook.office365.com
 (2603:10a6:20b:46f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT084.mail.protection.outlook.com (10.152.13.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:56:29 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:56:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
Date:   Fri, 23 Sep 2022 16:55:57 +0200
Message-ID: <20220923145602.25872-5-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT084:EE_|DBAPR07MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 209ff42b-e0c4-4604-6be5-08da9d73cbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJWBllj+q9V3upW0AN0XOlS3zJtgQ7HQsXAWBvNbCA082rCsnrrN7PVlawnlFleAmiPrm0D+S9rKCEwSotbZ7CWjja+j/PjZf8dXccRJNoDAal4AZLqIeCrnYgQmT7r/+Gb4NtKCLkp0NRtGCoXzpDHYlWQdLY6ZYPmFyIYO/vjQ7KKes0Yc7gr+1W+IWt1lTpmVK21T9UQVuGNINIFx7bA0oiZqMDOvaeHLtI2FO5EQl6hM6eU67ugTmmGxzrF0HXx9HxJnNQ9PPMNC+HF9VBgZp86Yh+5P3V/Kf0uUxW4WZq06bwD5VQNAadtet1j3YwZWtIGYV57SsbQiVr+OVgB3DavlUQIaInFanPH+1gGT474p94EwPqnTr+RIgTUxCUVK+DFz2JMj2nqnRhjjuzWTZXaG4k9kVZAc96sautwLhUlpn2stsrpvfrK+1YmK2CZuobPugO0tlBFa1lS8gEW4wHsH4LSuhW2ndNbt4wRt4/ugwIozGsWy9nafgTIn59kD/EJJf93qTq4dUM/tZ2ePJpPv+JFR+gJf+cIDZftYdWKz1FvhnN1z7YsD/kdb2NZNEJKE83fcxta8Lt2d9LutAzekdCCtmpcCYguZ7pwIPEVGbgWcvJGUVn1asra9HSyU+Kx2EeSLBGlC1gCoiN4zUv+GaPhFpHGBjeG1eEiNlXOGaR3yVEOLrM9jHC2DHV9D0LfJqDHNy94uyndtoRuc+7ClxFVIeIpbEJ3qXKsH5wvePoGrkVO29156/KgJyLh15Lz/jr/1VCwD6IO2w3y7nHgkG2zyZp6ADsi8MrJ8qUzXi/XEXbo51rg9RvdK
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39850400004)(396003)(451199015)(36840700001)(46966006)(36756003)(26005)(81166007)(5660300002)(70206006)(4326008)(6916009)(8676002)(316002)(41300700001)(70586007)(40480700001)(107886003)(86362001)(7696005)(356005)(8936002)(6666004)(478600001)(82310400005)(83380400001)(16526019)(82740400003)(36860700001)(336012)(4744005)(2906002)(47076005)(186003)(1076003)(2616005)(426003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:56:29.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ff42b-e0c4-4604-6be5-08da9d73cbcc
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT084.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6487
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 6d8d06edd34f..fbfd90b4e300 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1087,8 +1087,10 @@ static bool parse_min_interval(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->min_interval = 0;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 		return false;
-- 
2.35.3

