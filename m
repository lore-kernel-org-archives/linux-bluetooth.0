Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W6C88AB3C728FAD951FEC0D30E0@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Szymon Janc <szymon.janc@tieto.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: bluez5 pairing devices
Date: Fri, 20 Mar 2015 15:36:09 +0530
In-Reply-To: <BAY176-W527F50DD202F6D774CBD56D3010@phx.gbl>
References: 
 <BAY176-W679B1127159C091585D3AD3030@phx.gbl>,<,<46068BD2-CF33-4617-80DB-5AE5C1FCA364@holtmann.org>,<,<,<12627750.IG3ACNRtuD@leonov>
 <>>>,<,<BAY176-W40E12E1C2F620AB0D38605D3000@phx.gbl>,<,<440EB08C-2BD4-4373-B3DC-80361AA74722@holtmann.org>,<,<BAY176-W203E6BB20ECCED0D35B6A7D3010@phx.gbl>>>>>,<BAY176-W11EC25DD22E46D52ED6D92D3010@phx.gbl>,<,<CC6FAAF0-122B-4678-9865-F5E237073C09@holtmann.org>
 <>>,<BAY176-W24D0233AE18250D3778E44D3010@phx.gbl>,<03048CAB-EDA3-46D6-A65B-BB17927B1F7E@holtmann.org>,<BAY176-W527F50DD202F6D774CBD56D3010@phx.gbl>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel=2C=0A=
=0A=
>>=0A=
>> maybe the backport has some issues that got fixed. The latest stable ker=
nel is 3.19.2.=0A=
>>=0A=
>>> Is it true we cannot pair LE devices in bluez4.101 ?=0A=
>>=0A=
>> LE support with BlueZ 4 is limited to not really working at all. So if w=
ant to work on LE=2C then you need mgmt API support and a recent Bluetooth =
subsystem and BlueZ 5.=0A=
>>=0A=
> With gattool and hcitool lecc I am able to pair.  But I am not sure How t=
o get the data from le device ?=0A=
> Any pointers on doing this ?=0A=
>=0A=
$ # hcitool=A0 lecc 54:4A:16:5E:1B:9D=0A=
Connection handle 1025=0A=
=0A=
Does it create a fd ? so that me C app can access ?=0A=
=0A=
# gatttool=A0 -b 54:4A:16:5E:1B:9D -I=0A=
[=A0=A0 ][54:4A:16:5E:1B:9D][LE]> connect=0A=
[CON][54:4A:16:5E:1B:9D][LE]> char-desc=0A=
[CON][54:4A:16:5E:1B:9D][LE]> =0A=
handle: 0x0001=2C uuid: 2800=0A=
handle: 0x0002=2C uuid: 2803=0A=
handle: 0x0003=2C uuid: 2a00=0A=
handle: 0x0004=2C uuid: 2803=0A=
handle: 0x0005=2C uuid: 2a01=0A=
=0A=
I am not sure how to get events=2C how to hook for my application and get t=
he packets.=0A=
=A0=0A=
Regards=2C=0A=
Sagar=0A=
 		 	   		  =
