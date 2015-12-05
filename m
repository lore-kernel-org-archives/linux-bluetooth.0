Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Steve Abner <pheonix.sja@att.net>
Subject: bluez iphone connection
Message-ID: <5662D1DF.4000601@att.net>
Date: Sat, 5 Dec 2015 07:00:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I'm end user on both ubuntu 15.10, and LFS with 
kdbus,systemd-227,4.2 kernel.
I've connected both systems to iphone, but with big song and dance. 
First connected
to ubuntu, worked. Boot into LFS, use bluetoothctl, finally get it to 
connect.  Go back to
ubuntu, must delete, use bluetoothctl remove, start process over, 
finally get connected.
Boot LFS, cp over "info" as have done with trackpad. This cp is only 
work around I've found
so that you dont have to reset and start from scratch when rebooting. 
But I didn't
try to remove iphone and restart whole 30 min connection process on LFS. 
Go back
to ubuntu and it just refuses to connect, did not request new pairing on 
purpose, that's why
didn't attempt dance on LFS.
   Both systems I get:
Bluetooth: Unexpected continuation frame (len 0)
connect error: Too many levels of symbolic links (40)
   Honestly forget which applies to connection from pc to phone, vs. 
phone to pc.
If someone could direct me to documentation, which I cant find through 
web searching,
or answer this, I'd be thankful. Hopefully, an automated process for end
users to simply connect to devices, would be nice.
   Apologies if wrong list, but only one that I found on bluetooth, linux.
Steve

