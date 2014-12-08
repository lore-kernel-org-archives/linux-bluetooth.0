Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5485F8FB.7090206@gmail.com>
References: <5474BF78.7020501@gmail.com>
	<1685281.NVOr2VMF8E@uw000953>
	<547E3532.8060608@gmail.com>
	<5485F8FB.7090206@gmail.com>
Date: Tue, 9 Dec 2014 00:36:36 +0200
Message-ID: <CABBYNZLTD_AktAVFYtSQuJkCUx7sh5yzJeCsKypeB7GcoTtV6Q@mail.gmail.com>
Subject: Re: User question
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruce,

On Mon, Dec 8, 2014 at 9:16 PM, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> Is no one interested in helping?
>
>   -- Bruce
>
> Bruce Dubbs wrote:
>>
>> Szymon Janc wrote:
>>>
>>> Hi Bruce,
>>>
>>> On Tuesday 25 of November 2014 11:42:16 Bruce Dubbs wrote:
>>>>
>>>> This appears to be a developer list.  Do you accept user level questions
>>>> here?  If not, can you point me to a better place to ask?
>>>>
>>>> I'm trying to get bluez to work in an LFS system and am getting errors.
>>>>    I'd like to get it fixed and document the issues for our community.
>
>
>>> The best way would be to just describe the issue here and provide logs.
>>>
>>> You may also join #bluez-users on irc.freenode.net and ask there
>>> (depending on your timezone you may not get the answer right a way:)
>
>
>> Thanks you for the response.  I took a look at IRC but felt that the
>> data logs would be too much for IRC.
>>
>> What I am trying to do is connect one computer to another via bluetooth.
>>   Both systems are running bluez-5.23 from Debian Jessie.
>>
>> Both systems see each other, but I cannot connect.  This is a typical
>> session:
>>
>>   # bluetoothctl
>> [NEW] Controller AC:7B:A1:C0:2B:E0 debian [default]
>> [NEW] Device 00:17:E9:94:61:AA BlueZ 5.23
>> [NEW] Device 0D:D8:18:0D:AE:30 ZaggKeys Universal
>> [bluetooth]# info 00:17:E9:94:61:AA
>> Device 00:17:E9:94:61:AA
>>          Name: BlueZ 5.23
>>          Alias: BlueZ 5.23
>>          Paired: yes
>>          Trusted: yes
>>          Blocked: no
>>          Connected: no
>>          LegacyPairing: no
>>          UUID: A/V Remote Control Target
>> (0000110c-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control
>> (0000110e-0000-1000-8000-00805f9b34fb)
>>          UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
>>          UUID: Generic Access Profile
>> (00001800-0000-1000-8000-00805f9b34fb)
>>          UUID: Generic Attribute Profile
>> (00001801-0000-1000-8000-00805f9b34fb)
>>          Modalias: usb:v1D6Bp0246d0517
>> [bluetooth]# connect 00:17:E9:94:61:AA
>> Attempting to connect to 00:17:E9:94:61:AA
>> [CHG] Device 00:17:E9:94:61:AA Connected: yes
>> Failed to connect: org.bluez.Error.NotAvailable
>> [CHG] Device 00:17:E9:94:61:AA Connected: no
>> [bluetooth]#

Interesting, it looks like it is a remote controller (AVRCP) not a
real keyboard (HID), iirc AVRCP does not have auto connect flag, that
is probably is why connect fails but ConnectProfile should work.

>> I can get the ZaggKeys keyboard to connect.  But the result from the
>> other system running BlueZ 5.23 is similar to the above.
>>
>> Other information:
>>
>> # dmesg|grep -i blue
>> [    6.796472] toshiba_bluetooth: Detected Toshiba ACPI Bluetooth device
>> - installing RFKill handler
>> [    6.796596] toshiba_bluetooth: Re-enabling Toshiba Bluetooth
>> [    7.688297] Bluetooth: Core ver 2.19
>> [    7.688427] Bluetooth: HCI device and connection manager initialized
>> [    7.688496] Bluetooth: HCI socket layer initialized
>> [    7.688558] Bluetooth: L2CAP socket layer initialized
>> [    7.688626] Bluetooth: SCO socket layer initialized
>> [    8.258758] Bluetooth: hci0: read Intel version: 370710018002030d00
>> [    8.282937] bluetooth hci0: firmware: direct-loading firmware
>> intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>> [    8.282939] Bluetooth: hci0: Intel Bluetooth firmware file:
>> intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>> [    8.380858] Bluetooth: hci0: Intel Bluetooth firmware patch completed
>> and activated
>> [   15.920484] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [   15.921229] Bluetooth: BNEP filters: protocol multicast
>> [   15.921826] Bluetooth: BNEP socket layer initialized
>> ------------------
>>
>> # journalctl |grep blue
>> Dec 02 03:04:46 debian kernel: toshiba_bluetooth: Detected Toshiba ACPI
>> Bluetooth device - installing RFKill handler
>> Dec 02 03:04:46 debian kernel: toshiba_bluetooth: Re-enabling Toshiba
>> Bluetooth
>> Dec 02 03:04:48 debian kernel: bluetooth hci0: firmware: direct-loading
>> firmware intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>> Dec 02 03:04:53 debian bluetoothd[735]: Bluetooth daemon 5.23
>> Dec 02 03:04:55 debian bluetoothd[735]: Starting SDP server
>> Dec 02 03:04:55 debian bluetoothd[735]: Bluetooth management interface
>> 1.6 initialized
>> Dec 02 03:04:56 debian bluetoothd[735]: Sap driver initialization failed.
>> Dec 02 03:04:56 debian bluetoothd[735]: sap-server: Operation not
>> permitted (1)
>> Dec 02 03:04:56 debian bluetoothd[735]: hci0 Load Connection Parameters
>> failed: Unknown Command (0x01)
>>
>> If I remove the device and start over, I get:
>>
>> ---------------------------
>> # scan on
>> Discovery started
>> [CHG] Controller AC:7B:A1:C0:2B:E0 Discovering: yes
>> [NEW] Device 00:17:E9:94:61:AA BlueZ 5.23
>> [CHG] Device 00:17:E9:94:61:AA RSSI: -92
>> [CHG] Device 00:17:E9:94:61:AA RSSI: -54
>> [bluetooth]# devices
>> Device 00:17:E9:94:61:AA BlueZ 5.23
>> [CHG] Device 00:17:E9:94:61:AA RSSI: -68
>> [CHG] Device 00:17:E9:94:61:AA RSSI: -57
>> [bluetooth]# info 00:17:E9:94:61:AA
>> Device 00:17:E9:94:61:AA
>>          Name: BlueZ 5.23
>>          Alias: BlueZ 5.23
>>          Paired: no
>>          Trusted: no
>>          Blocked: no
>>          Connected: no
>>          LegacyPairing: no
>>          UUID: Generic Access Profile
>> (00001800-0000-1000-8000-00805f9b34fb)
>>          UUID: Generic Attribute Profile
>> (00001801-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control
>> (0000110e-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control Target
>> (0000110c-0000-1000-8000-00805f9b34fb)
>>          Modalias: usb:v1D6Bp0246d0517
>> [CHG] Controller AC:7B:A1:C0:2B:E0 Discoverable: no
>> [bluetooth]# pair 00:17:E9:94:61:AA
>> Attempting to pair with 00:17:E9:94:61:AA
>> [CHG] Device 00:17:E9:94:61:AA Connected: yes
>> Request confirmation
>> [agent] Confirm passkey 870856 (yes/no): yes
>> [bluetooth]# info 00:17:E9:94:61:AA
>> Device 00:17:E9:94:61:AA
>>          Name: BlueZ 5.23
>>          Alias: BlueZ 5.23
>>          Paired: no
>>          Trusted: no
>>          Blocked: no
>>          Connected: yes
>>          LegacyPairing: no
>>          UUID: Generic Access Profile
>> (00001800-0000-1000-8000-00805f9b34fb)
>>          UUID: Generic Attribute Profile
>> (00001801-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control
>> (0000110e-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control Target
>> (0000110c-0000-1000-8000-00805f9b34fb)
>>          Modalias: usb:v1D6Bp0246d0517
>> Failed to pair: org.bluez.Error.AuthenticationFailed
>> [CHG] Device 00:17:E9:94:61:AA Connected: no
>>
>> -----------------
>>
>> Any help will be appreciated.
>>
>>    -- Bruce
>>
>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
