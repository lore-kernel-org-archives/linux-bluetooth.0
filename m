Return-Path: <mcq@cacr.caltech.edu>
Date: Sun, 7 Mar 2004 16:21:00 -0800
From: John McCorquodale <mcq@cacr.caltech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: John McCorquodale <mcq@cacr.caltech.edu>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
Message-ID: <20040308002100.GA19049@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu> <1078704901.15279.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078704901.15279.6.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel> you should use "hciattach ttyS0 bcsp 230400", because the Socket card
Marcel> uses the BCSP transport protocol.

The other day you said:

Marcel> The Socket 2.5 generation (also know as revision G) is a CSR based
Marcel> serial Bluetooth card. Look at the archives for more details.

And the list seems to indicate that the F card is BCSP and the G card is CSR.
That said, using bcsp yields:

  $ hciattach ttyS0 bcsp 230400
  BCSP initialization timed out

Am I mistaken about the F/G distinction?  Am I correct in using the normal
serial_cs driver in the PCMCIA cardmgr?  Is there something I can run directly
at the serial port that will give me a more verbose dialog than "initialization
timed out", which might indicate some level of partial success?  Could it
be that there's a new G card series out there -- these are brand spankin' new
cards?

Cheers, and thanks,

-mcq
