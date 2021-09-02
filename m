Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A31C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5D361059
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbhIBWiH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbhIBWiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 18:38:07 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEEFC061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 15:37:08 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id n63so2891485vsc.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8FcPrE3HcW7f8iM5dt31z89Ehrv4exdQpTItfjb9/F4=;
        b=Lxjy7aHFPB/UoASPbV5DlpXIxazARv5aqQmj4pg71N2uIku/FMHuhYmfGSgajalvY6
         2qkaU3GL/FNbR1e/1ETdW0jF3KdI1ZqP7k1RwBb0BEnYEOWzLHs0FdTAvGaD/lf83VSQ
         jHD6ymAgXvFInTHMJja/EFiZkTQ3NcOeX66S5PTuMAQoTyJLdiupKP1LFMMSwhG8rjXR
         EC9gWGiduRmOcdV9OGFhtC1oKgBKP2oCv4H5hX5sN6b6pxQUhgMMM3MSImGp9SBs85Pc
         KVSj3CYrBSb6wCIe7TLce8WjnVN2CAvwURg1Xkxb27hI1+M00HDeUs0SbFaLqobVPRk1
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8FcPrE3HcW7f8iM5dt31z89Ehrv4exdQpTItfjb9/F4=;
        b=ITlVi+SHmPQ6LsHRFyurlarK8hs5ZCB5xriTVaLHnVXHnIIaODECRgkUNMDdk9Psud
         DZRQnoYemeGhrxOAgPqw6TiDoFnPsxpQ5nAlIjnIyxiSWOvct1GS0VJvwPrUwc8OK+3g
         Q90tpxfaZ/W6P1h8HxD+wNuFxvd3iNnZyvW6pqZ/ifGjMM9E+c5VhI/AXWzpg5UJbY80
         kuthPZ2k9e5BlvRfTA53QfVZuvI+LX5UfQ+3/BHfWHrJ2/iHtaYdm+MnQinFSxUw4Qy6
         hxuHH0jdGj1I+LBAyAp9YCj5MBCHrBGRlLFH3KPxuOFSidUDlv8NXQKmFSBT2kJ2vu6k
         N2GQ==
X-Gm-Message-State: AOAM533peDAvJx77GiE4TKboyJIQGy44ojYGskUAb6C831qFitpGett9
        3cqEqTooWE5JF5K5DRUdGj9C0xBomQbIXObw69iPHBkxn5Y=
X-Google-Smtp-Source: ABdhPJzvQW/RuxRgUYaxXfra4iDHPYCsZ9psMR/lH0GUQahixp6S7vrLIoZF6DHfdyXPgqFSZIt3coHiUuORT64IzU8=
X-Received: by 2002:a67:2e10:: with SMTP id u16mr191423vsu.7.1630622227384;
 Thu, 02 Sep 2021 15:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210831115637.6713-1-kiran.k@intel.com> <20210831115637.6713-12-kiran.k@intel.com>
 <CABBYNZL3=z6CWj9EAiGnOkcaEmgs1Mq7kc5-fT4Mjk2HCUPsFA@mail.gmail.com> <SJ0PR11MB486301A4412E6D42D85EE253D8CE9@SJ0PR11MB4863.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB486301A4412E6D42D85EE253D8CE9@SJ0PR11MB4863.namprd11.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Sep 2021 15:36:56 -0700
Message-ID: <CABBYNZLgH81VkkLyQwfxuZpCsiTvt-RCkNpArGLiCRy69e0tww@mail.gmail.com>
Subject: Re: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend when SCO
 use non-HCI transport
To:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Cc:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Pierres, Arnaud" <arnaud.pierres@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chethan,

