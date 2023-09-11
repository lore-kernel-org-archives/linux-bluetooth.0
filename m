Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C5CA0EC0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 21:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjIKVRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjIKIkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 04:40:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039AFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 01:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHwErS4v7Y+sLd88XmjUmlSLExVhqhFnnBQpSJiHjWqASRH2Ozb+RYweu9AnrWEvARnbp4Ub+dKDNedgC71QcFt+c/a9Ld+/1oBi2yv9DMY0A4CPXLYiyam6h8kK+XeA6SX2Pievz/RWP6TMNDbspC78bsJ0gQB5yzAFFFnltgPUsm/FLBNnIgXvT2SCeH3Lh7QPWB03RE6y4pDpCnEKt2DVu0ghnrVfjdZ7bOqatjgbAqSkBXcOZtD1x09rsvadAZhdR9kTA8sny3z++2bX8DfbegWGKwVZV3OgASSt+1ZhtHzHzHLyVGqZL0UFipy878NTqURa7MEFkamg/LN71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxga5DFZXwx3jAQiZNGgqnjCOZHgFM4uhq9ii17qHwg=;
 b=MbaAJXpIwstz53Wd4keBOUpLvAzLCDg5Y6fyR2O8M0a/F6k2yJuHux3EfdvMeQD/302rNpt7hYgNtaxEvN14qXUIpEXUmdsrODWVi5ttjeFxBf2iccxhyrFOSwE0JQ+2f7Y3u3IuhieobLs5TqGKXQLZFG2BL9sKnihIrpXJ9x6GnFNANAbKMLAMIX42/COwDOr5LrfzXQcAE/WtG5W4WIXBhEubELYe0NR7A1qydjC0RW/J0W0zdPu75/DDCHq2oFOj3THmnUm/QwkcPXplUdUHW58J7ndZB4iDvIBwV7zPML6ZuO4Fz/ppp6SnUVJiorIklRxVyb77jKGUCdqI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxga5DFZXwx3jAQiZNGgqnjCOZHgFM4uhq9ii17qHwg=;
 b=XI0BIQJtGyNvI6OUSH7FmJw4FcCpr9y+2URpQRR5MfNRafCfZRhn5DTpG3axXfdjQogF6yEJR5BFzjG1qKXralVhE0meZuWlnzIb4RNUodugU4ecBt/+tvexVh6hf8Ake/7W+uEPMhoyFzyKxQj5/SBerDNEI5oXlnvC9gvDVek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 08:40:08 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 08:40:08 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     william.xuanziyang@huawei.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ v2 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Mon, 11 Sep 2023 11:39:51 +0300
