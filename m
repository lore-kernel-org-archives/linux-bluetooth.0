Return-Path: <mcq@cacr.caltech.edu>
Date: Sun, 7 Mar 2004 17:11:47 -0800
From: John McCorquodale <mcq@cacr.caltech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: John McCorquodale <mcq@cacr.caltech.edu>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
Message-ID: <20040308011147.GA19276@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu> <1078704901.15279.6.camel@pegasus> <20040308002100.GA19049@viz.cacr.caltech.edu> <1078705579.15279.18.camel@pegasus> <20040308004811.GA19145@viz.cacr.caltech.edu> <1078707603.15279.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078707603.15279.27.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

> > First time loading it says:
> > bcsp_recv: Out-of-order packet arrived, expected 1 got 0
> 
> this is ok. You can ignore this message.

Ah, what I didn't notice when it said this is that it was working!  I have an
"up" hci0 for the first time.  An hcitool scan sees my headset.  Groovy!
2.4.25 works.

> > Unknown device type or id
> 
> This looks like that your command parameters are wrong.

Yeah, I can't actually repeat this in 2.4.25 now.  Dunno what I did a minute
ago.

> >   2) Is there a patch for the 2.6 serial problem?
> 
> Not that I know of. Some cards are working and some are not.

Now that I have it going, I'll look into this and see if I can figure out
what's going on.  If I figure it out, I'll send a patch to -devel.

Thanks for your help!

-mcq
