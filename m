Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Mon, 08 Oct 2012 10:22:11 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth3.0: No HS Speed
Message-ID: <d38b6bd21b40254327824c73f662a4fd@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
When I send datafiles (.mp3, .wav or .avi ; size >10 MB) then it is 
transfered only with Bluetooth-speed (~2MBit/s), and not with 
"Highspeed". I have two Bluetooth 3.0+HS Dongles and also the 
integrated wlan-chip is recognized: "ifconfig displays a wlan-adapter; 
and I don't have any wlan-card or -dongle in my PC, so I think this 
displayed wlan-adapter is the one from the Bluetooth-dongle.

I have a Windows PC with two virtual machines in it: Two Ubuntu12.04 
systems. I inserted the two Bluetooth 3.0+HS dongles in my Windows PC 
and created an USB-filter for each dongle to one Ubuntu system. So as I 
said before, datatransfer via Bluetooth between these two virtual 
Ubuntu systems works fine and also the wlan-adapter is displayed under 
ifconfig - but I only have bluetooth-speed =(

What's the problem?

Regards,
Steffen

