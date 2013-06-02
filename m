Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <33F0ED7F-C1AA-4B03-A585-DCBAE5E667E5@holtmann.org>
References: <1370056311-14199-1-git-send-email-anderson.lizardo@openbossa.org>
	<33F0ED7F-C1AA-4B03-A585-DCBAE5E667E5@holtmann.org>
Date: Sun, 2 Jun 2013 12:00:19 -0400
Message-ID: <CAJdJm_NcSO36+z_ib9gP5QVpZ8-z1fikxuR2xbXP6nmyt5p-iA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add parameter validation for ioctl(HCISETACLMTU)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jun 1, 2013 at 6:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Anderson,
>
>> Setting ACL MTU to a very low value (or even zero) causes access to
>> invalid memory when creating L2CAP connections. The minimum value of 48
>> was taken from the L2CAP minimum allowed MTU for BR/EDR (this ioctl() is
>> not applicable for LE).
>
> and the value 48 is totally wrong here. Please check the definition of a =
L2CAP C-frame and table 4.1 which defines the minimum payload as 23 octets =
for LE-U. We could argue that this ioctl only sets ACL-U, but nevertheless =
this seems kinda weird as well.

The reason 48 was used is because this ioctl only affects ACL link
types. LE ones are not affected.

> Why are we forcing L2CAP restrictions on a lower-layer here. If someone w=
ants to shoot themselves in the foot, they are allowed to do so. We need to=
 make sure that L2CAP works with whatever value we have here. Since essenti=
ally even a broken controller can give us wrong values.

I was going to send another patch that fixes the same issue for broken
"Read Buffer Size" HCI command implementations. But if you prefer, I
can instead fix all places where some minimum MTU is expected.

>> Also make sure the "maximum number of ACL packets" parameter is at least
>> 1, otherwise no connections can be created.
>
> Again, I am fine if people want to shoot themselves in the foot here. We =
need to just make sure L2CAP works properly.

Setting to zero simply makes the connection attempt to hang (and
eventually abort), but I didn't notice persistent issues. Will do more
tests to make sure.

> We might better fix l2cap_build_cmd here to fail if we are trying to buil=
d a frame that is larger than our ACL MTU. As I said, if a misbehaving cont=
roller gives us a too small value, we might be in trouble as well.

IIRC there are other places where a minimum MTU is expected. Should I
go ahead and fix all these locations?

> We have seen controllers giving us 0 buffer sizes for SCO packets in the =
past before. So this just need to be robust.

I noticed this quirk on the kernel code. But the "fix" there is to
assume a minimum buffer size in these cases instead of just refusing
to use the controller.

In summary, what's the best approach here?

1) Fail loudly if the controller or the user wants to use too small
buffer sizes; or
2) Ignore the given value and use the minimum value allowed by the
spec (23 for LE-U and 48 for ACL-U)

Best Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
