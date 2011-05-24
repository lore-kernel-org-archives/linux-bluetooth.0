Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306174446.2681.15.camel@aeonflux>
References: <BANLkTi=V_s9UjZ19qk-jivF=0wzPk9XYbA@mail.gmail.com>
	<1305916929.2681.12.camel@aeonflux>
	<BANLkTikahpfAQ48=Mtc5kMkbtC7sQd37sg@mail.gmail.com>
	<BANLkTimpsOoibrke0-v8tRSTpaZr1imJWQ@mail.gmail.com>
	<1306174446.2681.15.camel@aeonflux>
Date: Tue, 24 May 2011 11:54:25 +0800
Message-ID: <BANLkTi=+2VGcAwFBv5JU8JZDtTXQVL++Ow@mail.gmail.com>
Subject: Re: bluez patch : Modify OPUSH sdp record when use sdptool for GOEP v2.0
From: hui li <nami.li1984@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"haijun.liu" <haijun.liu@atheros.com>, steven.li@atheros.com, ruiyi.zhang@atheros.com,
	yang.wu@atheros.com, costa.yao@atheros.com, nami.li@atheros.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/24 Marcel Holtmann <marcel@holtmann.org>:
> Hi Hui,
>
>> =A0 =A0 So you =A0mean you don`t wanna to change currently add_opush
>> ,add_ftp and other obex services functions code?
>> I think instead of opush2, we can add a new goep2 command commonly to
>> sdptool to update service record like below:
>>
>> =A0sdptool goep2 l2cappsm SERVICE
>>
>> And in cmd_goep2 function, I first get that service original sdp
>> record, then update profile version, add new GoepL2capPsm attribute ,
>> and finally update that service record.
>> How do you think about this way ? It doesn`t influnce original command
>> and fuctions. If ok, I will send out my patch.
>
> just to make one thing perfectly clear here. The sdptool should only be
> used for testing. So you can do something like:
>
> =A0 =A0 =A0 =A0sdptool add --psm 2 opush
>
> And only create the extra GOEP 2.0 if the --psm switch is given. However
> it is not acceptable that you break the current behavior.
>
> Regards
>
> Marcel
>
>
>
hi, Marcel

  Can you just add below line in sdp.h ?
 #define SDP_ATTR_GOEP_L2CAP_PSM		0x0200

Because bt 3.0 is mainly used for OBEX and PAN, and the upper layer
code like obexd need this attribute id to determin remote device l2cap
psm to support OBEX over L2CAP . And only obex over l2cap can use bt
high speed.  I think this define in bluez will be more suitable than
in upper layer code.
 I just want to see your aptitude on obex14...

Thanks.
