Return-Path: <bb@arbetsmyra.dyndns.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bccmd reading clock
Date: Fri, 1 Jul 2005 10:43:28 +0200
References: <20050627223919.793D83BC@arbetsmyra.dyndns.org> <1119973364.15397.77.camel@pegasus> <20050629082735.CC3AC84E@arbetsmyra.dyndns.org>
In-Reply-To: <20050629082735.CC3AC84E@arbetsmyra.dyndns.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
MIME-Version: 1.0
Message-Id: <20050701084528.C38DD82D@arbetsmyra.dyndns.org>
List-ID: <bluez-devel.lists.sourceforge.net>


hi
I got no response to my revised bccmd patch
http://sourceforge.net/mailarchive/message.php?msg_id=12199652
Accepted, rejected och just delayed review?

regards
/Ronny




----------------------------------------------------------
> > > I was in the need for an enhancement of the bccmd tool and thus
> > > made a small change. The supplied patch adds a command for
> > > reading the the BT-clock of local device. In the process I also
> > > made some minor changes to utils/tools/csr.c to reuse existing
> > > code. Besided reading 16-bit variables it can now also read 32-
> > > and 8-bits alike.
> >
> > don't do type conversion like this. Use varid_complex for it if you
> > wanna support uint32 and unit8 without copying code.
>
> As you command.... :)  Perhaps like this then? Added parsing read of
> uart speed setting too. I'm a bit uncertain however of where to put
> corresponding uart config write. Both BCCMD and PSKEY seems adequate.
>
> /Ronny
