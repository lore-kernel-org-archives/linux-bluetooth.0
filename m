Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 20:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbiAFU5Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:57:24 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44377 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFU5X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 15:57:23 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7DFCDCECDD;
        Thu,  6 Jan 2022 21:57:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20f68eb75538796fb0e69b45543e151b3fd04bae.camel@intel.com>
Date:   Thu, 6 Jan 2022 21:57:21 +0100
Cc:     "hj.tedd.an@gmail.com" <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <56CB4500-6F81-47B4-9F80-4CB1D0B420CE@holtmann.org>
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
 <B5187291-3173-4BFB-8465-25AB75BA328E@holtmann.org>
 <39a9b9c68cdb9fbf32f3c6023c0272b53d37d668.camel@intel.com>
 <768826DA-51CF-4EA2-B582-89BFE843EBAE@holtmann.org>
 <f1ffad7eebc385d43f4f48d138021860f8e582cd.camel@intel.com>
 <F93FE723-881E-45D6-8A43-379B0ABAC363@holtmann.org>
 <5b0ddedd9c6c119d4c3c4b65adaabe5d86bd166f.camel@intel.com>
 <6EBC0BA5-E39D-4C9F-849D-C7972BDD9582@holtmann.org>
 <20f68eb75538796fb0e69b45543e151b3fd04bae.camel@intel.com>
To:     "An, Tedd" <tedd.an@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

>> but we succeed with HCI_Intel_Read_Version on a cold boot. So that means it is just that we have to make this one flag persistent. So it is valid even when no HCI_Intel_Read_Version is read. Or just
>> make it a bool variable in the btintel internal struct.
>> 
> 
> Yes, there is no problem with cold boot. The problem is warm boot. Here are the log after making the changes with some debug messages.
> 
> [COLD BOOT]
> 
> Dec 24 16:16:27 han1-XPS-13-9350 kernel: microcode: microcode updated early to revision 0xea, date = 2021-01-25
> Dec 24 16:16:27 han1-XPS-13-9350 kernel: Linux version 5.16.0-rc1+ (han1@han1-XPS-13-9350) (gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #1 SMP PREEMPT Thu Dec 23
> 20:52:12 PST 2021
> 
> Dec 24 16:16:27 han1-XPS-13-9350 kernel: usb 1-3: new full-speed USB device number 2 using xhci_hcd
> Dec 24 16:16:27 han1-XPS-13-9350 kernel: usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a, bcdDevice= 0.01
> Dec 24 16:16:27 han1-XPS-13-9350 kernel: usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> 
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: Core ver 2.22
> 
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>> btusb_probe: intf 00000000074889f5 id 00000000c09ad578
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Allocate hci_dev=00000000a477ec45
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Set hci_set_drvdata(hdev=00000000a477ec45, data=0000000077ec88bc)
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: usbcore: registered new interface driver btusb
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>> btintel_setup_combined(hdev=00000000a477ec45)
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Test flag(hdev=00000000a477ec45, INTEL_SHUTDOWN_EXECUTED)
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: >>>>>      INTEL_SHUTDOWN_EXECUTED is NOT SET
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17 2014
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: hci0: unexpected event 0xff length: 2 > 0
> Dec 24 16:16:28 han1-XPS-13-9350 kernel: Bluetooth: hci0: Intel BT fw patch 0x32 completed & activated
> 
> [HCI DOWN]
> 
> Dec 24 16:17:19 han1-XPS-13-9350 kernel: Bluetooth: >>>>> btintel_shutdown_combined(hdev=00000000a477ec45)
> Dec 24 16:17:19 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Send HCI_Intel_SWRFKILL
> Dec 24 16:17:19 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Set INTEL_SHUTDOWN_EXECUTED
> 
> Dec 24 16:17:35 han1-XPS-13-9350 systemd-shutdown[1]: Sending SIGTERM to remaining processes...
> 
> [REBOOT...]
> 
> Dec 24 16:18:40 han1-XPS-13-9350 kernel: usb 1-3: new full-speed USB device number 2 using xhci_hcd
> Dec 24 16:18:40 han1-XPS-13-9350 kernel: usb 1-3: New USB device found, idVendor=8087, idProduct=0a2a, bcdDevice= 0.01
> Dec 24 16:18:40 han1-XPS-13-9350 kernel: usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> 
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: Core ver 2.22
> 
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>> btusb_probe: intf 0000000016d7e789 id 0000000058418b5d
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Allocate hci_dev=0000000052758830
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Set hci_set_drvdata(hdev=0000000052758830, data=0000000074e43445)
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: usbcore: registered new interface driver btusb
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>> btintel_setup_combined(hdev=0000000052758830)
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>> Test flag(hdev=0000000052758830, INTEL_SHUTDOWN_EXECUTED)
> Dec 24 16:18:41 han1-XPS-13-9350 kernel: Bluetooth: >>>>>      INTEL_SHUTDOWN_EXECUTED is NOT SET
> 
> Dec 24 16:18:43 han1-XPS-13-9350 kernel: Bluetooth: hci0: Reading Intel version command failed (-110)
> Dec 24 16:18:43 han1-XPS-13-9350 kernel: Bluetooth: hci0: command tx timeout
> 
> 
> After [REBOOT], the INTEL_SHUTDOWN_EXECUTED flag that was set before the reboot is gone. 
> So, how can I make the flag persisten between rebooting the system?

thanks for being patient with me. I finally understand the issue here. The system reboots and thus we get a new hci_dev, but the controller sticks in its runtime suspend operational mode.

So yes, the only way to make this right is to list the quirk in btusb.c blacklist table. I review the original patch once again after fully groking the issue.

Regards

Marcel


