Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602231329r446c015bh172515b7eebec548@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] GetServiceClasses
In-Reply-To: <1140729493.24721.69.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0602231250q18912898td65b1ff0edf278@mail.gmail.com>
	 <1140729493.24721.69.camel@localhost>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 18:29:56 -0300

Hi Marcel,


On 2/23/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is the GetServiceClasses service.
>
> the patch has been applied. So what have been left?
[Claudio Takahasi]
- GetFeatures
- PinCodeLength
- EncryptionKeySize
- MinorClassChanged
- dbus-test update

I am going home now. I think we can try finish it until tomorrow.
SDP will be another history, I think we can try develop it after the Carniv=
al :)

Regards,
Claudio.

>
> > There are some shared constants(major classes, minor classes and
> > service classes) used by hciconfig.c and dbus-device.c. Maybe we could
> > put it in a common place.
>
> Keep them separate. It is not worth trying to move stuff around at this
> point.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
