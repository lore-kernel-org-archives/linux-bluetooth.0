Return-Path: <SRS0=JgXz=ZG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F28C43215
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2E206CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 06:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQ2ttzVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKNGDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:03:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35624 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNGDy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Nov 2019 01:03:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id i19so4048616qki.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 22:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f41jt7W7mauWCTlBQ2STSz6cFbmZmSdjiJXlGbUNtqQ=;
        b=mQ2ttzVHJ5cC2dWhgnE0vYscSuXyBrapYQ4Y0MeqYFNj63S3jVlngut6iGj/J1ueez
         z4jEZ455eh7RDCGafKPhzaxPjWhZTzILVTz1NmQkOD1yKEKZQmHwQwdKnBhSQhjcng3X
         rdcHTB5Kq8kKXoGS/39zf15irkXCaqiDDL/Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f41jt7W7mauWCTlBQ2STSz6cFbmZmSdjiJXlGbUNtqQ=;
        b=cxM3QVNAd5CqzIdKZSoY16vn9vciGmoA1Y/NsQa8dr53wpKUcoTzzK5HS/wwwMdPF/
         ulVAnLITgiu46decNG1Ct/BIgauun3QuhntLswCwJIofBolXzkANWFEsFMcTAvD9KqdQ
         vcJ/vgOhMQG22+zRDojRXTHQHtTHg8j44kYDh0t/PVrC/0+naIbw46OVRtgMY7MaFhNU
         iZ4gM51O/jtLeMpAKXBhfdecDCxGe+MAXN3CPgQhNQgnOnZgGjZ0Zsev7Qcsn1B0+Ez8
         7f0Rt2Mn0HlIKn8OYLDhIv9Jnnv6EDXSPxGMt8LYwmj06F3NlwThLowcn8vUFBSlYVJG
         l2RA==
X-Gm-Message-State: APjAAAXUiucVJA1IKtmL51s2EOhvnJRZVdctTtcwtd1E8OOD10wkRmbp
        Napytg3qOvqS4POMb0Lfz83SKetJta20aj2olhGNaQ==
X-Google-Smtp-Source: APXvYqwjkQitSZ0nObB4xzy6iQsQMAbTE2g3LsNohNcXQ2FEHdwffIT/aQQPan3WSvcH3FrVMeGRPmLWiNeAjR7EL/c=
X-Received: by 2002:a05:620a:1032:: with SMTP id a18mr4574215qkk.305.1573711433159;
 Wed, 13 Nov 2019 22:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-4-abhishekpandit@chromium.org> <DCCD0A71-D696-4701-9BBB-ED6D8FECC7FB@holtmann.org>
 <CANFp7mX0tXmBdJOkBUbar6Niwv9D60Fo9CvAcUkEKZKLnt--hQ@mail.gmail.com> <102CFB68-22A0-4DF7-B5CE-F3146AA36746@holtmann.org>
In-Reply-To: <102CFB68-22A0-4DF7-B5CE-F3146AA36746@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 13 Nov 2019 22:03:41 -0800
Message-ID: <CANFp7mUxBLGfDd+mR7R1RTK70PRhbHjV8whDJOucpap_qmgN3A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] Bluetooth: hci_bcm: Support pcm params in dts
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 13, 2019 at 9:29 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> >>> BCM chips may require configuration of PCM to operate correctly and
> >>> there is a vendor specific HCI command to do this. Add support in the
> >>> hci_bcm driver to parse this from devicetree and configure the chip.
> >>>
> >>> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >>> ---
> >>>
> >>> Changes in v4: None
> >>> Changes in v3: None
> >>> Changes in v2: None
> >>>
> >>> drivers/bluetooth/hci_bcm.c | 32 ++++++++++++++++++++++++++++++++
> >>> 1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> >>> index 6134bff58748..4ee0b45be7e2 100644
> >>> --- a/drivers/bluetooth/hci_bcm.c
> >>> +++ b/drivers/bluetooth/hci_bcm.c
> >>> @@ -88,6 +88,8 @@ struct bcm_device_data {
> >>> *    used to disable flow control during runtime suspend and system sleep
> >>> * @is_suspended: whether flow control is currently disabled
> >>> * @disallow_set_baudrate: don't allow set_baudrate
> >>> + * @has_pcm_params: whether PCM parameters need to be configured
> >>> + * @pcm_params: PCM and routing parameters
> >>> */
> >>> struct bcm_device {
> >>>      /* Must be the first member, hci_serdev.c expects this. */
> >>> @@ -122,6 +124,9 @@ struct bcm_device {
> >>>      bool                    is_suspended;
> >>> #endif
> >>>      bool                    disallow_set_baudrate;
> >>> +
> >>> +     bool                            has_pcm_params;
> >>> +     struct bcm_set_pcm_int_params   pcm_params;
> >>> };
> >>>
> >>> /* generic bcm uart resources */
> >>> @@ -596,6 +601,16 @@ static int bcm_setup(struct hci_uart *hu)
> >>>                      host_set_baudrate(hu, speed);
> >>>      }
> >>>
> >>> +     /* PCM parameters if any*/
> >>> +     if (bcm->dev && bcm->dev->has_pcm_params) {
> >>> +             err = btbcm_set_pcm_int_params(hu->hdev, &bcm->dev->pcm_params);
> >>> +
> >>> +             if (err) {
> >>> +                     bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
> >>> +                                 err);
> >>> +             }
> >>> +     }
> >>> +
> >>> finalize:
> >>>      release_firmware(fw);
> >>>
> >>> @@ -1132,7 +1147,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
> >>>
> >>> static int bcm_of_probe(struct bcm_device *bdev)
> >>> {
> >>> +     int err;
> >>> +
> >>>      device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
> >>> +
> >>> +     err = device_property_read_u8(bdev->dev, "brcm,bt-sco-routing",
> >>> +                                   &bdev->pcm_params.routing);
> >>> +     if (!err)
> >>> +             bdev->has_pcm_params = true;
> >>
> >> I think in case of HCI as routing path, these should be using the default or zero values as defined by Broadcom.
> >
> > I'm not sure what these default values should be. Wouldn't it be
> > reasonable to expect the user/developer to set the various brcm
> > parameters in device tree?
> > If unset, it's just 0.
>
> if that works with the hardware I am fine with that. The other option is to actually first read the current values. And then only change the ones that are supplied by the DT.

I don't know of a read pcm params command (this would be nice to have).

I think it might be prudent to default the frame_mode and clock_mode
to master (0x1). I'll test how the hardware responds to 0x0 and update
the default to 0x1 if things fail badly.

>
> Regards
>
> Marcel
>
