Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: avichal <avichal.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com
Subject: "Add Support for "Included Services" in Bluez"
Date: Thu, 15 Mar 2018 20:15:35 +0530
Message-id: <1521125138-24229-1-git-send-email-avichal.a@samsung.com>
In-reply-to: <avichal.a@samsung.com>
References: <avichal.a@samsung.com>
        <CGME20180315144648epcas2p33469538b136a71c74b4dbb4796f349bf@epcas2p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

 Currently in bluez, Included Service support is under "Not Implemented" status

After adding support for the same in gatt-database, i am able to verify the operation as follows.

- Three primary services "1802","a00d","a00c" are created
- Further, the services "a00d" and "a00c" are included in "1802".

Following is the log showing Included services are added to Main service [using btgatt-client tool]
I will be submitting patches for the support in subsequent patches. Please review and share your opinion. Thanks.



pi@raspberrypi:~/Downloads/bluez-5.48/tools $ ./btgatt-client  -d 00:1B:DC:07:33:50
Connecting to device... Done
[GATT client]# Service Added - UUID: 00001800-0000-1000-8000-00805f9b34fb start: 0x0001 end: 0x0005
[GATT client]# Service Added - UUID: 00001801-0000-1000-8000-00805f9b34fb start: 0x0006 end: 0x0009
[GATT client]# Service Added - UUID: 0000a00d-0000-1000-8000-00805f9b34fb start: 0x005c end: 0x005f
[GATT client]# Service Added - UUID: 0000a00c-0000-1000-8000-00805f9b34fb start: 0x0060 end: 0x0063
[GATT client]# Service Added - UUID: 00001802-0000-1000-8000-00805f9b34fb start: 0x0064 end: 0x0069
[GATT client]# GATT discovery procedures complete
[GATT client]# 
service - start: 0x0001, end: 0x0005, type: primary, uuid: 00001800-0000-1000-8000-00805f9b34fb
	  charac - start: 0x0002, value: 0x0003, props: 0x02, ext_props: 0x0000, uuid: 00002a00-0000-1000-8000-00805f9b34fb
	  charac - start: 0x0004, value: 0x0005, props: 0x02, ext_props: 0x0000, uuid: 00002a01-0000-1000-8000-00805f9b34fb

service - start: 0x0006, end: 0x0009, type: primary, uuid: 00001801-0000-1000-8000-00805f9b34fb
	  charac - start: 0x0007, value: 0x0008, props: 0x20, ext_props: 0x0000, uuid: 00002a05-0000-1000-8000-00805f9b34fb
		  descr - handle: 0x0009, uuid: 00002902-0000-1000-8000-00805f9b34fb

service - start: 0x005c, end: 0x005f, type: primary, uuid: 0000a00d-0000-1000-8000-00805f9b34fb
	  charac - start: 0x005d, value: 0x005e, props: 0x04, ext_props: 0x0000, uuid: 00002b06-0000-1000-8000-00805f9b34fb
		  descr - handle: 0x005f, uuid: 0260c653-1a54-426b-9e36-e84c238bc669

service - start: 0x0060, end: 0x0063, type: primary, uuid: 0000a00c-0000-1000-8000-00805f9b34fb
	  charac - start: 0x0061, value: 0x0062, props: 0x04, ext_props: 0x0000, uuid: 00002c07-0000-1000-8000-00805f9b34fb
		  descr - handle: 0x0063, uuid: 0000ffff-0000-1000-8000-00805f9b34fb

service - start: 0x0064, end: 0x0069, type: primary, uuid: 00001802-0000-1000-8000-00805f9b34fb
	  include - handle: 0x0065, - start: 0x005c, end: 0x005f,uuid: 0000a00d-0000-1000-8000-00805f9b34fb
	  include - handle: 0x0066, - start: 0x0060, end: 0x0063,uuid: 0000a00c-0000-1000-8000-00805f9b34fb
	  charac - start: 0x0067, value: 0x0068, props: 0x04, ext_props: 0x0000, uuid: 00002a06-0000-1000-8000-00805f9b34fb
		  descr - handle: 0x0069, uuid: 8260c653-1a54-426b-9e36-e84c238bc669

[GATT client]# 



