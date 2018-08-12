Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 12 Aug 2018 17:08:50 +0200
From: Andreas Fink <finkandreas@web.de>
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth poor signal with rtl8723de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <0MOzwh-1fmPPo3In9-006OkD@smtp.web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I have a question regarding coexistence of WiFi and Bluetooth in my notebook. I
have a rtl8723de chipset, which comes together with a bluetooth chip on the card. The
driver is not yet supported by the kernel, but in my understanding, the driver
provided at https://github.com/lwfinger/rtlwifi_new is supposed to be merged at some
point into the kernel.
I'm using that driver for getting the wifi part running, and while the wifi works fine, I
have troubles with the bluetooth part, due to very poor signal.
I have the the following modules all loaded:
rtl8723de             102400  0
rfcomm                 32768  16
btcoexist             454656  1 rtl8723de
phydm_mod             880640  1 rtl8723de
rtl8723_common         24576  1
rtl8723de rtl_pci                36864  1 rtl8723de
rtlwifi               163840  5 rtl_pci,rtl8723de,btcoexist,phydm_mod,rtl8723_common
mac80211              651264  2 rtl_pci,rtlwifi
cfg80211              622592  2 rtlwifi,mac80211
btusb                  45056  0
btrtl                  16384  1 btusb
btbcm                  16384  1 btusb
btintel                20480  1 btusb
bluetooth             393216  38 btrtl,btintel,btbcm,btusb,rfcomm

Both the wifi and bluetooth are neither hard nor soft blocked by rfkill, then the signal
for bluetooth is really poor. That means I can connect to a bluetooth device if it is
lying physically on the notebook, i.e. a distance of 3-4cm seems ok, the bluetooth
connection works. Once I move the bluetooth receiver (headset) further away the
connection is lost.

Soft-blocking the wifi with rfkill the bluetooth signal works as expected (distances of
at least 3m through walls are no problem). Once I unblock the wifi, the bluetooth
connection is lost instantly, and works only in a distance of a couple of centimeters
again.

I reported the problem already on github for rtlwifi_new, but I was told, that you could
maybe provide better help (the original issue is here):
https://github.com/lwfinger/rtlwifi_new/issues/382

I get the following output for `lsusb -s 001:005`:
Bus 001 Device 005: ID 0bda:b009 Realtek Semiconductor Corp.

I'm running kernel-4.17.14.
Any help, what the problem could be is appreciated. If you need further information, let
me know what output can be useful, since I'm out of ideas what else would be helpful.

Cheers
Andreas
