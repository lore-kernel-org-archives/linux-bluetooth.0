Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Jacek Chmiel <jacek@kontakt.io>
Subject: LE connection fails on kernel 3.10
Message-ID: <c9a5b22d-db06-9f18-4add-aa8820721687@kontakt.io>
Date: Thu, 16 Feb 2017 12:19:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm creating a device (ARM based) that will be a BLE Peripheral with a 
GATT Server. There is a problem when I try to connect and discover 
services using an Android phone.

The issue is experienced on kernel 3.10. I'm using Bluez release 5.43 
but the issue exists also in earlier versions. (I've checked 5.37). When 
I'm testing this on desktop with kernel 4.2 everything works correctly.

When Android device tries to establish LE connection and discover GATT 
database, there is no response for Read By Group request.

Here's hcidump log from the connection attempt:
 > HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 0, role slave
       bdaddr 47:09:3C:EA:A9:73 (Random)
 > ACL data: handle 0 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
 > HCI Event: LE Meta Event (0x3e) plen 10
     LE Connection Update Complete
       status 0x00 handle 0
       interval 7.50ms, latency 0.00ms, superv. timeout 20000.00ms
 > ACL data: handle 0 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
 > ACL data: handle 0 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 0 reason 0x13
     Reason: Remote User Terminated Connection

After some investigation I noticed that there are two events in bluez 
log caused by this connection. I guess that these events are related to 
LE Connection Request and Service Discovery. The problem is that in the 
former event the addr_type is one of LE types and in the latter it is 
BREDR and the device  not found on the adapter's device list.

I've modified bluez debug to include address_type in log As you can see 
the addr_type differs in adapter.c:connected_callback() and 
gatt-database.c:connect_cb(). I've also confirmed that when using kernel 
4.2 both addr_type values are the same.

bluetoothd[20787]: src/adapter.c:trigger_passive_scanning()
bluetoothd[20787]: src/adapter.c:connected_callback() hci0 device 
70:8D:40:D2:34:E3 connected eir_len 0
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() 
btd_adapter=000e66c8 addr=000e57d6 addr_type=2
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() Looking for 
device 70:8D:40:D2:34:E3 addr_type 2
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() Creating device
bluetoothd[20787]: src/device.c:device_create() dst 70:8D:40:D2:34:E3 
bdaddr_type 2
bluetoothd[20787]: src/device.c:device_new() address 70:8D:40:D2:34:E3
bluetoothd[20787]: src/device.c:device_new() Creating device 
/org/bluez/hci0/dev_70_8D_40_D2_34_E3
bluetoothd[20787]: src/gatt-database.c:connect_cb() New incoming BR/EDR 
ATT connection
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() 
btd_adapter=000e66c8 addr=bef30c20 addr_type=0
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() Looking for 
device 70:8D:40:D2:34:E3 addr_type 0
bluetoothd[20787]: src/adapter.c:dbg_device() addr: 70:8D:40:D2:34:E3
bluetoothd[20787]: src/adapter.c:btd_adapter_get_device() Creating device
bluetoothd[20787]: src/device.c:device_create() dst 70:8D:40:D2:34:E3 
bdaddr_type 0
bluetoothd[20787]: src/device.c:device_new() address 70:8D:40:D2:34:E3
bluetoothd[20787]: src/device.c:device_new() Creating device 
/org/bluez/hci0/dev_70_8D_40_D2_34_E3
bluetoothd[20787]: Unable to register device interface for 70:8D:40:D2:34:E3
bluetoothd[20787]: src/device.c:device_free() 0xe9510

I've implemented a hacky workaround for that problem by modifying 
device.c:device_addr_type_cmp() to not take address type into account 
when comparing addresses.

Am I right that this issue could be a kernel problem?
If so, I could stay with my workaround even if it causes any problems 
when handling BREDR connections which I don't need to accept anyway. But 
then my question is:

Is there by any chance a way to disable BREDR functionality at all? I've 
seen some information on that but it seemed to require newer kernel with 
btmgmt interface.

Thank you kindly for your attention,
Jacek Chmiel
