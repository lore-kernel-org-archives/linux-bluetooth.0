Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 14:15:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Fix possible NULL dereference
Message-ID: <20120719111527.GA17483@x220>
References: <1342691392-4006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120719102306.GA15933@x220>
 <20120719103819.GE26057@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120719103819.GE26057@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jul 19, 2012, Andrei Emeltchenko wrote:
> On Thu, Jul 19, 2012 at 01:23:06PM +0300, Johan Hedberg wrote:
> > Hi Andrei,
> > 
> > On Thu, Jul 19, 2012, Andrei Emeltchenko wrote:
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > hdev might be dereferenced in handler->func functions.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/mgmt.c |   11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > > index 2a0f695..48a83c9 100644
> > > --- a/net/bluetooth/mgmt.c
> > > +++ b/net/bluetooth/mgmt.c
> > > @@ -2801,14 +2801,15 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> > >  		goto done;
> > >  	}
> > >  
> > > -	if (hdev)
> > > +	if (hdev) {
> > >  		mgmt_init_hdev(sk, hdev);
> > >  
> > > -	cp = buf + sizeof(*hdr);
> > > +		cp = buf + sizeof(*hdr);
> > >  
> > > -	err = handler->func(sk, hdev, cp, len);
> > > -	if (err < 0)
> > > -		goto done;
> > > +		err = handler->func(sk, hdev, cp, len);
> > > +		if (err < 0)
> > > +			goto done;
> > > +	}
> > >  
> > >  	err = msglen;
> > 
> > Nack.
> > 
> > hdev is supposed to be NULL for some of the commands/handlers
> > (read_version, read_index_list, etc). With your change these mgmt
> > commands couldn't be called anymore. There's also a check for this
> > higher up in the mgmt_control function to ensure that hdev is not NULL
> > for other handlers:
> 
> OK, though I do not like that division by command name.

I was originally thinking of having a boolean flag for that in the
look-up table but concluded that it's a bit overkill (not to mention
that it breaks the clean formatting) since only the first few commands
are the ones that don't take a valid controller index.

Johan
