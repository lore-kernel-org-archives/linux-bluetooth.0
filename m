Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: BLE connection failing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com>
Date: Mon, 12 May 2014 18:27:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9ED33F2C-C3EF-41D7-8559-C04F1E6CE21D@holtmann.org>
References: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com>
To: Rick Mann <rmann@latencyzero.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rick,

> I've gotten a little closer to my goal of creating a BLE peripheral with BlueZ.
> 
> I run bluetoothd -d -E -n, get some logging, ending with:
> 
>> ...
>> bluetoothd[676]: ../src/adapter.c:trigger_passive_scanning() 
>> bluetoothd[676]: ../src/adapter.c:new_settings_callback() Settings: 0x000002d1
>> bluetoothd[676]: ../src/adapter.c:settings_changed() Changed settings: 0x00000010
>> bluetoothd[676]: ../src/adapter.c:new_settings_callback() Settings: 0x000002d3
>> bluetoothd[676]: ../src/adapter.c:settings_changed() Changed settings: 0x00000002
>> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() Name: linaro-developer
>> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() Short name: 
>> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() Current alias: linaro-developer
>> bluetoothd[676]: ../src/attrib-server.c:attrib_db_update() handle=0x0006
> 
> Then I connect from the BLE Tool app on an iPad:
> 
>> bluetoothd[676]: ../src/adapter.c:connected_callback() hci0 device 7D:F1:8F:C5:9D:14 connected eir_len 0
>> bluetoothd[676]: ../src/device.c:device_create() dst 7D:F1:8F:C5:9D:14
>> bluetoothd[676]: ../src/device.c:device_new() address 7D:F1:8F:C5:9D:14
>> bluetoothd[676]: ../src/device.c:device_new() Creating device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
>> bluetoothd[676]: ../src/device.c:btd_device_set_temporary() temporary 1
>> bluetoothd[676]: ../src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14 is not on the list, ignoring
>> bluetoothd[676]: ../src/attrib-server.c:connect_event() 
>> bluetoothd[676]: ../src/device.c:device_create() dst 7D:F1:8F:C5:9D:14
>> bluetoothd[676]: ../src/device.c:device_new() address 7D:F1:8F:C5:9D:14
>> bluetoothd[676]: ../src/device.c:device_new() Creating device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
>> bluetoothd[676]: Unable to register device interface for 7D:F1:8F:C5:9D:14
>> bluetoothd[676]: ../src/device.c:device_free() 0x156a20
>> bluetoothd[676]: ../src/adapter.c:dev_disconnected() Device 7D:F1:8F:C5:9D:14 disconnected, reason 2
>> bluetoothd[676]: ../src/adapter.c:adapter_remove_connection() 
>> bluetoothd[676]: ../src/adapter.c:adapter_remove_connection() Removing temporary device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
>> bluetoothd[676]: ../src/device.c:device_remove() Removing device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
>> bluetoothd[676]: ../src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
>> bluetoothd[676]: ../src/device.c:device_free() 0x156d58
>> bluetoothd[676]: ../src/adapter.c:bonding_attempt_complete() hci0 bdaddr 7D:F1:8F:C5:9D:14 type 2 status 0xe
>> bluetoothd[676]: ../src/adapter.c:resume_discovery() 
> 
> At this point, advertising is turned off and I can't re-connect until I turn it back on, after which the process just repeats.
> 
> Any idea why I can't make that connection? What does "Unable to register device interface for 7D:F1:8F:C5:9D:14" mean?

kernel 3.13 and later have support for Set Advertising mgmt command. That is what you should be using. Just issue “btmgmt advertising on”.

Regards

Marcel

