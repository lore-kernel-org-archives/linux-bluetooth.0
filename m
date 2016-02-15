Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGNRUGHOuLGpVa5NqVi4zvCTMFwNrTqpE2ysLq6_uCoCCg@mail.gmail.com>
References: <CAEZxfGNt6FPXpk0SQLCxke49M4PVcP5t-JSEnB9S+AXCi0HJgw@mail.gmail.com>
 <CABBYNZJiuQXVGm3AFbSU23mEQB_vEN5D0QFkcZJw=FFdU9Zztw@mail.gmail.com>
 <CAEZxfGNq6DWz_0Rp+_hr0KWwUBkN_gg0tpQssn+ZUnuDv6nhSw@mail.gmail.com> <CAEZxfGNRUGHOuLGpVa5NqVi4zvCTMFwNrTqpE2ysLq6_uCoCCg@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 15 Feb 2016 11:20:50 +0100
Message-ID: <CAEZxfGOtnPsBRJzKPNLt0cMn+DRo5NExw=NTF60JKSPQgCAiGQ@mail.gmail.com>
Subject: Re: What does mean "GattServices is nil" ?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And here are my bluetoothd logs when enabling debug mode:
http://pastebin.com/raw/WjRVrMk5

bluetoothd[21655]: src/device.c:device_connect_le() Connection attempt
to: F1:6F:DE:EC:F1:D6
bluetoothd[21655]: src/adapter.c:connect_failed_callback() hci0
F1:6F:DE:EC:F1:D6 status 2
bluetoothd[21655]: plugins/policy.c:conn_fail_cb() status 2
bluetoothd[21655]: src/adapter.c:bonding_attempt_complete() hci0
bdaddr F1:6F:DE:EC:F1:D6 type 2 status 0x2
bluetoothd[21655]: src/device.c:device_bonding_complete() bonding
(nil) status 0x02
bluetoothd[21655]: src/device.c:device_bonding_failed() status 2
bluetoothd[21655]: src/adapter.c:resume_discovery()
bluetoothd[21655]: src/device.c:att_connect_cb() connect error:
Transport endpoint is not connected (107)
bluetoothd[21655]: src/adapter.c:connected_callback() hci0 device
F1:6F:DE:EC:F1:D6 connected eir_len 24
bluetoothd[21655]: attrib/gattrib.c:g_attrib_ref() 0x7f3ccfe929b0:
g_attrib_ref=1
bluetoothd[21655]: src/device.c:load_gatt_db() Restoring
F1:6F:DE:EC:F1:D6 gatt database from file
bluetoothd[21655]: src/device.c:load_service() loading service:
0x0001, end: 0x0007, uuid: 1800
bluetoothd[21655]: src/device.c:load_service() loading service:
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:load_service() loading service:
0x0012, end: 0x0019, uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:load_service() loading service:
0x001a, end: 0xffff, uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
handle: 0x0002, value handle: 0x0003, properties 0x000a uuid: 2a00
bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
handle: 0x0004, value handle: 0x0005, properties 0x0002 uuid: 2a01
bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
handle: 0x0006, value handle: 0x0007, properties 0x0002 uuid: 2a04
bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
handle: 0x0009, value handle: 0x000a, properties 0x0020 uuid:
00002a05-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
handle: 0x000a, value handle: 0x000b, properties 0x0010 uuid:
6e400003-b5a3-f393-e0a9-e50e24dcca9e
bluetoothd[21655]: saving characteristic to db failed
bluetoothd[21655]: Unable to load gatt db from file for F1:6F:DE:EC:F1:D6
bluetoothd[21655]: src/gatt-client.c:btd_gatt_client_connected()
Device connected.
bluetoothd[21655]: src/device.c:att_browse_cb() ATT connection successful
bluetoothd[21655]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
bluetoothd[21655]: src/device.c:gatt_debug() Primary services found: 5
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0001, end:
0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0008, end:
0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x000c, end:
0x0011, uuid: 00001530-1212-efde-1523-785feabcd123
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0012, end:
0x0019, uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x001a, end:
0xffff, uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[21655]: src/device.c:gatt_debug() Secondary service
discovery failed. ATT ECODE: 0x0a
bluetoothd[21655]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0009, end:
0x000b, value: 0x000a, props: 0x20, uuid: 00002a05-0000-1
bluetoothd[21655]: src/device.c:gatt_debug() Failed to initialize gatt-client
bluetoothd[21655]: src/device.c:gatt_client_ready_cb() status: failed, error: 10
bluetoothd[21655]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6 err -5
bluetoothd[21655]: src/device.c:gatt_service_removed() start: 0x0001,
end: 0x0007

