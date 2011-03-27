Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Mar 2011 14:47:51 +0200
From: Vladimir Botka <vbotka@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: ciriarte@personal.net.py
Subject: bluetoothd connection timed-out with Nokia BH-505 and BCM2045 in
 2.6.37
Message-ID: <20110327144751.1463ebbe@l696.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!,

bluetoothd connection timed-out with Nokia BH-505 and BCM2045 [1] in 2.6.37. The multimedia buttons work
(play/pause), but the audio doesn't work. From /var/log/messages can be seen:
--
Mar 19 19:31:06 roamer pulseaudio[3668]: module-bluetooth-device.c: Skipping
5410592 us (= 954428 bytes) in audio stream
Mar 19 19:31:14 roamer bluetoothd[1663]: Suspend: Connection timed out (110)
Mar 19 19:31:14 roamer bluetoothd[1663]: suspend failed
Mar 19 19:31:14 roamer pulseaudio[3668]: module-bluetooth-device.c: Received
error condition: Error de entrada/salida
Mar 19 19:31:17 roamer bluetoothd[1663]: Abort: Connection timed out (110)
--

[1]
  Model: "Dell BCM2045"
  Hotplug: USB
  Vendor: usb 0x413c "Dell Computer Corp."
  Device: usb 0x8126 "BCM2045"
[2] /var/log/messages with bluetooth debug
    https://bugzilla.novell.com/show_bug.cgi?id=681080#c6
[3] # hcidump -t -w test
    https://bugzilla.novell.com/show_bug.cgi?id=681080#c7

Any idea ? Thank you,

	Vladimir Botka
