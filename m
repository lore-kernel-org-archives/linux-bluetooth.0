Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E4C4363D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 00:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF221531
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 00:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1dvjNUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgJAAz3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Sep 2020 20:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgJAAz3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Sep 2020 20:55:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA665C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2020 17:55:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so3839703edq.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2020 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5wN/tzCrDBu7dnJ7sVYOYNLB52wccKznuAjBSRYSRAc=;
        b=T1dvjNUjTi/BlJGXO+Nb12FN3aeZTvHKrFenDdhR13cDKbUDGH6HzGd5b7caBDN8s3
         w0RqnTwtkUW5/2dicL3C7TejaGorOqdOZZzf47r/Ho3/fjl2BHaKDWRByPgGokeWt0mp
         N6pyKgBMgmhotxqJW7U+r47xSv1Lz5EBc3edD2NNCJoHrrD/NLUYVLdtCQ5NNmTMZ9S9
         sCRfK1IPj+99dchBs/rqTYIDx8M+fIn/H8KCcE/1dmmNiahZ5FHInEG//BJMxSYZJA5x
         fD1wfyjFouD9Vz777GN1ZfBeZPtxUyi4otvR5HRYutIdDM+ufOjO26et8xQ78vwyqz3g
         6t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5wN/tzCrDBu7dnJ7sVYOYNLB52wccKznuAjBSRYSRAc=;
        b=q61motLyuaLW9Hui3WB/YQJvV0JSEBim4N0i5mK33Ifd6j38oCGw5AgwI2XMIejyiR
         KmD9zuTr6V5RobbSu7lfsCjS13DWggrWzT2VieesRBVzU5q/3+F0cSQQjXSluiODwlGE
         rCoaY6UM2hVq/O5tqWir5fQuCIrBVXZExniAzznqsW8EZ1TOqiWQ4CA3RRrl9C3aH1LY
         74WZdCrlogtg40BzMFthKNTrr7RR0mDlBU9PSd5szVCvO+o0dIqg/aYTpRFsLCuUDD/v
         CtUmtdyl/sKTc8d59AvovbCVh6O3XzxBUC52OuWDrDc10YtUFDzIeNliU2le34tTzkhj
         X4Ig==
X-Gm-Message-State: AOAM530aV+Y8o3vPiVic9nIj074LYmIIWamuR4RD9hMlXYIsk/iqnvD9
        CKRPXK+M0WGoVpdojbNVL/kYAwJyycajhT5lZ2WLTA==
X-Google-Smtp-Source: ABdhPJzVEf14dovdfYFJItvS6+XtsIDwP+Xz+q/7yve8YzfFWmWu3FJAuLzUIDP08CgFvFa8pUAdPCA1ebIzhGh+fis=
X-Received: by 2002:a05:6402:1602:: with SMTP id f2mr3938640edv.343.1601513726899;
 Wed, 30 Sep 2020 17:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
 <20200924180838.Bluez.v3.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
 <311BC779-4869-4092-B715-5D041F163192@holtmann.org>
In-Reply-To: <311BC779-4869-4092-B715-5D041F163192@holtmann.org>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Wed, 30 Sep 2020 17:55:15 -0700
Message-ID: <CAP2xMbsAGZU8uKNqee6AM0+MSkscL-YRWbzQYETgwbjijThBHA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 2/9] doc/mgmt-api: Add new MGMT interfaces to mgmt-api
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, I've got a new series that I plan to send tomorrow that
addresses all comments except one, below:


