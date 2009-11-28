Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 28 Nov 2009 11:22:46 +0530
Message-ID: <912bb79a0911272152y6fb12a05p299090e97ac91a54@mail.gmail.com>
Subject: Right way of pairing?
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am newbie to bluetooth world, For pairing I am connecting RFCOM
socket, I can show this connection on /org/bluez/789(pid of
process)/hci0 as dev_00_05_AD_EF_F8_A5 and linkkey information in
linkkeys file. but when I close this RFCOM socket (or when application
kills) all the information regarding the device pairing getting lost.

Is this the right way of pairing ??

I know that API has also available for device pairing, but I want to
use Dbus as less as possible due to the time take by dbus fucntions
calls and also I am not so comfortable with dbus API.

Can anybody suggest me the right way to pair devices?? Is it
compulsory to use DBUS API for pairing OR any other way without using
Dbus API

Your suggestion would be a great help for me.....

-- 
With Regards,
Nirav Rabara
