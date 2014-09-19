Return-Path: <cyrus@holtmann.org>
Message-ID: <541C95E5.5020202@mlsw.biz>
Date: Fri, 19 Sep 2014 16:45:25 -0400
From: Nathan Jozwiak <njozwiak@mlsw.biz>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Unable to see descriptor created from gatt-service application
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have built bluez-5.23 into my Ubuntu 14 system and am having issues 
customizing the GATT server running on it. My GATT client is another 
Ubuntu 14 system and I am using the gatttool utility to connect and 
perform operations.

I am running the tools/gatt-service sample (unmodified) that is built 
with the bluez package. My goal is to see the R/W descriptor that is 
added to the Immediate Alert Service (IAS UUID 0x1802) by this 
application from the GATT client and perform both read and write 
operations with it. This will be a base-line for creating a full custom 
service for my specific application development.

Running the gatt-service application appears to successfully register 
the descriptor with the service:

njozwiak@ubuntu:~/bluez-5.23/tools$ sudo ./gatt-service
gatt-service unique name: :1.655
Registered service: /service1
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
RegisterService: OK

My GATT server is run from the command line with the arguments: -n -d 
-E. The console output of bluetoothd appears to process the requests 
without error:

bluetoothd[30309]: src/gatt-dbus.c:register_service() New service 
0x831c498: /service1
bluetoothd[30309]: src/gatt-dbus.c:proxy_added() path /service1 iface 
org.bluez.GattService1
bluetoothd[30309]: src/gatt-dbus.c:proxy_added() path 
/service1/characteristic1 iface org.bluez.GattCharacteristic1
bluetoothd[30309]: src/gatt-dbus.c:proxy_added() path 
/service1/characteristic1/descriptor2 iface org.bluez.GattDescriptor1
bluetoothd[30309]: src/gatt-dbus.c:register_external_characteristics() 
Added GATT: /service1/characteristic1 (00002a06-0000-1000-8000-00805f9b34fb)
bluetoothd[30309]: src/gatt-dbus.c:register_external_characteristics() 
Added GATT: /service1/characteristic1/descriptor2 
(8260c653-1a54-426b-9e36-e84c238bc669)
bluetoothd[30309]: src/gatt-dbus.c:client_ready() Added GATT service 
/service1

But when I view the descriptors for the IAS from the GATT client I only 
see one descriptor... the Alert Level (0x2A06).

[CON][00:02:72:C9:5E:0F][LE]> primary
attr handle: 0x0001, end grp handle: 0x0008 uuid:
	00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x0009, end grp handle: 0x000c uuid:
	0000a002-0000-1000-8000-00805f9b34fb
attr handle: 0x0010, end grp handle: 0x0010 uuid:
	00001801-0000-1000-8000-00805f9b34fb
attr handle: 0x001b, end grp handle: 0x0025 uuid:
	0000a004-0000-1000-8000-00805f9b34fb
attr handle: 0x0026, end grp handle: 0x0028 uuid:
	00001803-0000-1000-8000-00805f9b34fb
attr handle: 0x0029, end grp handle: 0x002c uuid:
	00001804-0000-1000-8000-00805f9b34fb
attr handle: 0x002d, end grp handle: 0x002f uuid:
	00001802-0000-1000-8000-00805f9b34fb
attr handle: 0x0030, end grp handle: 0x0035 uuid:
	00001805-0000-1000-8000-00805f9b34fb
attr handle: 0x0036, end grp handle: 0x003a uuid:
	00001806-0000-1000-8000-00805f9b34fb
attr handle: 0x003b, end grp handle: 0x0043 uuid:
	0000180e-0000-1000-8000-00805f9b34fb
attr handle: 0x0044, end grp handle: 0x0050 uuid: 	
	00001811-0000-1000-8000-00805f9b34fb
attr handle: 0xfffa, end grp handle: 0xfffe uuid:
	feee74dc-a8de-3196-1149-d43596c00a4f
[CON][00:02:72:C9:5E:0F][LE]> characteristics 0x002d 0x002f
handle: 0x002e, char properties: 0x04, char value handle: 0x002f, uuid:
	00002a06-0000-1000-8000-00805f9b34fb
[CON][00:02:72:C9:5E:0F][LE]> char-desc 0x002e 0x002f
handle: 0x002e, uuid: 2803
handle: 0x002f, uuid: 2a06

Where is the descriptor (8260c653-1a54-426b-9e36-e84c238bc669) 
registered by gatt-service?

Thanks,
Nathan Jozwiak

