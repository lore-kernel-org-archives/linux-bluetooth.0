Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F82C43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A926A20855
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILPyU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 11:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgILPyP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 11:54:15 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 12 Sep 2020 15:54:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anupamsr@yahoo.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-9PnlMrId9b@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Anupam Srivastava (anupamsr@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |anupamsr@yahoo.com

--- Comment #153 from Anupam Srivastava (anupamsr@yahoo.com) ---
As a complete newbie in kernel space I wanted to pitch in and say that there
are many types of cheap Chinese USB-Bluetooth chips in market that are just a
tinsy bit different:

Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           25.20
  iManufacturer           0
  iProduct                2 CSR8510 A10
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA

The device gets detected but doesn't respond to any commands including 'power
up'. I am thinking if it will be possible to have a proper support of such
device in Linux. They do ship with drivers for Windows. If anyone would be so
kind to point me to start pointing I would be very interested in hacking some
support for it.

-- 
You are receiving this mail because:
You are the assignee for the bug.
