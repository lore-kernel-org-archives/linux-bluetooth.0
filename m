Return-Path: <prvs=1570335fbc=julia.cartwright@ni.com>
Date: Thu, 1 Feb 2018 13:01:50 -0600
From: Julia Cartwright <julia@ni.com>
To: Mirza Krak <mirza.krak@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
        <linux-rt-users@vger.kernel.org>
Subject: Re: High CPU load when using USB Bluetooth on 4.14.15-rt13 kernel
Message-ID: <20180201190150.GA868@jcartwri.amer.corp.natinst.com>
References: <CALw8SCWyD8-AVtqKvPZeNQuyLfvvdLe7ZtRWuh9KH09WNDDHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CALw8SCWyD8-AVtqKvPZeNQuyLfvvdLe7ZtRWuh9KH09WNDDHuA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:58:28AM +0100, Mirza Krak wrote:
> Hi.

Hello Mirza.

[..]
> I have tried running a 4.14.15 vanilla kernel, and this does not have
> this problem which means that it is the following combo
>
>     RT + USB Bluetooth
>
> That seem to the problem.
>
> Before I start digging deep in to the stacks I wanted to post my
> problem to the community to see if someone is having a similar problem
> on a different hardware or if you have any pointers on how to further
> debug this.

One suggestion I would have would be to re-do your testing on mainline
v4.14.15 booted with the 'threadirqs' kernel command line parameter.

The reason being that without this option, interrupts aren't threaded in
mainline, so it very well could be that your hardware is still
misbehaving, however it's execution time just isn't being accounted for
in the same way.

   Julia
