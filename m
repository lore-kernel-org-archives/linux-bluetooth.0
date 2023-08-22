Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE8EE49A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 04:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjHVEKo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 00:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHVEKn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 00:10:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F65133
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 21:10:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso193051cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 21:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692677440; x=1693282240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U2ABHUFjqfM1yqKzJCAwnKh/zDXzD3C006UOLjw/Z0=;
        b=a1NskRyl1BQKYiwc3oMAR1ig4w9z6Kndee3aeK5FeB+LKLkvQCiMmUJvhNh/YlghPT
         GJnQ0kuRmtoWlIHyoneSeQ6Rwpt9NAEf9rm+JnuQYgEX27ZauVTA/5aQz9Tbr45sCz/Z
         ugQebyKy7NbftQnkCTHzXGePi9KIq7W3iOAhIvlU6wMffncnyzT3DyJz0u93a6QLYDtj
         RjhJtzeIM0INrkiam03XFOs58FHfzwfmJ7L0gNIQLxfFrqwv8mxqR4xZRFuIePDPt4Th
         /qHiQDrhC/1r9/Wuh9X9jB8hwbJtC2u/Dn2e29Y9im2SBeIQOjSxMFvnj02CWoUqrIij
         L05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692677440; x=1693282240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U2ABHUFjqfM1yqKzJCAwnKh/zDXzD3C006UOLjw/Z0=;
        b=D9kB1VWXchyelNu9WsR5nyurZus+q7ok2JBH3GIJRURWDUCILxt0W/kHDF5KORI4Sa
         tqkhJkfM2VZqXEFfgZVL+PBAI+5ts14tFoSEMlfeQ74qYdDC5PTOvcMdFqlgo1fjm3cS
         4oLf8QJ4Xk/uA2Mtb2zIO1fIzmbp4MZKoQKbocNPa5qTVaGDgeyppNWgsZ296pRCfViA
         Cx5CHupvGoJEGYoFSA1fZQsP2EaUevbslfkOiAri2A4CUQHCevgaKIMK4gvgXofnmg1S
         DJQp2PV67TxyvRUp9rhi5LV9g7pBnYSOcXbCVzfxhp5CVueB3t4DIHjOE9DVVoUMCJS0
         klTw==
X-Gm-Message-State: AOJu0YxrFIZUk53PzW2czXlWehufuMAo3xFI8b5GW7DT9F75LECfxGJn
        GRDn1aLFbT0+Vbb88CeC06Iiu3+y2c/6mmwpEoMPdA==
X-Google-Smtp-Source: AGHT+IHLAgd1Q6hI9ENHDxQJgbzuOww9YXpt/GlYdwJXRdTgTMoaICVDPml/v138lCJMspIjfpHmFUz7+TMs4IxbFzQ=
X-Received: by 2002:a05:622a:1823:b0:403:fdf1:e05e with SMTP id
 t35-20020a05622a182300b00403fdf1e05emr98577qtc.19.1692677440509; Mon, 21 Aug
 2023 21:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
 <CABBYNZK8SW9aMHL-yrCQUN+72z_rDZWK83wAdutMA8xG-Zdo9A@mail.gmail.com>
 <CAB4PzUpL-FBU0tz1gXjqZXY1ZoJKNSCqcf92Q=yhGo0g5YbtEQ@mail.gmail.com>
 <CABBYNZKaaSjmJ4ZLOsBjHYRw8Uoou0XbJKKnZ07Y30+hQONqnQ@mail.gmail.com> <CABBYNZ+zbs7TP57pn==YPKy_8MUOLBkjiJRPATM3prvO==L1-g@mail.gmail.com>
In-Reply-To: <CABBYNZ+zbs7TP57pn==YPKy_8MUOLBkjiJRPATM3prvO==L1-g@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Mon, 21 Aug 2023 21:10:28 -0700
Message-ID: <CAB4PzUoM=zxkNWy57N_nEucD_Q_9OotGnOHKb=yEXjnbBB-WGA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: check wake_override when setting device privacy
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

