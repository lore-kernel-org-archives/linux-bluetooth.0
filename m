Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhLQTbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 14:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhLQTbj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 14:31:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E1C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:31:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so9298732ybg.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h++p6uSE/i8iUVd7GiltuHd2ov3F9+aKoViJVjzS6bc=;
        b=LrCMqmiDnK4TnLV1z0Uk3RSLoOV7JDV8tTB91pbkFt9DUKh/2FjlJxxlmrrhm4P4WO
         1dmK3rWVwm2rKKWkqMOcO42RG2xRUZhv0a1Gdv7QR1TAnOQQxrWlqaUsSNOtH1GiXzhV
         Jp60IVV4SVfHFda/SADIyhHvo0GTg1i7OxILip0gg4tThWo+SITZdNcOTcPyS3DUEIyF
         8+lJoaos11yhW7Q8Pk51mJg8YIaKdk9b7F6cZRKawgnP3D3cEH5fg9k1Te77yUZVEcaJ
         axLZMZFGB4qkXRc3sOPk16ztBOE8JrkJFDCfJXvie83k3GonX2bFu7fSYifMO91mMY2P
         /ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h++p6uSE/i8iUVd7GiltuHd2ov3F9+aKoViJVjzS6bc=;
        b=RPeO8mBxVl0wYRoCykdaqBCsmdIExaFtU19sLK/WzqTEfdbKzNNlBjAI7AaN2+URvv
         2q0w8Hf5WgvAEQWvvI0g79/sboBm9Wl2zChlW6i1LlY9pyuLocnq9H829QFW6p1zx2qc
         FWQWdNQOGhQR61q/iueJfbGXAWwHqXrSTTsKhJrBQdcbWkarPjL4z62ZPP6/LLeE4pVc
         qTQdm+MEW5PmTxUWVbdfmsnYnuSqks8v0AgWjPE7g5Ae0tbMFg6zfVrBQFnP3b+QoDX+
         4mFTcUtaObub8h5WK0PXi7XWYiWuIYwZErvxSReYZFosjkVvRc8jey6JaIaMQSLTCGMS
         jVeA==
X-Gm-Message-State: AOAM532YbeVB2I3qEOnYf7L/SiskPVONpnS35e1YAYLnizETyn1cmQkY
        jeANISWjyT38GTwJxPTZODxiumYJGwDzg/f/DH+jbjzL
X-Google-Smtp-Source: ABdhPJw5WfIazGoqhzaaecAeVR1fumrJ+YmmBMlcVNZOAUlKcbEdvdhip2OVBASQW55i8gNEY8ybmR3asQrwG6EZfiA=
X-Received: by 2002:a25:ab6c:: with SMTP id u99mr6500682ybi.188.1639769498073;
 Fri, 17 Dec 2021 11:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20211216210958.62129-1-hj.tedd.an@gmail.com> <CABBYNZKYvcEe5RHA337U_MrJyr3xZ2BEENQ38ZG2twwenrznXg@mail.gmail.com>
 <a9b72835896aa4c8215b1a37af174d96edd0bf13.camel@intel.com>
