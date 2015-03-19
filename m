Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W527F50DD202F6D774CBD56D3010@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Szymon Janc <szymon.janc@tieto.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: bluez5 pairing devices
Date: Fri, 20 Mar 2015 01:30:38 +0530
In-Reply-To: <03048CAB-EDA3-46D6-A65B-BB17927B1F7E@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl>
 <,<46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org>
 <,<,<12627750.IG3ACNRtuD@leonov> <>>>
 <,<BAY176-W40E12E1C2F620AB0D38605D3000@phx.gbl>
 <,<440EB08C-2BD4-4373-B3DC-80361AA74722@holtmann.org>
 <,<BAY176-W203E6BB20ECCED0D35B6A7D3010@phx.gbl>>>>>
 <BAY176-W11EC25DD22E46D52ED6D92D3010@phx.gbl>
 <,<CC6FAAF0-122B-4678-9865-F5E237073C09@holtmann.org> <>>
 <BAY176-W24D0233AE18250D3778E44D3010@phx.gbl>,<03048CAB-EDA3-46D6-A65B-BB17927B1F7E@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel=2C=0A=
=0A=
>=0A=
>>>>>>> # bluetoothctl=0A=
>>>>>>> [bluetooth]# power on=0A=
>>>>>>> No default controller available=0A=
>>>>>>> [bluetooth]#=0A=
>>>>>>=0A=
>>>>>> you need a running bluetoothd for bluetoothctl.=0A=
>>>>>>=0A=
>>>>> Isnt bluetoothd part of bluez5 stack ? as I am not able to see it.=0A=
>>>>>=0A=
>>>> A further debug showed me this:=0A=
>>>>=0A=
>>>> Mar 19 12:51:51 evm systemd[1]: Starting Bluetooth service...=0A=
>>>> Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth daemon 5.29=0A=
>>>> Mar 19 12:51:51 evm systemd[1]: Started Bluetooth service.=0A=
>>>> Mar 19 12:51:51 evm bluetoothd[189]: Starting SDP server=0A=
>>>> Mar 19 12:51:51 evm bluetoothd[189]: Bluetooth management interface 1.=
1 initialized=0A=
>>>> Mar 19 12:51:51 evm bluetoothd[189]: Failed to read info for index 547=
49: Invalid Index (0x11)=0A=
>>>=0A=
>>> this looks like an endian bug to me. That is no a valid index. Unless y=
ou really added 54749 Bluetooth dongles on your system. So something is scr=
ewed up that that needs to be investigated.=0A=
>>>=0A=
>> Not sure what=92s wrong here! because I have ported v3.5 bluetooth stack=
.=0A=
>=0A=
> maybe the backport has some issues that got fixed. The latest stable kern=
el is 3.19.2.=0A=
>=0A=
>> Is it true we cannot pair LE devices in bluez4.101 ?=0A=
>=0A=
> LE support with BlueZ 4 is limited to not really working at all. So if wa=
nt to work on LE=2C then you need mgmt API support and a recent Bluetooth s=
ubsystem and BlueZ 5.=0A=
>=0A=
With gattool and hcitool lecc I am able to pair.=A0 But I am not sure How t=
o get the data from le device ?=0A=
Any pointers on doing this ?=0A=
=0A=
Thanks for your support.=0A=
=0A=
Regards=2C=0A=
Sagar=0A=
 		 	   		  =
