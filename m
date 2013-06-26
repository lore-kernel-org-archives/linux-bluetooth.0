Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jun 2013 13:47:36 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pull request: bluetooth 2013-06-23
Message-ID: <20130626124736.GA3337@joana>
References: <20130623021351.GA2327@joana>
 <20130625201217.GA13879@amd.pavel.ucw.cz>
 <E95EC814-F064-4AEB-AE13-79982D3BE5E8@holtmann.org>
 <20130625210039.GA28448@joana>
 <20130626115255.GA7940@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130626115255.GA7940@amd.pavel.ucw.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [2013-06-26 13:52:55 +0200]:

> On Tue 2013-06-25 22:00:39, Gustavo Padovan wrote:
> > Hi Marcel,
> >=20
> > * Marcel Holtmann <marcel@holtmann.org> [2013-06-25 13:49:19 -0700]:
> >=20
> > > Hi Pavel,
> > >=20
> > > >> Jaganath Kanakkassery (1):
> > > >>      Bluetooth: Fix invalid length check in l2cap_information_rsp()
> > > >=20
> > > > Could we add the "3.10 vs. thinkpad x60" patch that fixes regressio=
n?
> > > > It is from Johan Hedberg=E2=80=A6
> > >=20
> > > that one went into net-next tree. It is scheduled for 3.11 right now.
> > >=20
> > > After 3.10 is out, maybe it can go into -stable, but otherwise I thin=
k it is bit late now. Unless someone wants to cherry-pick it.
> >=20
> > That patch is actually in 3.10 already, it was included in the last pull
> > request and John took it to wireless.git.
>=20
> Is it? I tried pulling yesterday (some updates) and today (no
> changes), am on:

Dave already pulled it so it should land in mainline anytime soon.

	Gustavo
