Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Not set name from main.conf
Reply-To: ProklovAV@mail.zabtrans.ru
To: linux-bluetooth@vger.kernel.org
Message-ID: <59A504D3.6070809@mail.zabtrans.ru>
Date: Tue, 29 Aug 2017 14:08:19 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hello All,

I set name in main.conf file, in log bluetoothd i see:
> bluetoothd[25627]: src/main.c:parse_config() name=PuppyBT
> bluetoothd[25627]: src/adapter.c:btd_adapter_new() System name: PuppyBT

and later in the log:

> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Name: PuppyBT
> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Short name:
> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Current alias: PuppyBT
> bluetoothd[25627]: plugins/hostname.c:property_changed() static hostname: pra
> bluetoothd[25627]: plugins/hostname.c:property_changed() pretty hostname:
> bluetoothd[25627]: plugins/hostname.c:update_name() name: pra
> bluetoothd[25627]: src/adapter.c:adapter_set_name() name: pra
> bluetoothd[25627]: src/adapter.c:adapter_set_name() alias: pra
> bluetoothd[25627]: src/adapter.c:set_name() sending set local name command for index 0
> bluetoothd[25627]: plugins/hostname.c:property_changed() chassis: laptop
> bluetoothd[25627]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Name: pra
> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Short name:
> bluetoothd[25627]: src/adapter.c:local_name_changed_callback() Current alias: pra

How to correctly set the device name?


Bluez version 5.45

---------------------
Best regards,
Aleksandr Proklov
