Return-Path: <cyrus@holtmann.org>
Message-ID: <ffcbfaab275d957cf387eb690b6a81ea.squirrel@iwavesystems.com>
In-Reply-To: <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
    <5a4e8eadcfd668fabdcd350e63a65308.squirrel@iwavesystems.com>
    <d2ec8d829215f8a06d693dd61ec226a2.squirrel@iwavesystems.com>
    <3088225.58tBxefHLJ@leonov>
    <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
Date: Mon, 21 Sep 2015 06:43:20 -0400
Subject: GATT onWriteCharacteristic() returns status=1 (BT_STATUS_FAIL)
From: krishnaks@iwavesystems.com
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using Bluez 5.33 on Android kitkat 4.4.3.
I am testing GATT functionality  and I found that sometime
onWriteCharacteristic returns status 1 (BT_STATUS_FAIL). In android
Application I am checking for success status (i.e. 0) which I am getting
most of the time. But occasionally I am getting Status 1 because of which
my application logic is failing.

When Bluez will send Status 1 and on what basis? How to avoid this?


-----------------------Working Log-------------------------------
D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
D/BtGatt.GattService( 1259): writeCharacteristic() -
address=00:00:39:36:85:2F
D/BtGatt.GattService( 1259): onWriteCharacteristic() -
address=00:00:39:36:85:2F, status=0
D/BluetoothGatt( 1359): onCharacteristicWrite() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=0
----------------------Log End-------------------------


--------------------------Failure Log---------------------------------
D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
D/BtGatt.GattService( 1259): writeCharacteristic() -
address=00:00:39:36:85:2F
D/BtGatt.GattService( 1259): onWriteCharacteristic() -
address=00:00:39:36:85:2F, status=1
D/BluetoothGatt( 1359): onCharacteristicWrite() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
--------------------------Log End-------------------------------

Regards,
KP

