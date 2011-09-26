Return-Path: <cyrus@holtmann.org>
Message-ID: <4E80CB8F.4070600@ahsoftware.de>
Date: Mon, 26 Sep 2011 20:59:27 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: 70-hid2hci.rules and Logitech dongles
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm having a Logitech dongle which identifies itself as 046d:0b02, 
046d:c70b and 046d:c70c and for which only hiddev devices are available 
after startup (when in HID mode).

To use the bluetooth functionality I had to change the rule in 
70-hid2hci.rules from

# Logitech devices
KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[35e]", \
   RUN+="hid2hci --method=logitech-hid --devpath=%p"

to

# Logitech devices
KERNEL=="hiddev*", ATTRS{idVendor}=="046d", 
ATTRS{idProduct}=="c70[35bce]", \
   RUN+="hid2hci --method=logitech-hid --devpath=%p"

After the dongle is in HCI mode, the hiddev device disappears and the 
hidraw devices are appearing.

I'm not sure why there is a rule for hidraw devices in that file too and 
I've just disabled it.

I've first reported it for Fedora ( 
https://bugzilla.redhat.com/show_bug.cgi?id=741247 ) but after having 
seen that those rules are appearing in almost every distribution, I 
thought I should report that upstream (here) too.

Regards,

Alexander
