Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 01:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CAB610A4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 01:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhHSB5G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:57:06 -0400
Received: from mail.sma-inc.us ([192.88.109.73]:20986 "EHLO sma-inc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235258AbhHSB5F (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 21:57:05 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 21:57:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=sma-inc.us; s=mail;
        bh=oddMgdINW0KNk7RrYqM9sFrWAYqSiekkGni5O0G8ctU=;
        h=Content-Transfer-Encoding:Content-Language:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To; b=mvEIh9iCm5dFRCt2tWHMPec/0h/0eG9M3Xy9YfIJJaAej+F
        1w65ln0Uxk6eSgcyBU+XVJjzslqj9W/xQ0UpbYsclzYwtYlrKiPBU41Y9HoZq6QLvqmtkBrkR2sn3
        GxA+DUXBO7vIEOJtZ24xMHF11vIQmilXq55DC4URbSiDgcg=
Received: from [127.0.0.1] (account moe.james@sma-inc.us HELO [IPv6:fd2f:4760:521f:3f3c::c0a8:45ec])
  by sma-inc.us (CommuniGate Pro SMTP 6.2.15)
  with ESMTPSA id 7815259 for linux-bluetooth@vger.kernel.org; Wed, 18 Aug 2021 18:36:29 -0700
X-Assp-Version: 2.6.5(21074) on assp.sma-server3.sma.com
X-Assp-ID: assp.sma-server3.sma.com 36989-03649
X-Assp-Session: 7FE918004240 (mail 1)
X-Assp-Envelope-From: jimoe@sohnen-moe.com
X-Assp-Intended-For: linux-bluetooth@vger.kernel.org
X-Assp-Server-TLS: yes
Received: from unknown ([fd2f:4760:521f:3f3c::c0a8:45ec] helo=[IPv6:fd2f:4760:521f:3f3c::c0a8:45ec])
         by assp.sma-server3.sma.com with SMTPA (2.6.5); 18 Aug 2021 18:36:29
         -0700
To:     linux-bluetooth@vger.kernel.org
From:   James Moe <jimoe@sohnen-moe.com>
Subject: The UNIFY bluetooth unit is not recognized by Gnome/bluetooth
Message-ID: <sig.0865cb2f28.54aee928-a4e2-9368-f417-58d87999b4e1@sohnen-moe.com>
Date:   Wed, 18 Aug 2021 18:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

opensuse tumbleweed 20210810
linux 5.13.8-1-default x86_64
gnome 40.3.0

The Roverbeats UNIFY by Etekcity is a bluetooth-to-analog-audio device to allow
bluetooth capable devices to send audio to analog equipment. Gnome fails to
properly connect to the device. The Bluetooth Settings page shows the device as
connected. However, there is no listing of Unify as an Output option, nor does
the Unify unit show a proper connection.

Below is the journal contents from the time a bluetooth v5 dongle (Asus
usb-bt500, realtek 8761b radio) was inserted into a USB port, discovered and
connected successfully to a "Bose Mini ii" speaker, and failed to connect to the
Unify device. The important bit is "Unable to select SEP"?

Other devices (e.g., iPads, iPod) connect successfully.

Is there simple way to include the Unify device in Gnome's awareness?

2021-08-18T16:01:14-0700 sma-station14l [RPM][10017]: Transaction ID 611d913a
started
2021-08-18T16:01:14-0700 sma-station14l [RPM][10017]: install
rtl8761b-firmware-20200610-1.4.noarch: success
2021-08-18T16:01:14-0700 sma-station14l [RPM][10017]: install
rtl8761b-firmware-20200610-1.4.noarch: success
2021-08-18T16:01:14-0700 sma-station14l [RPM][10017]: Transaction ID 611d913a
finished: 0
2021-08-18T16:01:20-0700 sma-station14l dbus-daemon[7119]: [session uid=0
pid=7119] Activating via systemd: service name='org.gtk.vfs.Daemon'
unit='gvfs-daemon.service' requested by ':1.7' (uid=0 pid=10056
comm="/usr/bin/appstream-util uninstall download.opensus")
2021-08-18T16:01:20-0700 sma-station14l systemd[9087]: Starting Virtual
filesystem service...
2021-08-18T16:01:20-0700 sma-station14l dbus-daemon[7119]: [session uid=0
pid=7119] Successfully activated service 'org.gtk.vfs.Daemon'
2021-08-18T16:01:20-0700 sma-station14l systemd[9087]: Started Virtual
filesystem service.
2021-08-18T16:01:20-0700 sma-station14l dbus-daemon[7119]: [session uid=0
pid=7119] Activating via systemd: service name='org.gtk.vfs.Metadata'
unit='gvfs-metadata.service' requested by ':1.7' (uid=0 pid=10056
comm="/usr/bin/appstream-util uninstall download.opensus")
2021-08-18T16:01:20-0700 sma-station14l systemd[9087]: Starting Virtual
filesystem metadata service...
2021-08-18T16:01:20-0700 sma-station14l dbus-daemon[7119]: [session uid=0
pid=7119] Successfully activated service 'org.gtk.vfs.Metadata'
2021-08-18T16:01:21-0700 sma-station14l systemd[9087]: Started Virtual
filesystem metadata service.
2021-08-18T16:01:35-0700 sma-station14l systemd[9547]: Started Application
launched by gnome-shell.
2021-08-18T16:01:52-0700 sma-station14l kernel: usb 2-2.1.1: USB disconnect,
device number 11
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: new full-speed USB
device number 12 using xhci_hcd
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: New USB device
found, idVendor=0b05, idProduct=190e, bcdDevice= 2.00
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: New USB device
strings: Mfr=1, Product=2, SerialNumber=3
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: Product: ASUS USB-BT500
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: Manufacturer: Realtek
2021-08-18T16:01:56-0700 sma-station14l kernel: usb 2-2.1.1: SerialNumber:
00E04C239987
2021-08-18T16:01:56-0700 sma-station14l upowerd[9227]: treating change event as
add on /sys/devices/pci0000:00/0000:00:05.0/0000:02:00.0/usb2/2-2/2-2.1/2-2.1.1
2021-08-18T16:01:56-0700 sma-station14l kernel: usbcore: registered new
interface driver btusb
2021-08-18T16:01:56-0700 sma-station14l systemd[1]: Starting Load/Save RF Kill
Switch Status...
2021-08-18T16:01:56-0700 sma-station14l systemd[9547]: Reached target Bluetooth.
2021-08-18T16:01:56-0700 sma-station14l systemd[9087]: Reached target Bluetooth.
2021-08-18T16:01:56-0700 sma-station14l systemd[1]: Started Load/Save RF Kill
Switch Status.
2021-08-18T16:01:56-0700 sma-station14l systemd[1]: Reached target Bluetooth
Support.
2021-08-18T16:01:56-0700 sma-station14l bluetoothd[1245]: Endpoint registered:
sender=:1.158 path=/MediaEndpoint/A2DPSink/sbc
2021-08-18T16:01:56-0700 sma-station14l bluetoothd[1245]: Endpoint registered:
sender=:1.158 path=/MediaEndpoint/A2DPSource/sbc
2021-08-18T16:02:01-0700 sma-station14l systemd[1]: systemd-rfkill.service:
Deactivated successfully.
2021-08-18T16:02:11-0700 sma-station14l bluetoothd[1245]:
/org/bluez/hci0/dev_08_DF_1F_43_AD_9B/sep1/fd5: fd(43) ready
2021-08-18T16:02:11-0700 sma-station14l rtkit-daemon[9230]: Supervising 0
threads of 0 processes of 0 users.
2021-08-18T16:02:11-0700 sma-station14l rtkit-daemon[9230]: Supervising 0
threads of 0 processes of 1 users.
2021-08-18T16:02:11-0700 sma-station14l kernel: input: Bose Mini II SoundLink
(AVRCP) as /devices/virtual/input/input52
2021-08-18T16:02:11-0700 sma-station14l rtkit-daemon[9230]: Supervising 0
threads of 0 processes of 1 users.
2021-08-18T16:02:11-0700 sma-station14l rtkit-daemon[9230]: Supervising 0
threads of 0 processes of 1 users.
2021-08-18T16:02:11-0700 sma-station14l rtkit-daemon[9230]: Supervising 0
threads of 0 processes of 1 users.
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: CONNECT(0x0), <unknown>(0xff)
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: CONNECT(0x0), <unknown>(0x0)
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: SETPATH(0x5), <unknown>(0xff)
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: SETPATH(0x5), Success(0x20)
2021-08-18T16:02:11-0700 sma-station14l systemd-logind[1310]: Watching system
buttons on /dev/input/event24 (Bose Mini II SoundLink (AVRCP))
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: SETPATH(0x5), <unknown>(0xff)
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]:
stat(/home/jmoe/phonebook/telecom): No such file or directory (2)
2021-08-18T16:02:11-0700 sma-station14l obexd[11125]: SETPATH(0x5), Not Found(0x44)
2021-08-18T16:02:15-0700 sma-station14l systemd[1]: snapperd.service:
Deactivated successfully.
2021-08-18T16:03:21-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:22-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:22-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:23-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:23-0700 sma-station14l kernel: input: UNIFY (AVRCP) as
/devices/virtual/input/input53
2021-08-18T16:03:23-0700 sma-station14l systemd-logind[1310]: Watching system
buttons on /dev/input/event25 (UNIFY (AVRCP))
2021-08-18T16:03:24-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:35-0700 sma-station14l bluetoothd[1245]:
profiles/audio/a2dp.c:a2dp_select_capabilities() Unable to select SEP
2021-08-18T16:03:37-0700 sma-station14l kernel: input: UNIFY (AVRCP) as
/devices/virtual/input/input54
2021-08-18T16:03:37-0700 sma-station14l systemd-logind[1310]: Watching system
buttons on /dev/input/event25 (UNIFY (AVRCP))
2021-08-18T16:04:00-0700 sma-station14l systemd[9547]:
app-gnome-gnome\x2dcontrol\x2dcenter-10106.scope: Consumed 4.227s CPU time.


-- 
James Moe
moe dot james at sohnen-moe dot com
520.743.3936
Think.
