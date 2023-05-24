Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8056C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 08:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjEXIkl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjEXIkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 04:40:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2519A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 01:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhPjQPJo4BaP2rt5YEdPuQl7Ntjfpx6+HCd66FnV8bJzv0AkAQrfcymLZxSbm8qQw4Zn6h/OEhXmwHzgOAdRfJSHrkr4SB/mTatKrgZzxYYfZ/S+vRX46RcjK1l2caM5KeXF9F72CxuNuoftRVv9cPTQJdMlzClSmsTJKicCl2LlvgIGRV978SjdV7Fhv8Z9dHaR/oFWQG6Z3+vr7ii2CsEQ1in6HFHv/NrrKV/UGDPT7nymjKM2eR3PP3jwB7mIM1G6kZS1ZNfEpW/cdOMYrk5gkHDnC6LIiUylFBaVunX80NVaJRW34m7XQdVIcBhW25LKyZKXDRLLIhuacK4KIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xfp3Rr4IwmhfR6vLU+vfBCXH53UHllN8chX8yoKhfA=;
 b=Art/SW2hLNNLgTo4twNzjbMjC8aSv86Ls9Y8XZb28eIIufo/MQA6tLEA2pk59u8U/K15PsIXiHe44evQTp+MtaBxaKA4jC9dSaYu1DqKIxAK5mBRLcq908eZaAyzQ9SVANwzYn5UVSmWFRtJ2SRx9po9FpWG7A3/kjKfai31EgNTBjz9zhIHlQKJOjbH4sa9ZhyAf0C6ifl3TLeROXM/3N0O366ukawKYqsqtX4gxD+mlyq3WqoeeSjUDp2W+swK2UJeSoH07iye8V7JMT02Pe63FxuK3TGduK1QCaYejiTKiO/lVen0zLfxwbOBuhjqgQzo8Djfp5LMwVD+PLKY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xfp3Rr4IwmhfR6vLU+vfBCXH53UHllN8chX8yoKhfA=;
 b=mMjEPsBCSKPGNGbYSeRp+EkQlMlOhbBgVR8RMKxLbjSR3PaqfSTrkaKcFsdDluVHOtst+73BvAS3xI4Hyfi4maM9VrnvKxmkg6lmIsHJKO1LJyEZ/pqrVuTB9xW19gh4YsruD3JFLG4LwYOoYr7IlBjAfUXKMv/aXo6YhItP6IA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:38:20 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 08:38:20 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        silviu.barbulescu@nxp.com
