Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79FC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 07:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjERHPa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjERHP2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 03:15:28 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B091BD2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 00:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJQ37Gt1MBjjBLkDDSAHukeKzShPzZNfitYU8suh3WSsDQ6tVWB11nJCj4VbLTGnGFL+9UnRzm+z9NHtgqOVuTdNzbd/YKVngSYDSfgHgLzMa//Q6lhObROOG+EYi7fIDt83ruSVJA/xj3RvmHKvfi4KLunk9Y46CIldrfAEINJUYpiEIHqhkeS4O4LglvW43fywumijN/RuboSvB0DLKPFmwgUJgzS6fAQXC3C4RudycFtgvcdFv9Vqv74P1XhFf+s3CEuBmWMXHCh4hjZnkdtjvcr9Ku8QPNeDOK3rxnYwvp/lJBAh46pGTnZoGv39z0HtGHsmgd1Ku+c3UZ1iKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSuFfIOhrJ1bHoKcSWcbw6Ni0W/x4HV9z4ZPWSg91qg=;
 b=Z2kHeprnIqGaUhyxTAdJJ8pGuNiZcOFyYKUJpyESXWflGo+KAY7c05SelRVqoatMw6suFjuDvE0B6QZMFJDh3abhEwi+npVe0mBvpLUhjsbFKVNpr/z/6waFRVbQex4klWMEnMwJu5JY1wdl9rRLPQ1yi9CNfn2m8Pn7ZpVpQhGlJOsVuKOSo9kkOy/KbqspByqqoQROzE1eilKfIA7kbs6pHQSPgde+tRGpwH3lmxci/VLcXkUnv4QE35GtAY7bkhOO2Yx1y7Y2kHB5WaYm7Ww/cG00xv9Xwxw9YpHrLKUdvolUAh/2faGUW4M65zD+Z/glAbpI8wEO5DGcSoaJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSuFfIOhrJ1bHoKcSWcbw6Ni0W/x4HV9z4ZPWSg91qg=;
 b=kojRNsBG3zGKbs5ed7ZytRCyGBXHa0OazFMzCaF2cARTc/vwoLIw0RLX2vhLHIkpFK9BeeOWU//4+jmxhomJ+ZodK+J41jOaEJcQDEDkRJPw/QCKI8LjWifd3qmz3zC64HB09HJVBBVxoDJUeeoi4pFxYULqZRJBWPV5XN2oHHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Thu, 18 May
 2023 07:15:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 07:15:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
