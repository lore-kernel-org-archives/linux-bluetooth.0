Return-Path: <cyrus@holtmann.org>
From: <erik.linder@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Thu, 21 Jul 2011 00:52:27 +0200
Subject: 103, 'Software caused connection abort'
Message-ID: <D5524B0DB6E8224893F1EDBF5C2402D481CFCAE255@EMEXM3123.dir.svc.accenture.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
This problem has been causing problems for quite some time now with numerous bluez and kernel version .

I'm using a bluetooth dongle to run a serial connection on top and the result is quite unstable: it can crash up to 10-20 times a day. The only work around is to unplug and replug the dongle (or reboot the system, sic). Hciconfig hci0 reset helps sometimes. I tried to reset the usb device and the entire bus without any success.

I caught the script outputting a couple of times:
Traceback (most recent call last):
  File "/usr/local/ /serial.py", line 46, in <module>
    charout = sock.recv(1)
  File "<string>", line 5, in recv
bluetooth.btcommon.BluetoothError: (103, 'Software caused connection abort')

and hciconfig hci0 reset when the dongle is crashed returns Can't init device hci0: Connection timed out (110)

I noticed tonight that reception might have an influence (need to test further). Poor reception could be increasing the frequency of crashes: the signal have to cross 2 doors if they are closed.

hcitool lq <mac> gives me around 13-15 with open doors and 6-9 with doors closed:

BTW the problem looks worse with the current kernel and bluez version which I'm using

root@:/ # uname -a
Linux 2.6.38-voyage #1 SMP PREEMPT Fri Jun 24 01:46:28 GMT 2011 i586 GNU/Linux
root@:/ # dpkg -l | grep bluez
ii  bluez                              4.94-2                       Bluetooth tools and daemons
ii  bluez-utils                    4.94-2                       Transitional package
ii  python-bluez             0.18-1+b2                Python wrappers around BlueZ for rapid bluetooth development



any ideas how to fix the problem  or to troubleshoot?

cheers
Erik

This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.

