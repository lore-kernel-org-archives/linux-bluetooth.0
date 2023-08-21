Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647DEE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjHUTvZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHUTvY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 15:51:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EA132
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:51:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso30010751fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692647477; x=1693252277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcI3nU5o1v5tS8wbo1deGIUlHheA3F01B4zpN7GPwg0=;
        b=QGDCOpzrsG5Qx81c2m+He6LyDn58o6PPdKvMXEL7P3/7XsqTFnEJqVJOIXK3awSZTu
         88DUDsCxaFfojy+zD53+T9ycIm4Vv9sxTmYoGaV5WZ6eeROjuanDkBkhuVBbaLUOw0Ut
         RIsEC3sp6lnoAZbGzotrVyZTMjNmLrvUubWNGkIFpr0IZlFGJU27JzDqRTH4yDBJHyq2
         fA7vdq3sZzgNOisUlLO1HRFH3oAlI/nHOa9rgXkY6iRIZk40INrQFYT7iE+bke5u5yZv
         JgUGW0pLXXD0rhhTLwg9X26neo9TQGF5ghChiei2SzWszY0WzYoXFBk6FlzGBvIklqrW
         jGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647477; x=1693252277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcI3nU5o1v5tS8wbo1deGIUlHheA3F01B4zpN7GPwg0=;
        b=c/jITYOSu+JnP2h1XMI7dte05lxzmewu9SHeITVt/9os7jezIUpN9bhtWSEWQP0nab
         6CD2TrXHuy3eW/fl0V4G4ZwUpBq/SmQS3tqU2CksXsbAYq0cgA8TIFxr2PHEgmUsotuJ
         pYOB7/9qVLNPTvaLPYY82VCCTNin7HXuTQahB6DDtVnv7waqiiTSY2rDRq1sqQcP6i6w
         xHC+SQxfa61uKAb18DMR2bUh0ULl9ayH5vfpDc4KY2FqW3JkNU4KweCq4lDNKNJT9dRL
         LTzQwYG6YTSWmrxrso9/reoby1olfcRMsPs5UFJoBiycp7K1hy4qlwbhgc6rAWny2e1e
         4TuQ==
X-Gm-Message-State: AOJu0Yy7jSzQXEpysXjtuTs+ba68Rtm8klsuVN27DRzEbBJtzzg33MF4
        AvEWmkOIS/TlQIZPz64CJwLGlcLn21Na+wc1/r4=
X-Google-Smtp-Source: AGHT+IETNpmucZ93jwXcf3yZT4f3I2DcveH5MwrDFvIGS59Kw9SVPAj71snld7vNUpeTCmnCwsSdcb3st+Xky+vS7EY=
X-Received: by 2002:a2e:920b:0:b0:2bb:a06d:1d3c with SMTP id
 k11-20020a2e920b000000b002bba06d1d3cmr5272702ljg.24.1692647476370; Mon, 21
 Aug 2023 12:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
 <CABBYNZK8SW9aMHL-yrCQUN+72z_rDZWK83wAdutMA8xG-Zdo9A@mail.gmail.com> <CAB4PzUpL-FBU0tz1gXjqZXY1ZoJKNSCqcf92Q=yhGo0g5YbtEQ@mail.gmail.com>
In-Reply-To: <CAB4PzUpL-FBU0tz1gXjqZXY1ZoJKNSCqcf92Q=yhGo0g5YbtEQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Aug 2023 12:51:03 -0700
Message-ID: <CABBYNZKaaSjmJ4ZLOsBjHYRw8Uoou0XbJKKnZ07Y30+hQONqnQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: check wake_override when setting device privacy
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 12:45=E2=80=AFPM Zhengping Jiang <jiangzp@google.co=
m> wrote:
>
> Hi Luiz,
>
> Thanks for the reply. I applied the above patch "device: Fix enabling
> wake support without RPA Resolution" and tried again. I can see there
> are still some things missing.
> I have attached a btsnoop log for reference. Here I am using a rasp pi
> configured as a LE mouse which is in privacy mode.
>
> The ll privacy feature is enabled at the beginning.
> @ MGMT Command: Set Experimental Feature (0x004a) plen 17
>                                                {0x0003} [hci0]
> 19:21:30.193783
>         UUID: BlueZ Experimental LL privacy
>         Action: Enabled (0x01)
>
> Later the LE advertisement with RPA is received.
>
> > HCI Event: LE Meta Event (0x3e) plen 32                                =
                                                 #311 [hci0] 19:22:36.63372=
