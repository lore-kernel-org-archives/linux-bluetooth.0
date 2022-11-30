Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7805C4321E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Nov 2022 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiK3XF7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3XF5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 18:05:57 -0500
X-Greylist: delayed 1741 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 15:05:56 PST
Received: from dpin.de (dpin.de [IPv6:2a01:4f8:150:6227::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0F950F0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 15:05:56 -0800 (PST)
Received: from [62.157.126.98] (helo=[192.168.21.41])
        by dpin.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <nicole.faerber@dpin.de>)
        id 1p0VhF-00078w-QP
        for linux-bluetooth@vger.kernel.org; Wed, 30 Nov 2022 23:36:53 +0100
Message-ID: <25009acf507abde274306efce19526d2cd8a0122.camel@dpin.de>
Subject: BLE HID GATT - Only partially working
From:   Nicole Faerber <nicole.faerber@dpin.de>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 30 Nov 2022 23:36:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
I just bought a new BLE HID device which I have a bit of a problem
with. It mostly works but not fully.

The device is an HP Elite Presenter Mouse:
https://www.hp.com/emea_africa-en/products/accessories/product-details/23564275

A pretty neat little device. The one side of it has the typical
presenter buttons for prev/next slide, a center click button and two
more function buttons. When you press and hold the center button the
device switches into a mouse mode and internal gyro/accellerometer is
used to emulate a mouse and move the mouse pointer.

In this presenter mode everything is working, including mouse pointer
movement.

The neat part is that you can twist the device in the middle and with
that flip it over. The other side has two mouse buttons and a touch
area emulating a scroll wheel.

In this mouse mode I can see HCI traffing (hcidump) but no mouse events
in Linux (no movement, no scroll wheel, no mouse button presses).

I am using Debian 'testing' and GNOME desktop on Wayland.

When the device connects I can see the following in dmesg:

[23198.451500] input: HP Elite Presenter Mouse as
/devices/virtual/misc/uhid/0005:03F0:464A.000C/input/input55
[23198.451962] input: HP Elite Presenter Keypad as
/devices/virtual/misc/uhid/0005:03F0:464A.000C/input/input56
[23198.452280] input: HP Elite Presenter Consumer Control as
/devices/virtual/misc/uhid/0005:03F0:464A.000C/input/input57
[23198.452572] hid-generic 0005:03F0:464A.000C: input,hidraw2:
BLUETOOTH HID v0.18 Mouse [HP Elite Presenter] on xx:xx:xx:xx:xx:xx


'evtest' shows the following input ev devices:

/dev/input/event20:     HP Elite Presenter Mouse
/dev/input/event21:     HP Elite Presenter Keypad
/dev/input/event22:     HP Elite Presenter Consumer Control


These are the attributes I can query (BT MAC redacted):

[HP Elite Presenter]# list-attributes
Primary Service (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0017
        00001530-1212-efde-1523-785feabcd123
        Vendor specific
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0017/char001d
        00001534-1212-efde-1523-785feabcd123
        Vendor specific
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0017/char001a
        00001531-1212-efde-1523-785feabcd123
        Vendor specific
Descriptor (Handle 0x0000)
       
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0017/char001a/desc001c
        00002902-0000-1000-8000-00805f9b34fb
        Client Characteristic Configuration
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0017/char0018
        00001532-1212-efde-1523-785feabcd123
        Vendor specific
Primary Service (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0013
        0000180f-0000-1000-8000-00805f9b34fb
        Battery Service
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0013/char0014
        00002a19-0000-1000-8000-00805f9b34fb
        Battery Level
Descriptor (Handle 0x0000)
       
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0013/char0014/desc0016
        00002902-0000-1000-8000-00805f9b34fb
        Client Characteristic Configuration
Primary Service (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service000c
        0000180a-0000-1000-8000-00805f9b34fb
        Device Information
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service000c/char0011
        00002a50-0000-1000-8000-00805f9b34fb
        PnP ID
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service000c/char000f
        00002a26-0000-1000-8000-00805f9b34fb
        Firmware Revision String
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service000c/char000d
        00002a29-0000-1000-8000-00805f9b34fb
        Manufacturer Name String
Primary Service (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
        00001801-0000-1000-8000-00805f9b34fb
        Generic Attribute Profile
Characteristic (Handle 0x0000)
        /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008/char0009
        00002a05-0000-1000-8000-00805f9b34fb
        Service Changed
Descriptor (Handle 0x0000)
       
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008/char0009/desc000b
        00002902-0000-1000-8000-00805f9b34fb
        Client Characteristic Configuration



And these are some events in this flipped over mouse mode I can
see/dump:

> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0xfa 0x0f 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0xfe 0x0f 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0xff 0x0f 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0x01 0x00 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0x02 0x00 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0x02 0x00 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0xff 0x0f 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 13
    ATT: Handle notify (0x1b)
      handle 0x0027
      value 0x00 0x00 0xf0 0xff 0x00 0x00 

but the mouse pointer does not move, buttons etc. do not work.

I am not sure what the problem could be or how to diagnose this
further. Any hints would be greatly appreciated! Since it seems that
the device works pretty much out of the box in Windows (at least
judging from the manual, I do not have Windows to test) I think no
special drivers etc. should be necessary. So I can just assume that
this devices is special in some way which is not yet fully handled by
BlueZ?

Cheers
  nicole

