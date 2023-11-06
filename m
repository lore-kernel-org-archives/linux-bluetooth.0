Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0005C4167D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjKFOfu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 09:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFOft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 09:35:49 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B894
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 06:35:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DED21BF20B
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 14:35:43 +0000 (UTC)
Message-ID: <c0df9d614f2a220bc93227eafcc68f73f1751528.camel@hadess.net>
Subject: Using Laird Connectivity Bluetooth LE PTS dongle with Linux
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Mon, 06 Nov 2023 15:35:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey,

I bought the Laird Connectivity Bluetooth LE-only PTS dongle listed on:
https://support.bluetooth.com/hc/en-us/articles/360049018492-What-is-the-difference-between-the-Profile-Tuning-Suite-PTS-Dongles-
as I was hoping to have an easy to use Bluetooth LE only device for testing.

But the device only shows up as a serial device under kernel 6.5 from
my distribution.

Is there anything specific that needs to be done for that device to be
usable as a Bluetooth adapter under Linux? Or does it only work with
the PTS?

I spotted the ability to run specific software on the micro-controller
itself when powered on, but nothing specific to using it as an adapter:
http://assets.lairdtech.com/home/brandworld/files/BL654%20USB%20Dongle%20User%20Guide%20v1_0.pdf

Full lsusb output for that device:
Bus 001 Device 018: ID 1915:521f Nordic Semiconductor ASA Nordic Open
DFU Bootloader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x1915 Nordic Semiconductor ASA
  idProduct          0x521f 
  bcdDevice            1.00
  iManufacturer           1 Laird Connectivity
  iProduct                2 Nordic Open DFU Bootloader
  iSerial                 3 E1BB9211FA41
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x004b
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 Default configuration
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2 Communications
      bFunctionSubClass       2 Abstract (modem)
      bFunctionProtocol       0 
      iFunction               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      0 
      iInterface              0 
      CDC Header:
        bcdCDC               1.10
      CDC Call Management:
        bmCapabilities       0x03
          call management
          use DataInterface
        bDataInterface          1
      CDC ACM:
        bmCapabilities       0x02
          line coding and serial state
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              16
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0001
  Self Powered

Cheers
