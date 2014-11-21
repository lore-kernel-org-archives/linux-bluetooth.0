Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANpMpoQoBhmprKEkrJrA1cdmwX=JvabtiJpm64hnxnR46MEFDA@mail.gmail.com>
References: <CANpMpoQoBhmprKEkrJrA1cdmwX=JvabtiJpm64hnxnR46MEFDA@mail.gmail.com>
Date: Fri, 21 Nov 2014 11:12:16 -0800
Message-ID: <CAHrH25RdVd0DWRy8Z6sheHvhYQtCcPJdyg0_2aVSisSCcG4S-g@mail.gmail.com>
Subject: Re: Where in the code is a BLE connection accepted?
From: Arman Uguray <armansito@chromium.org>
To: =?UTF-8?Q?Gilles_Gr=C3=A9goire?= <gilles.gregoire@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gilles,

> On Fri, Nov 21, 2014 at 12:03 AM, Gilles Grégoire <gilles.gregoire@gmail.com> wrote:
> Hi,
>
> I am trying to understand how a BLE connection is established between
> my embedded system and an Android phone. I am using bluez 5.9 on a
> 3.12 kernel on this embedded system; with a CSR chipset.
>
> I set up bluetooth using:
> hciconfig hci0 reset
> hciconfig hci0 noscan
>
> Then, I use hcitool to set the advertisement and scan data, and I
> enable a connectable advertisement with
> hcitool -i hci0 cmd 0x08 0x000a 01
>
> I am _not_ using bluetoothd.
>
> With this simple setup, I can connect with an Android phone to my
> embedded system.
> I check it with:
> hcitool -i hci0 con
>
> Which reports one active connection.
>
> I had a look at the hciconfig and hcitool source code (the only tools
> I used to setup bluetooth), but could not find where a connection is
> accepted.
>
> My question is: where (in the code) is the connection accepted in the
> first place?
>
> Thanks!
>
> -- Gilles
>
> PS: my excuses for this repost. I realized that I forgot to set a
> subject for the initial version of this e-mail sent on this list
> yesterday.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

If you're using just hcitool (and someone correct me if I'm wrong)
then the kernel will accept the connection but won't magically hand it
over to userland unless someone is listening for incoming connections.
For that you would have to create an L2CAP socket and listen on it.
Once a connection is accepted then you can use the returned socket
just as you would with any UNIX socket over which you can exchange
data.

You can look at tools/btgatt-server.c for an example of listening for
incoming LE L2CAP connections on the ATT channel.

Thanks,
Arman
