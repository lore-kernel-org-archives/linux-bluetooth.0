Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Dirk Vornheder <DVornheder@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406221724.44949.dvornheder@t-online.de>
References: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de>
	 <200406152223.33329.dvornheder@t-online.de>
	 <1087339136.13792.96.camel@pegasus>
	 <200406221724.44949.dvornheder@t-online.de>
Content-Type: text/plain
Message-Id: <1087939657.4209.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Jun 2004 23:27:37 +0200

Hi Dirk,

> > > The entires in  cups are:
> > >
> > > bluetooth://00027244CF9F/spp
> >
> > I prefer only using the URI and you don't need to add spp or hcrp,
> > because the backend with use HCRP if found and only fall back to RFCOMM
> > printing in the other case.
> >
> > Use "hcidump -x" to check what is happening.
> >
> 
> Here are the output from hcidump.
> 
> Hope you find the problem.

I don't see any useful in it, but it looks very weird. Too much SDP
traffic. Something must be screwed up. Make me a binary dump with -w and
try to get the initial connection setup.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