Date:   Thu, 18 May 2023 10:15:07 +0300
Message-Id: <20230518071507.4640-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZ+mRgkn_PiL5=4NuQQudrQZQvdYqVuab3m_S7pRvj9YeQ@mail.gmail.com>
References: <CABBYNZ+mRgkn_PiL5=4NuQQudrQZQvdYqVuab3m_S7pRvj9YeQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:208:136::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f885b1-5332-4294-fc93-08db576fa626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQ4pXJdvTdsWffEMfvHUsjYafXz5Tbjdem1BDlAK9wdj1Qwp4gtvTyBB5kZYmNlSwvALSUrWpz5wFMTAsaXkXFMbLNgrvFPnbozt+qObs2G8qWDbnCIT7b5zOtYxeqA7h5YuyLEA1p/JDZkuHfKJkv53liO/F3ppeVeKPV1HBkKt3q6umKpwYADlYtNYEl5XZrYpqcDutiYzcLeFOE3prDDb0FVf7P/IGyIELERREgzIb7/RtbeDV2oly2butFdhj/v0PyszXI4fpEDiqoJJN+upjGfvajEiSWEiGH3NZc2PCi2nsnQtvUdf+aX60XtXdebOuRveEd68C2xZUG/pYsiy+WFjs8oKHH1nPi7o4gn0XfuQrHfLzltL/D1NEkt1/PuqLE0qo24PX6Lz8T6EH/G/gWoA0y9b9EgRj6mKCfeuDY54OzHzan+GG96mWRdOUHFa41TiHfWbZDXemOlFEXJEVjib1aeN0hEYtlVM2x9SUfYf7GM6ScJx46PmCRh6u7tplyoanib8zRHc2P62hDaXXnKuO48Q61HWke7SVOWQ3sCZxFS1i5hIxtODrgHgcXmT8agsRdEt2nx758iXvVrDagvs5ph3JjJa9BbVqnm3EOF4bZa+4wesgQpP1AR8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(86362001)(36756003)(66476007)(66556008)(316002)(478600001)(6916009)(66946007)(4326008)(52116002)(8936002)(5660300002)(44832011)(8676002)(6486002)(2906002)(6666004)(38350700002)(38100700002)(6512007)(26005)(1076003)(186003)(6506007)(83380400001)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSy2hFmRVDTw8v/e2iPYPp2XH6t6kS6tSrNHvj6VQJuQyrHxq2Izy8NG0Ixj?=
 =?us-ascii?Q?jnh0wdzf8DnSZc32Wgf+EMtqoCGFOLBECZrT479y1sYyxypkePkjXotUBxNZ?=
 =?us-ascii?Q?rd8ob6o5g28ectn/6sCdpscAJBZQzbtlxbT40TUEswhTYz5ApVUR+HAT/7n9?=
 =?us-ascii?Q?fyMsbnlP0Rg0f+8DV99IM5LH01GO1stVvfaY1Oxf7jANsk7h2oVW5oyx8fWP?=
 =?us-ascii?Q?TRi1WoZJw0gIC9IoaWyHMwurv7l8ffU+yC9vkQvHA0nTEY9SQzuFNIDvbnOp?=
 =?us-ascii?Q?hVNlxQ0TBXySI14DX4u7h7WVxd3jOPyR0E35N4YgDflS4muBo62SjL3QFsOS?=
 =?us-ascii?Q?9r+i316wr5k8lyhYNXHh7IzEwfo+hIBIk/CSzqPM1iW+UKFxWpcirTLe8OGx?=
 =?us-ascii?Q?/NI75vqQ+O1CuPHnDWDvq5mwyh4+zUQFTocPip0ctz3uAKESl+/YwJftOq5E?=
 =?us-ascii?Q?vC4Pqj1zrmiOdV/zCmDd2+AJnDpaqwajkN9awk+3dXl3aiPiCKx8MUjC7/3D?=
 =?us-ascii?Q?CTIXC3rqJLj5BBeGcfzVAI68AKEQSaZ8iN8cx3a9h7YcuI9W1jGxbCcegL8G?=
 =?us-ascii?Q?VezoyTVBHTQ/wMRPJ5fW6RY0jWULpk3+WNWl7lOD9WnDgruNBL8J8EJgF6KK?=
 =?us-ascii?Q?Ti+REq2Ci7lZbKlRSxX3rr40RPPAaLwe0ytGCzT4s6YFRz9vg5Rs0/EmHpoC?=
 =?us-ascii?Q?P0A0J+AgFX2iNn0tVpNsuxMaeqP2xwb3RQlzl8eczVqUFlJ6ysTzztYCzmRw?=
 =?us-ascii?Q?nlotsP3CttzblSwW9lQIZae5KY4HivNQFaWVndOgNuQc14+wO9+qHoqcXSuJ?=
 =?us-ascii?Q?/IxKhPS1n3eGiKvvvW/NuOZyQuUResrmsNGqfOBHbjOl6y/AlEjmQZghW7KG?=
 =?us-ascii?Q?KtgS5FGyHOsZw/2/7Eca/dWt4fPoMnQ8+9BgEZUpOTVrBpMhHr72KikL+qNw?=
 =?us-ascii?Q?+OTqcD+d/hAEM12jdCqOA+KxPdhyh/bb9KBVv9+128WCRJTEU3QLnRJtCpXu?=
 =?us-ascii?Q?TKoB4yMRoZ/PZruNSfSY1sbiTQlV/CLkm2ZtaKYqTQXW7b1UzgpntjaMwtO/?=
 =?us-ascii?Q?1KM3x6rPM2zwGti2kQjzR1nOQbM5T0UrQx7l5p5+9wYyaBjSwzrZVO8hVLTF?=
 =?us-ascii?Q?sC0HgpC5w71Sfu+/H+3WzO808VP3QdMYVuyVIB3wBjbKW26ekDVbN2Qr05CN?=
 =?us-ascii?Q?ndTHpbpclxxE6abbhvnHdA9qG1dEyXb9H9oadzfmjOSo47hBZRfRnhnpIxgd?=
 =?us-ascii?Q?uWlhmyGn40GJqwvEfFiutqhweCbrMllVjwuM3tvei0HZ2B1Lq3pybKc+YPQm?=
 =?us-ascii?Q?wfWHQLF8db6GippFtRM6lUji5msUdz2GuAk3fdB+yUjeocCITPgERm++sJjj?=
 =?us-ascii?Q?YXDYFOZQn29Ciwy00PzOuVQ98Y1e3QEq8o2yQkAqOeJfbj3IzVUA+C16AbA1?=
 =?us-ascii?Q?LJppp06pVTrtpN3vcFFZ2dfKCSE2G8sne6Xv87KOzD6MUt0B8lU0kYze+tDH?=
 =?us-ascii?Q?rYiR0zoPZoJkcxNo25F12yifwr2hZjVm085wD0ZMyDi4HWnGz27zqfaK+Sih?=
 =?us-ascii?Q?YestIsSJrKBTPg3T1q0rbjMsDcoNztonRsivQQlpI5XMB/WewW2bcU5g5J6C?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f885b1-5332-4294-fc93-08db576fa626
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:15:24.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVVMrAhMipTzcSR2Nv7Momni2ALcQII5sYTyOs+jJGx1UPp4CytQr0Ur314gz4/qEI7sdARU6YHI1XJo73ttpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you for the review, let me better explain the flow that I proposed,
because I think I should have added a more detailed description to this
patch.

I added the num_bis field to the QoS structure so that the user can
specify from the start the total number of connections that will be
opened for the BIG, but one socket will always be connected to an
unique BIS.

So the user will first open a socket, set the QoS options with the
num_bis parameter set to the number of BISes, and then the user will
call connect on that socket. The BIG will be created with the specified
number of BISes, but the socket will only be connected to one of them.
The rest of the connection handles will be stored in the "bigs" queue
that I added.

Later on, the user might decide to open new sockets, for the rest of
the BISes that are created and stored in the queue. In this case,
the connect API on the socket will not issue the LE Create BIG command
again, but it will extract a connection handle from the queue and the
socket will be connected instantly.

As for the HCI_CONN_PER_ADV flag, I noticed that it was only checked
in the "bis_cleanup" function, to decide whether the advertising set
and the BIG should be terminated. I removed it because now I am only
terminating the advertising set and the BIG if all of the BIS handles
have been assigned and no other BISes are in the BT_CONNECTED state
for that BIG, so I thought I might not need the flag anymore.

I think it's a better idea to use DEFER_SETUP for binding multiple
BISes to a BIG, instead of using the num_bis QoS parameter, so that
I can keep each socket completely separated from information about
other connections, so I will update the implementation.

Regards,
Iulia
