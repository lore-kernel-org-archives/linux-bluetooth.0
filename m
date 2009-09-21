Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2009 12:49:46 +0530
Message-ID: <6887eb5d0909210019n6646cf37q8b9f45041dc1ba3@mail.gmail.com>
Subject: Folder not created (/var/
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI,

I m using Bluez-4.52 cross compiled with ronetix-arm-linux-4.3.3
toolchain on AT91SAM9263.
When I insert bluetooth USB dongle in my system and running command
./hciconfig -a hci0 up it brings up the device.

Then I run my test program that searchs for nearby bluetooth device
and later on as per user's selection it allows voice path after
successful pairng.

My problem is the folder with MAC address name is not created in
/var/lib/bluetooth also bluetoothd logs are not created in
/var/log/messages file.

I don't find any reason why this folder and file is not created on my
board. Because when I run the same application on Linux pc it created
both folder and file of log

Am I missing any setting that prevent folder and file creation on board???

Kindly guide me.
-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
