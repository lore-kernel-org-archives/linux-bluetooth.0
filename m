Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDE15A4B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133156; cv=fail; b=CmiFbv6kIK9C4HurCDZEhk+zZjfsFyD23w1I07oiq1WGzfN+Daiia2q0VAyfGshV61jEK/D6Fv/3RxMPv+KJHmGND42CNYDMaFVDCj3dysITyDkwyV1ew+Iu0Z9OquKAfUVcjj4JE8L8HdLCThylODxA1OFJvgYODVfuM8gcYEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133156; c=relaxed/simple;
	bh=jswHZKE8P/Svq+6HzYYu3jBdqzkft69bKHSzQcmHIaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bL66HPx/x4gV6Nj/9kjcQnXUupu4By69sNtYUkJ8TbImeOd/l0k9iIPZObXMElcNEP7n+eqpV8TXxKaUTf7+PGPPI8ZIPnTjvkoiGmvaz76hngXP0AEIqCsRE3qJbnY/7HQLVHeO0tltuKmiQXJe7lI2N/uEuNYZwZLEb9ztUuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fw/UuLSf; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fw/UuLSf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuIV8mwMLLKCBf+9+sIOc2oeRKdhlQnbGSTtXVTraN8yb5J1lGwurymPbZprzJGKHKZ311eAD1vOrAGvtykkg5NAnPrl0560KfeaBP5OI9j4BZzys1Ts7U4x4oiFAucg4Jiihj+Z3tJZp2Sa/J3z9///c17dvT4Ls+TvZdeH5Zt9VlosN37uzG0pRYkYG50Z/VLEvKoCPqKul4w2bpTsOzJ/Jn5V/vm49XKEpeq0r5VdYDaFBEg09ZzZjJzRFI1b0GgqogCLltidvUgvUKQ8KIPX2ZFHSTKWXitGCf5JpX7xP9/HCO2fgfBt5jjFXQwm8OckI1APG/1n2o3ajohJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOveG7anm/gSTerDcbCyuNAK9lVMSfJk35FmAp2Xs4g=;
 b=D7Ybj3v1eNn0Mdn9fOA8r5kKKBnlYMUBxwapCuKqaK8Bo/EaC47gDC8GYa5hVnCFl7hon1T0gHgDVNfOO8eWSevIEO2WF/kjyUt7qyjy41futBBxTUVv8dccBYM+8/5696dTU6e0R+XmudG++esNJ0Gn45L/Z5TiT9LIP0ghGVlfu/0C6dgSq9wxVkT1rF+D1XJvFatmogW466zkft858xPK1qvehusfL/APNpSr70SbqunE4WqJ2co7baJ8toIwP1wpUHT3bnKHU124yKfIGCYqKw7S/rRTcVxUKqLwSbNCJffVrWg7gH3r8r+prAJ2m8rtOzVgFPLME+XnnXRP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOveG7anm/gSTerDcbCyuNAK9lVMSfJk35FmAp2Xs4g=;
 b=Fw/UuLSfNHXFvG2w1UoBQ3pAyVlba8WD3KgL9r5yhrqnLaPhydGGcP21YIpVDzGVGD2Qa2nyxgYOPRaFyf9VC4C7xC8sdsX2sSdejCR2jcFyP++LW0McMuluMa+pyXWZhUtVkR9TAgAGJ0b5aJkRI+91LoPSQ+P8GcO+NdOnLho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 28 Feb
 2024 15:12:30 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 15:12:29 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an observed BIS
