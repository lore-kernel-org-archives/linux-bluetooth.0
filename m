Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3181C41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJPN1K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPN1J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 09:27:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950FE3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 06:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3A2iRCW7ydG77Z5aA20Bybhy0W1Xt78JKbuFiJofLSPWOEbYN4AdyIS2ZfoiIkmA6avMdCgreKPduVqSVEFnReb4ef5wBQRHTdrQOPG6sCugfoQu/QhS9r5xx7i5qE0CsfXwXNEkEQU03W+oX0A6HI4fDIt4/REQUK2TP7oRBSLhAYkImIIZmiWxRuK61u9HAKgasjsbQuc9CD5cu1Qp68+hd8cRY70qu/QpVZ6fGzJy+gbqmPhN5QCgXR03slXMHjQP6t6+XCgFjGrfY2LzdBPxY3NoLyTeuRMFmAaSuIrPhskl5swODi7FlLN1GHXfb4DCI1kT/yesqMz4S21BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bpodS72MocjxGc1ho/yGAyxJ+j4UlAGxjvBVbHSQLU=;
 b=Md5WOn/13IuHuwmxB6DTI9vop6syhH3y+lM9Ta1hRHHwuwb+Pwg1HaZjYJ0twoag3JdEpVe3zEvUfGNlxWNRy5V05nMS3BQB8VtGhDrzZhfOvXCt1+CMf3ApVpRGkCuRf6AkVMtC7xEqceGx/pqazo1ViMaYuWP7kNprleed9y8vNfP0f1pRKfHJwOfmvXD3LmjtfhWYP3RIaECH7AN+SKCp/LdQBX1zQeMXyYDvBYaCR00Lk2R4NdPOjT1oR3kY904FEVMOiipR9FJlGUQqYatq8wmeRIeHQLkQiDp0KJF6GsL55vPVt09i4eY0BPtST21W7vWEqiK0+flvQQe7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bpodS72MocjxGc1ho/yGAyxJ+j4UlAGxjvBVbHSQLU=;
 b=lY+W1h+eiLXqS73DMoOQfJguHFQBUL9zh4kldCmIFmLLpq1VMRszpUINIbeptuZfGkiFLNaF2w25aub3cOcjnsvu6ve0yAJdMZyT1l+VwYBNn0l6M9VHTufFMKha6iuW3HcgL+EaRNHfX0yruYqt+GiUUOumkhulIwb8CGvjG5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB9115.eurprd04.prod.outlook.com (2603:10a6:10:2f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:27:04 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 13:27:03 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 1/2] bap: Fix source+sink endpoint registration
