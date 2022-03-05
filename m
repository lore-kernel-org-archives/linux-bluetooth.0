Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25645C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 07:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiCEH6J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Mar 2022 02:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiCEH6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Mar 2022 02:58:08 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4045551E7E
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 23:57:19 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2dbd8777564so114857367b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 23:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NzuGPUTt1YZZ7Rgh/PBEF8DFTwV/oCvrQMa/tuOTpB8=;
        b=YtObIq+TC/TsTopWXkuKijiIGab7kUy221elWbRWuFIeCI0odtApHVz6ktrAyw1Nvm
         l++CUn1lRaV/mJ1uwLpm2s71x3XE2CqjYLx9zkbg4q/yu1C20vbmxI0wHm+7AUD3Vq+l
         l6cJbkK3dDYOrt9fVxRVU9VwwqFUOVizXnQmJUAY6SQFK6GRL84HmS2FRzy+oRqhdZdu
         J7yIz+RvFLXjQeIY4IIFYqhe/HkYu6UieL2ukpWcgwQj4+Q7Qn4RIl92msnds1xKP66s
         eIEeHRxyqHD7HEISxAESl26aeaJV3G9+VEsYdQ/G+GxFVhVSTCSf0lR3HPnS1E1tMmLe
         Ycuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NzuGPUTt1YZZ7Rgh/PBEF8DFTwV/oCvrQMa/tuOTpB8=;
        b=MQTpCvNfzIZbJyn2EAxQO9RXocKOe+6VDhgCfUKQu9zS06STEfN9hTfKQjNTZb3hYD
         VpoqepHGtsnrvdKPQg+srXTsvvn9hIcliWQWwXMDA9dY1qj46Wq4A5VkqlgpP3FgKbNG
         wSba9OCyMlfOmayjAhC9QxCPi4qDGcOUimfr+GdUWiqPhCg+cEat1lmlpoi1yHdb2usZ
         PK0KX+wAnNiHOLrmaaVt7JmalnX4Z+CIwiPHDPn2B6YvJtAsYnh9+Q5OAxljA6mhIa8L
         dV4ixP/TBNx8O9tfAdswiOxXGdOKAkGvvFGo2HF8L8NH5PZ0f7nS19tKkhHzDDDwDdu2
         BIuA==
X-Gm-Message-State: AOAM531JJNqhXd4qn3o2dyn5hy7WFmvk70FVk1azLg2Ar0vuq3CBIhBd
        2bXreXASqnIfo706xuNyhVvRveJbD1+zlqABHYtZVrG80eWJTg==
X-Google-Smtp-Source: ABdhPJxXYOilOyxjxpfUV9XY2XLoR71W5PPmnZql1qhG43L4/572bnLZ1ZPO5ZK+qBgO9nQRWqwUQOnT9mn0FUg/mwM=
X-Received: by 2002:a81:53c2:0:b0:2dc:3600:7db3 with SMTP id
 h185-20020a8153c2000000b002dc36007db3mr1766366ywb.23.1646467038031; Fri, 04
 Mar 2022 23:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20220215133636.2827039-1-josephsih@chromium.org> <666C5B97-A51C-48B9-AC91-0655C0D158B5@holtmann.org>
In-Reply-To: <666C5B97-A51C-48B9-AC91-0655C0D158B5@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Sat, 5 Mar 2022 15:57:07 +0800
Message-ID: <CAHFy41_KiZygzfj91+8tJQWqESWKCXuatQFuKovh+DnMcPyY8Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 1/8] doc: Introduce the quality report command
 and event
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, thank you for reviewing the patches! Please read my replies
in the lines below. Thanks!

