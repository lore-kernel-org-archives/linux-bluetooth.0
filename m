Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BFC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjE2G00 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjE2G0X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:26:23 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6779B2
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVajR7kl0ivjHEk+W5QkgDhpDTDR44QN9Pu+XSGzJQtf7O8ucmRv0VImUVlxbQ25qdY8UIEE7BpEFWgD+G76anz4UP4PKa0Vercv5GtoCfWElqDQgqb3Dee5xhIuDIHGcO0O7h71gcmYUTKDGC4eRFzxjSbDxO8YvU9nstbxnij/jupeyznh3JTuH+Mjyp329rGd4VAoa78SU8ugAldWMHg6u45KbXbg1/+kIXcwxCXEkrI0oZb0ual3+jxj+NOUNEpyZmcKFP+P5MkvxgVuHmcv8ElTBaCUT/nY7ziTqZ5H/ybZlkxa8hVt4e4jCJc29AbmzEgWr/yrTr3KxWJM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMkeANjsaElNlWQbvm4M/Xdx8UN1PdGVODesXn84/C8=;
 b=RTFgMkQSun7cRntzd+f2lIv5xyA5Kq8ALmLfxGa+i8ujuAk1eqGcN0sgl+aiyYC0wwQdDeX1YStynRpRZrQBQQPn5dt22hG0LIxd/HUvS688fVJReCxTy2VBHWEmS/rYDe0eUAlEg+TKApIwDM6bs6Idyl88+CdpFHcBZXYiwsdpmEfS66KM/Yej4GBdeCZCSrKO4UnTa0VvN+s29DkoRHWYgW1sOIggboPXbR8ygnTpoluswqT7LFOjFWxhphZ+JxDE95wVHXSH3oQoVKY5De9NJhehpUxDSu+55Qq5VifN1CH9QEykM4OuS2352wqwm6Fw//6NEyM2Q+ygBiSuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMkeANjsaElNlWQbvm4M/Xdx8UN1PdGVODesXn84/C8=;
 b=jjxSpq/GvIfT20MAhePMJVJ3sfUUWgXjFAPjHQFqk+LXThkfWeu1+rap9Vam88p28e6ztz54QqQkzgsMC/SHe707s4BXVG3KIsBJoS2l47VlGzJxobXMG1JC+lOIrX9FEamqiSVApgOSDML3GCmMuEKG7KyLrv+ZQQsrMu5ITlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:25:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:25:13 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] iso-tester: Add BAP Broadcast AC tests
