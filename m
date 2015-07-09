Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANzaTi4dRy_bLKc5BNPdyK2wVm6crq8bS8UaSrecwZ6gLqY7HQ@mail.gmail.com>
References: <CANzaTi5iskY=SpmnScctm7iTTV1CXhBimunuqezjKvVycTuSxg@mail.gmail.com>
	<CABBYNZJwwEnyNw-D1i38xJjPsmujz+C_E5t3NqXB-G8rM8N_SQ@mail.gmail.com>
	<CANzaTi4dRy_bLKc5BNPdyK2wVm6crq8bS8UaSrecwZ6gLqY7HQ@mail.gmail.com>
Date: Thu, 9 Jul 2015 17:32:47 +0200
Message-ID: <CANzaTi59tx+vnMuLZW4Jh7K1-ge39fy0zE43qw8aV5eDN4GTqw@mail.gmail.com>
Subject: Re: Advertising api, bluez sends empty scan response
From: dogan yazar <doganyazar@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And this is the output from the bluetoothd after I run example-advertisement>

bluetoothd[2456]: src/advertising.c:register_advertisement()
RegisterAdvertisement
bluetoothd[2456]: src/advertising.c:advertisement_create() Adding
proxy for /org/bluez/example/advertisement0
bluetoothd[2456]: src/advertising.c:register_advertisement()
Registered advertisement at path /org/bluez/example/advertisement0
bluetoothd[2456]: src/advertising.c:parse_advertising_service_uuids()
Adding ServiceUUID: 180D
bluetoothd[2456]: src/advertising.c:parse_advertising_service_uuids()
Adding ServiceUUID: 180F
bluetoothd[2456]:
src/advertising.c:parse_advertising_manufacturer_data() Adding
ManufacturerData for ffff
bluetoothd[2456]: src/advertising.c:parse_advertising_service_data()
Adding ServiceData for 9999
bluetoothd[2456]: src/advertising.c:refresh_advertisement() Refreshing
advertisement: /org/bluez/example/advertisement0
bluetoothd[2456]: src/advertising.c:add_advertising_callback()
Advertisement registered: /org/bluez/example/advertisement0

On Thu, Jul 9, 2015 at 5:20 PM, dogan yazar <doganyazar@gmail.com> wrote:
> Hi Luiz,
>
> I tried with 2 BT 4.0 dongles both of which have the same problem. And
> instead of running example-advertisement, if I run the following
> commands 2 commands manually, it works fine and I can discover and
> connect to my device:
> hcitool -i hci0 cmd 0x08 0x0008 3 02 01 05
> hciconfig hci0 leadv
>
> So I only have problem with the dbus advertising api. Copying the
> commands and output from btmon below. example-advertisement does not
> seem to set and advertisement data at all.
>
>
> //Run example-advertisement
>
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>                                                    [hci0] 7.258091
>         Advertising: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                                                               [hci0] 7.259431
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
>                                                    [hci0] 7.259540
>         Min advertising interval: 1280.000 msec (0x0800)
>         Max advertising interval: 1280.000 msec (0x0800)
>         Type: Connectable undirected - ADV_IND (0x00)
>         Own address type: Public (0x00)
>         Direct address type: Public (0x00)
>         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>         Channel map: 37, 38, 39 (0x07)
>         Filter policy: Allow Scan Request from Any, Allow Connect
> Request from Any (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                                                               [hci0] 7.260346
>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>                                                    [hci0] 7.260444
>         Advertising: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                                                                               [hci0] 7.261344
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
>
>
>
>
>
> //hcitool -i hci0 cmd 0x08 0x0008 3 02 01 05
>
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 4
>                                                  [hci0] 288.328182
>         invalid packet size
>         03 02 01 05                                      ....
>> HCI Event: Command Complete (0x0e) plen 4                                                                             [hci0] 288.329444
>       LE Set Advertising Data (0x08|0x0008) ncmd 1
>         Status: Success (0x00)
>
>
>
>
> //hciconfig hci0 leadv
>
> < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
>                                                  [hci0] 343.872012
>         Min advertising interval: 1280.000 msec (0x0800)
>         Max advertising interval: 1280.000 msec (0x0800)
>         Type: Connectable undirected - ADV_IND (0x00)
>         Own address type: Public (0x00)
>         Direct address type: Public (0x00)
>         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>         Channel map: 37, 38, 39 (0x07)
>         Filter policy: Allow Scan Request from Any, Allow Connect
> Request from Any (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                                                             [hci0] 343.872852
>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>                                                  [hci0] 343.880238
>         Advertising: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                                                                             [hci0] 343.880842
>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>         Status: Success (0x00)
>
> On Thu, Jul 9, 2015 at 2:45 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Thu, Jul 9, 2015 at 3:15 PM, dogan yazar <doganyazar@gmail.com> wrote:
>>> Hello,
>>> I am using Bluez 5.32 on kernel 4.1.
>>>
>>> When I run advertisement-example, bluez successfully sends
>>> advertisement but then as an answer to scan request it sends an empty
>>> scan response.
>>>
>>> Any idea what can be the problem?
>>
>> Could you please add the trace, iirc BlueZ only set the scan data so
>> it is up to the controller to generate the scan response not the host
>> stack so perhaps there is something wrong with your controller.
>>
>>
>> --
>> Luiz Augusto von Dentz