Date:   Mon, 16 Oct 2023 16:27:01 +0300
Message-Id: <20231016132701.4793-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZL1UJkH8_bUv-qRW9TZSAwhrw29_-R5xjnz9B5b+EO5ng@mail.gmail.com>
References: <CABBYNZL1UJkH8_bUv-qRW9TZSAwhrw29_-R5xjnz9B5b+EO5ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0063.eurprd02.prod.outlook.com
 (2603:10a6:802:14::34) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 05db1052-fc78-497f-db43-08dbce4b95da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2nZ1fDAkP3sBW9zwZt0AYKEugcEoOBTPVmlMhqtH9Mi+8f3YnK0SX8/O+4cW8IFGbMoFMH28zajk2XdEiS4ZW2BzBW9IwdM/qPr9bdbHJ8XtxsGxlEDF0+aQ4tmXRF9XAEVjalVEXjO8JNdSXIYyOmhGjp2p5Pa2wJzwCz1aibj931/tF4r+PDdOw1kMOPOwZ6rdu7x+0kZQOgwxLlPjzxEdrYF8zwDSCYPwaxrCORRur263y+gCD8rA1m+KhHkyEsOwEMv62zIYmfLWWJBsizACssdimM2FtH6iXUn3ijZ6q/Z2dUV6MNEy91DSYUT4D5m67/WgkBTL+1S6TRDhOcoDmFFp5GNy3SNY9urm2fRMA9QTGrteJSwhdT6Xt8K38sa1fKya/z3wi2fqHe6i476wsCh9VX9wD5nGQCzJU9UnyKL5kY5aRgYl8kCQDrTEYVM0ro+aJ7TDvS7hASZUjWkCsNjz/bjOBhPKgxaCmy3Dn12Xkz8+0HkPYeZpXDlj5SmJbcyfrlulQ0CguLcsXVsTvPIOlC2bkT26kuadyfsajks6U/X9khQf97gMF3F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(38100700002)(478600001)(2906002)(6512007)(6506007)(316002)(66476007)(66946007)(66556008)(6916009)(4326008)(41300700001)(5660300002)(8936002)(8676002)(83380400001)(53546011)(1076003)(26005)(2616005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtTVktJMGZkN0JjSHBOOHQvNExIdFo5M0ZTcmpkdjcyRkNvZTBkVnpoYmJX?=
 =?utf-8?B?d3oxK2hHalBqVTJCdGFTY1BDQU1pdXpGQlhHdUI3WVYwaUtDSWtXdEJMbUlE?=
 =?utf-8?B?czFsN0FHVFpmbmxJZy9XS1RjMi9hRENLZlRYSWxlVFRuZ2hCbkkrNG5xZUl6?=
 =?utf-8?B?OGlld2lMaWtBMlVWS2ZqeHJnYlI0QjZEb2srWWoyYjBzK1lXdHM3VlFFTWUx?=
 =?utf-8?B?bVFoNXJBRVpxeTMrYlVyTVZuUHRGbU1DWm5mclZ5YTBJaGUwaTBFc3FmblJR?=
 =?utf-8?B?cHhTRkZmZDY4Uk1oL210b04vVjR1R3Q5Um1OZ1ZMZTc4QkcyMVRTWmdhbjBl?=
 =?utf-8?B?MFRCL2VFOXZzbHZ2SjllVEdDSmJJaWxwK2JCMGtkc2JOU0xOeTUycmd3REkv?=
 =?utf-8?B?V3dLWUl1Wjh2YzYvRE1WbjNJdXlmR0U2anFHdTMxS0RISGt1R3hRRjJpOEIz?=
 =?utf-8?B?MlZwdDRDZ2Y1NGhmaDhXc1d3S0VsVTI2Q1hDcTYvT1BOZkR3RjNGOU8zYmFN?=
 =?utf-8?B?QTV2TDdrcUNJTDdZZjc5dCtCb0FYejZXaWhtTWliaXFNNXd5N0RoRitDQm0w?=
 =?utf-8?B?SGFRSEs3N2x2NkJyMFJLREsvekRDcURNSDdnbXlBTWdYcXMyZVN3NFV3UzY0?=
 =?utf-8?B?QTVKdHJ5RmxqR29kU0R6d3FTSnVBZytiUGdOcmxLbm9LNGpxRy82aDNleEpx?=
 =?utf-8?B?azhEbGtGRDZxaXR2OHBQclUrVVJnRHQ1T0hyeTRiVk9DVzlSejRoWllLaXRC?=
 =?utf-8?B?MGRCK2xmeVdkN3AxM0JHRUlCWHZWYXVyYWNSQS9GdVRpVkpKbTZsNzNtcUw2?=
 =?utf-8?B?cnJwbFYrY3pvL293bVJrMFR1cWtoUUVMT3J4YXJmTjVrL3BpY05OOTRMOHFC?=
 =?utf-8?B?dVE0cGFuT09HYVFKWm8wK2dzZ0t3UHVMbVZnQ2VIbVNURDFLemRiV1k1QVY5?=
 =?utf-8?B?eUpKazFZaVdmeDBBay9wNEJBdXFqNllJQnRQZTlrMHQ2T0JJUExoQVZxYVB1?=
 =?utf-8?B?b1pOWFIrVFIwT1orUDlML3FXUlQ5NStGMUpvMUJObzhYSXFLVnpaSlNIMHpn?=
 =?utf-8?B?QkxtREVtNUhod3hPbDI1bk1MSU1tRnZxMFUxZG16OEZwazdycUh2bmF1b2NY?=
 =?utf-8?B?Y0VnMWhkSTYzZXRUNVhTL1JRamdiMkxKT056SEViRUd2M21zQ0o4S0J5OFk5?=
 =?utf-8?B?Zk1MSmFxVUZQdE1BMEorOHh3VU1zZXhMRit5ZFloWUFRN0t4RWYzeFlIZjFi?=
 =?utf-8?B?M1YycEc0VWdpeDExMjhlZ05lRGdSWE1JR0JEdnNjR05ET1R6T1VuL2xPWGtY?=
 =?utf-8?B?b3pqbXJUbmUzL1VLdmE2aWZiV21PcmtpOU9ESEFDZExvR1N0cU85eExKSnkv?=
 =?utf-8?B?Y3FqWVh4TVpHVkJOdGQwaytxclVCUkU5V05pOHJpZUFWN1VuTHI5cVFuQ0Q1?=
 =?utf-8?B?U1BDNlM5WE1IZWxhYk9jTlFKY1FWTjVhZGZDNjg5dUdmMTNjamVCKzM0YUdl?=
 =?utf-8?B?NDQ5S0lXRVdzZFR0K2dGSHhoTGF4K2liUkgxeVhHT0JOUFRkUmVwd0EzLzVp?=
 =?utf-8?B?d29lZStTTDFSVzlmbmhXQ2c3TFJjSVExUVRzREtQdU11VWxvVi83NTNJSnFs?=
 =?utf-8?B?OXlIM1dCOThvU21pSGQvT2lsZ3RMdEw0cVFmUWpDc1lkWDBjdXdwRmxVblE1?=
 =?utf-8?B?OFJZQmVvUUhObFVMbGJLaWluenEyYmFVQWt5UGRBZVNWcjhETXBtdzhoWEFF?=
 =?utf-8?B?L0lIOGtDb3JyLzJZNzB3UGZaV2dVWndrSEdqcXFHei9iR1ArY0xiYVZWWnc5?=
 =?utf-8?B?VXhVbDdQVkRTaHpVbms4by9LQ1R5ZXhEQ3FjaTB1Ty9XekVKZGRISFVHdWtk?=
 =?utf-8?B?S3ovSnVSb0cxOW9POFFDTWdMUzg1ejgzRzl5WVNkTU51RFZyOVVwZW0wcU8r?=
 =?utf-8?B?MFNyeVF5RGYyRDZhUWxGbW14dnM0dWZ2aDBEYXNEUEYxZGtFUVBzUWtvWmJL?=
 =?utf-8?B?dWZ5RG1ibzkrZnlneGJnU3VXZ1hCV1d2Nnh0VGhGZDIxOXk2RmNGM1hXUGFU?=
 =?utf-8?B?a3ZDYjY1ckpETktESjU1L1JVem1iRGxxNTRSdDcyazArMnFVc1BHOXRtdkhM?=
 =?utf-8?Q?GIkxmIN/MZhdcmxQP/klp2Jfl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05db1052-fc78-497f-db43-08dbce4b95da
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:27:03.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaq00KSPaMB3Crb0FeP/8W70uunlq+eeqmhLELVY4WeoONVRrmVksT263+9OoH6F+uVJCzjCgsd8rqmoQTpabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9115
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, October 13, 2023 8:30 PM
> To: Claudia Cristina Draghicescu <claudia.rosu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Iulia Tanasescu
> <iulia.tanasescu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ 1/2] bap: Fix source+sink endpoint
> registration
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> Hi Claudia,
> 
> On Fri, Oct 13, 2023 at 3:06 AM Claudia Draghicescu <claudia.rosu@nxp.com>
> wrote:
> >
> > Create new endpoint name for the simulated broadcast sink that is
> > created when registering a broadcast source endpoint.
> > This removes the ambiguity when having registered a local broadcast
> > sink and fixes the situation when multiple remote endpoints are
> > created when discovering a broadcast source.
> >
> > ---
> >  src/shared/bap.c | 54
> > +++++++++++++++++++++++++++---------------------
> >  src/shared/bap.h |  1 +
> >  2 files changed, 32 insertions(+), 23 deletions(-)
> >
> > diff --git a/src/shared/bap.c b/src/shared/bap.c index
> > 925501c48..266116235 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -644,7 +644,7 @@ static struct bt_bap_endpoint
> *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
> >         if (type == BT_BAP_BCAST_SINK)
> >                 ep->dir = BT_BAP_BCAST_SOURCE;
> >         else
> > -               ep->dir = BT_BAP_BCAST_SINK;
> > +               ep->dir = BT_BAP_SIMULATED_BCAST_SINK;
> >
> >         return ep;
> >  }
> > @@ -1500,12 +1500,12 @@ static void ep_config_cb(struct bt_bap_stream
> *stream, int err)
> >                 return;
> >
> >         if (bt_bap_stream_get_type(stream) ==
> BT_BAP_STREAM_TYPE_BCAST) {
> > -               if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
> > +               if (bt_bap_stream_io_dir(stream) ==
> > + BT_BAP_SIMULATED_BCAST_SINK)
> >                         stream_set_state_broadcast(stream,
> > -                                               BT_BAP_STREAM_STATE_QOS);
> > +                               BT_BAP_STREAM_STATE_QOS);
> >                 else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
> >                         stream_set_state_broadcast(stream,
> > -                                               BT_BAP_STREAM_STATE_CONFIG);
> > +                               BT_BAP_STREAM_STATE_CONFIG);
> >                 return;
> >         }
> >
> > @@ -2710,15 +2710,15 @@ struct bt_bap_pac
> *bt_bap_add_vendor_pac(struct gatt_db *db,
> >                 break;
> >         case BT_BAP_BCAST_SOURCE:
> >                 bap_add_broadcast_source(pac);
> > -               if (queue_isempty(bdb->broadcast_sinks)) {
> > -                       /* When adding a local broadcast source, add also a
> > -                        * local broadcast sink
> > -                        */
> > -                       pac_broadcast_sink = bap_pac_new(bdb, name,
> > -                                       BT_BAP_BCAST_SINK, &codec, qos,
> > -                                       data, metadata);
> > -                       bap_add_broadcast_sink(pac_broadcast_sink);
> > -               }
> > +               /* When adding a local broadcast source, add also a
> > +                * local broadcast sink
> > +                */
> > +               pac_broadcast_sink = bap_pac_new(bdb, name,
> > +                       BT_BAP_SIMULATED_BCAST_SINK, &codec, qos,
> > +                       data, metadata);
> 
> I'm not really sure why this is needed to begin with, if that is to have a
> remote endpoint I'd say we need to change the logic so broadcast src role is
> allowed to create streams without a remote endpoint, anyway we should
> probably have better documentation around this logic.

I agree that a broadcast source should be allowed to create an endpoint without
a remote pac. We can try this approach and submit a new patch. 
Just to be sure, when you say "remote endpoint" do you mean the remote pac or 
other bap ep structure?
> 
> > +               bap_add_broadcast_sink(pac_broadcast_sink);
> > +               queue_foreach(sessions, notify_session_pac_added,
> pac_broadcast_sink);
> > +               return pac;
> >                 break;
> >         case BT_BAP_BCAST_SINK:
> >                 bap_add_broadcast_sink(pac); @@ -4457,13 +4457,23 @@
> > static void bap_foreach_pac(struct queue *l, struct queue *r,
> >                 for (er = queue_get_entries(r); er; er = er->next) {
> >                         struct bt_bap_pac *rpac = er->data;
> >
> > +                       if ((lpac->type == BT_BAP_BCAST_SOURCE)
> > +                               && (rpac->type != BT_BAP_SIMULATED_BCAST_SINK))
> > +                               continue;
> > +                       if ((rpac->type == BT_BAP_SIMULATED_BCAST_SINK)
> > +                               && (lpac->type == BT_BAP_BCAST_SOURCE)) {
> > +                               func(lpac, rpac, user_data);
> > +                               return;
> > +                       }
> > +
> >                         /* Skip checking codec for bcast source,
> >                          * it will be checked when BASE info are received
> >                          */
> >                         if ((rpac->type != BT_BAP_BCAST_SOURCE) &&
> >                                 (!bap_codec_equal(&lpac->codec, &rpac->codec)))
> >                                 continue;
> > -
> > +                       if (rpac->type == BT_BAP_SIMULATED_BCAST_SINK)
> > +                               continue;
> >                         if (!func(lpac, rpac, user_data))
> >                                 return;
> >                 }
> > @@ -4484,12 +4494,6 @@ void bt_bap_foreach_pac(struct bt_bap *bap,
> uint8_t type,
> >                 return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
> >                                                            func, user_data);
> >         case BT_BAP_BCAST_SOURCE:
> > -               if (queue_isempty(bap->rdb->broadcast_sources)
> > -                       && queue_isempty(bap->rdb->broadcast_sinks))
> > -                       return bap_foreach_pac(bap->ldb->broadcast_sources,
> > -                                       bap->ldb->broadcast_sinks,
> > -                                       func, user_data);
> > -
> >                 return bap_foreach_pac(bap->ldb->broadcast_sinks,
> >                                         bap->rdb->broadcast_sources,
> >                                         func, user_data); @@ -4497,6
> > +4501,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
> >                 return bap_foreach_pac(bap->ldb->broadcast_sinks,
> >                                         bap->rdb->broadcast_sources,
> >                                         func, user_data);
> > +       case BT_BAP_SIMULATED_BCAST_SINK:
> > +               return bap_foreach_pac(bap->ldb->broadcast_sources,
> > +                                       bap->ldb->broadcast_sinks,
> > +                                       func, user_data);
> >         }
> >  }
> >
> > @@ -4927,12 +4935,12 @@ unsigned int bt_bap_stream_enable(struct
> bt_bap_stream *stream,
> >                 queue_foreach(stream->links, bap_stream_enable_link,
> metadata);
> >                 break;
> >         case BT_BAP_STREAM_TYPE_BCAST:
> > -               if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
> > +               if (bt_bap_stream_io_dir(stream) ==
> > + BT_BAP_SIMULATED_BCAST_SINK)
> >                         stream_set_state_broadcast(stream,
> > -                                               BT_BAP_STREAM_STATE_CONFIG);
> > +                               BT_BAP_STREAM_STATE_CONFIG);
> >                 else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
> >                         stream_set_state_broadcast(stream,
> > -                                               BT_BAP_STREAM_STATE_STREAMING);
> > +                                BT_BAP_STREAM_STATE_STREAMING);
> >
> >                 return 1;
> >         }
> > diff --git a/src/shared/bap.h b/src/shared/bap.h index
> > ebe4dbf7d..af3b6be71 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -19,6 +19,7 @@
> >  #define        BT_BAP_SOURCE                   0x02
> >  #define        BT_BAP_BCAST_SOURCE             0x03
> >  #define        BT_BAP_BCAST_SINK               0x04
> > +#define BT_BAP_SIMULATED_BCAST_SINK    0x05
> >
> >  #define BT_BAP_STREAM_TYPE_UCAST       0x01
> >  #define        BT_BAP_STREAM_TYPE_BCAST        0x02
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Claudia
