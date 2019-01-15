Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98266C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5988D20866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547581742;
	bh=Vivl4+etHMq6ONGfeZB3fGogNeSGnltwyq4snpVBwX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p/5e99EvKedzOxGjAM8uAaEkg7WEcUgbD31V/MxoI2vqaGMSHhiD4I7ZgOAYH2+l1
	 uMzksRcpe6Yfw606q/G/+atX8uKV5D4aqcyZLUY79LgsFr6LXqd3tXXxMFQGweph5g
	 EQycFcmEbRYCYxDsSyMbgatlwY+12L6WhqJo8EY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfAOTtB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbfAOTtB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 14:49:01 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A0520866;
        Tue, 15 Jan 2019 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547581739;
        bh=Vivl4+etHMq6ONGfeZB3fGogNeSGnltwyq4snpVBwX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=puw5aOOtESR+voHmQRFXnyJOyBOowJzacBpyi/UvykuMMRuv0CbfYsZgYYFQssd08
         vN7CIFFgXEWYKOqEqVplxxxPwPy4jscGm7heNlyR7VGCEwTzRnpFgA2NoitIP3Yq3T
         OnBjMaZWkGKQfZLOEvI71zRXVroJ8Ef6RKGrhLE8=
Received: by mail-qt1-f176.google.com with SMTP id u47so4409452qtj.6;
        Tue, 15 Jan 2019 11:48:59 -0800 (PST)
X-Gm-Message-State: AJcUukdMMwXvqQRLt4nqEys7n+bKLQy2MzmBtUgTVTyZl1djB4WSQYSH
        /Nsy7baAboIcVvsbbNRhmVBt/Lc67AaJdQapNg==
X-Google-Smtp-Source: ALg8bN5NJZ+SJLma0ZqFaA4ZE8EsvZq04XsNQmDf6jI/ppxlnMIMvVtvyBS/GGwWISkqAeOBdoL+SEJNXoBelAq5AE8=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr4312788qvi.90.1547581738597;
 Tue, 15 Jan 2019 11:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk> <20190111163420.GA20311@bogus>
 <1308b7df-9f09-c46e-e740-131bd1c42fef@davidjohnsummers.uk>
In-Reply-To: <1308b7df-9f09-c46e-e740-131bd1c42fef@davidjohnsummers.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Jan 2019 13:48:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+vu+31_G2Vbe0nJsR4MTJAurjTYm3aEq_eWfg9p-BAMw@mail.gmail.com>
Message-ID: <CAL_Jsq+vu+31_G2Vbe0nJsR4MTJAurjTYm3aEq_eWfg9p-BAMw@mail.gmail.com>
Subject: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Jan 12, 2019 at 9:01 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
>
> Thanks Rob,
>
> I'll hopefully make those changes this weekend, and resubmit - just so
> next weekend can move onto the device tree.
>
> Oh yes, on the "-bluetooth" or "-bt"; as these devices have both and
> sdio input for wifi, and uart for bluetooth; I guess they will need to
> be listed twice in a device tree, both under uart and sdio. Now as both
> these parts of the device tree will want to specify the driver used, and
> the driver is different for bluetooth and for wifi - doesn't that mean
> we should specify compatible differently? Otherwise how will the kernel
> know which driver to load for wifi and which for bluetooth?
>
> So question is am I missing something here, and this could be simplified?

The compatibles don't really have to be different as the drivers will
only bind based on the bus interface. But keeping a '-bt' suffix is
fine.

>
> On the interrupts, GPIO control lines, power supplies, etc, on the ASUS
> code that I'm basing the patches on (for Tinker Board S) - these bits
> are freestanding in the device tree, and mainly go in with the wifi
> patch (and not bluetooth). I'll put some though into how this is best
> arranged when going mainline. I think if I'm honest, if I wait to get
> all these extras in the documentation, this will only get settled when I
> get the wifi into the device tree - as problem is more natural there.
> This though would delay the bluetooth patch probably a month. I'd prefer
> to get something out there - even if I have to return later to tidy the
> documentation.

At least for all the combo chips to date, the BT and WiFi halves are
pretty much independent. So we can get away with describing them
separately. If there's a shared supply or clock then we can list them
in both nodes and ref counting makes it all work fine. However, if you
had for example, a single firmware image for both BT and WiFi, then
we'd want to represent this as a single device (and driver with child
drivers). So you need to know if there's any issue like this because
that would affect how we do the BT binding.

Rob

>
> Regards, and thanks for the helpful comments.
>
> David.
>
>
> On 11/01/2019 16:34, Rob Herring wrote:
> > On Thu, Jan 03, 2019 at 04:35:37PM +0000, David Summers wrote:
> >> This adds the desrciption file that describes the hooks for the
> >> realtek bluetooth serial devices, as needed to refer to the interface
> >> in the device tree.
> > Please follow conventions for patch subjects. 'git log --oneline
> > --no-merges -- path/to/file' usually gives a good clue. In this case,
> > something like:
> >
> > dt-bindings: net: Add Realtek serial bluetooth binding
> >
> >> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> >> ---
> >>   .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >> new file mode 100644
> >> index 000000000000..0aabca1fc002
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> >> @@ -0,0 +1,28 @@
> >> +Realtek bluetooth devices connected via a UART
> >> +
> >> +- compatible: should be "realtek,<name>-bluetooth"
> >> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
> >> +       "realtek,rtl8723as-bluetooth"
> >> +       "realtek,rtl8723bs-bluetooth"
> >> +       "realtek,rtl8723ds-bluetooth"
> >> +       "realtek,rtl8761atv"
> >> +       "realtek,rtl8821as-bluetooth"
> >> +       "realtek,rtl8821cs-bluetooth"
> >> +       "realtek,rtl8822bs-bluetooth"
> > Arguably, '-bluetooth' is not necessary as nothing else is attached to
> > the serial port. At least shorten it to '-bt'.
> >
> >> +- These device are bluetooth devices, that connect via a uart
> > s/device/devices/
> >
> >> +- all devices (except for rtl8761atv) are also wifi devices, this is connected
> >> +  seperatly via sdio - and is not covered by this compatible node
> > Really, this should be up above the property list in a description of
> > the device(s).
> >
> >> +- ideally these will be referenced in a device tree serial node via serdev
> > Not ideally, but it is only valid for this to be a child of a UART.
> >
> > serdev is a kernel thing, and shouldn't be part of the binding doc.
> >
> >> + http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
> > Useful, but again, not part of this binding.
> >
> > There's no interrupts, GPIO control lines, power supplies, etc. for
> > these chips? The binding should be complete even if your platform
> > doesn't need these.
> >
> >> +
> >> +Example:
> >> +
> >> +&uart0 {
> >> +    status = "okay";
> > Don't show status in examples.
> >
> >> +            pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> >> +            bluetooth {
> >> +                      compatible = "realtek,rtl8723bs-bluetooth";
> >> +            };
> > Mixed tabs and spaces. Use tabs.
> >
> >> +};
> >> +
> >> +this ensures that the bluetooth device is tied to the correct uart
> >> --
> >> beagleboard@davidjohnsummers.uk
> >>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
