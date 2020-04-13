Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0405C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DEC2076D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8zvawOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgDMQ6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732208AbgDMQ6q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:58:46 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92949C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:58:46 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id q204so7892777oia.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iIC18xqv8mJ+jtiKs5Ml0e1e1tGeah+PUP1Zuz+kQnM=;
        b=r8zvawObCiiG8jjrkYEzlbZJJ8/+i2St7UBY84fTYhM2SlSNBpKnkNeoa/ohWOh5lk
         81Cg2UlsT1YBfFArBuieXyk8qkYszKm/0Zm2Hc68O3YMlqdNqK8sl+9RA2R69Kd+7mnS
         vAVwvvga0nV0s3cJ8DEnuyDree5ZfABzZmNgboO/42LyTJopivfIykh0AXFnc5rAs6TI
         m7ELM4nBoM1hbGv/McBE2RDedsXYVMv8U0YTS6Uxihzet/Q4iYtUPEeKItJgaHy/hW8v
         HaZZ/eJncOFwFij4G6eHZ18TRIX2JrpnEdEuNQpJYnRKs4T9LNSpnVeKt9mob189uE83
         58fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iIC18xqv8mJ+jtiKs5Ml0e1e1tGeah+PUP1Zuz+kQnM=;
        b=CIdHxcPwH+Sfo2CXfyrZfh7KP5DlNIWT1GxSQvgTEugPXCCfVvL+qW+/QTOwQ/qX4p
         iEX0Dx7ndUGI2/ocZ7QDWgbkJW+BNe3o3kUPsv1Rhb8E+YE2AO5xyagHIJ3mia7n/0GW
         wv1arLTsF5/Aia42qmxf347ks3QoY0jEt8iQRjYcA4boVisAjIqqOnFz9dQRROB6d4vM
         lAt+bvtSQKQSWgaoICsatD7egqyCYZI+urV+t7wJspHs6uDcfTtRPq4l5ebKoLi3iVXy
         RzZnDBIAwiLcDXV+B/b2fErzavpL08fAquKqZEYrz4SoirFzu0GiUiSqqoKENgJBAtFw
         hS+w==
X-Gm-Message-State: AGi0PuZdE0p5VBpzDqbSBLFVR+je+2LxYwASXEJMty5iqM2TrEbzwWVv
        6//7+AGUTSKdUPPYjjiTeo90z7HF3sMN5kZmnb8=
X-Google-Smtp-Source: APiQypLMyuXWqELsWPOJ9Eao3OsG5KZXXANv8preuAvPvt2KPdeUNQlCk/i05zVxljdeOUejVd41+SiaYzyk+/8bwB8=
X-Received: by 2002:aca:f584:: with SMTP id t126mr10631652oih.108.1586797125874;
 Mon, 13 Apr 2020 09:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <20200413162513.2221-2-pali@kernel.org> <CABBYNZKneybjWDEddrCXxtzJdGZSY__D7qtPuw25QMLDE9hg4Q@mail.gmail.com>
 <20200413165206.xluhkwi76cfpiv7z@pali>
In-Reply-To: <20200413165206.xluhkwi76cfpiv7z@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 09:58:34 -0700
Message-ID: <CABBYNZJYj=i4+SemOAST18Jn20Nn03C_NyfB+aBLc5L9Yg11_A@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 9:52 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 13 April 2020 09:44:14 Luiz Augusto von Dentz wrote:
> > On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > > @@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_serv=
ice *service)
> > >  static char *get_hfp_hf_record(struct ext_profile *ext, struct ext_i=
o *l2cap,
> > >                                                         struct ext_io=
 *rfcomm)
> > >  {
> > > +       /* HFP 1.7.2: By default features bitfield is 0b000000 */
> > >         return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->vers=
ion,
> > > -                                               ext->name, ext->featu=
res);
> > > +                               ext->name,
> > > +                               ext->have_features ? ext->features : =
0x0);
> > >  }
> > >
> > >  static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_i=
o *l2cap,
> > >                                                         struct ext_io=
 *rfcomm)
> > >  {
> > > +       /* HFP 1.7.2: By default features bitfield is 0b001001 */
> > >         return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->vers=
ion,
> > > -                                               ext->name, ext->featu=
res);
> > > +                               ext->name,
> > > +                               ext->have_features ? ext->features : =
0x9);
> >
> > I wonder why you didn't just initialize the features wiht 0x9 instead
> > of adding a flag to track it, btw add a define with value 0x09 like
> > HFP_DEFAULT_FEATURES that way it is clearer why we are doing this.
>
> This function get_hfp_ag_record() is for parsing local features. You are
> right that for local features we do not need a flag to track it.
>
> But flag for tracking is needed for parsing remote features. And to have
> unified code for storing local and remote features it is easier to have
> always a flag for checking if features were provided or not.

Im not following you about the remote features beinf different, I
though both would be could be initialized in the same way and then if
we read a different value from the SDP record we just overwrite it.

> I can put these default values in profile-role specific macros e.g.:
>
> #define HFP_AG_DEFAULT_FEATURES 0x09
> #define HFP_HF_DEFAULT_FEATURES 0x00
> #define HSP_HS_DEFAULT_VOLCNTRL "false"

Don't bother with default that are 0x00/false, we can assume this is
implicit when allocating the memory everything is set to 0 so these
defines wouldn't be needed in the first place.

> Or do you prefer different names?



--=20
Luiz Augusto von Dentz
