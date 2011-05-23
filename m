Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez patch : Modify OPUSH sdp record when use sdptool for
 GOEP v2.0
From: Marcel Holtmann <marcel@holtmann.org>
To: hui li <nami.li1984@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"haijun.liu" <haijun.liu@atheros.com>, steven.li@atheros.com,
	ruiyi.zhang@atheros.com, yang.wu@atheros.com,
	costa.yao@atheros.com, nami.li@atheros.com
In-Reply-To: <BANLkTimpsOoibrke0-v8tRSTpaZr1imJWQ@mail.gmail.com>
References: <BANLkTi=V_s9UjZ19qk-jivF=0wzPk9XYbA@mail.gmail.com>
	 <1305916929.2681.12.camel@aeonflux>
	 <BANLkTikahpfAQ48=Mtc5kMkbtC7sQd37sg@mail.gmail.com>
	 <BANLkTimpsOoibrke0-v8tRSTpaZr1imJWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 May 2011 11:14:06 -0700
Message-ID: <1306174446.2681.15.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hui,

>     So you  mean you don`t wanna to change currently add_opush
> ,add_ftp and other obex services functions code?
> I think instead of opush2, we can add a new goep2 command commonly to
> sdptool to update service record like below:
> 
>  sdptool goep2 l2cappsm SERVICE
> 
> And in cmd_goep2 function, I first get that service original sdp
> record, then update profile version, add new GoepL2capPsm attribute ,
> and finally update that service record.
> How do you think about this way ? It doesn`t influnce original command
> and fuctions. If ok, I will send out my patch.

just to make one thing perfectly clear here. The sdptool should only be
used for testing. So you can do something like:

	sdptool add --psm 2 opush

And only create the extra GOEP 2.0 if the --psm switch is given. However
it is not acceptable that you break the current behavior.

Regards

Marcel


