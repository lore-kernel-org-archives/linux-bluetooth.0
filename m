Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF54C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBGL60 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 06:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBGL6Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 06:58:25 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33314EAB
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 03:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUB/BVNIxa6mB46kmAUY7J5Q1AyYf1wK19zm4tf+HMzLR1M6+juYqOb6jgHvaO7MTaI6eYUCKQdTSrqVO39a/+AV6OcW4DiLYM+poNSuW5JQjLEdsKwuc5fyHAlH89WAcHKwA1A+JJl4i2hhDWEGKawy+GspwMNdkH/A+ji7BslgjTgBYj26qzARPuBJulYBe8gT0RTLXvLMXhB4G2ea37ISqtKp9R2Oz0XkJ3wAzsEyiAD500s8PjIuzDK6o+fae5GfobKHBUH0m3RCJJrGByeyZ6JCx6/GIPkdFjkppEfF1CY2qHTzgyHQ9j5vEdQ6bX96nE3q5QxtOHn2t75tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff3H7zA1G+mP5zj9SI8vxCT4NRFdpfVMoY093rdqBow=;
 b=FZ9vIBDdiv1gaCY2KdLJQTkNk46OPeKZXrV3cRAIfN58GGLb9YFzDfLZ8/6faOkCNxifltWSZDhuvZReG+hkJFjbC/KymdDTHQireRjXM8+smQhHXhjM4tE40fWT0uoNPq4+3mpuXZGF0zI1EEwsUOlNeMNXbyDDCXRY0La75Bq7d+2b6pQ9py5THewNlvPhj7Sh7yEMzluYoRfOCHn8D5bL35MYtEEWhOwT1SVgq+Y/q/zV7wOBGekvLBZrp9Lewzp0rp6z3FqBJctwtL0y0OGT04ucldj/6ARpe83e2+bNrIWjIzc+Cy2THZZz1CYVl5cevX/dCICW2YR1GR0hRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nordicsemi.no;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nordicsemi.no; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff3H7zA1G+mP5zj9SI8vxCT4NRFdpfVMoY093rdqBow=;
 b=U2CpxK09XX4sHBG+Vb9I5AGOVXdAz08BslE0JMo5YCbrSs2sXjb5XWEhL6Bs4oRbGLZfFY7uNONR23fZsmEQTyEOwRvwX3q2ECMugO+0yl54jCrx2qSa/8EsSrQvaz6PftuyoLGbyERMyskzNfmwpBI1vgw0ZnCI5+rBlxCk6vMc/hH37OmvXv9ixZdaH5YDX3R95lxPQ2ETtK79md4kX2FTR8fFlXTyEhXsC23yy24ez5HXcrp+hDeh3Ze/isRl1FONY/o5HrgctBVi2pbGGUMHw0JjNSoWD3sXTmlGLbssAPGwbFdylw1aumi9+dMldnSiU4QHftvrSZ6X2+8OnA==
Received: from AM6PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:20b:6e::23)
 by DB9PR05MB9101.eurprd05.prod.outlook.com (2603:10a6:10:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 11:58:18 +0000
Received: from AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::39) by AM6PR02CA0010.outlook.office365.com
 (2603:10a6:20b:6e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 11:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mail.nordicsemi.no; pr=C
Received: from mail.nordicsemi.no (194.19.86.146) by
 AM7EUR03FT026.mail.protection.outlook.com (100.127.140.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 11:58:18 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@nordicsemi.no>
To:     <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     =?UTF-8?q?Carles=20Cuf=C3=AD?= <carles.cufi@nordicsemi.no>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@nordicsemi.no>
Subject: [PATCH] Bluetooth: btusb: Do not require hardcoded interface numbers
Date:   Tue, 7 Feb 2023 12:57:41 +0100
Message-ID: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.241.138.38]
X-ClientProxiedBy: exch02.nvlsi.no (192.9.200.127) To exch01.nvlsi.no
 (192.9.200.126)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT026:EE_|DB9PR05MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eee6d6-dbda-4bc4-d9c3-08db09029a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZQJFQUw8MfnLZajqW7vrkSRjxwm8ir77CAaKv8B5HhS01/1PUh5K2irQlj6iclyODz4nXaeSMkOkc8E3IGjxBWU/CE0IRvL8id6CYHUTFYRtFaEnQO9YnIeGZYPQIUznIY3iORSwuUVfPKA2LnZIHiIlOH7gIT96W7LSVXGCLauDz3hFURtBc+7q71nWbvHWVYYZw/pYPKovptY4tuNbsoB0cS/OmBkRrsRlpetgOucVDfVP2hh2qyiVmQldricHZBejFoXnVk8HVDJd6USHi93t0Kb4BI0XEx88LRQKXChG0mLquzIA1o56ablWA5U+36LvqOYM5JgSJ/E5zAr45gTXONaZS3k9tYBKr3CY37OR02mYYE32nDXBPFrWpiYYB/gy+nZkqUbXfkucr8WkRRLRkKDZjMcqQvGSQT70H53nW5Dmsgg2cr7SIpBtL5EJ2GDVNFvbDWf+WVGHU0lhx+bHsnw81xW0/8QyN2D+UWXC1FfOvY5SQYprFlSkStNb2abS303eIvUXpqU6bWqJaP4271BwrllpAZG1S35FqGCE71hcH6G6OAKepvXFeOgKtyEg7xaxSUtvHDohSuNP4WqTerkQGUy8kUirfNyqFbL/lsRwBEYQ2utMek2l/a8ocwtbPZI1P5CnBQAdV3VYHsEq5ods/xCvpHw3kEuZPk=
X-Forefront-Antispam-Report: CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(70206006)(4326008)(8676002)(9316004)(40480700001)(83380400001)(82310400005)(2616005)(82740400003)(956004)(336012)(36860700001)(7636003)(356005)(36756003)(47076005)(54906003)(36736006)(6666004)(1076003)(110136005)(7696005)(186003)(316002)(86362001)(26005)(478600001)(6486002)(70586007)(107886003)(2906002)(8936002)(118246002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 11:58:18.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eee6d6-dbda-4bc4-d9c3-08db09029a2e
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mail.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove hardcoded interface number check because Bluetooth specification
since version 4.0 only recommends and no longer requires specific
interface numbers.

While earlier Bluetooth versions, i.e. 2.1 + EDR and 3.0 + HS, contain
required configuration table in Volume 4 - Host Controller Interface
Part B - USB Transport Layer, Bluetooth Core Specification Addendum 2
changes the table from required to recommended configuration.

Signed-off-by: Tomasz Moń <tomasz.mon@nordicsemi.no>
---
 drivers/bluetooth/btusb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2ad4efdd9e40..5110d26cff7a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3830,13 +3830,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	BT_DBG("intf %p id %p", intf, id);
 
-	/* interface numbers are hardcoded in the spec */
-	if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
-		if (!(id->driver_info & BTUSB_IFNUM_2))
-			return -ENODEV;
-		if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
-			return -ENODEV;
-	}
+	if ((id->driver_info & BTUSB_IFNUM_2) &&
+	    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
+		return -ENODEV;
 
 	ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
 
-- 
2.39.1

