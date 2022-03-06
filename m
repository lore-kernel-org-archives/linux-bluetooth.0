Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC96C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Mar 2022 04:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiCFEYc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Mar 2022 23:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCFEYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Mar 2022 23:24:31 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7D49F8E
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Mar 2022 20:23:39 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dbc48104beso131097287b3.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Mar 2022 20:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZF2SBBZ/1aHQs/d8g+oL/eU/8HPcL+MsPUUeyvF5jKI=;
        b=EoyUO4zseJpk0xUhI2ZiWFeWe7QppfOa4Eip2Hrph8qDvIK8FbGV6E8PxkYteQpva2
         yKEyhwQiBiNhGCFzKGijYgjW786njHO+p2PK17Fkysl6vZev7AgWri7uEW6TrRJmADxS
         FKsJF42BLaMwEBs0N9btgnB7S5KPBCBzCPKxFmFZ5EyQsIqd5ab5Bhee1piuRiqQqCr5
         L6CTHVIgivsCqldY4izfYIpwmOEH54Wte6KQwOIHcCC1CgSTQA4aZkhA6A44gm/3+yL4
         +QXZcByLc9mjW/awH2192UfFipkQym2oqldTJ97H8bQUuWJlF/2RP6N/6ilj/pL6XhDr
         /gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZF2SBBZ/1aHQs/d8g+oL/eU/8HPcL+MsPUUeyvF5jKI=;
        b=fowoKOsecHl7cYGR2ja5tQQDodZfuZEt3bcOVaa0niKtuiQboo8YN9RKAM6BGmAnmZ
         i9pQ4LraDB+LXl4h/laj1pG3sIwQxgzCAVvHDhHHkG63PnYOfgdiDYW6OHIYPTpBAfD/
         tUXaORyEajCpf92ZBJMWmYpERvdCE4o1ccMOqyuIRTbEkChbAJpe/JsLGmtjiTD899RO
         nV6Oo2Zt7AZmXGk6fsvrF3X763XOkUe/1osyYbgFpi49fiMU4jLxREebJGRhy7ugmHLV
         dX9aKVLCnZOPo0O9fQf4keH0gZcHgQUxmIWs8sharr0xEBj3YO1EVo0g24JZJfixVDyH
         Xe3A==
X-Gm-Message-State: AOAM533ZnogJqcqiUxBAvo1WV37ULwDV1t0umHLxOMi4tuoguy5XAFpE
        8fyvC6NpAilDZ3vfYq1AVNzrr9Vre90FO0vjR1A4iYWxRmj0ag==
X-Google-Smtp-Source: ABdhPJzvhYnlljgt3YvDbpJW5lYKt1FBX2y7W4K/zXHz80QR26RvcH1hFNA6XMqBGZ8oP2OMxUmFrqezTx2e7la/vyQ=
X-Received: by 2002:a81:4f14:0:b0:2dc:266:1f26 with SMTP id
 d20-20020a814f14000000b002dc02661f26mr4414822ywb.127.1646540618571; Sat, 05
 Mar 2022 20:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20220215133636.2827039-1-josephsih@chromium.org>
 <666C5B97-A51C-48B9-AC91-0655C0D158B5@holtmann.org> <CAHFy41_KiZygzfj91+8tJQWqESWKCXuatQFuKovh+DnMcPyY8Q@mail.gmail.com>
 <8AD1FDEA-CB22-4DEE-9ACE-CAAD3459DEF0@holtmann.org>
In-Reply-To: <8AD1FDEA-CB22-4DEE-9ACE-CAAD3459DEF0@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Sun, 6 Mar 2022 12:23:27 +0800
Message-ID: <CAHFy41_D3bBzU6Efd3q8Fuh2Ftmq5CrJ6zOj4hCH=x_9M5O89Q@mail.gmail.com>
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

Hi Marcel:
  What I plan to do about adapter power cycle for quality report:

  Step 1: At power off, do not clear the flag of HCI_QUALITY_REPORT in
hci_dev_clear_volatile_flags(). Will use HCI_QUALITY_REPORT to track
if the quality report is enabled before power off. Will also disable
the quality report explicitly in hci_sync.c:hci_dev_open_sync() just
before aosp_do_close()  so that different vendor chips will have
quality off at power off.

  Step 2: In hci_sync.c:hci_dev_open_sync(), re-enable quality report
explicitly just after aosp_do_open() if HCI_QUALITY_REPORT is true so
that all vendor chips have quality back on at power on.

  If the quality report is not enabled before power cycle,
HCI_QUALITY_REPORT will always stay false. Nothing mentioned above
will be executed in this case.

  One thing is worth noting here. The HCI_QUALITY_REPORT represents
