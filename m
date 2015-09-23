Return-Path: <cyrus@holtmann.org>
Message-ID: <31b0cbbb19862da2e92e66593bdbfbd1.squirrel@iwavesystems.com>
In-Reply-To: <0d7093fac6855c30739a0c25ba009bd8.squirrel@iwavesystems.com>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
    <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
    <ffcbfaab275d957cf387eb690b6a81ea.squirrel@iwavesystems.com>
    <2859057.ul7JxHffdl@leonov>
    <71b8da83b60d4739a7cf443599cf4b3f.squirrel@iwavesystems.com>
    <228494b5f37cbb0aa440a679c26c6e54.squirrel@iwavesystems.com>
    <CABBYNZLfwjqL4aPDbVfJMBy88EgLrLZ5YH6gc6YWrdN=023riw@mail.gmail.com>
    <0d7093fac6855c30739a0c25ba009bd8.squirrel@iwavesystems.com>
Date: Wed, 23 Sep 2015 07:06:37 -0400
Subject: Re: GATT onWriteCharacteristic() returns status=1 (BT_STATUS_FAIL)
From: krishnaks@iwavesystems.com
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Szymon Janc" <ext.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have done more tests on GATT behavioud and I found that sometime RX not
receiving for sent Tx and sometime Error RX response (Invalid Handle
error) is coming for the sent TX.

Shared both working and non working logs.

---------------------------------Working Log -----

< ACL Data TX: Handle 64 flags 0x00 dlen 9                    [hci0]
641.405722
      ATT: Write Request (0x12) len 4
        Handle: 0x0212
          Data: 0100
D/BtGatt.GattService( 1501): writeDescriptor() - address=00:00:39:36:85:2F
> ACL Data RX: Handle 64 flags 0x02 dlen 5                    [hci0]
641.521811
      ATT: Write Response (0x13) len 0
D/BtGatt.GattService( 1501): onWriteDescriptor() -
address=00:00:39:36:85:2F, status=0
D/BluetoothGatt( 1552): onDescriptorWrite() - Device=00:00:39:36:85:2F
UUID=00002a37-0000-1000-8000-00805f9b34fb
I/HCSDP_COLLECTORLIB( 1552): Success descriptor write.

-------------Log End----------------

-----------------------RX not received Log -----
< ACL Data TX: Handle 64 flags 0x00 dlen 9                    [hci0]
644.161560
      ATT: Write Request (0x12) len 4
        Handle: 0x0212
          Data: 0000
D/BtGatt.GattService( 1501): writeDescriptor() - address=00:00:39:36:85:2F
D/HCSDP_COLLECTORLIB( 1552): setRawDataMode() is called
D/HCSDP_COLLECTORLIB( 1552): setRawDataMode() is called.
D/HCSDP_COLLECTORLIB( 1552): Set RawDataMode: false
//Notification RX received instead of Write response for Notify disable
> ACL Data RX: Handle 64 flags 0x02 dlen 27                   [hci0]
644.221687
> ACL Data RX: Handle 64 flags 0x01 dlen 27                   [hci0]
644.289321
> ACL Data RX: Handle 64 flags 0x01 dlen 2                    [hci0]
644.356445
      ATT: Handle Value Notification (0x1b) len 51
        Handle: 0x0411
          Data:
0108000a020000010800fd0100000108000102000001080005020000010800fd01000001080004020000010800f9010000
D/BtGatt.GattService( 1501): onNotify() - address=00:00:39:36:85:2F,
charUuid=1d11ff20-485b-11e4-8add-0002a5d5c51b, length=49
D/BluetoothGatt( 1552): onNotify() - Device=00:00:39:36:85:2F
UUID=1d11ff20-485b-11e4-8add-0002a5d5c51b
----------------------Log End---------------


----------------------------Working Log2------------------
D/BluetoothGatt( 1073): writeCharacteristic() - uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 8                    [hci0]
176.499417
      ATT: Write Request (0x12) len 3
        Handle: 0x0241
          Data: 00
D/BtGatt.GattService(  829): writeCharacteristic() -
address=00:00:39:36:85:2F
> ACL Data RX: Handle 64 flags 0x02 dlen 5                    [hci0]
176.545564
      ATT: Write Response (0x13) len 0
D/BtGatt.GattService(  829): onWriteCharacteristic() -
address=00:00:39:36:85:2F, status=0
D/BluetoothGatt( 1073): onCharacteristicWrite() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=0
I/HCSDP_COLLECTORLIB( 1073): Success characteristic write.

----------------------------Log End----------------------



------------------------Write Failure Log------------
D/BluetoothGatt( 1073): writeCharacteristic() - uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 8                     [hci0]
72.124696
      ATT: Write Request (0x12) len 3
        Handle: 0x0241
          Data: 00
D/BtGatt.GattService(  829): writeCharacteristic() -
address=00:00:39:36:85:2F
I/audio_hw_primary(  189): start_output_stream... 2016783120, device 2
W/audio_hw_primary(  189): card 1, port 0 device 0x2
W/audio_hw_primary(  189): rate 48000, channel 2 period_size 0xc0
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


-------------------------Log End--------------


Regards,
KP


