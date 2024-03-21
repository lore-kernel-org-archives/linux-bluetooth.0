Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A77E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020847; cv=fail; b=OEssYw9Op9LcjeXwqfKGW4HLb8USDJcFrmvsv4ZyQbwM4d06qnkRTHWKFwk/JPZWMPpsaeSMmjsbqs99uQMtuzFxALsmpYYXLc2sOhzRLD1+fCMcMWlcz9RJrfUD40Qi+Z4rncMzrHsPuzJ+TT5fcMF32BkeU73uj3P3u2QF8t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020847; c=relaxed/simple;
	bh=O+QGCGyD5KElbphaNzopM3X4CjdxFp+T2IwQGbYM+/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Is1GcrSdH93l31O9LOQGUs2jk7pDSFJFzP88bI4LMBWO2k6GsyyCswkqVXjn7Ylvzz3C/cKcUhP7UTuuQtTjBl0XZKuzPoYWyO8PPR2bTNvG8mLmXtxPBY/i5ym+oGCG6boo0DUH8sEZ0BNGbcqTDptFp2vfQqaetj/anGwwJos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pK1fyAYb; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pK1fyAYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsOz0sXLWK/0eEQgYatP6Y2HVE54iE/b5wEsq8sKXHD8JlyjOkmM9mU8dLmGCc/gFoBGXXYbYmSvq6/4TZtN2Ffn32ErWaHxOk7l4DTzJLaArz0S0Z1czdT8/+x8quYw/cB6ebZIdTK6JJeP5SGCc2hf1lvmytgQ1bTMffy+g8fR1bnw0sVBYMd4a7tOowwLSmd/h69sy6ni52IrciiLZFG/jmy7LfzpM0K8GwH0RF363KCAAdnRjcqTCHWwn9EsT2+bN19tiXXsBnRkuOBY+Km8r9LAbQqK2q+8v7RsSwSf1bnj9bWk5BvvcvcBVqRQZ7MJGvY10WGhHVpt8K3ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrlrMHBc5vPjb+ktwT2KjDm+0kO7LrdnmLMrtKrFdbQ=;
 b=YZVip1KrEPxf5KWdq97x3FdXI1eFcXQit7I4G8fGKaoIYdZ6gBqrhBS3uijQqd5vBThVLrH5V+u4wGEJZOSCOp9DMv/FwC1ICqXNQCxAm2JPVEM5vuqfeWTQ3MbCAj/ffcKB8oJtkUl79nj8vbE3vAqVjhy8PE5/glGk+OYW78QXdcn0aTsEbVOB+EyJ3O9l9QXmeOUVm8vn7sKzIqC4dxJjku5aYKynolem4b+P/DkP8WrLeDpvazwghycZoC1Y4PPSj7STYyAwMQkPIrKCU+eoukB6Cfy7IozdweOph3906zVmbmngV1MWPu4eMaAmmTjGG6Sy3M0XMoTFsawaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrlrMHBc5vPjb+ktwT2KjDm+0kO7LrdnmLMrtKrFdbQ=;
 b=pK1fyAYboznQIggn8kGYUTFAQ1KlMdqb5TMt27RlL9QKGzb4y2vnwzPoj+m+f/inQBSiFarW00bBact/bF2Ovkd948srmoA6RA1W80Sb+OC96xqUnspnWPGd3tFMwe241xQv/7O848J/o2sU3sQ2c3NEGNwVpcMLwkHVlnpE13I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Thu, 21 Mar
 2024 11:34:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 11:34:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/2] player: Allow endpoint config without local endpoint argument
