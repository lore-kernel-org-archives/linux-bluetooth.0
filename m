Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <67399724.T38U7nJAul@arawn>
References: <67399724.T38U7nJAul@arawn>
Date: Thu, 13 Sep 2012 12:54:26 -0400
Message-ID: <CAJdJm_MY_TZqay8L0=qOXy3kFkM4RMsXgRKKh1nK7ukokB7WqA@mail.gmail.com>
Subject: Re: Connecting to Bluetooth Low Energy devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Philipp Claves <claves@budelmann-elektronik.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philipp,

On Thu, Sep 13, 2012 at 11:34 AM, Philipp Claves
<claves@budelmann-elektronik.com> wrote:
> Hello
>
> Trying  to get started with Bluetooth Low Energy devices, i used hcitool and
> gatttool to enumerate device attributes, but did not get far:
>
> # hcitool lescan
> LE Scan ...
> <MAC-Device1> Battery V1.0
> <MAC-Device1> (unknown)
> <MAC-Device2> Battery V1.0
> <MAC-Device2> (unknown)
> ^C
>
> # gatttool -b <MAC-Device1> -I
> [   ][<MAC-Device1>][LE]> connect
> Connecting... connect error: connect error: Connection refused (111)
> [   ][<MAC-Device1>][LE]>
>
> This is all i get.

Which kernel version are you running?

> Am i doing something obviously wrong?
> Any tips where to get more information about the error (dmesg shows nothing)?

run "hcidump -X" and check the logs while you run "hcitool lescan".
Then check the type of advertising those devices are sending. They
should be connectable advertisings to be able to connect to them. Also
check the address type, if it is "Random" you need to pass "-t random"
to gatttool.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
