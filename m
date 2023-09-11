Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F154EEE7FF4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 07:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjIKHss (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjIKHsr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 03:48:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5FCDE
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEXSUwFTSaAucTjbSC21mn7/UQx/+lNlCYhd2LInr2kISqVGtkvBzpgxq0J2N98j/3kj/YJAkX80nnL5ne46utjUb317gQcFydJjX35VQ9k2bajpmuviSSbthcHurnchgs4T5D9bo+8qWqL3t+uX0rGWAHToxLAXsFdSxUoJrMN61S53MMwWxDdgCxpQMjaoRVGbphB7yvjgYzhH3j0iBYFnpdms+IEth7rf4LuD/6sMU9ok7qlgoHR4pBOLj/R95hkTTq4B/5UF8flXdMAJBFt21M+Hk0vlRvLn1Vt7+D+PwOH4ujxXGJ8f55v8e092SQLyCX9xAmTS0cCzDZ7q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSkn2rrYwnkh0/3Y67mLSm/7ZOqQ9+m6g1iP3KwbJjc=;
 b=IlyNPo1keZt1rWFk5c8nllQw4mmgNc3vHdfP8NxBCUF61MhJGA5jRwqxTB8DwVooTnEmh9561Sv1qvFof9hSxe7fAimoHJL18vj0C7n0ckyhuWKQ4FqlcWyMhiNsVTLbnCuRGSLvo9C6C/uqeYkUcoFCmCbxXeifXSRdWRoMYMXPEdUcpDHzqu3tbIP7KdjnjE9q2rtAOf4WFrGBQdjCt41+rijrJmgUSMGJVF7UHK6zPWXVPsOLuZKWSDfqeAT0hkFVM2dtU/Z4TpGLSqHcjLyhS6WTV16Ptb1HDLJW21dej8/uiipFqyvgGu8eDYIDmv/Z7xmRKTzq1Jmv566fjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSkn2rrYwnkh0/3Y67mLSm/7ZOqQ9+m6g1iP3KwbJjc=;
 b=pyeqbpV09xUp4Vkh0Q3r2iKoERWjELrW/1A6s+i5ee+D9muv12kOeXl9I90B24rwNYM4OoqbhkCdjc6+CJYmhda8od0kRhE1KHZw0OeWot78foq7sORAWvHvAjjiQFPkegqLImpRADiyQ+SvU+4fgXYVB77Cl5j/gbxWE91O1vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 07:47:28 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:47:28 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com,
        luiz.dentz@gmail.com
Subject: [PATCH 0/2] Update transport acquire/release flow for BAP bcast source
Date:   Mon, 11 Sep 2023 10:47:09 +0300
Message-Id: <20230911074711.62493-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: bf978d1b-b2c3-443b-1130-08dbb29b5883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9st/bix/pcnOcgaiDEXD/x8HKGoMpujuxAhevBtNojldINVuNUPJZfq8pqSTzRV7ybwmgC1DXMqoXrSw5aXIzb48ZtajK0OvFkax5UxqEdfUm2hT1G4SykmsDrSeRbjLU1UC4L9bS3IsgWm63OKATFuCNAkdeMODETUxH/i+7Xp5H2iVGTmmqU4AjXqb6qt9qlDMdSIWU4In9Df+zHAKF8Bc51avte64H3TnmVrTbsX7QXE9P0Hk1rqkYRAhRQ2WeckhbtBUBoqgxJXDOTO09JGs0lPua+Q+kNpDn2MdcArsmDz78OVtB9WmKK8y+B3OhO+1A/UWneAQ3VWm1VkI92fQK43rIzrmhAsoGhSBsz7YpI0flbcXRbs5zBj7ul3LR0B6CY99HONHW0zgWCPo6XbJ8pT9xtA2fYZNiEUVtrWUWTXNV/Ov23m1Z7N5D23xp0OJ/1kQIA7j5rPCtuKZ9F5/iylDZWmEJc1E5I0ILayKKp3jZ+G1jvFap2VJb2yNApfKGNjaL/MZCCZWZUTztks41rFPhUPmaBQr5Bx1E8dYeeHNemnroTXBIwC1O8Psbk2J+A04rf6NtFABSSk6bCWg4PBsBptGRrXDd7BWjccuUxvNm1nQGhere6jSUrk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(52116002)(6486002)(6666004)(6506007)(86362001)(36756003)(38350700002)(38100700002)(1076003)(2616005)(26005)(4744005)(15650500001)(6512007)(83380400001)(478600001)(41300700001)(4326008)(316002)(2906002)(8936002)(8676002)(5660300002)(66476007)(6916009)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhzTXqJBHzKLmjbMXc2DuzKo8vpCQjkX/GT0xKicVsUr+3TnZu9KZYROMcWR?=
 =?us-ascii?Q?P6OqGJ4bwSvGwauxqv2iz8WzNBZ/kYxHMnrcHpXUCYNUF1p2jn+H7eMGS1RO?=
 =?us-ascii?Q?MqCd3Tll+b+n1aniymwdvh0G9wk3odYuNuw87JBKn1sPdm0INyTMcvrdsJ3+?=
 =?us-ascii?Q?6nf/VJosggl9zkZNN2quxrXhq/JKBV36rlMSXdMNIRYph2XczFWzLYpXqLsv?=
 =?us-ascii?Q?eZfhgmJy2yoPrbQSvSyH38jaaYPl58A/GHbqjSrvNnnPSXK/B59EGUW6i8cL?=
 =?us-ascii?Q?EYRwQZQXqLhgLf10ctkdLbKtW1aVCByl0YQrB3CuxUQ1zzsrviZizbL8Dy9v?=
 =?us-ascii?Q?+TnBXSd2/rb1KHDkaJhVdg3WzGUKJLKwXIs7QEH4RsaA3RyNlVKQtwEk6gSi?=
 =?us-ascii?Q?TmBGd67BBAi9xWKS+r5ICY5Eos97IrLMXe3NW/F3tOoP08sLZeG7zgL1i0yB?=
 =?us-ascii?Q?gybLm5Lkfy2xywK0xPI/AyS3ieuG4TZkX2czfrFn71XpvPVZIOwSztxMr3rS?=
 =?us-ascii?Q?fz6FPRj+ZnYOpUDWs7EKuQyTWecpeS29uq5EQr7dSu+cKLSuGgk+Yn2f22YY?=
 =?us-ascii?Q?cg7ImuINLKqaodli7r3rfM2SjTsq1S83/YVpo02RtlguoRFTaxaHtLJCHVnd?=
 =?us-ascii?Q?3IpBvjM27N6XBzDwdpoW/wdrDkpNZgAnXoo3zQqDafWpNzO4lQIzmMnDoX0w?=
 =?us-ascii?Q?HEOrf2TyZcl80w5h27tjCySMV7n82TemHWsuE0UwSUFw/9imzVAFdF8iubZ7?=
 =?us-ascii?Q?fDx/S7sXVRtJjtY33sABMh5SgpITDl8ZT3APGWhKdiCBMtlK1FLbflA7tYAh?=
 =?us-ascii?Q?k4JlbDawMnMFL+vU6cW/r2FUujQvDoGjcOy4qQ8S/QY+M4C7Z7Jttd28byoJ?=
 =?us-ascii?Q?h4ABpPJOAAH3FJO+ONfsXOm1J1ka4cSMUStTySfKYXk+u51uBcXzdgqDgvzX?=
 =?us-ascii?Q?JPT+ItptaeCFlhLJxrCmnKgWqxGy48g2h5qT2K+n3pUJY6UCy1/7+u12KWLX?=
 =?us-ascii?Q?40Uq7g8WkyxZB0O8RihPqovcncigB+Hu4N/48ojGA3RedJ0GDtVnimRGJR1l?=
 =?us-ascii?Q?b7dRpOYSBN6WfTcM0ru5QLAN5yJIX6OxOjR3YDIedJv6suZbr1hJDsiMVDNG?=
 =?us-ascii?Q?yLiTKPI/ysJLq+sMgTjO7cvprzqgwQwWDNhwMQSWaILHZASh10mLsSLgPxtI?=
 =?us-ascii?Q?jID190QsNxcX3CeylUkawdXYfXmCoZsiUGEtJwBpUwyInP+3U+K/MD1NYubY?=
 =?us-ascii?Q?Rhu6TkU/U7L66UxPwHV6JYWLWgDtGaTVkA8RSUNlk8j43v7GF4k6RjNTUc75?=
 =?us-ascii?Q?I9Wa9ypRfzvcHxBbykLo2cSHnTI96YIDZOWEwwVxKQkfE/C6Lao0EhHZOyX6?=
 =?us-ascii?Q?XydyIaAOrK+iffv6NcaQmrRlgX6KkSB+McGxXIVt0DbLHUJ6QOC/JSPRu5a3?=
 =?us-ascii?Q?CL7psd9JujWIRQClmwKDzUZXyR/YODmTzMcsIID9Ch/m53XUmUlyL02N0kwC?=
 =?us-ascii?Q?QC7bHa1pYWl9XyH6m6d5RjwP+l4R0FrU78CvPv/zjMLehXR0z70PHV8UVM6a?=
 =?us-ascii?Q?eu6inBLoGs+v82GNoPRs8jHTznIdG9KPs0feXHfKY3Sx1EOtYyAjbsxmpObl?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf978d1b-b2c3-443b-1130-08dbb29b5883
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:47:28.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77r7Cbp9OqJ1OnWBmefZ/ONX3kyYAz9c7MgqV2FKHXdg5iNUW0H29jedjZHKHHSFG6QH8HJjexyF5QGjl6WbrIp0SE8uL7PJjUdTwRuaAwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP broadcast source to 
fix failure on transport release, and second acquire

Silviu Florian Barbulescu (2):
  Update stream enable/disable flow for BAP broadcast source
  Update transport acquire/release flow for BAP broadcast source

 profiles/audio/bap.c       | 27 ++++++++++++-----
 profiles/audio/transport.c | 62 ++++++++++++++++++++++----------------
 src/shared/bap.c           | 51 ++++++++++++++++++++++---------
 src/shared/bap.h           |  2 ++
 4 files changed, 95 insertions(+), 47 deletions(-)


base-commit: df658c6c4ab5bd5ec4a8a3f8faa36e0d0a5f906a
-- 
2.34.1

