Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:18:14 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move scope of state_to_string
Message-ID: <20120217091812.GB19421@aemeltch-MOBL1>
References: <1329299426-8458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329308414.28848.80.camel@aeonflux>
 <20120217091003.GA19421@aemeltch-MOBL1>
 <1329469930.28848.156.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329469930.28848.156.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 17, 2012 at 10:12:10AM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > Function state_to_string will be used in other files.
> > > > 
> > > so long term, we need to keep socket states inside l2cap_sock.c and
> > > L2CAP states inside l2cap_core.c. Since L2CAP core engine should use the
> > > states from the specification and not try to fit into socket states.
> > > 
> > > I see a little bit of value here in having them in the debug log, but
> > > making them public like this seems a big overhead. Did you measure the
> > > size difference. 
> > 
> > size show exactly the same size after applying this patch with my config.
> > (dynamic debug enabled)
> > 
> > size net/bluetooth/bluetooth.ko 
> >    text	   data	    bss	    dec	    hex	filename
> >  196404	  12912	    644	 209960	  33428	net/bluetooth/bluetooth.ko
> 
> then I am fine with this. Just send an updated patch against the latest
> tree.

If we don't want it to be in bluetooth.h I can export only function
declaration or put it in l2cap.h. What is better?

Best regards 
Andrei Emeltchenko 
