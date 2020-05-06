Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A7C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC2D20936
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuUSEpoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEFQxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729341AbgEFQxq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 12:53:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBEDC061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 09:53:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j14so1938214lfg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3zclPtanI5YavVi5CSVOV6oUE2I4cP+WOlXvvv8wrvU=;
        b=WuUSEpoD8GFjUfcfCYefGWJlU30LJfbf1Jxix912QNdFcvDe0yY+/q2v4E9fqndTIh
         YmArIv/NKNwehCYBmTpSLBo4bW45Igjnqyri25Fc72/14LJpibHrS5cIM0UbAEUC7l7K
         ZhWlppkpdh4FOjdpE9PV49/pJ0n0uM06j6F55ew5bNelMlUsHxNHyucl8S6POCNNgl6N
         BQbUTcdn8uyjxV3IUVdgjosNYigpr5nTsXyXzUKCYZDGd7V82qZ4MyE1CCJ8uj1igGfl
         INsx5DpBirqymwLD/cA4qQ2Wdh8LT+xU7IOCBNSNGhACh/CrykEtBk+E4M1cSocZcFra
         4x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3zclPtanI5YavVi5CSVOV6oUE2I4cP+WOlXvvv8wrvU=;
        b=YOip7qeEdBkroRKo6hdl/Qysmq3pSum/hm+MafLzCKykfu12+jJsHzcX7ycZk5NYCx
         7u2h8HolIOUscE1F1TmM+xJmDII6sI7TQPk+nFjDGUBVho5m7u4dBVTmYH+fMg6dWARc
         rkzww79jUxf+YAY/gq+YyRKtxCO8Fj2l43VFFaQTV0m0F/7Tno30izfV61vdEaW8rYur
         OGW50+eVaNC4fjtGKquHWvWxjjWvCSFSELqRs1mSK7rQk7u5tcFBJlIeAuhQtEaEI8WQ
         pN/MF99SA1OwlLowZ/uUb/dUdUkjzL7vS5rq5jMpDwGexVNuTSNbULpWcZmanIfOu8pw
         ycHQ==
X-Gm-Message-State: AGi0PuboXP7JPThl9DylUXp3IF6uAlBBCbNUJLVw5zKga6iWlo7T6d4T
        d9sP9HZuN9WHRqB4uA4jj/hS4KFSglD0dD/IWUaHFg==
X-Google-Smtp-Source: APiQypLAximuMQKiUt7wEKaElU5Mi1dil2/XOl5f26nMWZhqJI9bAxW6qwy3Rh4fnOz3nLFShaBvrG9jnKbbeeksFgA=
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr5887668lfe.158.1588784023175;
 Wed, 06 May 2020 09:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200403153331.101846-1-alainm@chromium.org> <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
 <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
 <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
 <CALWDO_Ux+=YtWsvnNxwpO7W_PSbAmUukyh6MHUoBqStNF7qC2Q@mail.gmail.com>
 <CALWDO_UJtMpTmvWj6KsAJkwzDE=ZXA_bq2Cp2DR-gcBgvQT0cA@mail.gmail.com>
 <CALWDO_WpiztCRau98_eFegrCKNsK4VigKQhw7kvyzFgKLm3NZA@mail.gmail.com>
 <CABBYNZJq43bjTneJ9wsCpzfMWHOGdZyhBFTDfAZcYUWFCv5brQ@mail.gmail.com>
 <CALWDO_XXb8riTsVfVTsYngYwY3u6sZeHDLP9Es8DnfBJfzgkGg@mail.gmail.com>
 <CABBYNZKf2pBSEmBQvLg9Yoy7rR-TfPbokac=mm=wzNo1gwo0YA@mail.gmail.com> <075F8853-744B-44F9-B92D-3AE764832C07@holtmann.org>
In-Reply-To: <075F8853-744B-44F9-B92D-3AE764832C07@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 6 May 2020 12:53:31 -0400
Message-ID: <CALWDO_VN0WY7p-MibNhAa_pO5SL6iwdvMMD=dz80VjFYGDrjFg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Indeed, we do have the packet_msg patch to carry the erroneous data
flag.  We will send results once validated.

However, the profile implementation will still need to know if
erroneous data reporting is enabled/supported and that the USB driver
is correctly using the alt setting on the USB isoch endpoint. As a
result, we still need to carry some form of notification that all of
these things are supported from kernel below.  Again, this is a
controller attribute, not a connection attribute so it may best be
served outside of the sco socket.

Thanks,
Alain

