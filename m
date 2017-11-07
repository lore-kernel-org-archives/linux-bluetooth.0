Return-Path: <chiu@endlessm.com>
MIME-Version: 1.0
From: Chris Chiu <chiu@endlessm.com>
Date: Tue, 7 Nov 2017 12:42:36 +0800
Message-ID: <CAB4CAwc9GiF9EdzoZ2wUxvXqaB1y97-7UuitaQV9h2poiXXE3A@mail.gmail.com>
Subject: Bluetooth is not working on Intel new wifi/bt module 9462NGW
To: johannes.berg@intel.com, marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
    We just have the Intel new WiFi/BT module 9462NGW from Acer and
tried to verify if it works on the latest linux kernel. The BT is not
working because of the missing firmware.

[   18.249144] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[   18.250036] Bluetooth: hci0: Device revision is 2
[   18.250037] Bluetooth: hci0: Secure boot is enabled
[   18.250038] Bluetooth: hci0: OTP lock is disabled
[   18.250038] Bluetooth: hci0: API lock is enabled
[   18.250039] Bluetooth: hci0: Debug lock is disabled
[   18.250040] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   18.293902] bluetooth hci0: Direct firmware load for
intel/ibt-17-2.sfi failed with error -2
[   18.293907] Bluetooth: hci0: Failed to load Intel firmware file (-2)

I'm not able to find these missing files in linux-firmware.git and any
other possible place. What's the status of supporting this 9462NGW?
Please let me know if any more information required. Thanks

Chris
