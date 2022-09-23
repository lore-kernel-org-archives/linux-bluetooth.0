Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A51C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiIWO6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIWO6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:58:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E611CB09
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIvMC0hoVgYD5NMHzDOZGbY9IxB54u7weyYEoIqpf0woSB85r1YJpKZ3ru7K7vBJvVyEs5rnkOmtincWuSuQNKD5oqBfJW9LVGWWHyh7Id9oifxSlVRcOIR7sNZ56HzO2i9AYElakPbyCv3Qg+wRLqE/wXCFfaUQJDER4zWMzc3BcWt8i+vlKrtrLG4A4OgxzUFm6IkXCzqmlldVDEi/XYdn2lWqMgJd77JHYiqIucpT7tDsNGArz57tB6/ZfXgJsQh249GtJAyFbsWsmWte+JeSA3iL+m+V2WyGDCKezKtqQlk3Q64bQcGTn8khzwESSieqCtUwEExxFbz9XWyEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7Kk0q5xn5naleEfJu53J/kxWhCv147kuPzhvuzCRmI=;
 b=cBRD2qRGV7WOkjwchxV5D/29F/vxXnExQAJQB88H6Tlcv6diwbNPOStDcIAx4QLYE4oZpfqRZnY17rgMKF12POUniGXGFJqVFNd/WgZXPqrqJWVpjVo4PP5XXJu0ehG91VHV6mrCmkRuPct/EIQrxGdKK+JmE7/s19eC1TdO/77kiWlGOYSFCd+97g5Q/B9AdLIEGgU8iKAA5mCiYgw2nVfP1dyBJary7NdsnFAfs2IzgbVz2qi5Ltc8jha0irpQGmlMtxs7gu2tLa4tMOVAW3fnO1x8t/b9abrdLdR1x4/IAzugBG5o1GQI70jdqCtWYshdYkeCV7XXo4WknqDCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Kk0q5xn5naleEfJu53J/kxWhCv147kuPzhvuzCRmI=;
 b=nOPgGJSkUt55imS5ZQY3U5MuyFKlR7pB/qNFFRzicnHs1Bvfufv5H3ZxjgA9XSGTDvQWhhqal0MwZFkdaCyRz02ebCrkVbBjizbAwSiP9F1IdEyoTvwIlJsKb25270307PCNnclP6OYe6+IM+q/YpW4gVke5QVLmxzKoxaw5+HY=
Received: from AS9PR0301CA0032.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::30) by DU0PR07MB9241.eurprd07.prod.outlook.com
 (2603:10a6:10:42e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 14:58:28 +0000
Received: from VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::38) by AS9PR0301CA0032.outlook.office365.com
 (2603:10a6:20b:469::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT107.mail.protection.outlook.com (10.152.13.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:58:27 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:58:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 6/9] advertising: parse_tx_power: reset value if iter is NULL
Date:   Fri, 23 Sep 2022 16:58:11 +0200
Message-ID: <20220923145814.26077-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT107:EE_|DU0PR07MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 9178b28d-648d-4ee1-e6ac-08da9d741282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl5FhKHaEpd8kwmwdXwQFCdCx6aRM1SADtlMBx7fcyT4j/ozivQThk/J714x7CYH+y2AwYGYXQAdjyS1YZu/oR+6mB/JTNOrqnKXcgCwaeYjAYherh6gZdfr1Isbzx6eLwSlgUYAk8Pf4Y1TzZ2Pu2G7Eq1ycSe28FaSo71DLT5/dOuXu1yHKygF5j8cmW44YrUgGXPh1p3wg9ebd4FB9JPAKowIexTjrcfV+z+mm0kU98hbmf+5UYx7Q0+Bv3FbUHblzk7cZr8TXeIulrq+YVobwvvaX3tj5fRgYR9uksqMt18HaEwfgfk1Es+Evbj5aFgKwFDDQw7Pv5VnLRRH2NGXknqD/GddOGkfp8RvgbaEGAb9NYclmiLJ52+7os296RhUB+CLNGVZan4gPSRY+OTBm6kpmstNEPbzDDOzHBwbr7NdiaxJ99eUoeJjflgj+bV0Ps8rzImKqnEhr7Bf7c1Wqc0ZM42gN0pENIwwaPf2X9k8pdtaF+F8G8J2GoSAOQv/U+ydhyIr9naB355isPFhqfcyHB4dbb/8sN0V3Zx+WB1I68FNxVH23GicRtb7IViOSzN1WcQbme8NJGnbAIC7Cq6qn9WQt+0oaidC2LZKyX4icn7MhxtxAwS3E1qGjFbCWZganzo4+egX4sdnvWQlPcjHR/o/ENzrt+fcJSmCjN1Gh9fQwIUz4wDU9tNoqmcJiZwFpi0WWVhj5fbevHlLc3+nkFdiaOQutKEjVIHTEAGMX+732/Rvnf2G+Nyn6+r3kSu0J1SFvv/nYizS+w==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(70206006)(316002)(6916009)(2906002)(478600001)(5660300002)(4326008)(4744005)(26005)(107886003)(41300700001)(6666004)(8676002)(16526019)(36756003)(7696005)(8936002)(186003)(1076003)(83380400001)(70586007)(336012)(40480700001)(47076005)(2616005)(426003)(86362001)(82310400005)(82740400003)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:58:27.8213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9178b28d-648d-4ee1-e6ac-08da9d741282
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9241
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 25df2297b3c1..f9748b1328bc 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1153,8 +1153,10 @@ static bool parse_tx_power(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
 		return false;
-- 
2.35.3

