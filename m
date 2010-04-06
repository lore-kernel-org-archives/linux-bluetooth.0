Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 6 Apr 2010 18:23:26 +0530
Message-ID: <g2p912bb79a1004060553kdec12987gc9c957506b436c1e@mail.gmail.com>
Subject: Question regarding HS Connection
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using Bluez-4.62 on ARM platform, I am using USB Bluetooth
dongle, I use bluez api for the connection and disconnection, I have
strange problem with HS connection.
1) I paired dongle with HS, So now whenever I use Dbus API to get
paired device list I get device as paired device.
2) After that I creat connection to HS, this time I am able to
connect/disconnect with HS. (working)
3) Now I connect HS to some other devices( mycellphone1 then
cellphone2, cellphone3 etc).
4) After that whenever I try to connect with HS, it show me below message.
bluetoothd[410] Unable to get service record: Operation already in progress(114)
-> According to me - This HS is trying to connect with last connected
device with it, and because of this reason it not get connected.

My question is if such the case than how to connect with HS?

Any suggestion would be appreciable.
-- 
With Regards,
Nirav Rabara
