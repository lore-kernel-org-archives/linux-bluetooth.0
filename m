Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: acelan@gmail.com
In-Reply-To: <CAMz9Wg--F=f4eOKpjc0aC4ZR7vcCv7Rj-XGewF1zkA7O4CFY2w@mail.gmail.com>
References: <1327895375-9162-1-git-send-email-acelan.kao@canonical.com>
	<1327948421.1955.143.camel@aeonflux>
	<CAMz9Wg--F=f4eOKpjc0aC4ZR7vcCv7Rj-XGewF1zkA7O4CFY2w@mail.gmail.com>
Date: Fri, 9 Mar 2012 10:09:43 +0800
Message-ID: <CAMz9Wg-XvEELt-MhBUvenVdEjff+5Tx9h=1bBQUUmNBc4CbaiA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [0cf3:e004]
From: AceLan Kao <acelan.kao@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Marcel,

Sorry, I didn't get notice about this patch,
is there any update for this patch?

There is no issue for 3.2 kernel and I think we should have the
PID:VID listed in the kernel first.
We could contact Atheros and request they update the firmware if there
is any problem happened in the future.

Best regards,
AceLan Kao.

2012/1/31 AceLan Kao <acelan.kao@canonical.com>:
> Dear Marcel,
>
> I just verified that, on 3.0 kernel, the btusb will be loaded after
> ath3k. That will lead to the problem.
>
> But, on 3.2 kernel, btusb will be loaded before ath3k.
> And I forced it to load ath3k before btusb on 3.2 kernel, and it works
> as expected.
> So, there is no loading order issue on 3.2 kernel.
>
> I removed the wording about the module loading order and reattach it agai=
n.
>
> Best regards,
> AceLan Kao.
>
> 2012/1/31 Marcel Holtmann <marcel@holtmann.org>:
>> Hi AceLan,
>>
>>> Add another vendor specific ID for Atheros BT device
>>>
>>> output of usb-devices:
>>> T: =A0Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D04 Cnt=3D01 Dev#=3D =A04 Spd=
=3D12 =A0MxCh=3D 0
>>> D: =A0Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=
 =A01
>>> P: =A0Vendor=3D0cf3 ProdID=3De004 Rev=3D00.02
>>> S: =A0Manufacturer=3DAtheros Communications
>>> S: =A0Product=3DBluetooth USB Host Controller
>>> S: =A0SerialNumber=3DAlaska Day 2006
>>> C: =A0#Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>>> I: =A0If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
>>> I: =A0If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dr=
iver=3Dbtusb
>>>
>>> BTW, to enable this device correctly, the btusb module should be loaded
>>> before ath3k. So, user should have this line in /etc/modprobe.d/ath3k.c=
onf
>>>
>>> =A0 =A0install ath3k modprobe btusb; modprobe --ignore-install ath3k;
>>
>> NAK. Get this fixed properly then.
>>
>> Regards
>>
>> Marcel
>>
>>
>
>
>
> --
> Chia-Lin Kao(AceLan)
> http://blog.acelan.idv.tw/
> E-Mail: acelan.kaoATcanonical.com (s/AT/@/)



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
