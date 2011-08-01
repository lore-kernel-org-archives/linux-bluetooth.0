Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACbkbUJ9wC4ZgAuhJ89ee4MVV+QugHNu0uAh+vhc8A7aJ1MwXw@mail.gmail.com>
References: <CACbkbUJ9wC4ZgAuhJ89ee4MVV+QugHNu0uAh+vhc8A7aJ1MwXw@mail.gmail.com>
Date: Mon, 1 Aug 2011 14:46:14 -0300
Message-ID: <CAKT1EBerKVhx8tL_i_9DJ+kYobaYBRoQ46PR7PK+At00qaPD8Q@mail.gmail.com>
Subject: Re: Advertising cache and random address support
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: VISHWANATH KM <a21174@motorola.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Andre Guedes <andre.guedes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishwanath,

On Mon, Aug 1, 2011 at 10:29 AM, VISHWANATH KM <a21174@motorola.com> wrote:
> Hi,
>
> Advertising cache seem to temporarily store the peer_addr_type info,
> if we reboot, then we loose the information and subsequent connection
> fails as we don't have the peer_addr_type, unless we re-scan

we are aware about this limitation. Andre Guedes is already working on it.

>
> The better approach may be
> 1) bluez while receiving the advertising events would also store the
> peer_addr_type info ( may be in dev_info structure in hciops )
> 2) while initiating connection bluez may pass the peer_addr_type as
> part of  bt_io_connect in l2cap_connect (attrib/client.c) as part of
> new option BT_IO_OPT_
>
> Please let me know your comments on above, or if any better
> approaches/alternatives on the same, thx

We are trying to keep the consistency between Basic Rate and BLE,
avoiding transport specific parameters in the Bluetooth socket
operations.
Passive scanning needs to be executed if the address is not found in
the cache, otherwise re-connections will not work. In BlueZ it is
necessary to address multiple connections, so probably the final
solution will use passive scanning "together" with LE create
connection(using whitelist or general connection procedure). Remember
that address resolution is handled by the host, this is another
argument to implement passive scanning in the kernel.

Are you working in the Android team? I'd be good cooperation and
interoperability tests.
I sent some Proximity patches to the ML, let me know if you have
comments about the proposed Proximity API changes and the
implementation. You can find the git repository address in the email
that I sent last week: "Current status on BLE development".

Regards,
Claudio.

>
> Regards
> Vishwanath
