Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F7B64ECC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBINid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:38:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhBINhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:37:55 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l9TCZ-00050T-Hb; Tue, 09 Feb 2021 13:37:12 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 0/3] Add reset hci through mgmt experimental feature
Date:   Tue,  9 Feb 2021 21:36:25 +0800
Message-Id: <20210209133629.12784-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We have an annoying issue with Intel Bluetooth adapter, that is after
we update a firmware in the filessystem, and reboot the machine, the
driver will not load the new firmware since the adapter is already in
the operational mode instead of bootloader mode. we need to poweroff
the machine and cold boot it, and even on some desktops, we need to
wait for 10+ seconds between poweroff and the cold boot.

I wrote a patch for this issue last year, Marcel suggested that "we
should do it in a more generic way that resets the controller and puts
it into boot loader support if support. We can use the experimental
mgmt setting for this".

Here I wrote a new patch set according to Marcel's suggestion, a
generic reset hci method for all usb bluetooth adapters, it will reset
the adapter on the usb bus (similar to unbind the device and rebind
the device), and will call disconnect() and probe() in the btusb.c;
for Intel adapters, there is a specific method to reset the adapter
and put it into the bootloader mode.

This is the log I run reset_hci on machines with Qualcomm and CSR
adapters (generic reset hci method):
$ sudo ./btmgmt -i 0 exp-reset-hci
Reset hci feature successfully set
$ dmesg
[  110.116868] Bluetooth: hci0: urb 00000000e81d049e failed to resubmit (2)
[  110.232865] usb 3-6: reset full-speed USB device number 3 using xhci_hcd
[  110.358814] usb 3-6: device firmware changed
[  110.358949] usb 3-6: USB disconnect, device number 3
[  110.476527] usb 3-6: new full-speed USB device number 4 using xhci_hcd
[  110.603890] usb 3-6: New USB device found, idVendor=0cf3, idProduct=e005, bcdDevice= 0.01
[  110.603907] usb 3-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  110.662539] usb 3-6: USB disconnect, device number 4
[  110.913411] usb 3-6: new full-speed USB device number 5 using xhci_hcd
[...]
[  116.186419] usb 3-6: New USB device found, idVendor=0cf3, idProduct=e005, bcdDevice= 0.02
[  116.186434] usb 3-6: New USB device strings: Mfr=0, Product=0, SerialNumber=0



This is the log I run reset_hci on the machien with Intel adaper, this
adapter has specific method to reset to bootloader mode:
$ sudo ./btmgmt -i 0 exp-reset-hci
Reset hci feature successfully set
$ dmesg
[  100.843848] usb 3-10: USB disconnect, device number 4
[  100.844639] Bluetooth: hci0: FW download error recovery failed (-19)
[  101.252944] usb 3-10: new full-speed USB device number 5 using xhci_hcd
[  101.380862] usb 3-10: New USB device found, idVendor=8087, idProduct=0026, bcdDevice= 0.02
[  101.380872] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  101.384448] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[  101.385367] Bluetooth: hci0: Device revision is 2
[  101.385374] Bluetooth: hci0: Secure boot is enabled
[  101.385377] Bluetooth: hci0: OTP lock is enabled
[  101.385380] Bluetooth: hci0: API lock is enabled
[  101.385383] Bluetooth: hci0: Debug lock is disabled
[  101.385385] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  101.385849] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[  103.206577] Bluetooth: hci0: Waiting for firmware download to complete
[  103.207382] Bluetooth: hci0: Firmware loaded in 1780489 usecs
[  103.207409] Bluetooth: hci0: Waiting for device to boot
[  103.222478] Bluetooth: hci0: Device booted in 14734 usecs
[  103.222595] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
[  103.224414] Bluetooth: hci0: Applying Intel DDC parameters completed
[  103.227429] Bluetooth: hci0: Firmware revision 0.0 build 121 week 36 2020


Hui Wang (3):
  Bluetooth: btusb: Add reset_hci handler
  Bluetooth: make experimental features expand easier
  Bluetooth: reset_hci experimental feature

 drivers/bluetooth/btusb.c        |  60 +++++
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/mgmt.c             | 428 +++++++++++++++++++------------
 3 files changed, 327 insertions(+), 162 deletions(-)

-- 
2.25.1

