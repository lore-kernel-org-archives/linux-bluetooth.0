Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <984B6D8C-483D-46C7-A746-2BB28B262F87@holtmann.org>
References: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
 <D83A359C-829A-4DBC-B5CE-1B077CE6B0E4@holtmann.org> <CA+icZUUD92VO52MtynBBQFFPxWkj=pvhm0yDkMYNamvVG4ry9Q@mail.gmail.com>
 <1083ECDC-2292-4372-B85D-DA551EB3FB38@holtmann.org> <CA+icZUVT-fJwamHBSUfHW1KOQU6gx3OeKWgbo7B5oTYmK5dm7g@mail.gmail.com>
 <984B6D8C-483D-46C7-A746-2BB28B262F87@holtmann.org>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 9 Jun 2017 18:24:25 +0200
Message-ID: <CA+icZUVBZZ0pOb8z3ueRaM_LxuTbtGow1K9LEHe77J2_x6v-TQ@mail.gmail.com>
Subject: Re: [Linux-4.9.30] Broadcom BCM20702 bluetooth in ThinkPad-T530 not usable
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 9, 2017 at 6:18 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Sedat,
>
>>>>>> I have some problems using my BCM20702 adapter on my Debian/stretch
>>>>>> 9.0 AMD64 system with Linux v4.9.30 on a ThinkPad-T530 notebook.
>>>>>>
>>>>>
>>>>> can you run =E2=80=9Cbtmon -w trace.log=E2=80=9D and attach that log.=
 I think that I know what is going on, but I want to confirm this.
>>>>>
>>>>
>>>> attached is a 2nd hcidump and the requested trace.log.
>>>
>>> so here is the problem:
>>>
>>> < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
>>>        Mask: 0x0000000000000000
>>>> HCI Event: Command Complete (0x0e) plen 4
>>>      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
>>>        Status: Unknown HCI Command (0x01)
>>>
>>> This controller just does not support this command. Problem is that ear=
lier it told us it did.
>>>
>>> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>>>> HCI Event: Command Complete (0x0e) plen 68
>>>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>        Status: Success (0x00)
>>>        Commands: 162 entries
>>>          ...
>>>          Set Event Mask Page 2 (Octet 22 - Bit 2)
>>>          ...
>>>
>>> Can you provide the output of /sys/kernel/debug/usb/devices that relate=
s to this USB dongle.
>>>
>>> I posted a RFC patch that you might want to try. If that works, I just =
need to include a proper commit message. If it works, please send also the =
btmon -w trace.log for success part.
>>>
>>
>> Hi Marcel,
>>
>> [ /sys/kernel/debug/usb/devices ]
>>
>> T:  Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D03 Dev#=3D  9 Spd=3D12  =
 MxCh=3D 0
>> D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
>> P:  Vendor=3D0a5c ProdID=3D21e6 Rev=3D 1.12
>> S:  Manufacturer=3DBroadcom Corp
>> S:  Product=3DBCM20702A0
>> S:  SerialNumber=3DF82FA8E8CFC0
>> C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Dbtusb
>> E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
>> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
>> I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
>>
>> Can you point me to your RFC patch?
>
> I send it to the mailing list already.
>

Hmm, I am not subscribed to linux-bluetooth ML and cannot find a
patchwork-URL where I can fetch it.
Might sending it to me directly?

Thanks.

- Sedat -
