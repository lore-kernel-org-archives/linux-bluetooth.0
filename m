Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B8FC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DE2063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afoNjtlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgDMRrV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387424AbgDMRrS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 13:47:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9826C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 10:47:16 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j4so3306970otr.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTVvfznWZCG9UrzYtecKyNvF3hD7rLA/2v4zd50ELdo=;
        b=afoNjtlpxmujDaozcWlQAIBAosi2MNc2xpXmMoOwu09jVFYW9ERyVOkOVDqu85IJJt
         NoTR6+uEt7CN5FISY2nOV9SZUo+F6KKo1LexhT7uYJkDQIK89KaXwI7eXmT+sARKiBjp
         WsmZiXTBylyzD0momIb4xDUcmd5RFu6TWy+/WEZPA/mO11YJ103PjH6/wfK700WCwZ/e
         DiZ7oxnGrg1j/sICHNfpSyy6DdUbaV2AN8pQTnSWGxiw7WdkYDcUJy2DKdyH7LOqsVoj
         b23gfTkWihZjnxS357ZROQbt+1/6nQJIv3M1nrSrRz3+O2bsDf28waeaUrKTUYpgaqLR
         jK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTVvfznWZCG9UrzYtecKyNvF3hD7rLA/2v4zd50ELdo=;
        b=GTPioPn2kUAfOgiXKQJhuwMrlLyXsG0/H1P7JCSQebtbKhZ9cC/oRj3ACR/ZzKXBht
         523LLhndJd1BMHK+jq5W8r9cnl/RkLdcrHMk0M1jg9fdaLfJrWXTZw3TW5QubOMqMXlK
         O4h0cKG/yPPBdyepS8FZFeVUu+QjLwSICkLUTJJp95y0qBm4NuVhs2kr83Z29jEMDyG/
         R7hxqJap0hS7Hc5m+Aguv75Bk1sv6xXg9Tb7zEmWGeF1YCtuXO5etF9MWUMJpLSQOG46
         7PHBl8n+oJL4QuGfQ7AyYz+PIFTsAS33T0XVsL4vvPHUdAXpoTWhUzJk15fQ9Dj92BD8
         uZCg==
X-Gm-Message-State: AGi0PuZpoceISF7qyP/6K469lDHO57ofEKn3agAfxvTkJgEywpiGxLPh
        uu17tDwWsWoP/nDsYm4OAWT7k2v2ikkbERMaGkJIvx0AuIw=
X-Google-Smtp-Source: APiQypJwbmvp9jUfneFG6LD2iO0IXxMToFbH533s6MIJTT/tDFvu7fx4/r9acJk8iSL0tTB5E7R0XNGUswFi6R00eug=
X-Received: by 2002:a4a:be89:: with SMTP id o9mr8875656oop.20.1586800036070;
 Mon, 13 Apr 2020 10:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org> <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali> <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
 <20200413171722.ilawhisu67onrifn@pali>
In-Reply-To: <20200413171722.ilawhisu67onrifn@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 10:47:04 -0700
Message-ID: <CABBYNZKFGjsnCnBPyw0WFr_aJ2zaYAjLj81t04S=fXaXD9ac+g@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 10:17 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 April 2020 09:58:34 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Mon, Apr 13, 2020 at 9:52 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote:
> > > > On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
> > > > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_=
service *service)
> > > > >  static char *get_hfp_hf_record(struct ext_profile *ext, struct e=
xt_io *l2cap,
> > > > >                                                         struct ex=
t_io *rfcomm)
> > > > >  {
> > > > > +       /* HFP 1.7.2: By default features bitfield is 0b000000 */
> > > > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->=
version,
> > > > > -                                               ext->name, ext->f=
eatures);
> > > > > +                               ext->name,
> > > > > +                               ext->have_features ? ext->feature=
s : 0x0);
> > > > >  }
> > > > >
> > > > >  static char *get_hfp_ag_record(struct ext_profile *ext, struct e=
xt_io *l2cap,
> > > > >                                                         struct ex=
t_io *rfcomm)
> > > > >  {
> > > > > +       /* HFP 1.7.2: By default features bitfield is 0b001001 */
> > > > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->=
version,
> > > > > -                                               ext->name, ext->f=
eatures);
> > > > > +                               ext->name,
> > > > > +                               ext->have_features ? ext->feature=
s : 0x9);
> > > >
> > > > I wonder why you didn't just initialize the features wiht 0x9 inste=
ad
> > > > of adding a flag to track it, btw add a define with value 0x09 like
> > > > HFP_DEFAULT_FEATURES that way it is clearer why we are doing this.
> > >
> > > This function get_hfp_ag_record() is for parsing local features. You =
are
> > > right that for local features we do not need a flag to track it.
> > >
> > > But flag for tracking is needed for parsing remote features. And to h=
ave
> > > unified code for storing local and remote features it is easier to ha=
ve
> > > always a flag for checking if features were provided or not.
> >
> > Im not following you about the remote features beinf different, I
> > though both would be could be initialized in the same way and then if
> > we read a different value from the SDP record we just overwrite it.
>
> But in this case we put these default remote features to HFP DBus agent
> like if they were specified in SDP. Default value is specific for
> profile version. And if e.g. new HFP version defines a new bit in
> features with its own default value then HFP DBus agent would not be
> able to distinguish between state when remote device did not specified
> any value (as bluez will put there some defaults) and when remote device
> specified same features as bluez has defined in its current default
> value.

Different version may have different defaults but we can initialize
them correctly.

> Before and also after this change remote features are not send to HFP
> DBus agent when they were not specified by remote device.
>
> After your suggestion HFP DBus agent would not be able to check if
> remote device provided features or not. And this is I think a
> regression.

I don't think we can consider a regression to always provide features,
besides what would be the reason for the agent to know if the features
were from the SDP record or they are auto initiliazed? I that was
really necessary Id just dump the whole record as a ServiceRecord
option and leave it up to the client to parse it.

> > > I can put these default values in profile-role specific macros e.g.:
> > >
> > > #define HFP_AG_DEFAULT_FEATURES 0x09
> > > #define HFP_HF_DEFAULT_FEATURES 0x00
> > > #define HSP_HS_DEFAULT_VOLCNTRL "false"
> >
> > Don't bother with default that are 0x00/false, we can assume this is
> > implicit when allocating the memory everything is set to 0 so these
> > defines wouldn't be needed in the first place.
> >
> > > Or do you prefer different names?
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
