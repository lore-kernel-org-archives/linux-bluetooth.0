Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
Date: Fri, 18 Jul 2003 11:53:29 -0700
Message-ID: <002301c34d5d$e1069c70$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <001501c347df$5c945550$1a01010a@baked>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Just wanted to make sure that you saw this (not trying to be pushy). :)

I haven't actually run into this problem with a real product yet, but the
rfcomm tester runs into it. So as far as qualification goes, it's pretty
marginal.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Daryl Van Vorst
> Sent: July 11, 2003 12:05 PM
> To: 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
> 
> 
> Marcel,
> 
> I just reproduced it here. Attached is an aclsession script 
> which will do it. First run aclsession on one machine, then 
> run rctest on the other machine. Also attached are the 
> console output and hcidump from the machine running rctest.
> 
> The pattern of send 5 packets, wait 20 seconds, send 5 more, 
> etc appears to continue forever. I'm told that it should just 
> keep sending data.
> 
> -Daryl.
> 
> > -----Original Message-----
> > From: bluez-devel-admin@lists.sourceforge.net
> > [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> > Daryl Van Vorst
> > Sent: July 11, 2003 9:44 AM
> > To: 'Marcel Holtmann'
> > Cc: 'BlueZ Mailing List'
> > Subject: [Bluez-devel] RE: Qualification testing - rfcomm
> > 
> > 
> > Marcel,
> > 
> > You're right that it doesn't check the error code, it just
> > exits. But that doesn't explain why it sends 5 frames, waits 
> > for 20 seconds, and then sends 5 more.  Shouldn't send block?
> > 
> > I haven't yet tried to reproduce that behaviour.  So I'm not
> > certain that the sequence of send 5, wait 20, send 5 repeats 
> > indefinitely.  I'll take a look at it shortly.
> > 
> > Thanks for the flow control patch...  I'll wait and see if
> > anything comes out of the above stuff before sending it out 
> > for testing.
> > 
> > -Daryl.
> > 
> > > -----Original Message-----
> > > From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de]
> > > Sent: July 11, 2003 1:55 AM
> > > To: Daryl Van Vorst
> > > Cc: BlueZ Mailing List
> > > Subject: Re: Qualification testing - rfcomm
> > > 
> > > 
> > > Hi Daryl,
> > > 
> > > > Finally got some results on those latest rfcomm changes for 
> > > > qualification. Looks like there are a few more problems. :(
> > >  But we're
> > > > close. :)
> > > > 
> > > > TP/RFC/BV-09-C:
> > > > "Verify that the IUT handles flow control correctly when
> > > the Tester,
> > > > acting as a device conforming to Bluetooth version 1.0B,
> > > controls the
> > > > data flow using the Modem Status Command. The IUT's device
> > > role is of
> > > > no importance."
> > > > 
> > > > The command and console output:
> > > > 
> > > > root@jack-00000000:~>./rctest -s -P 1 -b 20 00:A0:96:1F:83:71
> > > > rctest[351]: Connected
> > > > rctest[351]: Sending ...
> > > > rctest[351]: Send failed. Resource temporarily unavailable(11)
> > > > 
> > > > The IUT sends data in 5 frames, then stops for aboue 20s,
> > > then sends 5
> > > > more, then stops, etc. Technically, this test passed
> > because we did
> > > > stop sending data after the tester send MSC stop to the IUT. But
> > > > something's clearly not right.
> > > 
> > > this looks quite right, but the rctest program don't 
> check the error 
> > > code. If it receives EAGAIN it should try again, but it aborts.
> > > 
> > > Regards
> > > 
> > > Marcel
> > > 
> > > 
> > > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email sponsored by: Parasoft
> > Error proof Web apps, automate testing & more.
> > Download & eval WebKing and get a free book.
> > www.parasoft.com/bulletproofapps1 
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net 
> > https://lists.sourceforge.net/lists/listinfo/b> luez-devel
> > 
> 