Date: Thu, 21 Mar 2024 13:33:59 +0200
Message-Id: <20240321113359.12475-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZL-JFqb5wq-k4Ge2zOVPf71E3pVsnu5X-h4LOy1tziNCQ@mail.gmail.com>
References: <CABBYNZL-JFqb5wq-k4Ge2zOVPf71E3pVsnu5X-h4LOy1tziNCQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 4490472c-c38a-4381-3ec4-08dc499ace32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	55TVrWUYoCmWIgmJRpQZG+sRbA1SAnTZi/xf/+LzDdVdBfHYVm/8sg+bkAjtnp7axe7jPGxjF9IR+bIkH7HMJsz9OtRsMXaIF2H26+sRJdgJrNhGLOr4ooHjQ14vRATLJsb+m/Yzh2DAZET6CrWmutfldk+hEQk98Ul8jW4MJRqRCS2mKoYKQHmUhE+X6Pbx3oNN+obwFwp3BK5ScGGLZlxk3VynGk0g2hI3hEspkQAJiwVgC5Z6tncU8N5kb3o4RZnu4r9591x6/pHwQuP+N+psmLddJtstSo2aAKBpEKKDXJjBPPNT4nFXqiRYbBlTE3DRXswtoMmTLbUFBNR8wIhL4/yKM1KTXquhf19EFOjGlEy3O26VGHDOThEL1RBdt+X4p2JdkdVRP/8kITUdb+SAus+ucf2WAyP8RhbLE0AjD4GfRjBx3CeNfX8yU5aGiyEpRK6x3J64xA5snUbPnn2Mh7XjhMRS2HoFb98RPaOJfyxR/ltf52mgNZ/1l2Q8cweszelQArtL7TBb6p9qoRxxCRr8neMQz6C6d/yi7hfZJx25fdEVQY93/808LDjgzvLa6NNWddIjmFZsR4l8aZsttNlEtcdMdtOoPLxzuBtgXP2XzvNLrvdBQ0R9i2oNw4htvGkFDC6pYLU3Z/mStN2rEuWLFtdZAc07GWYd9uo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vx8ZdDgzfsU51+pjorlIzf9ut4A1BeLv8n8KVTaZLYj5DXk3NIm18HF9mjCk?=
 =?us-ascii?Q?PGe4sIamiqFH7FDtHoQHHhf2Cm8Mto/F+bRCCwCrvRkF7/1sdnNfCgd4T3V8?=
 =?us-ascii?Q?+U82De7AiCeWR9SI+ThEg7oxaCue9czo0a2A6vHHGK49BEiVK21IVsVDMxdE?=
 =?us-ascii?Q?l4nHETpjgqPy86wH6kkJtZxRSOm+WFNRDG0GHEZSr3NVpAiXyNdkRzRloINY?=
 =?us-ascii?Q?UZoiO4L5/SHLTNVy4v5mCsTxCZg+Qx41ydDD11MNVHZdAnq+g3TJyUTwUAjn?=
 =?us-ascii?Q?0+0JfsMfLm/VeaMAViCbVE2vKZEPATZGjPlIuvBpzyaEQLXNBmi5HbwANeQj?=
 =?us-ascii?Q?ibmr1lh8HLztvjsRGPRUBYVgXyQx248gSre0gppXsRAdVP01XsJXXR6qUFoa?=
 =?us-ascii?Q?M1CCxn0a7nhWYquJ0psmjf9hc9wm39hadszd+jKrV1ffPOHH0TjsXec6AZ1A?=
 =?us-ascii?Q?Ujz2GqTUUUSVKoUtqqNGeRQDnvQHUDJCGcoVm8DOY+s67iVtmmb+d813pSGo?=
 =?us-ascii?Q?DPPSlieiiffotP5dtHmC3wvxEIIKP6HVXdkLpSBbQMv/KBK2ubJv/Jl6p6GY?=
 =?us-ascii?Q?eE5PnyHni4V8qUBhBtwEpBpQ/pRarg54uvRnMPEeoGTeiTxCAjZV0eY6Syof?=
 =?us-ascii?Q?6LT/r6pLrcXbGyk7jrG96hhlDWiCc7nA8qLCZ3GzQa/f4DKaa6b9tDpkSZIB?=
 =?us-ascii?Q?LUao7Xw+1D7/qm04ENqWZKuJDAwUxn5i3fdp/v26Ln3lP2OVXoF6xqfMR8D6?=
 =?us-ascii?Q?Nf0LIElf3/wNE/EItpemJ82ICMyOdA/KGPXQ5PlmLARN0Gq73x5mfBoLXYAm?=
 =?us-ascii?Q?3QpYIXpMOyv2uicHKFq5phorBy0FKBeUfi7Fb8Oto4KMzX0OfuYbkuAWz863?=
 =?us-ascii?Q?7Ia7EKmOse3memMm5MCf9Mf5j7BqHiVTESpxKqk9pMZWo1qi8f4fV/uVOmWW?=
 =?us-ascii?Q?i9mEnn5mRzTo/O87wRW+cTIBIDGIP8SOF6aWstj4Nn7Vn7KyYwRkzADpPDss?=
 =?us-ascii?Q?24UV7Zy6P9LnHiewiIVmGfKXRpVZAcc1gKINUweocGVgbroM2sl1pyzunE8f?=
 =?us-ascii?Q?o+neJNywLg0gf79wlXTZLcCaAjn0GMccqLjoWn2FqmJN8BdhVfTnQKJLFcoj?=
 =?us-ascii?Q?w0h1heYtGrMIHj+XtrqBI6g3JAQLC+iLfoghdW/tjavIifif5ZDVkz043cxV?=
 =?us-ascii?Q?GOw6hgcw2iF2te/v8NH1zqqMZlrpvictKMIaRW6BbzhltYmvGt9Y8HNrsiVz?=
 =?us-ascii?Q?OBRkj/7Xu2alrPSOim/VYIR7J0iV2FtzjmCwIOTHLqiV6vQE5/w00bsGH7O4?=
 =?us-ascii?Q?gYA8oUpiq042MX6d+Bz0MlG7X7MrAkUBY7YG4WgdPQxwXVocDjYLHJQlqano?=
 =?us-ascii?Q?hLMPykVEObELxXA10Y34CzgX9i0Zn1Ls5GvazZ6tj0gKdh4YC88xHORAtEBL?=
 =?us-ascii?Q?E/jdpsKHEAn0pJnviHC7ir6Yfk5U1p0cmT4Yee9L8qFO22S9oYzvFUlWP9D9?=
 =?us-ascii?Q?nV8VnguexoNVWudIhCfOcHLyXgmNlvjlkR/4ATrWABKjUVQcgk0aiFiCx5Dz?=
 =?us-ascii?Q?cdP0PXvRLSd/x4KSBYe61TeBta6LgIl4WLQluXLP0BhZ1SQi28pX6aMTcw5L?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4490472c-c38a-4381-3ec4-08dc499ace32
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 11:34:01.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi/ftypgTRCZ3MfTLzsvYaCQPjRxj5gDOrXwPeGSXnrnGi11+N4GfCjhWQroCie9Dv9vCrgZH+H9oy7CyjDy7J/kknjv2Gg6ZRA1pg+P39M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573

