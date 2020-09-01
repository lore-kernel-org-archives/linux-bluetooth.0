Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A46C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1454B208CA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0vyufV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgIARrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIARra (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 13:47:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0637C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 10:47:29 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j21so1893299oii.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBa4zSsC7mmvdX3MM5YBiZhyDeDh3CNd56AtQwupmoA=;
        b=X0vyufV04Cvvr6FFJ3aETHrb/NoC3lWzm1Eb9kMd8Kun4dZ93mAoxtOWxEoyUVq3Fz
         XdiLrRGbKoOrKxAJuJNkuKDOEreMNdUgJUf4WdfbwtAbSSOWx7/JKLalBTEnZOQULgoV
         y9M0siiBImjaRldkPAnjUXYt19u6e2gxkOZPmYDidWflMgvHeJmAqcjl13i8a8MzKB6d
         86T/xoFEC33sekkFmTfvvBwEdp+vzx6oMPq7dhM6cK2dvSPrylWgPRW+/W/9pGOdMZk9
         v88Tpv/GKKqYZQAHOdk2G2XkIvENbMTsaGlwS1R/XX/BmldfwC5DHK2+88oKk9VAOyz6
         bFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBa4zSsC7mmvdX3MM5YBiZhyDeDh3CNd56AtQwupmoA=;
        b=mZK5nl/nhr9Jcvt8TlrQXn8UR0Fh/Y0lePu7EoOaNfcVYnEuoigcAkh5jxHrf3APpR
         z2Fda/OHgMpEJ+ssqe1MxHTJ0mt2pNYnBeq5dSDysS4ZAmCwI01MFnWxsvNwPN4ZGl28
         0s/5/rFE0JCEOfVlrcwtfdT0kQJzObHqEM2NxMQlsbjhQTRaqV96VAUCjQlrf5s8sd6n
         ac8k+l9Bg/Z/aF3fDSnYK/J2OoW96hkI1j/rAHKU2XgKPd4/XNHFZiq/m/G6E8jS/sK0
         Lp9Smwrba5FZpOSG3QueddHg8L+SilM9XtwvcjvW2zm1jVc8eScn7fiIdOvmFT8FlAfg
         Gf7Q==
X-Gm-Message-State: AOAM531G9XkolFLzhHbbPGfF/ytG8nyK/RR/+aSbUDmTSsDBgnCbnA0q
        3LpKhqtAe/cB4yf3dojRwAQMUC2nMvuvtKwFbao=
X-Google-Smtp-Source: ABdhPJxXL/aJxj8HMruY2b8PhLvLnMf36eDoYI8E6GbEXHXzNDRvIzrYa7A9by477MXaEe30UYAvL8n27xGMjXq/I+s=
X-Received: by 2002:a05:6808:913:: with SMTP id w19mr1759257oih.48.1598982449016;
 Tue, 01 Sep 2020 10:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
 <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
 <CAHC-ybxFY_3HWrvnwF5DS-i-YJtYpUuR9K3-MSWJWo=C-CKQHA@mail.gmail.com> <CALWDO_Wsyx3s3SwBejAFdc6SFX=V29DnvPKmo48hd-yy9SqHSg@mail.gmail.com>
In-Reply-To: <CALWDO_Wsyx3s3SwBejAFdc6SFX=V29DnvPKmo48hd-yy9SqHSg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Sep 2020 10:47:19 -0700
Message-ID: <CABBYNZJxjYUvui7e-S4TGx21W2U9QvmXhyKNOaWg3RLR4jWg2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Yu Liu <yudiliu@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Tue, Sep 1, 2020 at 8:43 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Marcel/Luiz,
>
> I'd be particularly interested in seeing your opinion on whether this could be better described as some form of SCO socket property... even if this is indeed an adapter property.

Yep, but wasn't that supposed to be what BT_PKT_STATUS is for? I mean
one can just attempt to read it with getsockopt and in case of returns
an error it means the controller does not support it, that said it
doesn't look like we do check the adapter features when using
BT_PKT_STATUS, should that be checking if HCI_WIDEBAND_SPEECH_ENABLED
is set?

Also it doesn't seem we have updated userspace to support
BT_PKT_STATUS, we should probably have something to test it via
isotest and perhaps create a iso-tester.c to validate all the options.

> Thanks,
> Alain
>
> On Mon, Aug 31, 2020 at 5:44 PM Yu Liu <yudiliu@google.com> wrote:
>>
>> +Alain Michaud
>>
>> Hi Marcel,
>>
>> Can you please comment on the cl as well as Luiz's suggestion? Thanks.
>>
>> On Thu, Aug 20, 2020 at 10:20 AM Yu Liu <yudiliu@google.com> wrote:
>> >
>> > Friendly ping for comments from Marcel. Thanks.
>> >
>> >
>> > On Mon, Aug 17, 2020 at 4:17 PM Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> > >
>> > > Hi Marcel,
>> > >
>> > > On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
>> > > >
>> > > > From: Archie Pusaka <apusaka@chromium.org>
>> > > >
>> > > > Initially this is introduced to query whether WBS is supported by the adapter,
>> > > > the API is generic enough to be extended to support querying others in
>> > > > the future.
>> > > >
>> > > > Reviewed-by: sonnysasaka@chromium.org
>> > > >
>> > > > Signed-off-by: Yu Liu <yudiliu@google.com>
>> > > > ---
>> > > >
>> > > > Changes in v2:
>> > > > - Return an array of strings instead of a dict
>> > > >
>> > > > Changes in v1:
>> > > > - Initial change
>> > > >
>> > > >  doc/adapter-api.txt | 12 ++++++++++++
>> > > >  1 file changed, 12 insertions(+)
>> > > >
>> > > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> > > > index 1a7255750..8fbcadb54 100644
>> > > > --- a/doc/adapter-api.txt
>> > > > +++ b/doc/adapter-api.txt
>> > > > @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
>> > > >                                          org.bluez.Error.NotReady
>> > > >                                          org.bluez.Error.Failed
>> > > >
>> > > > +               array{string} GetCapabilities()
>> > > > +
>> > > > +                       This method returns a list of supported
>> > > > +                       capabilities that is populated when the adapter
>> > > > +                       initiated.
>> > > > +
>> > > > +                       Possible values:
>> > > > +                               "wbs" - Wide band speech
>> > >
>> > > Btw, should we stick to use wbs terminology here, or we should
>> > > actually use the HCI feature/command, because wbs has actually to be
>> > > implemented by the HFP afaik this is only indicating that the
>> > > controller is able to notify packets drops, etc, with use of erroneous
>> > > command. Perhaps we should actually use the term PLC (Packet Loss
>> > > Concealment) instead since that seems to be the real capability here,
>> > > afaik WBS does not actually require PLC.
>> > >
>> > > > +
>> > > > +                       Possible errors: org.bluez.Error.NotReady
>> > > > +                                        org.bluez.Error.Failed
>> > > > +
>> > > >  Properties     string Address [readonly]
>> > > >
>> > > >                         The Bluetooth device address.
>> > > > --
>> > > > 2.28.0.220.ged08abb693-goog
>> > > >
>> > >
>> > >
>> > > --
>> > > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
