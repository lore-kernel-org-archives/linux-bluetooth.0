Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32966C07545
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjJYPAk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJYPAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 11:00:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED996133
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 08:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPaJDnIyqI9oUo38+BKKHu1Uc8dHQcQ2Smo3qf/YaCGf5aPWPMZqBBGWhhKAmO/KfXoqwx+B52D9SieGB/bAxlE5puOS7vspKIUrA0cnD5+/mXaM4BU6n/tXGlS3c/obhELbQGpu1T6UdYE/qFPRH6reAq4JKy+ri/sK8BgdqBxz4LllH2//ta+n1LoBrrM6Gyt1y/nX7Y3jQs8G8zZ4Du0yPNyRIEWc1aKxxTFjT4POroF3S8cgJKlVAxAC2PrqEoMP12vJ4ozgwc4bS4OMTP6UoB1UtFYCGzaQCn8JqEMJsVQV3SR6dj5mJPvI0hJsnAMkjUaltXWMdkRTSb9gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6C6s+hbKzLzls1TzDOUGa/VBKD6fPJpPQUs3IQhwic=;
 b=blqUCjDFuw0vvp/owiaTJpsoezbAEnPu8vLhD3WEho5snYGkB3hCfvM1HfHvUJvT/DGly/Zqes9gbsAvTPGr0/i5xLeQO8Du/KzDKUwZ1caGfA4poiH34eIMlQT8teTOXgLcAS0bjAf2YJ/z1QG84pcQxhLSflt/pVXJqkkSLYf1F6fvF9qJ7tiM/D5jWMUPlq2LRC1nOQlAnXL7iUAFotuaMfoAKqVirN+D3KlH52qPgMf6ZxbtgbvjlFaI9SW348T1qXNSvRk+BBt+RSId0jkZe7jo8zpvwNNC4Enr1DhRFFyAdJGuchXoyZMX8NYQFEsNjUdVt2laW73kCufE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6C6s+hbKzLzls1TzDOUGa/VBKD6fPJpPQUs3IQhwic=;
 b=pAt6tkeBHoUK/OoJHMaVFQEDLcxpoONvGEt0GegoI9cDQR4CltJvcVRLAhUr4tNQMpwO5A/vNFPzvdGU1AJnTpzGXmv0JdvsKTpoNKN64MDHe2kOif9nrex5wTYRpndtDpCa6mQhbK8f1Kk2aEaNH5bnjGD0hLgy87ExO7ODLlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 15:00:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 15:00:32 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/4] shared/bass: Handle G_IO_HUP on io channels
