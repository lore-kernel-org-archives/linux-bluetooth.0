Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB32EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 10:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjGMK0j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGMK0i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 06:26:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419910F2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 03:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz21gsKT8HwUbOKuufT0U0XGLEoKZXSE8F+t7As+eDuBq5iEpu+5A1S5AJTNF26GFlZOLR1SVVEPfwuh5exGpq56oK1nCSAIAAUNNfQDQD01XbhruLjqn1HgndvX6NjwkRgwrB9BVB77J6oiEQWwxpRHJ4vXJrhgp0Vp06Kvi4jOxuZM0IVABTOMq6p5R27fIkCpNWqyqExsOVUzYKl85pQ4rwso6cJ6eMZkQF6mz3EJFwsF553wt+Ck/n1T/ddjfgdvc+mMqT5KVM1PoZNVZ2WpriFdeokJ84ibnx864/FcQJCZHQCAQIHxStUSXx+mgi91Cg6juGGXjBFIBK/pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ2EabrlHklA8m/aPoQ6a1FIOS/ppFGjWMYK7O/n4MA=;
 b=DAXu9hOEsf0VMceHx37tN4IXIz1cVFS065S0c3FSDqBVV6GbhhDCpy2DFtEByp7LuwhA5tCeVAdTPY90l/VMc/gkltkios7PRdmI8AB5TFbi9nq6xuDBQKlZVgTxE4e1aTqaSS0c8x6056reqgN/5LU1edVVEBpVTvtl0LIdih3ZdczM/Et5xxBHybmRuANZ0yh7NwN0cHB0UtnY3jYWj1yzDWYsHs+WgvjqlEid5X5G6SZzW28FAtvpyxScDQuIHjqOQBPOV8It0jxpl8V6kcs/TaIGqjD5tjAwo33BlHLKlBH/BwLidrOhlWto45Q64vqGXESmoNhBebAlVZmRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nordicsemi.no;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nordicsemi.no; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ2EabrlHklA8m/aPoQ6a1FIOS/ppFGjWMYK7O/n4MA=;
 b=IBSpiuANQ+4D6UqPO3VLJtVFe1ZW8Ro6mzxmZaX4J+VXkH/bcSinJeekp4PSQVwOv18VEqsJVhcqzF+4cWA4me33u0WymQZRPrSoX6Bd9f8OyFom+F7o6iZ4S/DnK/DPXk0lRHBKvCxH2zx9vGK4KOtedm9gu5rx0hw6ia2Xe8x5DlM/g9WXY1iopIsR4PS354tyDoITw3DBiOASHpOQ/PMO1vu0ioXrmS0IySnkOcCnb5U+pG/yJjvBPqwXVeN5hDt/08MfitOyZGJADd0BLBzNE+N75U0pNQUB7FwNuszz9r5biDABe7oCC2np3CBqcR2ka4PdTqYi76wQ/3smGA==
Received: from AS9P251CA0005.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::17)
 by PA4PR05MB7854.eurprd05.prod.outlook.com (2603:10a6:102:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 10:26:29 +0000
Received: from AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:50f:cafe::d8) by AS9P251CA0005.outlook.office365.com
 (2603:10a6:20b:50f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 10:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mail.nordicsemi.no; pr=C
Received: from mail.nordicsemi.no (194.19.86.146) by
 AM7EUR03FT039.mail.protection.outlook.com (100.127.140.224) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 10:26:29 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@nordicsemi.no>
To:     <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        John Holland <johnbholland@icloud.com>
CC:     =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@nordicsemi.no>,
        =?UTF-8?q?Carles=20Cuf=C3=AD?= <carles.cufi@nordicsemi.no>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [RFC PATCH] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
Date:   Thu, 13 Jul 2023 12:25:14 +0200
Message-ID: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.241.138.38]
X-ClientProxiedBy: exch02.nvlsi.no (192.9.200.127) To exch01.nvlsi.no
 (192.9.200.126)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT039:EE_|PA4PR05MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a90c0c-941d-4d3d-2cc4-08db838b9f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUSnK/fFUpuTRUAwca4Y33QMn3g5pOu0iBYt26ZnhRuFqakQkImU13wOb0np5VofqTq9v9M/Om/Qbc7LqkEe9fj6Nvbt6JRu9rTlSwa2M4tMD4fl2KeavYHs/qUA3KIU9eqZBBflBzB3HDfFRCbvMCvP6/FCj/uKH/aeCiEr/NhFwXi1mZo/3eCAaz+KzhELzvCSIELRkcReVZ7NtS4aIylsHxGifpcwP/UciCZ2jw2Ve5RFSImyZ57faQAUAGisyP7DwWFbOEy0sWPnty9rIICV1n/lkglEQhbx/yfHR9RafKvusMQ2RphS4q9VuK/C41xl6BmIadzApkvcpbS7ut5iSowCP57r8+fLfvwJYpSJ7vIFXjavbpnW8aruHDw/AQPYdF5hP8ARewtRoLxo6/50ov6i+rvOtdFYOBECJv/DOElktNMSgOnrcaODIxVUVz4Mh0zulRuj9V7TZGhs2QGgZxsVQb0uwWjR2zW9VpMRST/BhI8yVBUzM/Wle/PA40/mDt977Em9LwW6ZbfJa/dRHrzw9qep0vKkid4FGXIiX2gWdrEUjEjb4ohCv2l8psq0u2UEOaFLg0WlsbiYfiQSg1kHaRW3Il/lXp3xZ/R2mM6I4Z0fKp+6n1wRbk1GR+P2dleC+UctaGbZIiLfVUHVexREOyG1Onfc7OAORUvAAQCYKDbk9c5HQhnnz/9goz6gGY8zGY8rN8AW1lH8sYAGOZUBb4dMg53OeSCm2h94Z+grJqqlowCtyqoDaSeg
X-Forefront-Antispam-Report: CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(2906002)(82310400005)(118246002)(966005)(356005)(7636003)(336012)(83380400001)(47076005)(82740400003)(2616005)(1076003)(40480700001)(26005)(186003)(86362001)(5660300002)(36860700001)(956004)(8676002)(36756003)(8936002)(110136005)(478600001)(54906003)(6666004)(7696005)(9316004)(41300700001)(70206006)(4326008)(316002)(70586007)(36736006)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:26:29.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a90c0c-941d-4d3d-2cc4-08db838b9f12
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mail.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB7854
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit c13380a55522 ("Bluetooth: btusb: Do not require hardcoded
interface numbers") inadvertedly broke bluetooth on Intel Macbook 2014.
The intention was to keep behavior intact when BTUSB_IFNUM_2 is set and
otherwise allow any interface numbers. The problem is that the new logic
condition omits the case where bInterfaceNumber is 0.

Fix BTUSB_IFNUM_2 handling by allowing both interface number 0 and 2
when the flag is set.

Fixes: c13380a55522 ("Bluetooth: btusb: Do not require hardcoded interface numbers")
Reported-by: John Holland <johnbholland@icloud.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217651
Signed-off-by: Tomasz Moń <tomasz.mon@nordicsemi.no>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d844fb8e7cb7..ab7d62538b48 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4258,6 +4258,7 @@ static int btusb_probe(struct usb_interface *intf,
 	BT_DBG("intf %p id %p", intf, id);
 
 	if ((id->driver_info & BTUSB_IFNUM_2) &&
+	    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
 	    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
 		return -ENODEV;
 
-- 
2.41.0

