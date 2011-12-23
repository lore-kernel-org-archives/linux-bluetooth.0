Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 23 Dec 2011 19:03:43 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: =?utf-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>
Cc: Szymon Janc <szymon@janc.net.pl>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM mailing list <linux-pm@vger.kernel.org>,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth:
 Increase HCI reset timeout ...)
Message-ID: <20111223210343.GF5287@joana>
References: <20111118184017.GA5052@nomi.cz>
 <20111121211506.GA16081@nomi.cz>
 <20111223165429.GA5287@joana>
 <201112232143.20937.szymon@janc.net.pl>
 <20111223204849.GA23712@nomi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111223204849.GA23712@nomi.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom=C3=A1=C5=A1,

* Tom=C3=A1=C5=A1 Janou=C5=A1ek <tomi@nomi.cz> [2011-12-23 21:48:49 +0100]:

> Hello,
>=20
> On Fri, Dec 23, 2011 at 09:43:20PM +0100, Szymon Janc wrote:
> > > Is this still happening? If yes I'm going to revert this patch.
>=20
> Yes, it is.

The commit is now reverted. It should be mainline before the 3.2 release.

	Gustavo
