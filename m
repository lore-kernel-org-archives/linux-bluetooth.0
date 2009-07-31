Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090731093949.GA4867@darkstar>
References: <20090725115011.7ddf8d00@lxorguk.ukuu.org.uk>
	 <20090725131046.0f076f37@lxorguk.ukuu.org.uk>
	 <20090727095904.GA5442@darkstar> <4A6D8BA3.3030601@hartkopp.net>
	 <4A6D91D7.6030204@hartkopp.net> <20090727140736.GA1864@darkstar>
	 <4A705604.3040807@hartkopp.net>
	 <a8e1da0907300215q3934da47g3676648e3b247af8@mail.gmail.com>
	 <4A717083.5090101@hartkopp.net> <20090731093949.GA4867@darkstar>
Date: Fri, 31 Jul 2009 18:10:21 +0800
Message-ID: <a8e1da0907310310h483cedeeg433947d51345246c@mail.gmail.com>
Subject: Re: tty_register_device NULL pointer dereference in 2.6.31-rc4
From: Dave Young <hidave.darkstar@gmail.com>
To: Oliver Hartkopp <oliver@hartkopp.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcel Holtmann <marcel@holtmann.org>,
	Linux Netdev List <netdev@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 31, 2009 at 5:39 PM, Dave Young<hidave.darkstar@gmail.com> wrot=
e:
> On Thu, Jul 30, 2009 at 12:05:55PM +0200, Oliver Hartkopp wrote:
>> Dave Young wrote:
>> > On Wed, Jul 29, 2009 at 10:00 PM, Oliver Hartkopp<oliver@hartkopp.net>=
 wrote:
>> >> Hi Dave,
>> >>
>> >> i got it again - even with your patch (that's why it's 2.6.31-rc4-dir=
ty in the
>> >> attached screenshot).
>> >
>> > Weird, the oops occurs between sock init and tty init routines. Could
>> > you tell your bluez version and your configuration?
>> >
>>
>> No problem:
>
> Thanks.
>
> It's still reasonable, after rfcomm sock layer initialized, userspace do =
sock ioctl callback but tty layer was not initilized yet at this time.
>
> Could you confirm it by applying following debug patch on top of my previ=
ous patch? if you get more oops with it then above reason will be right.
>
> --- linux-2.6.orig/net/bluetooth/rfcomm/core.c =C2=A02009-07-31 17:14:07.=
000000000 +0800
> +++ linux-2.6/net/bluetooth/rfcomm/core.c =C2=A0 =C2=A0 =C2=A0 2009-07-31=
 17:30:39.000000000 +0800
> @@ -36,6 +36,7 @@
> =C2=A0#include <linux/net.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/kthread.h>
> +#include <linux/nmi.h>
>
> =C2=A0#include <net/sock.h>
> =C2=A0#include <asm/uaccess.h>
> @@ -2080,7 +2081,7 @@ static CLASS_ATTR(rfcomm_dlc, S_IRUGO, r
> =C2=A0/* ---- Initialization ---- */
> =C2=A0static int __init rfcomm_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 int ret, i;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0l2cap_load();
>
> @@ -2088,6 +2089,12 @@ static int __init rfcomm_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_sock;
>
> + =C2=A0 =C2=A0 =C2=A0 /* delay 5 seconds to trigger the tty bug */
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < 50; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 touch_nmi_watchdog();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(100);

Hi, for this case, msleep is better, you can just replace the above
two lines with msleep(100)

> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rfcomm_init_ttys();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_tty;
>



--=20
Regards
dave
