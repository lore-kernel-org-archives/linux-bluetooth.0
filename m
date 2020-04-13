Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03385C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0C820663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 20:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUA3t1O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgDMUZJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgDMUZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 16:25:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68914C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 13:25:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d63so8525139oig.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vn2CSGwk7cmeZKReGlL8AAXUKFvawEYYKDuPwX+nx4M=;
        b=GUA3t1O7mSmWC7tjmH63Vv45P1dO1pT6p1d1otwRVVIUVhyUKQ9te/vdFqXfZ2Vc8I
         TKp1XvbPGeSwSixynDTQhdQLe5Xpi0k8iwWuBwJYpTrUNqfwXdMNcg4Pe34qSVegrWmh
         OVujVKqj81nUuUEZYLwJc4P6OyRWyEuf/OOviDdXXGP3uVYQXbCipYvQxN11b/zU1FX+
         G5qPm8CJ5Dy3wntJzZ55LB5xA3m3wFOY6CuO58x9gvnNaa/8nRfd6hFM7sTrMX46Om5z
         PkMZyJzy6NdFpCPEsMqvELhLQZH/qJwfbso/kA8ScdmEG3EoBBDJaCd0mjzi4gQE7tRn
         ti5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vn2CSGwk7cmeZKReGlL8AAXUKFvawEYYKDuPwX+nx4M=;
        b=nlRwPGJCcTrzk1j2Lkb0O49cVUpP/TsyRGe0AQbZVcZHVLfykYTQhseZLtM3jeMD2J
         IeKUvg1e4vpjwU5nYdy9chH0em3SM2YLbk3O915F+isXc/5FSuTreEnOwdgAeUyDdg/l
         LO9ebFxonhtNV5p2ujx6+MOvAgqhanIzrrDaAuC+apiJPNJQDtPL8skY/rfedgDPZyip
         pDqyeh7LtYDFXB+ASPD12A+DySEKPdpJVNmipxoMw2nwuSuNn3b0uHyTH2I4sw9q56oj
         CuP8YK7O/rt81RwrWZiA29HD3AjcGpWk805t/6yt5BG1x+/mdubhLqP2MQhwV4HcRZnW
         VK6A==
X-Gm-Message-State: AGi0PuZQA2dNDu5gsFxcKK61JptOCGweX4pEOhcd5PRl+k5LaCZ1qQYX
        5izmrjvfPQX6MIazmP44e5dvmZm9WQXT750v0NQ=
X-Google-Smtp-Source: APiQypJ3RhMrnLgqIBj99QXzQECTs2BZCKKmoe8CVf7LWg/MJp9pKOghpWeGaKj8S6Y14lvhut3BgVBGp2FF4tn3HKg=
X-Received: by 2002:aca:db8a:: with SMTP id s132mr3061148oig.110.1586809507541;
 Mon, 13 Apr 2020 13:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org> <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali> <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
 <20200413171722.ilawhisu67onrifn@pali> <CABBYNZKFGjsnCnBPyw0WFr_aJ2zaYAjLj81t04S=fXaXD9ac+g@mail.gmail.com>
 <20200413175833.di53ucocat5tdrke@pali> <CABBYNZL4hr34svvF1Qdz5YA3fWwTex4cyX0PumVL_ARErKBo3w@mail.gmail.com>
 <20200413195034.2inyau3gkdxjoscu@pali>
In-Reply-To: <20200413195034.2inyau3gkdxjoscu@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 13:24:56 -0700
Message-ID: <CABBYNZ+M2y0pkcKgNWJRMniUgx6xEdXMfqAt91=HCVB64Hxecw@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 12:51 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 April 2020 12:41:44 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Mon, Apr 13, 2020 at 10:58 AM Pali Roh=C3=A1r <pali@kernel.org> wrot=
e:
> > >
> > > On Monday 13 April 2020 10:47:04 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, Apr 13, 2020 at 10:17 AM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
> > > > >
> > > > > On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Mon, Apr 13, 2020 at 9:52 AM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > > > > > >
> > > > > > > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote=
:
> > > > > > > > On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > > > > > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(str=
uct btd_service *service)
> > > > > > > > >  static char *get_hfp_hf_record(struct ext_profile *ext, =
struct ext_io *l2cap,
> > > > > > > > >                                                         s=
truct ext_io *rfcomm)
> > > > > > > > >  {
> > > > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b0=
00000 */
> > > > > > > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->cha=
n, ext->version,
> > > > > > > > > -                                               ext->name=
, ext->features);
> > > > > > > > > +                               ext->name,
> > > > > > > > > +                               ext->have_features ? ext-=
>features : 0x0);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static char *get_hfp_ag_record(struct ext_profile *ext, =
struct ext_io *l2cap,
> > > > > > > > >                                                         s=
truct ext_io *rfcomm)
> > > > > > > > >  {
> > > > > > > > > +       /* HFP 1.7.2: By default features bitfield is 0b0=
01001 */
> > > > > > > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->cha=
n, ext->version,
> > > > > > > > > -                                               ext->name=
, ext->features);
> > > > > > > > > +                               ext->name,
> > > > > > > > > +                               ext->have_features ? ext-=
>features : 0x9);
> > > > > > > >
> > > > > > > > I wonder why you didn't just initialize the features wiht 0=
x9 instead
> > > > > > > > of adding a flag to track it, btw add a define with value 0=
x09 like
> > > > > > > > HFP_DEFAULT_FEATURES that way it is clearer why we are doin=
g this.
> > > > > > >
> > > > > > > This function get_hfp_ag_record() is for parsing local featur=
es. You are
> > > > > > > right that for local features we do not need a flag to track =
it.
> > > > > > >
> > > > > > > But flag for tracking is needed for parsing remote features. =
And to have
> > > > > > > unified code for storing local and remote features it is easi=
er to have
> > > > > > > always a flag for checking if features were provided or not.
> > > > > >
> > > > > > Im not following you about the remote features beinf different,=
 I
