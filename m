Return-Path: <cyrus@holtmann.org>
Message-ID: <529B7153.2060204@ahsoftware.de>
Date: Sun, 01 Dec 2013 18:26:43 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Add empty udev rule to disable hid2hci by default
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

Almost every distribution gets it wrong and enables hid2hci by default 
(besides Fedora where I already intervened twice).

This is a real problem, because it disables Bluetooth keyboards and/or 
mice which aren't paired with bluez, thus many Live-CDs and default 
installs aren't usable when only a Bluetooth keyboard is connect.

An easy solution to disable that behaviour would be to install an empty 
rule in /etc/udev/rules.d named the same as the one in 
/lib/udev/rules.d. It could just contain a comment like

# Delete this file in order to activate hid2hci.
#
# You might need to pair your Bluetooth keyboard and/or mouse
# in order to still use it when hid2hci is enabled.

This (empty) rule would then be used by udev instead of the one in 
/lib/udev/rules.d and thus would be an easy to use configuration switch.

I would appreciate it, if the default bluez install would install such 
an empty rule too, if configure was called with --enable-hid2hci.

I think otherwise that problem will never go away. It's really 
unbelievable how many distributions got this wrong and thus how many 
Live-CDs and default installations are unusable when only a Bluetooth 
keyboard is used with a hid-aware Bluetooth dongle.

Regards,

Alexander Holler
