Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7CC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ED12175B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfBRKsP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:48:15 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56464 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKsP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 05:48:15 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6329BCF2C6;
        Mon, 18 Feb 2019 11:56:06 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: drivers/bluetooth/Kconfig BT_HCIUART_RTL depends on ACPI
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9d693bec-56c7-58a1-67b8-ba9edd63989d@davidjohnsummers.uk>
Date:   Mon, 18 Feb 2019 11:48:12 +0100
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <07109476-C017-4DC2-98A7-2EE5B53C4AB3@holtmann.org>
References: <9d693bec-56c7-58a1-67b8-ba9edd63989d@davidjohnsummers.uk>
To:     David Summers <beagleboard@davidjohnsummers.uk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

> On Arch Linux Arm, have a couple of people helping with the Tinker Board Patches - think we are close to something that may get passed.
> 
> Now testing it far more, and a snag, drivers/bluetooth/Kconfig contains:
> 
> config BT_HCIUART_RTL
>     bool "Realtek protocol support"
>     depends on BT_HCIUART
>     depends on BT_HCIUART_SERDEV
>     depends on GPIOLIB
>     depends on ACPI
>     select BT_HCIUART_3WIRE
>     select BT_RTL
> 
> But why does it depend on ACPI? I haven't found a way of setting that in 4.20, used to be in Power Management IIRC - but can't find now.
> 
> find . -name Kconfig -type f -exec grep "select ACPI" '{}' \;
> 
> Doesn't find anything to select ACPI …

initially we only supported Realtek chips that are described via ACPI. For DT based ones you need to extend this. The Broadcom ones uses this line:

depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)

Maybe this works here as well.

Regards

Marcel