On Mon, Feb 15, 2016 at 10:45 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> Here are the two warnings I'm seeing...
>
> 2016-02-15T10:44:51.194355+01:00 WARNING bluetoothd[1610]: saving
> characteristic to db failed
> 2016-02-15T10:44:51.194452+01:00 WARNING bluetoothd[1610]: Unable to
> load gatt db from file for F1:6F:DE:EC:F1:D6
>
> On Mon, Feb 15, 2016 at 10:21 AM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> It is all... that's why I'm surprised too.
>> Where do you see bluetoothd logs?
>>
>> On Mon, Feb 15, 2016 at 10:19 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi François,
>>>
>>> On Fri, Feb 12, 2016 at 3:38 PM, François Beaufort
>>> <beaufort.francois@gmail.com> wrote:
>>>> Hello! I use BlueZ 5.35 and I'd love your help.
>>>> Can you help me understand why list-attributes doesn't return anything
>>>> and the "GattServices is nil" message?
>>>>
>>>> Here's my bluetoothctl logs:
>>>>
>>>> [bluetooth]# connect F1:6F:DE:EC:F1:D6
>>>> Attempting to connect to F1:6F:DE:EC:F1:D6
>>>> [CHG] Device F1:6F:DE:EC:F1:D6 Connected: yes
>>>> Connection successful
>>>> [CHG] Device F1:6F:DE:EC:F1:D6 GattServices is nil
>>>> [DFU_Test]# list-attributes
>>>> [DFU_Test]# info
>>>> Device F1:6F:DE:EC:F1:D6
>>>>         Name: DFU_Test
>>>>         Alias: DFU_Test
>>>>         Appearance: 0x0340
>>>>         Paired: no
>>>>         Trusted: no
>>>>         Blocked: no
>>>>         Connected: yes
>>>>         LegacyPairing: no
>>>>         UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
>>>>         UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>>>>
>>>> And here are my btmon logs in case it would help:
>>>>
>>>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7      [hci0] 49.518076
>>>>         Type: Passive (0x00)
>>>>         Interval: 60.000 msec (0x0060)
>>>>         Window: 30.000 msec (0x0030)
>>>>         Own address type: Public (0x00)
>>>>         Filter policy: Ignore not in white list (0x01)
>>>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 49.518952
>>>>       LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>>>         Status: Success (0x00)
>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0] 49.518981
>>>>         Scanning: Enabled (0x01)
>>>>         Filter duplicates: Enabled (0x01)
>>>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 49.519952
>>>>       LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>         Status: Success (0x00)
>>>>> HCI Event: LE Meta Event (0x3e) plen 36                       [hci0] 52.188030
>>>>       LE Advertising Report (0x02)
>>>>         Num reports: 1
>>>>         Event type: Connectable undirected - ADV_IND (0x00)
>>>>         Address type: Random (0x01)
>>>>         Address: F1:6F:DE:EC:F1:D6 (Static)
>>>>         Data length: 24
>>>>         Flags: 0x06
>>>>           LE General Discoverable Mode
>>>>           BR/EDR Not Supported
>>>>         16-bit Service UUIDs (complete): 2 entries
>>>>           Heart Rate (0x180d)
>>>>           Device Information (0x180a)
>>>>         Appearance: Heart Rate Sensor (0x0340)
>>>>         Name (complete): DFU_Test
>>>>         RSSI: -31 dBm (0xe1)
>>>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0] 52.188143
>>>>         Scanning: Disabled (0x00)
>>>>         Filter duplicates: Disabled (0x00)
>>>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 52.188957
>>>>       LE Set Scan Enable (0x08|0x000c) ncmd 1
>>>>         Status: Success (0x00)
>>>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25       [hci0] 52.189058
>>>>         Scan interval: 60.000 msec (0x0060)
>>>>         Scan window: 30.000 msec (0x0030)
>>>>         Filter policy: White list is not used (0x00)
>>>>         Peer address type: Random (0x01)
>>>>         Peer address: F1:6F:DE:EC:F1:D6 (Static)
>>>>         Own address type: Public (0x00)
>>>>         Min connection interval: 50.00 msec (0x0028)
>>>>         Max connection interval: 70.00 msec (0x0038)
>>>>         Connection latency: 0x0000
>>>>         Supervision timeout: 420 msec (0x002a)
>>>>         Min connection length: 0.000 msec (0x0000)
>>>>         Max connection length: 0.000 msec (0x0000)
>>>>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 52.189955
>>>>       LE Create Connection (0x08|0x000d) ncmd 1
>>>>         Status: Success (0x00)
>>>> < HCI Command: LE Create Connection Can.. (0x08|0x000e) plen 0  [hci0] 54.195731
>>>>> HCI Event: LE Meta Event (0x3e) plen 19                       [hci0] 54.195946
>>>>       LE Connection Complete (0x01)
>>>>         Status: Success (0x00)
>>>>         Handle: 32
>>>>         Role: Master (0x00)
>>>>         Peer address type: Random (0x01)
>>>>         Peer address: F1:6F:DE:EC:F1:D6 (Static)
>>>>         Connection interval: 67.50 msec (0x0036)
>>>>         Connection latency: 0.00 msec (0x0000)
>>>>         Supervision timeout: 420 msec (0x002a)
>>>>         Master clock accuracy: 0x00
>>>> @ Device Connected: F1:6F:DE:EC:F1:D6 (2) flags 0x0000
>>>>         02 01 06 05 03 0d 18 0a 18 03 19 40 03 0a 09 44  ...........@...D
>>>>         46 55 5f 54 65 73 74 00                          FU_Test.
>>>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0] 54.196928
>>>>       LE Create Connection Cancel (0x08|0x000e) ncmd 1
>>>>         Status: Command Disallowed (0x0c)
>>>> < HCI Command: LE Read Remote Used Feat.. (0x08|0x0016) plen 2  [hci0] 54.197004
>>>>         Handle: 32
>>>>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 54.197929
>>>>       LE Read Remote Used Features (0x08|0x0016) ncmd 1
>>>>         Status: Success (0x00)
>>>>> HCI Event: LE Meta Event (0x3e) plen 12                       [hci0] 54.330960
>>>>       LE Read Remote Used Features (0x04)
>>>>         Status: Success (0x00)
>>>>         Handle: 32
>>>>         Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>>           LE Encryption
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 7                      [hci0] 54.332123
>>>>       ATT: Exchange MTU Request (0x02) len 2
>>>>         Client RX MTU: 517
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 54.397976
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 7                      [hci0] 54.465099
>>>>       ATT: Exchange MTU Response (0x03) len 2
>>>>         Server RX MTU: 23
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 54.465342
>>>>       ATT: Read By Group Type Request (0x10) len 6
>>>>         Handle range: 0x0001-0xffff
>>>>         Attribute group type: Primary Service (0x2800)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 54.532926
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 18                     [hci0] 54.600225
>>>>       ATT: Read By Group Type Response (0x11) len 13
>>>>         Attribute data length: 6
>>>>         Attribute group list: 2 entries
>>>>         Handle range: 0x0001-0x0007
>>>>         UUID: Generic Access Profile (0x1800)
>>>>         Handle range: 0x0008-0x000b
>>>>         UUID: Generic Attribute Profile (0x1801)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 54.600402
>>>>       ATT: Read By Group Type Request (0x10) len 6
>>>>         Handle range: 0x000c-0xffff
>>>>         Attribute group type: Primary Service (0x2800)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 54.667973
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 26                     [hci0] 54.735207
>>>>       ATT: Read By Group Type Response (0x11) len 21
>>>>         Attribute data length: 20
>>>>         Attribute group list: 1 entry
>>>>         Handle range: 0x000c-0x0011
>>>>         UUID: Unknown (00001530-1212-efde-1523-785feabcd123)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 54.735408
>>>>       ATT: Read By Group Type Request (0x10) len 6
>>>>         Handle range: 0x0012-0xffff
>>>>         Attribute group type: Primary Service (0x2800)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 54.802940
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 18                     [hci0] 54.937705
>>>>       ATT: Read By Group Type Response (0x11) len 13
>>>>         Attribute data length: 6
>>>>         Attribute group list: 2 entries
>>>>         Handle range: 0x0012-0x0019
>>>>         UUID: Heart Rate (0x180d)
>>>>         Handle range: 0x001a-0xffff
>>>>         UUID: Device Information (0x180a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 54.937991
>>>>       ATT: Read By Group Type Request (0x10) len 6
>>>>         Handle range: 0x0001-0xffff
>>>>         Attribute group type: Secondary Service (0x2801)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.005936
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.072581
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Group Type Request (0x10)
>>>>         Handle: 0x0001
>>>>         Error: Attribute Not Found (0x0a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.072850
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x0008-0x000b
>>>>         Attribute type: Include (0x2802)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.140972
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.207582
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x0008
>>>>         Error: Attribute Not Found (0x0a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.207940
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x000c-0x0011
>>>>         Attribute type: Include (0x2802)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.275954
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.342564
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x000c
>>>>         Error: Attribute Not Found (0x0a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.342855
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x0012-0x0019
>>>>         Attribute type: Include (0x2802)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.410939
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.477547
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x0012
>>>>         Error: Attribute Not Found (0x0a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.477794
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x001a-0xffff
>>>>         Attribute type: Include (0x2802)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.545967
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.612685
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x001a
>>>>         Error: Attribute Not Found (0x0a)
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.612878
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x0008-0x000b
>>>>         Attribute type: Characteristic (0x2803)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.680951
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 13                     [hci0] 55.747715
>>>>       ATT: Read By Type Response (0x09) len 8
>>>>         Attribute data length: 7
>>>>         Attribute data list: 1 entry
>>>>         Handle: 0x0009
>>>>         Value: 200a00052a
>>>> < ACL Data TX: Handle 32 flags 0x00 dlen 11                     [hci0] 55.747892
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x000a-0x000b
>>>>         Attribute type: Characteristic (0x2803)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 55.815954
>>>>         Num handles: 1
>>>>         Handle: 32
>>>>         Count: 1
>>>>> ACL Data RX: Handle 32 flags 0x02 dlen 9                      [hci0] 55.882715
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x000a
>>>>         Error: Attribute Not Found (0x0a)
>>>> --
>>>
>>> Was this all? Check if there is any error in bluetoothd logs since it
>>> appears to have stopped while discovering the characteristics of a GAP
>>> service.
>>>
>>> --
>>> Luiz Augusto von Dentz
