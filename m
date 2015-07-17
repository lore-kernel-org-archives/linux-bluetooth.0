Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 17 Jul 2015 18:46:27 +0800
Message-ID: <CAKc24n3nLkHG8q7SfgUU--xfyx1hHqz8E2sVyXcVaKnpZ6setA@mail.gmail.com>
Subject: Android-x86 Bluez integration
From: Chih-Wei Huang <cwhuang@android-x86.org>
To: Android-x86 <android-x86@googlegroups.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
As you have probably noticed, the Bluez 5.32 was
integrated to kitkat-x86 to replace bluedroid stack
as a part of the Android-x86 4.4-r3 release.
Many thanks to the Bluez team to make this possible
and Povilas Staniulis / cheatman pointed me
the direction.

I've tested all the devices with Bluetooth chip I have.
Almost all of them work nice.
It's much more stable and usable than before.
I'm very satisfied with the status.

If you have HCI USB based chip with
correct linux driver and firmware,
the 4.4-r3 release should just work for you.
If not, show me the output of
dmesg, lsmod, logcat and hciconfig.

If you have HCI UART bluetooth device,
you may need to configure the UART port
by hciattach or similar tool.
Read the init_hal_bluetooth function of
device/generic/x86/init.sh and see the
T10*TA section as an example.
Send me a patch if you have configured it
successfully.

Known issues:
* Bluetooth in ASUS T100 is still unstable:
  Sometimes can't scan any device.
  Can pair a Bluetooth speaker but can't play audio.
  Probably a driver or firmware issue?

I'll update the lollipop-x86 for the
Bluez integration later.

-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
