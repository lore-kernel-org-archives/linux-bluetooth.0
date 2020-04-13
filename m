Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4D6C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B7206DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGibPbpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbgDMVHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbgDMVH2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 17:07:28 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B0C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 14:07:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u20so8610975oic.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xxftBVKbZu2TqjaLIWvFCvI/47Oa5SsdL8vM0yAVeTE=;
        b=BGibPbpMEjXpX6i5lVNR2jaSpL1P6UiXruEw0fQtoocj5TEunv8LzZ5W6Vy4rvDFqh
         1UnT095LD3aAnSK4KuI7lr2sujhBiSY756M1vxPyz2QCKFihfYHbqIetgC6hfvGkD/W1
         cpmOkHdxrrYakh7LqJDC8SHT14av42wTEmBSpH0i7xeU2a9hqmXt5o1CP1bOxj0nnQbe
         fIk9CrYOtaha5V8ykYdS63KTEbeKn8H3H+WEcIj4+vhoGiaJW0L37HeEcTB836rH7xEt
         pSLblWcHOdFgDE2qQvxnRERwYJhzV+U4+owgqu/a4b1XIdAq3VjBC+phfCEDx7978LKJ
         PUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxftBVKbZu2TqjaLIWvFCvI/47Oa5SsdL8vM0yAVeTE=;
        b=ArkwVfOUn2X1V99OVaCzE0J5p/nThREG6d3E2ZU2vEV94KUSBOJREcLgbSnIfR+xp4
         hbD81Oy5avRW0vbLvQalox+Nk8vx11rKIHeD3sPWKN45FF+wOkZ8BMtk/BfKySsAgO24
         Ep3xiOC3sdrw12NC1APwJkzw79U4Llmptvx5w+6s3th8uV+mJNq2rtcgd1qLR516DZhj
         HEM7n12/JWa47JzL2IqExpkz1iH6vpJNIuPHiKq+EwrQk14UGzr2zuthpSc4MUZ/FsIV
         UoVMN2oI7Gv4Q1aYp/qYlos3yKqaIKyuDY0B+OFV3Ty8nq9Ii/Jv1mJqtrhceS9ILNvY
         a0wg==
X-Gm-Message-State: AGi0PuYpEQYPgW2sjPDIyWFBAoah25wCGZWO9615YgpCLKgweWpKfAL+
        NCT1/SzfDqqw/C7FlYY+n1e1mefiJIijS/ePOtE=
X-Google-Smtp-Source: APiQypLE4Fk5TulpuTJwRiQuV4wJAldi7VOHKYq9K7FiLc2+5yR0cI2pv2gn/LIOvjZS2Q2+g4Xb4cUFY7P05lwxDDs=
X-Received: by 2002:aca:b602:: with SMTP id g2mr12793268oif.82.1586812047454;
 Mon, 13 Apr 2020 14:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200413162513.2221-2-pali@kernel.org> <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali> <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
 <20200413171722.ilawhisu67onrifn@pali> <CABBYNZKFGjsnCnBPyw0WFr_aJ2zaYAjLj81t04S=fXaXD9ac+g@mail.gmail.com>
 <20200413175833.di53ucocat5tdrke@pali> <CABBYNZL4hr34svvF1Qdz5YA3fWwTex4cyX0PumVL_ARErKBo3w@mail.gmail.com>
 <20200413195034.2inyau3gkdxjoscu@pali> <CABBYNZ+M2y0pkcKgNWJRMniUgx6xEdXMfqAt91=HCVB64Hxecw@mail.gmail.com>
 <20200413204215.gmbs2mdfwny5m2s2@pali>
In-Reply-To: <20200413204215.gmbs2mdfwny5m2s2@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 14:07:15 -0700
Message-ID: <CABBYNZLmE1D0sUpxwLJ=2++_Be18LBWj=2KwSyLs+tSAStAE2w@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 1:42 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 April 2020 13:24:56 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Mon, Apr 13, 2020 at 12:51 PM Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > >
> > > On Monday 13 April 2020 12:41:44 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, Apr 13, 2020 at 10:58 AM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
> > > > >
> > > > > On Monday 13 April 2020 10:47:04 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Mon, Apr 13, 2020 at 10:17 AM Pali Roh=C3=A1r <pali@kernel.o=
rg> wrote:
> > > > > > >
> > > > > > > On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote=
:
> > > > > > > > Hi Pali,
> > > > > > > >
> > > > > > > > On Mon, Apr 13, 2020 at 9:52 AM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > > > > > > >
> > > > > > > > > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz w=
rote:
> > > > > > > > > > On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@k=
ernel.org> wrote:
> > > > > > > > > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev=
(struct btd_service *service)
> > > > > > > > > > >  static char *get_hfp_hf_record(struct ext_profile *e=
xt, struct ext_io *l2cap,
> > > > > > > > > > >                                                      =
   struct ext_io *rfcomm)
