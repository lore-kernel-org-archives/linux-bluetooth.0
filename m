Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55B5DA6E.9060100@tobias.preclik.de>
References: <55B5DA6E.9060100@tobias.preclik.de>
Date: Mon, 27 Jul 2015 11:27:14 +0300
Message-ID: <CABBYNZ+XERxap9yH0avT_QtxcJ8hYwFBpWqqinJzODADNmcAGA@mail.gmail.com>
Subject: Re: Invalid file descriptor gatttool of bluez 5.32
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tobias Preclik <linux-bluetooth@tobias.preclik.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Mon, Jul 27, 2015 at 10:14 AM, Tobias Preclik
<linux-bluetooth@tobias.preclik.de> wrote:
> Hello,
>
> it seems the cleanup process when disconnecting from a bluetooth LE device
> changed in bluez 5.32 but gatttool (attrib/interactive.c:disconnect_io)
> wasn't updated.
>
> $ ./gatttool -I
> [                 ][LE]> connect FF:A7:8C:98:46:B6 random
> Attempting to connect to FF:A7:8C:98:46:B6
> Connection successful
> [FF:A7:8C:98:46:B6][LE]> disconnect
>
> (gatttool:20949): GLib-WARNING **: Invalid file descriptor.
>
> [FF:A7:8C:98:46:B6][LE]> exit
>
> What's the right way to do it in gatttool/bluez 5.32?

There are new tools to use with GATT, bluetoothctl/bluetoothd is the
preferred since with that you have GAP, etc, but if want to use a
stand alone tool then I suggest you use btgatt-client.


-- 
Luiz Augusto von Dentz
