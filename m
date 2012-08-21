Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYPK6qhJNdpk6-bXaxj2DsUvkvquXQzLZTNDOBmrx3+r7Q@mail.gmail.com>
References: <CACUGKYPK6qhJNdpk6-bXaxj2DsUvkvquXQzLZTNDOBmrx3+r7Q@mail.gmail.com>
Date: Tue, 21 Aug 2012 06:41:07 -0400
Message-ID: <CAJdJm_OC4dcjY-yY4=LsNebeuAFnst4QxCO6oLCLATm9zTHVLA@mail.gmail.com>
Subject: Re: gatt-example plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Mon, Aug 20, 2012 at 9:19 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello Guys,
>
> I was playing with bluez-4.99 for LE. After setting the "EnableGatt to
> true" and re-start the bluetoothd, I was able to connect to the
> advertised services of the bluez. But, I could not figured out how to
> access/load the gatt_example plugin and access the services. Any
> information how to do it?

First, make sure that gatt_example plugin was compiled into
bluetoothd. You can check this by looking at the first lines of the
debug log for this string:

src/plugin.c:add_plugin() Loading gatt_example plugin

As long as you don't pass any "-P" option to bluetoothd, all compiled
plugins will load by default.

Next, you can test GATT operations from a remote device, e.g. some
GATT client you already have or the "gatttool" in BlueZ (running on
another adapter).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
