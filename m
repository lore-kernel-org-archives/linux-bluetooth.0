Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B5C433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43092224D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jteHDUIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgJSQGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgJSQGr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 12:06:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171AC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 09:06:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t25so14622753ejd.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aRIqVxL2RnfMucyTPDAxROqU2QrXXhMYzDdVAjB5ZBo=;
        b=jteHDUIJhnuzyGjLtIxlVDFqO6MYYxNCQbvy+Pu40abuJKbNI9Ko2mFYn+ykY3svNn
         hwkGLUW4EOkUCanCjE5jUBVGnqbKCCCrM7rC4hNp1AMkdwgVJFeimrYWsySlVefiPcA9
         q2qG//ulx3u3MMvxOJsG8S7CWhhphbrvrdWrNVjX5KHsifAtj33xg8BrsZcHQ+1eSNJS
         t1v1ISKHlyxFWLp3L2ecNfgIOcadbsrkKuqDqchnN5E0IjPKwAdkDHF2N7Kvy1UXYHJz
         1jOfOQjakTJvfQmANL3NLzgJqW4hzgyp2Rn2HS6JXLkwWutb8kbw0fCr/VJr4qaX6lBk
         F+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRIqVxL2RnfMucyTPDAxROqU2QrXXhMYzDdVAjB5ZBo=;
        b=DbgtPIP1D2vSCeqdO0nK/P2GYkZjbb64Kp5hE4ei2psihEia/gsvDVjbKagdBNvZx7
         EzOk+7LCasKPNfUgcasKOoY2HT0k3wHlXOaW+AxYmbKSKLzyJedVaBrwUpe4vBLl9/hY
         dbE5zTCGBA2YPEK4gFYLgA4pQalao5OhyYCSLuJhrGwRR7Sv6CH/nQPO5PQSdkjURRem
         aJRDcQf2FC9Vwe7eoZlXU3xyBF5vNoEn1BFn1rqFphyTvy8d8P2Bit3JEff4k+71hrQv
         hrNGpf0XQpNO2QVo7z9c0j4c9nQi/FGQz7RzvOk0tIlSraPAiWIotaB5eSmU2/iOTYwS
         Swyw==
X-Gm-Message-State: AOAM5326YNWeJ1lOp6dLMbbWaNwwQgMY2s/tDKy4jfkyPeY7iljFra+/
        CVIhdIYQfGa6D9/9PlQVUnBIE8kDqndU8d9pJg==
X-Google-Smtp-Source: ABdhPJxr5Kk8nF6mtw7CyCu3kzTZkvQ+uNl6cbWQa7oizcNJv1ra8tfJ7SXX1W+6uT2TcyGaMgeXmbwMTUmrUmW1OO4=
X-Received: by 2002:a17:906:7e52:: with SMTP id z18mr605769ejr.186.1603123605469;
 Mon, 19 Oct 2020 09:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
 <20201019141608.401899-1-marijns95@gmail.com>
In-Reply-To: <20201019141608.401899-1-marijns95@gmail.com>
From:   Marek Czerski <ma.czerski@gmail.com>
Date:   Mon, 19 Oct 2020 18:06:34 +0200
Message-ID: <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
Subject: Re: avrcp: possible race condition during connection establishment
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

pon., 19 pa=C5=BA 2020 o 16:16 Marijn Suijten <marijns95@gmail.com> napisa=
=C5=82(a):
>
> Hi Marek,
>
> > Hi all,
> >
> > I was looking into, so called, absolute volume control that was
> > introduced in AVRCP v1.4. What I want to achieve is to send audio from
> > android smartphone to linux based device running bluez and make the
> > volume control on the smartphone side to control the volume on the
> > device. So the device is the a2dp sink + avrcp CT/TG and the phone is
> > a2dp source + avrcp CT/TG.
> >
> > I assume that if all is working correctly then on the dbus the Volume
> > property of the org.bluez.MediaTransport1 will be changed by the
> > volume control of the phone and changes made to this property from the
> > device would propagate to the phone volume slider.
> >
> > This is not happening and what I believe is the cause is that
> > AVRCP_EVENT_VOLUME_CHANGED event registration request sent from the
> > phone is rejected by the bluez. I can see that on the wireshark snoop
> > from the device's bluetooth adapter. And on wireshark I see that
> > AVRCP_EVENT_VOLUME_CHANGED event registration is sent by the phone
> > before bluez initializes session->supported_events variable (not
> > really sure about that). I think that this rejection makes the phone
> > to not send SetAbsoluteVolume commands to the device on volume change.
>
> I looked into the same issue earlier this year, see
> 20200118194841.439036-1-marijns95@gmail.com [1].  The gist of it is that =
BlueZ
> bases supported_events solely on the remote AVRCP controller version, whi=
ch
> Android sets to 1.3 when it is a media source [2].  This version is not
> relevant in your use-case because the Android phone is the AVRCP target w=
hile
> blueZ is the controller.
>

I didn't tested Your patch but after looking at the code it seems that
just applying Your patch would solve my problem.
Regarding avrcp version, in android there is developer option to set
avrcp version. For example my Xiaomi redmi 8 (android 10) reports
version according to this setting, but samsung galaxy s7 (android 8)
always report version 1.4 regardless of this setting.

> It was decided in that mail thread to split supported_events in two; one =
based
> on the external controller version (when BlueZ operates as target it'll
> validate incoming notification registrations) and the other based on what=
 BlueZ
> currently supports as controller.
>
> The second check might not be all too relevant and is already covered by =
the
> switch-case; perhaps it makes more sense to base this check on the extern=
al
> target version, and again validate whether we expect to receive that part=
icular
> notification registration?
>
> Both checks together implicitly validate what BlueZ supports locally in i=
ts
> role of controller or target, as remote_{target,controller}_supported_eve=
nts
> (anticipated names of the new members replacing supported_events) will on=
ly be
> set to events that BlueZ is able to emit.
>

One thing is not clear for me, what is the purpose of the
supported_events ?  It is used in two places:
First is the avrcp_handle_register_notification function. If the
remote side want to register itself for specific event notification it
does not matter what version of avrcp that remote side supports. If it
ask for specific event it clearly support that event.
Second is in avrcp_handle_get_capabilities in CAP_EVENTS_SUPPORTED
case. Does it matter if local side reply with events that are not
supported in the version of avrcp supported by the remote side ?

> Unfortunately my ramblings in that mail shadowed an important question: h=
ow to
> determine in avrcp_handle_register_notification whether BlueZ is running =
as
> controller or target?  set_volume in transport.c derives this from
> transport->source_watch but there seems to be no easy access to the
> accompanying transport in avrcp_handle_register_notification.  With this
> question answered I'll be able to update and resubmit the original patch.
>
> > To test my theory i changed the session_init_control function in the
> > profiles/audio/avrcp.c to call first target_init and then
> > controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGED event not
> > been rejected and the volume control from the phone works as expected.
> >
> > After reading AVRCP specification I did not find any reason for the CT
> > on the phone side not to send event registration immediately after the
> > AVCTP connection establishment. So I believe that bluez should not
> > reject event registration in this case.
> >
> > Best Regards,
> > Marek Czerski
>
> Best regards,
> Marijn Suijten
>
> [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D157937699001093
> [2]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0=
_r4/bta/av/bta_av_main.cc#761


Best regards,
Marek Czerski
