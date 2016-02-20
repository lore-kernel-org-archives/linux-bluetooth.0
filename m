Return-Path: <tore@fud.no>
Date: Sat, 20 Feb 2016 18:12:59 +0100
From: Tore Anderson <tore@fud.no>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160220181259.1e28f8da@envy.w5.y.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Starting with commit 2ff1389, =C2=ABPerform HCI update for power on
synchronously=C2=BB, my Logitech M555b bluetooth mouse no longer works after
resuming the system from suspend. The devices is handled by Blueman, and
after resuming from suspend the white lines/triangles inside the
systray icon doesn't turn green even though I move the mouse around.
(The lines turning green normally indicates that a device is active.)

In order to revive it, I need to manually disable and then re-enable
bluetooth, at which point it will re-connects fine.

I've also noticed that I need to press Blueman's =C2=ABTurn Bluetooth Off=
=C2=BB
menu selection twice for it to take effect (so that Blueman's systray
icon gets overlayed with a little red X symbol). This only happens once
after each resume from suspend - after having been through one
off-off-on cycle, bluetooth will turn off normally on the first attempt
(until the next suspend/resume cycle). It also turns off normally on
the first attempt after the initial boot-up. This "double-off after
resume" behaviour also first occurred with commit 2ff1389.

Let me know if there's any other information I can provide.

Tore
