Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4DEE728C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjI2Phj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Phi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 11:37:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B25DB
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 08:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct/9vrIS6D/+WHOtehVQsGehhTLSDTS+BNalyXhmw7SHs7JnXwEd7GqbOD67mOHS54BHMpHQq+xGM8RPwatVLJWLlo/yGzLxe59jLQXUACXu/McT/D8zY2MsT9cdImt2xSUc6W4kVHZTXsvumEMJF3UbLD4/lpbw62mSOXeNdWIJ8cnQrsyMXGmVpp1JHcmWX8jHXxLMzLNQDmeAOMD/4OCg0zt15eaUjXGJ+ny02pe3K6Deh4UgJHrnDCrrpZVBLI3fl+G2s9CKvwkdEyDBvTSIgaick42NZhup9zT9X5iyrpE6e+qUgxzbFbTrCIQaA+++wN7CPuBrxQqj+e9TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS3hR+D1Pb6LiVVi38Tq2eb9phXgmnA0bAAqT9IdonU=;
 b=Lu3gEY+QpnU/v4lxMpp9v0Me8i7wUlIfkSBu22uMt+sgeICOZcQ8GdQoTj36qnN93w4JBPPnrs8zfzY1yhe19MmQQYZ5aSoOOjOApt9Ymd6Q+t50+gRdTTdhJ4oVJ3MRyLYzWqv2JHF7x1PRnWC8zEghe43KHl0kzcbK+ild1JcbDNV6AcrfKoEsWUyqeGt6ta+OagnFwhHqomfFI+5nK2YcQOIxgzH3OX7CxWaGMWU5fnGs3j6r/tWIy9MYeiOCp44a4kDgj6tnJZ6yNSygtaTKCPhpv8la+oYT+sv1nH4YOOr9jTcWtex6oMXNhwP2fh2iUm3BO8fuwEL+jnzFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3hR+D1Pb6LiVVi38Tq2eb9phXgmnA0bAAqT9IdonU=;
 b=o1fi9j3qMeoo2PfCMVhxZ+I/LoJY1RdhjEFvsqlknUwePgELtMIRUqMc2K/GOTa9wl2BlQsuuVpZ9N8Y5Dd8HgeynGcYrkKwii/3JY9zlrYlt2Uysc/UJUznnD73Ef+/rcIMwpUshuxEM7kHmUG0+FWlI4TUg+I9MjWCTqDcebQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 15:37:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 15:37:33 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
