Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3017327.dufLGECPfA@uw000953>
References: <CAA8=LDXCLCVytAMDNAX8Vafi827F5mMrEp7WELbseM_oZ5+S0w@mail.gmail.com>
	<3017327.dufLGECPfA@uw000953>
Date: Mon, 13 Jan 2014 13:19:52 +0200
Message-ID: <CABBYNZJgbZt3MopBQRFMmH4LtmJZJ5c699yTex-y_Y=7R=2r-g@mail.gmail.com>
Subject: Re: Problems with Logitech V270 mouse
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Jakub Jechanowski <j.jechanowski@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 13, 2014 at 12:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> On Thursday 02 of January 2014 23:55:25 Jakub Jechanowski wrote:
>> After pairing and connecting (bluetoothctl or bluetooth-wizard) mouse
>> works ok. But when I restart bluetoothd (or whole OS) mouse no longer
>> works. After touching the mouse, in bluetoothd log I get:
>>
>> bluetoothd[6418]: src/adapter.c:connected_callback() hci0 device
>> 00:07:61:68:55:27 connected eir_len 5
>> bluetoothd[6418]: src/device.c:device_create() dst 00:07:61:68:55:27
>> bluetoothd[6418]: src/device.c:device_new() address 00:07:61:68:55:27
>> bluetoothd[6418]: src/device.c:device_new() Creating device
>> /org/bluez/hci0/dev_00_07_61_68_55_27
>> bluetoothd[6418]: src/device.c:btd_device_set_temporary() temporary 1
>> bluetoothd[6418]: src/adapter.c:adapter_connect_list_remove() device
>> /org/bluez/hci0/dev_00_07_61_68_55_27 is not on the list, ignoring
>> bluetoothd[6418]: src/device.c:device_set_class()
>> /org/bluez/hci0/dev_00_07_61_68_55_27 0x002580
>> bluetoothd[6418]: profiles/input/server.c:connect_event_cb() Incoming
>> connection from 00:07:61:68:55:27 on PSM 17
>> bluetoothd[6418]: profiles/input/device.c:input_device_set_channel()
>> idev (nil) psm 17
>> bluetoothd[6418]: Refusing input device connect: No such file or directory (2)
>> bluetoothd[6418]: profiles/input/server.c:confirm_event_cb()
>> bluetoothd[6418]: Refusing connection from 00:07:61:68:55:27: unknown device
>>    <<<few seconds of pause>>>
>> bluetoothd[6418]: src/adapter.c:dev_disconnected() Device
>> 00:07:61:68:55:27 disconnected, reason 2
>> bluetoothd[6418]: src/adapter.c:adapter_remove_connection()
>> bluetoothd[6418]: src/adapter.c:adapter_remove_connection() Removing
>> temporary device /org/bluez/hci0/dev_00_07_61_68_55_27
>> bluetoothd[6418]: src/device.c:device_remove() Removing device
>> /org/bluez/hci0/dev_00_07_61_68_55_27
>> bluetoothd[6418]: src/device.c:btd_device_unref() Freeing device
>> /org/bluez/hci0/dev_00_07_61_68_55_27
>> bluetoothd[6418]: src/device.c:device_free() 0x24a65e0
>> bluetoothd[6418]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
>> 00:07:61:68:55:27 type 0 status 0xe
>> bluetoothd[6418]: src/adapter.c:resume_discovery()
>>
>> ------------------------------------
>>
>> Log from btmon after touching mouse:
>>
>> > HCI Event: Connect Request (0x04) plen 10                     [hci0] 9.133728
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Class: 0x002580
>>           Major class: Peripheral (mouse, joystick, keyboards)
>>           Minor class: 0x20
>>           Limited Discoverable Mode
>>         Link type: ACL (0x01)
>> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7   [hci0] 9.133770
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Role: Master (0x00)
>> > HCI Event: Command Status (0x0f) plen 4                       [hci0] 9.136727
>>       Accept Connection Request (0x01|0x0009) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Role Change (0x12) plen 8                          [hci0] 9.294753
>>         Status: Success (0x00)
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Role: Master (0x00)
>> > HCI Event: Connect Complete (0x03) plen 11                    [hci0] 9.444736
>>         Status: Success (0x00)
>>         Handle: 11
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Link type: ACL (0x01)
>>         Encryption: Disabled (0x00)
>> < HCI Command: Read Remote Supported Fe.. (0x01|0x001b) plen 2  [hci0] 9.444839
>>         Handle: 11
>> > HCI Event: Command Status (0x0f) plen 4                       [hci0] 9.446731
>>       Read Remote Supported Features (0x01|0x001b) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Read Remote Supported Features (0x0b) plen 11      [hci0] 9.448739
>>         Status: Success (0x00)
>>         Handle: 11
>>         Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
>>           Encryption
>>           Slot offset
>>           Timing accuracy
>>           Role switch
>>           Hold mode
>>           Sniff mode
>>           Park state
>>           Power control requests
>>           Channel quality driven data rate (CQDDR)
>>           SCO link
>>           HV2 packets
>>           HV3 packets
>>           u-law log synchronous data
>>           A-law log synchronous data
>>           CVSD synchronous data
>>           Paging parameter negotiation
>>           Power control
>>           Transparent synchronous data
>>           AFH capable slave
>>           AFH capable master
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10        [hci0] 9.448793
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Page scan repetition mode: R2 (0x02)
>>         Page scan mode: Mandatory (0x00)
>>         Clock offset: 0x0000
>> > HCI Event: Command Status (0x0f) plen 4                       [hci0] 9.449737
>>       Remote Name Request (0x01|0x0019) ncmd 1
>>         Status: Success (0x00)
>> > ACL Data RX: Handle 11 flags 0x02 dlen 12                     [hci0] 9.477736
>>       L2CAP: Connection Request (0x02) ident 1 len 4
>>         PSM: 17 (0x0011)
>>         Source CID: 64
>> < ACL Data TX: Handle 11 flags 0x02 dlen 16                     [hci0] 9.477798
>>       L2CAP: Connection Response (0x03) ident 1 len 8
>>         Destination CID: 64
>>         Source CID: 64
>>         Result: Connection pending (0x0001)
>>         Status: No further information available (0x0000)
>> < ACL Data TX: Handle 11 flags 0x02 dlen 10                     [hci0] 9.477805
>>       L2CAP: Information Request (0x0a) ident 1 len 2
>>         Type: Extended features supported (0x0002)
>> @ Device Connected: 00:07:61:68:55:27 (0) flags 0x0000
>>         04 0d 80 25 00                                   ...%.
>> > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 9.485716
>>         Num handles: 1
>>         Handle: 11
>>         Count: 2
>> > ACL Data RX: Handle 11 flags 0x02 dlen 16                     [hci0] 9.501737
>>       L2CAP: Information Response (0x0b) ident 1 len 8
>>         Type: Extended features supported (0x0002)
>>         Result: Success (0x0000)
>>         Features: 0x00000000
>> < ACL Data TX: Handle 11 flags 0x02 dlen 16                     [hci0] 9.502107
>>       L2CAP: Connection Response (0x03) ident 1 len 8
>>         Destination CID: 64
>>         Source CID: 64
>>         Result: Connection successful (0x0000)
>>         Status: No further information available (0x0000)
>> < ACL Data TX: Handle 11 flags 0x02 dlen 12                     [hci0] 9.502113
>>       L2CAP: Configure Request (0x04) ident 2 len 4
>>         Destination CID: 64
>>         Flags: 0x0000
>> > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 9.507719
>>         Num handles: 1
>>         Handle: 11
>>         Count: 2
>> > HCI Event: Remote Name Req Complete (0x07) plen 255           [hci0] 9.548727
>>         Status: Success (0x00)
>>         Address: 00:07:61:68:55:27 (Logitech Europe SA)
>>         Name: Bluetooth Travel Mouse
>> > ACL Data RX: Handle 11 flags 0x02 dlen 17                     [hci0] 9.555740
>> > ACL Data RX: Handle 11 flags 0x01 dlen 17                     [hci0] 9.556723
>> > HCI Event: QoS Setup Complete (0x0d) plen 21                  [hci0] 9.557718
>>         Status: Success (0x00)
>>         Handle: 11
>>         Flags: 0x00
>>         Service type: Best Effort (0x01)
>>         Token rate: 1511
>>         Peak bandwidth: 0
>>         Latency: 11250
>>         Delay variation: -1
>> > ACL Data RX: Handle 11 flags 0x01 dlen 6                      [hci0] 9.557726
>>       L2CAP: Configure Request (0x04) ident 2 len 32
>>         Destination CID: 64
>>         Flags: 0x0000
>>         Option: Maximum Transmission Unit (0x01)
>>           MTU: 48
>>         Option: Quality of Service (0x03)
>>           Flags: 0x00
>>           Service type: Best Effort (0x01)
>>           Token rate: 0x00000000
>>           Token bucket size: 0x00000000
>>           Peak bandwidth: 0x00000000
>>           Latency: 0x00002bf2
>>           Delay variation: 0xffffffff
>> < ACL Data TX: Handle 11 flags 0x02 dlen 18                     [hci0] 9.557754
>>       L2CAP: Configure Response (0x05) ident 2 len 10
>>         Source CID: 64
>>         Flags: 0x0000
>>         Result: Success (0x0000)
>>         Option: Maximum Transmission Unit (0x01)
>>           MTU: 48
>> > ACL Data RX: Handle 11 flags 0x02 dlen 14                     [hci0] 9.570733
>>       L2CAP: Configure Response (0x05) ident 2 len 6
>>         Source CID: 64
>>         Flags: 0x0000
>>         Result: Success (0x0000)
>> < ACL Data TX: Handle 11 flags 0x02 dlen 5                      [hci0] 9.571076
>>       Channel: 64 len 1 [PSM 17 mode 0] {chan 0}
>>         15                                               .
>> < ACL Data TX: Handle 11 flags 0x02 dlen 12                     [hci0] 9.571284
>>       L2CAP: Disconnection Request (0x06) ident 3 len 4
>>         Destination CID: 64
>>         Source CID: 64
>> > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 9.573737
>>         Num handles: 1
>>         Handle: 11
>>         Count: 2
>> > ACL Data RX: Handle 11 flags 0x02 dlen 12                     [hci0] 9.610754
>>       L2CAP: Connection Request (0x02) ident 3 len 4
>>         PSM: 19 (0x0013)
>>         Source CID: 65
>> < ACL Data TX: Handle 11 flags 0x02 dlen 16                     [hci0] 9.610846
>>       L2CAP: Connection Response (0x03) ident 3 len 8
>>         Destination CID: 65
>>         Source CID: 65
>>         Result: Connection pending (0x0001)
>>         Status: Authorization pending (0x0002)
>> < ACL Data TX: Handle 11 flags 0x02 dlen 16                     [hci0] 9.612931
>>       L2CAP: Connection Response (0x03) ident 3 len 8
>>         Destination CID: 65
>>         Source CID: 65
>>         Result: Connection refused - security block (0x0003)
>>         Status: No further information available (0x0000)
>> > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 9.613738
>>         Num handles: 1
>>         Handle: 11
>>         Count: 2
>> > ACL Data RX: Handle 11 flags 0x02 dlen 12                     [hci0] 9.640735
>>       L2CAP: Disconnection Response (0x07) ident 3 len 4
>>         Destination CID: 64
>>         Source CID: 64
>> > HCI Event: Number of Completed Packets (0x13) plen 5          [hci0] 9.854750
>>         Num handles: 1
>>         Handle: 11
>>         Count: 1
>> < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 13.650261
>>         Handle: 11
>>         Reason: Remote User Terminated Connection (0x13)
>> > HCI Event: Command Status (0x0f) plen 4                      [hci0] 13.652743
>>       Disconnect (0x01|0x0006) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 13.705753
>>         Status: Success (0x00)
>>         Handle: 11
>>         Reason: Connection Terminated By Local Host (0x16)
>> @ Device Disconnected: 00:07:61:68:55:27 (0) reason 2
>>
>>
>> ------------------------------------
>>
>> I also noticed, that after bluetoothd restart, lists of devices and
>> paired-devices are empty:
>
> This looks like issues with storage. Could you check if bluetoothd is able to
> access storage directory (/var/lib/bluetooth) ?

Either this or the mount point gets overwritten/wiped on every boot...



-- 
Luiz Augusto von Dentz
