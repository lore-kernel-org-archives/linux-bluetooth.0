Return-Path: <SRS0=Gi1c=MX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C0C32788
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A7F20835
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 10:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJKRjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:39:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39024 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKRjN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Oct 2018 13:39:13 -0400
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gAXxK-0003Xw-So; Thu, 11 Oct 2018 12:12:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] This patch adds wifi to asus tinker board S
Date:   Thu, 11 Oct 2018 12:12:34 +0200
Message-ID: <2811253.FAip1BQNUo@phil>
In-Reply-To: <efb16675-0382-64b1-ceb5-acee3f95628d@davidjohnsummers.uk>
References: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk> <5682345.Yzn33l6ONg@phil> <efb16675-0382-64b1-ceb5-acee3f95628d@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am Donnerstag, 11. Oktober 2018, 12:09:51 CEST schrieb David Summers:
> On 08/10/2018 10:30, Heiko Stuebner wrote:
> > Hi David,
> >
> > Am Samstag, 22. September 2018, 19:02:36 CEST schrieb David Summers:
> >> Now as fair as I understand. the asus tinker board contains a wifi
> >> So should this patch be added to the tinker board dtsi ?
> >>
> >> It also far move complex - it adds far more things, so consider
> >>
> >> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> >> ---
> >>   arch/arm/boot/dts/rk3288-tinker-s.dts | 93 +++++++++++++++++++++++++++
> >>   1 file changed, 93 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
> >> index bc691e3f9c07..3d91924fd8db 100644
> >> --- a/arch/arm/boot/dts/rk3288-tinker-s.dts
> >> +++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
> >> @@ -10,6 +10,95 @@
> >>   / {
> >>   	model = "Rockchip RK3288 Asus Tinker Board S";
> >>   	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
> >> +
> >> +	wireless-bluetooth {
> >> +		compatible = "bluetooth-platdata";
> >> +		uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> >> +		pinctrl-names = "default","rts_gpio";
> >> +		pinctrl-0 = <&uart0_rts>;
> >> +		pinctrl-1 = <&uart0_gpios>;
> >> +		BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> >> +		BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> >> +		BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> >> +		status = "okay";
> >> +	};
> > the basic problem here is, that all these nodes stem from the so called
> > soc-vendor-tree. Devicetree bindings normally go through a review process
> > while soc vendors often invent their own shortcut that is not and will
> > not be supported by the mainline kernel.
> >
> > Bluetooth-platdata and wlan-platdata are examples of that.
> >
> > Additionally, the kernel now has the somewhat new "serdev" to manage the
> > needed connection between bluetooth and uart. See
> > http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
> > for an introduction.
> 
> Sigh - this just got difficult:
> 
> https://github.com/torvalds/linux/blob/master/drivers/bluetooth/btrtl.c
> 
> Which is the bluetooth driver for Realtek RTL8723BS neither contains the 
> device tree tabs ("static const struct of_device_id") so it can't be 
> referred to in the device tree, nor is it linked in with serdev, so it 
> probably can't go as sub child of uart0.
> 
> I'll look at those changes first ...

or alternatively, take small steps and at first "simply" add the core sdio
device that already does the wifi and then later add serdev stuff.
I'm also only of limited help here, as while I know that it exists now,
so far I haven't had to much contact with it.


Heiko


