Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Davide Pesavento <davidepesa@gmail.com>
Date: Sat, 29 Aug 2009 01:04:05 +0200
Message-ID: <2da21fe50908281604q64556b0byac38deec59be154d@mail.gmail.com>
Subject: [regression] bluetooth mouse not working on 2.6.31-rc8
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

my bluetooth mouse (Apple Mighty Mouse) doesn't work on 2.6.31-rc8.
It's not a recent regression though, I remember it wasn't working on
-rc2 or -rc3. It works on a 2.6.30 kernel.

The adapter itself seems to work: it's able to scan and find the
mouse, kdebluetooth4 even reports it's connected to it, but the kernel
doesn't print the usual message announcing a new input device and the
pointer on the screen remains motionless.

Thanks,
Davide
