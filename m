Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20100701152541.031ae7c0@gmx.net>
Date: Thu, 01 Jul 2010 15:33:25 +0200
To: linux-bluetooth@vger.kernel.org
From: Peter Kornatowski <pkorn@gmx.net>
Subject: Bug with Alias
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have several headsets of the same model, so I set an Alias for each 
to distinguish them in my own application. But since bluez 4.64 the 
Alias is bugged. Sometimes after a reboot or after a bluez restart 
when i read out the Alias through the dbus api, I get the Name 
instead. I also tried to read it with d-feet or through a dbus-send 
call (dbus-send --system --print-reply --dest=org.bluez 
/org/bluez/11344/hci0/dev_00_XX_XX_XX_XX_XX 
org.bluez.Device.GetProperties) and also got the Name instead of the 
Alias. But in the aliases file under 
/var/lib/bluetooth/XX:XX:XX:XX:XX:XX/aliases is the correct Alias. 
The bug seems to have something to do with the commit 
48a2c31cdbc1f2ac2a2bbadbd505976f84a9eaca 
(http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=48a2c31cdbc1f2ac2a2bbadbd505976f84a9eaca).
I hope someone can resolve this issue.

Thanks,
Peter

