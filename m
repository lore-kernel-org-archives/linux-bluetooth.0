Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E8C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469C72064A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtiE5hRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbgDMTl7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387935AbgDMTl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 15:41:58 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA498C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 12:41:57 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k133so7670070oih.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KXwsEvmr3zGzp5z62Z8VdqltGux3+eny0IvNqgRcTnU=;
        b=CtiE5hRFygjNEShiapvKBGhx5Ikn19Ye4Vy4AXvB8Qm5ukugEavm4fM4L+3yDSIOFZ
         4iM0SgEvwzvEwfs1q/CUmKHNzrCdUpWJ9OgylQ4sCcRAaGLwfawZDDXm+Q9j1ehzAnSR
         lmchqN3k/2rkZP/YeDFzRKGBMLPx5WsayVoqCd/GCGg7+vSABNfg+FszZbup+Q7Pqd97
         hso0z9TCK/0mPwLCsnQWP9cgnoBQZLpPYxOkwKT2VMqctdFjjVBYsAwm0ChYx3HXwuJC
         x8DcGGjaZolKpYLIPVIpCYcsgq8oWh4q+6RWK5uVaTkmMRRFi7rKE/Lj/fkH6P29VMud
         rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KXwsEvmr3zGzp5z62Z8VdqltGux3+eny0IvNqgRcTnU=;
        b=b1FbQfLLSnjQUFTOguCYZ7qd49S0G/Hirj9YH8bfCuPULqUsZfIlvmxnYSM2DdQ1AT
         sONWlIlGvYaaYy1azq/TYe2KN/ePJoPIj9UKptEx1qVs9rT9KBz6DEws1UEPbk4D0fmj
         3/Nv7etS7PIyhUFAOwdGYEPWv6Kxtvl+6aJzmzfHp/ROPyUQ1V5sQriEzvRUGK6FUGn1
         HQ/qB2RK0GvBpQFADKAXh6jms11he38choxZqXtoz44jJ+WLuQMr5L/8U1Xs/421EBWT
         tKaF2pbDxQyE3XQJauPzg3Xq1GMxKuv3dPS50qx+JOL2MAofQwaadh4J3ImW1T2md8gW
         cNdQ==
X-Gm-Message-State: AGi0PubBiYvTNPwsww5zsSWhA8tegiRdbKnXxbzFu7LxLR+TgnM8xASr
        HBNjQuuH+4NS+82Hb7FeQkW1vMXo913ZqUpNopecH9mi
X-Google-Smtp-Source: APiQypKkWr6qiZRRSVw/3VKOJEjs3RNiBulXMDGEZEHF1tkt43uPIbr8J6l1dUEBNkXtfIFD2LJCoK0NLuYZ/hQNkMc=
X-Received: by 2002:aca:f584:: with SMTP id t126mr11133964oih.108.1586806916899;
 Mon, 13 Apr 2020 12:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org> <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali> <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
 <20200413171722.ilawhisu67onrifn@pali> <CABBYNZKFGjsnCnBPyw0WFr_aJ2zaYAjLj81t04S=fXaXD9ac+g@mail.gmail.com>
 <20200413175833.di53ucocat5tdrke@pali>
In-Reply-To: <20200413175833.di53ucocat5tdrke@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 12:41:44 -0700
Message-ID: <CABBYNZL4hr34svvF1Qdz5YA3fWwTex4cyX0PumVL_ARErKBo3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] src/profile: Distinguish between zero-set HFP AG
 features and unset HFP AG features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 13, 2020 at 10:58 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 April 2020 10:47:04 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Mon, Apr 13, 2020 at 10:17 AM Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > >
