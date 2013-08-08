Return-Path: <cyrus@holtmann.org>
Message-ID: <41942.172.16.2.1.1375965758.squirrel@gesmail.globaledgesoft.com>
Date: Thu, 8 Aug 2013 18:12:38 +0530 (IST)
Subject: Gatt Thermometer Server Support
From: ajay.kv@globaledgesoft.com
To: linux-bluetooth@vger.kernel.org
Cc: anderson.lizardo@openbossa.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
As i am experimenting the BlueZ BLE features. I have some query. I am
using 2 Linux Ubuntu 12.04 Desktop with linux-3.10 kernel and Bluez-5.7
configured with #./configure --enable-experimental

Server_System:
     Enabled ThermometerManager->RegisterWatcher (d-feet
application).
     #hciconfig 0 leadv

Client_System:
     #gatttool -I
     [                 ][LE]>
     [00:02:72:D6:97:79][LE]> connect 00:02:72:D6:97:79
     Attempting to connect to 00:02:72:D6:97:79
     Connection successful

     [00:02:72:D6:97:79][LE]> primary
     attr handle: 0x0001, end grp handle: 0x0008 uuid:
00001800-0000-1000-8000-00805f9b34fb
     attr handle: 0x0009, end grp handle: 0x000b uuid:
00001803-0000-1000-8000-00805f9b34fb
     attr handle: 0x000c, end grp handle: 0x000f uuid:
00001804-0000-1000-8000-00805f9b34fb
     attr handle: 0x0010, end grp handle: 0x0010 uuid:
00001801-0000-1000-8000-00805f9b34fb
     attr handle: 0x0011, end grp handle: 0x0013 uuid:
00001802-0000-1000-8000-00805f9b34fb
     attr handle: 0x0014, end grp handle: 0x0019 uuid:
00001805-0000-1000-8000-00805f9b34fb
     attr handle: 0x001a, end grp handle: 0x001e uuid:
00001806-0000-1000-8000-00805f9b34fb
     attr handle: 0x001f, end grp handle: 0x0027 uuid:
0000180e-0000-1000-8000-00805f9b34fb
     attr handle: 0x0028, end grp handle: 0x0034 uuid:
00001811-0000-1000-8000-00805f9b34fb

    Here we could not find the UUID for Thermometer(1809) and heartrate ,
which we are interested to debug more.

Query:
How to set the dummy temperature or heartrate values in the server and
to get them in the Client.?


Thanks in Advance,
Ajay K V

