Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Egbert van der Wal <ewal@pointpro.nl>
Subject: Configuring a Bluetooth PAN server: can't find docs
Message-ID: <56FE6EFA.5060406@pointpro.nl>
Date: Fri, 1 Apr 2016 14:52:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Short story: I'd really like to RTFM, but in all of my online quests I 
can't find where it is. Where can I find documentation about bluez, 
configuration files and pand?

With a bit more information: I'm trying to configure a device (Odroid 
XU4 running Ubuntu 14.04, using Bluez 4.101) to accept PAN-connections. 
Doing this I want to provide the connecting user with a web interface to 
perform some configuration tasks (such as connecting to a wifi).

The resulting connection will not provide internet access and will only 
be used to expose access to an internal IP address (e.g. 10.0.0.1). I 
want the device to basically accept any pairing request using a fixed, 
pre-configured pin-code.

I've been trying to get this working for a while now using various 
howto's but it seems to me that each and every one of them uses a 
different way to configure Bluez, probably resulting from a different 
version. I basically tried all of them and none seem to work (due to 
missing / invalid commands or missing / ignored configuration files).

I couldn't find any documentation on bluez.org itself. The bluetoothd 
man-page refers to a man-page of /etc/bluetooth/main.conf that doesn't 
seem to exist, and the contents of /etc/bluetooth/main.conf also seem to 
be ignored so I'm quite stuck here.

Any pointers to any type of documentation that covers my version of 
bluez and the steps to set this up would be highly appreciated.

Thanks in advance!

Regards,

Egbert