4
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0013
>             Props: 0x0013
>               Connectable
>               Scannable
>               Use legacy advertising PDUs
>             Data status:  [0;32mComplete [0m
>           Legacy PDU Type: ADV_IND (0x0013)
>           Address type: Random (0x01)
>           Address: 6F:CB:45:0C:AD:1F (Resolvable)
>
> But I still get the error for not being able to set wake_support. I
> think this is not right as the address resolution is already enabled.
> I haven't checked the details yet.
>
> =3D bluetoothd: Unable to set wake_support without RPA resolution
>
> 19:22:41.337325
>
> Then the wake up flag is not set as a result.
>
> @ MGMT Event: Device Flags Changed (0x002a) plen 15
>                                                {0x0003} [hci0]
> 19:22:41.372969
>         LE Address: DC:A6:32:A4:08:BF (OUI DC-A6-32)
>         Supported Flags: 0x00000003
>           Remote Wakeup
>           Device Privacy Mode
>         Current Flags: 0x00000002
>           Device Privacy Mode
>
> The address resolution is enabled as shown later in the log, after the
> adapter reboot and the LE mouse can reconnect with RPA.
>
> < HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
>                                                    #601 [hci0]
> 19:22:57.164690
>         Address resolution: Disabled (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                 #602 [hci0] 19:22:57.16553=
0
>       LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Add Device To Resolving List (0x08|0x0027) plen 39
>                                                    #603 [hci0]
> 19:22:57.165663
>         Address type: Public (0x00)
>         Address: DC:A6:32:A4:08:BF (OUI DC-A6-32)
>         Peer identity resolving key: 0bf179254f3b2eb51324711e416f22e8
>         Local identity resolving key: 00000000000000000000000000000000
> ...
>
> Before applying the above patch, there will be a set device flag
> command in the place of the error, but the command will fail.
>
> @ MGMT Command: Set Device Flags (0x0050) plen 11
>                                                {0x0003} [hci0]
> 00:42:59.247080
>         LE Address: E4:5F:01:89:8F:85 (OUI E4-5F-01)
>         Current Flags: 0x00000001
>           Remote Wakeup
> @ MGMT Event: Command Complete (0x0001) plen 10
>                                                {0x0003} [hci0]
> 00:42:59.247129
>       Set Device Flags (0x0050) plen 7
>         Status: Invalid Parameters (0x0d)
>         LE Address: E4:5F:01:89:8F:85 (OUI E4-5F-01)
>
> Please let me know your opinion.

Perhaps we need the following patch in order to make sure the
experimental flags are enabled _before_ wake_support logic is
triggered:

https://patchwork.kernel.org/project/bluetooth/patch/00052eaeb78774fd7be365=
805203cb0c8b189243.1692531437.git.pav@iki.fi/

I'm in the process of applying it since it we do have similar problem
with the likes of ISO sockets that needs to be enabled before loading
drivers, etc.

> Thanks,
> Zhengping
>
> On Mon, Aug 21, 2023 at 11:00=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 21, 2023 at 10:28=E2=80=AFAM Zhengping Jiang <jiangzp@googl=
e.com> wrote:
> > >
> > > For the device using a RPA, hog_probe sets wake_override to true, but
> > > the command to set remote wakeup fails because the device has not bee=
n
> > > added to the kernel and the connection with the public address cannot=
 be
> > > found.
> >
> > This is actually not true, hog_probe does call
> > device_set_wake_support, also note that I had a fix on how we handle
> > RPA with remote wakeup because that depends on LL Privacy/RPA
> > Resolution:
> >
> > commit 7a4b67f9caa6bdc004c910f3a52108744a8cab74
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Thu May 12 16:40:49 2022 -0700
> >
> >     device: Fix enabling wake support without RPA Resolution
> >
> >     If device uses RPA it shall only enable wakeup if RPA Resolution ha=
s
> >     been enabled otherwise it cannot be programmed in the acceptlist wh=
ich
> >     can cause suspend to fail.
> >
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215768
> >
> >
> > > When setting the device privacy flag, the wakeup flag should be set
> > > according to the wake_override, instead of the current flags.
> >
> > Afaik wake_override is only set by the user via WakeAllowed, plugins
> > shall not be using it directly, so it really sounds like this doesn't
> > apply to current upstream.
> >
> > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > > ---
> > >
> > > Changes in v1:
> > > - Add function to fetch wake_override value
> > > - Set the remote wakeup bit if privacy mode is used when setting flag=
s
> > >
> > >  src/adapter.c | 2 ++
> > >  src/device.c  | 5 +++++
> > >  src/device.h  | 1 +
> > >  3 files changed, 8 insertions(+)
> > >
> > > diff --git a/src/adapter.c b/src/adapter.c
> > > index 004062e7c..f63018495 100644
> > > --- a/src/adapter.c
> > > +++ b/src/adapter.c
> > > @@ -5520,6 +5520,8 @@ static void add_device_complete(uint8_t status,=
 uint16_t length,
> > >         if (btd_opts.device_privacy) {
> > >                 uint32_t flags =3D btd_device_get_current_flags(dev);
> > >
> > > +               if (device_get_wake_override(dev))
> > > +                       flags |=3D DEVICE_FLAG_REMOTE_WAKEUP;
> >
> > We shall only use override if wake_support is set.
> >
> > >                 /* Set Device Privacy Mode has not set the flag yet. =
*/
> > >                 if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
> > >                         adapter_set_device_flags(adapter, dev, flags =
|
> > > diff --git a/src/device.c b/src/device.c
> > > index 9b58e0c4e..ae75f2fd1 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -1545,6 +1545,11 @@ void device_set_wake_override(struct btd_devic=
e *device, bool wake_override)
> > >         }
> > >  }
> > >
> > > +bool device_get_wake_override(struct btd_device *device)
> > > +{
> > > +       return device->wake_override;
> > > +}
> > > +
> > >  static void device_set_wake_allowed_complete(struct btd_device *devi=
ce)
> > >  {
> > >         if (device->wake_id !=3D -1U) {
> > > diff --git a/src/device.h b/src/device.h
> > > index 3252e14ef..79377a13a 100644
> > > --- a/src/device.h
> > > +++ b/src/device.h
> > > @@ -141,6 +141,7 @@ void device_set_wake_support(struct btd_device *d=
evice, bool wake_support);
> > >  void device_set_wake_override(struct btd_device *device, bool wake_o=
verride);
> > >  void device_set_wake_allowed(struct btd_device *device, bool wake_al=
lowed,
> > >                              guint32 id);
> > > +bool device_get_wake_override(struct btd_device *device);
> > >  void device_set_refresh_discovery(struct btd_device *dev, bool refre=
sh);
> > >
> > >  typedef void (*disconnect_watch) (struct btd_device *device, gboolea=
n removal,
> > > --
> > > 2.42.0.rc1.204.g551eb34607-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
