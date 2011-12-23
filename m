Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Fri, 23 Dec 2011 14:54:29 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: =?utf-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon@janc.net.pl>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM mailing list <linux-pm@vger.kernel.org>,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth:
 Increase HCI reset timeout ...)
Message-ID: <20111223165429.GA5287@joana>
References: <20111118184017.GA5052@nomi.cz>
 <20111121152506.GB15633@fusion.localdomain>
 <20111121211506.GA16081@nomi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111121211506.GA16081@nomi.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom=C3=A1=C5=A1,

* Tom=C3=A1=C5=A1 Janou=C5=A1ek <tomi@nomi.cz> [2011-11-21 22:15:07 +0100]:

> Hi Johan,
>=20
> On Mon, Nov 21, 2011 at 05:25:06PM +0200, Johan Hedberg wrote:
> > It might be worth to try out the two patches I just sent to
> > linux-bluetooth for HCI command failure tracking. They make sure that
> > failures are properly caught which should help avoid triggering the
> > timeout in certain scenarios (and yours might be one of them).
>=20
> No, these don't help. :-(

Is this still happening? If yes I'm going to revert this patch.

	Gustavo