Date: Wed, 28 Feb 2024 17:12:27 +0200
Message-Id: <20240228151227.12034-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABBYNZ+0mMAw4ftbwGE_s49QOQrRZAFGRVEXucxWkv=6YEG+iA@mail.gmail.com>
References: <CABBYNZ+0mMAw4ftbwGE_s49QOQrRZAFGRVEXucxWkv=6YEG+iA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAXPR04MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 405f4b11-79e6-4d1d-c3ce-08dc386fae35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ww/tWkr/hQdsgMoGDg4PAerl2rSjcSdNJ1MvFRkXXlZgMMLl0kC+/AYbWdmGEx4ICkyL6AystMeZjfr4JX9SMq94oBDUXa+SC3oRiNpe7oFI0CC86tdPQx5P2Z6KfqbFL6DqnSYNkbyoyJN3/74PkFszLpZXVfUnWBdX01ETFLYzgSMt239zDCj5n9p219N5m7kK/O+fOwKFMZSt6XxrjqByGyRfOtNnuAexS1ITK+iA/6vp4Q+NwIl7FJkfsvB3pFuq8vxU1AU+rDYKpMHo9qkJKaMD+Gj5kRZjSLTxgSY9eH+bploARMYNWhmsDO4dKxubU90jKjZ5kK1XJ7P6/bpDuIie2smP+11dqubiec8bocXN9xsrslRKJEPe+GrrlJ9nlj6eb9yauHfue6QDgaiqr7rG24Yl39s+a2Juf88w0nsDiLptPVxaIIX12kiyoqSgqFYOpPQaAF7rfJEsc8D8hJGLQzlvk/oUb2tX7epaCzAIKpIy8SqF/GyZPqiat92UFsErdDKDg8+lKiet76HQD0qmoFlaqbUIIJo0gINY+porE1e4tUmlBgI4SC3IhJhd5aYXYgtOXmc9lcAc3ndbV8S2DzKBBz3f/oL5wbsmFU1ALUq/Hqro6eZGT0DrHubLbjqTiZhypnQD3+og/5n+plNhxXEpWv+5Xx3ATh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTC0jCpoKsjy/hZN8+fPhIHmM4FpWnpJgx4s2VxRfde2fCBM56cPbzy4r+cZ?=
 =?us-ascii?Q?DH2ewtd4WgobkQhLgv302AYOLXhsS94sCvOX1geboG6nvyf279+GnhbZN7KO?=
 =?us-ascii?Q?SMh7CkwLTOfLMsCsLUEXmFDaABuDp1auNlaKeIdY6IK/TrCP3z1oMxPaTMUU?=
 =?us-ascii?Q?zFFMQamhtv0I/CdNZEfMzAVs31KLHoRMXI/n8WpOfXxUfbcuOq1f/n8ukNYQ?=
 =?us-ascii?Q?ToUPwKXDYC3qbRjhIl2OCowepHIT0yWQnivqqx+hUTtM6nadHq17iouaoS/A?=
 =?us-ascii?Q?UKbWcNSOtxdyczVzkVaIUwfs7vythdprELAzkIYQvUv8vp1sTTV2Fdrxy0oY?=
 =?us-ascii?Q?FpTIuImm4znprC2iEuCPPHW/uuKeFiZiXAMwrvOzDcsSh4gYzdkg+78Ue+do?=
 =?us-ascii?Q?aThMPTT+ZWw2kkJ5tOE3P5WnV2ac6j+Xll6NN/Yxa/uA+PCLMzUnPvU8l6xg?=
 =?us-ascii?Q?2uvXdpaHuA8plbJIl5uPPChbwvnNgtQrWTqkABOwp2PNxzxm8ADwbr8ZgK0I?=
 =?us-ascii?Q?GFgRvlHz+RC58yWe/OJkYxxKhAAR2tlp2GY89Q0lYk5A2mWFBl0FyI/AvRMh?=
 =?us-ascii?Q?OJbnJG2j2wwFu9t0AB24OCVeCL/1Z9+PqcmR1jZb9eC8hCKhqXIO9hz89Btr?=
 =?us-ascii?Q?HBdHDJIxlQQv1OnQonl8goew742TJ0lvboYlkZ8pS/abtgCpaeEVv1Ps3jIq?=
 =?us-ascii?Q?fdPnBge7IGlEjetKPM11tLYBqaU4KWKxyaTTrxJVE3BU9ddWNWV+ETDTd96W?=
 =?us-ascii?Q?NbWYNBN19FllHEUuXZ5SlGCWsbRDoPrmzKFjA9F9jD5vRp5rz0jbJGU3s51f?=
 =?us-ascii?Q?EX2EScyHjtBCx4YEAwP8CPGvoq9BAyKdCVX4B9ggPBBO98XE4QTkssTA2IAR?=
 =?us-ascii?Q?uaiSOhaVLTOHcrmheo8I1Fb2oasp6FKqjhvGmctvhrQhxu5Vt4vuj31iEPHl?=
 =?us-ascii?Q?vuxFiZwAj17iYFuzNBi7GVPZYprOQHDlNuyaiCaSsoepW7wm71pepj2DBWAe?=
 =?us-ascii?Q?KK55xPjhEvwjhpjCgzRpteiP3gje9HE41z/cuvI5O03Mw/8PkwFxcfbYG5XF?=
 =?us-ascii?Q?9zuxsgbeBUku864dupXYUF4h6JAa5uTJyGVZgF5rkBUe2+ySQ5j+CL3uOuB5?=
 =?us-ascii?Q?ibMA1HPBfELJSHkmjNHXdLRo2+mxBagSMvUhlCrCSJNNYvOb+bmq431sxnu3?=
 =?us-ascii?Q?Px5V93eIDzlsnw0PoZzyyvu1VZMlf6srSZe3vWCTdsGyQW1IBgT6dX5yh+ff?=
 =?us-ascii?Q?QbZQ4lfmf7jqyt9q51hOU1/dC0SpmNihSTPFMLbpf5uDY6xMZD8Rmz+XDiUT?=
 =?us-ascii?Q?o19l3q6CAcY3mI7nVokWgyteWIuyjDjDDXoqEwWRZe6Zkwmn9N2y/kCetO95?=
 =?us-ascii?Q?NW4YYiQr++GvWRK9dPciRE8TMMWiGmuzmEhr8GYtk/8ibS4EH/QaHJkSTkoE?=
 =?us-ascii?Q?1CdME60m9I3VmeY0tycfkazXnUvbKiFpcO38r4AFvYtRO/fxP+4AD+H08avI?=
 =?us-ascii?Q?sFUxMPXiDaqiSsAaWxL4Xx213Ge0oHOMAhR0o/hvS/aC4LX3Q1MQpCTDe8M3?=
 =?us-ascii?Q?uQs+P2V/pDdiZgD8XRMi9LAJRVbe5n5P3sM0TmyiQL6yfIAG2ZFujQDteEHe?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405f4b11-79e6-4d1d-c3ce-08dc386fae35
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:12:29.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHSORSuFaLaOzTOhLPb1B1v95tE7uShFo0MqHuBzfMCjnnLuDffykujE4q7ThLWXd57abfSBFzi1/CTDSreQdBObeDGV4VEWkYyfPXfnuh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877

