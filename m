Return-Path: <SRS0=/MJP=M3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF2FC0044C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 21:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D996205F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Oct 2018 21:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D996205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJPFUb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:20:31 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:42545 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbeJPFUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Oct 2018 01:20:31 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 01:20:31 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 8F82581238EE
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 21:23:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C0EE41803D438
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 21:23:34 +0000 (UTC)
X-Session-Marker: 6461674062616B6B652E636F6D
X-HE-Tag: arch39_596020311fd32
X-Filterd-Recvd-Size: 3701
Received: from [192.168.6.148] (219.92-221-209.customer.lyse.net [92.221.209.219])
        (Authenticated sender: dag@bakke.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Oct 2018 21:23:34 +0000 (UTC)
From:   Dag Bakke <dag@bakke.com>
Subject: bluetoothd spinning at 100% CPU in
 input_device_enter_reconnect_mode()
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <577dfb58-5c24-2cb3-eab3-b3fb7fc0d1c8@bakke.com>
Date:   Mon, 15 Oct 2018 23:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi.

When my bluetooth keyboard becomes unavailable (suspending, connecting to other controller, etc.), bluetoothd starts consuming 100% CPU.
See below for output from debug mode. Is this behavior expected? Is it avoidable?

Dag B

kernel: 4.18.13-gentoo
bluez: (git as of tonight) 
no systemd

main.conf:

[General]
FastConnectable = true
[GATT]
Cache = yes
[Policy]
ReconnectUUIDs=
ReconnectAttempts=0
AutoEnable=true

bluetoothd[30587]: src/adapter.c:dev_disconnected() Device 00:18:00:3D:8B:E9 disconnected, reason 4
bluetoothd[30587]: src/adapter.c:adapter_remove_connection() 
bluetoothd[30587]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:18:00:3D:8B:E9 type 0 status 0xe
bluetoothd[30587]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[30587]: src/device.c:device_bonding_failed() status 14
bluetoothd[30587]: src/adapter.c:resume_discovery() 
bluetoothd[30587]: profiles/input/device.c:ctrl_watch_cb() Device 00:18:00:3D:8B:E9 disconnected
bluetoothd[30587]: profiles/input/device.c:intr_watch_cb() Device 00:18:00:3D:8B:E9 disconnected
bluetoothd[30587]: src/service.c:change_state() 0x5593ae51b620: device 00:18:00:3D:8B:E9 profile input-hid state changed: connected -> disconnected (0)
bluetoothd[30587]: profiles/input/device.c:input_device_enter_reconnect_mode() path=/org/bluez/hci0/dev_00_18_00_3D_8B_E9 reconnect_mode=device

[At this point, bluetoothd starts consuming 100% cpu]


[Convertible 2 TKL]# show
Controller 00:1B:DC:06:BA:87 (public)
        Name: BlueZ 5.50
        Alias: BlueZ 5.50
        Class: 0x0000010c
        Powered: yes
        Discoverable: no
        DiscoverableTimeout: 0x000000b4
        Pairable: yes
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0532
        Discovering: no

[Convertible 2 TKL]# info
Device 00:18:00:3D:8B:E9 (public)
        Name: Convertible 2 TKL
        Alias: Convertible 2 TKL
        Class: 0x00000540
        Icon: input-keyboard
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v0A5Cp8502d011B

I will be happy to provide further info as needed.

