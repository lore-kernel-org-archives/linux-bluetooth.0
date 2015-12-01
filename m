Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 1 Dec 2015 11:03:26 +0100
Message-ID: <CAEZxfGMGixpTkyyc_dyR+NuzGo_wuns9b=y8_A4TWvvve6xFXQ@mail.gmail.com>
Subject: Is the GattServices property still updated?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm not sure to understand what is happening and I'd love your help there.

Is the "GattServices" device property still supposed to be updated
once all remote GATT services of the device
have been discovered and exported over D-Bus as mentioned in
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt#n215

If so, does this DBUS messages trace looks good to you:
http://pastebin.com/emxWB4w1?
