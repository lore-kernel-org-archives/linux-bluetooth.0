Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 2 Dec 2009 10:31:51 +0530
Message-ID: <912bb79a0912012101k16ac6689s5afcc7135a755ca3@mail.gmail.com>
Subject: How to auto connect Headset (on power ON)
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using simple-agent for pairing.
Once the pairing has done, If I turn OFF the headset and again turn ON
it, headset trying to connect with my adapter but cannot connect and
shows following debug

bluetoothd[804]: adapter_get_device(00:02:5B:00:AA:A5)
bluetoothd[804]: adapter_creat_device(00:02:5B:00:AA:A5)
bluetoothd[804]: creating device /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
bluetoothd[804]: btd_device_ref(0x2a06c658): ref=1
bluetoothd[804]: link_key_request (sba=00:15:83:0C:16:BF, bda=00:02:5B:00:AA:A5)
bluetoothd[804]: kernel auth requirement = 0x00
bluetoothd[804]: pin_code_request (sba=00:15:83:0C:16:BF, bda=00:02:5B:00:AA:A5)
bluetoothd[804]: adapter_get_device(00:02:5B:00:AA:A5)
bluetoothd[804]: /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5: requesting
agent authentication
bluetoothd[804]: No agent available for 0 request
bluetoothd[804]: Removing temporary device
/org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
bluetoothd[804]: Removing device /org/bluez/804/hci0/dev_00_02_5B_00_A5_A5
bluetoothd[804]: btd_device_unref(0x2a06c658): ref=0
bluetoothd[804]: device_free(0x2a06c658)

> "bluetoothd[804]: No agent available for 0 request" Is there any separate agent required ?

Can anybody suggest me how to auto connect headset with adapter on power on.

-- 
With Regards,
Nirav
