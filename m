Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13EE732DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 14:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjI1OcR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjI1OcQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 10:32:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D567F5
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 07:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK1VGsKaiyxpE4O0eMhzxmLzYdRLVsJx3Q8dmjkBQ7q1Er/goZ1e9udd4KMwnKZlYIJhEda/UYc+MnmZlIUvFbwwQAZSc3cLTknXS9PUulFP9JqHY/8zfS0mO55e/sMC7XKEYLJTs3xxYRTffilLdyFZ9Ezn+D6cEWdzzVvKSrgLPWIsn3+fvzLdFlUFQbJFjDGg/7V9w9LluhPCjqMLGvcTScPLDQQ0xKZlvn/j3AWtO7FeJsgJn6ZIf9ONCJpK7GkzKTegGK74TnI8gYuMSeyijdfixwYPdRSWx9bsCm9fCNN3sSPAyhlHm7gJ6DcMbCsaKs2mo99RWz/bmz5vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6grMOOf0XNs0FymnfxZcrdGFUHjnNma012J6olxVJtU=;
 b=Usyrf+AqpZNUBpCtRH2dJYCJBpvfHQT31GQ3T79ZgYHXrPkfVQNUdw5Gef9LGT3hVud6KPoVOmnqIYr1JgHdCF96Uhx8bp2uG5uT6UsSFeznuKpuZjVohO5Y4CGTbyrLVx+LOOt5YpHULR+FF1ka0SYWLuf0DowYQp4ER2/rXjbtbYs9bSdw+7OaeEjoxLaAFW0mafxuUqjbbZYIKORZ4d0h0R8gCcD0JiFnO1tvF5zpd5CRH40AnAO4HiNXmT3NnHIXd05I7lma6H4Wqnqb2wohAHEHV2eftvFYY65hxpA9uLS8S4o4t+z2AuEcrciOwwA0tOIpt/fPMqdY93FGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6grMOOf0XNs0FymnfxZcrdGFUHjnNma012J6olxVJtU=;
 b=XA2oZGg5GgV6kBvXaTWbCHKW2+gDs4swIDyFQqRY+UEFujO0WIIkg/KwFFc0FVql39rA4Xcd2vu8+adeHiQ7Z17i0nOAxvoGNVZfE9yPLWN+u3x/TXDOuw3qvJafkjKuynU8BHe7qVmKGtuXfe+5jYxccXEPixILG41OfHph6rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:32:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:32:12 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
