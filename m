Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb autosuspend and circular lock dep
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
In-Reply-To: <200908242149.51588.oliver@neukum.org>
References: <20090615175435.GA4772@gamba.jf.intel.com>
	 <200908241559.59814.oliver@neukum.org>
	 <1251133391.2950.51.camel@localhost.localdomain>
	 <200908242149.51588.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 12:59:22 -0700
Message-Id: <1251143962.2950.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > > > > I see.  I removed that case and re-tested.  The simple down, auto,
> > > > > > up, down test worked fine.  However, the down, up, wait, auto test
> > > > > > failed. Logs of the success and the failure are attached.
> > > > >
> > > > > Very well, this version works for me.
> > > >
> > > > can you send a clean version so we can merge this into 2.6.32. This
> > > > version still has the debug details in there. And please send it to the
> > > > mailing list for reference.
> 
> And again.
> 
> > > +	if (!err < 0)
> > > +		return;
> >
> > This looks like a typo.
> 
> Fixed
> >
> 
> > > @@ -989,9 +1123,10 @@ static int btusb_resume(struct usb_interface *intf)
> > >  		err = btusb_submit_bulk_urb(hdev, GFP_NOIO);
> > >  		if (err < 0) {
> > >  			clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > > -			return err;
> > > -		} else
> > > +			goto failed;
> > > +		} else {
> > >  			btusb_submit_bulk_urb(hdev, GFP_NOIO);
> > > +		}
> > >  	}
> >
> > Normally we don't put braces around single else or if statement.
> 
> Quoting CodingStyle.txt:
> This does not apply if one branch of a conditional statement is a single
> statement. Use braces in both branches.
> 
> if (condition) {
> 	do_this();
> 	do_that();
> } else {
> 	otherwise();
> }

okay, then we have to violate coding style here since throughout the
whole Bluetooth subsystem we don't do { } around single statements. And
this applies to single else statements.

Regards

Marcel


