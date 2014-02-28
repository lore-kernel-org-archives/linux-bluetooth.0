Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <530FBB6B.8080300@gmx.net>
References: <530FBB6B.8080300@gmx.net>
Date: Fri, 28 Feb 2014 08:16:45 -0400
Message-ID: <CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

On Thu, Feb 27, 2014 at 6:25 PM, Tobias Jakobi <liquid.acid@gmx.net> wrote:
> That's the server:
> [bluetooth]# info 00:02:72:C6:43:11
> Device 00:02:72:C6:43:11
>         Name: chidori-bt
>         Alias: chidori-bt
>         Class: 0x020000
>         Paired: yes
>         Trusted: yes
>         Blocked: no
>         Connected: no
>         LegacyPairing: no
>         UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>         UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>         UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
>         UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v1D6Bp0246d0509

Looks like you are missing a "power on" on the server side. Notice
that the client side shows "Powered: yes" on the info command.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