Message-Id: <20230911083951.42831-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9971ad4e-e07d-9d63-2bb0-ec9ae4e0db5c@huawei.com>
References: <9971ad4e-e07d-9d63-2bb0-ec9ae4e0db5c@huawei.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: c63719d5-b584-4ed0-faa5-08dbb2a2b43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H1a+LGQs+EOomiHzox4FaBUWo1E79l9QBystRhV6wkf28W3fsnKgxUaRKPGV9OzTREhTMLz88Ip93puBqWAmZFuLK84r4So0X2nuFCES+8/9c88zzU0pFbwnPqJVvw3P4mGMse19NTi75+RPiahQmK0fEBlPs5wQzUPQS2qodEToUG+li3GEXDcz5ewCLpq8lhSHiUn6lWxv/CnqNaprVImHcATbanY/kzscTT3TnYjqNLVJ0VqaSJFzgjvZuCSkPZK9eMg8RswbUcevZBOefCGWJILdZrJ6JetgA9hlUGVyMKHQEAP/KVGhz4gX3BCLPPFxlvSG0ub4daSXVNAdhZW6ebeI99Q/zHccIgX0HKkNCgOTet4NTV9WKI/Qm4MFTib8Dw5cZyREiTVQjAUyAERF2ikKVcl+ZU744qXt61iYmkO/aoBchEzxZr2J2yjl7DTyH0/XkSzRr2p0XHuR0zq8OeP5/SWqUiqQZ4nOSrAk2SE5WUVXrUUwelNs94pYE8o1oP7QHhTJjiZ8gAhkRXthCDr36y/jzsuOGALoBxdBi6CyKke3+GAILlgI8XOySNEmcL/8C15uE+v+WWNt+B0kMf+OXzKYgV8jK/bEIHgUUGfhPqUo7L3IQfErcRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(5660300002)(41300700001)(44832011)(4326008)(8936002)(8676002)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(36756003)(6506007)(6666004)(52116002)(53546011)(2616005)(6486002)(2906002)(86362001)(1076003)(26005)(83380400001)(38350700002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UO3zk5wbrAe5XonAcGsMTZRjI6sPgMG0gv6tA9swPDDSiZsOxr9hDi5qL6n?=
 =?us-ascii?Q?WKa4q4WNIRrN0COCIaWb+1qR5UYKToYiI1++stT1Po2Gs3q7Y36952SmbWu4?=
 =?us-ascii?Q?KknEkL8aMXeWJecuencHdh6PCzNchPSt4rQSjGgJ5V67wvQz4REXVZZXfqKj?=
 =?us-ascii?Q?/yec7nZMxVXMGIngKc8IuQQ3h8RRHYcdYr8itdOy7zub6LzUPsySAbQ3ZGnu?=
 =?us-ascii?Q?/T0kVzlt40c4Pr3Rcu3zi9VQOl5dnl7yELOqyHJUPVHZmwdQQTSXZV0wA9H8?=
 =?us-ascii?Q?OaTWyaFtEonXZdAa1R4M51Q6mnuYso8JiolkGuq6hVCNcF+3GP61MLxK3rkm?=
 =?us-ascii?Q?Pigtbh+rbXg1FMb7KDFAo3JQ8H0B3Oi6diaPmapRj7qDek6GBI0UKTxxSGw9?=
 =?us-ascii?Q?CkhtombVjr0BoV6mrAxxEX1ofebmuWM9MZUBZd2dIG8kEzb/S1MmwFIR8Tzr?=
 =?us-ascii?Q?mntNHN8Sk1OnXu2u2sotk2POjHm6WAq3yRaduHOvcBKhl4yx97ba+Pc/9zPb?=
 =?us-ascii?Q?PNWmp+fwUK5wbux7pElH/H3sivecDw1vKmmXASVBbeAfni6x+t8QwHiuHVUG?=
 =?us-ascii?Q?fpzC8SS34Muw37lSR/1fLqazbGhSialmspsfOGerLLmQqNcTXhaarlVp8q/O?=
 =?us-ascii?Q?Wbxwincm5Ew16j+49KvdDdZuc5qdNP8rOtcHiY+aCgVgcoAp2YAEFvYo7VQg?=
 =?us-ascii?Q?ghyUIePiOlQ91blxlhcYwfXSgxfJAjt0LSB85VDZ00f55yyLFbhll2juzuBE?=
 =?us-ascii?Q?0kefjUundMAXJgXrjXZ7fUuPqz/Cg7m0Uw2GiTWuHNebq0/8+wWBforBfehw?=
 =?us-ascii?Q?CNbxh9bpO4QLqxmiH/XjDxe7olqnYjc8Q1l3R4HCcxMffVBKvBJkDGcfkIjG?=
 =?us-ascii?Q?HWOKmIbu/6qNRMrR/0XN2iV6yeohSS+E4pAihL7LJ+NWC4AsYDDC8BxmkZcD?=
 =?us-ascii?Q?6DrSuGNlHcq9a2sjuQpKMP6Vx8VPFnJky6MBXHFhWCbRk21pjrRtoJ3EobF3?=
 =?us-ascii?Q?ZuIr6MZjY5wvLt99kExHoSu4No3U6HLfsE7cs43C/h8uTA3SeQzyoxnK+248?=
 =?us-ascii?Q?weEBbNzplJzH4Pi7RrqTKblr//D5zP80oyMPS+e0ScVlEsX2wuiXaxBHXNzm?=
 =?us-ascii?Q?kTbEr/4zqPapmK0+AUUnS53/uRVZ63s4v4joeDbhwNyPGaFP5kELHPL701iL?=
 =?us-ascii?Q?9/yIm5ov4iDCQjZJwXbrpJEDawfnViwIqPlUHiiFThc+zTgh5itHakbtXtX7?=
 =?us-ascii?Q?qhB+8fMHBprv7ijzf4p1ERtrEHGZlfwv86LAAjxNc+kJagYujBF9H/+rJGia?=
 =?us-ascii?Q?7iu8lYUwVSQ0/kvYGbgCutXnsim8oP0XrYEHju32IRYhT0gWqK4cPNx49SX1?=
 =?us-ascii?Q?qsUXJMtLYBEf1efycbo8z+6d7psHY/KT1d/DprOM0/fkiJXVn4I7O03Cq+mj?=
 =?us-ascii?Q?TswZHJp7i/JISb4ERAOZ+kSaSIpEoiJNWKBtJYTEH0EMr+k/+DWAP1y9bmdD?=
 =?us-ascii?Q?G1VZOdqfl7LhvvxwH8+LPuCXwOXC2yaaHnlvncJewNi8yTDo+AOsfveTdTEt?=
 =?us-ascii?Q?dQ/1HVB9OSvuSZhQL6wFhBU5n9Z/1LJzh2o/TR1YvqpQjMjWRcy2/m7vGeko?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63719d5-b584-4ed0-faa5-08dbb2a2b43c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:40:08.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLyrVEKXI22ypv8/aZx/ZoGdqu8dkmK366yCa5LDXfKSeQlszdLmACJQ7FvZ7deEc3Q8WgYq0FF9T+kHIoO5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi William,

> -----Original Message-----
> From: Ziyang Xuan (William) <william.xuanziyang@huawei.com>
> Sent: Monday, September 11, 2023 10:05 AM
> To: Vlad Pruteanu <vlad.pruteanu@nxp.com>; linux-bluetooth@vger.kernel.org
> Cc: Claudia Cristina Draghicescu <claudia.rosu@nxp.com>; Mihai-Octavian
> Urzica <mihai-octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v2 1/1] bap: Use defer setup when syncing to a
> BIS source
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report this
> email' button
> 
> 
> > This commit uses the newly added bt_io_bcast_accept function from
> > btio.c to implement the defer setup for the BIS sync process.
> > Now, information from the BIG Info advertising report can be used when
> > sending the BIG Create Sync command.
> > ---
> >  profiles/audio/bap.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c index
> > ee90426b9..8a2da24dd 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -840,6 +840,22 @@ drop:
> >
> >  }
> >
> > +static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data) {
> > +     GError *err = NULL;
> > +
> > +     if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> > +                             user_data, NULL, &err)) {
> > +             error("bt_io_bcast_accept: %s", err->message);
> > +             g_error_free(err);
> > +             goto drop;
> > +     }
> > +     return;
> > +
> > +drop:
> > +     g_io_channel_shutdown(io, TRUE, NULL); }
> Maybe we do not need goto. It's can be more concise as following:
> 
> static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data) {
>         GError *err = NULL;
> 
>         if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
>                                 user_data, NULL, &err)) {
>                 error("bt_io_bcast_accept: %s", err->message);
>                 g_error_free(err);
>                 g_io_channel_shutdown(io, TRUE, NULL);
>         }
> }
> 
> or
> 
> static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data) {
>         GError *err = NULL;
> 
>         if (bt_io_bcast_accept(io, iso_bcast_confirm_cb,
>                                 user_data, NULL, &err)) {
>                 return;
>         }
> 
>         error("bt_io_bcast_accept: %s", err->message);
>         g_error_free(err);
>         g_io_channel_shutdown(io, TRUE, NULL); }
> 
> 
> William Xuan

You're right, I'll update the patch using the first option. Thanks for the input!

> > +
> >  static bool match_data_bap_data(const void *data, const void
> > *match_data)  {
> >       const struct bap_data *bdata = data; @@ -1587,7 +1603,7 @@
> > static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
> >       if (bt_bap_stream_get_io(stream) || data->listen_io)
> >               return;
> >
> > -     io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
> > +     io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL,
> > + &err,
> >                       BT_IO_OPT_SOURCE_BDADDR,
> >                       btd_adapter_get_address(ep->data->adapter),
> >                       BT_IO_OPT_DEST_BDADDR,
> >

