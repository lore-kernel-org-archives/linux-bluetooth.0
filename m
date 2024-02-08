Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504F6BFD8
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391557; cv=fail; b=C9T/5daBiqeC9b2o7/UVL35Sq9+rLUUKBXBy499Rjk15bzOFY6FRylgL6qWrQaRDiaHUzm09CiGgckoBwtxaoIruZwM1oU7gqJ17w2joO6lpyA6IJUhzGa6SHw/seXX476nfbxfsEvVYmh1wqa3ZvQJTMlJpFCkR2YIWe2JjqDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391557; c=relaxed/simple;
	bh=xeg1ujEWD/HdAldQpwbLIrYHa5ACJB2xQuRkH6Gt4sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLKLrY/jajGAb5tOCouhKaBfbNwbc0JxSD446+nsCN9s6CEs5xSG1r7L3mEM2isYY4LTRUubVvZ8yd1MMYldmgghO13yA6ebBr+gFwmO9OD0k4HRPFVKNyEcNa0MX95FynE9Y7ATJA22KKKEK4nne1pB2jxPY74UahD8AfKmmGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pmy73BNp; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pmy73BNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYeDcRdYsinPdBoR+G4xl9DcAD4QQmKhHr5jirTwFuk47qRatCa7PhTX5eQuxpXQh2EY3QKJxoSVWdlAVfv8c8ol9eEJXbCRmicJ4AUNNK9OTSILbQixELs6yU8lRvljvqa5lSFksk1j+oUKMm6csZlQk0h6728u2s/SVN8Moax+bBDatf0d57KyE55PyZ3uaydu5qCj3avwADkzdTC9IqHbkoK1WTA8d75xknDmyoqmOJZW8Gvlr6GNAOLHohQNH/FTgfLIcOB7KlnOC15RY77Gc8EYP2MRzwI11WhPfVyWVrTgx5iHuDe8otLx3EvCAeLkAo6p2ZhBVgra9fTDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWSiUTxQogKyQJpHrFKpT4GoDMamPNd0LNXxR/P/77k=;
 b=hUV5JGmWsjf76onx7cwtBjIQ7Cd56TK5Il/+QUO5zHG3XCgmYgF3aDRcHlDzfKo0gKo3YTTCdaE3+ppCVIbBYZIsjEc46+Cdt4CHGkCGac28qxOjyflqTfaDHHA8BmAa4SSGL/VQpBvjoBSwVrgVxO8pi+jcwjSRWPBzc7WGZKcFIUpQV7RqYJZzwgdRCdR55CM0m7lU2hbqZPw4tUiH99lWOU1FT8bczHIMYgQqVfhNb4HGAbDTtoUq10KDSGXiU9FLiukN9VGGYnZfbdVvc9ReGpXf9txU5mMzXWZ0xtFd4kTFWDydoTsYYkqX4VwCJixVKZnJVbDqEADafxrWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWSiUTxQogKyQJpHrFKpT4GoDMamPNd0LNXxR/P/77k=;
 b=Pmy73BNpVpDXuFzBoDM0o2GiTNKDAJyXkxKSTCv0yV38VcuUezlpIRsKkK6HFzy/Su2+HZNoepfpTCdd0VoO0DnpFQi61jg9zuGuF6vJP5Bs3i2WUil505iy51anKeNtrhKHYoDa8tgQQUxX0Rd6U+CEewtYE0KIlyvEU7Z2DHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB9PR04MB9843.eurprd04.prod.outlook.com (2603:10a6:10:4c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 11:25:51 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 11:25:51 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Thu,  8 Feb 2024 13:25:49 +0200
Message-Id: <20240208112549.7432-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABBYNZJ9VQL+bvx1=0EaPV0WJS_jLnP=3-gwTLr3rvqhSbN9iA@mail.gmail.com>
References: <CABBYNZJ9VQL+bvx1=0EaPV0WJS_jLnP=3-gwTLr3rvqhSbN9iA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB9PR04MB9843:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bd14eb-0949-4d18-d5b9-08dc2898b4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZTzY29T8kbPBEymDmfK1ZtsOXTrUAG8bYxhOYp5Xxhu8aAO4hMshP8JG02EJUW8X88TFWFjuasERscCMJ78OT/FYs3dYdN4CFsCq9KwrIacSY0wSsPvs5ZkZnoETx6gILbu7xxkv8Sh5PQl7VSVhHX7DwYhLzKEOHHbOoELw/CEnqo7DTih615EvKBpoGvzEFw4A9h1qSeGfcgBwSOqJVA7VAmeBLBw87dh1RatX8qKuzTMQ5d2nHdiqte74XsGHaL2OeiJooi4neED5Kp4k4wJhjdBE0+Pc0FlMwSEbt3s0YWW4DXpD49MkX4Yb/wNXIrxN1FSAGNjA2OodeZMFaaY+nlTb3c+/Ks3EXCD4qf4q9v/SHaJUGY5ux8DKO5XkR87uM3HNFpyF4Defh8dq/CvQ+gboY0MW01oVNijWlrymT2OOlz308FHgmrDv4RT7oW6kvOQiZ62UbQPVphYe6ibGi3hy6tbVSs5ARqt+Ny8NYPbc4c/I/Kll4qWtn2zFAgq1UHP51b8I0/wHQKBMFkdQSfR/MNs1RtG+ZVg06ZmFgtfdWPY681GJl6X2RATv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8676002)(8936002)(4326008)(44832011)(41300700001)(66899024)(38100700002)(36756003)(2906002)(66946007)(2616005)(66476007)(30864003)(316002)(66556008)(5660300002)(6916009)(86362001)(6506007)(478600001)(53546011)(6512007)(6486002)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lzjPph72QnDlseARPrRFpz457JFsCaEJXZ7z8tg4OcZ+Kn9bZ63vvljJ9NX1?=
 =?us-ascii?Q?5FunfH4dj+nLKivZ9rn5nDBKoNWd9fcVAG6ds1u9wuQMiKhVfafFWVv4Knnz?=
 =?us-ascii?Q?sETOOAiM8epFAMcI8y7s1vpWiyi5W/lzc4LLGPP/20Cx+y4JrD2n3hftw/J3?=
 =?us-ascii?Q?q0qg2bp8mQSoSOhv1sSi3TqRLTUM71rSOF4ffX8g6h0RaQV18x81dH5eH2Dp?=
 =?us-ascii?Q?nMT4nGcIz0UwKfbyW+MTTdsHa7y+EtuTghjVioezF937YIY3Ri2iia6IFUDT?=
 =?us-ascii?Q?N7e7kqN51Hk7SHFiYWpEIPPgSrWYTOhvy/9oXxvHQ/ZtzsVYQtVqr3OQn7Yd?=
 =?us-ascii?Q?ui9PMBHNgcH94fcbZPuckjKujIeBTrAdr9dMCX4L9rNnzvHZXPC+ic9Ee1//?=
 =?us-ascii?Q?08Ooh7GxuYsnyOk70MeFS0cI1/SumsuOWg7Z+SeXsnFEb7dQmTvttWtyaywm?=
 =?us-ascii?Q?oRWRkZm7hYSL/QGuaPKQqiWXQ07Gcix859gV6sz4cQtoSrgPpQU6Mk6v/DF2?=
 =?us-ascii?Q?EvmjeKGMx7zm+OLNJF94zbKhVMo95Vs17cozIyxPZUz9hIq7uL/DeGabdHFM?=
 =?us-ascii?Q?awHn3lyBzCKbt8m9M3AmJ8nZzRJ0oV040gDGtaOWivKcGnj+Tj+inVGft9AY?=
 =?us-ascii?Q?78BKLix4RnVH8fxuS84Fe0IH8sdSDnlAB8nTscNfoTdhHKUi910kyle6pHWL?=
 =?us-ascii?Q?w45IKQ/3vKSdppOhnHbf72q55BxlIGU2ZdHVpPuWxBm/l6L+zkGuJVy7T7oO?=
 =?us-ascii?Q?7k9yDSgxdL2SPWGB4DOi5022v3D+FbAOrAg4aAVczzCn9dHdigyS5iTExntg?=
 =?us-ascii?Q?/Zf3T1pMevvctccRTSwwIcWDoNc/uDvZmBiAjjBGAZa2QsbvtuK7640GNvtx?=
 =?us-ascii?Q?bgcI3ch7QNMkSYl++Gt4ZW96ZAlv+6LRnXMYjETFZAiUolHbmKDcCA1QbSu9?=
 =?us-ascii?Q?C4mvkb9Hqx0NK4IhVtQN193siKL0Jl9YRrqlF2QbJF6qtOQso9dDSUbbnUjl?=
 =?us-ascii?Q?yLlbCvufg7uyHOSowksbBBi6tJdoSOcVA3CHqF1qBsmwWlpWvZU4KfcLki3W?=
 =?us-ascii?Q?o3cG6puk5VHDpuVlfuEwIU4jxpB/0dmcTTcBgNH+ulVkIJ/UIYJToBGtfgCu?=
 =?us-ascii?Q?eI1kDieIFyQK4POTl1G5SebcqMWzCmjJDdbKKFk8qsh5fUerKxcKMa/xUWm+?=
 =?us-ascii?Q?N5RAZdb8M6zxZQ6YRy+GJIVnHWSWoaIvvkJsDTjJhAPNIFUhaA8kEi14+Rb0?=
 =?us-ascii?Q?3z1frE9qSg2nA6BHGX3EDGuhTsrapioMF/I6Tednxsp38v6/e1JUquuz/7uY?=
 =?us-ascii?Q?CzeTb6VCgXBygGtMGBZVo9PeFkSHjbkF+vWqy4emV4g+BpIREwiewHBLUpkN?=
 =?us-ascii?Q?wT3N5zdOWflgXdD/AP0z3wJfEjgKYIG+njGaZ6SZrMpIQHCqQJBiJkWHIu3x?=
 =?us-ascii?Q?pKiGO+K5FNfcdx5oZOjT0lDX1sO1vD4FjEaChZeaDJuZtPc7gzGM+AJ+qdVG?=
 =?us-ascii?Q?DUunO2osSxQ5J0hXTrSjIvGJOICl3c/gqSYkJqqMcDLwDQMgRdisAHjbKihe?=
 =?us-ascii?Q?43PpfePJVVTZu1NYNrjUh4bkCLJnX4xyBlUj4T4fPjn86XhoQa2RqUzE2ATZ?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bd14eb-0949-4d18-d5b9-08dc2898b4b7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 11:25:51.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cRzIRKYUCM73dvvPsBLVtaa62GPzPg9PqlwIpgUM8pvpK5a93kX8OxYjaKk+KpUPbE2N0LYfyUxSuEF2Mb0XBWlJuoGqT/TcDEg5eYm8x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9843

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, February 7, 2024 4:42 PM
> To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broadcast
> source discovered
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> Hi Andrei,
> 
> On Wed, Feb 7, 2024 at 7:23 AM Andrei Istodorescu
> <andrei.istodorescu@nxp.com> wrote:
> >
> > After discovering a BAP Broadcast Source do a short PA sync first to
> > learn the BASE. After discovering the BASE check how many BISes are
> > matching the sink capabilities and create endpoints for them. Allow
> > user to configure one endpoint using "SetConfiguration" causing BIG
> > synchronization to the corresponding BIS; also this results in
> > creating a stream and the corresponding transport.
> > ---
> >  profiles/audio/bap.c | 324
> > +++++++++++++++----------------------------
> >  1 file changed, 110 insertions(+), 214 deletions(-)
> >
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c index
> > 88c93127bea0..8646eae2ed20 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -105,6 +105,44 @@ struct bap_data {
> >         void *user_data;
> >  };
> >
> > +/* Structure holding the parameters for periodic train and BIG
> > + * synchronization
> > + */
> > +static struct bt_iso_qos bap_sink_sync_parameters = {
> > +       .bcast = {
> > +               .big                    = BT_ISO_QOS_BIG_UNSET,
> > +               .bis                    = BT_ISO_QOS_BIS_UNSET,
> > +               /* HCI_LE_Periodic_Advertising_Create_Sync */
> > +               .options                = 0x00,
> > +               .skip                   = 0x0000,
> > +               .sync_timeout   = 0x4000,
> > +               .sync_cte_type  = 0x00,
> > +               /* HCI_LE_BIG_Create_Sync */
> > +               .encryption             = 0x00,
> > +               .bcode                  = {0x00},
> > +               .mse                    = 0x00,
> > +               .timeout                = 0x4000,
> > +               /* to remove from kernel check */
> > +               .sync_factor    = 0x07,
> > +               .packing                = 0x00,
> > +               .framing                = 0x00,
> > +               .in = {
> > +                       .interval       = 10000,
> > +                       .latency        = 10,
> > +                       .sdu            = 40,
> > +                       .phy            = 0x02,
> > +                       .rtn            = 2,
> > +               },
> > +               .out = {
> > +                       .interval       = 10000,
> > +                       .latency        = 10,
> > +                       .sdu            = 40,
> > +                       .phy            = 0x02,
> > +                       .rtn            = 2,
> > +               }
> > +       }
> > +};
> 
> This cannot be global, it needs to be stored on a per device basis so it doesn't
> get overwritten.

