Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: vtervo@gmail.com
In-Reply-To: <201008131556.22623.oneukum@suse.de>
References: <201008120944.49044.oneukum@suse.de>
	<201008121416.31808.oneukum@suse.de>
	<AANLkTi=odMckPT4pAOiQJm+1NWbk0diL=-9=yKBfj66W@mail.gmail.com>
	<201008131556.22623.oneukum@suse.de>
Date: Fri, 13 Aug 2010 10:08:51 -0400
Message-ID: <AANLkTi=ZFrEk_UaBs++iVPCpgskROa+qnS1_9sm+9=Bq@mail.gmail.com>
Subject: Re: resending patch to retry reset in case it failed
From: Ville Tervo <ville.tervo@iki.fi>
To: Oliver Neukum <oneukum@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On Fri, Aug 13, 2010 at 9:56 AM, Oliver Neukum <oneukum@suse.de> wrote:

>>
>> Could you share also "hciconfig hci0 revision" and "hciconfig hci0
>> version" info. And laptop model you have the chip build in.
>
> The device reported:
>
> localhost:/tmp # hciconfig hci0 version
> hci0: =A0 Type: USB
> =A0 =A0 =A0 =A0BD Address: 00:27:13:98:49:7E ACL MTU: 1021:8 SCO MTU: 64:=
1
> =A0 =A0 =A0 =A0HCI Ver: 3.0 (0x5) HCI Rev: 0x1e1 LMP Ver: 3.0 (0x5) LMP S=
ubver: 0x4203
> =A0 =A0 =A0 =A0Manufacturer: Broadcom Corporation (15)
> localhost:/tmp # hciconfig hci0 revision
> hci0: =A0 Type: USB
> =A0 =A0 =A0 =A0BD Address: 00:27:13:98:49:7E ACL MTU: 1021:8 SCO MTU: 64:=
1
> =A0 =A0 =A0 =A0Firmware 225.66 / 3
>
> The laptop is a prototype. All laptops it was installed in showed the sam=
e
> problem.

Thanks. I don't have access to that hardware and cannot do much without.

hcidump from chip initialization might reveal something. Could you
send the dump also?

--=20
Ville
