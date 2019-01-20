Return-Path: <SRS0=FRXr=P4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9AC6369F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599EB2087B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Jan 2019 14:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0Y4chCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfATOJu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:09:50 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:41884 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfATOJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Jan 2019 09:09:50 -0500
Received: by mail-io1-f53.google.com with SMTP id s22so14450950ioc.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Jan 2019 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KyaAAQ9VnzeUOWiz0BFqH3tNi27mjTWjK6deSEpq3Rg=;
        b=I0Y4chCsi+3mX8CmAWFINS/2kUyW1WQMWmvD5ZNSZvUjBNmGS1TWTAnpv287CghVcx
         a17PdpIa6JlT570Sr2KBYBwpeOFegQ0flXzxYMisIIC5WhIHOjlM5zouNOZRZdYEpO3e
         jJETp1fGPFx6OZ2MVSzoNn+y81TbgQRErLuzZ9pncIrAV6hqHJBAwq+txIt6pVqAmjBj
         4fQi/y4QgXawhmmEPtw/FsZKO30lALowrIld30jtRwzPv9CZPHhEE9anRxo5QeTdsrLI
         tQ34dlNXyYYPCMh75pCzttDflhEb8adt8SRi7H1QnvdvhfyuzCfjWL3dJETMOv18VPIV
         NWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KyaAAQ9VnzeUOWiz0BFqH3tNi27mjTWjK6deSEpq3Rg=;
        b=Vvzx4oHH1W2auwekguE7kBtLKYQvusmtGocMRwlvmAAe4dBG9BQ34XK3928X15R8Fb
         Tx4257yai/6eUCwUFxqfQLvHJzNUaOu+ZRnMHl4QmvN2GDpoND9UKWcDVZNXUVf4J/yF
         Y8+rRQkzFSzp80zuZXi8l0NABCksm1Nt1OwD1hPuxzrO7bZ4euH281bl5tfT8LpA+zJT
         my3HbqfWUC/5o9BuM679CV8sqYeGmB/784m0QaMt5glLLJs3d3Iw0PlRotIZiyA7V5RW
         7P8evNNjsOWQpSq47c6kzencUPvX8DZS2k8rTQVSN/QJVtjBfqXPRymlrWHQrExxx23W
         ESRw==
X-Gm-Message-State: AJcUukfybpzjTsU/Zosy6yTuh9xMF+QybaAAJN/l+5uqw7tIENvcrUDX
        PpQGn/wvAE0O/3/9SCP1fwSMvNzZI1jTaiXFGHqRRgRBFs4=
X-Google-Smtp-Source: ALg8bN46i0++dgJMBX++pRTVkyVgsHnxfoWlQX6+6KCyDya8+TBCPKcw9dYeoZfaHRB0e6KDZcmgma233d1SVnss9zU=
X-Received: by 2002:a6b:b589:: with SMTP id e131mr13498515iof.41.1547993388859;
 Sun, 20 Jan 2019 06:09:48 -0800 (PST)
MIME-Version: 1.0
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Sun, 20 Jan 2019 17:09:38 +0300
Message-ID: <CAAOqupzadB0Nmo=WMRwD1AetRtuqGwA2OYryeVzyGgZT90KNYQ@mail.gmail.com>
Subject: Cannot pair and connect headset
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I have a bluetooth headset SONY MDR-XB650BT and I cannot pair and connect it.

I got it several months ago and it worked well, I configured it using
blueman-manager but now I cannot.

Hardware:
02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
Subsystem: Intel Corporation Dual Band Wireless-AC 7265
Kernel driver in use: iwlwifi
Kernel modules: iwlwifi

Software:
Debian Stretch 9.6
Linux gregf 4.18.0-0.bpo.1-amd64 #1 SMP Debian 4.18.6-1~bpo9+1
(2018-09-13) x86_64 GNU/Linux
ii  blueman                               2.0.4-1
     amd64        Graphical bluetooth manager
ii  bluetooth                             5.43-2+deb9u1
     all          Bluetooth support
ii  bluez                                 5.43-2+deb9u1
     amd64        Bluetooth tools and daemons
ii  bluez-firmware                        1.2-3
     all          Firmware for Bluetooth devices
ii  bluez-hcidump                         5.43-2+deb9u1
     amd64        Analyses Bluetooth HCI packets
ii  bluez-obexd                           5.43-2+deb9u1
     amd64        bluez obex daemon
ii  bluez-tools                           0.2.0~20140808-5+b2
     amd64        Set of tools to manage Bluetooth devices for linux
ii  libbluetooth3:amd64                   5.43-2+deb9u1
     amd64        Library to use the BlueZ Linux Bluetooth stack
ii  pulseaudio-module-bluetooth           10.0-1+deb9u1
     amd64        Bluetooth module for PulseAudio sound server
ii  python-bluez                          0.22-1
     amd64        Python wrappers around BlueZ for rapid bluetooth
development

This is part of my logs: https://pastebin.com/xPnm6SgW

I'm trying to do it via `bluetoothctl` but get something like:
[bluetooth]# info 00:18:09:C5:44:1E
Device 00:18:09:C5:44:1E
Name: MDR-XB650BT
Alias: MDR-XB650BT
Class: 0x240404
Icon: audio-card
Paired: no
Trusted: no
Blocked: no
Connected: no
LegacyPairing: no
UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
[bluetooth]# agent on
Agent registered
[bluetooth]# trust 00:18:09:C5:44:1E
[CHG] Device 00:18:09:C5:44:1E Trusted: yes
Changing 00:18:09:C5:44:1E trust succeeded
[bluetooth]# pair 00:18:09:C5:44:1E
Attempting to pair with 00:18:09:C5:44:1E
[CHG] Device 00:18:09:C5:44:1E Connected: yes
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device 00:18:09:C5:44:1E Connected: no
[CHG] Device 00:18:09:C5:44:1E Connected: yes
[CHG] Device 00:18:09:C5:44:1E Connected: no
[bluetooth]# pair 00:18:09:C5:44:1E
Attempting to pair with 00:18:09:C5:44:1E
[CHG] Device 00:18:09:C5:44:1E Connected: yes
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device 00:18:09:C5:44:1E Connected: no

I'm sure it works but how to detect the reason why it cannot now, I
got out of my hairs. Could you help me, please?

Thank you!
