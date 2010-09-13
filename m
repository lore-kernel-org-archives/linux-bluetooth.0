Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001301cb4efe$f723f660$e56be320$%park@samsung.com>
References: <AANLkTi=Q=E2uUBXuyBuOdrxiyWU+meiFLkaef3xvwQ1=@mail.gmail.com>
	<001301cb4efe$f723f660$e56be320$%park@samsung.com>
Date: Mon, 13 Sep 2010 17:09:30 -0500
Message-ID: <AANLkTi=C8Cj8KicUWfMMMg-Rj5VdDUNXNJfmBXOuP0Pk@mail.gmail.com>
Subject: Re: MP3 over A2DP issue
From: pl bossart <bossart.nospam@gmail.com>
To: =?EUC-KR?B?udrC+b+t?= <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Could you send me "bluetoothd" log?

I tried again on a different laptop with a clean Fedora install. Same
issue, cannot send mp3 to the headset (worked fine with decode/sbc
encode):

[ume@plb ~]$ gst-launch filesrc location=~/AURAL/Audio/maxwork.mp3 !
mp3parse ! a2dpsink device=00:0B:E4:94:31:9D
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
0:00:00.019779029  2452  0x83cfc98 ERROR              avdtpsink
audio/gstavdtpsink.c:1328:gst_avdtp_sink_audioservice_recv:<avdtpsink>
BT_OPEN failed : Invalid argument(22)
0:00:00.019809767  2452  0x83cfc98 ERROR              avdtpsink
audio/gstavdtpsink.c:1085:gst_avdtp_sink_configure:<avdtpsink> Error
while receiving device confirmation
0:00:00.020036315  2452  0x83cfc98 ERROR              avdtpsink
audio/gstavdtpsink.c:1328:gst_avdtp_sink_audioservice_recv:<avdtpsink>
BT_START_STREAM failed : Success(0)
0:00:00.020050426  2452  0x83cfc98 ERROR              avdtpsink
audio/gstavdtpsink.c:937:gst_avdtp_sink_stream_start:<avdtpsink> Error
while stream start confirmation
WARNING: from element
/GstPipeline:pipeline0/GstA2dpSink:a2dpsink0/GstAvdtpSink:avdtpsink:
Internal data flow problem.
Additional debug info:
gstbasesink.c(3436): gst_base_sink_chain_unlocked ():
/GstPipeline:pipeline0/GstA2dpSink:a2dpsink0/GstAvdtpSink:avdtpsink:
Received buffer without a new-segment. Assuming timestamps start from 0.
ERROR: from element /GstPipeline:pipeline0/GstFileSrc:filesrc0:
Internal data flow error.
Additional debug info:
gstbasesrc.c(2559): gst_base_src_loop ():
/GstPipeline:pipeline0/GstFileSrc:filesrc0:
streaming task paused, reason error (-5)
Execution ended after 1757132 ns.
Setting pipeline to PAUSED ...
Setting pipeline to READY ...
Setting pipeline to NULL ...
Freeing pipeline ...


