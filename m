Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23220C282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5735214DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVhVP1in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfA1QDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:03:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39455 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfA1QDU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so15052364otl.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OxrrHDZfqicaZ1UHUmMUdX87fQAYtnMsgkYl1Jm75O4=;
        b=DVhVP1in0eGSktAeVBi44EPmaZ/H4ruRD+TfrME4gu4YZ1h3kM3xuH5dTcP3ukp0tj
         u6YGO5iKuc3grIVskZB1ZHemaEdufJ5XYwNAy3Hj7+RWd/EuOWBKFRp+CcRnVry4z5+3
         tyiwbsL8dYgbbxU37BZgCf+lz7btdOYeoH/T/DdbTQg1gcS8o9SubypKyO17rNPh1oLX
         2GM99PSJfmsYWYZq7ox8ilLQpAT/MxrVr01vsEg/e5pVPwa+OmG/f5FzDEB+5R4Kdcwa
         rFwg5F4zBTNdDUgFe90tkZAl814cDJohVzg3YKRVMvctSPqr6kbHVp7ICLf25moXfXzk
         IELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OxrrHDZfqicaZ1UHUmMUdX87fQAYtnMsgkYl1Jm75O4=;
        b=AtjclCKFkdRSbYwbONZLaVLwML7Ifz1GYEL6o8FSAq+vtX4BZz8MyoZoWj9KnyNygR
         r4KtpupZmD34sR/UeCTnA5kO9sQdHuyXDVjODl7kLNOEQwuv0Qp0yiJQW1byg6meoU6n
         YY1dF53Z73bst+77n+r9HSLA1SuSVZiSZNbp2zUAtywQWzEwBiZVDUrtPwP9BbclfJYe
         GWPeCUfJ9qVpJGSdrLrmDL223DAhZBjw4679xf42Fu7Sok/qFU6bP3g5fk8kpVqFe0gS
         LMdPea48sbrnsul6gTpoSsJ2NdM6UkpHUdpZRzX+/LJX8IPcY5zYHjA7jJBhG1bKFhY3
         RySA==
X-Gm-Message-State: AJcUukdmuXaYUW6CDvzT884PqP5gysD8OpSIIrHLCh+NktpXSOqbP6T5
        C9wicUfGCYJHjNFIT/0Vikobbv2mGgT4j4PdCMMgrk6a
X-Google-Smtp-Source: ALg8bN4kuYqpriFM1RwVvRITKZMhXwW2tx7rC/M8reXbRvWgzSob9+sOHA/1gC4f1OTlb04W85AvxDs3tav8eVA6aqg=
X-Received: by 2002:a9d:20c4:: with SMTP id x62mr16116181ota.202.1548691399343;
 Mon, 28 Jan 2019 08:03:19 -0800 (PST)
MIME-Version: 1.0
References: <1548665625-23742-1-git-send-email-raghuram.hegde@intel.com>
 <91F174CE-3CBE-4D3B-B0C9-E350C01F3DDF@holtmann.org> <CAMH2TCqtZM++VSboKbFB9htTCuP=8Z+8PmGDymdkSgrEXKr2Og@mail.gmail.com>
 <110D522B-D320-4839-A519-C8379C251314@holtmann.org>
In-Reply-To: <110D522B-D320-4839-A519-C8379C251314@holtmann.org>
From:   chethan tn <chethantn@gmail.com>
Date:   Mon, 28 Jan 2019 21:33:07 +0530
Message-ID: <CAMH2TCoTuVJ6F3Qrh5pwmpaQQ9jr_0cB192HRP8yJ8=oW3x1VA@mail.gmail.com>
Subject: Re: [PATCH] btusb: Add shutdown routine for BTUSB_INTEL_NEW devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Raghuram Hegde <raghuram.hegde@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Mon, Jan 28, 2019 at 9:30 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Chethan,
>
> >>> btusb_shutdown_intel routine shall reset the controller
> >>> and stop all BT operation.
> >>> Advantages:
> >>>      1. Power save on the platform
> >>>      2. Host and controller will be in Sync.
> >>>
> >>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> >>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >>> ---
> >>> drivers/bluetooth/btusb.c | 1 +
> >>> 1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index 5de0c2e59b97..66483ca3d870 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -3139,6 +3139,7 @@ static int btusb_probe(struct usb_interface *in=
tf,
> >>>              hdev->manufacturer =3D 2;
> >>>              hdev->send =3D btusb_send_frame_intel;
> >>>              hdev->setup =3D btusb_setup_intel_new;
> >>> +             hdev->shutdown =3D btusb_shutdown_intel;
> >>>              hdev->hw_error =3D btintel_hw_error;
> >>>              hdev->set_diag =3D btintel_set_diag;
> >>>              hdev->set_bdaddr =3D btintel_set_bdaddr;
> >>
> >> I assumed that this was only needed for the older ROM versions of the =
Intel controllers and not the newer RAM versions. I have been told they don=
=E2=80=99t inherit the LED issue that we tried to fix with this. Please rea=
d the comments in btusb_shutdown_intel and amend comments if needed and pro=
vide a detailed commit message.
> > Yes you're absolutely right about the LED issue on the older ROM produc=
ts.
> > But in the recent day we have observed that in case BT
> > operation(Inquiry/LE Scan) were triggered through the stack and
> > further BT was turned off through "hciconfig hci0 down". In this case
> > controller would active doing BT operation and consume power and also
> > might cause race condition on the next BT on as the controller might
> > try to push the events that were queued up before processing the reset
> > command. So to make sure when BT is turned off either through stack or
> > through command line thought it would be better approach to reset the
> > controller(This is applicable for ROM or RAM products).
>
> what about creating a btusb_shutdown_intel_new() that just sends the HCI =
Reset command. That should be enough to ensure that anything in the radio s=
cheduler gets cancelled and cleaned up.
Sure,  will make the changes accordingly and send the new patch.
>
> Regards
>
> Marcel
>
Thanks and Regards
Chethan
