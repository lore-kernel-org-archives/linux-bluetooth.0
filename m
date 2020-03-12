Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED4C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0322074B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LclYynNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgCLEjv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:39:51 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45697 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387738AbgCLEjv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 00:39:51 -0400
Received: by mail-vs1-f67.google.com with SMTP id x82so2844910vsc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pM8Q9a8Vl8GYS7reTW+XonDdMZW4AJ2AP8plEDZCOB4=;
        b=LclYynNxUkg1xyz2aT0DgqNAl6CUmcZy3LURxz3uxrcEzic87gNJjVCKxrOT0sophA
         OTh0TEEu+u/a2YfcHB92o429nbHsxwvJavbZnp080CG7L0NDOc3YJArBoKTW+bR4vb5j
         Nis7vioqHSbrSTotVoydjc3/71bx0jfEVErHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pM8Q9a8Vl8GYS7reTW+XonDdMZW4AJ2AP8plEDZCOB4=;
        b=DkLTXkpZWgx6OmUcfm+2JHUDZDW280X+2VK5Q+kb8aO2BIrFllwZQY324gyyjMnD2K
         tnslmOq7/U7DhJRj0aoyM+9SZ4a+BPID2RrRE4YXpCmZi1DJmqCTcKzcmYrAY9cYWtGH
         4GCUDkMI11eEyx8Isj7hTTIRCG4GyY9KYrZxbircaUjY56nRN1hjxrYSLtqO7yVRGD/4
         Vz75RCM6WqT/Vn6RKKKd5nnwgBKehL1xUo1tF+ZOuFESsZWDH4gM/Sv6c+u1py+wJ4s1
         ce2fnwqewLvtJnjybIshtt+/ndZC/bPgi+IBjO0UkDOQ4yvmAp3kq/fnq6eMSFQMWJPA
         psvw==
X-Gm-Message-State: ANhLgQ0NFtCtsSswGSrlvT5q7Jd/oRHOsaTXpND98CXPaRz3tMz/FolU
        mSi0nqLU7/lwpQri+SvrHe17IupShzYqK6oPgPSfczxv
X-Google-Smtp-Source: ADFU+vu1eTGy/XdtMx3K4jbw5z9nFv+1gqyJN1PunmcukKhU3/HLQzKIv5rF0VqoE5X0pHgK/nE6Eb8iFbjBBngR3sQ=
X-Received: by 2002:a67:f641:: with SMTP id u1mr4221927vso.86.1583987987322;
 Wed, 11 Mar 2020 21:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
 <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
 <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org> <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
 <00B97550-7BB3-4F86-8463-A4053C84978A@holtmann.org> <CANFp7mW5BV9oo2jya86+e8p+XWotMgrMyqJ63+0gjPforcYMuQ@mail.gmail.com>
 <287E8DBD-B40C-454B-A3C8-9380DCF15D67@holtmann.org>
In-Reply-To: <287E8DBD-B40C-454B-A3C8-9380DCF15D67@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 11 Mar 2020 21:39:35 -0700
Message-ID: <CANFp7mUXjTCgM9ty8dagw2z0m5L=nzHeOYOz5dXFPBJHekGSXA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

Reviving this thread to talk about how we should handle "set wake
capable".  For a more general implementation, we could rename this to
"Set Connection Params". It could be extended for other connection
parameters in the future.

i.e.
enum conn_params_type {
  SET_WAKE_CAPABLE,
};

struct conn_param {
  uint8_t type;
  uint8_t value;
};

struct set_conn_params {
  bdaddr_t addr;
  uint8_t count;
  struct conn_param values[];
};

Thoughts?

Abhishek









On Wed, Jan 29, 2020 at 11:03 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Abhishek,
>
> >>>>> Add docs for new management operation to mark a device as wake capa=
ble.
> >>>>>
> >>>>> ---
> >>>>>
> >>>>> Changes in v3: None
> >>>>> Changes in v2:
> >>>>> * Separated docs/mgmt-api.txt into its own patch
> >>>>>
> >>>>> doc/mgmt-api.txt | 19 +++++++++++++++++++
> >>>>> 1 file changed, 19 insertions(+)
> >>>>>
> >>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> >>>>> index 1e59acc54..8a73a9bb9 100644
> >>>>> --- a/doc/mgmt-api.txt
> >>>>> +++ b/doc/mgmt-api.txt
> >>>>> @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
> >>>>>     Possible errors:        Invalid Parameters
> >>>>>                             Invalid Index
> >>>>>
> >>>>> +Set Wake Capable Command
> >>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>>>> +
> >>>>> +     Command Code:           0x0047
> >>>>> +     Controller Index:       <controller id>
> >>>>> +     Command Parameters:     Address (6 Octets)
> >>>>> +                             Address_Type (1 Octet)
> >>>>> +                             Wake Capable (1 Octet)
> >>>>> +     Return Parameters:      Address (6 Octets)
> >>>>> +                             Address_Type (1 Octet)
> >>>>> +                             Wake Capable (1 Octet)
> >>>>> +
> >>>>> +     This command sets whether a bluetooth device is capable of wa=
king the
> >>>>> +     system from suspend. This property is used to set the event f=
ilter and
> >>>>> +     LE whitelist when the system enters suspend.
> >>>>> +
> >>>>> +     Possible errors:        Failed
> >>>>> +                             Invalid Parameters
> >>>>> +                             Invalid Index
> >>>>>
> >>>>
> >>>> my current thinking goes into this API addition:
> >>>>
> >>>> --- a/doc/mgmt-api.txt
> >>>> +++ b/doc/mgmt-api.txt
> >>>> @@ -2003,6 +2003,7 @@ Add Device Command
> >>>>               0       Background scan for device
> >>>>               1       Allow incoming connection
> >>>>               2       Auto-connect remote device
> >>>> +               3       Allow incoming connection to wake up the sys=
tem
> >>>>
> >>>>       With the Action 0, when the device is found, a new Device Foun=
d
> >>>>       event will be sent indicating this device is available. This
> >>>> @@ -2018,6 +2019,9 @@ Add Device Command
> >>>>       and if successful a Device Connected event will be sent. This
> >>>>       action is only valid for LE Public and LE Random address types=
.
> >>>>
> >>>> +       With the Action 3, the device is allowed to connect the same=
 way
