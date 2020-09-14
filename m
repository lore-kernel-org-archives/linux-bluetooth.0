Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F6C43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4D620EDD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUvMIK5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgINRnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgINMX2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 08:23:28 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9EC0698C4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 05:18:40 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h20so11651064ybj.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95MkvjALtD+pWjI9L+dX9jS5l3VsX/dwVwk6PdF2H90=;
        b=BUvMIK5XM9/nSld70H/GBdIBvh2rIH9jwVh7E1IIo3gf+O+eVnOdStAbg+NveSxK7z
         e/XTV+vzv/3uHTlycyTHZ6NAP3kzlg0reNW4YWL71VPf1wB8oGisMQBQgAgMNPIx3cnN
         Vvdt2NZHPLkg9yIAdHfj9DXEGJdPO7P5XqRo7dAiPsBeZhDsOwN1CtuCy4G+Msha0XO0
         JslegxXzxikldWKnjhEcEWvtQKwuSqXWQJRSm0llo1ZOmwPqN/v29jLjAWYhfeJHfWgq
         FcK3c/fpRNXSvH2lCrn/2KY4t2uEbmR4g5XA1l31V2d0hsN7k0jwLeisbZ0ZByI78EPU
         CfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95MkvjALtD+pWjI9L+dX9jS5l3VsX/dwVwk6PdF2H90=;
        b=EAMfSOZJPfLciSAd5Dk3L3VoOpco1jNvBWXkHLAN1BdV4uuiEM34K119H6v7OweGYI
         MnDiojR7aHOzIdy4ifeCZ1nT1yU94aG/GCQjdwnaIMNDVQzu4J1lsnMTojYhtnbPcjk4
         XEUWkbABVy31PKRlEnJWcYdOVSkCuMETcFLgCMDWnITarGgoKsVOCfgMsDwQj90RRk6v
         YyFsb5bpVUnihNVN4VT7tOWFaCKkbg82jm4/AYdcv7BcllFCmOEL+YT2000EOFgoQHpq
         HvHOZVhWC8JypFiaK1aJRLrnzIiIzg+n6jt0uqWKRr4s3zz1DDz0hl92wJue7iexafUl
         Y1rQ==
X-Gm-Message-State: AOAM533jfpgy8ymdUNzZEj0F4cXE36eRIFzpOR17Hnu5Eb6HidXGLDMd
        pXw1ew0O11n+h5ijzL5x+WkV/uOt8nzR5uGztYEONQ==
X-Google-Smtp-Source: ABdhPJxjgaCTkVcsuVGglaPfAZXtOAa3ztmw6wM6ggRMFf1DI4xOOd4Bkak99KEX4rW77bs7qnBN4tc79sW8Wyszurk=
X-Received: by 2002:a25:db88:: with SMTP id g130mr20706294ybf.193.1600085919205;
 Mon, 14 Sep 2020 05:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910060403.144524-1-josephsih@chromium.org>
 <20200910140342.v3.1.I56de28ec171134cb9f97062e2c304a72822ca38b@changeid> <20200910081842.yunymr2l4fnle5nl@pali>