Hi Luiz, 

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, March 20, 2024 7:33 PM
> To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>; Andrei
> Istodorescu <andrei.istodorescu@nxp.com>; Iulia Tanasescu
> <iulia.tanasescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ 2/2] player: Allow endpoint config without local
> endpoint argument
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report this
> email' button
> 
> 
> Hi Silviu,
> 
> On Wed, Mar 20, 2024 at 2:42PM Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com> wrote:
> >
> > Update endpoint config command to create local endpoint for broadcast
> > endpoint, this will be used to configure a broadcast source\sink if
> > register endpoint is done from another application like PipeWire
> 
> Sorry but will not gona fly, we don't have any business with endpoints from
> other process in the system, in fact we might actually make it strictly prohibit
> for third-party process to use SetConfiguration with endpoint that do not belong
> their own D-Bus connection, same for MediaTransport, they shall only be
> acquired by the process that created them.
> 
> Also I remember quite clearly stating that we would move away from using
> MediaEndpoint for Broadcast Sink, instead what we shall be doing is
> enumerating BIS as MediaTransport directly so the likes of pipewire can Acquire
> them directly without doing any configuration since they are already configured
> over the air. Broadcast source will probably require a special interface at
> pipewire side, or perhaps a dedicated card which gets configured via some
> configuration file, etc, but we shall not depend on bluetoothctl to configured it,
> that will just make things more complicated than really helping.
> 

We are investigating a solution with the broadcast source configuration
from PipeWire and also removing the MediaEndpoint reliance for the broadcast sink.