Date:   Mon, 29 May 2023 09:24:56 +0300
Message-Id: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4147599a-9463-4985-78bd-08db600d75bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55AjPK6M6oIPyut13LIOApKEOSCZgF3KmotrnoIOG0/WL6Fe+rYB8ikXVDsHF3WebCKsXTRL5eptW4FtupALFInmho2MF1Am9MEzaQD/CtFyR/JqwA9OdS0YXivhSkBZsQAtVdOmDvmg7ihwEZLEUzvkordf9LU8wc+D9AjmV3MYNR43JiGO2asuxI8vczJn3foEKYc7IIFtLVFW3sdMwce0GBv0UhlNvdtfzzboUdKq6/9FGjF/Ieti/gzqcQp5+BR3KJxvE7wahVKd/Jujg2+ga94ogPWnnbWhZe3SnBcSM5+ii2A4l+1gfNBmsCNrXA3LX1xI7hd30CPnFh5MjG2NwNGbsEHvImUMCW97vv/NTqDvVGFl4od03mkB/XlpVpmmstLRPuVCKLVxMqZ5/r1Nt70t+awLb+AHm/ihgQ5EmCbGVHIVXBP6lX/wepQ6wO/YmWJvJymf1po1E0Qq8Ccj24Dvb/Y0ekWoNLMjGWthq2/uSnFZZhxHHgZxsIr6gREdc5KBWnAmYJXCStW3VmHuVxLSLK2fy3nS2/w1qTjRl6X7mjbPlxA2OoTyvIrZDZx0Suo5TjC+FxShyZGuTaCYT9G95QhQ/JtvL2hX7n0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(6506007)(6512007)(4744005)(186003)(44832011)(2906002)(2616005)(26005)(478600001)(1076003)(83380400001)(52116002)(86362001)(8936002)(8676002)(6486002)(966005)(38100700002)(38350700002)(41300700001)(5660300002)(36756003)(66476007)(6666004)(316002)(66946007)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2HmxEaeecFviBtX2fWVoRFUUUZRKzpxIGu3fiB4esv0vL8cjlSJtiV48mKm?=
 =?us-ascii?Q?oQTdaLu7IhDdkG2s0F8WmIMM9aAuQGLibbSlFtnLWYxAjXsTt5+QaLmhD6BO?=
 =?us-ascii?Q?kB4fqOBGgAaPi5Cic9s/h5iXbYddzPbmF7wro9JwhUXTGvPZshwX2EW5Vz9d?=
 =?us-ascii?Q?xei0nvgTcgxU6p3WVM/gueUhH7bUxlE8kxMkAeuF/C03P6akSSeROmnKto7E?=
 =?us-ascii?Q?c0zCGhU2DF99zrJQzGAqcBgnqjNuql7S4aojcVjasAsgoQkucnOCLklfsLLb?=
 =?us-ascii?Q?HHXfaiddR3dlC8QynGmULnzuE3DllXIGVQq9iScAiaYjf+SvS17+2sZH7pn7?=
 =?us-ascii?Q?eQQtZuAA/wTC8Ae6ZmCKmuQDlmeZkwLQct28ffSDeZ1Ks2RgqBzxHLjOdwQs?=
 =?us-ascii?Q?EcpWuF/afuexwRZDonLY/wxS4yG/e44U9Qd0yO0ypYkSr1Zlm5+e8hRrE4ah?=
 =?us-ascii?Q?LgSfu4SmSKG0T+lcD6f+b0ku+8Qo2HXjoyr/qw10PRcJuV3CULWwvZO+Bkqe?=
 =?us-ascii?Q?eeTI4ExgZBT6Rhlk6XfkzERhlerha6KwDg4Pyzv1llER2iidsonFzo1/yl/v?=
 =?us-ascii?Q?fNF2aV7D15y4JCThOVMMl7TdpbrDxCA+wGKkCLwf/1PcBbYne6iT2EfZY50E?=
 =?us-ascii?Q?ZXH9Q77LEORb8SGLFGyMAU9Qp2BwlspSd/pasF5Rua7jL1Cb303h0b65y60w?=
 =?us-ascii?Q?Q6WRg24L5ftcR81bHAYL/vJcf/HwHVnroyVMP/D1cju97UVpJGX38lFzJCRK?=
 =?us-ascii?Q?5wXxoAL2pfuVE3jSefKjQ5HXNejLzWrgpg9q+xTn8QJ+qIYXWVRnvnphtmQ2?=
 =?us-ascii?Q?KUGKuo/nlhG3opFp5aQgtHiBjJ4a42om3s6P7Z8wWGJX1vieaWaEcnoL+FKg?=
 =?us-ascii?Q?d7jr7Zp2kVBlWA4LF2dYaKOPGEGyVNUyUxBme6NWLg8+TKSmd9sdWcC/hvzv?=
 =?us-ascii?Q?yp05tBsUU21jLlJ1LdZZr4TDAzgxoo2QhIoYFjY0WEi5HUJOsFBGmQWFnL6S?=
 =?us-ascii?Q?7Orl5R0uOgNA25EM0uZPjZ2llOEvlDhvyo7pqJh1Zx17hAccB+E+dw9E5Er5?=
 =?us-ascii?Q?vkKlFzuP3Lxi4E0zwEQLBQpzqUJrbXF0AUeioNIDQoKZi57rbpymA5VoIqc+?=
 =?us-ascii?Q?9Gmf2qtzMURMethoAhYgf5MLWQ5sWEGmYl6Q8tryOv1hkEn1TTxxHtCva3p/?=
 =?us-ascii?Q?z0jiORJUvFh/ycTNGRQVDOMODS8zmCKZCUhGYf0cxNA/em+jbwWOY2bpaQ5K?=
 =?us-ascii?Q?YcS3pSDpfekd6FVF+etGuWNoTLe/kYxFBXEiBDdRLdbgyvHhG84fiuY+xe/Z?=
 =?us-ascii?Q?otLtK6hfGrF6GvtsoULexlCxSGnB4ftdLfqkDbqbllyZFJTIJhPzWsP1+PZu?=
 =?us-ascii?Q?Qs2ICoAvm67fas1t7IzcxJrv/xVc+o0omKjgFnxwJ/8fBhdXvwnttzTHWJVG?=
 =?us-ascii?Q?1jJnn51yPkr18xbvYxysw+khxf32pHnMuiobB58UrmlP/S3qV/nLRAgr5oYX?=
 =?us-ascii?Q?4hUnVRaPFQ5DV721Wyss3AtBeZ3oHlSeaBZkJDkuYw4OtOluhoRksgq2zLQP?=
 =?us-ascii?Q?PzQ2MK0M1Zb/QqpQXZa0XxsEpeTS6jFdX1+eOWm8n8a7ZWGbR4e8RshtU4Km?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4147599a-9463-4985-78bd-08db600d75bf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:25:13.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7edNEs1uqQdwJ8Hsn2lMPCz2wLn32J00NDShpXeciutwpDhXxqMDidcFmztqyGfASafjV/2VjFx81CiMMRw3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds 3 additional iso-tester tests, based on
the BAP Broadcast Audio Configurations.

Since Audio configuration 13 requires a Broadcast Source to
create a BIG with 2 BISes, this support has been added in
btdev. This implementation also depends on the kernel support
for multiple BISes, introduced by the following patch:

https://patchwork.kernel.org/project/bluetooth/patch/20230529061057.3107-2-iulia.tanasescu@nxp.com/

Iulia Tanasescu (2):
  btdev: Support multiple BIS
  iso-tester: Add BAP Broadcast AC tests

 emulator/btdev.c   |  52 +++++++-----
 tools/iso-tester.c | 193 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 190 insertions(+), 55 deletions(-)


base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
-- 
2.34.1