In-Reply-To: <20200910081842.yunymr2l4fnle5nl@pali>
From:   Joseph Hwang <josephsih@google.com>
Date:   Mon, 14 Sep 2020 20:18:27 +0800
Message-ID: <CAHFy418Ln9ONHGVhg513g0v+GxUZMDtLpe5NFONO3HuAZz=r7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: define HCI packet sizes of USB Alts
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Sep 10, 2020 at 4:18 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Thursday 10 September 2020 14:04:01 Joseph Hwang wrote:
> > It is desirable to define the HCI packet payload sizes of
> > USB alternate settings so that they can be exposed to user
> > space.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Set hdev->sco_mtu to rp->sco_mtu if the latter is smaller.
> >
> > Changes in v2:
> > - Used sco_mtu instead of a new sco_pkt_len member in hdev.
> > - Do not overwrite hdev->sco_mtu in hci_cc_read_buffer_size
> >   if it has been set in the USB interface.
> >
> >  drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++++++++----------
> >  net/bluetooth/hci_event.c | 14 +++++++++++-
> >  2 files changed, 47 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index fe80588c7bd3a8..651d5731a6c6cf 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -459,6 +459,24 @@ static const struct dmi_system_id btusb_needs_rese=
t_resume_table[] =3D {
> >  #define BTUSB_WAKEUP_DISABLE 14
> >  #define BTUSB_USE_ALT1_FOR_WBS       15
> >
> > +/* Per core spec 5, vol 4, part B, table 2.1,
> > + * list the hci packet payload sizes for various ALT settings.
> > + * This is used to set the packet length for the wideband speech.
> > + * If a controller does not probe its usb alt setting, the default
> > + * value will be 0. Any clients at upper layers should interpret it
> > + * as a default value and set a proper packet length accordingly.
> > + *
> > + * To calculate the HCI packet payload length:
> > + *   for alternate settings 1 - 5:
> > + *     hci_packet_size =3D suggested_max_packet_size * 3 (packets) -
> > + *                       3 (HCI header octets)
> > + *   for alternate setting 6:
> > + *     hci_packet_size =3D suggested_max_packet_size - 3 (HCI header o=
ctets)
> > + *   where suggested_max_packet_size is {9, 17, 25, 33, 49, 63}
> > + *   for alt settings 1 - 6.
>
> Thank you for update, now I see what you mean!
>
> > + */
> > +static const int hci_packet_size_usb_alt[] =3D { 0, 24, 48, 72, 96, 14=
4, 60 };
>
> Now the another question, why you are using hci_packet_size_usb_alt[1]
> and hci_packet_size_usb_alt[6] values from this array?

Will answer it per the spec in the next patch series.

>
> > +
> >  struct btusb_data {
> >       struct hci_dev       *hdev;
> >       struct usb_device    *udev;
> > @@ -3959,6 +3977,15 @@ static int btusb_probe(struct usb_interface *int=
f,
> >       hdev->notify =3D btusb_notify;
> >       hdev->prevent_wake =3D btusb_prevent_wake;
> >
> > +     if (id->driver_info & BTUSB_AMP) {
> > +             /* AMP controllers do not support SCO packets */
> > +             data->isoc =3D NULL;
> > +     } else {
> > +             /* Interface orders are hardcoded in the specification */
> > +             data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> > +             data->isoc_ifnum =3D ifnum_base + 1;
> > +     }
> > +
> >  #ifdef CONFIG_PM
> >       err =3D btusb_config_oob_wake(hdev);
> >       if (err)
> > @@ -4022,6 +4049,10 @@ static int btusb_probe(struct usb_interface *int=
f,
> >               hdev->set_diag =3D btintel_set_diag;
> >               hdev->set_bdaddr =3D btintel_set_bdaddr;
> >               hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> > +
> > +             if (btusb_find_altsetting(data, 6))
> > +                     hdev->sco_mtu =3D hci_packet_size_usb_alt[6];
>
> Why you are setting this sco_mtu only for Intel adapter? Is not this
> whole code generic to USB?

Please refer to the answer to the Realtek adapter below. Thanks.

>
> > +
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > @@ -4063,15 +4094,6 @@ static int btusb_probe(struct usb_interface *int=
f,
> >               btusb_check_needs_reset_resume(intf);
> >       }
> >
> > -     if (id->driver_info & BTUSB_AMP) {
> > -             /* AMP controllers do not support SCO packets */
> > -             data->isoc =3D NULL;
> > -     } else {
> > -             /* Interface orders are hardcoded in the specification */
> > -             data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> > -             data->isoc_ifnum =3D ifnum_base + 1;
> > -     }
> > -
> >       if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
> >           (id->driver_info & BTUSB_REALTEK)) {
> >               hdev->setup =3D btrtl_setup_realtek;
> > @@ -4083,9 +4105,10 @@ static int btusb_probe(struct usb_interface *int=
f,
> >                * (DEVICE_REMOTE_WAKEUP)
> >                */
> >               set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> > -             if (btusb_find_altsetting(data, 1))
> > +             if (btusb_find_altsetting(data, 1)) {
> >                       set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
> > -             else
> > +                     hdev->sco_mtu =3D hci_packet_size_usb_alt[1];
>
> And this part of code which you write is Realtek specific.

We currently only have Intel and Realtek platforms to test with. If
making it generic without proper testing platforms is fine, I will
make it generic. Or do you think it might be better to make it
customized with particular vendors for now; and make it generic later
when it works well with sufficient vendors?

>
> I thought that this is something generic to bluetooth usb as you pointed
> to bluetooth documentation "core spec 5, vol 4, part B, table 2.1".
>
> > +             } else
> >                       bt_dev_err(hdev, "Device does not support ALT set=
ting 1");
> >       }
>
> Also this patch seems to be for me incomplete or not fully correct as
> USB altsetting is chosen in function btusb_work() and it depends on
> selected AIR mode (which is configured by another setsockopt).
>
> So despite what is written in commit message, this patch looks for me
> like some hack for Intel and Realtek bluetooth adapters and does not
> solve problems in vendor independent manner.

You are right that sco_mtu should be changed according to the air
mode. Here are some issues to handle and what I plan to do. I would
like to solicit your comments before I submit the next series.

[Issue 1] The air mode is determined in btusb_work() which is
triggered by hci_sync_conn_complete_evt(). So =E2=80=9Cconn->mtu =3D
hdev->sco_mtu=E2=80=9D should not be done in  sco_conn_add() in the early
connecting stage. Instead, it will be moved to near the end of
hci_sync_conn_complete_evt().

[Issue 2] The btusb_work() is performed by a worker. There would be a
timing issue here if we let btusb_work() to do =E2=80=9Chdev->sco_mtu =3D
hci_packet_size_usb_alt[i]=E2=80=9D because there is no guarantee how soon =
the
btusb_work() can be finished and get =E2=80=9Chdev->sco_mtu=E2=80=9D value =
set
correctly. In order to avoid the potential race condition, I suggest
to determine air_mode in btusb_notify() before
schedule_work(&data->work) is executed so that =E2=80=9Chdev->sco_mtu =3D
hci_packet_size_usb_alt[i]=E2=80=9D is guaranteed to be performed when
btusb_notify() finished. In this way, hci_sync_conn_complete_evt() can
set conn->mtu correctly as described in [Issue 1] above.

[Issue 3] Concerning CVSD: The above flow is good when the transparent
mode is selected. When it is the CVSD mode, we should set
hdev->sco_mtu and conn->mtu back to the original mtu size returned by
hci_cc_read_buffer_size(). This is because we do not have a reliable
way to determine what size is used with CVSD. AFAIK, controllers
connected through USB use 48 bytes; and controllers connected through
UART use 60 bytes. It seems to me that these numbers are not recorded
in the kernel(?). It seems beyond the scope of this patch to set the
proper value for CVSD. So we will let hdev->sco_mtu and conn->mtu go
back to their original values and are not affected by this patch.

I am wondering if such directions of fixing this patch look good to you?

Thanks and regards!
Joseph



--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