> > > > > > > > > > >  {
> > > > > > > > > > > +       /* HFP 1.7.2: By default features bitfield is=
 0b000000 */
> > > > > > > > > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm-=
>chan, ext->version,
> > > > > > > > > > > -                                               ext->=
name, ext->features);
> > > > > > > > > > > +                               ext->name,
> > > > > > > > > > > +                               ext->have_features ? =
ext->features : 0x0);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static char *get_hfp_ag_record(struct ext_profile *e=
xt, struct ext_io *l2cap,
> > > > > > > > > > >                                                      =
   struct ext_io *rfcomm)
> > > > > > > > > > >  {
> > > > > > > > > > > +       /* HFP 1.7.2: By default features bitfield is=
 0b001001 */
> > > > > > > > > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm-=
>chan, ext->version,
> > > > > > > > > > > -                                               ext->=
name, ext->features);
> > > > > > > > > > > +                               ext->name,
> > > > > > > > > > > +                               ext->have_features ? =
ext->features : 0x9);
> > > > > > > > > >
> > > > > > > > > > I wonder why you didn't just initialize the features wi=
ht 0x9 instead
> > > > > > > > > > of adding a flag to track it, btw add a define with val=
ue 0x09 like
> > > > > > > > > > HFP_DEFAULT_FEATURES that way it is clearer why we are =
doing this.
> > > > > > > > >
> > > > > > > > > This function get_hfp_ag_record() is for parsing local fe=
atures. You are
> > > > > > > > > right that for local features we do not need a flag to tr=
ack it.
> > > > > > > > >
> > > > > > > > > But flag for tracking is needed for parsing remote featur=
es. And to have
> > > > > > > > > unified code for storing local and remote features it is =
easier to have
> > > > > > > > > always a flag for checking if features were provided or n=
ot.
> > > > > > > >
> > > > > > > > Im not following you about the remote features beinf differ=
ent, I
> > > > > > > > though both would be could be initialized in the same way a=
nd then if
> > > > > > > > we read a different value from the SDP record we just overw=
rite it.
> > > > > > >
> > > > > > > But in this case we put these default remote features to HFP =
DBus agent
> > > > > > > like if they were specified in SDP. Default value is specific=
 for
> > > > > > > profile version. And if e.g. new HFP version defines a new bi=
t in
> > > > > > > features with its own default value then HFP DBus agent would=
 not be
> > > > > > > able to distinguish between state when remote device did not =
specified
> > > > > > > any value (as bluez will put there some defaults) and when re=
mote device
> > > > > > > specified same features as bluez has defined in its current d=
efault
> > > > > > > value.
> > > > > >
> > > > > > Different version may have different defaults but we can initia=
lize
> > > > > > them correctly.
> > > > >
> > > > > But we do not know default values for future versions which have =
not
> > > > > been released yet. There would be a problem if user run current
> > > > > bluez daemon e.g. in 5 years when new version of HFP profile woul=
d be
> > > > > released and remote device would use it.
> > > >
> > > > We would have to match what is the features that the agent can hand=
le.
> > >
> > > But we do not know what features can agent handle. There is no API fo=
r
> > > it.
> >
> > Yes we do, the version would tell exactly what features the agent can h=
andle.
>
> No. Endpoints (local agent or remote device) does not have to support
> all features provided by version. This is why feature list exist.

Support no, understand yes, it must understand all the values exposed
by the remote features if it support the version, and here Im
suggesting just the default values so it surprises me the sort
assertive tone.

> > > Agent which works in AG role accept connections from remote HF role.
> > > Agent register to bluez with AG role features. HF and AG features are
> > > different and bluez has absolutely no idea what features can agent
> > > accept from remote device.
> >
> > The version needs to be compatible no matter if the features are
> > different for AG/HF.
>
> This is not truth. Version X is compatible with all versions less then
> X. So if remote device support version 1.5, then it can connect to our
> local dbus agent which is running at version 1.7. And version 1.7 is
> registered to bluez. In HFP spec is written how implementation should
> deal with this backward compatibility. It is at protocol level, so it
> cannot be done in bluez, only in application which implements HFP
> protocol, therefore external DBus HFP agent.

