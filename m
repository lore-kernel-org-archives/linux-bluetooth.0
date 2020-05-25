Return-Path: <SRS0=GU2S=7H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0E2073B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgEYKaZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 May 2020 06:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389373AbgEYKaX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 May 2020 06:30:23 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203535] Bluetooth: command tx timeout with Intel Corporation
 Wireless 7260 in A2DP mode
Date:   Mon, 25 May 2020 10:30:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tnielsen@suse.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203535-62941-KafX7G1Jl3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203535-62941@https.bugzilla.kernel.org/>
References: <bug-203535-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203535

Thomas Nielsen (tnielsen@suse.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tnielsen@suse.com

--- Comment #2 from Thomas Nielsen (tnielsen@suse.com) ---
Hello I believe this is the same problem (i took out all the plasma and
networkmanager messages.
In short my jabra 65t looses connection after very short audio usage (and as a
bonus kills my mouse as well if i use bt mouse) The jabra headset works fine
with my phone(-s)

(uname -a
Linux linux-jn76 5.6.12-1-default #1 SMP Tue May 12 17:44:12 UTC 2020 (9bff61b)
x86_64 x86_64 x86_64 GNU/Linux)

May 25 12:04:49 linux-jn76 kernel: input: Jabra Elite 65t (AVRCP) as
/devices/virtual/input/input33
May 25 12:04:49 linux-jn76 obexd[2100]: CONNECT(0x0), <unknown>(0xff)
May 25 12:04:49 linux-jn76 obexd[2100]: CONNECT(0x0), <unknown>(0x0)
May 25 12:04:49 linux-jn76 obexd[2100]: SETPATH(0x5), <unknown>(0xff)
May 25 12:04:49 linux-jn76 obexd[2100]: stat(/root/phonebook/): No such file or
directory (2)
May 25 12:04:49 linux-jn76 obexd[2100]: SETPATH(0x5), Not Found(0x44)
May 25 12:04:49 linux-jn76 systemd-logind[1161]: Watching system buttons on
/dev/input/event19 (Jabra Elite 65t (AVRCP))
May 25 12:05:51 linux-jn76 kwin_x11[1876]: qt.qpa.xcb: QXcbConnection: XCB
error: 3 (BadWindow), sequence: 4207, resource id: 2>
May 25 12:05:51 linux-jn76 kwin_x11[1876]: qt.qpa.xcb: QXcbConnection: XCB
error: 3 (BadWindow), sequence: 4235, resource id: 3>
May 25 12:06:53 linux-jn76 kio_http_cache_cleaner[6486]: QIODevice::skip
(QBuffer): WriteOnly device
May 25 12:06:53 linux-jn76 kio_http_cache_cleaner[6486]: QIODevice::skip
(QBuffer): WriteOnly device
May 25 12:09:14 linux-jn76 kernel: usb 2-1.3: reset full-speed USB device
number 5 using ehci-pci
May 25 12:09:36 linux-jn76 kernel: usb 2-1.3: Failed to suspend device, error
-32
May 25 12:09:36 linux-jn76 obexd[2100]: disconnected: Transport got
disconnected
May 25 12:09:36 linux-jn76 kernel: usb 2-1.3: USB disconnect, device number 5
May 25 12:09:36 linux-jn76 kded5[1833]: bluedevil: Removed Obex session is not
ours "/org/bluez/obex/server/session3"
May 25 12:09:36 linux-jn76 dbus-daemon[1119]: [system] Rejected send message, 0
matched rules; type="method_return", sender=":1.22" (uid=0 pid=1764 comm="/us>
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Unable to get io data for Headset
Voice gateway: getpeername: Transport endpoint is not connected (107)
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Unable to get io data for Phone
Book Access: getpeername: Transport endpoint is not connected (107)
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Endpoint unregistered:
sender=:1.22 path=/MediaEndpoint/A2DPSink/sbc
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Endpoint unregistered:
sender=:1.22 path=/MediaEndpoint/A2DPSource/sbc
May 25 12:09:36 linux-jn76 systemd[1]: Starting Load/Save RF Kill Switch
Status...
May 25 12:09:36 linux-jn76 systemd[1755]: Stopped target Bluetooth.
May 25 12:09:36 linux-jn76 systemd[1]: Stopped target Bluetooth.
May 25 12:09:36 linux-jn76 systemd[1]: Started Load/Save RF Kill Switch Status.
May 25 12:09:36 linux-jn76 kernel: usb 2-1.3: new full-speed USB device number
6 using ehci-pci
May 25 12:09:36 linux-jn76 kernel: usb 2-1.3: New USB device found,
idVendor=8087, idProduct=07dc, bcdDevice= 0.01
May 25 12:09:36 linux-jn76 kernel: usb 2-1.3: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
May 25 12:09:36 linux-jn76 kernel: Bluetooth: hci0: read Intel version:
3707100180012d0d2a
May 25 12:09:36 linux-jn76 kernel: Bluetooth: hci0: Intel device is already
patched. patch num: 2a
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Endpoint registered: sender=:1.22
path=/MediaEndpoint/A2DPSink/sbc
May 25 12:09:36 linux-jn76 bluetoothd[1439]: Endpoint registered: sender=:1.22
path=/MediaEndpoint/A2DPSource/sbc
May 25 12:09:37 linux-jn76 systemd[1755]: Reached target Bluetooth.
May 25 12:09:37 linux-jn76 systemd[1]: Reached target Bluetooth.
May 25 12:09:42 linux-jn76 systemd[1]: systemd-rfkill.service: Succeeded.
May 25 12:09:53 linux-jn76 kernel: usb 1-1.2: new full-speed USB device number
6 using ehci-pci
May 25 12:09:53 linux-jn76 kernel: usb 1-1.2: New USB device found,
idVendor=046d, idProduct=c52f, bcdDevice=22.01
May 25 12:09:53 linux-jn76 kernel: usb 1-1.2: New USB device strings: Mfr=1,
Product=2, SerialNumber=0
May 25 12:09:53 linux-jn76 kernel: usb 1-1.2: Product: USB Receiver
May 25 12:09:53 linux-jn76 kernel: usb 1-1.2: Manufacturer: Logitech
May 25 12:09:53 linux-jn76 kernel: logitech-djreceiver 0003:046D:C52F.0007:
hidraw0: USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:00:1a.0-1.2/inpu>
May 25 12:09:53 linux-jn76 kernel: logitech-djreceiver 0003:046D:C52F.0008:
hiddev96,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:1a.>
May 25 12:09:53 linux-jn76 kernel: logitech-djreceiver 0003:046D:C52F.0008:
device of type eQUAD step 4 DJ (0x04) connected on slot 1
May 25 12:09:53 linux-jn76 kernel: input: Logitech M187 as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C52F.0008/0003:046D:4019.0009/>
May 25 12:09:53 linux-jn76 kernel: logitech-hidpp-device 0003:046D:4019.0009:
input,hidraw3: USB HID v1.11 Mouse [Logitech M187] on
usb-0000:00:1a.0-1.2/inpu>
May 25 12:09:53 linux-jn76 mtp-probe[7435]: checking bus 1, device 6:
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2"
May 25 12:09:53 linux-jn76 mtp-probe[7435]: bus: 1, device: 6 was not an MTP
device
May 25 12:09:53 linux-jn76 mtp-probe[7462]: checking bus 1, device 6:
"/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2"
May 25 12:09:53 linux-jn76 mtp-probe[7462]: bus: 1, device: 6 was not an MTP
device
May 25 12:09:53 linux-jn76 upowerd[1986]: failed to coldplug unifying device:
Unable to read response from device: Resource temporarily unavailable
May 25 12:09:54 linux-jn76 systemd-logind[1161]: Watching system buttons on
/dev/input/event17 (Logitech M187)
May 25 12:09:54 linux-jn76 kcminit[7470]: Initializing  "kcm_mouse" : 
"kcminit_mouse"
May 25 12:09:54 linux-jn76 kwin_x11[1876]: qt.qpa.xcb: QXcbConnection: XCB
error: 3 (BadWindow), sequence: 61320, resource id: 132120581, major code: 18
(Cha>
May 25 12:09:58 linux-jn76 bluetoothd[1439]: a2dp-sink profile connect failed
for 74:5C:4B:30:12:01: Device or resource busy
May 25 12:09:58 linux-jn76 obexd[2100]: CONNECT(0x0), <unknown>(0xff)
May 25 12:09:58 linux-jn76 obexd[2100]: CONNECT(0x0), <unknown>(0x0)
May 25 12:09:58 linux-jn76 obexd[2100]: SETPATH(0x5), <unknown>(0xff)
May 25 12:09:58 linux-jn76 obexd[2100]: stat(/root/phonebook/): No such file or
directory (2)
May 25 12:09:58 linux-jn76 obexd[2100]: SETPATH(0x5), Not Found(0x44)

-- 
You are receiving this mail because:
You are the assignee for the bug.
