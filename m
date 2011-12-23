Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 23 Dec 2011 19:05:13 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Szymon Janc <szymon@janc.net.pl>
Cc: =?utf-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM mailing list <linux-pm@vger.kernel.org>,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth:
 Increase HCI reset timeout ...)
Message-ID: <20111223210513.GG5287@joana>
References: <20111118184017.GA5052@nomi.cz>
 <20111121211506.GA16081@nomi.cz>
 <20111223165429.GA5287@joana>
 <201112232143.20937.szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201112232143.20937.szymon@janc.net.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon@janc.net.pl> [2011-12-23 21:43:20 +0100]:

> On Friday 23 December 2011 17:54:29 Gustavo Padovan wrote:
>=20
> Hi,
>=20
> > > On Mon, Nov 21, 2011 at 05:25:06PM +0200, Johan Hedberg wrote:
> > > > It might be worth to try out the two patches I just sent to
> > > > linux-bluetooth for HCI command failure tracking. They make sure th=
at
> > > > failures are properly caught which should help avoid triggering the
> > > > timeout in certain scenarios (and yours might be one of them).
> > >=20
> > > No, these don't help. :-(
> >=20
> > Is this still happening? If yes I'm going to revert this patch.
>=20
> I kindly ask to not revert this patch yet as this will bring back issue o=
n my=20
> CSR dongle.
>=20
> If this regression still happening I can try investigate it next week (as=
 long=20
> as Tom=C3=A1=C5=A1 is willing to provide more detailed logs and do some t=
ests if=20
> needed).

Sure, we can figure out what is going wrong for both of you, but until this
commit will reverted for safety.

	Gustavo