the host setting instead of the controller state. During power off,
the HCI_QUALITY_REPORT host setting remains true while the controller
state about quality report is turned off. This behavior is similar to
"wide-band-speech" whose setting remains true during power off.

  Does this sound good to you? If yes, I will append a new patch to
the next Series-version. Thanks!

On Sun, Mar 6, 2022 at 5:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Joseph,
>
> >>> Add the MGMT quality report command and event in doc/mgmt-api.txt.
> >>>
> >>> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> >>> ---
> >>>
> >>> Changes in v4:
> >>> - Use "Quality Report Event" without the prefix "Bluetooth" word.
> >>> - Combine both MGMT quality report command and event changes in a
> >>> single patch.
> >>>
> >>> Changes in v3:
> >>> - Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
> >>> - Add 5 new patches (5/9 - 9/9) to enable the quality report
> >>> feature via MGMT_OP_SET_QUALITY_REPORT instead of through the
> >>> experimental features.
> >>>
> >>> Changes in v2:
> >>> - This is a new patch for adding the event in doc/mgmt-api.txt
> >>>
> >>> doc/mgmt-api.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>> 1 file changed, 61 insertions(+)
> >>>
> >>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> >>> index ebe56afa4..a494f5d7e 100644
> >>> --- a/doc/mgmt-api.txt
> >>> +++ b/doc/mgmt-api.txt
> >>> @@ -332,6 +332,7 @@ Read Controller Information Command
> >>>              15      Static Address
> >>>              16      PHY Configuration
> >>>              17      Wideband Speech
> >>> +             18      Quality Report
> >>>
> >>>      This command generates a Command Complete event on success or
> >>>      a Command Status event on failure.
> >>> @@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
> >>>              15      Static Address
> >>>              16      PHY Configuration
> >>>              17      Wideband Speech
> >>> +             18      Quality Report
> >>>
> >>>      The EIR_Data field contains information about class of device,
> >>>      local name and other values. Not all of them might be present. F=
or
> >>> @@ -3858,6 +3860,46 @@ Add Advertisement Patterns Monitor With RSSI T=
hreshold Command
> >>>                              Invalid Parameters
> >>>
> >>>
> >>> +Set Quality Report Command
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>> +
> >>> +     Command Code:           0x0057
> >>> +     Controller Index:       <controller id>
> >>> +     Command Parameters:     Action (1 Octet)
> >>
> >> I remember mentioning that we should use Quality_Report instead of Act=
ion.
> >>
> >>> +     Return Parameters:      Current_Settings (4 Octets)
> >>> +
> >>> +     This command is used to enable and disable the controller's qua=
lity
> >>> +     report feature. The allowed values for the Action command param=
eter
> >>> +     are 0x00 and 0x01. All other values will return Invalid Paramet=
ers.
> >>> +
> >>> +     The value 0x00 disables the Quality Report, and the value 0x01
> >>> +     enables the Quality Report feature.
> >>> +
> >>> +     This command is only available for the controllers that support
> >>> +     either AOSP Bluetooth quality report or Intel telemetry event.
> >>
> >> The details below are interesting, but don=E2=80=99t have to be in thi=
s document. It is supported if the Supported_Settings indicate support for =
it.
> >>
> >>> +     For a controller supporting the AOSP specification, it should c=
all
> >>> +     hci_set_aosp_capable() in its driver. The controller should als=
o
> >>> +     return version_supported v0.98 or higher in its Vendor-specific
> >>> +     capabilities responding to the LE_Get_Vendor_Capabilities_Comma=
nd.
> >>> +     On the other hand, for a controller supporting Intel specificat=
ion,
> >>> +     it should set up the set_quality_report callback properly. The =
driver
> >>> +     is responsible of setting up the quality report capability as
> >>> +     described above; otherwise, a Not Supported status will be retu=
rned.
> >>> +
> >>> +     This command requires to use a valid controller index. Otherwis=
e,
> >>> +     an Invalid Index status will be returned.
> >>> +
> >>> +     The command is sent to the controller to enable/disable the qua=
lity
> >>> +     report feature, and generates a Command Complete event on succe=
ss.
> >>> +     If the controller failed to execute the action, a Failed status=
 will
> >>> +     be returned.
> >>
> >> Can this be used when powered off, is it remembered over power off/on =
cycles etc.
> >
> > It is not remembered by the Intel controller over power cycles. I will
> > test the other AOSP vendors, and plan to address this issue in
> > separate patches in which I will describe the behavior explicitly.
> > Thanks.
>
> I think this means that on every power on we have to reprogram it if it w=
as enabled before. That is how we handle other settings. They survive power=
 cycles. And since we have a Current_Settings flags for this, I would expec=
t it to behave exactly the same.
>
> Regards
>
> Marcel
>


--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