Date:   Thu, 28 Sep 2023 17:32:08 +0300
Message-Id: <20230928143208.3256-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZJW+KV_+293w8MPu7+Ek0zrSgA73ZVF67zZCA8iWy+znQ@mail.gmail.com>
References: <CABBYNZJW+KV_+293w8MPu7+Ek0zrSgA73ZVF67zZCA8iWy+znQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: ff712b99-8450-4b46-b83c-08dbc02fb3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDuTEP6G6z/2ehyP5uyf7rnWi26TAc/ZkeZyXRi8EP7JfcYCny8Irdwf2dobct4jljUw9ZmoDp3yLvDLcdjup8NvmcnG//rOW6ZUobRLbU727r5UvSG1HL1lKafg/VgVTvSOs0U1JzCNfpFwNSaV/taJQJSSF6faTL+V4gqa9hTGBuKQB8Mr7m+qfttJLHxsI6LYPcHPKuP8Yk4wHiOkzgoAZY2/fanUaI/5PPPd97yRtPUbtQnJq1ztG6sGHQIKJvByPDa/Ucw838ncfZ5/B/wdyWZPpa/80mo4eDRFi8UaKpQZlLkfcly/+RlPIWPFwze9FO2Wu7q5miOj7hEw2XvXKNnUoTRZb+MvN/Z1yzi2PDwxFFzyaFpUYoGlsd9aceoEj+Y37kT4lBveJxhVec4CXCZyHMC+8kPmAdQY8ah/q1Fr6y9B/4KrDmwVIaPs71Nv7v4emeCj0rHSIqUvkox343V7dq5SlcLn434lDWrFu6dynP/YBaSelJ3a0gDAg0iJdMge1Yl6d+0qRQoipXzE2ChGDFf7ADRwoBAMrAdUZ9fEig6KOSEJ7CQxkyrvxWqJHx8+bIU7SggKa/HwlgS1LLmF+NCTmNSuMB4evFBrbY3mu+KwqEQENxPPEI23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(53546011)(6512007)(6666004)(6506007)(1076003)(38100700002)(2616005)(66556008)(66476007)(66946007)(86362001)(478600001)(6486002)(6916009)(83380400001)(26005)(2013699003)(36756003)(5660300002)(44832011)(41300700001)(316002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Trzt/TEIs2eU1V+whtp4SPvZO6opG60c/CyND0QiEN4IN0fZMbkGyLOWW+Dl?=
 =?us-ascii?Q?RYYvsyLRmVed7rNw2NuVMZVeNGgylIdDvNza0Yf5eE3iNo/UXiCkq9AJYvW8?=
 =?us-ascii?Q?JzE0+Mc0df2fD57oh0PBpAlMPME/cy5WlcJxKUgLWZ6fMZyWpwW6DGcGSKZ5?=
 =?us-ascii?Q?0IrxCCN8Hrmf0If+DbMXZnCnkObUb521+udNV/vjNEVoSq9HfTAistYKWJOJ?=
 =?us-ascii?Q?6FriGiv3p2OzQWcRWc4pNhK7tB/lQbpKAxy8Ls7XED4gVCpXUtfWCoWprTII?=
 =?us-ascii?Q?jqf5SwDjbzAnA7y07GBTKJeWoWsVsT8LYuLUJYgO7e6Q7m6aR10mJ2l7tlyz?=
 =?us-ascii?Q?fHL6hMf3GcqMNUY+dH99bG2bNMKFvxj9hUhVOeEIsM0J+F9m7vN7mABhwEKy?=
 =?us-ascii?Q?bt/t303U3VuMB4kxVyslBeGzRUk3PLnp+oEfDL1bjcl6HnwdjEbKlKY7PLhQ?=
 =?us-ascii?Q?LoOcf4F6sRmLHM2SoF/kvw+sMlDnh75IjFfeVc7WTZZtg5XRF02OUvlqcrE8?=
 =?us-ascii?Q?ZhZ+7WpLHk4EueYgFBUVkGsoLSBuxrNovLqvDxReKmeKoZeQUlnQ3Kj7Mq/9?=
 =?us-ascii?Q?meM5VqReRshgsY/71/qQzEI5wQSObQKxRJb5MtdVWbKcbcmyLrNo+gA8Lr0h?=
 =?us-ascii?Q?eSfXZdlsmZWEZoNwSyRM3waOm2iR8BPEivGYufVFvl/ilTjFRx3v/x+WR+nX?=
 =?us-ascii?Q?p00ICLw5WbjMCEiarGz1TaWs658uHNLRV73KC7QwVJp1JXb+aDBhbIB3RHVa?=
 =?us-ascii?Q?6vA4QumJ6X3am/aDzh8JoIaYh2HzM4TeP08k3QNLrCa3dCIkD0LJKACCydXh?=
 =?us-ascii?Q?dPUbdvFbzKsE3zWqn/lUoQ9xcgCPvwBL0EVBuNjnVBhJsBEnweM8+TxUQns5?=
 =?us-ascii?Q?sx6z7OpKW6Ef2HbU4PKoZVCo34ddPKDJk4oDEB4TDkcz3o4Aj578QgcvLKIA?=
 =?us-ascii?Q?eOG7vE6j+7FlP3oWQ8E8om503h0uE/FPj3TzN+jLBwnuFy5IoQ3ZV4vwEUfK?=
 =?us-ascii?Q?tkyQthBI9Djtb6ECta3QALr8A1CqCwrrJ39yLW20gGZB7QLOy6Gpeot+bAy0?=
 =?us-ascii?Q?1754UqNb2CkNCoQoNa9RgjoBiw2jiTt+uG4OQN+xs40Kr8Ma0ImD8gKfmkT3?=
 =?us-ascii?Q?Rg0WvVTXD0xtLiZFfXuFXK2tLfSYNe96s7WMyyp94fP38RYay2XaaBlhN/m2?=
 =?us-ascii?Q?4riU54qfv2tYMCOKNDrB/yJLA3gT+/UoCyE0RuPFdjVuSF4JgXZXCaj/fOR2?=
 =?us-ascii?Q?erN/BYf9UKVGCd6wjAP5mMhvweYbQuNUeVtoz86lU02qrzrBeZwqKPdc2E+X?=
 =?us-ascii?Q?ekhd19n9x+Vry6qBdj+h2ocLJxGiZgU3NW1ix0iiRqOmVFIeyfggMIIxIJpe?=
 =?us-ascii?Q?or4dprm5h3oKbhpR6IowHx2L3xWdYqQrZfc4EoIdViwsqr6XR2wRLyRKCEpm?=
 =?us-ascii?Q?wSgX9fkSbJLXCoWpi+b3nkQcAjMlQz1PjDpQuGYWR0kqpG3VuLVc7Gccz0q9?=
 =?us-ascii?Q?2Al83caDx8KFpmpzfz13EUkrd53LZMCxpKHUpEpxVXG69IUkSTaDPRukeD6s?=
 =?us-ascii?Q?ELPi6wiTUKt7ZnxdcD5s4WFIgGT1uRhpL6cPJK1i2ShA4PSvjdfr2BZexT8r?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff712b99-8450-4b46-b83c-08dbc02fb3ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:32:12.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttH9DtBphEqSEWNHsmvH9NCZil+kVm1AW48zRb2DZURl4EujHnIO73tSrTv3vHM1nCoCHVZiA4kEfK0Cu0wX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, September 28, 2023 12:49 AM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH 1/1] Bluetooth: ISO: Allow binding a bcast listener
