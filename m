Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bccmd reading clock
References: <20050627223919.793D83BC@arbetsmyra.dyndns.org> <20050629082735.CC3AC84E@arbetsmyra.dyndns.org> <1120385776.10273.8.camel@pegasus>
In-Reply-To: <1120385776.10273.8.camel@pegasus>
MIME-Version: 1.0
Message-Id: <20050703163538.1E47C3FB@arbetsmyra.dyndns.org>
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
Date: Sun, 3 Jul 2005 18:33:34 +0200


> actually I added the clock reading support by copying the uint32
> reading command. Using the complex command needs a little bit more
> testing and of course audit. The CSR BCCMD can be quite picky if you
> do something wrong. I also added support for uint32 and BT_CLOCK to
> hcidump.

Hi
Ok. Nice, but how can we "test" the complex command if we don't use it? 
I agree we need to be careful yes, but BCCMD works in ram only, right? 
If something goes wrong one can just do a cold reset to restore 
settings.


> The UART config is used via BCCMD for temporary changes and via the
> PSKEY for permanent changes. I didn't added it, because I don't like
> mixing patches. One patch per feature.

I understand. Besides the UART feature I've also added preliminary 
support for these additional commands:
	- Read RSSI
	- Read/write BER threshold
	- Read/write max tx power
	- Read/write default tx power
And also made a find_conn_handle() function to automatically get the 
ACL connection handle and pass it on to all the BCCMDs who needs it 
(most of them, including your "keylen" function). User can then use the 
commands simply with a <bdaddr> on the commandline instead of the 
harder to find handle. Should I send you patches for these too? Perhaps 
separated in smal chunks?


Regards
/Ronny




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
