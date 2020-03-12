Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB410C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749720674
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cPKF6baC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCLVqA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:46:00 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42721 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCLVp7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 17:45:59 -0400
Received: by mail-ua1-f66.google.com with SMTP id v16so1658439ual.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NFcmSjb+aJoZTGncsfyUezNEwA7nFSkI3ZEtq9rsFcw=;
        b=cPKF6baCitrt67vh7fo5hMUB34auPpc2vJWMXpyrF7Z3MbuPs7NIR5hNU5eV6v51qZ
         oNPX1KuxOhJaTJOai+/XaCaDG+cVHhw/GT7jSmKqmrJtLWHbvfUv7dgAulGRMvActhz1
         3pW/UYSuQzL1ICDk855ub+tMrbsdEtvtT1FjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NFcmSjb+aJoZTGncsfyUezNEwA7nFSkI3ZEtq9rsFcw=;
        b=eH457lyqOgwmM2c5cp7oKaoU8Hv7kgGTEx5u0KVvzvDuw/qhvxiXefzEdhN4Z1BuVW
         aaiRJvSNQSPDn9jv39yTGBgIcMKqGTv5FkIuXr+3k76Bo7sF1ZFZEJuu/f1ibvoTBg8/
         8lvyejRCcl3Cf526FIwZBLMw3h2gkUES2NFqzEOykQHn4TCx/7Kq3CkwteSvN5khhQUS
         DYsqv1+SkL1rw/ePnZ5QPNuavejzfOoBTue/rlIPV7csxl4LlCHh6QAnFxBRls9RLsEn
         Dx/Wq64hSPWVJk8qdboa+3kFB1r5mF2sD89aNpN5t16YovT1ZQWCutPKTkF2KeibFJ7i
         YmyQ==
X-Gm-Message-State: ANhLgQ0XTdlDHHQ5Po0n4QEw8s/U5+uQhuJ+VjaRBLrRTMYa5tsICUYB
        OPlapMgMNMCwEdqxv7UvEOnk8Bx3Uxi6zrnO5ZqDgPFG
X-Google-Smtp-Source: ADFU+vvMl5IfSaHtyhmhqokVr00D2bMJUG/7MfGrjTWD2DOsK/acfFmFSEYu7BFeRqrJs+zesOAzY+RTgpvycA2zxqU=
X-Received: by 2002:ab0:18a8:: with SMTP id t40mr6578423uag.115.1584049558156;
 Thu, 12 Mar 2020 14:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
 <20200127180433.BlueZ.v3.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
 <137EB79B-88E6-43E0-894F-A0C8D5F9B710@holtmann.org> <CANFp7mUF=1ehF_Kwnf5kdCiypoOL8ph8PPEMbwm53NR-==D-hA@mail.gmail.com>
 <00B97550-7BB3-4F86-8463-A4053C84978A@holtmann.org> <CANFp7mW5BV9oo2jya86+e8p+XWotMgrMyqJ63+0gjPforcYMuQ@mail.gmail.com>
 <287E8DBD-B40C-454B-A3C8-9380DCF15D67@holtmann.org> <CANFp7mUXjTCgM9ty8dagw2z0m5L=nzHeOYOz5dXFPBJHekGSXA@mail.gmail.com>
In-Reply-To: <CANFp7mUXjTCgM9ty8dagw2z0m5L=nzHeOYOz5dXFPBJHekGSXA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 12 Mar 2020 14:45:47 -0700
Message-ID: <CANFp7mVb9_NYzesphZAKeDwqUTY4sBQb2pobuJzffsMAcNmE1A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 1/5] mgmt: Add docs for Set Wake Capable
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Luiz and +Johan -- I think I had you in the cc: before but, as Marcel
said in earlier email, what are your thoughts on where this belongs in
userspace?

I'm reluctant to plop this in "Add Device" because that happens before
profile connection and that's when we determine whether the connection
should be wake capable.

Here's the contents of my last email:
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

>
>
>
>
>
> On Wed, Jan 29, 2020 at 11:03 AM Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> >
> > Hi Abhishek,
> >
> > >>>>> Add docs for new management operation to mark a device as wake ca=
pable.
> > >>>>>
> > >>>>> ---
> > >>>>>
> > >>>>> Changes in v3: None
> > >>>>> Changes in v2:
> > >>>>> * Separated docs/mgmt-api.txt into its own patch
> > >>>>>
> > >>>>> doc/mgmt-api.txt | 19 +++++++++++++++++++
> > >>>>> 1 file changed, 19 insertions(+)
> > >>>>>
> > >>>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > >>>>> index 1e59acc54..8a73a9bb9 100644
> > >>>>> --- a/doc/mgmt-api.txt
> > >>>>> +++ b/doc/mgmt-api.txt
> > >>>>> @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
> > >>>>>     Possible errors:        Invalid Parameters
> > >>>>>                             Invalid Index
> > >>>>>
> > >>>>> +Set Wake Capable Command
> > >>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > >>>>> +
> > >>>>> +     Command Code:           0x0047
> > >>>>> +     Controller Index:       <controller id>
> > >>>>> +     Command Parameters:     Address (6 Octets)
> > >>>>> +                             Address_Type (1 Octet)
> > >>>>> +                             Wake Capable (1 Octet)
> > >>>>> +     Return Parameters:      Address (6 Octets)
> > >>>>> +                             Address_Type (1 Octet)
> > >>>>> +                             Wake Capable (1 Octet)
> > >>>>> +
> > >>>>> +     This command sets whether a bluetooth device is capable of =
waking the
> > >>>>> +     system from suspend. This property is used to set the event=
 filter and
