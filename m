Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 6 Feb 2016 20:30:40 +0000
Message-ID: <CAAu3APaeS_7xnuTW_JgdJKkAcfY1x4zU=3VxTkSHqEZYsSkY_A@mail.gmail.com>
Subject: Error 133 (0x85): GATT ERROR
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to get the Raspberry Pi to advertise itself as a peripheral
so I've started by taking the example-gatt-server and
example-advertisement to get something running.

The code I have running can be found at:
https://github.com/ukBaz/python-bluezero/blob/master/examples/battery_service.py

When I run the above code with Bluez 5.37 then I can connect and read
values from it on another Raspberry Pi using bluetoothctl.
However when I try to connect with various apps on my phone then I'm
not able to successfully connect.
On the Nordic nRF Master Control Panel (BLE) app I can see in the log
'Error 133 (0x85): GATT ERROR)' I've done various searches on this
error message but nothing actionable has turned up.

Any suggestions as to what is wrong?

Thanks,
Barry
