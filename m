Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Subject: Bluetooth keyboard not working in combination with CSR btusb devices
Message-ID: <a4b34893-6ba7-32e2-2226-3bb177bef070@redhat.com>
Date: Mon, 8 Jan 2018 10:50:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

While testing some bluetooth stuff I noticed that a cheap
clone BT USB keyboard I have, with a vid:pid of: 04E8:7021
and described as "ULAK" in its strings, will not work when
combined with a CSR btusb dongle.

I've 2 CSR dongles both a fake and a real one, and interestingly
enough it shows the same behavior with both.

I can pair the keyboard and if I type something real quick after
pairing it works, but as soon as I let it idle for say 0.5 seconds
it stops working.

I've the feeling that the problem is that the CSR dongles are quite
old and only support a subset of modern bluetooth and that the
keyboard decides to switch to some low-power link mode which the
CSR dongle does not understand and then the connection breaks.

I also see the gnome BT status icon go away after a while and
then come back again after a couple of seconds (don't remember
if the coming back only happened after pressing a key on the
keyboard or not), as if the broken link gets noticed after a
while and then a reconnect is done, only for the link to break
almost directly again.

I think this is probably just a bug in the keyboard where it
fails to work properly with older bluetooth hosts, but if anyone
has any suggestions to try and fix this I can give a patch a try.

Regards,

Hans