> > >>>>> +     LE whitelist when the system enters suspend.
> > >>>>> +
> > >>>>> +     Possible errors:        Failed
> > >>>>> +                             Invalid Parameters
> > >>>>> +                             Invalid Index
> > >>>>>
> > >>>>
> > >>>> my current thinking goes into this API addition:
> > >>>>
> > >>>> --- a/doc/mgmt-api.txt
> > >>>> +++ b/doc/mgmt-api.txt
> > >>>> @@ -2003,6 +2003,7 @@ Add Device Command
> > >>>>               0       Background scan for device
> > >>>>               1       Allow incoming connection
> > >>>>               2       Auto-connect remote device
> > >>>> +               3       Allow incoming connection to wake up the s=
ystem
> > >>>>
> > >>>>       With the Action 0, when the device is found, a new Device Fo=
und
> > >>>>       event will be sent indicating this device is available. This
> > >>>> @@ -2018,6 +2019,9 @@ Add Device Command
> > >>>>       and if successful a Device Connected event will be sent. Thi=
s
> > >>>>       action is only valid for LE Public and LE Random address typ=
es.
> > >>>>
> > >>>> +       With the Action 3, the device is allowed to connect the sa=
me way
> > >>>> +       as with Action 1, but allows to wake up the system from su=
spend.
> > >>>> +
> > >>>>       When a device is blocked using Block Device command, then it=
 is
> > >>>>       valid to add the device here, but all actions will be ignore=
d
> > >>>>       until the device is unblocked.
> > >>>>
> > >>>> Since we are really talking about incoming connections, then the A=
dd Device command is the one that handles this. Giving a device the option =
to wake us up that is not set up for incoming connections makes no sense. W=
e can discuss if certain LE advertising packets should wake us up, but that=
 is a total different API in my book.
> > >>>
> > >>> I originally tried implementing this with the Add Device api as you
> > >>> suggested in the RFC email back in November (when we first talked
> > >>> about this). I had trouble figuring out when/where in bluez to
> > >>> actually send the Add Device command.
> > >>>
> > >>> Whether a device supports wake-up is a profile level setting (i.e. =
HID
> > >>> only so far). As far as I can tell, Add Device is called before the
> > >>> profile connection is established. Bluez has two apis that call
> > >>> MGMT_OP_ADD_DEVICE:
> > >>> * adapter_auto_connect_add (this seems to be LE)
> > >>> * adapter_whitelist_add (this seems to be BR/EDR)
> > >>>
> > >>> Both seem to be called BEFORE the registered profiles have a chance=
 to
> > >>> accept the connection.
> > >>
> > >> this is something for Luiz or Johan to comment on. Maybe our code is=
 not as good as I was thinking in this regard. Or maybe this is actually le=
gacy code that I am trying to rid of by requiring a mgmt API revision that =
has Add Device support.
> > >>
> > >> In general once we bonded with a device, we should be able to assign=
 certain properties to it that are kept persistently.
> > >>
> > >
> > > It looks like add_device would work if I opted to use it as an
> > > "update_device_params" type of function (I think I can use it in the
> > > same location I currently use adapter_set_wake_capable; I would just
> > > check that the device has already been added first).
> > >
> > > You would still need to make a separate call from the original
> > > add_device so your original criticism of requiring another mgmt call
> > > for every param being set is still there. I could refactor the action
> > > parameter to accept flags (i.e. 0x3 =3D Set connection parameters) an=
d
> > > then add a uint16_t flags parameter (i.e. 1 << 0: Allow wakeup from
> > > incoming connection).
> > >
> > > What do you think?
> >
> > I like to give Johan and Luiz some time to look at userspace code and s=
ee where this fits best.
> >
> > My proposal would be to ignore the API question for a bit. Keep the mgm=
t command you have for testing for now. Switching over to a different comma=
nd is done within an hour once we have the internals solid.
> >
> > As I commented in my review, I would store the BR/EDR ones in the wakea=
ble list and the LE ones as a flag or parameter in the conn params list. My=
 real concern is the complexity your patch set adds. We really need to stre=
amline this and make things simpler. The whitelist update worries me a lot.=
 That code path is already rather complicated and we should not add to it.
> >
> > For me it looks like you designed this based on the API that mgmt expos=
es (aka your first patch in the patch set). That leads you on a path that I=
 feel is too complicated. So I would do this complete opposite and figure o=
ut the tasks and what information of wakeable or not you need at what point=
 and where are they best places for BR/EDR and LE in hci_dev.
> >
> > As an example, the whole complexity of disconnecting all devices and di=
sabling page scan and scanning etc. is something that we can get merged qui=
ckly. If I assume an empty list of wakeable devices, then I would still dis=
connect all devices, disable page scan and scanning and also suspend all ad=
vertising and discovery.
> >
> > I fully realize that this is a lot of work, but we need to get this sup=
port done right. I already foresee that you might want to have a keep adver=
tising while suspend flag to advertise some sort of non-connectable beacon =
(like a find me hint). And at that point I don=E2=80=99t want to have to re=
think the whole code path again.
> >
> > Also please don=E2=80=99t be shy and tell if we did things totally stup=
id. We can change existing code as long as mgmt API stays backwards compati=
ble. I am a big fan of fixing things to make code simpler and make maintena=
nce easier.
> >
> > Regards
> >
> > Marcel
> >
