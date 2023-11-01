Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjKAPac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjKAPab (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 11:30:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C657CFD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 08:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxV/53vY6M8CDL0nxkK64JcBCxwlK5jop5SvXTGVtWLb1CpG4efm9F9Tp/pKlb/I/ctzzmQLSVW6S3isxhEiObsLZvsgVBKwuTTGAzHXi2/B0Uw7Iwm5QWxjSQ7GFk6htjPc2F+JFYIPPgLzzeY+cCqltptnkK/8L7lbd/6J0kcm1DRrCw07HhD74n4QJEEhOHh9xLRMxTTVIWMNdMMK2DOhn0aG0xWlhtlUzg/pd514wUvLQgC8HqO5RO60m6Y9ILMRmmS3CVHii9dlnYEUgHTNpll1HeBjwvH1pRUBTKPUjXqw73s/B8YZoQw1MVBU0j/kbetdS78LXZsJs/DurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7s1YoATqnbLkubnijMgOwJ07dVm+Aa8wrTTnrg6SSg=;
 b=S/9vNl4ofNETS4CKdXP6lcYr4L9ozrOEltM/PTa8EfN09sJSAbMqQAoy2Dm3GO8geKMitGvpuMQw0rehs7dW2JsRB1Iwn9RDldueJX8ZfWK4aQByyUczbsuAUG6X1c8hTJFgOVKX3Ifg1d7rvsfeidMQyzwHqlIUYfzTq057W9E/U3c20I2s6TuqZ2cn0fyulBW6W+IJ5lRSL5fvUfzIa2rfCPPFU6/mYW1bR0QQDkQ3G44G/x813yVnnImbqkhQN4NGFEkWkKHT2Uv10F83L20zdDsl5GWecRMekv1RCPTZtAn6Y2p4yzzjxoEISvUp4kjHQ7QPBCmxkRF9gWAbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7s1YoATqnbLkubnijMgOwJ07dVm+Aa8wrTTnrg6SSg=;
 b=YibtQpo8sU0e072bF9/XaUrc8UJO933eg68+CuXs9XLm0E5AXkWkK+aAuDLwFKcRn9vV+upQmixMhcHSaNLK345MHYO6yls+DeYOl627LaOAzvB7BY6sXI7Q85/b6b1J7iPSPNUMYonYpjbQhO/1ZQGKHLIbOsLwZKrQhzhyaFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:30:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.017; Wed, 1 Nov 2023
 15:30:21 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date:   Wed,  1 Nov 2023 17:30:14 +0200
Message-Id: <20231101153015.5541-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0216.eurprd07.prod.outlook.com
 (2603:10a6:802:58::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd7593c-20d8-4fa6-f4f3-08dbdaef75e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqrzpjt8SaKct5TpuazvxXQdcQ32hdbB2a+2VNbYXhXXiFDXqOT7GodNRcXZx4IbzTF2CEFK4kr1qi8iih/XGB6X/W5vlI3s9ePYbcc5cjHuyEd2/voB7NCHQI11ySMTjX+TEh4rWUPcMCKZVtMp1ZCvNhN/j0yBxGBqsVTQmWvJAeovSOiERCbt84RIxbPYcwXxsyRXkpXWOXSEMIXLBA8URl3OlOk3ogxWPyluepwQpRQCMxG96b6ykisqBo4enf6abAExXefVflbgGQ+TZ/xXHSLP7CeU4IwqJxp4wxXEE0wUli2tFlQhWpPl1xsFpo0crN3JxBP+SL7PFbif0ISff+5GTfVEaehZyQl/Xdztwm4g73qxipYbdWSL3M73gMF0KAVbHrJFb+04t1rZJtSaGsOacqcfrE70if1MaCRjFDOiipYEi0TkyKXb4dQ3CiuHs1ZCpNmHmjD4dJ2fSinLP8nprW4NYwlTCg3C/5Scc7SHV9Qkmq6mnA5tOElrE4Sq2u10UPCSw4tNhYXpknxfu7jHw/rdwIcYU868Kc3PQ6ndhdB6jRn4rYyFJBtn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6666004)(6512007)(38100700002)(86362001)(6486002)(6506007)(478600001)(36756003)(2906002)(1076003)(2616005)(66476007)(66556008)(66946007)(26005)(316002)(6916009)(4326008)(5660300002)(8676002)(8936002)(83380400001)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BXjf6CCiOe/kwJmtMNH5eaeNbr5JE1VtCn6yHT1Lyk8yw7iJ0IjPzc5sg/5M?=
 =?us-ascii?Q?d/HJ2g3CWKX/KeYyQyHfcx4xdpVz1NVCTtFN0Qn656btXcKEBqwz13ZWOZKv?=
 =?us-ascii?Q?VEwPxeWZg+vxA+AVbk0Upn+d27xdKEiWYJuYGPwkHUXt1SNsE1ThMCoz2rRN?=
 =?us-ascii?Q?+1CZGfSCfvYQC40yhxz4z6HB1l+2mrMC0BDcCGAdyULsRMlEEI/Y1IkXksFL?=
 =?us-ascii?Q?hjMpEnRn8+4TvBLTLM46UBT4EXdWpdk8hsNcSfavauhjscc/W4RYGDOez4on?=
 =?us-ascii?Q?Om5QrGK4vWOGHHR77cPf05j9MbOdKgtoHwnbyl22bY52l2jMNLAa0/FKVqUm?=
 =?us-ascii?Q?aLns8yxZBoWB4yWF5IzogMT4LtYXqhB+Coqa4HlHIamw5OQgvOwdhZlF1T4H?=
 =?us-ascii?Q?HVjfxZTerIeMRp+b/8KEFI+H+MD9UeqThKluY/zb9LV4WOgpk8eooj75Xh25?=
 =?us-ascii?Q?/VKbQgZgpt9ox+UikoQjTWg/tpCqjH9eTGmLchYALzieKuGXcZzYSjPJY0Lc?=
 =?us-ascii?Q?sT6kBlLt7DsNxayoK3gPcGWwl4twfaCf/m0G6NRZMC6ieFZiNKnyGdkI8GCi?=
 =?us-ascii?Q?Yt9PoLTAWK7avKhtIYobd+pL3SzjZ2UkEYQbao8o7KokrQ05WsJm134BRNZ8?=
 =?us-ascii?Q?PS11daI6AfUuvYunSeY61vo9JYdTD0NmdX0PbqZcFKcZef17yqmrnT2ZXmku?=
 =?us-ascii?Q?q9iDgZlwe/f+qjgOMr5m11+HGFiBLdFbxHloxPMl3NeYn8Di+wmnG1MTkHG4?=
 =?us-ascii?Q?v1qVVaQVfAlcxJK/ZHno6TzZE6wtq6wv+DpyzO8whytwbIJouor5sY8lsjID?=
 =?us-ascii?Q?gR0uwVHoYoVds/yZcIRrWwTrHC7UJS7M+JAN0wgwKiZWbVtxD0Hm1ipbXX0q?=
 =?us-ascii?Q?klKhvP0/aTwoIiv5qV5ilTnnsH76m7C87SGWHmPCQWIjV1BU+y1DFko6VB/H?=
 =?us-ascii?Q?D0R18SaZL5vQefVgQzoTqmqS29jV0RUMvxb0nHvLaTVBqVJF5MJ2nYxhXzCO?=
 =?us-ascii?Q?UFJBV41kuDQ5ZxDz+W5Ao/5it+yLobt4jcwIwVHBgyjyzsoB0GT8pVnoSnaa?=
 =?us-ascii?Q?utK5CDUS37qyUt4RFO/BrPhNXIksl+qlvtMJN/YpfglWseP4Int+J7wwwRUg?=
 =?us-ascii?Q?615r0enBEPCgZnuH+NoyQhP3TnKOKgrTYmOCg/DK83ipKumG3H4+Gn4lJlT/?=
 =?us-ascii?Q?xGrSEnhxNhqB3UdGH4SxtmuYaj4Y92nXFfg9iVM5QjzGrsq8yVL3Zqh1xPy4?=
 =?us-ascii?Q?Ue4teOWaOiBNLtAPVlp0Y00eo3C/1tz7LAXfVWgWDW2f9Pqq7ytiIPWxMmFI?=
 =?us-ascii?Q?7p2i7E6+feQSLHXR8PP6MdGorSMswVWBBmz4gfSSJ0NxJ8UNC7yKvtNJtSBL?=
 =?us-ascii?Q?MKUChBNh2s1Gr7LChRKw6XLZfiu3FA4SwlYq+inqjTivfk2E/owI+AVg7+jM?=
 =?us-ascii?Q?J9ofqJ/XDB2Rq/DLjLsPFe3idFqBo3TrB1BDfyyjX6gljARbI9Na7q2wL2U9?=
 =?us-ascii?Q?IZgiHwAU6d+PDM4kcuMHlzc7G3BOGfA4RJDd7j5JZE6E9qytx/Fs4rLoysG8?=
 =?us-ascii?Q?ZlCVLI4o4YxuW6yYK+gaR/yeE2rzn7mWmnGDu9boQQtNbJOnImwD0orfT5Hk?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd7593c-20d8-4fa6-f4f3-08dbdaef75e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:30:21.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAxS08RRzz/FREFaGybQr/xLmsr1EBgSwC/cFVZaiAnFM5oe3QGtX5LHlj2VNQEGJI1mHZAepXkg+fz9LNaXJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements a kernel improvement, to be able to reopen a BIS
socket from userspace and reassociate it with an active BIS connection.

This is useful for a Broadcast Source with multiple BISes - since a BIS
cannot be terminated independently from other BISes in the BIG, all BIS
hcons should be linked and kept alive as long as the BIG is active.

If multiple BIS sockets are opened for a BIG handle, and only part of
them are closed at some point, the associated hcons will be marked as
open. If new sockets will later be opened for the same BIG, they will
be reassociated with the open BIS hcons.

All BIS hcons will be cleaned up and the BIG will be terminated when the
last BIS socket is closed from userspace.

This patch version fixes review findings.

Iulia Tanasescu (1):
  Bluetooth: ISO: Reassociate a socket with an active BIS

 include/net/bluetooth/hci_core.h | 24 ++++++++++
 net/bluetooth/hci_conn.c         | 32 ++++++++++++-
 net/bluetooth/iso.c              | 79 +++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 4 deletions(-)


base-commit: 0783375f2c56ca17719d5ec670e498dc661ea5c3
-- 
2.39.2