On Wed, Sep 1, 2021 at 8:52 PM Tumkur Narayan, Chethan
<chethan.tumkur.narayan@intel.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Thursday, September 2, 2021 5:24 AM
> > To: K, Kiran <kiran.k@intel.com>
> > Cc: linux-bluetooth@vger.kernel.org; Tumkur Narayan, Chethan
> > <chethan.tumkur.narayan@intel.com>
> > Subject: Re: [PATCH v13 12/12] Bluetooth: Allow usb to auto-suspend whe=
n SCO
> > use non-HCI transport
> >
> > Hi Kiran,
> >
> > On Tue, Aug 31, 2021 at 4:54 AM Kiran K <kiran.k@intel.com> wrote:
> > >
> > > From: Chethan T N <chethan.tumkur.narayan@intel.com>
> > >
> > > Currently usb tranport is not allowed to suspend when SCO over HCI
> > > tranport is active.
> > >
> > > This patch shall enable the usb tranport to suspend when SCO link use
> > > non-HCI transport
> > >
> > > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > ---
> > >
> > > Notes:
> > >     changes in v13:
> > >     - suspend usb in HFP offload use case
> > >
> > >  drivers/bluetooth/btintel.c       |  2 +-
> > >  include/net/bluetooth/bluetooth.h |  4 ++++
> > >  net/bluetooth/hci_event.c         | 20 +++++++++++---------
> > >  net/bluetooth/sco.c               |  2 +-
> > >  4 files changed, 17 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index 6091b691ddc2..2d64e289cf6e 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -2215,7 +2215,7 @@ static int btintel_get_codec_config_data(struct
> > > hci_dev *hdev,  static int btintel_get_data_path_id(struct hci_dev
> > > *hdev, __u8 *data_path_id)  {
> > >         /* Intel uses 1 as data path id for all the usecases */
> > > -       *data_path_id =3D 1;
> > > +       *data_path_id =3D BT_SCO_PCM_PATH;
> > >         return 0;
> > >  }
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h
> > > b/include/net/bluetooth/bluetooth.h
> > > index c1fa90fb7502..9e2745863b33 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -177,6 +177,10 @@ struct bt_codecs {
> > >  #define CODING_FORMAT_TRANSPARENT      0x03
> > >  #define CODING_FORMAT_MSBC             0x05
> > >
> > > +/* Audio data transport path used for SCO */ #define BT_SCO_HCI_PATH
> > > +0x00 #define BT_SCO_PCM_PATH 0x01
> >
> > If this is in fact vendor specific perhaps you should be declared in bt=
intel.h not
> > here.
> This is defined the Host Controller Interface assigned numbers, page no.3=
 "Transport Layer"- https://btprodspecificationrefs.blob.core.windows.net/a=
ssigned-numbers/Assigned%20Number%20Types/Host%20Controller%20Interface.pdf=
. So defined in bluetooth.h, let me know if you think otherwise.

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2221
Data_Path_ID:
0x01 to 0xFE Logical channel number; the meaning is vendor-specific.


BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2022
Input_Data_Path:
0x01 to 0xFE Logical_Channel_Number. The meaning of the logical channels wi=
ll be
vendor specific.
Output_Data_Path:
0x01 to 0xFE Logical_Channel_Number. The meaning of the logical channels wi=
ll be
vendor specific.

> >
> > > +
> > >  __printf(1, 2)
> > >  void bt_info(const char *fmt, ...);
> > >  __printf(1, 2)
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index b48e24629fa4..7ff11cba89cf 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -4516,15 +4516,17 @@ static void hci_sync_conn_complete_evt(struct
> > > hci_dev *hdev,
> > >
> > >         bt_dev_dbg(hdev, "SCO connected with air mode: %02x",
> > > ev->air_mode);
> > >
> > > -       switch (ev->air_mode) {
> > > -       case 0x02:
> > > -               if (hdev->notify)
> > > -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD=
);
> > > -               break;
> > > -       case 0x03:
> > > -               if (hdev->notify)
> > > -                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRAN=
SP);
> > > -               break;
> > > +       if (conn->codec.data_path =3D=3D BT_SCO_HCI_PATH) {
> > > +               switch (ev->air_mode) {
> > > +               case 0x02:
> > > +                       if (hdev->notify)
> > > +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_=
SCO_CVSD);
> > > +                       break;
> > > +               case 0x03:
> > > +                       if (hdev->notify)
> > > +                               hdev->notify(hdev, HCI_NOTIFY_ENABLE_=
SCO_TRANSP);
> > > +                       break;
> > > +               }
> >
> > Hmm I think we might need to notify the driver to enable PCM routing so=
 the
> > likes of btusb can call usb_disable_endpoint/usb_enable_endpoint for ex=
ample
> > since in theory userspace may choose to switch from
> > offload and vice-versa, note without calling usb_disable_endpoint there=
 might
> > not be much power saving after all since the endpoint will remain activ=
e or do
> > we actually have a good explanation why it shall not be called when usi=
ng PCM
> > routing? Note that usb_set_interface will call usb_enable_interface tha=
t will
> > then call usb_enable_endpoint so perhaps we need to call
> > usb_disable_interface, either way we can't assume the platform will be
> > restricted to only use one or the other.
> Ack, Does it make sense to define and notify events "HCI_NOTIFY_DISABLE_S=
CO_USB_INTF ", "HCI_NOTIFY_ENABLE_SCO_USB_INTF " accordingly and handle thi=
s in btusb driver by disabling/enabling the ISOC endpoint respectively. Tha=
t will serve the purpose or switch between software to hardware.

Or perhaps we should switch to notify the actual data path, in fact
there could be situations where we have both hardware offload and
software based if we were dealing with multiple connections in which
case we would need to check if there is any connection using HCI
routing before disabling it.

> >
> > >         }
> > >
> > >         hci_connect_cfm(conn, ev->status); diff --git
> > > a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
> > > 004bce2b5eca..f35c12ca6aa5 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -506,7 +506,7 @@ static struct sock *sco_sock_alloc(struct net *ne=
t,
> > struct socket *sock,
> > >         sco_pi(sk)->codec.id =3D CODING_FORMAT_CVSD;
> > >         sco_pi(sk)->codec.cid =3D 0xffff;
> > >         sco_pi(sk)->codec.vid =3D 0xffff;
> > > -       sco_pi(sk)->codec.data_path =3D 0x00;
> > > +       sco_pi(sk)->codec.data_path =3D BT_SCO_HCI_PATH;
> > >
> > >         bt_sock_link(&sco_sk_list, sk);
> > >         return sk;
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
