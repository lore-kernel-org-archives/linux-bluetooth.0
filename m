Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 22:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiAMWUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 17:20:09 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41503 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237457AbiAMWUI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 17:20:08 -0500
Received: from [192.168.0.2] (ip5f5aea9b.dynamic.kabel-deutschland.de [95.90.234.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD31C61EA1925
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 23:20:05 +0100 (CET)
Message-ID: <5891f0d5-8d51-9da5-7663-718f301490b1@molgen.mpg.de>
Date:   Thu, 13 Jan 2022 23:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: How to pass through USB Bluetooth wireless interface to QEMU?
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     linux-bluetooth@vger.kernel.org
References: <331ae35c-7d48-46fc-c4ae-1e60cb0f3378@molgen.mpg.de>
In-Reply-To: <331ae35c-7d48-46fc-c4ae-1e60cb0f3378@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Fixed references]


Am 13.01.22 um 23:18 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> To debug the issue with file transfers to the Nokia N9 [1], I would like 
> to pass through the USB Bluetooth wireless to QEMU.
> 
>      $ lsusb
>      Bus 001 Device 004: ID 1bcf:28ae Sunplus Innovation Technology Inc. 
> Laptop Integrated Webcam HD
>      Bus 001 Device 003: ID 8087:0a2a Intel Corp. Bluetooth wireless 
> interface
>      Bus 001 Device 002: ID 8087:8001 Intel Corp. Integrated Hub
>      Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>      Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>      Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>      $ ls -ld /dev/bus/usb/001/003
>      crw-rw-rw- 1 root root 189, 2 13. Jan 23:05 /dev/bus/usb/001/003
> 
> Then following Leif’s article *QEMU USB host device pass-through* [2], I 
> run
> 
>      $ qemu-system-x86_64 -version
>      QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-1)
>      Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project 
> developers
>      $ sudo qemu-system-x86_64 -cpu host -m 2G -enable-kvm -usb -device 
> usb-host,vendorid=0x8087,productid=0x0a2a -hda /dev/shm/debian-64.img 
> -net nic -net user,hostfwd=tcp::22223-:22
> 
> (`-device usb-host,hostbus=1,hostport=3` did *not* work for me.)
> 
> In QEMU with *linux-image-5.15.0-2-amd64* 5.15.5-2 and *bluez* 5.62-2 
> the device is now detected, but bluetoothctl does not detect the 
> controller. (Starting QEMU as root does not make a difference.)
> 
>      # lsusb
>      Bus 001 Device 002: ID 8087:0a2a Intel Corp. Bluetooth wireless 
> interface
>      Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>      # lsusb -t
>      /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
>          |__ Port 1: Dev 2, If 0, Class=Wireless, Driver=btusb, 12M
>          |__ Port 1: Dev 2, If 1, Class=Wireless, Driver=btusb, 12M
> 
>      # bluetoothctl
>      Agent registered
>      [bluetooth]# list
>      [bluetooth]#
> 
>      # systemctl status bluetooth
>      ● bluetooth.service - Bluetooth service
>           Loaded: loaded (/lib/systemd/system/bluetooth.service; 
> enabled; vendor preset: enabled)
>           Active: active (running) since Thu 2022-01-13 23:05:25 CET; 
> 6min ago
>             Docs: man:bluetoothd(8)
>         Main PID: 400 (bluetoothd)
>           Status: "Running"
>            Tasks: 1 (limit: 2326)
>           Memory: 4.4M
>              CPU: 24ms
>           CGroup: /system.slice/bluetooth.service
>                   └─400 /usr/libexec/bluetooth/bluetoothd
> 
>      Jan 13 23:05:25 qemu systemd[1]: Starting Bluetooth service...
>      Jan 13 23:05:25 qemu bluetoothd[400]: Bluetooth daemon 5.62
>      Jan 13 23:05:25 qemu systemd[1]: Started Bluetooth service.
>      Jan 13 23:05:25 qemu bluetoothd[400]: Starting SDP server
>      Jan 13 23:05:25 qemu bluetoothd[400]: Bluetooth management 
> interface 1.21 initialized
> 
> Linux in QEMU logs:
> 
> 
>      # dmesg | grep -e Bluetooth -e hci0
>      [    4.385414] Bluetooth: Core ver 2.22
>      [    4.385453] Bluetooth: HCI device and connection manager 
> initialized
>      [    4.385741] Bluetooth: HCI socket layer initialized
>      [    4.385744] Bluetooth: L2CAP socket layer initialized
>      [    4.385751] Bluetooth: SCO socket layer initialized
>      [    4.593802] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>      [    4.593806] Bluetooth: BNEP filters: protocol multicast
>      [    4.593809] Bluetooth: BNEP socket layer initialized
>      [    6.544261] Bluetooth: hci0: Reading Intel version command 
> failed (-110)
>      [    6.544310] Bluetooth: hci0: command tx timeout
> 
> The firmware is installed:
> 
>      # ls /lib/firmware/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
>      /lib/firmware/intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
> 
> Do you have an idea, how to get it working?
> 
> 
> Kind regards,
> 
> Paul


[1]: 
https://lore.kernel.org/linux-bluetooth/a93c0fa7-7b84-6aea-265b-c913e0c84678@molgen.mpg.de/
[2]: https://station.eciton.net/qemu-usb-host-device-pass-through.html
