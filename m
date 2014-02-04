Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Feb 2014 19:57:06 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Alejandro Exojo <aexojo@modpow.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How do you install bluez for development?
Message-ID: <20140204215706.GA1967@molly>
References: <CACMtdhhCecEWiK33A6uNSQr-=iRJSehfbJCqb0Maxpq-8WjkPA@mail.gmail.com>
 <20140203183606.GA12511@molly>
 <CACMtdhhnvG_PopNn185npxi2nSqzFSLXthoh6PPPTh4SGj_uiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACMtdhhnvG_PopNn185npxi2nSqzFSLXthoh6PPPTh4SGj_uiA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alejandro,

On 08:28 Tue 04 Feb, Alejandro Exojo wrote:
> 2014-02-03 Vinicius Costa Gomes <vcgomes@gmail.com>:
> >> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth service...
> >> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Bluetooth daemon 5.14
> >> Feb 03 17:14:38 PC-MW03 systemd[1]: Started Bluetooth service.
> >> Feb 03 17:14:38 PC-MW03 systemd[1]: Starting Bluetooth.
> >> Feb 03 17:14:38 PC-MW03 systemd[1]: Reached target Bluetooth.
> >> Feb 03 17:14:38 PC-MW03 bluetoothd[22571]: Failed to access management interface
> >
> > Two probable causes, your kernel is older than 3.4, or the user that is running
> > bluetoothd doesn't have the CAP_NET_ADMIN capability.
>
> True! I was running 3.2. I've installed a more recent one, and I got
> it working. Thank you very much, I would not have thought of the
> kernel at all.
>
> How come that at least 3.4 is needed?

That was the kernel version that enabled the management interface by default, which is a
runtime requirement for BlueZ 5.x.

>
> Thank you again.
>
> Cheers.
> --
> Alejandro Exojo Piqueras
>
> ModpoW, S.L.
> Technova LaSalle | Sant Joan de la Salle 42 | 08022 Barcelona | www.modpow.es
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