Date:   Fri, 29 Sep 2023 18:37:26 +0300
Message-Id: <20230929153727.3728-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0062.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfd820d-bcb6-4c4e-e4df-08dbc101ffb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f22Gk9zcd8Vyt25TdhfxJdyAJLQYXOOPnp4MK1ih0FaVXeQD7KYvKxkJ6DZFlnSG8eHSnGOmqz48m5U43JvqiJqlgJYlwxhtmZjDHyUN2WMiHtrzGWY03MtfnxlMtfiVxhp1A3jZFa24NEQqg3PhO+l4GZM3nEnRiYJ3wKcFM0Tq/tcVybH5K4sNGCvkXNp/VT0Mp70Qrvzr682Vez7NHGNSxbsICwAwnTxWR1KM56kn504mVT42ibUoLC8H9P8Go0eyFVLXcxqoz4BvMrT+UF0Jm2epFz2VpkXzy/HakoJ7o3WNEFtG77tmos3HG1uZ0OZncA0mkBNGDwtpmLbCd+blb8fY83Ol2Kh0w3fotHYMfwNuY5SP5fgkiFQJ+HJUq8spwt/739Xc+mFdR9c/UGw7WQwAkhF4OLKv+gHVJUPYyQdMVzrH2jQzhvYusIdhB16bS/Ty3OQRvtdsTly6zPCXxPu2C5kwkwrgss93xkUOD3JoskzLh4328mszKh6ppZnf8lrvhJOJ3W1vsR3A2ct8JtdWS4V8sFnbDIGPMiLbxXpzMuX7dj33Vn40ttak
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(66556008)(66946007)(66476007)(6916009)(8676002)(4326008)(8936002)(1076003)(41300700001)(36756003)(26005)(2616005)(6486002)(478600001)(6506007)(6666004)(6512007)(86362001)(38100700002)(2906002)(4744005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UIzdni3UA6cwYtTmp5lW2TTgHbg3Fi+N00JleOXOul1kBCiAofRAsFLushW?=
 =?us-ascii?Q?jy/lMDRnmg68AyuhyafcAZU1g3wQozPBA7gwWhGAhqGAbNysfJwbuwjnZiO9?=
 =?us-ascii?Q?qeGx+m/2Lm2xpE83PXsC8yzSAgpUR4eEjozk8Y4h4Y96QSsAOFYmaaD5T5Cx?=
 =?us-ascii?Q?8UuBDOtv3gZmU43QwIrFS1SpFZ9sUNXxzGRT3OWKCnmXXpUjFbFChf7DhnNW?=
 =?us-ascii?Q?/p67uHMLaGE5ON9qSnMmssIvga/EPUuNVNte+pJ6fjCkMG1pwzZItbxaDJGe?=
 =?us-ascii?Q?2fOBKRU3lESuZbVgm/fWDnWQ4nB37Ig/AMTlUxe0BAECtVyx7HFoU1Pr74O2?=
 =?us-ascii?Q?K1NsLsk2jNOJlU1ZtlZza9Z+d4k1fi5Tll33B1zd6q3TN75q6W9EO5DXzwzL?=
 =?us-ascii?Q?JyPxEQP4ZAGYwjaMBTmqTXxT3ZNe1MYR6Q2ZGwvg8XeHvwST56NycQIdBVF1?=
 =?us-ascii?Q?ldRsFsXVO1QQAOj124QGYMXyPHSEu+gg7QiM7U4K0XiBY0M6tuGtXEVHykme?=
 =?us-ascii?Q?cl03c8IGzwOuitmEPn3CCKp+hU/SFhwnkiAcUbIRApCDAceXPQHI1d8MFyis?=
 =?us-ascii?Q?56zQ2cwmtgwwG5wNk+qssfroyFP/EjWf3SjzOidcjbFQI2nDxustgxCaxkf1?=
 =?us-ascii?Q?85GC/LpNJNMvS00erOSckPN3JltLnJfVe781ynt0z0wPj1WKlznAiXaJ+Ivl?=
 =?us-ascii?Q?b/IlRpY2DeA8FOpBaI3ZdOYHwc8R5o9HEQNPb1i5JzBUFOyHxwgI+Or1t9r6?=
 =?us-ascii?Q?3uANp9Xmri9kVu/pduV3+mlABuSSvPPQb5qefrlkdtN58oggjZ2sKmyNpmfR?=
 =?us-ascii?Q?HwsdbMYnpS6lllCGi86Uo9NiA8Hptpvoeh5HUHSQzZM4dudmrWQzAwOSVraB?=
 =?us-ascii?Q?Ts2k4QNFt88UKbGjwAuuHaVsh0BjBSvU+IJUkKDCCq8CCHE09nsaji3+5qto?=
 =?us-ascii?Q?YLJwjX99Ao98NNzvrkYA/CCsFy8bX6CT6B1osmCj0mrYBmUkVK6whMwoEiZP?=
 =?us-ascii?Q?2pQDDVNqdBSOAbeaZnVemsRdjEB1RjSxPgVUl6i90K/06Wy00Xr3C7L5tD/H?=
 =?us-ascii?Q?7umoIV8KYlJ+cHbfBw7tF+IQl4Bk8ILu2DCHcUbgaYTvvFyCxV8haghwekht?=
 =?us-ascii?Q?blCWrFN8lMCCsPQ51sxSQd3unJgtvFffh5rQP1G2H3fhC9SsAjhaDM8pTEpZ?=
 =?us-ascii?Q?xx+COgFOxGHexTfauuiKNmGsOzshQ1BgKd5jhp4daB9OmLYHUJFsFIWBRl5R?=
 =?us-ascii?Q?Ezd3CzNLb9sk/RLw/oIf5hWttOIPprcOKCWyMRIvEelP9Lrvc//wzArCcz7e?=
 =?us-ascii?Q?VxsHDhWmO81LYo/H4cQUt3aLsBu9+LTVfNqH1BMkUsJNOeaXRg9vLY5/g2UV?=
 =?us-ascii?Q?knEF8jUvH5qcsNO/3C2sZl1Ju9o26T8sQT5tCKrBHc4QiRzO4Yz0iqXFOia8?=
 =?us-ascii?Q?pbGJ69vR7fDPMHorakzvGcJMx8XcQoba7LdAN3VhfbA2xKoU+CDNPPEoxHKf?=
 =?us-ascii?Q?tCIINcViUJlAlEhViW741NNGvChR4qT+s1GZCg7u/MHKFCGWBK1qLdlFoIpM?=
 =?us-ascii?Q?r4OD9okIRy1sVHAqSNViYGMZssg0Snvc4xubwoK+s4z4a+t21fpu/Xt//Nco?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfd820d-bcb6-4c4e-e4df-08dbc101ffb8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:37:33.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAspHxDx4FV2bI+hk/fpOecAbgmZ1Fjl5xEKTh6BSLT9MIDTwzGczpkWg++WpGWL0Oj+e1IPyRKONAZgqYkEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, if the user wants to bind multiple broadcast sockets to the
same BIG handle, the BIG and BIS fields of the QoS structs must be
identical for all sockets.

It means that the user must remember both the desired BIG handle and
the associated advertising handle that the BIG will be opened for.
This information is redundant, since one BIG handle may only be
associated with an unique adv handle.

This patch makes it possible for the user to only provide a desired
BIG handle and leave the advertising handle as unset - in this case,
the kernel should allocate an unused adv handle for the first opened
socket and then be able to match it for all other sockets that will
be later bound for the same BIG.

Iulia Tanasescu (1):
  Bluetooth: ISO: Match QoS adv handle with BIG handle

 net/bluetooth/hci_conn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