Yes it needs to be backward compatible, but what Im saying is that the
agent need to be able to understand the features bits, how else would
then it goes and enable events, etc, via AT commands, and actually
although your protocol can handle 1.7 the remote side may only be
handling 1.5 features then essentially all features are limited to
1.5. Im not sure why we always come to this bits and pieces in our
discussions, it is as if I was not involved with any of this in the
past, I know pretty well how HFP operates, in fact most profiles work
in the same way regarding the version, the record only indicates what
is maximum supported version and all version previous to that shall
work so at protocol level you just downgrade the version according to
what both sides can supports, what we cannot do is to upgrade the
version so features from e.g. 1.8 shall never creep into the features
bits since they wouldn't be compatible.

> > > > > > > Before and also after this change remote features are not sen=
d to HFP
> > > > > > > DBus agent when they were not specified by remote device.
> > > > > > >
> > > > > > > After your suggestion HFP DBus agent would not be able to che=
ck if
> > > > > > > remote device provided features or not. And this is I think a
> > > > > > > regression.
> > > > > >
> > > > > > I don't think we can consider a regression to always provide fe=
atures,
> > > > > > besides what would be the reason for the agent to know if the f=
eatures
> > > > > > were from the SDP record or they are auto initiliazed?
> > > > >
> > > > > Autoinitialized for which version? Bluez has currently defined de=
fault
> > > > > values for HFP 1.7. But DBus agent can register HFP profile also =
for
> > > > > version 1.5 or also 1.8.
> > > > >
> > > > > To which value should it be autoinitialized when remote device an=
nounce
> > > > > that is in version 1.8 but does not specify features (=3D default=
 for
> > > > > version 1.8 should be used)? The only option which make sense is =
to not
> > > > > autoinitiaze this value as version 1.8 was not released yet and n=
ow we
> > > > > do not know what would be the default value.
> > > >
> > > > We should probably use the mininum version of the client and server=
,
> > > > so if the device supports 1.8 but our agent is 1.5 it should defaul=
t
> > > > to 1.5, this actually would have to be done anyway because othewise=
 we
> > > > would make agents duplicating the logic of handling the features
> > > > properly so we might as well try to consolidate this on the daemon =
and
> > > > only expose the features that can actually be used in the session,
> > > > that means the autoinitilize logic the to take into account both th=
e
> > > > device and agent version.
> > >
> > > And what would happen if both agent and remote device supports 1.8?
> >
> > Then 1.8 defaults are used, if the daemon don't support 1.8 then the
> > agent cannot register for 1.8 to begin with.
>
> bluez daemon does not implement HFP profile. It is external DBus agent
> which implements it. Bluez provides just some default values for SDP
> records, but external DBus agent can provide own SDP values including
> version number and feature list.

Yes and in order to construct a valid SDP record it needs to
understand the version and features.

> So default version numberin bluez is meaningless for HFP implementation
> in external DBus agent.
>
> > > When remote device do specified features, default one should be used.
> > > So this cannot be solved with some default values in bluez.
> >
> > Like I said before, bluez controls the SDP record so it will need to
> > understand what features are supported based on version, this is
>
> Why it needs to know it? It just export SDP features which agent can
> provides on its own. Bluez is not doing more then providing SDP records.

Read above, we still need to construct a valid SDP record, this
shouldn't be a big change compared to what you already have all we
would be doing is:

1. version =3D MIN(remote_version, local_version)
2. features =3D  default_features(version)
3. features =3D get_features()
4. NewConnectiion(version, features)

Then all the agents out there would don't need to keep doing on their own.

> > exactly why we want the daemon to control the sdp record so we don't
> > have the agents dealing version compatibility, etc.
> >
> > > > > > I that was
> > > > > > really necessary Id just dump the whole record as a ServiceReco=
rd
> > > > > > option and leave it up to the client to parse it.
> > > > > >
> > > > > > > > > I can put these default values in profile-role specific m=
acros e.g.:
> > > > > > > > >
> > > > > > > > > #define HFP_AG_DEFAULT_FEATURES 0x09
> > > > > > > > > #define HFP_HF_DEFAULT_FEATURES 0x00
> > > > > > > > > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> > > > > > > >
> > > > > > > > Don't bother with default that are 0x00/false, we can assum=
e this is
> > > > > > > > implicit when allocating the memory everything is set to 0 =
so these
> > > > > > > > defines wouldn't be needed in the first place.
> > > > > > > >
> > > > > > > > > Or do you prefer different names?
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
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
