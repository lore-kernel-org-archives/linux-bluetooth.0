Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bccmd reading clock
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050703163538.1E47C3FB@arbetsmyra.dyndns.org>
References: <20050627223919.793D83BC@arbetsmyra.dyndns.org>
	 <20050629082735.CC3AC84E@arbetsmyra.dyndns.org>
	 <1120385776.10273.8.camel@pegasus>
	 <20050703163538.1E47C3FB@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1120409776.10273.71.camel@pegasus>
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
Date: Sun, 03 Jul 2005 18:56:16 +0200

Hi Ronny,

> > actually I added the clock reading support by copying the uint32
> > reading command. Using the complex command needs a little bit more
> > testing and of course audit. The CSR BCCMD can be quite picky if you
> > do something wrong. I also added support for uint32 and BT_CLOCK to
> > hcidump.
> 
> Ok. Nice, but how can we "test" the complex command if we don't use it? 
> I agree we need to be careful yes, but BCCMD works in ram only, right? 
> If something goes wrong one can just do a cold reset to restore 
> settings.

it is not about the settings. The bccmd tool must be usable all the time
without crashing the device at runtime. Feel free to send new patches
against the current CVS. I will see if I get some time to review and of
course test them.

> > The UART config is used via BCCMD for temporary changes and via the
> > PSKEY for permanent changes. I didn't added it, because I don't like
> > mixing patches. One patch per feature.
> 
> I understand. Besides the UART feature I've also added preliminary 
> support for these additional commands:
> 	- Read RSSI
> 	- Read/write BER threshold
> 	- Read/write max tx power
> 	- Read/write default tx power
> And also made a find_conn_handle() function to automatically get the 
> ACL connection handle and pass it on to all the BCCMDs who needs it 
> (most of them, including your "keylen" function). User can then use the 
> commands simply with a <bdaddr> on the commandline instead of the 
> harder to find handle. Should I send you patches for these too? Perhaps 
> separated in smal chunks?

Send small chunks and step by step. It is then easier for me to review
them and apply them. This is also better for the revision history.

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
