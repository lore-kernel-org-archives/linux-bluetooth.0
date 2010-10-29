Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 29 Oct 2010 10:41:14 +0200
Message-ID: <AANLkTikFbjk8Siva51=zH=KbYE_kkFpqRAqCbyphgEBU@mail.gmail.com>
Subject: btusb Headset Microphone not working
From: Michael Kopp <mikopp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I upgraded my notebook recently and as of now the headset microphone
is not working anymore. When trying arecord no data is being recorded.
I already tried several versions of bluez up and to including 4.75
with kernels 2.6.32, 2.6.34 2.6.35, no joy.

I get the following error in dmesg

btusb_submit_isoc_urb: hci0 urb f359fe00 submission failed (28)
btusb_submit_isoc_urb: hci0 urb f5f37200 submission failed (28)

/var/log/messages reveals a little more


ct 29 08:40:54 mkopp bluetoothd[5751]: link_key_request
(sba=1C:65:9D:02:DE:E0, dba=00:16:94:09:DB:88)
Oct 29 08:40:54 mkopp bluetoothd[5751]: link_key_request
(sba=1C:65:9D:02:DE:E0, dba=00:16:94:09:DB:88)
Oct 29 08:40:57 mkopp kernel: input: 00:16:94:09:DB:88 as
/devices/virtual/input/input16
Oct 29 08:42:21 mkopp kernel: btusb_submit_isoc_urb: hci0 urb f359fe00
submission failed (28)
Oct 29 08:43:28 mkopp bluetoothd[5751]: No matching connection found
for handle 6
Oct 29 08:45:28 mkopp kernel: btusb_submit_isoc_urb: hci0 urb f5f37200
submission failed (28)
Oct 29 08:45:50 mkopp bluetoothd[5751]: No matching connection found
for handle 6
Oct 29 08:49:19 mkopp kernel: input: 00:16:94:09:DB:88 as
/devices/virtual/input/input17
Oct 29 08:49:20 mkopp bluetoothd[5751]: Disconnected from
00:16:94:09:DB:88, /org/bluez/5751/hci0/dev_00_16_94_09_DB_88


Audio output works for both AD2P and SCO, input works on neither
although the headset supports it and works on my cell phone.

my .asoundrc is as simple as it gets

pcm.bluetooth {
   type bluetooth
   device "00:16:94:09:DB:88"
   profile "voice"
}

I've tried google and all sorts of forums but although I've seen this
error several times I was not able to find a solution. I would be
grateful if somebody could point me towards a solution.

Best regards
Michael Kopp