On Fri, Sep 25, 2020 at 10:58 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Daniel,
>
> > This patch adds the following to mgmt-api:
> > - Add Extended Advertising Parameters Command
> > - Add Extended Advertising Data Command
> > - Changes Read Security Info to Read Controller Capabilities CMD
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Removed Tx Power Selected MGMT event
> > - Changed Read Security Info cmd to  Read Controller Capabilities
> >
> > Changes in v2:
> > - Removed extra space in Add Extended Advertising Parameters API
> >
> > doc/mgmt-api.txt | 229 +++++++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 223 insertions(+), 6 deletions(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index ca0d38469..85aa8b797 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3110,19 +3110,19 @@ Set Wideband Speech Command
> >                               Invalid Index
> >
> >
> > -Read Security Information Command
> > +Read Controller Capabilities Command
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I am fine with the name. Just extend the =3D=3D=3D to match the text abov=
e.
>
> >
> >       Command Code:           0x0048
> >       Controller Index:       <controller id>
> >       Command Parameters:
> > -     Return Parameters:      Security_Data_Length (2 Octets)
> > -                             Security_Data (0-65535 Octets)
> > +     Return Parameters:      Capabilities_Data_Length (2 Octets)
> > +                             Capabilities_Data (0-65535 Octets)
> >
> > -     This command is used to retrieve the supported security features
> > +     This command is used to retrieve the supported capabilities
> >       by the controller or the host stack.
> >
> > -     The Security_Data_Length and Security_Data parameters provide
> > +     The Capabilities_Data_Length and Capabilities_Data parameters pro=
vide
> >       a list of security settings, features and information. It uses
> >       the same format as EIR_Data, but with the namespace defined here.
> >
> > @@ -3131,6 +3131,8 @@ Read Security Information Command
> >               0x01            Flags
> >               0x02            Max Encryption Key Size (BR/EDR)
> >               0x03            Max Encryption Key Size (LE)
> > +             0x04            Min Supported LE Tx Power (dBm)
> > +             0x05            Max Supported LE Tx Power (dBm)
>
> I would actually prefer if we put them into a 2 octet size value. So two =
times s8 fields. And then just call it "Supported Tx Power (LE)=E2=80=9D.
>
> >
> >       Flags (data type 0x01)
> >
> > @@ -3146,6 +3148,15 @@ Read Security Information Command
> >               present, then it is unknown what the max encryption key
> >               size of the controller or host is in use.
> >
> > +     Min/Max Supported LE Tx Power (data types 0x04 and 0x05)
> > +
> > +             These fields indicate the supported range of LE Tx Power =
in
> > +             dBm across all supported PHYs. These values are populated
> > +             by the return of the LE Read Transmit Power HCI command. =
If
> > +             this HCI command is not available, the values default to
> > +             0x7F, indicating HCI_TX_POWER_INVALID, as a valid range
> > +             is not available.
> > +
>
> Actually no. If the command is not available or failed, then this field w=
ill not be present. Clearly indicate the absence. The should be a clear dif=
ference if the command is not available and the controller returning -127.
>
> Can we split this change into a separate patch please.
>
> >       This command generates a Command Complete event on success or
> >       a Command Status event on failure.
> >
> > @@ -3574,6 +3585,212 @@ Remove Advertisement Monitor Command
> >                               Busy
> >
> >
> > +Add Extended Advertising Parameters Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x0054
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Instance (1 Octet)
> > +                             Flags (4 Octets)
> > +                             Params (2 Octets)
> > +                             Duration (2 Octets)
> > +                             Timeout (2 Octets)
> > +                             MinInterval (4 Octets)
> > +                             MaxInterval (4 Octets)
> > +                             TxPower (1 Octet)
> > +     Return Parameters:      Instance (1 Octet)
> > +                             TxPower (1 Octet)
>
> If we leave the Flags that tell what adv data and scan rsp data to add, t=
hen we should also return the leftover sizes of each fields so that the cal=
ler knows how much they can occupy. So that you don=E2=80=99t have to use G=
et Advertising Size Information command to get that information. We already=
 know it at this point in time.

Hi Marcel, I am happy to add the remaining space available for
advertising and scan response data to the response here. However,
userspace already has a local function,
advertising.c:calc_max_adv_len(), that computes the losses caused by
these flags. I imagine that this feature will be useful for any other
application not using userspace bluez so I will add it to the
response, but at the moment userspace does not need it. Please let me
know if you have any further thoughts on this point.

Thanks,
Daniel

>
> > +
> > +     This command is used to configure the parameters for Bluetooth Lo=
w
> > +     Energy advertising instance. This command is expected to be follo=
wed
> > +     by an Add Extended Advertising Data command to complete and enabl=
e
> > +     the advertising instance.
> > +
> > +     Added advertising information with this command will not be visib=
le
> > +     immediately if advertising is enabled via the Set Advertising
> > +     command. The usage of the Set Advertising command takes precedenc=
e
> > +     over this command. Instance information is stored and will be
> > +     advertised once advertising via Set Advertising has been disabled=
.
> > +
> > +     The Instance identifier is a value between 1 and the number of
> > +     supported instances. The value 0 is reserved.
> > +
> > +     With the Flags value the type of advertising is controlled and
> > +     the following flags are defined:
> > +
> > +             0       Switch into Connectable mode
> > +             1       Advertise as Discoverable
> > +             2       Advertise as Limited Discoverable
> > +             3       Add Flags field to Adv_Data
> > +             4       Add TX Power field to Adv_Data
> > +             5       Add Appearance field to Scan_Rsp
> > +             6       Add Local Name in Scan_Rsp
> > +             7       Secondary Channel with LE 1M
> > +             8       Secondary Channel with LE 2M
> > +             9       Secondary Channel with LE Coded
> > +
> > +     When the connectable flag is set, then the controller will use
> > +     undirected connectable advertising. The value of the connectable
> > +     setting can be overwritten this way. This is useful to switch a
> > +     controller into connectable mode only for LE operation. This is
> > +     similar to the mode 0x02 from the Set Advertising command.
> > +
> > +     When the connectable flag is not set, then the controller will
> > +     use advertising based on the connectable setting. When using
> > +     non-connectable or scannable advertising, the controller will
> > +     be programmed with a non-resolvable random address. When the
> > +     system is connectable, then the identity address or resolvable
> > +     private address will be used.
> > +
> > +     Using the connectable flag is useful for peripheral mode support
> > +     where BR/EDR (and/or LE) is controlled by Add Device. This allows
> > +     making the peripheral connectable without having to interfere
> > +     with the global connectable setting.
> > +
> > +     Secondary channel flags can be used to advertise in secondary
> > +     channel with the corresponding PHYs. These flag bits are mutually
> > +     exclusive and setting multiple will result in Invalid Parameter
> > +     error. Choosing either LE 1M or LE 2M will result in using
> > +     extended advertising on the primary channel with LE 1M and the
> > +     respectively LE 1M or LE 2M on the secondary channel. Choosing
> > +     LE Coded will result in using extended advertising on the primary
> > +     and secondary channels with LE Coded. Choosing none of these flag=
s
> > +     will result in legacy advertising.
> > +
> > +     To allow future parameters to be optionally extended in this stru=
cture,
> > +     the Params member is used to specify which of the structure field=
s were
> > +     purposefully set by the caller. Unspecified parameters will be gi=
ven
> > +     sensible defaults by the kernel before the advertisement is regis=
tered.
> > +     The Params bit field uses the following bit to parameter relation=
ship:
> > +
> > +             0       The Duration parameter should be used
> > +             1       The Timeout parameter should be used
> > +             2       The Interval parameters should be used
> > +             3       The Tx Power parameter should be used
> > +
> > +     The Duration parameter configures the length of an Instance. The
> > +     value is in seconds. The default is 2 seconds.
>
> Wouldn=E2=80=99t we just add this to Flags instead of yet another paramet=
er?
>
> > +
> > +     If only one advertising Instance has been added, then the Duratio=
n
> > +     value will be ignored. It only applies for the case where multipl=
e
> > +     Instances are configured. In that case every Instance will be
> > +     available for the Duration time and after that it switches to
> > +     the next one. This is a simple round-robin based approach.
> > +
> > +     The Timeout parameter configures the life-time of an Instance. In
> > +     case the value 0 is used it indicates no expiration time. If a
> > +     timeout value is provided, then the advertising Instance will be
> > +     automatically removed when the timeout passes. The value for the
> > +     timeout is in seconds. Powering down a controller will invalidate
> > +     all advertising Instances and it is not possible to add a new
> > +     Instance with a timeout when the controller is powered down.
> > +
> > +     When a Timeout is provided, then the Duration subtracts from
> > +     the actual Timeout value of that Instance. For example an Instanc=
e
> > +     with Timeout of 5 and Duration of 2 will be scheduled exactly 3
> > +     times, twice with 2 seconds and once with one second. Other
> > +     Instances have no influence on the Timeout.
> > +
> > +     MinInterval and MaxInterval define the minimum and maximum advert=
ising
> > +     intervals, with units as number of .625ms advertising slots. The =
Max
> > +     interval is expected to be greater than or equal to the Min inter=
val,
> > +     and both must have values in the range [0x000020, 0xFFFFFF]. If e=
ither
> > +     condition is not met, the registration will fail.
> > +
> > +     The provided Tx Power parameter will only be used if the controll=
er
> > +     supports it, which can be determined by the presence of the
> > +     CanSetTxPower member of the Read Advertising Features command.
> > +
> > +     The acceptable range for requested Tx Power is defined in the spe=
c
> > +     (Version 5.2 | Vol 4, Part E, page 2585) to be [-127, +20] dBm, a=
nd the
> > +     controller will select a power value up to the requested one. The
> > +     transmission power selected by the controller is not guaranteed
> > +     to match the requested one, so the reply will contain the power
> > +     chosen by the controller. If the requested Tx Power is outside
> > +     the valid range, the registration will fail.
> > +
> > +     Re-adding an already existing instance (i.e. issuing the Add Exte=
nded
> > +     Advertising Parameters command with an Instance identifier of an
> > +     existing instance) will update that instance's configuration.
>
> This can get tricky with Instance Added and Instance Removed events. We w=
ould have to describe on how that is handled.
>
> > +
> > +     An instance being added or changed while another instance is
> > +     being advertised will not be visible immediately but only when
> > +     the new/changed instance is being scheduled by the round robin
> > +     advertising algorithm.
> > +
> > +     Changes to an instance that is currently being advertised will
> > +     cancel that instance and switch to the next instance. The changes
> > +     will be visible the next time the instance is scheduled for
> > +     advertising. In case a single instance is active, this means
> > +     that changes will be visible right away.
> > +
> > +     LE must already be enabled, and the controller must be powered,
> > +     otherwise a "rejected" status will be returned.
> > +
> > +     This command generates a Command Complete event on success or a
> > +     Command Status event on failure.
> > +
> > +     Possible errors:        Failed
> > +                             Rejected
> > +                             Not Supported
> > +                             Invalid Parameters
> > +                             Busy
> > +
> > +
> > +Add Extended Advertising Data Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +     Command Code:           0x0055
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Instance (1 Octet)
> > +                             Advertising Data Length (1 Octet)
> > +                             Scan Response Length (1 Octet)
> > +                             Advertising Data (0-255 Octets)
> > +                             Scan Response (0-255 Octets)
> > +     Return Parameters:      Instance (1 Octet)
> > +
> > +     The Add Extended Advertising Data command is used to update the
> > +     advertising data of an existing advertising instance known to the
> > +     kernel. It is expected to be called after an Add Extended Adverti=
sing
> > +     Parameters command, as part of the advertisement registration
> > +     process.
> > +
> > +     If extended advertising is available, this call will initiate HCI
> > +     commands to set the instance's advertising data, set scan respons=
e
> > +     data, and then enable the instance. If extended advertising is
> > +     unavailable, the advertising instance structure maintained in ker=
nel
> > +     will have its advertising data and scan response updated, and the
> > +     instance will either be scheduled immediately or left in the queu=
e
> > +     for later advertisement as part of round-robin advertisement rota=
tion
> > +     in software.
> > +
> > +     If Scan_Rsp_Len is zero and the flags defined in Add Extended
> > +     Advertising Parameters command do not have connectable flag set a=
nd
> > +     the global connectable setting is off, then non-connectable
> > +     advertising is used. If Scan_Rsp_Len is larger than zero and
> > +     connectable flag is not set and the global advertising is off,
> > +     then scannable advertising is used. This small difference is
> > +     supported to provide less air traffic for devices implementing
> > +     broadcaster role.
> > +
> > +     If the Instance provided does not match a known instance, or if t=
he
> > +     provided advertising data or scan response are in an unrecognized
> > +     format, an "Invalid Parameters" status will be returned.
> > +
> > +     If a "Set LE" or Advertising command is still in progress, a "Bus=
y"
> > +     status will be returned.
> > +
> > +     If the controller is not powered, a "rejected" status will be ret=
urned.
> > +
> > +     This command generates a Command Complete event on success or a
> > +     Command Status event on failure.
> > +
> > +     Possible errors:        Failed
> > +                             Rejected
> > +                             Invalid Parameters
> > +                             Busy
> > +
> > +
> > Command Complete Event
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > @@ -4576,4 +4793,4 @@ Advertisement Monitor Removed Event
> >       using the Remove Advertisement Monitor command.
> >
> >       The event will only be sent to management sockets other than the
> > -     one through which the command was sent.
> > +     one through which the command was sent.
>
> Please don=E2=80=99t add unrelated changes.
>
> Regards
>
> Marcel
>
