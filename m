Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 12:06:09 -0500
From: Kodiak Furr <boxerapp@aol.com>
To: Alan Cox <alan@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Muralidharan Karicheri
 <m-karicheri2@ti.com>, Marcel Holtmann <marcel@holtmann.org>,
 <linux-bluetooth@vger.kernel.org>,  <linux-serial@vger.kernel.org>
Message-ID: <56219B38-9220-4832-B227-B733AE54BB77@aol.com>
In-Reply-To: <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
References: <20140320163435.GH32692@saruman.home>
 <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
Subject: Re: hci_ldsic nested locking problem
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="532b2001_625558ec_16f8e"
List-ID: <linux-bluetooth.vger.kernel.org>

--532b2001_625558ec_16f8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.  =20

---Sent from Boxer =7C http://getboxer.com

On Thu, 2014-03-20 at 11:34 -0500, =46elipe Balbi wrote:

> Hi,

> =20
> when 8250 driver calls uart=5Fwrite=5Fwakeup(), the tty port lock is al=
ready

> taken. hci=5Fldisc.c's implementation of ->write=5Fwakeup() calls

> tty->ops->write() to actually send the characters, but that call will

> try to acquire the same port lock again.

> =20
> Looking at other line disciplines that looks like a bug in hci=5Fldisc.=
c.

> Am I correct to assume that ->write=5Fwakeup() is supposed to *just*

> wakeup the bottom half so we handle ->write() in another context =3F

> =20
> Is it legal to call tty->ops->write() from within ->write=5Fwakeup() =3F=




It isn't because you might send all the bytes and go



	write

		write=5Fwakeup

			write

				write wakeup

					...



and recurse



Alan





--

To unsubscribe from this list: send the line =22unsubscribe linux-kernel=22=
 in

the body of a message to majordomo=40vger.kernel.org

More majordomo info at  http://vger.kernel.org/majordomo-info.html

Please read the =46AQ at  http://www.tux.org/lkml/


--532b2001_625558ec_16f8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.<br><br><div id=3D=22boxer-meta=22></div><div id=3D=22attachments=22></d=
iv><span id=3D=22draft-break=22></span>---<br>Sent from Boxer =7C <a href=
=3D=22http://d.getboxer.com/1dYH=46GQ=22>http://getboxer.com</a><span id=3D=
=22draft-break=22></span><div><div>On March 20, 2014 at 11:42:16 AM CDT, =
Alan Cox &lt;alan=40linux.intel.com&gt; wrote:<br><blockquote type=3D=22c=
ite=22><div>On Thu, 2014-03-20 at 11:34 -0500, =46elipe Balbi wrote:<br>&=
gt; Hi,<br>&gt; <br>&gt; when 8250 driver calls uart=5Fwrite=5Fwakeup(), =
the tty port lock is already<br>&gt; taken. hci=5Fldisc.c's implementatio=
n of -&gt;write=5Fwakeup() calls<br>&gt; tty-&gt;ops-&gt;write() to actua=
lly send the characters, but that call will<br>&gt; try to acquire the sa=
me port lock again.<br>&gt; <br>&gt; Looking at other line disciplines th=
at looks like a bug in hci=5Fldisc.c.<br>&gt; Am I correct to assume that=
 -&gt;write=5Fwakeup() is supposed to *just*<br>&gt; wakeup the bottom ha=
lf so we handle -&gt;write() in another context =3F<br>&gt; <br>&gt; Is i=
t legal to call tty-&gt;ops-&gt;write() from within -&gt;write=5Fwakeup()=
 =3F<br><br>It isn't because you might send all the bytes and go<br><br>	=
write<br>		write=5Fwakeup<br>			write<br>				write wakeup<br>					...<br>=
<br>and recurse<br><br>Alan<br><br><br>--<br>To unsubscribe from this lis=
t: send the line =22unsubscribe linux-kernel=22 in<br>the body of a messa=
ge to majordomo=40vger.kernel.org<br>More majordomo info at  http://vger.=
kernel.org/majordomo-info.html<br>Please read the =46AQ at  http://www.tu=
x.org/lkml/<br></div></blockquote></div></div>
--532b2001_625558ec_16f8e--
