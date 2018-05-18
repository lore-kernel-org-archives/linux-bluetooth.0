Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: meshctl: Failed to AcquireWrite
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <adcc154e-622d-d974-87cc-23d9d0b220c3@posteo.de>
 <CABBYNZLUKFm1u=OsSArm73Diq=dsXJTc0V2=MaYN7pt-9wjPCA@mail.gmail.com>
From: "wenzel.reichmuth@posteo.de" <wenzel.reichmuth@posteo.de>
Message-ID: <a0673f4c-143d-4b0b-0e2a-ba51e1ea2db9@posteo.de>
Date: Fri, 18 May 2018 16:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZLUKFm1u=OsSArm73Diq=dsXJTc0V2=MaYN7pt-9wjPCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, thanks for reply. This is my meshctl output:

[meshctl]# discover-unprovisioned on
SetDiscoveryFilter success
Discovery started
Adapter property changed
[CHG] Controller B8:27:EB:04:E6:D4 Discovering: yes
		Mesh Provisioning Service (00001827-0000-1000-8000-00805f9b34fb)
			Device UUID: e534e0da9ae700000000000000000000
			OOB: 0000
[NEW] Device E7:9A:DA:E0:34:E5 Zephyr
[meshctl]# security 0
Provision Security Level set to 0 (low)
[meshctl]# provision e534e0da9ae700000000000000000000
Trying to connect Device E7:9A:DA:E0:34:E5 Zephyr
Adapter property changed
[CHG] Controller B8:27:EB:04:E6:D4 Discovering: no
Connection successful
Service added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service0006
Service added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a
Char added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000b:
Char added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d:
Services resolved yes
Found matching char: path
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000b, uuid
00002adb-0000-1000-8000-00805f9b34fb
Found matching char: path
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d, uuid
00002adc-0000-1000-8000-00805f9b34fb
Start notification on
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d
Characteristic property changed
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d
AcquireNotify success: fd 7 MTU 69
Notify for Mesh Provisioning Out Data started
Open-Node: 0x17ebe50
Open-Prov: 0x17f64d8
Open-Prov: proxy 0x17f1e08
Initiated provisioning
Characteristic property changed
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000b
AcquireWrite success: fd 8 MTU 69
GATT-TX:	 03 00 10
GATT-RX:	 03 01 01 00 01 00 00 00 00 00 00 00 00
Got provisioning data (12 bytes)
	 01 01 00 01 00 00 00 00 00 00 00 00
GATT-TX:	 03 02 00 00 00 00 00
GATT-TX:	 03 03 67 85 01 73 01 02 ea c5 3d af 03 82 09 b7
GATT-TX:	 e4 f8 6a c3 11 15 a2 98 cf 6a 2f 9e 4a d0 77 b3
GATT-TX:	 94 ec 9c f8 ee e4 f7 6d 15 f5 35 6b 43 a5 fd 21
GATT-TX:	 fc db b4 2c cd f9 61 1d 03 42 1c d1 d9 d4 8c a2
GATT-TX:	 f8 ad
GATT-RX:	 03 03 2d 9e 3e ea 9c cd 61 5f ac be 46 f6 43 b6
GATT-RX:	 ee b6 2c cb de 6e c6 40 e7 9d 82 20 8e cf 76 9e
GATT-RX:	 8a 16 4c 8e 6b aa 7c f7 af 0d 4a 48 d5 11 83 0a
GATT-RX:	 f3 53 d4 aa bc 3f d4 26 bc 94 78 5d 67 1f f5 cd
GATT-RX:	 c1 05
Got provisioning data (65 bytes)
	 03 2d 9e 3e ea 9c cd 61 5f ac be 46 f6 43 b6 ee
	 b6 2c cb de 6e c6 40 e7 9d 82 20 8e cf 76 9e 8a
	 16 4c 8e 6b aa 7c f7 af 0d 4a 48 d5 11 83 0a f3
	 53 d4 aa bc 3f d4 26 bc 94 78 5d 67 1f f5 cd c1
	 05
GATT-TX:	 03 05 ba 40 d3 a0 fd ef c2 5a ed 0c 93 4b 80 c9
GATT-TX:	 8b e9
GATT-RX:	 03 05 63 09 38 59 da 51 a7 bb da b6 e6 e8 4c 36
GATT-RX:	 4c cd
Got provisioning data (17 bytes)
	 05 63 09 38 59 da 51 a7 bb da b6 e6 e8 4c 36 4c
	 cd
GATT-TX:	 03 06 b4 7b b8 3c 4e ab 08 05 14 26 2e a6 62 83
GATT-TX:	 fa 91
GATT-RX:	 03 06 df b9 45 a3 3d c6 d2 cd 1d 5e 85 82 46 65
GATT-RX:	 0f 20
Got provisioning data (17 bytes)
	 06 df b9 45 a3 3d c6 d2 cd 1d 5e 85 82 46 65 0f
	 20
Confirmation Validated
S-Key	 f2 1d d7 c4 ea d0 b8 d5 2a 62 d7 98 44 64 41 d9
S-Nonce	 59 57 79 52 a0 f7 6c 06 90 b0 be d4 4f
DevKey	 41 fa 20 0e 6a 5f 4a 1f ab 9a 24 3a 87 2d 96 87
Data	 18 ee d9 c2 a5 6a dd 85 04 9f fc 3c 59 ad 0e 12
Data	 00 00 00 00 00 00 05 01 10
DataEncrypted + mic	 22 8b 63 c6 46 9a 19 fc 99 4d 12 a1 38 d2 39 18
DataEncrypted + mic	 83 78 e2 41 19 6f 40 29 24 31 85 f4 e5 f2 06 9c
DataEncrypted + mic	 14
GATT-TX:	 03 07 22 8b 63 c6 46 9a 19 fc 99 4d 12 a1 38 d2
GATT-TX:	 39 18 83 78 e2 41 19 6f 40 29 24 31 85 f4 e5 f2
GATT-TX:	 06 9c 14
GATT-RX:	 03 08
Got provisioning data (1 bytes)
	 08
Provision success. Assigned Primary Unicast 0110
Attempting to disconnect from E7:9A:DA:E0:34:E5
Characteristic property changed
/org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d
Write closed
Service added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a
Char added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000b:
Char added /org/bluez/hci0/dev_E7_9A_DA_E0_34_E5/service000a/char000d:
Services resolved no
SetDiscoveryFilter success
Discovery started
Adapter property changed
[CHG] Controller B8:27:EB:04:E6:D4 Discovering: yes
[meshctl]# menu config
[meshctl]# target 0110
Configuring node 0110
[config: Target = 0110]# appkey-add 1
Failed to AcquireWrite

Am 17.05.18 um 10:19 schrieb Luiz Augusto von Dentz:
> Hi,
> On Wed, May 16, 2018 at 2:15 PM wenzel.reichmuth@posteo.de <
> wenzel.reichmuth@posteo.de> wrote:
> 
>> Hello. I am using meshctl from bluez 5.49 and try to configure a mesh
>> with zephyr nodes on redbear ble nano 2. I am able to discover and
>> provision a node. but when i try to configure it e.g. appkey-add i get
>> "Failed to AcquireWrite". Any hint, how to get this solved? there is
>> sparse documentation for meshctl.
> 
> Perhaps the problem is with fd passing being blocked by something like
> selinux, do you have logs of the problem?
> 
