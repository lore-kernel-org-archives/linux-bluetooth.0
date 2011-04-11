Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Apr 2011 00:16:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
    Keith Packard <keithp@keithp.com>,
    linux-kernel <linux-kernel@vger.kernel.org>,
    linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
In-Reply-To: <1302558033.2572.219.camel@aeonflux>
Message-ID: <alpine.LFD.2.00.1104120014130.2702@localhost6.localdomain6>
References: <yun1v1fj024.fsf@aiko.keithp.com>  <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>  <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>  <yunaag0tjzb.fsf@aiko.keithp.com> <20110409000857.GB25581@piper>
 <alpine.LFD.2.00.1104111807480.4501@localhost6.localdomain6> <1302558033.2572.219.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 11 Apr 2011, Marcel Holtmann wrote:

> Hi Thomas,
> 
> > > > > Can the bluetooth folks please have a look at that ASAP? The obvious
> > > > > fast fix for Linus tree is to revert the second hunk for now, but this
> > > > > needs to be fixed proper.
> > > > 
> > > > Who will submit this patch? I'd rather have your name on it so that
> > > > people come complain at you...
> > > 
> > > I took a shot at it and just sent a patch (also attached for convenience) 
> > > that should solve the problem.
> > 
> > Aaarg. No. That patch reverts both hunks.
> > 
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -586,9 +586,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> >  	hci_req_cancel(hdev, ENODEV);
> >  	hci_req_lock(hdev);
> >  
> > -	/* Stop timer, it might be running */
> > -	del_timer_sync(&hdev->cmd_timer);
> > -
> >  	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
> >  		hci_req_unlock(hdev);
> >  		return 0;
> > 
> > As I said before you need that first hunk to stay for the case where
> > there is no device up and you return via the !HCI_UP check. You just
> > moved back to the state before as the stupid timer is active for
> > whatever reason even when HCI_UP is not set.
> 
> if I read this right then we have the case that we arm this timer for no
> real reason. A device in !HCI_UP should have nothing running. Certainly
> not the cmd_timer since it will never process any commands.
> 
> According to Gustavo, the problem is really in the hci_reset logic were
> we arm the timer even when shutting down the device.

The reason why the original patch was sent is, that the timer was
running when the thing went out via the !HCI_UP path, which caused the
whole thing to explode in the first place. I had no time to figure out
why, but moving the del_timer_sync above the
if (!test_and_clear_bit(HCI_UP, &hdev->flags)) solved it.

Thanks,

	tglx