Subject: Re: [PATCH BlueZ 5/6] client/player: Update bluetoothctl with support for broadcast source
Date:   Wed, 24 May 2023 11:38:08 +0300
Message-Id: <20230524083808.141604-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJ9wtSUh-k0HAikoyz4nxWBG6+3d4D-Q3feeUwSNhgfyg@mail.gmail.com>
References: <CABBYNZJ9wtSUh-k0HAikoyz4nxWBG6+3d4D-Q3feeUwSNhgfyg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a00d9a6-fad6-4265-cb3f-08db5c323a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWYw5JIMDg/goKxhZ4F8z6vRovID0D/iIYKx8N9bvsEUHduQJN6HWXYzaMs9rUezc1TnAfT9gHIgDldWYc+uDb/gbm0TUt8gZFTTiJFe+YeSVrO95XYJXwWCRi0nbsqrarw74t+dVku8KR8gm2Xnm6RB4Qgt5Q4pH0/HWhyMOxERNBcRLD6ThDutbs4Lx4IgdfpLn24NDX7rSA8bEpRdnjPRBDloWWU8ZOJa8rYOvWWzxZGMFmPTzaSE0KSXQBJVLTcRKzD1HQXiGbF0hP234CVwpi8NgNX12W8rRDhfJU0EBdLqsU5igXpd49JVaBN16vOuCyNvLQG31jnzvjEXMoKC7Lq39q9i44syOsv+8A8GISigoZAizJMjFhYJJuw7j0wuL2ur45F+2kQ09b3nTH0r+QtjLal9Nc8zMZ0nWL0C+xso1aRKY7Xh/Cg+xCSgJEkT+Xs1Fy1BJEQJKDpAtAICxkA//uOalsmTg5i2P23c1/69WImm7ntKGEzMVspfAi0n2cUjZ7nd/0MoaXS6Ns78uyK4tNWofmnUsx5rn1nRCQWAVZ0EELXr8xhQ1anM3MV8SPQAS68AeD1wCtnwXA0UfFG5RMYo9xXXv8v/foGvyEyyazTRBGvo1p/dQGwe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(38100700002)(86362001)(38350700002)(52116002)(2906002)(4744005)(2616005)(478600001)(8676002)(8936002)(6916009)(36756003)(6506007)(1076003)(4326008)(316002)(6512007)(5660300002)(6666004)(6486002)(186003)(26005)(66556008)(41300700001)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvDY5tNY+K+9m4JSUwsVC9b0kJRMbcX+paUGG64j4xChppxud5d78kyPuHB2?=
 =?us-ascii?Q?pRcV2SrQRu7WOHyjWDQLr/I1XA/+VTRcNpKQ9h3398LZ428HJu1s6zDvkTQv?=
 =?us-ascii?Q?IDkV8VW21WQcmJUkyaR3APWnMOsQEcZP1PMK9Jdthx3hOGpBLjWfS9TGk/uw?=
 =?us-ascii?Q?Oj2zln4YmsshEvNnjJ7uHqLv7+Sgp4F2GkM8DmIFbY4X3h1UHfd4afx9tI8M?=
 =?us-ascii?Q?bVh7mRcZ7NwOvQ0wS35ePoI4WTWTn7MainTkwyf/nf4E4xgxLrVJlVsEpFDA?=
 =?us-ascii?Q?x0faNIkBfu0avPx0wA2nxjalY5Nfe8ru+1bZrqfvKukzw6KgQT795EpGoSkn?=
 =?us-ascii?Q?GHXZnPMKuQVHUuhLBnGmpwmlGRbVojsUWd3awdSbZjjFXHmkJhDQwNEa2HtO?=
 =?us-ascii?Q?VC8tTfSSz1Q7WoqqGvbawoU8rwLn1J/YYjdx9xICGDewCFDttKrBSpv5KjsJ?=
 =?us-ascii?Q?I7k0trVCoZYeFzW8ucmhyJb3xttP/DUPKrDJMJRht1riEBR92c12kwcHrs6i?=
 =?us-ascii?Q?/ilypImUNkGDpm7/p8Cc7BcFYUE2V4f17X/Abcvlr4tur8+rOeUuCcL4u+ad?=
 =?us-ascii?Q?yGPk57gz2RouvBbiiqfPk9aeYRzjiKWuYhcEwqxPmZDB7RNtUKUimliGahq6?=
 =?us-ascii?Q?joFnVU7RSfItZlojRlAGCDs/2K1bEcJlveqxmEtjIqaCFF9FLyZFy2ShTcBD?=
 =?us-ascii?Q?n4SsarWLcHhE6UlM4AZ+CBiaxYQZXvaWa/GEvNpSQgltUhxcN3o1KggcCfqr?=
 =?us-ascii?Q?kB0cN4bPbTfC8N5Oei9d9LqygoNtYLaN4npw74mpF09WznB2yfYuS+eGyo4H?=
 =?us-ascii?Q?bQqBibmhpT+3zEqq5SQWydWdUjVR4aMZSFbozT9eFjYLtHXQeWx13vRZpVIJ?=
 =?us-ascii?Q?MdgjOWpQo1sLSujQ+Liqm1s1uj79Fcr0xhXsz3LZWHIBtkItzFXy/wQm94P2?=
 =?us-ascii?Q?PAZmWTn/bgvB1+NEU5MvWk+BUROyjc19VFzgA61c4mOJWh8GxGjUnll6v2Ab?=
 =?us-ascii?Q?WTQqb0yQjW+N2AIX3o0R4uLIuVoJIK/hdYQ5O/B9d43A6Ga6cIh3KwLmRTCO?=
 =?us-ascii?Q?9uzDHRl5MwUMHr4Gd0OLMGhB7V+utRTbUUs3Wo+BHbQRepRYJ/qlFTf9M2Te?=
 =?us-ascii?Q?hftF0EGiNNHRvyE2GWbZDYjR/knO8lFcUBbJK2mmjJQEraS4oKb248xuYGK8?=
 =?us-ascii?Q?n+0gfAd8hGZ/bAHzZjErJkhBsrRL8Zcg6RWaasKX93icst0cMsg5jmM8KjSq?=
 =?us-ascii?Q?JIbzo7G4/WT7kwJKhzu3wQeMeIxZxuDH5DuiEmymJHzk8z8/0/5GR24v55Nd?=
 =?us-ascii?Q?DrHenSsx+fBX8lwt7EC+7oLWUmUFA8lm12ec35fmOoNU4iYREo7JiIJYy0Oq?=
 =?us-ascii?Q?ffLnDiM0wSAaI0AxD3TXdaEsYRN0gGHAiyol9Ais3bl9eUvjTVJAeU5eR70Y?=
 =?us-ascii?Q?9q+W3QCGXOw1YoRcGbE7LF8Oe8IHUEKguJwk6N3eJAsgfaNJNVdEbmrnaUeB?=
 =?us-ascii?Q?Bc0mKgW6UfoQD5GX3uh601wpxmjwN0ZRoo3DxVxRAWS8C4uw8f83a8raVwS7?=
 =?us-ascii?Q?nhSgtsIghMZmD6fsRBJSWgBj2wl9ligDr8zaB3pvfr8FQWiG0r8LF1oDm8+D?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a00d9a6-fad6-4265-cb3f-08db5c323a67
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:38:20.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTs56uirotyCNMNdxG6BfIfuLOO9Zaw+lzng1iuL3L7zRuHR2eqD2eGtF0+vQK1w2hGG+UVUJ7emgqDZzPA1JD7+WVDIrNOLU9DKVrOiF50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Luiz,

To test BAP Broadcast Source support implementation use bluetoothctl with the following commands:

# endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06

# transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0

# transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 <file.wav>