Date:   Wed, 25 Oct 2023 18:00:30 +0300
Message-Id: <20231025150030.3222-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZ+jgKfE7f7M1K_3WFrTPvfBRewb5u_q5SC8HQtmiRXzDA@mail.gmail.com>
References: <CABBYNZ+jgKfE7f7M1K_3WFrTPvfBRewb5u_q5SC8HQtmiRXzDA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:803:104::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 928b66e0-ae53-4e5e-060f-08dbd56b2281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2sHpenbddJCS+Jo9WguWgNuH0M/jBQweZs13k5YA3CS/eSS2UzUN4qrfr66Lim9Ly/CdG8a7LThL0bT2fd6f/jiJVY9+bseJDm7daK0uU/hfq6hrERGehByF70Tml/KVlhdvE19xiZCqM5sY2aSKwY+ltyxJWy/JTtSV8lFpwgvogiegeYsv/C+NU0kIP0Wpl1VkDlMDMIktZlbwk10nsVc23scokL/pO3OpzfhXplZeeNaa706UcRaX1WKT3UQ0AoA+k7GH5lTSNiPdjQLICv4ZWNSJPSb/mMuH23QkPSt5oOgEvsXaIaQbl72YtjvCLarRLBPjW8FLiW1oTMldkf4fUR2JfDWNECqEpu2sJ9uU5gk4Be8nN5g6zIoEdXPRLD57Wx3pD5py+iIWZOVUe2X8N2xI+oNbfHOBhjd8uKuvixSrpQp4d/JsOS6lEf84U4NYQu1flzAk4xvjN5iQo3Eu4Q2B37BswJxR4B5sxivHs2Zp3FZMCMurJHQlYwKtKD/XGPgwdUIQNyBD2hfIvsZWo2fPbIO+Xkl1Hy65uyWefjE/5YY4Qax94yw/0vQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6916009)(66946007)(66556008)(66476007)(26005)(1076003)(6512007)(2616005)(6506007)(6486002)(53546011)(36756003)(86362001)(8676002)(8936002)(44832011)(2906002)(41300700001)(5660300002)(38100700002)(316002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGToJ1FcIDqFt87HThYpoRg7YWlnaJEJtnrQiR6BrxM81pVRNz86qcqvD0aV?=
 =?us-ascii?Q?wsk1zFnjKXQ3ea09Npb+B9PUApEN7OHUTIJoby0mq1ci1ajmZWIWok5PuS5b?=
 =?us-ascii?Q?ZD8jfEiIVbQ2dHeFg2hPbQ8OxgNqiNsYqi/Uy7yN9Nh83woxizJ6joshFyEx?=
 =?us-ascii?Q?2AjAP/VsqTrOyr1139QEbV/+mn5Vc9o9BcTq1jV8ZzvvbXH9660sGEb1breF?=
 =?us-ascii?Q?9aLcIy7J+SwiAq+l8PsyjRCCL9h/lLI1CMqmsBrAOp36D5BR85SZrReOhwvF?=
 =?us-ascii?Q?iIqB+foS8MgMNXERDKfi7uSanTT4oG6/pnjEfMj9LmvZjnDN69D30fhGfa5K?=
 =?us-ascii?Q?B8yMznOgJGpxS1vFNvQ3VHEpQieoNuj4Ma+vgJ02qUAjrnMBezl6itPGush7?=
 =?us-ascii?Q?iMvj0fcfw70kv3y8pg2L2ekJop3fTEg9UaV78jStuAYPPLrarDat0sScmCl/?=
 =?us-ascii?Q?g5a23uJtq9xwYyqqWTWb8ezjv22MiKPvN9ZzVoTKsvQX5kZFDz9Y5REmX069?=
 =?us-ascii?Q?ehCWjGtazXpoxojrRwZSXQFpKw8W2onbBVZUQq6opLZWAXxmAfKpld0JI167?=
 =?us-ascii?Q?PjkGyjSZjz51ZcP0aQOWiOa6elEbw/svBe9Px954ne3kjDR1AfGepO8p4hHF?=
 =?us-ascii?Q?HWfZ9kjex2UVqU+8p9NtlNmvkfrIjSadtp8DY95n8vKa7NHtfKfsq7xCq6nl?=
 =?us-ascii?Q?Is2+37mAYW6Zh7bDdVxacOdvCISKiZoLxI4Lkzese/qcGa1mimvvaDXFOa0g?=
 =?us-ascii?Q?t9vOyZQ/nkmAvXcwwmCP0jfOAGM3/7J4tDZF3Ip8ulUC1h3J76SOErE4+Ohr?=
 =?us-ascii?Q?l7gnR4xo5cD4ycth3uobSpSgJ7a0E1cYG6KCoJh9sOtasUufR1dOJIecEsgE?=
 =?us-ascii?Q?JL8ljV2EM4pjOzemnfOzQmadQlA8Q5QNEIB3dZAqgZ42IjwFJxFgp07v9PnK?=
 =?us-ascii?Q?5BkiGNZvlhat+83VLu9rpde6rcqxTAxbQ9lWwJZcsgRH0p2A9xICZD/KV6ur?=
 =?us-ascii?Q?HOoAkY4Qwt0OmCLTDWjsM223saBXRae7BJRwY+eYs8bpyZDbKMJBOmot7KJ5?=
 =?us-ascii?Q?KOBFWYiwcFN/q7z45iy/yIbbRJERDOhUiyIRULy1TWdn0njx9WPqsHM8EorH?=
 =?us-ascii?Q?cty4U1Q/OfIohHmDeWroUrTWWvCErNj2WnMxdbdLak5g1EFWnS+VGvlTh7Gr?=
 =?us-ascii?Q?RO0d7hcFNOSVdq/JrijDGkYsq7jhtA5kC9z2L3ncHxXxcCWb6k6WdIETayrt?=
 =?us-ascii?Q?6vGpNiRVxY8y0/cadE4pop/yHyHsIXLqB0eBDOvVBCuMdLgWRRshg2penj7Y?=
 =?us-ascii?Q?1L8VLH2c/c0K4fXHq7WowMNK/S99w21WpE2yjgP658zarpaYX3Pw0hckSH9e?=
 =?us-ascii?Q?MScCObgw6nevCn0ORMhKMtoyFgYLiwYKNWIhHj9nvLN+VYz9V+NgD+oZEq2L?=
 =?us-ascii?Q?UOOSyvd1vRftU9+iiM5LPrzsWcTk/5EY9+us1DRsnfT7fQbT6Us+ZR6CyGar?=
 =?us-ascii?Q?M1Ce7GiBeaRbQrAf7TEZacaVNrSWNrMdd7tK3Mu/JTTtrbEb+oxGzNwH3c7+?=
 =?us-ascii?Q?mX5dIu+swfQ+L+ZpJJevhWAwhsW6AS34r8zBlTDXycIaGED4oOaWypSJ9+J1?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b66e0-ae53-4e5e-060f-08dbd56b2281
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:00:32.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq3V2SKoMuP68g1to1XeyFN8nYEXBG4CTB2a92Xa0R/FspgIHB3zzrRaYXmQz3IDAJVDpR/NNNG9AG56R1LGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Monday, October 16, 2023 8:05 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 2/4] shared/bass: Handle G_IO_HUP on io
> channels
> 
> Hi Iulia,
> 
> On Mon, Oct 16, 2023 at 8:49 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This adds watches to handle closed sockets
> >
> > ---
> >  src/shared/bass.c | 59
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  src/shared/bass.h |  2 ++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/src/shared/bass.c b/src/shared/bass.c index
> > 0ee3187d1..78103d463 100644
> > --- a/src/shared/bass.c
> > +++ b/src/shared/bass.c
> > @@ -655,6 +655,11 @@ static void connect_cb(GIOChannel *io, GError
> *gerr,
> >                 g_io_channel_unref(bcast_src->listen_io);
> >                 bcast_src->listen_io = NULL;
> >
> > +               if (bcast_src->listen_io_id > 0) {
> > +                       g_source_remove(bcast_src->listen_io_id);
> > +                       bcast_src->listen_io_id  = 0;
> > +               }
> > +
> >                 /* Close pa sync io */
> >                 if (bcast_src->pa_sync_io) {
> >                         g_io_channel_shutdown(bcast_src->pa_sync_io,
> > @@ -663,6 +668,11 @@ static void connect_cb(GIOChannel *io, GError
> *gerr,
> >                         bcast_src->pa_sync_io = NULL;
> >                 }
> >
> > +               if (bcast_src->pa_sync_io_id > 0) {
> > +                       g_source_remove(bcast_src->pa_sync_io_id);
> > +                       bcast_src->pa_sync_io_id  = 0;
> > +               }
> > +
> >                 for (i = 0; i < bcast_src->num_subgroups; i++)
> >                         bcast_src->subgroup_data[i].bis_sync =
> >                                 BT_BASS_BIG_SYNC_FAILED_BITMASK; @@
> > -703,6 +713,18 @@ static bool bass_trigger_big_sync(struct bt_bcast_src
> *bcast_src)
> >         return false;
> >  }
> >
> > +static gboolean pa_sync_io_disconnect_cb(GIOChannel *io,
> GIOCondition cond,
> > +                       gpointer data) {
> > +       struct bt_bcast_src *bcast_src = data;
> > +
> > +       DBG(bcast_src->bass, "PA sync io has been disconnected");
> > +
> > +       bcast_src->pa_sync_io_id = 0;
> > +       bcast_src->pa_sync_io = NULL;
> > +
> > +       return FALSE;
> > +}
> >
> >  static void confirm_cb(GIOChannel *io, gpointer user_data)  { @@
> > -726,6 +748,15 @@ static void confirm_cb(GIOChannel *io, gpointer
> user_data)
> >         bcast_src->pa_sync_io = io;
> >         g_io_channel_ref(bcast_src->pa_sync_io);
> >
> > +       if (bcast_src->pa_sync_io_id > 0) {
> > +               g_source_remove(bcast_src->pa_sync_io_id);
> > +               bcast_src->pa_sync_io_id  = 0;
> > +       }
> > +
> > +       bcast_src->pa_sync_io_id = g_io_add_watch(io, G_IO_ERR |
> G_IO_HUP |
> > +                               G_IO_NVAL, (GIOFunc) pa_sync_io_disconnect_cb,
> > +                               bcast_src);
> > +
> >         len = sizeof(qos);
> >         memset(&qos, 0, len);
> >
> > @@ -844,6 +875,19 @@ static bool
> bass_validate_add_src_params(uint8_t *value, size_t len)
> >         return true;
> >  }
> >
> > +static gboolean listen_io_disconnect_cb(GIOChannel *io, GIOCondition
> cond,
> > +                       gpointer data) {
> > +       struct bt_bcast_src *bcast_src = data;
> > +
> > +       DBG(bcast_src->bass, "Listen io has been disconnected");
> > +
> > +       bcast_src->listen_io_id = 0;
> > +       bcast_src->listen_io = NULL;
> > +
> > +       return FALSE;
> > +}
> > +
> >  static void bass_handle_add_src_op(struct bt_bass *bass,
> >                                         struct gatt_db_attribute *attrib,
> >                                         uint8_t opcode, @@ -1023,6
> > +1067,11 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
> >                 bcast_src->listen_io = io;
> >                 g_io_channel_ref(bcast_src->listen_io);
> >
> > +               bcast_src->listen_io_id = g_io_add_watch(io, G_IO_ERR |
> > +                                       G_IO_HUP | G_IO_NVAL,
> > +                                       (GIOFunc)listen_io_disconnect_cb,
> > +                                       bcast_src);
> 
> IO handling shall probably be kept outside of shared so we could emulate it
> with use of socketpairs and unit test it, see how it was done for bap.
> 

I submitted a patch to move all IO handling from src/shared to
profiles/audio, similar to bap.

> >                 if (num_bis > 0 && !bcast_src->bises)
> >                         bcast_src->bises = queue_new();
> >         } else {
> > @@ -1318,11 +1367,21 @@ static void bass_bcast_src_free(void *data)
> >                 g_io_channel_unref(bcast_src->listen_io);
> >         }
> >
> > +       if (bcast_src->listen_io_id > 0) {
> > +               g_source_remove(bcast_src->listen_io_id);
> > +               bcast_src->listen_io_id  = 0;
> > +       }
> > +
> >         if (bcast_src->pa_sync_io) {
> >                 g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
> >                 g_io_channel_unref(bcast_src->pa_sync_io);
> >         }
> >
> > +       if (bcast_src->pa_sync_io_id > 0) {
> > +               g_source_remove(bcast_src->pa_sync_io_id);
> > +               bcast_src->pa_sync_io_id  = 0;
> > +       }
> > +
> >         queue_destroy(bcast_src->bises, bass_bis_unref);
> >
> >         free(bcast_src);
> > diff --git a/src/shared/bass.h b/src/shared/bass.h index
> > c4b5b76ba..bd3fe900b 100644
> > --- a/src/shared/bass.h
> > +++ b/src/shared/bass.h
> > @@ -57,7 +57,9 @@ struct bt_bcast_src {
> >         uint8_t num_subgroups;
> >         struct bt_bass_subgroup_data *subgroup_data;
> >         GIOChannel *listen_io;
> > +       guint listen_io_id;
> >         GIOChannel *pa_sync_io;
> > +       guint pa_sync_io_id;
> >         struct queue *bises;
> >  };
> >
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

