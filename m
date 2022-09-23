Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A244C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiIWO4T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiIWO4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678A22512
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsAB5Hm1qZvO2INW+qLVYZsgowDERBjBT0uFsDZsgqjOu+jZBJi5hcuwuMsky+dqn1rmdB5VWW1DMguf9DemW1LNuF6EYya1A6xd32Iaor/Xf5cEvw1jZ2dQo5CO2gDhOszXuoDG/0IRt8+5hvIQezlrKS2HIgEQqKn3ZgWusTQVr0SL+yy61FELnBtL3BWq/ueaXw/H/kjEhFfi1+wbGPhrEICia6eqmrhvLLbd9EBzxMvHbmkTKXMGICSjJjdJ5ml9LQLBlHH8xzO7r2TAXL3F0nLcs15OsUTJ/G6da5PSJe/MsyS8iFOSbmkeoXl9TESaJy6DcPFWniQB14/RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa3aYKcAFL4Ld2GbqsKjDF74dTBWy/AkbLuIWw+TtM4=;
 b=Alvx7tHYBtNp+XBUn9vfB3y+EBuLwHxHSR/9hfxozifn6cmknoaxTQo8CR2+j7Pugova7ly9aE93VeIl2g6r8UXa30zxwu6dBQMdcz8R8JGY+zoBE35jNI24QIKPfUMCtZWjsucwLx3JzzRp93dM5E8v9QkKiehI62TzO7KDn82GtN39P7JNcsd8gJaP6YU7X96KXkce2QXE8DcayUeODL/dtr28YvoNknm3nX5TQLYn54ni18VF0W4GrCY8YU/BltTKXVSsHRF1rBcNNUet9yvP40Qf+yzOdDIkBPhD87bdSEdDGm1s5BTQtNFGQpNkauzmF46hGIHIzARps0A2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa3aYKcAFL4Ld2GbqsKjDF74dTBWy/AkbLuIWw+TtM4=;
 b=SB2ZJjzoNL8BRkz2oHVfPFdotDcV2G4X1PY45S+SXaLXuvFTDA4sbn9hHdbYw6jo4g+/d1f2Qhr4l0TsHnkzPXqY8VxcNfK4iqg3dxpLL+DgTuQ00VfvBux3w6k/h9vchuPPWp+av+IRgkAKqO4yTQ0tjVdlTWrl1KhWIV1yrd8=
Received: from FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::15)
 by VI1PR07MB6686.eurprd07.prod.outlook.com (2603:10a6:800:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 14:56:12 +0000
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
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:56:11 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:56:11 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 0/9] properties_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 16:55:53 +0200
Message-ID: <20220923145602.25872-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT012:EE_|VI1PR07MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: df520edb-3cd6-4826-031f-08da9d73c162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpgKjuCFVYGR9fVHIYDdovKbC8ZViaHfJiHzoOy8I8vqlToLyCgB7Rif/HctQJ3z4WH8xpFFzFRf+AyGiRtAC4Lp69ArRJLcuKpNlK3puyU+7aUQXJWmqolb3UdksE64ZRTuQRVrYR7aW0WzI6Ogacj8rDAg7xX6sJ+mhqQd7CHE+x5Q1funUqbp9JRuXsvZLU07rdL4HcmJ+gMx2VihATyuz9SHqLSBKUDxT5dI+cjF8UkqEhyfWtejtbeAZllNELf9n6KX+L4oA9KNJXkjT5Nct/fA4hKtsqYG+TtfZvLeHY8laRP68vJQKyDQBiGZM/H4NtwRNHb1Dy1/ppTWvnVqm0l+Q9pfoNXE5JYV4tspioLeDUx+NGgjzfS1v1bunbswz1VPuJzu+EYv1R5FsviFW3Xa2ttrs7baEITzQFXWrLIXcNW0ykXhbefQEOcR3bEHRxMJlT3/LJcVzjFPkeIwNt6aKOxY2oH+FcNBpR7Q/k1YLAk/sGa7smwVgTf5zG0bVEIvA0lJVTUhwjuR/FJ1rAo/ndYegCGGCICnDuFCxzrreKxy++kpJmAwW+rMD2OIsmpUbpkP2wdzVfhubbk+b5BKq8RyKuXMZ6Kf0pUbDL5gNtf5XGL/k1NZoX7RinxpVhPk4r8Q2sadJ2doe83BoF6tN4uocX80z1qubpoUY3FGxPliEP6EpXPWn8Daq0fVjSzgHuVbfc8VmgJgE1h4dyg+b+z6Zw9nLu5lkT8cNQYvweeBRJZJZ5cfoOAeZrxLuEz0zIqtxeHgoqfHRQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(70206006)(8676002)(86362001)(4326008)(5660300002)(4744005)(2906002)(8936002)(6666004)(7696005)(41300700001)(16526019)(36860700001)(70586007)(107886003)(2616005)(47076005)(186003)(1076003)(336012)(426003)(83380400001)(26005)(6916009)(316002)(356005)(478600001)(82740400003)(81166007)(36756003)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:56:11.6868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df520edb-3cd6-4826-031f-08da9d73c162
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6686
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2:
----
- 7/9: don't call memcpy(x, NULL, 0) [Scan Build]
- 9/9: shorten GIT summary [GitLint]

Christian Eggers (9):
  advertising: parse_secondary: fix loop condition
  advertising: parse_secondary: fix mask value
  advertising: parse_secondary: check for NULL iterator
  advertising: parse_min_interval: reset min_interval if iter is NULL
  advertising: parse_[min|max]_interval: reset value if iter is NULL
  advertising: parse_tx_power: reset value if iter is NULL
  client/gatt: proxy_property_changed: check for NULL iterator
  gatt: proxy_property_changed: check for NULL iterator
  battery: provided_battery_property_changed_cb: check iterator

 client/gatt.c       | 17 ++++++++++-------
 src/advertising.c   | 22 +++++++++++++++++-----
 src/battery.c       | 10 ++++++----
 src/gatt-database.c | 20 +++++++++++---------
 4 files changed, 44 insertions(+), 25 deletions(-)

-- 
2.35.3

