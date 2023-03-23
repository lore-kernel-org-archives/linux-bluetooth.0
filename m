Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4710C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCWPJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWPJC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 11:09:02 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFF10277
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 08:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnWbK02btGQmtBmCZUGvPBSHknU1Iqq+4x8XXiZt9OIW8MvUbQ4W5MMJkPWydIacjYjbl8YoIdsvC07Gq9d+eQ1garRsISZul41qKVxYly/9xQ6uw3Cn9nKyNVvYTcp54wyG5ZDJv1H+uAaJllURbSUawbPJZwXkSzbTM9JBqPUCLw8p9TpiwxxOZgF5rUw90G8AfUQi41UCkzZO786wHaXhOlspSTQgr+bd6nlw76qx7TTrTq1nYLnLBm+rD7nQzXawD23SOCetHYTwf5WgqE/BWng7798/YQCOOk6qt/tHB+/E74ZqZzofAqC2k7+fRbF+xERQcMZnqSLpYd+uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sVcCSXHbJz+wNMgSvPRCBf1sxSXiZC6dU9M2BH2LGI=;
 b=Q3UMmtG4XrQQx3cneEDxBU01ikENxY1DzLcnHglyE8q/8s4Suy5mu5pFoUd8wC1jecXG7UAxiYw7UduoHeLTcwgduBvXnSZupR5aDAbmOAsl4Gz/z/JNGWwXjHKnfj6ad04bvBiCj/p/6efYA3byss+2VA4h4IjrfnnTK2JBkWf5db9F7yI90q9Q9HmhC66+e+dHHEdTDEZWCs71e+rnVLFDUaGh/RJBxmowdiszgk3oRgKnioOrZylsWFEFEvM86gJvFBvVyx4Ioe0cHcc0TdP21wV873a3exTljHEPzv/elStmyeMs7i0sOyOTJUu/OWEzKEIvb5o028q4RuEoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sVcCSXHbJz+wNMgSvPRCBf1sxSXiZC6dU9M2BH2LGI=;
 b=a0QIHGpPHK75CU4Dm/N7+J6wNuQGcreAQz6dj0dVNcjlZx0fxZDEQb5pLUXO2DEikA0cploH/n0k1oQCnmKBGUz1PAE8ojxC6blCd5MRsO+HoKIvj5H8U9TY715lhC286LEkWzXpu8gZAZ1NRTze9vji4fFy9AsUwB9acSQLEdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7117.eurprd04.prod.outlook.com (2603:10a6:800:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 15:06:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 15:06:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Thu, 23 Mar 2023 17:06:06 +0200
Message-Id: <20230323150606.755286-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJfkdbXyJUfg-i88Uorj5rp97ZpbXcRZ2oGt8PmW4tgRw@mail.gmail.com>
References: <CABBYNZJfkdbXyJUfg-i88Uorj5rp97ZpbXcRZ2oGt8PmW4tgRw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0223.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3ffa1e-4003-4ef4-899c-08db2bb02cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rON/up95ZqENIr1a+7B3L8yG1cdgIu3mQYOSEu/fWgiY0KEUgBk5zIgypSvL2dXLBa9Cj+gR4J6OZouXdHrgqu73DbGC4wdMaqni7s0TjVgRiNNK7+IN7tPlVrePVf11KyuROckLU22BKGhTCUEcYAGZ1ms2s0MqO6ChOzDBt3i/dNUTd9rcECBBsXdc5be+u5K4tjJcJzmiWM4PlRYHYSbwbBprBSUYCnmdcLCGZ5694W2SPD9wkNHHQRiHA6pSzhTsN2lfx8c2nTjBO/vdmYXVgaUlAlVzTt/BTGpjt9U3OS5FkXFYK4pBnwS37jWLM714eD+adcnLItXYOHzEIYypYd96TyIZmwZnfwCDcxotRZfVSUCLwmH1jtbgBPl6Wik2a5r1236VBCKx3IXnzm4+MpLgbEPHtyl0B9aD5D3Gb6g8lodxsGqdY8cizWLknFMXLQF7U2Wm0yYsUQqa5hrWG6Wwvu/Cw0EARo+tDwG/2f6PPSKBo0WiPTDiAHXhXQy21e+xWmkg6IR4S8WJkOS7+KjBiPHytM/0xsFZeHYyF00LSRQrHq4aKP8sntX7dieBcnU+0zDvQe40KuhIgJNi2/v/XCRuKKJmLa1xEhuLCc3BUFtFOHtN/3A1T5NlO8f2qiqTzqQmeG326b6V0RpdMqtJtUiSw6Wn6YnM5PSs/mIiTOFtTqTlKNYcbqhfu52/Nh196AmgVI1jq7IHOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(38100700002)(38350700002)(19618925003)(2906002)(6486002)(478600001)(83380400001)(52116002)(2616005)(4270600006)(186003)(558084003)(86362001)(36756003)(316002)(66556008)(66946007)(66476007)(8676002)(4326008)(6916009)(1076003)(8936002)(6666004)(26005)(6512007)(6506007)(55236004)(5660300002)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDZSTAHAUZJCn9tob+w4yRnzraLJMuwnx7nt74y726UMEvQq6e4CBmXEjkkB?=
 =?us-ascii?Q?GnuCISyStL2sH0DwraQnTc5MY/L2lNUY1ZVvKV6A71zFd/bQcGEikigb/L9d?=
 =?us-ascii?Q?Yy6SWydJQNKzFQdmpEvPVz2qyI2Fp8eNc0dFyt+9fJ6VPnAgxqWAfsyA4VEV?=
 =?us-ascii?Q?9Yo94qKQvGLx+BQZNyU/pyKnT5Vygfh5C8zhYO52Za5uZp7vN7S+9h7b6A1E?=
 =?us-ascii?Q?WnuuP165hVWoMbgmaefROF17O0eQo/Rgg+wWhOWF6MuJkDeZvtHGi3x7kKkI?=
 =?us-ascii?Q?1aeMX6+Uk2yiI9/a73f9NSsF/lfiA5iVPhTj5F9A1/MVGWoHLvNKtETA/guc?=
 =?us-ascii?Q?6qrsfun1vcuAhgjGFkOW6sCZuc+nofshEAPaPM6RbeIPDjOw3HVRa1Tu9ipY?=
 =?us-ascii?Q?gkh6ggfIutiCkWBIDTFtOX7HSW/kWAGLFXdPRz1Hc0QS40fhrzPMjh5tpH8A?=
 =?us-ascii?Q?Y2WgHl1Di+mbUUDJvwSxRiES2xMPcLw4PJNTCIvUgtVkNgpBvjW5xT62hvLm?=
 =?us-ascii?Q?JpxUvohu0bY0KEyIL7c582kESqBZqOmZSmBCsQq1UAUeGdpbys9+krPa1aG9?=
 =?us-ascii?Q?to27c1LhKSjKIreyYpMqaXpZPpAncCEs31DpXXMZe5fTNxbhfCOzj24slSML?=
 =?us-ascii?Q?W/38678+NdOXCpMlVHcGDRdbBHhKbvpp0Gik73eutJWxMp3/wNxxZIgy65HT?=
 =?us-ascii?Q?+MXZL3sSbn1jKltFnje6bvlh6q7bdEA8lWEvQVveVygBKePGsmjZlxR5Avk2?=
 =?us-ascii?Q?F7+bRiOBWxll4SEDjl9S4WSu8iPdPDlSuWwFKJLEc/F2JHT9mz2tJALb+jp4?=
 =?us-ascii?Q?XFzpA/Ps/+lvGMlXMpPnCp3p8TlFJ4u+DGxpODufpeNGrbAILLmI1qXvJGMn?=
 =?us-ascii?Q?jDbpalyDppj9yhsiF+8+/tS0cALhz3PgSGKSN3vTGVmHt15C8FUHe82UVe+8?=
 =?us-ascii?Q?DadRNgGHEnrPGt+nZ2rCxPR+i+R+BLnFdeXPnFq2It+mKIv7EOgfYyGlwXLx?=
 =?us-ascii?Q?g7GqQa3Kx/jg6ApyDZQeoejubmm2MJDG9ymXU5jj4OK50HcEqmvSFl8AteJS?=
 =?us-ascii?Q?RSn/Z4MV57cvGsFFP8bwlxt+Ol9K9YWvjSgkUhb/1naGLNapOMhXLQhgVGET?=
 =?us-ascii?Q?uVcT2JUH6F89R+8Q7SfxK+YOpHcoLXGUavjDsXOw2iexD0xPoXxHA2A1pBtb?=
 =?us-ascii?Q?Qfm7QUQQe9zg6FFQdS1casAemBU7cP/iuMRItuzaEiTXD21KJysW7Zy4aS0/?=
 =?us-ascii?Q?FEjRfjQ4Rcw1FeIy28OoSvFab5QdClpX9gmrJyhSSKwSVlSsc/WmVdy/B9vf?=
 =?us-ascii?Q?0+NPK5sMGTUHZFKogqah5O/rncQeis5N5xA7rrfSr3jnYPkarwc/JsurBcv3?=
 =?us-ascii?Q?f1ipKkeL9u9YVZUFKLsGAIgN3iHk114DuI3RptZ2b2/ofW9EWupp6NJ3F3zd?=
 =?us-ascii?Q?9tqx712/TEIHej95ItT7CLi1h37LRZ/6earRcOL/fgvVTWWbN09G3Yb2/fgG?=
 =?us-ascii?Q?GrA3CP9bSxwOLU0eJ/XNuV92W1NRhZOPldOOKo4yayxw3KltoBo0IzaENKl+?=
 =?us-ascii?Q?MiAqvIMcKycve6WRdD/5zRE3xSxb/cCzix+lM5MuXURu7TLr6XcOm248Jxw/?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3ffa1e-4003-4ef4-899c-08db2bb02cec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:06:27.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9byOsl8KVsp7Nx8f2ylYXMbpH55P2wv8F60LVSg+jmr3dyLzQQ06YxOQQGc5OWpbdMo+sAvjskiDFkezACirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7117
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you, I will update this way.

Regards,
Iulia