On Thu, Feb 17, 2022 at 8:13 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Joseph,
>
> > Add the MGMT quality report command and event in doc/mgmt-api.txt.
> >
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Use "Quality Report Event" without the prefix "Bluetooth" word.
> > - Combine both MGMT quality report command and event changes in a
> >  single patch.
> >
> > Changes in v3:
> > - Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
> > - Add 5 new patches (5/9 - 9/9) to enable the quality report
> >  feature via MGMT_OP_SET_QUALITY_REPORT instead of through the
> >  experimental features.
> >
> > Changes in v2:
> > - This is a new patch for adding the event in doc/mgmt-api.txt
> >
> > doc/mgmt-api.txt | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 61 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index ebe56afa4..a494f5d7e 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -332,6 +332,7 @@ Read Controller Information Command
> >               15      Static Address
> >               16      PHY Configuration
> >               17      Wideband Speech
> > +             18      Quality Report
> >
> >       This command generates a Command Complete event on success or
> >       a Command Status event on failure.
> > @@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
> >               15      Static Address
> >               16      PHY Configuration
> >               17      Wideband Speech
> > +             18      Quality Report
> >
> >       The EIR_Data field contains information about class of device,
> >       local name and other values. Not all of them might be present. Fo=
r
> > @@ -3858,6 +3860,46 @@ Add Advertisement Patterns Monitor With RSSI Thr=
eshold Command
> >                               Invalid Parameters
> >
> >
> > +Set Quality Report Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +     Command Code:           0x0057
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Action (1 Octet)
>
> I remember mentioning that we should use Quality_Report instead of Action=
.
>
> > +     Return Parameters:      Current_Settings (4 Octets)
> > +
> > +     This command is used to enable and disable the controller's quali=
ty
> > +     report feature. The allowed values for the Action command paramet=
er
> > +     are 0x00 and 0x01. All other values will return Invalid Parameter=
s.
> > +
> > +     The value 0x00 disables the Quality Report, and the value 0x01
> > +     enables the Quality Report feature.
> > +
> > +     This command is only available for the controllers that support
> > +     either AOSP Bluetooth quality report or Intel telemetry event.
>
> The details below are interesting, but don=E2=80=99t have to be in this d=
ocument. It is supported if the Supported_Settings indicate support for it.
>
> > +     For a controller supporting the AOSP specification, it should cal=
l
> > +     hci_set_aosp_capable() in its driver. The controller should also
> > +     return version_supported v0.98 or higher in its Vendor-specific
> > +     capabilities responding to the LE_Get_Vendor_Capabilities_Command=
.
> > +     On the other hand, for a controller supporting Intel specificatio=
n,
> > +     it should set up the set_quality_report callback properly. The dr=
iver
> > +     is responsible of setting up the quality report capability as
> > +     described above; otherwise, a Not Supported status will be return=
ed.
> > +
> > +     This command requires to use a valid controller index. Otherwise,
> > +     an Invalid Index status will be returned.
> > +
> > +     The command is sent to the controller to enable/disable the quali=
ty
> > +     report feature, and generates a Command Complete event on success=
.
> > +     If the controller failed to execute the action, a Failed status w=
ill
> > +     be returned.
>
> Can this be used when powered off, is it remembered over power off/on cyc=
les etc.

It is not remembered by the Intel controller over power cycles. I will
test the other AOSP vendors, and plan to address this issue in
separate patches in which I will describe the behavior explicitly.
Thanks.

>
> > +
> > +     Possible errors:        Failed
> > +                             Invalid Index
> > +                             Invalid Parameters
> > +                             Not Supported
> > +
> > +
> > Command Complete Event
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -4978,3 +5020,22 @@ Advertisement Monitor Device Lost Event
> >               2       LE Random
> >
> >       This event will be sent to all management sockets.
> > +
> > +
> > +Quality Report Event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Event code:             0x0031
> > +     Controller Index:       <controller_id>
> > +     Event Parameters:       Quality_Spec (1 Octet)
> > +                             Report_Len (2 Octets)
> > +                             Report (0-65535 Octets)
> > +
> > +     This event carries the Bluetooth quality report sent by the
> > +     controller.
> > +
> > +     Possible values for the Quality_Spec parameter:
> > +             0       AOSP Bluetooth Quality Report Event
> > +             1       Intel Telemetry Event
> > +
> > +     This event will be sent to all management sockets.
>
> Regards
>
> Marcel
>


--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
