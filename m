Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D965C4741F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0217207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="QNc/ATkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgKJKNn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:13:43 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:60240
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726737AbgKJKNn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 05:13:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSSPxlwW/QPr09jMf/k6ytB+wz2Nu+AL91SyDtIDJCGFpVSVPGR8OJ69rPfK73CkAOTt6CnPE/RYOCs1r43KZrZGkj4E0MClagkH8pA3YjecOVdAY8bR0VBbcGzrcS2+7Lmg7pWs570sgixO2Gd72FpNcrQFRlFs51dSZcz/VuztG1xLJaIGBVPUDIXd/IrRQ9l1D18YZHfeYsaU0itznbwa8o4vz7N3Um8HypgxSKF1K49XXucjiJJ12EhgfcujYZjWmSrrAXj0O9qaJvhomgFUfW0+zS7PF+hy9We7zLG8uMiQeaV7vw/3QZoAYLXQLymO8jNpmBdubgmxKzFtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk1tTI+1RUwg8nQksIovW/9WlTswIA8IS8jfkkAzqCc=;
 b=nM2MAPt+hJstUoZgbSL9MKBycCLwXHjeCmW8i+Zdfg9gtLa/eez2jJgSZLT2wZpLKfRbfqAoiFWgqUifD+z2tJZwfWcOJDQMNfRwyBltTkrYlQoJw1n66TRMpXCoBBEKo8GRpkbqGbUGBRHHBj800PUUvSl/wTiLwDWVR26vcdAy8lKs+5tDCsGl+tWbg1OoTgv5o+xqpoyZXus7xyeMWuoBkLG2D2x+AYWciPGpdfke9SmiPKSV8gUF+Mj09AOEV8zbFq5fSw660IrmgHe2GbfyW885DtmQsqkfBYdtocEcUV4EQm+lsasIXyLwH1VjAUOi38mZwC44ar3/5iFhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk1tTI+1RUwg8nQksIovW/9WlTswIA8IS8jfkkAzqCc=;
 b=QNc/ATkDwdrYiMM8sG/cY24NIYbBQLsmuOnGxd1noKk5zTCb411r6M8LmPD/5+ZO1f3rWCZFmcsgU1ER1eTXfk2r6/J/9hpT1/2zBvxrzHZM+ugtpmcPo/XByRVMgD0FokVz73noSzBuO6aP6fpNoAVm2Zg0rai/wEPOmQ+g8TU=
Authentication-Results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 10 Nov
 2020 10:13:41 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::3c06:91b4:3df0:a232]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::3c06:91b4:3df0:a232%7]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 10:13:41 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_ll: add a small delay for wl1271 enable bt_en
Date:   Tue, 10 Nov 2020 18:13:11 +0800
Message-Id: <20201110101311.1657220-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK0PR01CA0057.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 10:13:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a16ed0-634d-494f-1bd2-08d885614bf8
X-MS-TrafficTypeDiagnostic: PH0PR11MB4966:
X-Microsoft-Antispam-PRVS: <PH0PR11MB4966C2C1570CA5CD4B64429395E90@PH0PR11MB4966.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/b74t/vUZERmVaSdFqe8jfA2dUcmbNDPcq1uGRxmklBYxb4aqr2ohSNzWRrgPPo0yN5+TU5005Z6oyTVvBq/dmB+zDxVcsE3D0rObtF6NDkMcrvc2SHfKdoT1A/EkyUZ5rJHmook9HX5l99hqngR2MMjwVT1d5icikMNMkiUJ9MuRkWObZHwWwMdClA5NrZ7UIJTpLakM2L/IsEpLzXCqditXf1C45XorPs2vnTDOhpMzWCXZTblQMyw2wSyM2OrOZW28oaT8VaH0k5vK3qZMzxYHoWO/yfWvR9lXArA+RSN+S199aifT5nqzKu1muNac8F46swLv/paKNo4Tsx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(366004)(376002)(136003)(66946007)(6512007)(316002)(6916009)(52116002)(66556008)(186003)(16526019)(36756003)(26005)(66476007)(86362001)(8676002)(4744005)(2616005)(5660300002)(6506007)(6666004)(8936002)(44832011)(1076003)(6486002)(956004)(478600001)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FlEevJ9arikWqDGo9nUYSJYgqOjT+XzgXNam3K60eI5U9qekvZJ71pUcanzNVEI2DL9T33+HSRzUJlSPlfXB12UAKLZdwcgz0bwA3rqZh8Ad9Hhvw5x6IHGQJSXI46OTr/WzAXIOeIMrGsWYGs7xeTwuZd+F6OUxaXoOsBiwE6WVZViUBAPUyU7StSWGdbzyI2vv0far2g/IpsLRRU2HFOn5tUFRzy6VDxt0G+5a5EjATXfVyc+nkkdP4sDW3tfN8A8NR7+oNLRDNn+wnL+xXti4Ecsqno1xvkieForJrbXP1kcvsIxk83vG62CCuH38GE8FAbWa98CZmx4jEYK2XRa++6KkHLF1jEaKQ71TMhtzYhWzJnA2PGWC/RIwDzSpLwgfclEKy04JDwfBIeTWkgOR1D3wTLQMdFxOGx7HPtQTHj/ryLzYSrK9YjDhDpK7bnWIalfTuaEPMziG6Lf2avuFt6sKMVVHhHKnk2wixXGPbSPxyq/T840sGjH47tAjrVkm5LEyAdvVKUi523XAC46Vyi95OuSsUZ1xXehAc2l0p4ti5Go/icYaSWEIm8xNUI9/L+GYdiNFKqKJidZR7l6PDGs3ELaV5zdAnFvggH3ER4x9/hvL0I+T39/QNuUyjq74puw+xXYxUAxEXC4qHg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a16ed0-634d-494f-1bd2-08d885614bf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 10:13:40.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfU4FXmYmAnBi9LtgIj0UNZZxIVls5KCrShlhGObSZ4R1bdd5ZeCwp4aFUdf9QG68oBz08C2bgJO+ci0q8YgkcQ9yUXQUZxNIZ4azo1i2uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using the wl1271 Bluetooth function of am335x, it is found that the
Bluetooth module cannot respond in time after Bluetooth is enabled, and
a small delay is needed to work normally, so whether to add a small
mdelay.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/bluetooth/hci_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 8bfe024d1fcd..eb1e736efeeb 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -626,6 +626,7 @@ static int ll_setup(struct hci_uart *hu)
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 		msleep(5);
 		gpiod_set_value_cansleep(lldev->enable_gpio, 1);
+		mdelay(100);
 		err = serdev_device_wait_for_cts(serdev, true, 200);
 		if (err) {
 			bt_dev_err(hu->hdev, "Failed to get CTS");
-- 
2.25.1