Hi Luiz,

I have fixed all the comments excepting one. Please see inline.

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, February 27, 2024 4:39 PM
> To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Subject: Re: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an
> observed BIS
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> Hi Andrei,
> 
> On Fri, Feb 23, 2024 at 10:34 AM Andrei Istodorescu
> <andrei.istodorescu@nxp.com> wrote:
> >
> > Add API to add a PAC for each observed BIS that is supported by the
> > local PACS data.
> > Each BIS observed capabilities LTV is compared to the local
> > capabilities and when we have a full LTVs match a PAC record is created for
> that BIS.
> > Also a MediaEndpoint is registered over DBUS and the stream can be
> > enabled using the SetConfiguration DBUS call.
> > ---
> >  src/shared/bap.c | 304
> > ++++++++++++++++++++++++++++++++++++++++++++---
> >  src/shared/bap.h |  13 +-
> >  2 files changed, 302 insertions(+), 15 deletions(-)
> >
> > diff --git a/src/shared/bap.c b/src/shared/bap.c index
> > f5fc1402701c..853919111835 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -48,6 +48,15 @@
> >
> >  #define BAP_PROCESS_TIMEOUT 10
> >
> > +#define BAP_FREQ_LTV_TYPE 1
> > +#define BAP_DURATION_LTV_TYPE 2
> > +#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3 #define
> > +BAP_FRAME_LEN_LTV_TYPE 4 #define
> CODEC_SPECIFIC_CONFIGURATION_MASK (\
> > +               (1<<BAP_FREQ_LTV_TYPE)|\
> > +               (1<<BAP_DURATION_LTV_TYPE)|\
> > +               (1<<BAP_FRAME_LEN_LTV_TYPE))
> > +
> >  struct bt_bap_pac_changed {
> >         unsigned int id;
> >         bt_bap_pac_func_t added;
> > @@ -1692,11 +1701,8 @@ static unsigned int bap_bcast_config(struct
> bt_bap_stream *stream,
> >                                      bt_bap_stream_func_t func, void
> > *user_data)  {
> >         stream->qos = *qos;
> > -       if (stream->lpac->type == BT_BAP_BCAST_SINK) {
> > -               if (data)
> > -                       stream_config(stream, data, NULL);
> > -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> > -       }
> > +       stream->lpac->ops->config(stream, stream->cc, &stream->qos,
> > +                       ep_config_cb, stream->lpac->user_data);
> >
> >         return 1;
> >  }
> > @@ -3302,6 +3308,13 @@ static void bap_add_broadcast_source(struct
> > bt_bap_pac *pac)  static void bap_add_broadcast_sink(struct bt_bap_pac
> > *pac)  {
> >         queue_push_tail(pac->bdb->broadcast_sinks, pac);
> > +
> > +       /* Update local PACS for broadcast sink also, when registering an
> > +        * endpoint
> > +        */
> > +       pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
> > +       pacs_add_sink_supported_context(pac->bdb->pacs,
> > +                       pac->qos.supported_context);
> >  }
> >
> >  static void notify_pac_added(void *data, void *user_data) @@ -3453,6
> > +3466,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct
> bt_bap_pac *pac)
> >         return &pac->qos;
> >  }
> >
> > +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac) {
> > +       return pac->data;
> > +}
> > +
> > +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac) {
> > +       return pac->metadata;
> > +}
> > +
> >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)  {
> >         if (!stream)
> > @@ -5253,10 +5276,6 @@ bool bt_bap_stream_set_user_data(struct
> > bt_bap_stream *stream, void *user_data)
> >
> >         stream->user_data = user_data;
> >
> > -       if (bt_bap_stream_get_type(stream) ==
> BT_BAP_STREAM_TYPE_BCAST)
> > -               stream->lpac->ops->config(stream, stream->cc, &stream->qos,
> > -                                       ep_config_cb, stream->lpac->user_data);
> > -
> >         return true;
> >  }
> >
> > @@ -5892,8 +5911,9 @@ static void add_new_subgroup(struct bt_base
> > *base,
> >
> >  struct bt_ltv_match {
> >         uint8_t l;
> > -       uint8_t *v;
> > +       void *data;
> >         bool found;
> > +       uint32_t data32;
> >  };
> >
> >  struct bt_ltv_search {
> > @@ -5912,7 +5932,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t t,
> uint8_t *v,
> >         if (ltv_match->l != l)
> >                 return;
> >
> > -       if (!memcmp(v, ltv_match->v, l))
> > +       if (!memcmp(v, ltv_match->data, l))
> >                 ltv_match->found = true;  }
> >
> > @@ -5924,7 +5944,7 @@ static void search_ltv(size_t i, uint8_t l,
> > uint8_t t, uint8_t *v,
> >
> >         ltv_match.found = false;
> >         ltv_match.l = l;
> > -       ltv_match.v = v;
> > +       ltv_match.data = v;
> >
> >         util_ltv_foreach(ltv_search->iov->iov_base,
> >                         ltv_search->iov->iov_len, &t, @@ -5965,8
> > +5985,10 @@ static bool compare_ltv(struct iovec *iov1,  }
> >
> >  struct bt_ltv_extract {
> > -       struct iovec *result;
> >         struct iovec *src;
> > +       void *value;
> > +       uint8_t len;
> > +       struct iovec *result;
> >  };
> >
> >  static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> > @@ -5978,7 +6000,7 @@ static void extract_ltv(size_t i, uint8_t l,
> > uint8_t t, uint8_t *v,
> >
> >         ltv_match.found = false;
> >         ltv_match.l = l;
> > -       ltv_match.v = v;
> > +       ltv_match.data = v;
> >
> >         /* Search each BIS caps ltv in subgroup caps
> >          * to extract the one that are BIS specific @@ -6111,3
> > +6133,257 @@ struct iovec *bt_bap_stream_get_base(struct
> bt_bap_stream
> > *stream)
> >
> >         return base_iov;
> >  }
> > +
> > +static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
> > +               uint8_t *v, void *user_data) {
> > +       uint32_t location32;
> > +
> > +       if (!v)
> > +               return;
> > +
> > +       memcpy(&location32, v, l);
> > +       *((uint32_t *)user_data) = le32_to_cpu(location32); }
> > +
> > +/*
> > + * This function compares PAC Codec Specific Capabilities, with the
> > +Codec
> > + * Specific Configuration LTVs received in the BASE of the BAP
> > +Source. The
> > + * result is accumulated in data32 which is a bitmask of types.
> > + */
> > +static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> > +                                       void *user_data) {
> > +       struct bt_ltv_match *compare_data = user_data;
> > +       uint8_t *bis_v = compare_data->data;
> > +
> > +       switch (t) {
> > +       case BAP_FREQ_LTV_TYPE:
> > +       {
> > +               uint16_t mask = *((uint16_t *)v);
> > +
> > +               mask = le16_to_cpu(mask);
> > +               if (mask & (1 << (bis_v[0] - 1)))
> > +                       compare_data->data32 |= 1<<t;
> > +       }
> > +       break;
> > +       case BAP_DURATION_LTV_TYPE:
> > +               if ((v[0]) & (1 << bis_v[0]))
> > +                       compare_data->data32 |= 1<<t;
> > +               break;
> > +       case BAP_FRAME_LEN_LTV_TYPE:
> > +       {
> > +               uint16_t min = *((uint16_t *)v);
> > +               uint16_t max = *((uint16_t *)(&v[2]));
> > +               uint16_t frame_len = *((uint16_t *)bis_v);
> > +
> > +               min = le16_to_cpu(min);
> > +               max = le16_to_cpu(max);
> > +               frame_len = le16_to_cpu(frame_len);
> > +               if ((frame_len >= min) &&
> > +                               (frame_len <= max))
> > +                       compare_data->data32 |= 1<<t;
> > +       }
> 
> Don't create new scopes inside a switch statement, that makes it hard to
> follow the code, if you really think that would help have a helper function to
> check each field.
> 
> > +       break;
> > +       }
> > +}
> > +
> > +static void check_source_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> > +                                       void *user_data) {
> > +       struct bt_ltv_match *local_data = user_data;
> > +       struct iovec *pac_caps = local_data->data;
> > +       struct bt_ltv_match compare_data;
> > +
> > +       compare_data.data = v;
> > +
> > +       /* Search inside local PAC's caps for LTV of type t */
> > +       util_ltv_foreach(pac_caps->iov_base, pac_caps->iov_len, &t,
> > +                                       check_pac_caps_ltv,
> > + &compare_data);
> > +
> > +       local_data->data32 |= compare_data.data32; }
> > +
> > +static void bap_sink_check_level3_ltv(size_t i, uint8_t l, uint8_t t,
> > +               uint8_t *v, void *user_data) {
> > +       struct bt_ltv_extract *merge_data = user_data;
> > +
> > +       merge_data->value = v;
> > +       merge_data->len = l;
> > +}
> > +
> > +static void bap_push_ltv(struct iovec *output, uint8_t l, uint8_t t,
> > +void *v) {
> > +       l++;
> > +       iov_append(output, 1, &l);
> > +       iov_append(output, 1, &t);
> > +       iov_append(output, l - 1, v);
> > +}
> 
> Perhaps we should create a helper function to do this sort of thing, maybe
> util_ltv_push?
> 
> > +static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t,
> > +               uint8_t *v, void *user_data) {
> > +       struct bt_ltv_extract *merge_data = user_data;
> > +
> > +       merge_data->value = NULL;
> > +       util_ltv_foreach(merge_data->src->iov_base,
> > +                       merge_data->src->iov_len,
> > +                       &t,
> > +                       bap_sink_check_level3_ltv, user_data);
> > +
> > +       /* If the LTV at level 2 was found at level 3 add the one from level 3,
> > +        * otherwise add the one at level 2
> > +        */
> > +       if (merge_data->value)
> > +               bap_push_ltv(merge_data->result, merge_data->len,
> > +                               t, merge_data->value);
> > +       else
> > +               bap_push_ltv(merge_data->result, l, t, v); }
> > +
> > +static void check_local_pac(void *data, void *user_data) {
> > +       struct bt_ltv_match *compare_data = user_data;
> > +       struct iovec *bis_data = (struct iovec *)compare_data->data;
> > +       const struct bt_bap_pac *pac = data;
> > +
> > +       /* Keep searching for a matching PAC if one wasn't found
> > +        * in previous PAC element
> > +        */
> > +       if (compare_data->found == false) {
> > +               struct bt_ltv_match bis_compare_data = {
> > +                               .data = pac->data,
> > +                               .data32 = 0, /* LTVs bitmask result */
> > +                               .found = false
> > +               };
> > +
> > +               /* loop each BIS LTV */
> > +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, NULL,
> > +                               check_source_ltv, &bis_compare_data);
> > +
> > +               /* We have a match if all selected LTVs have a match */
> > +               if ((bis_compare_data.data32 &
> > +                       CODEC_SPECIFIC_CONFIGURATION_MASK) ==
> > +                       CODEC_SPECIFIC_CONFIGURATION_MASK)
> > +                       compare_data->found = true;
> > +       }
> > +}
> > +
> > +static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
> > +               uint8_t *v, void *user_data) {
> > +       struct bt_ltv_match *data = user_data;
> > +       uint32_t location32;
> > +
> > +       if (!v)
> > +               return;
> > +
> > +       memcpy(&location32, v, l);
> > +       location32 = le32_to_cpu(location32);
> > +
> > +       /* If all the bits in the received bitmask are found in
> > +        * the local bitmask then we have a match
> > +        */
> > +       if ((location32 & data->data32) == location32)
> > +               data->found = true;
> > +       else
> > +               data->found = false;
> > +}
> > +
> > +static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec
> > +*bis_data) {
> > +       struct bt_ltv_match compare_data = {};
> > +
> > +       /* Check channel allocation against the PACS location.
> > +        * If we don't have a location set we can accept any BIS location.
> > +        * If the BIS doesn't have a location set we also accept it
> > +        */
> > +       compare_data.found = true;
> > +
> > +       if (ldb->pacs->sink_loc_value) {
> > +               uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> > +
> > +               compare_data.data32 = ldb->pacs->sink_loc_value;
> > +               util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, &type,
> > +                               bap_sink_match_allocation, &compare_data);
> > +       }
> > +
> > +       /* Check remaining LTVs against the PACs list */
> > +       if (compare_data.found) {
> > +               compare_data.data = bis_data;
> > +               compare_data.found = false;
> > +               queue_foreach(ldb->broadcast_sinks, check_local_pac,
> > +                               &compare_data);
> > +       }
> > +
> > +       return compare_data.found;
> > +}
> > +
> > +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> > +               struct bt_bap_codec *codec,
> > +               struct iovec *l2_caps,
> > +               struct iovec *l3_caps,
> > +               struct iovec *meta)
> > +{
> > +       struct bt_bap_pac *pac_source_bis;
> > +       struct bt_bap_endpoint *ep;
> > +       int err = 0;
> > +       struct bt_bap_pac_qos bis_qos = {0};
> > +       uint8_t type = 0;
> > +       struct bt_ltv_extract merge_data = {0};
> > +
> > +       merge_data.src = l3_caps;
> > +       merge_data.result = new0(struct iovec, 1);
> > +
> > +       /* Create a Codec Specific Configuration with LTVs at level 2 (subgroup)
> > +        * overwritten by LTVs at level 3 (BIS)
> > +        */
> > +       util_ltv_foreach(l2_caps->iov_base,
> > +                       l2_caps->iov_len,
> > +                       NULL,
> > +                       bap_sink_check_level2_ltv, &merge_data);
> > +
> > +       /* Check each BIS Codec Specific Configuration LTVs against our Codec
> > +        * Specific Capabilities and if the BIS matches create a PAC with it
> > +        */
> > +       if (bap_check_bis(bap->ldb, merge_data.result) == false)
> > +               goto cleanup;
> > +
> > +       DBG(bap, "Matching BIS %i", bis_index);
> > +
> > +       /* Create a QoS structure based on the received BIS information to
> > +        * specify the desired channel for this BIS/PAC
> > +        */
> > +       type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
> > +       util_ltv_foreach(merge_data.result->iov_base,
> > +                       merge_data.result->iov_len, &type,
> > +                       bap_sink_get_allocation, &bis_qos.location);
> 
> Isn't it better to parse this inline with the use of util_iov_pull_*?
> If you don't want to change the iovec passed, which shall be made a const if
> that is intention, then just create a dup and parse it.
merge_data.result is the concatenated list for Capabilities LTVs. We need to 
extract the value for the Allocation LTV so that we pass it to the stream qos.
I used util_ltv_foreach to easily access the ltv. Do you see another way? 
Maybe I didn't understand your comment.

> 
> > +       /* Create a remote PAC */
> > +       pac_source_bis = bap_pac_new(bap->rdb, NULL,
> > +                               BT_BAP_BCAST_SOURCE, codec, &bis_qos,
> > +                               merge_data.result, meta);
> > +
> > +       err = asprintf(&pac_source_bis->name, "%d", bis_index);
> > +
> > +       if (err < 0) {
> > +               DBG(bap, "error in asprintf");
> > +               goto cleanup;
> > +       }
> > +
> > +       /* Add remote source endpoint */
> > +       if (!bap->rdb->broadcast_sources)
> > +               bap->rdb->broadcast_sources = queue_new();
> > +       queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
> > +
> > +       queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
> > +       /* Push remote endpoint with direction sink */
> > +       ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
> > +
> > +       if (ep)
> > +               queue_push_tail(bap->remote_eps, ep);
> > +
> > +cleanup:
> > +       util_iov_free(merge_data.result, 1); }
> > diff --git a/src/shared/bap.h b/src/shared/bap.h index
> > 2c3550921f07..b2826719f84f 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -4,7 +4,7 @@
> >   *  BlueZ - Bluetooth protocol stack for Linux
> >   *
> >   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> > - *  Copyright 2023 NXP
> > + *  Copyright 2023-2024 NXP
> >   *
> >   */
> >
> > @@ -175,6 +175,10 @@ uint16_t bt_bap_pac_get_context(struct
> bt_bap_pac
> > *pac);
> >
> >  struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
> >
> > +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
> > +
> > +struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
> 
> Have these 2 functions above in a separate patch.
> 
> >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> >
> >  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> > @@ -323,3 +327,10 @@ void bt_bap_update_bcast_source(struct
> bt_bap_pac
> > *pac,  bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct
> > bt_bap_pac *pac);
> >
> >  struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
> > +
> > +void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
> > +               struct bt_bap_codec *codec,
> > +               struct iovec *l2_caps,
> > +               struct iovec *l3_caps,
> > +               struct iovec *meta);
> > +
> > --
> > 2.40.1
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Andrei
