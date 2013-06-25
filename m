Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jun 2013 22:00:39 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pavel Machek <pavel@ucw.cz>, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pull request: bluetooth 2013-06-23
Message-ID: <20130625210039.GA28448@joana>
References: <20130623021351.GA2327@joana>
 <20130625201217.GA13879@amd.pavel.ucw.cz>
 <E95EC814-F064-4AEB-AE13-79982D3BE5E8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E95EC814-F064-4AEB-AE13-79982D3BE5E8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-06-25 13:49:19 -0700]:

> Hi Pavel,
>=20
> >> Jaganath Kanakkassery (1):
> >>      Bluetooth: Fix invalid length check in l2cap_information_rsp()
> >=20
> > Could we add the "3.10 vs. thinkpad x60" patch that fixes regression?
> > It is from Johan Hedberg=E2=80=A6
>=20
> that one went into net-next tree. It is scheduled for 3.11 right now.
>=20
> After 3.10 is out, maybe it can go into -stable, but otherwise I think it=
 is bit late now. Unless someone wants to cherry-pick it.

That patch is actually in 3.10 already, it was included in the last pull
request and John took it to wireless.git.

	Gustavo
