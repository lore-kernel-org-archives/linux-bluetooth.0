Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0F2EE81A-0DB1-44DF-8EFD-F0835B090B7E@holtmann.org>
References: <530FB0CA.4070309@gmail.com>
	<613439C8-AFCE-4B23-81FE-AD4B91A27768@holtmann.org>
	<530FC224.90305@gmail.com>
	<0F2EE81A-0DB1-44DF-8EFD-F0835B090B7E@holtmann.org>
Date: Fri, 28 Feb 2014 21:26:46 +0100
Message-ID: <CAE5S2EnDWG28nraphCROhj7iWzMcLHBhFPbfaSCYYUzg0j1veQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: ath3k: added Atheros AR3012 with ID 0x0b05:0x17d0
From: Bela Hausmann <bela.hausmann@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I would, but I just now noticed that you already added this device ID
a few days ago in commit a735f9e22432899cee188d167966782c29246390 to
linux-next [1]. Thank you!

Best wishes,
Bela

[1] https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/drivers/bluetooth?id=3Da735f9e22432899cee188d167966782c29246390

2014-02-28 0:19 GMT+01:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Bela,
>
>> Hi Marcel,
>>
>> sorry for the messed up tabs.
>>
>> Here is /sys/kernel/debug/usb/devices:
>> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D02 Dev#=3D  4 Spd=3D12  =
 MxCh=3D 0
>> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
>> P:  Vendor=3D0b05 ProdID=3D17d0 Rev=3D 0.02
>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>
>> An again the patch.
>>
>> Best wishes,
>> Bela
>
> why don=E2=80=99t you use git-format-patch and git-send-email. Just save =
the email you send as raw text and see what happens if you apply it with gi=
t-am and then look at git-log.
>
> Regards
>
> Marcel
>