A few questions on the patch.
(1) I checked in the new_irk_callback, the patch calls
device_set_rpa(device, true). This feels like the assumption is still
having IRK means using RPA. If I understand correctly, this is not
true. For example, the MX Master 3 mouse I am using. It is using an
identity address, but still having IRK.

This is from the pairing log, the RPA is empty in the callback.
> src/adapter.c:new_irk_callback() hci0 new IRK for E3:C1:E3:A6:10:D9 RPA 0=
0:00:00:00:00:00

I think we may need to check the type of the conn_bdaddr and make sure
it is a RPA.

(2)
> Note you need LL Privacy on the scanner side, not on the peripheral
> that is advertising, so if you got this the other way around it will
> not work. RPA resolution is required to be able to resolve the
> advertisements using RPAs since the accept list can only be programmed
> with the identity address.

Regarding this, I have enabled privacy in both scanner and peripheral.
As shown in the log, after the adapter is powered on. The identity
address is added to the accept list and the IRK is added to the
resolving list. Then the address resolution is enabled.

< HCI Command: LE Add Device To Resolving List (0x08|0x0027) plen 39

               #582 [hci0] 16:06:32.070202
        Address type: Public (0x00)
        Address: DC:A6:32:A4:09:DF (OUI DC-A6-32)
        Peer identity resolving key: b724b925ee4e955d723fa2247bba24a0
        Local identity resolving key: 00000000000000000000000000000000
...
< HCI Command: LE Set Privacy Mode (0x08|0x004e) plen 8

               #584 [hci0] 16:06:32.071113
        Peer Identity address type: Public (0x00)
        Peer Identity address: DC:A6:32:A4:09:DF (OUI DC-A6-32)
        Privacy Mode: Use Device Privacy (0x01)
...
< HCI Command: LE Add Device To Accept List (0x08|0x0011) plen 7

               #586 [hci0] 16:06:32.072126
        Address type: Public (0x00)
        Address: DC:A6:32:A4:09:DF (OUI DC-A6-32)
...
< HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1

               #588 [hci0] 16:06:32.073130
        Address resolution: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                                           =
       #589 [hci0] 16:06:32.073986
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)

The scan policy is set to 0x01.

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8

               #590 [hci0] 16:06:32.074074
        Own address type: Public (0x00)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 367.500 msec (0x024c)
          Window: 37.500 msec (0x003c)

The advertisement also shows the address is resolved.

> HCI Event: LE Meta Event (0x3e) plen 32                                  =
                                                                           =
       #604 [hci0] 16:07:05.292173
      LE Extended Advertising Report (0x0d)
...
          Address type: Resolved Public (0x02)
          Address: DC:A6:32:A4:09:DF (OUI DC-A6-32)

(3) Given comment (2), when LL privacy is enabled both on scanner and
peripheral, the issue still exists in hog_probe. The connection is
built with the RPA, so the connection cannot be found before adding
the device is done. It will fail at hci_conn_params_lookup. As
set_device_flags is always called with identity address.

params =3D hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
le_addr_type(cp->addr.type));

During add_device, a new hci_conn_params will be added with
hci_conn_params_set. Then the following set_device_flags will not
fail.

Zhengping


Thanks,
Zhengping





On Mon, Aug 21, 2023 at 12:59=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Mon, Aug 21, 2023 at 12:51=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 21, 2023 at 12:45=E2=80=AFPM Zhengping Jiang <jiangzp@googl=
e.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thanks for the reply. I applied the above patch "device: Fix enabling
> > > wake support without RPA Resolution" and tried again. I can see there
> > > are still some things missing.
> > > I have attached a btsnoop log for reference. Here I am using a rasp p=
i
> > > configured as a LE mouse which is in privacy mode.
> > >
> > > The ll privacy feature is enabled at the beginning.
> > > @ MGMT Command: Set Experimental Feature (0x004a) plen 17
> > >                                                {0x0003} [hci0]
> > > 19:21:30.193783
> > >         UUID: BlueZ Experimental LL privacy
> > >         Action: Enabled (0x01)
> > >
> > > Later the LE advertisement with RPA is received.
>
> Note you need LL Privacy on the scanner side, not on the peripheral
> that is advertising, so if you got this the other way around it will
> not work. RPA resolution is required to be able to resolve the
> advertisements using RPAs since the accept list can only be programmed
> with the identity address.
>
> > >
> > > > HCI Event: LE Meta Event (0x3e) plen 32                            =
                                                     #311 [hci0] 19:22:36.6=
