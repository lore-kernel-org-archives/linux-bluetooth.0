Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50901C4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 03:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE1A221EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 03:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReBzNMLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIYDeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 23:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgIYDeN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 23:34:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE4C0613D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 20:34:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w25so573289vsk.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 20:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJ7yarg421rbw+0Qq+LWPlS5VfbAKELCgdAWUBAvzsc=;
        b=ReBzNMLAJQ7JvxuqCGbfVlbHL7w3Y8Va3lZUvb3PIAhRaT16VlY1qjYuzJC621Dhni
         lYyGP8nsOwlvz6y5nInidjsFMXyPsh4dpywzyTw51Jqp7uMPRmNYCHnvXKuX7I/6pcg9
         KrAsTZFab/nY3lMFNB62DocRBa8s825D73y2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJ7yarg421rbw+0Qq+LWPlS5VfbAKELCgdAWUBAvzsc=;
        b=i2L8RO2bVF1pbA62Vgf9UEtWdPQbj7y+uNSwBP0f5R6yv1N+hksW98l0j8h/5t5b0a
         /8d9c1nWgr/2Zz7FRNNDIzNxWke+fpGXNeWzgqHiZZ08fON5IE5HNS+zsDyGx+aHphHm
         hKikAA70SayNYr8pFBnVfDEcfPR8cGNHsxPDyWdAc/mZRdZqEJHTIbe1Lc/IQcVkGXdr
         Zyfa0pK5nXftfzo0yn/K3NR1f3lmMio1b8aEw2bNqRdCm+EzIlTLijZ85ZSfKNESPPOf
         npvO72Z8Ab9cUHH1cPz3BVlnxyf95eUub3xON6Yw1/VOz9xhouC0Y0ltrIdFFlrIAwPA
         Estw==
X-Gm-Message-State: AOAM532T3g4Fk5M3n1LKBPhAxAnpUBA7++4HLLS44S1vId2sFHrUmT9z
        ObysWGSEiR9DDWXYRGKOFFZMaeKv7yVNFTgx4KywIQ==
X-Google-Smtp-Source: ABdhPJwDwOC8klX1Sl/GoSS1EGjXgmmQ8HV8ThibOPCKamscmh7vhkkOT+rtPYo5MXHSD9Pr9cKndysNnWIVEEqKPPc=
X-Received: by 2002:a67:8b45:: with SMTP id n66mr1824347vsd.45.1601004852342;
 Thu, 24 Sep 2020 20:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200923175602.9523-1-kai.heng.feng@canonical.com>
 <CANFp7mV7fC9_EZHd7B0Cu-owgCVdA6CNd2bb7XwFf5+6b7FVpg@mail.gmail.com> <A6F728DB-A07B-4323-83A5-3DABA8FDC156@canonical.com>
In-Reply-To: <A6F728DB-A07B-4323-83A5-3DABA8FDC156@canonical.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 24 Sep 2020 20:33:59 -0700
Message-ID: <CANFp7mVJZTizHJDss5BJmdm5ydrfrVy4sBhXRX4vLBmK2sRGSA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system resume
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Lu <alex_lu@realsil.com.cn>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Alex Lu (who contributed the original change)

Hi Kai-Heng,


On Thu, Sep 24, 2020 at 12:10 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> [+Cc linux-usb]
>
> Hi Abhishek,
>
> > On Sep 24, 2020, at 04:41, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
> >
> > Hi Kai-Heng,
> >
> > Which Realtek controller is this on?'
>
> The issue happens on 8821CE.
>
> >
> > Specifically for RTL8822CE, we tested without reset_resume being set
> > and that was causing the controller being reset without bluez ever
> > learning about it (resulting in devices being unusable without
> > toggling the BT power).
>
> The reset is done by the kernel, so how does that affect bluez?
>
> From what you described, it sounds more like runtime resume since bluez is already running.
> If we need reset resume for runtime resume, maybe it's another bug which needs to be addressed?

From btusb.c:  https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/bluetooth/btusb.c#n4189
/* Realtek devices lose their updated firmware over global
* suspend that means host doesn't send SET_FEATURE
* (DEVICE_REMOTE_WAKEUP)
*/

Runtime suspend always requires remote wakeup to be set and reset
resume isn't used there.

During system suspend, when remote wakeup is not set, RTL8822CE loses
the FW loaded by the driver and any state currently in the controller.
This causes the kernel and the controller state to go out of sync.
One of the issues we observed on the Realtek controller without the
reset resume quirk was that paired or connected devices would just
stop working after resume.

>
> > If the firmware doesn't cut off power during suspend, maybe you
> > shouldn't set the BTUSB_WAKEUP_DISABLE flag for that controller.
>
> We don't know beforehand if the platform firmware (BIOS for my case) will cut power off or not.
>
> In general, laptops will cut off the USB power during S3.
> When AC is plugged, some laptops cuts USB power off and some don't. This also applies to many desktops. Not to mention there can be BIOS options to control USB power under S3/S4/S5...
>
> So we don't know beforehand.
>

I think the confusion here stems from what is actually being turned
off between our two boards and what we're referring to as firmware :)

In your case, the Realtek controller retains firmware unless the
platform cuts of power to USB (which it does during S3).
In my case, the Realtek controller loses firmware when Remote Wakeup
isn't set, even if the platform doesn't cut power to USB.

In your case, since you don't need to enforce the 'Remote Wakeup' bit,
if you unset the BTUSB_WAKEUP_DISABLE for that VID:PID, you should get
the desirable behavior (which is actually the default behavior; remote
wake will always be asserted instead of only during Runtime Suspend).

@Alex -- What is the common behavior for Realtek controllers? Should
we set BTUSB_WAKEUP_DISABLE only on RTL8822CE or should we unset it
only on RTL8821CE?

> >
> > I would prefer this doesn't get accepted in its current state.
>
> Of course.
> I think we need to find the root cause for your case before applying this one.
>
> Kai-Heng
>
> >
> > Abhishek
> >
> > On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Realtek bluetooth controller may fail to work after system sleep:
> >> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
> >> [ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)
> >>
> >> If platform firmware doesn't cut power off during suspend, the firmware
> >> is considered retained in controller but the driver is still asking USB
> >> core to perform a reset-resume. This can make bluetooth controller
> >> unusable.
> >>
> >> So avoid unnecessary reset to resolve the issue.
> >>
> >> For devices that really lose power during suspend, USB core will detect
> >> and handle reset-resume correctly.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/bluetooth/btusb.c | 8 +++-----
> >> 1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >> index 8d2608ddfd08..de86ef4388f9 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
> >>                enable_irq(data->oob_wake_irq);
> >>        }
> >>
> >> -       /* For global suspend, Realtek devices lose the loaded fw
> >> -        * in them. But for autosuspend, firmware should remain.
> >> -        * Actually, it depends on whether the usb host sends
> >> +       /* For global suspend, Realtek devices lose the loaded fw in them if
> >> +        * platform firmware cut power off. But for autosuspend, firmware
> >> +        * should remain.  Actually, it depends on whether the usb host sends
> >>         * set feature (enable wakeup) or not.
> >>         */
> >>        if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
> >>                if (PMSG_IS_AUTO(message) &&
> >>                    device_can_wakeup(&data->udev->dev))
> >>                        data->udev->do_remote_wakeup = 1;
> >> -               else if (!PMSG_IS_AUTO(message))
> >> -                       data->udev->reset_resume = 1;
> >>        }
> >>
> >>        return 0;
> >> --
> >> 2.17.1
> >>
>