> > > > > > though both would be could be initialized in the same way and t=
hen if
> > > > > > we read a different value from the SDP record we just overwrite=
 it.
> > > > >
> > > > > But in this case we put these default remote features to HFP DBus=
 agent
> > > > > like if they were specified in SDP. Default value is specific for
> > > > > profile version. And if e.g. new HFP version defines a new bit in
> > > > > features with its own default value then HFP DBus agent would not=
 be
> > > > > able to distinguish between state when remote device did not spec=
ified
> > > > > any value (as bluez will put there some defaults) and when remote=
 device
> > > > > specified same features as bluez has defined in its current defau=
lt
> > > > > value.
> > > >
> > > > Different version may have different defaults but we can initialize
> > > > them correctly.
> > >
> > > But we do not know default values for future versions which have not
> > > been released yet. There would be a problem if user run current
> > > bluez daemon e.g. in 5 years when new version of HFP profile would be
> > > released and remote device would use it.
> >
> > We would have to match what is the features that the agent can handle.
>
> But we do not know what features can agent handle. There is no API for
> it.

Yes we do, the version would tell exactly what features the agent can handl=
e.

> Agent which works in AG role accept connections from remote HF role.
> Agent register to bluez with AG role features. HF and AG features are
> different and bluez has absolutely no idea what features can agent
> accept from remote device.

The version needs to be compatible no matter if the features are
different for AG/HF.

> > > > > Before and also after this change remote features are not send to=
 HFP
> > > > > DBus agent when they were not specified by remote device.
> > > > >
> > > > > After your suggestion HFP DBus agent would not be able to check i=
f
> > > > > remote device provided features or not. And this is I think a
> > > > > regression.
> > > >
> > > > I don't think we can consider a regression to always provide featur=
es,
> > > > besides what would be the reason for the agent to know if the featu=
res
> > > > were from the SDP record or they are auto initiliazed?
> > >
> > > Autoinitialized for which version? Bluez has currently defined defaul=
t
> > > values for HFP 1.7. But DBus agent can register HFP profile also for
> > > version 1.5 or also 1.8.
> > >
> > > To which value should it be autoinitialized when remote device announ=
ce
> > > that is in version 1.8 but does not specify features (=3D default for
> > > version 1.8 should be used)? The only option which make sense is to n=
ot
> > > autoinitiaze this value as version 1.8 was not released yet and now w=
e
> > > do not know what would be the default value.
> >
> > We should probably use the mininum version of the client and server,
> > so if the device supports 1.8 but our agent is 1.5 it should default
> > to 1.5, this actually would have to be done anyway because othewise we
> > would make agents duplicating the logic of handling the features
> > properly so we might as well try to consolidate this on the daemon and
> > only expose the features that can actually be used in the session,
> > that means the autoinitilize logic the to take into account both the
> > device and agent version.
>
> And what would happen if both agent and remote device supports 1.8?

Then 1.8 defaults are used, if the daemon don't support 1.8 then the
agent cannot register for 1.8 to begin with.

> When remote device do specified features, default one should be used.
> So this cannot be solved with some default values in bluez.

Like I said before, bluez controls the SDP record so it will need to
understand what features are supported based on version, this is
exactly why we want the daemon to control the sdp record so we don't
have the agents dealing version compatibility, etc.

> > > > I that was
> > > > really necessary Id just dump the whole record as a ServiceRecord
> > > > option and leave it up to the client to parse it.
> > > >
> > > > > > > I can put these default values in profile-role specific macro=
s e.g.:
> > > > > > >
> > > > > > > #define HFP_AG_DEFAULT_FEATURES 0x09
> > > > > > > #define HFP_HF_DEFAULT_FEATURES 0x00
> > > > > > > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> > > > > >
> > > > > > Don't bother with default that are 0x00/false, we can assume th=
is is
> > > > > > implicit when allocating the memory everything is set to 0 so t=
hese
> > > > > > defines wouldn't be needed in the first place.
> > > > > >
> > > > > > > Or do you prefer different names?
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