33724
> > >       LE Extended Advertising Report (0x0d)
> > >         Num reports: 1
> > >         Entry 0
> > >           Event type: 0x0013
> > >             Props: 0x0013
> > >               Connectable
> > >               Scannable
> > >               Use legacy advertising PDUs
> > >             Data status:  [0;32mComplete [0m
> > >           Legacy PDU Type: ADV_IND (0x0013)
> > >           Address type: Random (0x01)
> > >           Address: 6F:CB:45:0C:AD:1F (Resolvable)
> > >
> > > But I still get the error for not being able to set wake_support. I
> > > think this is not right as the address resolution is already enabled.
> > > I haven't checked the details yet.
> > >
> > > =3D bluetoothd: Unable to set wake_support without RPA resolution
> > >
> > > 19:22:41.337325
> > >
> > > Then the wake up flag is not set as a result.
> > >
> > > @ MGMT Event: Device Flags Changed (0x002a) plen 15
> > >                                                {0x0003} [hci0]
> > > 19:22:41.372969
> > >         LE Address: DC:A6:32:A4:08:BF (OUI DC-A6-32)
> > >         Supported Flags: 0x00000003
> > >           Remote Wakeup
> > >           Device Privacy Mode
> > >         Current Flags: 0x00000002
> > >           Device Privacy Mode
> > >
> > > The address resolution is enabled as shown later in the log, after th=
e
> > > adapter reboot and the LE mouse can reconnect with RPA.
> > >
> > > < HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
> > >                                                    #601 [hci0]
> > > 19:22:57.164690
> > >         Address resolution: Disabled (0x00)
> > > > HCI Event: Command Complete (0x0e) plen 4                          =
                                                     #602 [hci0] 19:22:57.1=
65530
> > >       LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
> > >         Status: Success (0x00)
> > > < HCI Command: LE Add Device To Resolving List (0x08|0x0027) plen 39
> > >                                                    #603 [hci0]
> > > 19:22:57.165663
> > >         Address type: Public (0x00)
> > >         Address: DC:A6:32:A4:08:BF (OUI DC-A6-32)
> > >         Peer identity resolving key: 0bf179254f3b2eb51324711e416f22e8
> > >         Local identity resolving key: 0000000000000000000000000000000=
0
> > > ...
> > >
> > > Before applying the above patch, there will be a set device flag
> > > command in the place of the error, but the command will fail.
> > >
> > > @ MGMT Command: Set Device Flags (0x0050) plen 11
> > >                                                {0x0003} [hci0]
> > > 00:42:59.247080
> > >         LE Address: E4:5F:01:89:8F:85 (OUI E4-5F-01)
> > >         Current Flags: 0x00000001
> > >           Remote Wakeup
> > > @ MGMT Event: Command Complete (0x0001) plen 10
> > >                                                {0x0003} [hci0]
> > > 00:42:59.247129
> > >       Set Device Flags (0x0050) plen 7
> > >         Status: Invalid Parameters (0x0d)
> > >         LE Address: E4:5F:01:89:8F:85 (OUI E4-5F-01)
> > >
> > > Please let me know your opinion.
> >
> > Perhaps we need the following patch in order to make sure the
> > experimental flags are enabled _before_ wake_support logic is
> > triggered:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/00052eaeb78774fd7b=
e365805203cb0c8b189243.1692531437.git.pav@iki.fi/
> >
> > I'm in the process of applying it since it we do have similar problem
> > with the likes of ISO sockets that needs to be enabled before loading
> > drivers, etc.
> >
> > > Thanks,
> > > Zhengping
> > >
> > > On Mon, Aug 21, 2023 at 11:00=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Aug 21, 2023 at 10:28=E2=80=AFAM Zhengping Jiang <jiangzp@g=
oogle.com> wrote:
> > > > >
> > > > > For the device using a RPA, hog_probe sets wake_override to true,=
 but
> > > > > the command to set remote wakeup fails because the device has not=
 been
> > > > > added to the kernel and the connection with the public address ca=
nnot be
> > > > > found.
> > > >
> > > > This is actually not true, hog_probe does call
> > > > device_set_wake_support, also note that I had a fix on how we handl=
e
> > > > RPA with remote wakeup because that depends on LL Privacy/RPA
> > > > Resolution:
> > > >
> > > > commit 7a4b67f9caa6bdc004c910f3a52108744a8cab74
> > > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > Date:   Thu May 12 16:40:49 2022 -0700
> > > >
> > > >     device: Fix enabling wake support without RPA Resolution
> > > >
> > > >     If device uses RPA it shall only enable wakeup if RPA Resolutio=
n has
> > > >     been enabled otherwise it cannot be programmed in the acceptlis=
t which
> > > >     can cause suspend to fail.
> > > >
> > > >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215768
> > > >
> > > >
> > > > > When setting the device privacy flag, the wakeup flag should be s=
et
> > > > > according to the wake_override, instead of the current flags.
> > > >
> > > > Afaik wake_override is only set by the user via WakeAllowed, plugin=
s
> > > > shall not be using it directly, so it really sounds like this doesn=
't
> > > > apply to current upstream.
> > > >
> > > > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > > > > ---
> > > > >
> > > > > Changes in v1:
> > > > > - Add function to fetch wake_override value
> > > > > - Set the remote wakeup bit if privacy mode is used when setting =
flags
> > > > >
> > > > >  src/adapter.c | 2 ++
> > > > >  src/device.c  | 5 +++++
> > > > >  src/device.h  | 1 +
> > > > >  3 files changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index 004062e7c..f63018495 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -5520,6 +5520,8 @@ static void add_device_complete(uint8_t sta=
tus, uint16_t length,
> > > > >         if (btd_opts.device_privacy) {
> > > > >                 uint32_t flags =3D btd_device_get_current_flags(d=
ev);
> > > > >
> > > > > +               if (device_get_wake_override(dev))
> > > > > +                       flags |=3D DEVICE_FLAG_REMOTE_WAKEUP;
> > > >
> > > > We shall only use override if wake_support is set.
> > > >
> > > > >                 /* Set Device Privacy Mode has not set the flag y=
et. */
> > > > >                 if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
> > > > >                         adapter_set_device_flags(adapter, dev, fl=
ags |
> > > > > diff --git a/src/device.c b/src/device.c
> > > > > index 9b58e0c4e..ae75f2fd1 100644
> > > > > --- a/src/device.c
> > > > > +++ b/src/device.c
> > > > > @@ -1545,6 +1545,11 @@ void device_set_wake_override(struct btd_d=
evice *device, bool wake_override)
> > > > >         }
> > > > >  }
> > > > >
> > > > > +bool device_get_wake_override(struct btd_device *device)
> > > > > +{
> > > > > +       return device->wake_override;
> > > > > +}
> > > > > +
> > > > >  static void device_set_wake_allowed_complete(struct btd_device *=
device)
> > > > >  {
> > > > >         if (device->wake_id !=3D -1U) {
> > > > > diff --git a/src/device.h b/src/device.h
> > > > > index 3252e14ef..79377a13a 100644
> > > > > --- a/src/device.h
> > > > > +++ b/src/device.h
> > > > > @@ -141,6 +141,7 @@ void device_set_wake_support(struct btd_devic=
e *device, bool wake_support);
> > > > >  void device_set_wake_override(struct btd_device *device, bool wa=
ke_override);
> > > > >  void device_set_wake_allowed(struct btd_device *device, bool wak=
e_allowed,
> > > > >                              guint32 id);
> > > > > +bool device_get_wake_override(struct btd_device *device);
> > > > >  void device_set_refresh_discovery(struct btd_device *dev, bool r=
efresh);
> > > > >
> > > > >  typedef void (*disconnect_watch) (struct btd_device *device, gbo=
olean removal,
> > > > > --
> > > > > 2.42.0.rc1.204.g551eb34607-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