On Wed, May 6, 2020 at 12:43 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >>>>>>>>>>>>> This change adds an adapter Api to report the controller's
> >>>>>>>>>>>>> widebandspeech enabled state.
> >>>>>>>>>>>
> >>>>>>>>>>> I wonder if this shouldn't be queried over SCO socket, or sim=
ple fail
> >>>>>>>>>>> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how wh=
at is
> >>>>>>>>>>> normally used when using mSBC.
> >>>>>>>>>>
> >>>>>>>>>> I think there is value in both.
> >>>>>>>>>
> >>>>>>>>> Can you expand on that? I think this might generate confusion i=
f the
> >>>>>>>>> property indicates support for it but HFP implementation don't =
support
> >>>>>>>>> it, since the later is usually implemented as a external profil=
e so we
> >>>>>>>>> don't have the features it may support, or perhaps the intentio=
n here
> >>>>>>>>> is to actually indicate when it is in use?
> >>>>>>>>
> >>>>>>>> This is a signal that the adapter supports it and has everything
> >>>>>>>> enabled to support it.   Driver indicated it supports it and err=
oneous
> >>>>>>>> data reporting was enabled.  The profile has it's own state whic=
h may
> >>>>>>>> indicate if msbc will be used, but this will be on a per connect=
ion
> >>>>>>>> basis and is independent from this adapter property.
> >>>>>>>>
> >>>>>>>> The value in this property is to support diagnostic UX about
> >>>>>>>> controller capabilities/state and also allow profiles that are
> >>>>>>>> implemented outside of bluetoothd to see which codec it can atte=
mpt to
> >>>>>>>> negotiate with the device.
> >>>>>>>
> >>>>>>> For diagnosic I think we would be better off with some dedicated
> >>>>>>> interface to query this, as for the later the information we are
> >>>>>>> giving does not actually tell anything about the codec support, w=
hich
> >>>>>>> was part of my original argument that for the likes of HFP and ot=
her
> >>>>>>> profiles using it it might not be enough and they still need to u=
se
> >>>>>>> BT_VOICE in order to enable the use of custom codecs, if you take
> >>>>>>> ofono for example it does implement support for wideband speech
> >>>>>>> already and it would completely disregard this property which can=
 give
> >>>>>>> the false impression that wideband speech cannot be activated whe=
n in
> >>>>>>> fact it can, it just don't have erroneous data reporting enable, =
so
> >>>>>>> perhaps we should indicate the actual adapter feature (e.g.
> >>>>>>> ErrnoneousDataReporting) not the profile feature here, so the pro=
file
> >>>>>>> implementation can check weather this would disable use of wideba=
nd
> >>>>>>> speech or not, futhermore we should probably report the errors ba=
ck to
> >>>>>>> the SCO socket or is that just for diagnostic and cannot be used =
to
> >>>>>>> adjust the streaming?
> >>>>>>
> >>>>>> My original patch actually had this MGMT feature called erroneous =
data
> >>>>>> reporting and Marcel argued against it.  If you both agree, then I=
'm
> >>>>>> happy to rename all of this to erroneous data reporting.  We'd sti=
ll
> >>>>>> need some way for the driver support to be messaged some other way
> >>>>>> though. see:
> >>>>>>
> >>>>>> if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
> >>>>>>        set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks)=
;
> >>>
> >>> So this will get a little bit confusing if we don't have a HFP
> >>> implementation that actually does implement the profile parts to
> >>> enable wideband speech so I wonder if we should rename it to the
> >>> underline feature it enables, that said this sort of feature is
> >>> probably easier to be queried over the socket itself rather than over
> >>> D-Bus so it can be used in conjunction with the likes of BT_VOICE,
> >>> also regarding the erroneous data should that be also enabled by the
> >>> HFP profile, because depending on the platform it may not support
> >>> wideband speech so enabling erroneous data automatically may result i=
n
> >>> artifacs, specially in cases where the codecs don't have error
> >>> correction or data loss concealment to handle data with possible erro=
r
> >>> and lost data respectively, btw we don't seem to be parsing the
> >>> SCO/ESCO flags and even if we do this properly we need to find a way
> >>> to notify them over the socket so things like plc works properly.
> >>
> >> This indeed makes sense, but we'll need to decide how erroneous data
> >> reporting gets enabled.  The SCO socket is a per connection scope
> >> thing while erroneous data reporting is a controller level thing.
> >
> > The way I would have done this is to make use of recvmsg and then add
> > the packet flags as msg_flags:
> >
> >   recvmsg()
> >       The recvmsg() call uses a msghdr structure to minimize the
> > number of directly supplied arguments.  This structure is defined as
> > follows in <sys/socket.h>:
> >
> >           struct iovec {                    /* Scatter/gather array ite=
ms */
> >               void  *iov_base;              /* Starting address */
> >               size_t iov_len;               /* Number of bytes to trans=
fer */
> >           };
> >
> >           struct msghdr {
> >               void         *msg_name;       /* Optional address */
> >               socklen_t     msg_namelen;    /* Size of address */
> >               struct iovec *msg_iov;        /* Scatter/gather array */
> >               size_t        msg_iovlen;     /* # elements in msg_iov */
> >               void         *msg_control;    /* Ancillary data, see belo=
w */
> >               size_t        msg_controllen; /* Ancillary data buffer le=
n */
> >               int           msg_flags;      /* Flags on received messag=
e */
> >           };
> >
> > But to make this backward compatible I would recommend adding a
> > socketopt that enables this new behavior and in case there is more
> > than one SCO socket those that did not use the sockopt should probably
> > drop packets with error or lost data so they work as without erroneous
> > data report since in that case the application will likely be using
> > regular reads it won't be able to detect the use of msg_flags.
>
> I think that I already send an example on how to do that a while ago. Don=
=E2=80=99t remember if that was a private email or addressed to the mailing=
 list, but I remember showing how this can be done. Or I confused this with=
 something similar :(
>
> Regards
>
> Marcel
>
