Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinBqjTmLiXwd5LkzZRXOkuYkfS=48m6gWQ9AQO7@mail.gmail.com>
References: <AANLkTinBqjTmLiXwd5LkzZRXOkuYkfS=48m6gWQ9AQO7@mail.gmail.com>
Date: Thu, 28 Oct 2010 16:11:40 -0200
Message-ID: <AANLkTimU3vT0MiqiTk0E8mFhVJJWXB5xJ50RosiYHCBy@mail.gmail.com>
Subject: Re: RFCOMM connection from android device to desktop pc
From: Leandro de Oliveira <lehphyro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So, any ideas? Don't you find it strange that bluez can't communicate
with itself?

2010/10/22 Leandro de Oliveira <lehphyro@gmail.com>:
> Hi,
>
> I'm trying to open an RFCOMM connection from my android device to my
> desktop pc running Ubuntu 10.04, send some data, close the connection
> and then do it again. My desktop program is written in Java and relies
> on BlueCove[1] to handle bluetooth details which calls Bluez 4.x in
> this case.
>
> The problem is that I get a successful connection and data transfer in
> the first communication attempt but nothing in subsequent attempts.
>
> There is this thread[2] in the android-platform mailing list with much
> more detail, but I think you could just take a look at this hcidump
> that has been requested there to let me know if this is a problem in
> bluez on the android or desktop side:
> http://dl.dropbox.com/u/1401233/pc-hcidump.txt
>
> Please, let me know if you need more info.
>
> The same program works perfectly when the android application connects
> to it running on Windows 7 using the Microsoft Bluetooth Stack.
>
> [1] http://www.bluecove.org/
> [2] http://groups.google.com/group/android-platform/browse_thread/thread/485db57409304d3e?hl=en
>
> Thank you very much
>
