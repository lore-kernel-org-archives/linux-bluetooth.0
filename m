Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD9C4727F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7480E221EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 09:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gd/H3Syo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgI1Jhb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 05:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgI1Jhb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 05:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601285849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTtZ1phuHtb72mm3U9LrSkAvfGeY6LYM9Ml1QgHswWg=;
        b=Gd/H3SyouSeWfHMU8z5UGLOKxql2Q+D6ZvdvXcHHmyLGtTjtXN8NLGhKUzp7vq7HIAZg1i
        Q9j00gCqS6+xtaBCfB9fE27fAd0BUfiR509HwMqo5UuzeyAzAungRuuaHzHpLkUszKn2lR
        hntxAC9eaQ23tl2cqmHO5usILcvRuqM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31F71AC1D;
        Mon, 28 Sep 2020 09:37:29 +0000 (UTC)
Message-ID: <652a910c864bcd70fa3eb9a114afba2165f5122c.camel@suse.com>
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Oliver Neukum <oneukum@suse.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Lu <alex_lu@realsil.com.cn>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Date:   Mon, 28 Sep 2020 11:37:20 +0200
In-Reply-To: <CANFp7mVJZTizHJDss5BJmdm5ydrfrVy4sBhXRX4vLBmK2sRGSA@mail.gmail.com>
References: <20200923175602.9523-1-kai.heng.feng@canonical.com>
         <CANFp7mV7fC9_EZHd7B0Cu-owgCVdA6CNd2bb7XwFf5+6b7FVpg@mail.gmail.com>
         <A6F728DB-A07B-4323-83A5-3DABA8FDC156@canonical.com>
         <CANFp7mVJZTizHJDss5BJmdm5ydrfrVy4sBhXRX4vLBmK2sRGSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am Donnerstag, den 24.09.2020, 20:33 -0700 schrieb Abhishek Pandit-
Subedi:

> Runtime suspend always requires remote wakeup to be set

No, not entirely. Btusb requires remote wakeup between open()
and close(). On a closed device it is not set to save more power.
 
>  and reset
> resume isn't used there.

reset_resume() is basically incompatible with remote wakeup.
Remote wakeup implies that you will ask the device to perform
some action after wakeup. A reset destroys that capability.

> During system suspend, when remote wakeup is not set, RTL8822CE loses
> the FW loaded by the driver and any state currently in the controller.

That is true after every suspend, whether runtime or system.
The device throws away its firmware when it does not need it.
You have control over this feature.
Hence the quirk enables remote
wakeup upon close().
That is the most important part of the original patch.

> This causes the kernel and the controller state to go out of sync.
> One of the issues we observed on the Realtek controller without the
> reset resume quirk was that paired or connected devices would just
> stop working after resume.

The logic on whether reset_resume() should be used is imperfect.

> > In general, laptops will cut off the USB power during S3.
> > When AC is plugged, some laptops cuts USB power off and some don't. This also applies to many desktops. Not to mention there can be BIOS options to control USB power under S3/S4/S5...
> > 
> > So we don't know beforehand.

Technically we tell the BIOS before suspend the system whether
a device should wake up the system during sleep and hope that
the BIOS is clever enough not to cut power to them.
Compliance is mixed.

> In your case, since you don't need to enforce the 'Remote Wakeup' bit,
> if you unset the BTUSB_WAKEUP_DISABLE for that VID:PID, you should get
> the desirable behavior (which is actually the default behavior; remote
> wake will always be asserted instead of only during Runtime Suspend).

Well, no. Only between open() and close()
Please always test the case of Bluetooth not being used. I know
it is not sexy, but surprisingly common.

	Regards
		Oliver


