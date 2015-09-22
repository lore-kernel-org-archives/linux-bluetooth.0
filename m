Return-Path: <cyrus@holtmann.org>
Message-ID: <228494b5f37cbb0aa440a679c26c6e54.squirrel@iwavesystems.com>
In-Reply-To: <71b8da83b60d4739a7cf443599cf4b3f.squirrel@iwavesystems.com>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
    <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
    <ffcbfaab275d957cf387eb690b6a81ea.squirrel@iwavesystems.com>
    <2859057.ul7JxHffdl@leonov>
    <71b8da83b60d4739a7cf443599cf4b3f.squirrel@iwavesystems.com>
Date: Tue, 22 Sep 2015 01:13:23 -0400
Subject: Re: GATT onWriteCharacteristic() returns status=1 (BT_STATUS_FAIL)
From: krishnaks@iwavesystems.com
To: krishnaks@iwavesystems.com
Cc: "Szymon Janc" <ext.szymon.janc@tieto.com>,
	krishnaks@iwavesystems.com, linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> Hi,
>>
>> On Monday 21 of September 2015 06:43:20 krishnaks@iwavesystems.com
>> wrote:
>>> Hi,
>>>
>>> I am using Bluez 5.33 on Android kitkat 4.4.3.
>>> I am testing GATT functionality  and I found that sometime
>>> onWriteCharacteristic returns status 1 (BT_STATUS_FAIL). In android
>>> Application I am checking for success status (i.e. 0) which I am
>>> getting
>>> most of the time. But occasionally I am getting Status 1 because of
>>> which
>>> my application logic is failing.
>>>
>>> When Bluez will send Status 1 and on what basis? How to avoid this?
>>>
>>>
>>> -----------------------Working Log-------------------------------
>>> D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
>>> 1d4de0a0-9f84-11e4-a042-0002a5d5c51b
>>> D/BtGatt.GattService( 1259): writeCharacteristic() -
>>> address=00:00:39:36:85:2F
>>> D/BtGatt.GattService( 1259): onWriteCharacteristic() -
>>> address=00:00:39:36:85:2F, status=0
>>> D/BluetoothGatt( 1359): onCharacteristicWrite() -
>>> Device=00:00:39:36:85:2F
>>> UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=0
>>> ----------------------Log End-------------------------
>>>
>>>
>>> --------------------------Failure Log---------------------------------
>>> D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
>>> 1d4de0a0-9f84-11e4-a042-0002a5d5c51b
>>> D/BtGatt.GattService( 1259): writeCharacteristic() -
>>> address=00:00:39:36:85:2F
>>> D/BtGatt.GattService( 1259): onWriteCharacteristic() -
>>> address=00:00:39:36:85:2F, status=1
>>> D/BluetoothGatt( 1359): onCharacteristicWrite() -
>>> Device=00:00:39:36:85:2F
>>> UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
>>> --------------------------Log End-------------------------------
>>
>> Please enable debug logs for daemon (check android/README for how-to)
>> and
>> provide both debug logs and btmon HCI traces.
>>
>> --
>> BR
>> Szymon Janc
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Hi,
>
> Attached Working and Failure logs with btmon HCI traces and with bluez
> debug logs
>
> Regards,
> KP
>

Hi,

>From the log (attached in previous mail), From the btmon HCI traces,I am
getting "Error: Invalid Handle (0x01)" error. I hope this error is not
related to characteristics handle range.How to resolve this error/ find
the cause?

Log--->

< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.810476
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0633-0x0633
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
66.944822
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0633
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
67.078076
        Num handles: 1
        Handle: 64
        Count: 1
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
72.209941
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0241
        Error: Invalid Handle (0x01)
D/BtGatt.GattService(  829): onWriteCharacteristic() -
address=00:00:39:36:85:2F, status=1
D/BluetoothGatt( 1073): onCharacteristicWrite() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
I/HCSDP_COLLECTORLIB( 1073): Fail characteristic write.

Regards,
KP

