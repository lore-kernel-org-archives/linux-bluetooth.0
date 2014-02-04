Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000201cf21ed$d18f02d0$74ad0870$@lampreynetworks.com>
References: <000201cf21ed$d18f02d0$74ad0870$@lampreynetworks.com>
Date: Tue, 4 Feb 2014 19:05:36 -0400
Message-ID: <CAJdJm_PEQEmCz1owo8MZ+29R-O5u8qm8x85WgeuKy9U1x74zGw@mail.gmail.com>
Subject: Re: possible bug in blueZ 5.8 gatt tool or library
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Caleb Reinhold <creinhold@lampreynetworks.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Caleb,

On Tue, Feb 4, 2014 at 5:12 PM, Caleb Reinhold
<creinhold@lampreynetworks.com> wrote:
> We are working with the 5.8 version of the library, kernel version 3.12.9,
> bluetoothctl, and gatttool when we encountered a possible error.
> We expected on the reconnection of two bonded devices, one of which had
> stored measurements, that data would transfer. When running gatt tool in
> medium security the first measurement to be indicated was lost.

First of all, gatttool is a developer tool, and it is far from being a
compliant GATT endpoint (e.g. it does not report to requests, which is
mandatory by the spec). With moderate effort though, the missing
features can be added.

> However upon attempting to reconnect to the simulated agent device with
> medium security two unexpected behaviors occurred. First, and more
> immediately apparent was that the simulated agent did not receive a
> confirmation of the indication. A slightly closer look using the hcidump,
> trying to find what had happened, showed that the indication had arrived at
> the hci layer but was not received at events_handler.

Are you using gatttool in interactive mode (i.e. the -I option) ? If
yes, try first connecting to the device with "connect" followed by
setting the security level to medium with "sec-level medium". This
will imitate the behavior of the BlueZ daemon when connecting to LE
devices. Also be sure to use the "--listen" option so the confirmation
is sent by gatttool.

Let us know if it works :)

> While the indication
> is sent very swiftly upon the reconnection of the devices we understand this
> to be the manner in which low energy devices are supposed to behave given
> stored measurements and a bonded device.

You are correct that this is the expected behavior. But gatttool is
far from perfect. Did you try implementing a BlueZ plugin?

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