> > > On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, Apr 13, 2020 at 9:52 AM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
> > > > >
> > > > > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote:
> > > > > > On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > > > > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct =
btd_service *service)
> > > > > > >  static char *get_hfp_hf_record(struct ext_profile *ext, stru=
ct ext_io *l2cap,
> > > > > > >                                                         struc=
t ext_io *rfcomm)
> > > > > > >  {
> > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b00000=
0 */
> > > > > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, e=
xt->version,
> > > > > > > -                                               ext->name, ex=
t->features);
> > > > > > > +                               ext->name,
> > > > > > > +                               ext->have_features ? ext->fea=
tures : 0x0);
> > > > > > >  }
> > > > > > >
> > > > > > >  static char *get_hfp_ag_record(struct ext_profile *ext, stru=
ct ext_io *l2cap,
> > > > > > >                                                         struc=
t ext_io *rfcomm)
> > > > > > >  {
> > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b00100=
1 */
> > > > > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, e=
xt->version,
> > > > > > > -                                               ext->name, ex=
t->features);
> > > > > > > +                               ext->name,
> > > > > > > +                               ext->have_features ? ext->fea=
tures : 0x9);
> > > > > >
> > > > > > I wonder why you didn't just initialize the features wiht 0x9 i=
nstead
> > > > > > of adding a flag to track it, btw add a define with value 0x09 =
like
> > > > > > HFP_DEFAULT_FEATURES that way it is clearer why we are doing th=
is.
> > > > >
> > > > > This function get_hfp_ag_record() is for parsing local features. =
You are
> > > > > right that for local features we do not need a flag to track it.
> > > > >
> > > > > But flag for tracking is needed for parsing remote features. And =
to have
> > > > > unified code for storing local and remote features it is easier t=
o have
> > > > > always a flag for checking if features were provided or not.
> > > >
> > > > Im not following you about the remote features beinf different, I
> > > > though both would be could be initialized in the same way and then =
if
> > > > we read a different value from the SDP record we just overwrite it.
> > >
> > > But in this case we put these default remote features to HFP DBus age=
nt
> > > like if they were specified in SDP. Default value is specific for
> > > profile version. And if e.g. new HFP version defines a new bit in
> > > features with its own default value then HFP DBus agent would not be
> > > able to distinguish between state when remote device did not specifie=
d
> > > any value (as bluez will put there some defaults) and when remote dev=
ice
> > > specified same features as bluez has defined in its current default
> > > value.
> >
> > Different version may have different defaults but we can initialize
> > them correctly.
>
> But we do not know default values for future versions which have not
> been released yet. There would be a problem if user run current
> bluez daemon e.g. in 5 years when new version of HFP profile would be
> released and remote device would use it.

We would have to match what is the features that the agent can handle.

> > > Before and also after this change remote features are not send to HFP
> > > DBus agent when they were not specified by remote device.
> > >
> > > After your suggestion HFP DBus agent would not be able to check if
> > > remote device provided features or not. And this is I think a
> > > regression.
> >
> > I don't think we can consider a regression to always provide features,
> > besides what would be the reason for the agent to know if the features
> > were from the SDP record or they are auto initiliazed?
>
> Autoinitialized for which version? Bluez has currently defined default
> values for HFP 1.7. But DBus agent can register HFP profile also for
> version 1.5 or also 1.8.
>
> To which value should it be autoinitialized when remote device announce
> that is in version 1.8 but does not specify features (=3D default for
> version 1.8 should be used)? The only option which make sense is to not
> autoinitiaze this value as version 1.8 was not released yet and now we
> do not know what would be the default value.

We should probably use the mininum version of the client and server,
so if the device supports 1.8 but our agent is 1.5 it should default
to 1.5, this actually would have to be done anyway because othewise we
would make agents duplicating the logic of handling the features
properly so we might as well try to consolidate this on the daemon and
only expose the features that can actually be used in the session,
that means the autoinitilize logic the to take into account both the
device and agent version.

> > I that was
> > really necessary Id just dump the whole record as a ServiceRecord
> > option and leave it up to the client to parse it.
> >
> > > > > I can put these default values in profile-role specific macros e.=
g.:
> > > > >
> > > > > #define HFP_AG_DEFAULT_FEATURES 0x09
> > > > > #define HFP_HF_DEFAULT_FEATURES 0x00
> > > > > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> > > >
> > > > Don't bother with default that are 0x00/false, we can assume this i=
s
> > > > implicit when allocating the memory everything is set to 0 so these
> > > > defines wouldn't be needed in the first place.
> > > >
> > > > > Or do you prefer different names?
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