> > ---
> >  client/player.c | 80
> > +++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 77 insertions(+), 3 deletions(-)
> >
> > diff --git a/client/player.c b/client/player.c index
> > ab33bfc46..b02a40423 100644
> > --- a/client/player.c
> > +++ b/client/player.c
> > @@ -3662,10 +3662,15 @@ static void endpoint_set_config_bcast(struct
> endpoint_config *cfg)
> >                 config_endpoint_iso_group, cfg);  }
> >
> > +static void endpoint_init_defaults(struct endpoint *ep);
> >  static void cmd_config_endpoint(int argc, char *argv[])  {
> > +       DBusMessageIter iter;
> >         struct endpoint_config *cfg;
> > -       const struct codec_preset *preset;
> > +       const struct codec_preset *preset = NULL;
> > +       const struct capabilities *cap;
> > +       uint8_t codec;
> > +       const char *uuid;
> >
> >         cfg = new0(struct endpoint_config, 1);
> >
> > @@ -3680,8 +3685,75 @@ static void cmd_config_endpoint(int argc, char
> *argv[])
> >         /* Search for the local endpoint */
> >         cfg->ep = endpoint_find(argv[2]);
> >         if (!cfg->ep) {
> > -               bt_shell_printf("Local Endpoint %s not found\n", argv[2]);
> > -               goto fail;
> > +               /* If argc != 3 then argv[2] should be the
> > +                * local endpoint. Return error.
> > +                */
> > +               if (argc != 3) {
> > +                       bt_shell_printf("Local Endpoint %s not found\n",
> > +                                       argv[2]);
> > +                       goto fail;
> > +               }
> > +
> > +               /* If local endpoint is not found verify if this is a
> > +                * broadcast remote endpoint because this can be an
> > +                * endpoint config command with remote endpoint and
> > +                * preset. In this case we have to create its own
> > +                * local endpoint.
> > +                */
> > +               if (!g_dbus_proxy_get_property(cfg->proxy, "UUID", &iter))
> > +                       return;
> > +               dbus_message_iter_get_basic(&iter, &uuid);
> > +
> > +               /* The local endpoint must have the UUID of local pac but
> > +                * the remote endpoint has the UUID of the remote pac, so
> > +                * based on this information we determine the UUID for the
> > +                * local endpoint.
> > +                */
> > +               if (!strcmp(uuid, BAA_SERVICE_UUID))
> > +                       uuid = BCAA_SERVICE_UUID;
> > +               else if (!strcmp(uuid, BCAA_SERVICE_UUID))
> > +                       uuid = BAA_SERVICE_UUID;
> > +               else {
> > +                       /* This should be a local endpoint because is not
> > +                        * a broadcast endpoint.
> > +                        */
> > +                       bt_shell_printf("Local Endpoint %s not found\n",
> > +                                       argv[2]);
> > +                       goto fail;
> > +               }
> > +
> > +               if (!g_dbus_proxy_get_property(cfg->proxy, "Codec", &iter))
> > +                       return;
> > +
> > +               dbus_message_iter_get_basic(&iter, &codec);
> > +
> > +               /* Verify if the local endpoint already exists */
> > +               cfg->ep = endpoint_find(uuid);
> > +               if ((!cfg->ep) || (cfg->ep->codec != codec)) {
> > +                       /* Get capabilities to create the local endpoint */
> > +                       cap = find_capabilities(uuid, codec);
> > +                       if (!cap) {
> > +                               bt_shell_printf(
> > +                                       "Capabilities not found for UUID %s, codec id %d",
> > +                                       uuid, codec);
> > +                               goto fail;
> > +                       }
> > +
> > +                       cfg->ep = endpoint_new(cap);
> > +                       endpoint_init_defaults(cfg->ep);
> > +               }
> > +
> > +               /* Verify if argv[2] parameter is a valid preset */
> > +               preset = preset_find_name(cfg->ep->preset, argv[2]);
> > +               if (!preset) {
> > +                       bt_shell_printf("Preset %s not found\n",
> > +                               argv[2]);
> > +                       /* Free created endpoint */
> > +                       local_endpoints = g_list_remove(local_endpoints,
> > +                                               cfg->ep);
> > +                       endpoint_free(cfg->ep);
> > +                       goto fail;
> > +               }
> >         }
> >
> >         if (argc > 3) {
> > @@ -3690,7 +3762,9 @@ static void cmd_config_endpoint(int argc, char
> *argv[])
> >                         bt_shell_printf("Preset %s not found\n", argv[3]);
> >                         goto fail;
> >                 }
> > +       }
> >
> > +       if (preset) {
> >                 cfg->caps = g_new0(struct iovec, 1);
> >                 /* Copy capabilities */
> >                 util_iov_append(cfg->caps, preset->data.iov_base,
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

