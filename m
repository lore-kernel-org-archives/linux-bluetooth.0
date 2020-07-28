Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEAC433E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CC20792
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG1HKX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:10:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45014 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG1HKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:10:22 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id AD970CECCD;
        Tue, 28 Jul 2020 09:20:22 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0bba3f22-a232-3c07-1b05-73e6d38dab8a@gmail.com>
Date:   Tue, 28 Jul 2020 09:10:20 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BB91A6AF-35AD-4BFF-BD1A-49292C064A43@holtmann.org>
References: <0bba3f22-a232-3c07-1b05-73e6d38dab8a@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ismael,

> For some reason they tend to squat on the very first CSR/
> Cambridge Silicon Radio VID/PID instead of paying fees.
> 
> This is an extremely common problem; the issue goes as back as 2013
> and these devices are only getting more popular, even rebranded by
> reputable vendors and sold by retailers everywhere.
> 
> So, at this point in time there are hundreds of modern dongles reusing
> the ID of what originally was an early Bluetooth 1.1 controller.
> 
> Linux is the only place where they don't work due to spotty checks
> in our detection code. It only covered a minimum subset.
> 
> So what's the big idea? Take advantage of the fact that all CSR
> chips report the same internal version as both the LMP sub-version and
> HCI revision number. It always matches, couple that with the manufacturer
> code, that rarely lies, and we now have a good idea of who is who.
> 
> Additionally, by compiling a list of user-reported HCI/lsusb dumps, and
> searching around for legit CSR dongles in similar product ranges we can
> find what CSR BlueCore firmware supported which Bluetooth versions.
> 
> That way we can narrow down ranges of fakes for each of them.
> 
> e.g. Real CSR dongles with LMP subversion 0x73 are old enough that
>     support BT 1.1 only; so it's a dead giveaway when some
>     third-party BT 4.0 dongle reuses it.
> 
> So, to sum things up; there are multiple classes of fake controllers
> reusing the same 0A12:0001 VID/PID. This has been broken for a while.
> 
> Known 'fake' bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
>  IC markings on 0x7558: FR3191AHAL 749H15143 (???)
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=60824
> 
> Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)
> Reported-by: Michał Wiśniewski <brylozketrzyn@gmail.com>
> Tested-by: Mike Johnson <yuyuyak@gmail.com>
> Tested-by: Ricardo Rodrigues <ekatonb@gmail.com>
> Tested-by: M.Hanny Sabbagh <mhsabbagh@outlook.com>
> Tested-by: Oussama BEN BRAHIM <b.brahim.oussama@gmail.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> 
> Changes in v4:
> * Chain the is_fake conditions with else ifs.
> * Properly use le16_to_cpu() when needed.
> 
> Changes in v3:
> * Find an even better-er way of detecting which type is which; use the
>  best parts of v1 and v2 and combine them with previous feedback.
> * Additionally, detect fakes by comparing against real BlueCore
>  firmware numbers and their supported protocol versions.
> * Introduce HCI_QUIRK_BROKEN_ERR_DATA_REPORTING and use it on all
>  fake chips. It doesn't seem to cause any drawback, and if we
>  make it too specific a lot of these chips won't work at all,
>  so it's probably better than nothing. Other user reported
>  being able to finally pair with their stereo A2DP speaker
>  with this fix.
> * Limit the use of btusb_setup_csr() only to cover 0A12:0001.
> * Use bt_dev_warn for the fake detection notice.
> * Remove all other noisy bt_dev_info() calls.
> 
> Changes in v2:
> * Find a better way of detecting which type is which; scrap the wonky
>> =Bluetooth 1.2 protocol check and instead do what's described above.
> * Move all the quirk logic to btusb_setup_csr(), simplify it a bit.
> * Use a switch statement and list all the known broken bcdDevice
>  instead of trying to penalize the real CSR devices.
> * Add two bt_dev_info() prints because this may be important in the
>  future, given the amount of variables we are playing with here.
> * Try to keep my comments within a 80-column limit.
> 
> Now I'm able to pair with Android devices, A2DP headphones,
> DS4 controllers and more; whereas previously set up failed
> and userland software couldn't even scan with it.
> 
> This patch probably uncovers other quirks in some of these
> previously *unusable* dongles, so it's probably a good start
> point so that other fixes can be implemented on top.
> 
> Looking forward to fine-tune these checks in the future.
> Let me know what you think.
> 
> drivers/bluetooth/btusb.c         | 74 ++++++++++++++++++++++++++-----
> include/net/bluetooth/bluetooth.h |  2 +
> include/net/bluetooth/hci.h       | 11 +++++
> net/bluetooth/hci_core.c          |  6 ++-
> 4 files changed, 81 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