I will submit an update for this.

> 
> >  static struct queue *sessions;
> >
> >  static bool bap_data_set_user_data(struct bap_data *data, void
> > *user_data) @@ -422,113 +460,6 @@ static int
> parse_array(DBusMessageIter *iter, struct iovec *iov)
> >         return 0;
> >  }
> >
> > -static bool parse_base(void *data, size_t len, util_debug_func_t func,
> > -               uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
> > -               struct bt_bap_codec *codec, struct iovec **caps,
> > -               struct iovec **meta)
> > -{
> > -       struct iovec iov = {
> > -               .iov_base = data,
> > -               .iov_len = len,
> > -       };
> > -
> > -       uint8_t capsLen, metaLen;
> > -       struct iovec cc;
> > -       struct iovec metadata;
> > -
> > -       if (presDelay) {
> > -               if (!util_iov_pull_le24(&iov, presDelay))
> > -                       return false;
> > -               util_debug(func, NULL, "PresentationDelay %d", *presDelay);
> > -       }
> > -
> > -       if (numSubgroups) {
> > -               if (!util_iov_pull_u8(&iov, numSubgroups))
> > -                       return false;
> > -               util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
> > -       }
> > -
> > -       if (numBis) {
> > -               if (!util_iov_pull_u8(&iov, numBis))
> > -                       return false;
> > -               util_debug(func, NULL, "NumBis %d", *numBis);
> > -       }
> > -
> > -       if (codec) {
> > -               codec = util_iov_pull_mem(&iov, sizeof(*codec));
> > -               if (!codec)
> > -                       return false;
> > -               util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
> > -                               "Codec", codec->id, codec->cid, codec->vid);
> > -       }
> > -
> > -       if (!util_iov_pull_u8(&iov, &capsLen))
> > -               return false;
> > -       util_debug(func, NULL, "CC Len %d", capsLen);
> > -
> > -       if (!capsLen)
> > -               return false;
> > -
> > -       cc.iov_len = capsLen;
> > -       cc.iov_base = util_iov_pull_mem(&iov, capsLen);
> > -       if (!cc.iov_base)
> > -               return false;
> > -
> > -       if (caps) {
> > -               if (*caps)
> > -                       util_iov_free(*caps, 1);
> > -
> > -               *caps = util_iov_dup(&cc, 1);
> > -       }
> > -
> > -       for (int i = 0; capsLen > 1; i++) {
> > -               struct bt_ltv *ltv = util_iov_pull_mem(&cc, sizeof(*ltv));
> > -               uint8_t *caps;
> > -
> > -               if (!ltv) {
> > -                       util_debug(func, NULL, "Unable to parse %s",
> > -                                                               "Capabilities");
> > -                       return false;
> > -               }
> > -
> > -               util_debug(func, NULL, "%s #%u: len %u type %u",
> > -                                       "CC", i, ltv->len, ltv->type);
> > -
> > -               caps = util_iov_pull_mem(&cc, ltv->len - 1);
> > -               if (!caps) {
> > -                       util_debug(func, NULL, "Unable to parse %s",
> > -                                                               "CC");
> > -                       return false;
> > -               }
> > -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> > -
> > -               capsLen -= (ltv->len + 1);
> > -       }
> > -
> > -       if (!util_iov_pull_u8(&iov, &metaLen))
> > -               return false;
> > -       util_debug(func, NULL, "Metadata Len %d", metaLen);
> > -
> > -       if (!metaLen)
> > -               return false;
> > -
> > -       metadata.iov_len = metaLen;
> > -       metadata.iov_base = util_iov_pull_mem(&iov, metaLen);
> > -       if (!metadata.iov_base)
> > -               return false;
> > -
> > -       if (meta) {
> > -               if (*meta)
> > -                       util_iov_free(*meta, 1);
> > -
> > -               *meta = util_iov_dup(&metadata, 1);
> > -       }
> > -
> > -       util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
> > -
> > -       return true;
> > -}
> > -
> >  static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
> >                                 struct bt_bap_io_qos *qos)  { @@
> > -954,6 +885,17 @@ static DBusMessage
> *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >                 return btd_error_invalid_args(msg);
> >         }
> >
> > +       /* For BAP Broadcast Sink, the capabilities and metadata are coming
> > +        * from the source's BIS, which are present in the remote PAC
> > +        */
> > +       if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
> > +               util_iov_free(setup->caps, 1);
> > +               setup->caps = util_iov_dup(bt_bap_pac_get_data(ep->rpac), 1);
> > +               util_iov_free(setup->metadata, 1);
> > +               setup->metadata = util_iov_dup(
> > +                               bt_bap_pac_get_metadata(ep->rpac), 1);
> > +       }
> > +
> >         setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep-
> >rpac,
> >                                                 &setup->qos,
> > setup->caps);
> >
> > @@ -977,95 +919,27 @@ static DBusMessage
> *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >                 break;
> >         case BT_BAP_STREAM_TYPE_BCAST:
> >                 /* No message sent over the air for broadcast */
> > -               if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
> > -                       setup->msg = dbus_message_ref(msg);
> > -               else {
> > +               if (bt_bap_pac_get_type(ep->lpac) ==
> > + BT_BAP_BCAST_SOURCE)
> >                         setup->base = bt_bap_stream_get_base(setup->stream);
> > -                       setup->id = 0;
> >                 }
> > +               setup->id = 0;
> >
> >                 if (ep->data->service)
> >                         service_set_connecting(ep->data->service);
> >
> >                 return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> > -       }
> >
> >         return NULL;
> >  }
> >
> > -static void update_bcast_qos(struct bt_iso_qos *qos,
> > -                       struct bt_bap_qos *bap_qos)
> > -{
> > -       bap_qos->bcast.big = qos->bcast.big;
> > -       bap_qos->bcast.bis = qos->bcast.bis;
> > -       bap_qos->bcast.sync_factor = qos->bcast.sync_factor;
> > -       bap_qos->bcast.packing = qos->bcast.packing;
> > -       bap_qos->bcast.framing = qos->bcast.framing;
> > -       bap_qos->bcast.encryption = qos->bcast.encryption;
> > -       bap_qos->bcast.options = qos->bcast.options;
> > -       bap_qos->bcast.skip = qos->bcast.skip;
> > -       bap_qos->bcast.sync_timeout = qos->bcast.sync_timeout;
> > -       bap_qos->bcast.sync_cte_type = qos->bcast.sync_cte_type;
> > -       bap_qos->bcast.mse = qos->bcast.mse;
> > -       bap_qos->bcast.timeout = qos->bcast.timeout;
> > -       bap_qos->bcast.io_qos.interval = qos->bcast.in.interval;
> > -       bap_qos->bcast.io_qos.latency = qos->bcast.in.latency;
> > -       bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
> > -       bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
> > -       bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
> > -       if (!bap_qos->bcast.bcode)
> > -               bap_qos->bcast.bcode = new0(struct iovec, 1);
> > -       util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
> > -                                               sizeof(qos->bcast.bcode));
> > -}
> > -
> >  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void
> > *user_data)  {
> >         struct bap_setup *setup = user_data;
> > -       struct bap_ep *ep = setup->ep;
> > -       struct bap_data *data = ep->data;
> > -       struct bt_iso_qos qos;
> > -       struct bt_iso_base base;
> > -       char address[18];
> >         int fd;
> > -       struct iovec *base_io;
> > -       uint32_t presDelay;
> > -       uint8_t numSubgroups;
> > -       uint8_t numBis;
> > -       struct bt_bap_codec codec;
> > -
> > -       bt_io_get(io, &err,
> > -                       BT_IO_OPT_DEST, address,
> > -                       BT_IO_OPT_QOS, &qos,
> > -                       BT_IO_OPT_BASE, &base,
> > -                       BT_IO_OPT_INVALID);
> > -       if (err) {
> > -               error("%s", err->message);
> > -               g_error_free(err);
> > -               goto drop;
> > -       }
> >
> > -       g_io_channel_ref(io);
> > -       btd_service_connecting_complete(data->service, 0);
> > -       DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
> > -                                       address, qos.bcast.big, qos.bcast.bis);
> > -
> > -       update_bcast_qos(&qos, &setup->qos);
> > -
> > -       base_io = new0(struct iovec, 1);
> > -       util_iov_memcpy(base_io, base.base, base.base_len);
> > -
> > -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
> > -                       &presDelay, &numSubgroups, &numBis,
> > -                       &codec, &setup->caps, &setup->metadata);
> > -
> > -       /* Update pac with BASE information */
> > -       bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
> > -                                       setup->metadata);
> > -       setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
> > -                                       setup->caps, NULL, NULL);
> > -
> > -       bt_bap_stream_set_user_data(setup->stream, ep->path);
> > +       /* listen channel is not needed anymore */
> > +       g_io_channel_unref(setup->io);
> > +       setup->io = NULL;
> >
> >         fd = g_io_channel_unix_get_fd(io);
> >
> > @@ -1074,26 +948,43 @@ static void iso_bcast_confirm_cb(GIOChannel
> *io, GError *err, void *user_data)
> >                 g_io_channel_set_close_on_unref(io, FALSE);
> >                 return;
> >         }
> > -
> > -
> > -       return;
> > -
> > -drop:
> > -       g_io_channel_shutdown(io, TRUE, NULL);
> > -
> >  }
> >
> >  static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
> > {
> >         GError *err = NULL;
> > +       struct bap_data *data = user_data;
> > +       struct bt_iso_base base;
> > +       struct bt_bap_base base_s;
> > +       struct bt_iso_qos qos;
> >
> > -       if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> > -                               user_data, NULL, &err, BT_IO_OPT_INVALID)) {
> > -               error("bt_io_bcast_accept: %s", err->message);
> > +       btd_service_connecting_complete(data->service, 0);
> > +
> > +       bt_io_get(io, &err,
> > +                       BT_IO_OPT_BASE, &base,
> > +                       BT_IO_OPT_QOS, &qos,
> > +                       BT_IO_OPT_INVALID);
> > +       if (err) {
> > +               error("%s", err->message);
> >                 g_error_free(err);
> >                 g_io_channel_shutdown(io, TRUE, NULL);
> > +               return;
> >         }
> >
> > +       /* The PA Sync channel becomes the new listen_io.
> > +        * It will be later used to listen for a BIS io.
> > +        */
> > +       g_io_channel_unref(data->listen_io);
> > +       data->listen_io = io;
> > +       g_io_channel_ref(io);
> > +
> > +       /* Analyze received BASE data and create remote media endpoints for
> each
> > +        * matching BIS
> > +        */
> > +       base_s.subgroups = queue_new();
> > +       bt_bap_parse_base(data->bap, base.base, base.base_len,
> bap_debug,
> > +                       &base_s);
> > +       queue_foreach(base_s.subgroups, bt_bap_parse_bis, NULL);
> >  }
> >
> >  static bool match_data_bap_data(const void *data, const void
> > *match_data) @@ -1934,12 +1825,11 @@ static void setup_listen_io(struct
> bap_data *data, struct bt_bap_stream *stream,
> >         data->listen_io = io;
> >  }
> >
> > -static void setup_listen_io_broadcast(struct bap_data *data,
> > +static void setup_accept_io_broadcast(struct bap_data *data,
> >                                         struct bap_setup *setup,
> >                                         struct bt_bap_stream *stream,
> >                                         struct bt_iso_qos *qos)  {
> > -       GIOChannel *io;
> >         GError *err = NULL;
> >         struct sockaddr_iso_bc iso_bc_addr;
> >
> > @@ -1951,29 +1841,18 @@ static void setup_listen_io_broadcast(struct
> > bap_data *data,
> >
> >         DBG("stream %p", stream);
> >
> > -       /* If IO already set skip creating it again */
> > -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> > -               return;
> > -
> > -       io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL, &err,
> > -                       BT_IO_OPT_SOURCE_BDADDR,
> > -                       btd_adapter_get_address(data->adapter),
> > -                       BT_IO_OPT_DEST_BDADDR,
> > -                       device_get_address(data->device),
> > -                       BT_IO_OPT_DEST_TYPE,
> > -                       btd_device_get_bdaddr_type(data->device),
> > -                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > -                       BT_IO_OPT_QOS, &qos->bcast,
> > -                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> > -                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> > -                       BT_IO_OPT_INVALID);
> > -       if (!io) {
> > -               error("%s", err->message);
> > +       if (!bt_io_bcast_accept(data->listen_io,
> > +                       iso_bcast_confirm_cb,
> > +                       setup, NULL, &err,
> > +                       BT_IO_OPT_ISO_BC_NUM_BIS,
> > +                       iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
> > +                       iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> > +               error("bt_io_bcast_accept: %s", err->message);
> >                 g_error_free(err);
> >         }
> > -       setup->io = io;
> > -       data->listen_io = io;
> >
> > +       setup->io = data->listen_io;
> > +       data->listen_io = NULL;
> >  }
> >  static void setup_create_ucast_io(struct bap_data *data,
> >                                         struct bap_setup *setup, @@
> > -2037,7 +1916,7 @@ done:
> >         if (bt_bap_pac_get_type(setup->ep->lpac) ==
> BT_BAP_BCAST_SOURCE)
> >                 setup_connect_io_broadcast(data, setup, stream, &iso_qos);
> >         else
> > -               setup_listen_io_broadcast(data, setup, stream, &iso_qos);
> > +               setup_accept_io_broadcast(data, setup, stream,
> > + &iso_qos);
> >  }
> >
> >  static void setup_create_io(struct bap_data *data, struct bap_setup
> > *setup, @@ -2422,6 +2301,7 @@ static int bap_bcast_probe(struct
> btd_service *service)
> >         struct btd_gatt_database *database =
> btd_adapter_get_database(adapter);
> >         struct bap_data *data = btd_service_get_user_data(service);
> >         char addr[18];
> > +       GError *err = NULL;
> >
> >         ba2str(device_get_address(device), addr);
> >
> > @@ -2465,7 +2345,23 @@ static int bap_bcast_probe(struct btd_service
> > *service)
> >
> >         bt_bap_set_user_data(data->bap, service);
> >
> > -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> > +       DBG("Create PA sync with this source");
> > +       data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
> > +                       NULL, &err,
> > +                       BT_IO_OPT_SOURCE_BDADDR,
> > +                       btd_adapter_get_address(data->adapter),
> > +                       BT_IO_OPT_DEST_BDADDR,
> > +                       device_get_address(data->device),
> > +                       BT_IO_OPT_DEST_TYPE,
> > +                       btd_device_get_bdaddr_type(data->device),
> > +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> > +                       BT_IO_OPT_QOS, &bap_sink_sync_parameters,
> > +                       BT_IO_OPT_INVALID);
> > +       if (!data->listen_io) {
> > +               error("%s", err->message);
> > +               g_error_free(err);
> > +       }
> 
> I really doubt this will work in a crowded environment, it seems we would be
> doing several PA Sync in parallel, one for each announcement found, which
> not only would overwrite the QOS but also I don't think controller are capable
> of doing multiple PA Sync like that so we might need to serialize the process
> of doing short lived PA Syncs to enumerate the BASE.
> 
> Usually we have dealt with the serialization using an idle timer which can
> then check services that need to be resolved, once a service is being
> resolved then the timer shall be stopped, we restart the time everytime
> something needs to be resolved.
> 

bap_bcast_probe starts a PA Sync controller procedure for each new Broadcast 
source seen. 
This can take several milliseconds with physical controller and runs in an instant 
with the emulator. The problem that can arrive is that another Broadcast source 
gets probed and another bt_io_listen is executed before the previous one is 
completed. In this scenario the controller will return an error for no resources 
and the second PA sync will fail, but the one in progress will complete successfully.
Given the timings for this to happen, can I submit a different patch for this 
issue, or shall I fix it in this one?

> > +
> >         return 0;
> >  }
> >
> > --
> > 2.40.1
> >
> 
> 
> --
> Luiz Augusto von Dentz
