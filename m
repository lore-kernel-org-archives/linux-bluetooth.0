Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bccmd reading clock
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050629082735.CC3AC84E@arbetsmyra.dyndns.org>
References: <20050627223919.793D83BC@arbetsmyra.dyndns.org>
	 <1119973364.15397.77.camel@pegasus>
	 <20050629082735.CC3AC84E@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1120385776.10273.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 03 Jul 2005 12:16:16 +0200

Hi Ronny,

> > > I was in the need for an enhancement of the bccmd tool and thus
> > > made a small change. The supplied patch adds a command for reading
> > > the the BT-clock of local device. In the process I also made some
> > > minor changes to utils/tools/csr.c to reuse existing code. Besided
> > > reading 16-bit variables it can now also read 32- and 8-bits alike.
> >
> > don't do type conversion like this. Use varid_complex for it if you
> > wanna support uint32 and unit8 without copying code.
> 
> As you command.... :)  Perhaps like this then? Added parsing read of 
> uart speed setting too. I'm a bit uncertain however of where to put 
> corresponding uart config write. Both BCCMD and PSKEY seems adequate.

actually I added the clock reading support by copying the uint32 reading
command. Using the complex command needs a little bit more testing and
of course audit. The CSR BCCMD can be quite picky if you do something
wrong. I also added support for uint32 and BT_CLOCK to hcidump.

The UART config is used via BCCMD for temporary changes and via the
PSKEY for permanent changes. I didn't added it, because I don't like
mixing patches. One patch per feature.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
