Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4C851F03BEE04A418B7A2D283DDCAB5D27C95F71@EFJDFWMB01.EFJDFW.local>
References: <4C851F03BEE04A418B7A2D283DDCAB5D27C95F71@EFJDFWMB01.EFJDFW.local>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Aug 2017 13:24:02 +0300
Message-ID: <CABBYNZJKXF=d1=0skuus1Qr_gCY66b8Jc08ZQi7v3U=E6TLhxA@mail.gmail.com>
Subject: Re: Operate on BlueZ provided file descriptor in C
To: Austin Riffle <ARiffle@efji.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Austin,

On Thu, Aug 10, 2017 at 5:06 AM, Austin Riffle <ARiffle@efji.com> wrote:
> Hello
>
> I am attempting to work with the org.bluez.Profile1 in BlueZ 5.44. When c=
onnecting with a new device via the NewConnection DBus method, we get a fil=
e descriptor to work with. I am fairly confused on what state this file des=
criptor is in, and what I need to do in order to read/write from it. Simply=
 calling read/write does not behave as expected for me.
>
> In the file test/test-profile, I see this line of python code:
>
> self.fd =3D fd.take()
>
> I am struggling to find the Linux C equivalent to the take method, as I b=
elieve this is what I need to do to operate on the fd. Any advice on how to=
 configure this fd in Linux C code so I can read/write with the fd would be=
 very helpful!

Though the code bellow is not handling the NewConnection it should
give you clear picture how to deal with file descriptors:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/gatt.c#n750

Or in case of actual NewConnection you can check how PulseAudio
implements it for HSP:

https://github.com/pulseaudio/pulseaudio/blob/master/src/modules/bluetooth/=
backend-native.c#L492

> Thanks
> Austin
> This e-mail transmission, and any documents, files or previous e-mail mes=
sages attached to it, may contain confidential information. If you are not =
the intended recipient, or a person responsible for delivering it to the in=
tended recipient, you are hereby notified that any disclosure, distribution=
, review, copy or use of any of the information contained in or attached to=
 this message is STRICTLY PROHIBITED. If you have received this transmissio=
n in error, please immediately notify us by reply e-mail, and destroy the o=
riginal transmission and its attachments without reading them or saving the=
m to disk. Thank you.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
