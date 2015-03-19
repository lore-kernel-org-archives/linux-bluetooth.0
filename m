Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W11EC25DD22E46D52ED6D92D3010@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez5 pairing devices
Date: Thu, 19 Mar 2015 18:26:08 +0530
In-Reply-To: <BAY176-W203E6BB20ECCED0D35B6A7D3010@phx.gbl>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl>,<46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org>,<,<12627750.IG3ACNRtuD@leonov>
 <>>,<BAY176-W40E12E1C2F620AB0D38605D3000@phx.gbl>,<440EB08C-2BD4-4373-B3DC-80361AA74722@holtmann.org>,<BAY176-W203E6BB20ECCED0D35B6A7D3010@phx.gbl>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>> # bluetoothctl
>>> [bluetooth]# power on
>>> No default controller available
>>> [bluetooth]#
>>
>> you need a running bluetoothd for bluetoothctl.
>>
> Isnt bluetoothd part of bluez5 stack ? as I am not able to see it.
>
A further debug showed me this:

Mar 19 12:51:51 evm systemd[1]: Starting Bluetooth service...
Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth daemon 5.29
Mar 19 12:51:51 evm systemd[1]: Started Bluetooth service.
Mar 19 12:51:51 evm bluetoothd[189]: Starting SDP server
Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth management interface 1.1 initialized
Mar 19 12:51:51 evm bluetoothd[189]: Failed to read info for index 54749: Invalid Index (0x11)
Mar 19 12:51:51 evm connmand[149]: Method "ListAdapters" with signature "" on interface "org.bluez.Manager" doesn't exist

org.bluez.Manager service is missing in from services shouldnt it come from bluez5 ?

Regards,
Sagar

>>> Here is output of hciconfig:
>>>
>>> $ hciconfig -a
>>> hci0: Type: BR/EDR Bus: UART
>>> BD Address: 34:B1:F7:E2:DE:CB ACL MTU: 1021:6 SCO MTU: 180:4
>>> UP RUNNING PSCAN ISCAN
>>> RX bytes:12525 acl:56 sco:0 events:262 errors:0
>>> TX bytes:2948 acl:52 sco:0 commands:108 errors:0
>>> Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
>>> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>> Link policy: RSWITCH HOLD SNIFF
>>> Link mode: SLAVE ACCEPT
>>> Name: 'bt_hw'
>>> Class: 0x001f00
>>> Service Classes: Unspecified
>>> Device Class: Invalid Device Class!
>>> HCI Version: 4.1 (0x7) Revision: 0x0
>>> LMP Version: 4.1 (0x7) Subversion: 0xac7c
>>> Manufacturer: Texas Instruments Inc. (13)
>>>
>>> #
>>
>> Just our of curiosity, does this chip support BR/EDR Secure Connections? You might need to check with hciconfig hci0 features or run btmon to see the fully decoded list.
>>
> From the logs seems it does support:
>
> Bluetooth monitor ver 5.29
> = New Index: 34:B1:F7:E2:DE:CB (BR/EDR,UART,hci0)               [hci0] 0.041017
>
> Regards,
> Sagar
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  