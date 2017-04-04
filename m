Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Date: Tue, 4 Apr 2017 18:59:00 +0530
Message-ID: <CA+TC0NoAX-B362BS=s-kk3bhi4k75ygYV_Lix6F9vDoJsTMS-w@mail.gmail.com>
Subject: Re-connect to BLE device in response to ADV_DIRECT_IND
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I'm a BlueZ newbie and wanted your help regarding a problem that I'm
facing with a BLE project.

I'm running BlueZ 5.42 in my linux machine and have written a
bluetooth application which communicates with a BLE device.
The application uses bluez dbus APIs for pairing and connecting to the
BLE device (device-api.txt and adapter-api.txt).
The BLE device is programmed to disconnect if left idle and send
ADV_DIRECT_IND if woken up.

Using hcidump tool, I see that bluetoothd on my machine indeed
receives the ADV_DIRECT_IND message from the BLE device. However I'm
not able to figure out how my application can be made aware that such
an advertisement has been received and it should now reconnect to the
BLE device.

I do not see any dbus API or signal using which the application can be
made aware of this event.

Could you suggest me a solution to this? Are there any low level
settings/configuration which would make bluetoothd automatically
reconnect to the BLE device if it receives an ADV_DIRECT_IND?

Appreciate your help.

Thanks,
Sudeepta