In-Reply-To: <a9b72835896aa4c8215b1a37af174d96edd0bf13.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Dec 2021 11:31:27 -0800
Message-ID: <CABBYNZKAnpMu4DkOYxZsFRVkuAYGLTnViFYktYYc+C1D4gPUZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Dec 16, 2021 at 6:47 PM An, Tedd <tedd.an@intel.com> wrote:
>
> Hi Luiz,
>
> On Thu, 2021-12-16 at 16:47 -0800, Luiz Augusto von Dentz wrote:
> > Hi Tedd,
> >
> > On Thu, Dec 16, 2021 at 4:04 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
> > >
> > > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > >
> > > This patch fixes the broken LED quirk for Intel legacy ROM devices.
> > > To fix the LED issue that doesn't turn off immediately, the host sends
> > > the SW RFKILL command while shutting down the interface and it puts the
> > > devices in an asserted state.
> > >
> > > Once the device is in SW RFKILL state, it can only accept HCI_Reset to
> > > exit from the SW RFKILL state. This patch checks the quirk and sends the
> > > HCI_Reset before sending the HCI_Intel_Read_Version command.
> > >
> > > The affected legacy ROM devices are
> > >  - 8087:0a2a
> > >  - 8087:0aa7
> > >
> > > fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")
> > >
> > > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > > ---
> > >  drivers/bluetooth/btintel.c | 13 ++++++-------
> > >  drivers/bluetooth/btusb.c   | 10 ++++++++--
> > >  2 files changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > > index e1f96df847b8..75f8d7aceb35 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> > >          * As a workaround, send HCI Reset command first which will reset the
> > >          * number of completed commands and allow normal command processing
> > >          * from now on.
> > > +        *
> > > +        * For INTEL_BROKEN_LED, these devices have an issue with LED which
> > > +        * doesn't go off immediately during shutdown. Set the flag here to send
> > > +        * the LED OFF command during shutdown.
> > >          */
> > > -       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
> > > +       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
> > > +                               btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
> > >                 skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
> > >                                      HCI_INIT_TIMEOUT);
> > >                 if (IS_ERR(skb)) {
> > > @@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> > >                                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> > >                                         &hdev->quirks);
> > >
> > > -                       /* These devices have an issue with LED which doesn't
> > > -                        * go off immediately during shutdown. Set the flag
> > > -                        * here to send the LED OFF command during shutdown.
> > > -                        */
> > > -                       btintel_set_flag(hdev, INTEL_BROKEN_LED);
> > > -
> > >                         err = btintel_legacy_rom_setup(hdev, &ver);
> > >                         break;
> > >                 case 0x0b:      /* SfP */
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index d1bd9ee0a6ab..c6a070d5284f 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
> > >  #define BTUSB_WIDEBAND_SPEECH  0x400000
> > >  #define BTUSB_VALID_LE_STATES   0x800000
> > >  #define BTUSB_QCA_WCN6855      0x1000000
> > > +#define BTUSB_INTEL_BROKEN_LED 0x2000000
> >
> > I wonder why we haven't been using BIT macro here and did we make a
> > mistake and leave one bit behind? Or something else was at this bit
> > position?
>
> There used to be a flag BTUSB_INTEL_NEWGEN, and it was removed while
> refactoring the btintel, and the NCMD was added before removing the
> NEWGEN flag.

Ok that explains it then, luckily this is just used internally by the
driver so it shouldn't break anything if we reuse, but I'd still think
using BIT macro is clear here.

> >
> > >  #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
> > >
> > >  static const struct usb_device_id btusb_table[] = {
> > > @@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
> > >         { USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> > >         { USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
> > >                                                      BTUSB_INTEL_BROKEN_INITIAL_NCMD },
> > > -       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> > > +       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> > > +                                                    BTUSB_INTEL_BROKEN_LED },
> > >         { USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
> > > -       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
> > > +       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> > > +                                                    BTUSB_INTEL_BROKEN_LED },
> > >         { USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
> > >
> > >         /* Other Intel Bluetooth devices */
> > > @@ -3724,6 +3727,9 @@ static int btusb_probe(struct usb_interface *intf,
> > >
> > >                 if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
> > >                         btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
> > > +
> > > +               if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
> > > +                       btintel_set_flag(hdev, INTEL_BROKEN_LED);
> >
> > I wonder if wouldn't be simples to have a flag e.g. INTEL_NEED_RESET
> > instead of replicating the quirks as flags since in either case the
> > actual outcome is to send a reset.
>
> The result is same though, I think it is better to be more specific.
> I am fine with it also.

Fair enough.

> >
> > >         }
> > >
> > >         if (id->driver_info & BTUSB_MARVELL)
> > > --
> > > 2.25.1
> > >
> >
> >
>


-- 
Luiz Augusto von Dentz
