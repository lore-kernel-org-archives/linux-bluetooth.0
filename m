Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: Qualification testing - rfcomm
Date: Fri, 11 Jul 2003 09:43:43 -0700
Message-ID: <001001c347cb$97a39840$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1057913731.1027.11.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

You're right that it doesn't check the error code, it just exits. But that
doesn't explain why it sends 5 frames, waits for 20 seconds, and then sends
5 more.  Shouldn't send block?

I haven't yet tried to reproduce that behaviour.  So I'm not certain that
the sequence of send 5, wait 20, send 5 repeats indefinitely.  I'll take a
look at it shortly.

Thanks for the flow control patch...  I'll wait and see if anything comes
out of the above stuff before sending it out for testing.

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de] 
> Sent: July 11, 2003 1:55 AM
> To: Daryl Van Vorst
> Cc: BlueZ Mailing List
> Subject: Re: Qualification testing - rfcomm
> 
> 
> Hi Daryl,
> 
> > Finally got some results on those latest rfcomm changes for 
> > qualification. Looks like there are a few more problems. :( 
>  But we're 
> > close. :)
> > 
> > TP/RFC/BV-09-C:
> > "Verify that the IUT handles flow control correctly when 
> the Tester, 
> > acting as a device conforming to Bluetooth version 1.0B, 
> controls the 
> > data flow using the Modem Status Command. The IUT's device 
> role is of 
> > no importance."
> > 
> > The command and console output:
> > 
> > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > rctest[351]: Connected
> > rctest[351]: Sending ...
> > rctest[351]: Send failed. Resource temporarily unavailable(11)
> > 
> > The IUT sends data in 5 frames, then stops for aboue 20s, 
> then sends 5 
> > more, then stops, etc. Technically, this test passed because we did 
> > stop sending data after the tester send MSC stop to the IUT. But 
> > something's clearly not right.
> 
> this looks quite right, but the rctest program don't check 
> the error code. If it receives EAGAIN it should try again, 
> but it aborts.
> 
> Regards
> 
> Marcel
> 
> 
> 
