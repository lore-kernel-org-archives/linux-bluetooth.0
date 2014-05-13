Return-Path: <cyrus@holtmann.org>
From: Amith Raghunath <Amith.Raghunath@LNTTECHSERVICES.COM>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Wins Thomas <Wins.Thomas@LNTTECHSERVICES.COM>
Subject: FW: Query regarding BLE communication between 2 Dual Mode devices
Date: Tue, 13 May 2014 04:41:02 +0000
Message-ID: <86D12A3EE8C39046AB3F026D471074661D23BF85@POCITMSEXMB02.LntUniverse.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Amith Raghunath
Sent: 12 May 2014 08:30
To: linux-bluetooth@vger.kernel.org
Cc: Wins Thomas (Wins.Thomas@LNTTECHSERVICES.COM)
Subject: Query regarding BLE communication between 2 Dual Mode devices

Hi Marcel / Claudio,
   Subject: Query regarding the BLE communication between 2 Dual Mode devices.
   Stack Ver: bluez 5.14 / bluez 5.18.
   Kernel Ver: 3.10

   I am trying to establish BLE connection between 2 dual mode devices using bluez at both the sides.
   The Classic connection gets established, but BLE connection does not happen
   (--experimental flag is enabled while running the configure script to include BLE modules & the bluetoothd log indicates that the relevant BLE modules are loaded).
   I am communicating with Bluez stack via D-BUS interface.

   It will be of great help if you can provide answers to my below queries. I am trying to find a solution to this.
       1.  Is this a known issue or a new issue ?
       2.  If I want to add a commit (patch) to the bluez git what is the procedure ?

Thanks,
Amith

L&T Technology Services Ltd

www.LntTechservices.com<http://www.lnttechservices.com/>

This Email may contain confidential or privileged information for the intended recipient (s). If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
