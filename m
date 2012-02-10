Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20120210100809.GB28736@pcnci.linuxbox.cz>
References: <CA+55aFyDE+chjpt9N5yNG=+A_LL5qhZjPYfOjFGuZcXUPGEoOQ@mail.gmail.com>
 <20120210100809.GB28736@pcnci.linuxbox.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Feb 2012 08:56:29 -0800
Message-ID: <CA+55aFw9wOUbJKm7vVZYzFfKucanX43T2RwKoEfvNiVeEJP-2A@mail.gmail.com>
Subject: Fwd: Linux 3.3-rc3
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

This seems to have gotten lost somewhere - the lkml post was from the
middle of January.

                    Linus

---------- Forwarded message ----------
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Date: Fri, Feb 10, 2012 at 2:08 AM
Subject: Re: Linux 3.3-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
geert@linux-m68k.org


On Wed, Feb 08, 2012 at 07:36:37PM -0800, Linus Torvalds wrote:
> Another week, another -rc.
>
> No big surprises, which is just how I like it. About a third of the
> patches are in ARM, but the bulk of that is due to the removal of the
> unused DMA map code form the bcmring support. So no complaints.
>
> The rest is fairly flat in the diffstat (=3D=3D random small changes all
> over), although mostly drivers. More sound/hda (and asoc) updates,
> some target and IB updates, etc etc.
>
> Shortlog appended for your perusal, you can see the kind of largely
> "fix small details" almost all of it is,

Hi,

just wanted to let You know, that following fix didn't make it into
Your tree yet:
https://lkml.org/lkml/2012/1/15/23

the bug is causing build failures with some GCC versions:

=A0CC [M] =A0net/bluetooth/l2cap_sock.o
net/bluetooth/l2cap_sock.c: In function =91l2cap_sock_connect=92:
include/net/bluetooth/l2cap.h:838: sorry, unimplemented: inlining
failed in call to =91l2cap_chan_connect=92: function body not available
net/bluetooth/l2cap_sock.c:126: sorry, unimplemented: called from here
make[2]: *** [net/bluetooth/l2cap_sock.o] Error 1
make[1]: *** [net/bluetooth] Error 2
make: *** [net] Error 2

BR
nik


--
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 01 Ostrava

tel.: =A0 +420 596 603 142
fax: =A0 =A0+420 596 621 273
mobil: =A0+420 777 093 799
www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------
