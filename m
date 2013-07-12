Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Jul 2013 22:17:34 +0800 (SGT)
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: bluez-5.x sdptool browse local failed to connect to SDP server
Message-ID: <Pine.LNX.4.64.1307122209580.31230@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


# sdptool browse local
Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or 
directory

I'm on latest commit 57ce0cb4c2ad4b03bc1863255dfc508725cedd84.

bluetoothd started and shows SDP server running ...
2013-07-12T21:49:30.174559+08:00 boston bluetoothd[31175]: Bluetooth 
daemon 5.7
2013-07-12T21:49:30.175370+08:00 boston bluetoothd[31175]: Starting SDP 
server
2013-07-12T21:49:30.175913+08:00 boston bluetoothd[31175]: Bluetooth 
management interface 1.3 initialized


Any help would be greatly appreciated!

Thanks,
Jeff
