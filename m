Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 3 May 2013 10:31:00 -0400
Message-ID: <CAJdJm_MNgzqquKHCtrDPjU3OaaLba6zb=kwCjUnUm-qNccevpw@mail.gmail.com>
Subject: ATT/GATT shared code (Re: [PATCH BlueZ v3 06/16] attrib: Change
 g_attrib_set_destroy_function return type)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 2, 2013 at 12:05 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> I also like to see ATT and GATT being implemented as src/shared/ under LG=
PL so we can be easily share it in the future. I already have some (unpubli=
shed) code for src/shared/att.[ch] and src/shared/gatt.[ch] already, but I =
think what we first need to do is to figure out how we handle clients and s=
ervers from the kernel side. Especially with the background of the kernel a=
uto-connecting LE channels in the future.

We have been working recently on cleaning up GATT/ATT code and
implementing unit tests for it (as you can see from our latest patches
in BlueZ). Is this unpublished code based on existing code, or
something written from scratch? If the latter, I think we should not
spend time on cleaning up existing GATT code.

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
