Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC2C2D0C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF861206CB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="tsO1ZGF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLPNZM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:25:12 -0500
Received: from vps.xff.cz ([195.181.215.36]:45352 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfLPNZM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 08:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1576502709; bh=es+nOMcbHNUvRapBUN4dNUN1UmQSHOWrTb4CbncHywQ=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=tsO1ZGF1xfKCIUq16OlM2icXeTDgx8P0RR99yzocXToFCSskUe4dEZqEyANAQwbZh
         nzkxDr39xTguJz3bbHmXeowcERvh5XnXHD1zwPNH2XirEWE6tkTzeLpa6CRwNHK9OU
         dzQjLfqVJDbcHudGbMBRHzmlYsObxhMjB4WV0A8Q=
Date:   Mon, 16 Dec 2019 14:25:09 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
Message-ID: <20191216132509.ofqcdpwxsd7324ql@core.my.home>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On Sun, Oct 20, 2019 at 11:17:28PM +0200, Stefan Wahren wrote:
> Hi Marcel,
> hi Johan,
> 
> Am 06.10.19 um 17:28 schrieb Stefan Wahren:
> > The RPi 4 uses the hardware handshake lines for CYW43455, but the chip
> > doesn't react to HCI requests during DT probe. The reason is the inproper
> > handling of the RTS line during startup. According to the startup
> > signaling sequence in the CYW43455 datasheet, the hosts RTS line must
> > be driven after BT_REG_ON and BT_HOST_WAKE.
> >
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > ---
> >  drivers/bluetooth/hci_bcm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index 7646636..0f73f6a 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -445,9 +445,11 @@ static int bcm_open(struct hci_uart *hu)
> >
> >  out:
> >  	if (bcm->dev) {
> > +		hci_uart_set_flow_control(hu, true);
> >  		hu->init_speed = bcm->dev->init_speed;
> >  		hu->oper_speed = bcm->dev->oper_speed;
> >  		err = bcm_gpio_set_power(bcm->dev, true);
> > +		hci_uart_set_flow_control(hu, false);
> >  		if (err)
> >  			goto err_unset_hu;
> >  	}
> > --
> > 2.7.4
> 
> would be nice to get some feedback about this.

I started seeing failures on Orange Pi 3 in 5.5-rc:

[    3.839134] Bluetooth: hci0: command 0xfc18 tx timeout
[   11.999136] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
[   12.004613] Bluetooth: hci0: Failed to set baudrate
[   12.123187] Bluetooth: hci0: BCM: chip id 130
[   12.128398] Bluetooth: hci0: BCM: features 0x0f
[   12.154686] Bluetooth: hci0: BCM4345C5
[   12.157165] Bluetooth: hci0: BCM4345C5 (003.006.006) build 0000
[   15.343684] Bluetooth: hci0: BCM4345C5 (003.006.006) build 0038

Switch to higher baudrate works again after reverting this patch.

That board also uses RTS/CTS signalling.

I guess the patch needs re-thinking/maybe other chips may not need this?

I don't have access to datasheets.

regards,
	o.

> Regards
> Stefan
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
