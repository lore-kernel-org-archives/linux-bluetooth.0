Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2da21fe50908281604q64556b0byac38deec59be154d@mail.gmail.com>
References: <2da21fe50908281604q64556b0byac38deec59be154d@mail.gmail.com>
Date: Sat, 29 Aug 2009 07:37:05 +0200
Message-ID: <a70b8cd30908282237u3d584d0dnc690f517f43bc2b3@mail.gmail.com>
Subject: Re: [regression] bluetooth mouse not working on 2.6.31-rc8
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Davide,
2009/8/29, Davide Pesavento <davidepesa@gmail.com>:
>  The adapter itself seems to work: it's able to scan and find the
>  mouse, kdebluetooth4 even reports it's connected to it, but the kernel
>  doesn't print the usual message announcing a new input device and the
>  pointer on the screen remains motionless.
>
Do you have uinput module loaded? Is /proc/bus/input/devices listing
the mouse while it is connected?

-- 
----
Looking forward to reading yours.
 RUFF-RIPE DI76-GANDI RUFF-6BONE
     Ruslan N. Marchenko