> >>>> +       as with Action 1, but allows to wake up the system from susp=
end.
> >>>> +
> >>>>       When a device is blocked using Block Device command, then it i=
s
> >>>>       valid to add the device here, but all actions will be ignored
> >>>>       until the device is unblocked.
> >>>>
> >>>> Since we are really talking about incoming connections, then the Add=
 Device command is the one that handles this. Giving a device the option to=
 wake us up that is not set up for incoming connections makes no sense. We =
can discuss if certain LE advertising packets should wake us up, but that i=
s a total different API in my book.
> >>>
> >>> I originally tried implementing this with the Add Device api as you
> >>> suggested in the RFC email back in November (when we first talked
> >>> about this). I had trouble figuring out when/where in bluez to
> >>> actually send the Add Device command.
> >>>
> >>> Whether a device supports wake-up is a profile level setting (i.e. HI=
D
> >>> only so far). As far as I can tell, Add Device is called before the
> >>> profile connection is established. Bluez has two apis that call
> >>> MGMT_OP_ADD_DEVICE:
> >>> * adapter_auto_connect_add (this seems to be LE)
> >>> * adapter_whitelist_add (this seems to be BR/EDR)
> >>>
> >>> Both seem to be called BEFORE the registered profiles have a chance t=
o
> >>> accept the connection.
> >>
> >> this is something for Luiz or Johan to comment on. Maybe our code is n=
ot as good as I was thinking in this regard. Or maybe this is actually lega=
cy code that I am trying to rid of by requiring a mgmt API revision that ha=
s Add Device support.
> >>
> >> In general once we bonded with a device, we should be able to assign c=
ertain properties to it that are kept persistently.
> >>
> >
> > It looks like add_device would work if I opted to use it as an
> > "update_device_params" type of function (I think I can use it in the
> > same location I currently use adapter_set_wake_capable; I would just
> > check that the device has already been added first).
> >
> > You would still need to make a separate call from the original
> > add_device so your original criticism of requiring another mgmt call
> > for every param being set is still there. I could refactor the action
> > parameter to accept flags (i.e. 0x3 =3D Set connection parameters) and
> > then add a uint16_t flags parameter (i.e. 1 << 0: Allow wakeup from
> > incoming connection).
> >
> > What do you think?
>
> I like to give Johan and Luiz some time to look at userspace code and see=
 where this fits best.
>
> My proposal would be to ignore the API question for a bit. Keep the mgmt =
command you have for testing for now. Switching over to a different command=
 is done within an hour once we have the internals solid.
>
> As I commented in my review, I would store the BR/EDR ones in the wakeabl=
e list and the LE ones as a flag or parameter in the conn params list. My r=
eal concern is the complexity your patch set adds. We really need to stream=
line this and make things simpler. The whitelist update worries me a lot. T=
hat code path is already rather complicated and we should not add to it.
>
> For me it looks like you designed this based on the API that mgmt exposes=
 (aka your first patch in the patch set). That leads you on a path that I f=
eel is too complicated. So I would do this complete opposite and figure out=
 the tasks and what information of wakeable or not you need at what point a=
nd where are they best places for BR/EDR and LE in hci_dev.
>
> As an example, the whole complexity of disconnecting all devices and disa=
bling page scan and scanning etc. is something that we can get merged quick=
ly. If I assume an empty list of wakeable devices, then I would still disco=
nnect all devices, disable page scan and scanning and also suspend all adve=
rtising and discovery.
>
> I fully realize that this is a lot of work, but we need to get this suppo=
rt done right. I already foresee that you might want to have a keep adverti=
sing while suspend flag to advertise some sort of non-connectable beacon (l=
ike a find me hint). And at that point I don=E2=80=99t want to have to reth=
ink the whole code path again.
>
> Also please don=E2=80=99t be shy and tell if we did things totally stupid=
. We can change existing code as long as mgmt API stays backwards compatibl=
e. I am a big fan of fixing things to make code simpler and make maintenanc=
e easier.
>
> Regards
>
> Marcel
>
