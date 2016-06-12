Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: GATT Server example
Message-ID: <6c8e3d32-f9db-c5bc-5163-28705289ae44@gmail.com>
Date: Sun, 12 Jun 2016 13:41:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
how to use the example-gatt-server?
Launching it will print:

> GetManagedObjects
> GATT application registered
> Battery Level drained: 98
> Battery Level drained: 96
> Battery Level drained: 94

but from my smartphone I cannot find any BLE device.
As far as I understand this example should show how to "fake" a battery 
level and heartrate standard profiles, and also a custom test service.

It should advertise, acting as a peripheral unit, in order to be 
connected from a central one (smartphone).

Am I wrong?