> to 0 bises
> 
> Hi Iulia,
> 
> On Wed, Sep 27, 2023 at 12:59 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This makes it possible to bind a broadcast listener to a broadcaster
> > address without asking for any BIS indexes to sync with.
> 
> Is the intend to use this logic for discovering broadcaster? I guess we should
> make it clearer and perhaps have iso-tester also testing its behavior.
> 

I have been working on new unit tests for BASS, and some of them require
the BASS Server to only sync to the PA transmitted by a source, and not
any BIS - for example, BASS/SR/CP/BV-05-C or BASS/SR/CP/BV-06-C.

So basically the BASS Server will call bt_io_listen with defer setup enabled,
it will just perform PA sync, and it will notify the BASS Client about it
without also continuing to perform BIG sync.

I submitted a patch with an iso-tester test for this case.

> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  net/bluetooth/hci_conn.c | 2 +-
> >  net/bluetooth/iso.c      | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c index
> > e62a5f368a51..c4395d34da70 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2138,7 +2138,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev,
> struct hci_conn *hcon,
> >         } pdu;
> >         int err;
> >
> > -       if (num_bis > sizeof(pdu.bis))
> > +       if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
> >                 return -EINVAL;
> >
> >         err = qos_set_big(hdev, qos);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > 2132a16be93c..8ab7ea5ebedf 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -790,8 +790,7 @@ static int iso_sock_bind_bc(struct socket *sock,
> struct sockaddr *addr,
> >         BT_DBG("sk %p bc_sid %u bc_num_bis %u", sk, sa->iso_bc->bc_sid,
> >                sa->iso_bc->bc_num_bis);
> >
> > -       if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc) ||
> > -           sa->iso_bc->bc_num_bis < 0x01 || sa->iso_bc->bc_num_bis > 0x1f)
> > +       if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc))
> >                 return -EINVAL;
> >
> >         bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

