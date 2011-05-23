Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikahpfAQ48=Mtc5kMkbtC7sQd37sg@mail.gmail.com>
References: <BANLkTi=V_s9UjZ19qk-jivF=0wzPk9XYbA@mail.gmail.com>
	<1305916929.2681.12.camel@aeonflux>
	<BANLkTikahpfAQ48=Mtc5kMkbtC7sQd37sg@mail.gmail.com>
Date: Mon, 23 May 2011 15:05:25 +0800
Message-ID: <BANLkTimpsOoibrke0-v8tRSTpaZr1imJWQ@mail.gmail.com>
Subject: Re: bluez patch : Modify OPUSH sdp record when use sdptool for GOEP v2.0
From: hui li <nami.li1984@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"haijun.liu" <haijun.liu@atheros.com>, steven.li@atheros.com, ruiyi.zhang@atheros.com,
	yang.wu@atheros.com, costa.yao@atheros.com, nami.li@atheros.com
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/21 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi,
>
> On Fri, May 20, 2011 at 9:42 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Hui,
>>
>>> =A0Since GOEP v2.0 has some changes in sdp record, I`d like to add the
>>> two changes in bluez for backwards compatibility with GOEP v1.x:
>>> =95 The profile version number in the BluetoothProfileDescriptorList
>>> attribute shall be incremented to match the version number of the
>>> enhanced profile specification. If earlier versions of the profile do
>>> not include this SDP attribute it shall be included in revised
>>> versions.
>>> =95 The SDP records shall include the GoepL2capPsm attribute.
>>>
>>> The upper text references Generic Object Exchange Profile v2.0.
>>> The GoepL2capPsm attribute value can be found in Bluetooth SIG
>>> Assigned Numbers =96 Service Discovery, and this value is 0x0200.
>>>
>>> My patch only define GoepL2capPsm and change OPUSH sdp record in
>>> sdptool. I didn`t assign a new variable in svc_info_t struct to
>>> indicate the new l2cap psm value, I used its original psm member to
>>> indicate l2cap psm value.
>>> Also, I didn`t found OPUSH l2cap psm default value in Bluetooth SIG
>>> Assigned Numbers or its spec, so I just choose 0x1015 as its default
>>> value.
>>
>> please do not update opush record details since we are using that one
>> for qualification and I don't wanna redo all my SDP data.
>>
>> Just add an opush2 command to sdptool to add a GOEP 2.0 SDP record.
>
> Btw, GoepL2capPsm seems to be random/user defined like RFCOMM
> channels, maybe we could adopt the non-reserved psm base + original
> RFCOMM channel in pre 2.0?
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Hi, Marcel
    So you  mean you don`t wanna to change currently add_opush
,add_ftp and other obex services functions code?
I think instead of opush2, we can add a new goep2 command commonly to
sdptool to update service record like below:

 sdptool goep2 l2cappsm SERVICE

And in cmd_goep2 function, I first get that service original sdp
record, then update profile version, add new GoepL2capPsm attribute ,
and finally update that service record.
How do you think about this way ? It doesn`t influnce original command
and fuctions. If ok, I will send out my patch.
Thanks.

Hi, Luiz
  I think it`s a good idear to adopt the non-reserved psm base +
original RFCOMM channel for the L2CAP Psm. I will change my default
value as your suggestion.

Thanks .
Hui
