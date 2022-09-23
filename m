Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDFEECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIWK1o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiIWK1Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:27:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60130.outbound.protection.outlook.com [40.107.6.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D211128883
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR183U3JbKh9iUkGdGxIGlFmkP0kB84hdI9Ts9Yy16em3XgE+tPC4DCHbSJd4FNQ0D29+9ck5RIymLPIRGdHZctHBO/Po/T/enL8y2WMjoeTCIT7QAHL0p4ARIlz7m7zzToGJCdUfUMBLwTKkXg4KtEKxoc+BRf8PpOdg0/FF8r7OeVA3xz6qwBef5cpT42mqUMwCkgEu7PlS+c8B5M08NPB195nfvGjN/RrHlmcH6zu9evDBDzATwov1vtWwX1fofJUzI14X3ulGt7ZXi4ZB4UMaMBOWlJXo8Q80uRQfD+uOLVnjIK+sz4LBsc5puEYZaV4Ayrhjd813oA2krWojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmE3MKKIlxMOZt+/ILTc5UuPKfu/KwXQxlum2V0NXJk=;
 b=Kh3FhWIeu072AZXxBYJoGmmDn+MfbVraI9DIablLIjGNjHD4vzDdJ5b7S6NDVatxFKpVgjm1ZUtxJcYV+fgnpFHjWGyZAXzuLXLquEgIy1e8VOyZk6zn054gBOaAt1Z3k7P/kqcUcfvg8YbUaZDSRcOhOX+pYqBiqM5Q3OWP18oVlj5hn5nudLPijN9sLZCARWVoZ16Lp76JQXvWAguktA9egAt1icI3qfpcPc4WRYDAGREjQtHzSOOagIJt5PadJCVU68vL8FApxgMdoAH+SbAtjob0JR7nhX/pTmolQJOgVyqn7FD1T3jdsNDP+qtXTZqa5uLWcBEZCo5bcUiofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmE3MKKIlxMOZt+/ILTc5UuPKfu/KwXQxlum2V0NXJk=;
 b=Ie3Qla+dmctzImL6GLnqXiWvmWfUbIKe7426OF8bum+KpD6chSWuAw/iWs66WlSK1rdzdFEZ/ieSOsHVuKY5EDfwdKwXA1cLoCwH45+vc3YLOIh2Ujthy8XJAm7r6QPA919evBXntPK/lsxKOT45KcBdxv13Nh3TyE0TnxZKtSw=
Received: from AM6PR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::39) by PA4PR07MB8696.eurprd07.prod.outlook.com
 (2603:10a6:102:265::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 10:27:21 +0000
Received: from AM5EUR02FT037.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::3d) by AM6PR01CA0062.outlook.office365.com
 (2603:10a6:20b:e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT037.mail.protection.outlook.com (10.152.8.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.19 via Frontend Transport; Fri, 23 Sep 2022 10:27:21 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:27:20 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 8/9] gatt: proxy_property_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 12:27:12 +0200
Message-ID: <20220923102712.10604-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT037:EE_|PA4PR07MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d044dd1-8db3-446f-39e7-08da9d4e32fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJucAEJgqp6vXkEKcOpTYjrWUgyYGVOZeZT3QtIM8nOjm/RFWQOAswr7my7EWItyK3qISNtXslZ9GNcmtUoMqQLCj86+bRdt4Leo8ffIFzgeAX1/z+X3g7ItUnNW7cOwfrCFCn03oqUUtG0evQGJ3RjJ6FrGu9CipfEM087E3x/z4VMKFoX7HdFTyf+kK2oLcOysAH+r6qU6w435eBWzxYdA/5l+URtx8VoURKLFAbf97msTgiJta9PV91ZLrcl/0z+dR+iHasWoB9z3WjYe0u+CKQDy8VGd8lLmrH9vjDoKFIntB/yvVsN/biLv4VGfIg/OqeaRivOLOnaJLx9VhGh6c5HaR4By8BIXFz0hUZnos4ku2iOW0Xefsq2+CxJGlEX5rYgyK7F7EIXwiNkcUSbAaUm2BPxFhcaBejeG6RlRnFHub7tYPsSfgv5gEnjuvgb9ldgoQEJP1rnz+0AOP0Ocy7TO3uig0wlvIh9wI8qHAgHIzvd4JIE7HxfgV5HHN1B6BIZebhi7YPYfLA4ORrcHKR3TFto2W99KYJQUyX/YNiPYiZRL2TZyuGQ4L25tuHXFDWAophJ7VjzjmXFp4G7eIYAse8FgNiCTE3XEvIyHpeP/zUAOTukOuT3utZTu3sv/8N28k1YtJvx1ibij93DOby9MIwlCzxxXBCIVM3lwwSktYYe5fmj4Kp18HWyuVcMAGAlJX19xynpvwQKPpK0FHVL5LgTMAjBDiz65YCruS8vPwG31b2yB7HfmvGMfd22AxMFJRskC/0yGtdPhlQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(82740400003)(36756003)(356005)(86362001)(83380400001)(81166007)(36860700001)(26005)(2906002)(40480700001)(6666004)(2616005)(6916009)(107886003)(336012)(7696005)(16526019)(478600001)(1076003)(426003)(186003)(47076005)(70206006)(8936002)(4326008)(316002)(82310400005)(70586007)(8676002)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:27:21.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d044dd1-8db3-446f-39e7-08da9d4e32fb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT037.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8696
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The passed iterator can be NULL as in
src/gatt-database.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--client/gatt.c::property_changed_cb(..., ..., iter, ...);
      +--dbus_message_iter_get_arg_type(iter);
...
---
 src/gatt-database.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index c72f4a4d5c54..ea282d4bc193 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2867,17 +2867,19 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
 	if (strcmp(name, "Value"))
 		return;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
-		DBG("Malformed \"Value\" property received");
-		return;
-	}
+	if (iter) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+			DBG("Malformed \"Value\" property received");
+			return;
+		}
 
-	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &len);
+		dbus_message_iter_recurse(iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &value, &len);
 
-	if (len < 0) {
-		DBG("Malformed \"Value\" property received");
-		return;
+		if (len < 0) {
+			DBG("Malformed \"Value\" property received");
+			return;
+		}
 	}
 
 	/* Truncate the value if it's too large */
-- 
2.35.3

