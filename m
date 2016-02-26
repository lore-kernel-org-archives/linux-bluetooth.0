Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 26 Feb 2016 20:23:37 +0100
From: Oscar C <oscar-listas@naiandei.net>
To: <szymon.janc@gmail.com>, <linux-bluetooth@vger.kernel.org>
Cc: <oscar@naiandei.net>
Subject: sixaxis: Improved support for DualShock 3 clones not working
 (undefined symbol)
Message-ID: <323cb9a32683f9af27f299d84d928986@naiandei.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I tried the patches sent to the list on June 2015 regarding the DS 
clones made by ShanWan. That patches are necessary because the DualSock 
clones do not work with the current sixaxis plugin.

It compiles ok, but when I try to run the daemon it fails because a 
symbol can not be found. Of course, the same code but without the 
patches applied works fine (but the gamepad does not work).

Any idea on how to solve this? Thanks!


gardenia:/root # /usr/lib/bluetooth/bluetoothd -n -d 9
bluetoothd[5943]: Bluetooth daemon 5.37
bluetoothd[5943]: Starting SDP server
bluetoothd[5943]: Can't load plugin 
/usr/lib/bluetooth/plugins/sixaxis.so: 
/usr/lib/bluetooth/plugins/sixaxis.so: undefined symbol: sdp_data_alloc
bluetoothd[5943]: Bluetooth management interface 1.6 initialized

--
Cheers,
