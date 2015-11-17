Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Nov 2015 16:56:23 +0800
Message-ID: <CABuKQihPRJFU9yVKbfSu1qTfVA3cjhabJzs4VTDQ82S-Kqa7Yw@mail.gmail.com>
Subject: How to access services on my bluetooth device
From: John WW <wrxzzj@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

    recently, I bought a microsoft bluetooth 4.0 mouse, connect and
work very well on bluez-5.36.

   I found this device have five profile
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)

  How can I access Battery Service, I want to known the battery status.
Is't possible to get the battery status by bluez utils ?

-- 
Thanks
