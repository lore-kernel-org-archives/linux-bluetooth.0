Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 12 Apr 2011 15:09:33 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Keith Packard <keithp@keithp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
Message-ID: <20110412180933.GA2836@joana>
References: <yun1v1fj024.fsf@aiko.keithp.com>
 <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
 <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
 <yunaag0tjzb.fsf@aiko.keithp.com>
 <20110409000857.GB25581@piper>
 <alpine.LFD.2.00.1104111807480.4501@localhost6.localdomain6>
 <1302558033.2572.219.camel@aeonflux>
 <alpine.LFD.2.00.1104120014130.2702@localhost6.localdomain6>
 <alpine.LFD.2.00.1104120016490.2702@localhost6.localdomain6>
 <20110411222504.GE2195@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110411222504.GE2195@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-04-11 19:25:04 -0300]:

> * Thomas Gleixner <tglx@linutronix.de> [2011-04-12 00:19:32 +0200]:
>=20
> > On Tue, 12 Apr 2011, Thomas Gleixner wrote:
> > > On Mon, 11 Apr 2011, Marcel Holtmann wrote:
> > >=20
> > > > Hi Thomas,
> > > >=20
> > > > > > > > Can the bluetooth folks please have a look at that ASAP? Th=
e obvious
> > > > > > > > fast fix for Linus tree is to revert the second hunk for no=
w, but this
> > > > > > > > needs to be fixed proper.
> > > > > > >=20
> > > > > > > Who will submit this patch? I'd rather have your name on it s=
o that
> > > > > > > people come complain at you...
> > > > > >=20
> > > > > > I took a shot at it and just sent a patch (also attached for co=
nvenience)=20
> > > > > > that should solve the problem.
> > > > >=20
> > > > > Aaarg. No. That patch reverts both hunks.
> > > > >=20
> > > > > --- a/net/bluetooth/hci_core.c
> > > > > +++ b/net/bluetooth/hci_core.c
> > > > > @@ -586,9 +586,6 @@ static int hci_dev_do_close(struct hci_dev *h=
dev)
> > > > >  	hci_req_cancel(hdev, ENODEV);
> > > > >  	hci_req_lock(hdev);
> > > > > =20
> > > > > -	/* Stop timer, it might be running */
> > > > > -	del_timer_sync(&hdev->cmd_timer);
> > > > > -
> > > > >  	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
> > > > >  		hci_req_unlock(hdev);
> > > > >  		return 0;
> > > > >=20
> > > > > As I said before you need that first hunk to stay for the case wh=
ere
> > > > > there is no device up and you return via the !HCI_UP check. You j=
ust
> > > > > moved back to the state before as the stupid timer is active for
> > > > > whatever reason even when HCI_UP is not set.
> > > >=20
> > > > if I read this right then we have the case that we arm this timer f=
or no
> > > > real reason. A device in !HCI_UP should have nothing running. Certa=
inly
> > > > not the cmd_timer since it will never process any commands.
> > > >=20
> > > > According to Gustavo, the problem is really in the hci_reset logic =
were
> > > > we arm the timer even when shutting down the device.
> > >=20
> > > The reason why the original patch was sent is, that the timer was
> > > running when the thing went out via the !HCI_UP path, which caused the
> > > whole thing to explode in the first place. I had no time to figure out
> > > why, but moving the del_timer_sync above the
> > > if (!test_and_clear_bit(HCI_UP, &hdev->flags)) solved it.
> >=20
> > Oops. Hit send too fast.
> >=20
> > Then it broke the resume on Keith machine and reverting just the hunk
> > which disarms the timer in the=20
> >=20
> >         if (hdev->sent_cmd) {
> >=20
> > path made both scenarios working. So there are two problems:
> >=20
> >      1) Why do we need the del_timer_sync() above the !HCI_UP check
>=20
> That is still a mysterious to me, the real bug the hiding here. I'm tryin=
g to
> track this down but no luck yet.
>=20
> >=20
> >      2) Why gets the timer rearmed after that
>=20
> It is armed at each HCI command we send. In the close path we send out an=
 HCI
> RESET command that rearms it.

I applied v2 patch from Vin=EDcius that fix all the symptoms. Now we have m=
ore time
to find the real cause of this bug. However I still have no idea, I'm not a=
ble
to reproduce it.

--=20
Gustavo F. Padovan
http://profusion.mobi
