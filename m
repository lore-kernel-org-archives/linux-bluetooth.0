Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Nov 2008 03:23:55 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: <linux-bluetooth@vger.kernel.org>, npelly@google.com, marcel@holtmann.org
Message-ID: <1026773358.244421227304435724.JavaMail.root@mbv7.indiatimes.com>
Subject: Place-Holder for a driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

The OMAP Zoom2 board has a bluetooth chip which needs to be enabled to be used. When running on Android, the Bluetooth service of Android uses the rfkill sysfs entry to turn on bluetooth.

So I linked the Bluetooth enable GPIO to the sys-fs entry, Now the question is where should/does this driver fit in ?

I've thought of drivers/misc, Any suggestions are welcome.

Thanks & Regards,
Pavan Savoy.


--
The New Maruti A-Star is here. View pics, videos, read expert opinion and more on ZigWheels.com
http://images.zigwheels.com/b2cam/a_star.html
