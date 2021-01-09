Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE363C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jan 2021 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02F3239D1
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jan 2021 21:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAIVSa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:18:30 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50054 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVSa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jan 2021 16:18:30 -0500
Received: from marcel-macpro.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 322B6CECFF;
        Sat,  9 Jan 2021 22:25:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: bluetoothctl not listing the controller when I disable the HID
 profiles
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABatt_w0CxJGX7Vp+h-hOe3EE0CgjWiprom400iawXJ4BmbURQ@mail.gmail.com>
Date:   Sat, 9 Jan 2021 22:17:48 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B1F1FD56-9B66-4AF2-90B3-6A2D9DBBA861@holtmann.org>
References: <CABatt_w0CxJGX7Vp+h-hOe3EE0CgjWiprom400iawXJ4BmbURQ@mail.gmail.com>
To:     Martin Townsend <mtownsend1973@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,

> I've been debugging a problem where my bluetooth device wasn't showing
> up in bluetoothctl.  I was building with the following configuration:
> 
> --disable-a2dp --disable-avrcp --disable-btpclient --disable-cups
> --enable-deprecated --enable-health --disable-hid --disable-hog
> --disable-mesh --disable-midi --disable-network --disable-nfc
> --disable-obex --enable-client --disable-sap --disable-sixaxis
> --enable-systemd --disable-testing --disable-threads --enable-tools
> --disable-udev
> 
> Basically the stack is running on a very resource constrained MIPS
> based board so I'm trying to reduce the stack down to the essential
> which is just to read BLE sensors.  But with this configuration
> bluetoothctl lists no default controllers.  Now if I enable HID
> profiles with
> --enable-hid
> 
> It works and I can list the controller and connect to a BLE sensor and
> perform all the various GATT commands.
> 
> Is this expected? I would have thought I could safely disable HID
> profiles as I'm not going to be connecting any keyboards or mice.
> 
> Bluez stack is 5.54
> Kernel is 5.4.76
> 
> This was built using Yocto but I'm sure I could get this build a newer
> version if you think this has already been fixed.
> 
> One thing I've noticed is that when bringing up hci0 when HID is
> enabled I get the following
> 
> hciconfig hci0 up
> [   48.704477][  T140] rtk_btusb: btusb_open start
> [   48.713535][  T140] rtk_btusb: btusb_open hdev->promisc ==0
> [   48.724586][  T140] rtk_btusb: download_patch start
> [   48.734262][  T140] rtk_btusb: chip type value: 0x74
> [   48.744098][  T140] rtk_btusb: HCI reset.
> [   48.763108][  T140] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
> [   48.775279][  T140] rtk_btusb: read_ver_rsp->hci_rev = 0x999
> [   48.786501][  T140] rtk_btusb: patch_entry->lmp_sub = 0x8761
> [   48.797712][  T140] rtk_btusb: Firmware already exists
> [   48.807889][  T140] rtk_btusb: Rtk patch end 1
> [   48.816687][  T140] rtk_btusb: btusb_open set HCI_RUNNING
> [   48.827449][  T140] rtk_btcoex: Open BTCOEX
> [   48.835745][  T140] rtk_btusb: btusb_open end
> [   48.849158][    T3] rtk_btcoex: BTCOEX hci_rev 0x0999
> [   48.859302][    T3] rtk_btcoex: BTCOEX lmp_subver 0x646b
> Can't init device hci0: Invalid argument (22)
> 
> even though there is an error it works!!!
> 
> When it's disabled I don't get the error at the end and it doesn't work:
> 
> [   44.084337][  T137] rtk_btusb: btusb_open start
> [   44.093395][  T137] rtk_btusb: btusb_open hdev->promisc ==0
> [   44.104446][  T137] rtk_btusb: download_patch start
> [   44.114109][  T137] rtk_btusb: chip type value: 0x74
> [   44.123946][  T137] rtk_btusb: HCI reset.
> [   44.143090][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x8761
> [   44.155259][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0xb
> [   44.166140][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
> [   44.177350][  T137] rtk_btusb: load_firmware start
> [   44.186843][  T137] rtk_btusb: lmp_version = 0x8761
> [   44.196502][  T137] rtk_btusb: config filename rtl8761bu_config
> [   44.214206][  T137] LoadPin: mnt_sb lacks block device, treating as: writable
> [   44.228442][  T137] LoadPin: enforcement can be disabled.
> [   44.240206][  T137] LoadPin: firmware pinned
> obj="/lib/firmware/rtl8761bu_config" pid=137 cmdline="hciconfig hci0
> up"
> [   44.263326][  T137] rtk_btusb: no bdaddr file /opt/bdaddr
> [   44.274090][  T137] rtk_btusb: Origin cfg len 6
> [   44.283073][  T137] rtk_btusb: 55 ab 23 87 00 00
> [   44.292235][  T137] rtk_btusb: New cfg len 6
> [   44.300690][  T137] rtk_btusb: 55 ab 23 87 00 00
> [   44.312206][  T137] rtk_btusb: fw name is  rtl8761bu_fw
> [   44.328515][  T137] rtk_btusb: This is not 8723a, use new patch style!
> [   44.341527][  T137] rtk_btusb: rtk_get_eversion: gEVersion 255
> [   44.355112][  T137] rtk_btusb: eversion->status = 0x0,
> eversion->version = 0x1
> [   44.369710][  T137] rtk_btusb: load_firmware: New gEVersion 1
> [   44.381110][  T137] rtk_btusb: rtk_get_fw_project_id: opcode 0, len
> 1, data 14
> [   44.395424][  T137] rtk_btusb: lmp_version is 8761, project_id is
> 8761, match!
> [   44.409728][  T137] rtk_btusb: fw_version = 0x999646b
> [   44.419731][  T137] rtk_btusb: number_of_total_patch = 2
> [   44.430250][  T137] rtk_btusb: chipID 2
> [   44.437847][  T137] rtk_btusb: patch_length 0x5024
> [   44.447331][  T137] rtk_btusb: start_offset 0x00003780
> [   44.457508][  T137] rtk_btusb: Svn version:    23166
> [   44.467339][  T137] rtk_btusb: Coexistence: BTCOEX_20190327-0202
> [   44.479235][  T137] rtk_btusb: buf_len = 0x502a
> [   44.488460][  T137] rtk_btusb: fw: exists, config file: exists
> [   44.500037][  T137] rtk_btusb: load_firmware done
> [   44.515792][  T137] rtk_btusb: download_data start
> [   44.636082][  T137] rtk_btusb: download_data done
> [   44.645683][  T137] rtk_btusb: HCI reset.
> [   44.665084][  T137] rtk_btusb: read_ver_rsp->lmp_subver = 0x646b
> [   44.677260][  T137] rtk_btusb: read_ver_rsp->hci_rev = 0x999
> [   44.688487][  T137] rtk_btusb: patch_entry->lmp_sub = 0x8761
> [   44.699720][  T137] rtk_btusb: Rtk patch end 0
> [   44.708525][  T137] rtk_btusb: btusb_open set HCI_RUNNING
> [   44.719288][  T137] rtk_btcoex: Open BTCOEX
> [   44.727576][  T137] rtk_btusb: btusb_open end
> [   44.741138][   T43] rtk_btcoex: BTCOEX hci_rev 0x0999
> [   44.751278][   T43] rtk_btcoex: BTCOEX lmp_subver 0x646b
> [   44.782126][   T56] rtk_btusb: btusb_notify: hci0 evt 3

this is an out-of-tree driver. Take it up with Realtek.

Regards

Marcel

