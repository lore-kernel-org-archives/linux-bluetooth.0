Return-Path: <cyrus@holtmann.org>
Message-ID: <59774.86.105.94.79.1413974113.squirrel@boosthardware.com>
Date: Wed, 22 Oct 2014 21:35:13 +1100 (EST)
Subject: rtk_btusb issues
From: "Patrick Shirkey" <pshirkey@boosthardware.com>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have an android device running the rtk_btusb driver. The original driver
was a couple of years old and there was a problem with stability with BLE.
In addition the localname was not found in the scan_response data.

I upgraded the bluetooth stack by manually backporting from a recent
kernel. That fixed the issue wit the scan_repsonse data but there were
still stability issues with BLE devices (although slightly improved
compared to the older bluetooth stack).

I have tried upgrading the driver to the latest version of the rtk_btusb
driver from the git repo and ported the hooks for bluedroid from the old
driver however I get issues with hci send command when loading the driver.

http://pastebin.com/hXALmXBr

I traced the command but I am not sure where the send value is generated.
I can see the function definition in the hci_dev struct but not the
location where the value is actually set.

I thought it might be an issue specific to bluedroid so I installed bluez
but the issue is still there so it appears to be a bug in my version of
the driver or something wrong with the bluetooth kernel layer.

I went back to the older version of the driver running against  bluez
instead of bluedroid. That gets me further along but I still cannot
initialise the bluetooth system on the device.

http://pastebin.com/HcSZXiMu

Does anyone have any suggestions for how to go about resolving this
situation I have got myself into?



--
Patrick Shirkey
Boost Hardware Ltd