And I see the following messages in /var/log/messages:
Sep 13 16:40:51 localhost kernel: usb 4-2: Product: ThinkPad Bluetooth
with Enhanced Data Rate II
Sep 13 16:40:51 localhost kernel: Bluetooth: Core ver 2.15
Sep 13 16:40:51 localhost kernel: Bluetooth: HCI device and connection
manager initialized
Sep 13 16:40:51 localhost kernel: Bluetooth: HCI socket layer initialized
Sep 13 16:40:51 localhost kernel: Bluetooth: Generic Bluetooth USB
driver ver 0.6
Sep 13 16:40:51 localhost kernel: thinkpad_acpi: rfkill switch
tpacpi_bluetooth_sw: radio is unblocked
Sep 13 16:40:57 localhost bluetoothd[1647]: Bluetooth daemon 4.64
Sep 13 16:40:58 localhost bluetoothd[1651]: Starting SDP server
Sep 13 16:40:58 localhost kernel: Bluetooth: L2CAP ver 2.14
Sep 13 16:40:58 localhost kernel: Bluetooth: L2CAP socket layer initialized
Sep 13 16:40:58 localhost bluetoothd[1651]: Parsing
/etc/bluetooth/network.conf failed: No such file or directory
Sep 13 16:40:58 localhost kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Sep 13 16:40:58 localhost kernel: Bluetooth: BNEP filters: protocol multicast
Sep 13 16:40:58 localhost bluetoothd[1651]: bridge pan0 created
Sep 13 16:40:58 localhost bluetoothd[1651]: Parsing
/etc/bluetooth/input.conf failed: No such file or directory
Sep 13 16:40:58 localhost bluetoothd[1651]: Parsing
/etc/bluetooth/audio.conf failed: No such file or directory
Sep 13 16:40:58 localhost bluetoothd[1651]: HCI dev 0 registered
Sep 13 16:40:58 localhost kernel: Bluetooth: SCO (Voice Link) ver 0.6
Sep 13 16:40:58 localhost kernel: Bluetooth: SCO socket layer initialized
Sep 13 16:40:58 localhost bluetoothd[1651]: HCI dev 0 up
Sep 13 16:40:58 localhost bluetoothd[1651]: Starting security manager 0
Sep 13 16:40:58 localhost bluetoothd[1651]: Parsing
/etc/bluetooth/serial.conf failed: No such file or directory
Sep 13 16:40:58 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
Sep 13 16:40:58 localhost kernel: Bluetooth: RFCOMM socket layer initialized
Sep 13 16:40:58 localhost kernel: Bluetooth: RFCOMM ver 1.11
Sep 13 16:40:58 localhost bluetoothd[1651]: Adapter
/org/bluez/1647/hci0 has been enabled
Sep 13 16:42:01 localhost bluetoothd[1651]: link_key_request
(sba=00:22:68:EB:F8:5D, dba=00:0B:E4:94:31:9D)
Sep 13 16:42:02 localhost bluetoothd[1651]: link_key_request
(sba=00:22:68:EB:F8:5D, dba=00:0B:E4:94:31:9D)
Sep 13 16:42:04 localhost bluetoothd[1651]: Badly formated or
unrecognized command: AT+CSRSF=1,1,1,1,1,7
Sep 13 16:42:48 localhost bluetoothd[1651]: seid 2 not available or locked
Sep 13 16:42:48 localhost bluetoothd[1651]: seid not opened

No idea if this is due to a bad configuration or a bad headset...
I also see a bunch of bt-usb messages, not sure if this is related

Sep 13 16:40:51 localhost kernel: usbcore: registered new interface driver btusb
Sep 13 16:41:01 localhost kernel: btusb_intr_complete: hci0 urb
f3ff1b00 failed to resubmit (1)
Sep 13 16:41:01 localhost kernel: btusb_bulk_complete: hci0 urb
f3ff1980 failed to resubmit (1)
Sep 13 16:41:01 localhost kernel: btusb_bulk_complete: hci0 urb
f3ff1780 failed to resubmit (1)
Sep 13 16:42:08 localhost kernel: btusb_intr_complete: hci0 urb
f21c0180 failed to resubmit (1)
Sep 13 16:42:08 localhost kernel: btusb_bulk_complete: hci0 urb
f21c0b00 failed to resubmit (1)
Sep 13 16:42:08 localhost kernel: btusb_bulk_complete: hci0 urb
f21c0000 failed to resubmit (1)
Sep 13 16:42:18 localhost kernel: btusb_intr_complete: hci0 urb
f0eb2180 failed to resubmit (1)
Sep 13 16:42:18 localhost kernel: btusb_bulk_complete: hci0 urb
f0eb2a80 failed to resubmit (1)
Sep 13 16:42:18 localhost kernel: btusb_bulk_complete: hci0 urb
f0eb2100 failed to resubmit (1)
Sep 13 16:42:40 localhost kernel: btusb_intr_complete: hci0 urb
f0d99900 failed to resubmit (1)
Sep 13 16:42:40 localhost kernel: btusb_bulk_complete: hci0 urb
f0d99780 failed to resubmit (1)
Sep 13 16:42:40 localhost kernel: btusb_bulk_complete: hci0 urb
f0d99f00 failed to resubmit (1)
Sep 13 16:42:50 localhost kernel: btusb_intr_complete: hci0 urb
f0d82000 failed to resubmit (1)
Sep 13 16:42:50 localhost kernel: btusb_bulk_complete: hci0 urb
f0d82e00 failed to resubmit (1)
Sep 13 16:42:50 localhost kernel: btusb_bulk_complete: hci0 urb
f0d82200 failed to resubmit (1)

Thanks for your feedback,
-Pierre
