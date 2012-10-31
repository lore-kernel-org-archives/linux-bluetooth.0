Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 21:09:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Notify about device registration before power
 on
Message-ID: <20121031190907.GA3631@x220.P-661HNU-F1>
References: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
 <20121031181801.GB1679@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121031181801.GB1679@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Oct 31, 2012, Gustavo Padovan wrote:
> > It is important that the monitor interface gets notified about
> > a new device before its power on procedure has been started.
> > 
> > For some reason that is no longer working as expected and the power
> > on procedure runs first. It is safe to just notify about device
> > registration and trigger the power on procedure afterwards.
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/hci_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Patch has been applied to bluetooth-next. Thanks.

I guess you mean bluetooth.git? (that's where the patch is right now -
not bluetooth-next). Also, I don't think the Cc: stable addition was
necessary since this scheduling behavior seems to be something only
introduced for 3.7 (not 100% sure about this though).

Johan
