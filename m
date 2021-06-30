Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDBC11F65
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2C661450
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhF3US2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:18:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38736 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhF3US2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 16:18:28 -0400
Received: from smtpclient.apple (tmo-122-159.customers.d1-online.com [80.187.122.159])
        by mail.holtmann.org (Postfix) with ESMTPSA id B12E4CED24;
        Wed, 30 Jun 2021 22:15:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3] Bluetooth: hci_h5: Disable the hci_suspend_notifier
 for btrtl devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210629195907.64769-1-hdegoede@redhat.com>
Date:   Wed, 30 Jun 2021 22:15:55 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4AD88FCC-099B-4412-A84D-8A9B00DD3CA0@holtmann.org>
References: <20210629195907.64769-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> The hci_suspend_notifier which was introduced last year, is causing
> problems for uart attached btrtl devices. These devices may loose their
> firmware and their baudrate setting over a suspend/resume.
> 
> Since we don't even know the baudrate after a suspend/resume recovering
> from this is tricky. The driver solves this by treating these devices
> the same as USB BT HCIs which drop of the bus during suspend.
> 
> Specifically the driver:
> 1. Simply unconditionally turns the device fully off during
>   system-suspend to save maximum power.
> 2. Calls device_reprobe() from a workqueue to fully re-init the device
>   from scratch on system-resume (unregistering the old HCI and
>   registering a new HCI).
> 
> This means that these devices do not benefit from the suspend / resume
> handling work done by the hci_suspend_notifier. At best this unnecessarily
> adds some time to the suspend/resume time.
> 
> But in practice this is actually causing problems:
> 
> 1. These btrtl devices seem to not like the HCI_OP_WRITE_SCAN_ENABLE(
> SCAN_DISABLED) request being send to them when entering the
> BT_SUSPEND_CONFIGURE_WAKE state. The same request send on
> BT_SUSPEND_DISCONNECT works fine, but the second one send (unnecessarily?)
> from the BT_SUSPEND_CONFIGURE_WAKE transition causes the device to hang:
> 
> [  573.497754] PM: suspend entry (s2idle)
> [  573.554615] Filesystems sync: 0.056 seconds
> [  575.837753] Bluetooth: hci0: Timed out waiting for suspend events
> [  575.837801] Bluetooth: hci0: Suspend timeout bit: 4
> [  575.837925] Bluetooth: hci0: Suspend notifier action (3) failed: -110
> 
> 2. The PM_POST_SUSPEND / BT_RUNNING transition races with the
> driver-unbinding done by the device_reprobe() work.
> If the hci_suspend_notifier wins the race it is talking to a dead
> device leading to the following errors being logged:
> 
> [  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
> [  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
> [  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110
> 
> In both cases things still work, but the suspend-notifier is causing
> these ugly errors getting logged and ut increase both the suspend- and
> the resume-time by 2 seconds.
> 
> This commit avoids these problems by disabling the hci_suspend_notifier.
> 
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Use hu->flags instead of hu->hdev_flags to store the
>  HCI_UART_NO_SUSPEND_NOTIFIER flag
> 
> Changes in v2:
> - Use the new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk, instead of directly
>  unregistering the notifier from hci_h5.c
> ---
> drivers/bluetooth/hci_h5.c     | 7 +++++++
> drivers/bluetooth/hci_serdev.c | 3 +++
> drivers/bluetooth/hci_uart.h   | 7 ++++---
> 3 files changed, 14 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

