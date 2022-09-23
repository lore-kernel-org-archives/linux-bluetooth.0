Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F8C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWKY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWKYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:24:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2108.outbound.protection.outlook.com [40.107.105.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8383193E2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsWE2lk9oUaD4NsL1RsruyKCXKbtwvj4v7r2Fls1ZKwEpj84/GXM5dX4YKBdO/YXGD4upLwbD+XF4oK5dv7ylpejIicNpt0h5JOxiM5v9+/JjcvqqFoqKvRVlEicYxW9Ro481pWPWI9u4nYR6oScegOEPWfZX/ldfd4onS0vIRB6kBp2W+iKIiSe5GMySwJpcUhEMU1qd0ZkftcCLUUZmbCk/WEp1gEPrczSRw9NHBeQR9UVHlHcDLJXe1/c95T9P+WIUOgcA9nBVjEeDtOgMvDnw9Q8sAQXsql86K/B1V59yMyWPiFh+bWzsIe65y1LTcq/81fs8PJ50PSFkjhb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjltFy7Pf+umznXX/J22+PumsEM8NMnVudQlpc0d9q4=;
 b=NmG8SEj8g5lLvMd3iFRKsoC0HlGG+TdKkrPMfQAFpCDuTaV9h3jnSWD5DM5q32HcnFSPYpI3GYz5SroMcjyIQLO9yhbbRSNI65u48lvI0WOEb04sScHYCFRlqseVfgehpA1xOzNb06iKcksQWtiPlCnMmI5npv2aYrFuSvHxWMUOGvxLqBJTRPR3qANCI9jLt578J4v/qJ1E3+Iq//2OHnsQzK8x2I7dacC65giKFOwh6Cr1/rF1YLKE/e39cPfgGMzxPRCoFpPXccheRxu4eP3nBnU1CKcPHjl7ulWFNj/tlEoMVP34eQx9c1sLmZqdZqGz4cbiZOe/EtCN3L1rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjltFy7Pf+umznXX/J22+PumsEM8NMnVudQlpc0d9q4=;
 b=GrNb3g1g9n/Z/0lls1FuVv9hg2oFjK8O2fJcrg9GPO6HpGlKxXKi8quTykPlYJuExPjnJBmqLpSDxZjhfJR+oVTib4qD040xRARg2JRJXH+YWpy9QmtfztZZOhe7np8tsqKuk/24yaeE4pTw3HNB7I9blwHGicZnbcntnPemfcI=
Received: from DB9PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:1db::23)
 by AM9PR07MB7234.eurprd07.prod.outlook.com (2603:10a6:20b:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:24:36 +0000
Received: from DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::2f) by DB9PR06CA0018.outlook.office365.com
 (2603:10a6:10:1db::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5EUR02FT021.mail.protection.outlook.com (10.13.58.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:24:34 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:24:34 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 0/9] properties_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 12:24:12 +0200
Message-ID: <20220923102421.10336-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT021:EE_|AM9PR07MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 787a2f0f-9ec7-4490-81e3-08da9d4dcfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEn/oUjIF5Viyp1XtwLm013nDkkZReOWeSmFhd8gGPXhaGz6rgKupaF06H36m93xWr1jOEEIT0mXZ9DJEWEN+It1sCCodcbhxzZAuvr2v9QVfio29GPW3c6UQ74zM/wEEUxQPuOarNn02j1S9n2O3RFzzncSJiD0Pr+ArhObJ1UBvX+vMkEeQ7w/Vp1bPgvK5uvnA4tjWIhrqW5l8PPNTxeVMdFdLuqn2RsFhFoTW4OQE8+y98U3UVJHs2A78hL7VjYlV8e4Q9x1NHeEITpgomCnL0FkH8D4t3gvKKlDDgvMzgO4UloGKuMDIZnq+w10/TceuOAkdsSGeFSrKgVdyGLX1ZhiXKEeeaRfbN/21+gPsmJcF4kcpY3hZcfwlzDutiG3DLAJ5fqs8Ijd1FwlzqyHKsq+AAPy+50BFeoaL1QV5hDzO103VgSFHtcZTbbkgFO2L/Vq96bde8YylTPUq6wDHARjpgxoMzgDlsQQiSzY6CeZ9Ap6OGjpWvx/m2Q72JAj/qTPX6YIBMJvPf8uBR/d0cexA6/EYJkRu/ySMHWo/i/21h5QR5JZlz1fpIMjdDZHIdtkpf0lV1sNHCn2Dcc2+rGOoW+8u/c+YtW5MFjHksljrSZj/KsQY8lvyipGEgdyYb6NGJk2VsNEbV+RN9ysjvWz1hE+vFdm+ji9nW2547FeQ9vbfRmc+kb+STUpJ8Mgmoj1f9s6CnCHUwsfoyuu1UWBmqQDX5ENyaDHyCEnN/PkPt84/YibFQ4Mo/qcLhrHP2dcDCwzoF6AcTDBhw==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(336012)(426003)(316002)(5660300002)(1076003)(16526019)(8936002)(7696005)(186003)(70586007)(83380400001)(81166007)(2616005)(41300700001)(478600001)(36756003)(2906002)(47076005)(82740400003)(86362001)(36860700001)(6666004)(107886003)(8676002)(4326008)(356005)(40480700001)(6916009)(26005)(82310400005)(70206006)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:24:34.9501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a2f0f-9ec7-4490-81e3-08da9d4dcfc6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7234
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The org.freedesktop.DBus.Properties.PropertiesChanged signal allows
sending "invalidated_properties" (only property names without values).
In this case the property_changed callbacks are called with NULL iterator
by gdbus/client.c::properties_changed():

...
proxy->prop_func(..., ..., iter=NULL, ...)
...

Christian Eggers (9):
  advertising: parse_secondary: fix loop condition
  advertising: parse_secondary: fix mask value
  advertising: parse_secondary: check for NULL iterator
  advertising: parse_min_interval: reset min_interval if iter is NULL
  advertising: parse_[min|max]_interval: reset value if iter is NULL
  advertising: parse_tx_power: reset value if iter is NULL
  client/gatt: proxy_property_changed: check for NULL iterator
  gatt: proxy_property_changed: check for NULL iterator
  battery: provided_battery_property_changed_cb: check for NULL iterator

 client/gatt.c       |  5 +++++
 src/advertising.c   | 22 +++++++++++++++++-----
 src/battery.c       | 10 ++++++----
 src/gatt-database.c | 20 +++++++++++---------
 4 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.35.3

