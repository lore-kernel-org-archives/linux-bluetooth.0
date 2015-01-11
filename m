Return-Path: <cyrus@holtmann.org>
Message-ID: <54B272A8.4000105@farce.de>
Date: Sun, 11 Jan 2015 21:55:04 +0900
From: Stefan Wiehler <sephalon@farce.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Replacement for rfcomm.conf
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody,

I recently added a Bluetooth dongle to a RS232 device to get readouts
from a remote location. This is working fine as long as I execute
"rfcomm bind" after each restart.

However, when I wanted to automate this process by using a rfcomm.conf
file as suggested by several guides on the web [1], I realized that the
corresponding code has been removed from the rfcomm tool several years
ago [2].

I tried to use udev as a replacement by writing a rule which executes
rfcomm after pairing, but it seems like sysfs does not expose
information about coupled devices (udevadm info -a -p
/sys/class/bluetooth/hci0).

Is it possible to solve that problem using udev? Or are there any other
best practices? Thank you for your consideration.

Kind regards,

Stefan Wiehler

[1] http://askubuntu.com/a/252235
[2] 
http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=5bec57420bd57f86d61b2919450d182f3407facf
