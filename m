Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] patch for: RFComm dynamic channel allocation
Message-Id: <20040708200805.7034024f@coredump>
In-Reply-To: <1089308231.4857.45.camel@pegasus>
References: <20040708165219.16a1d6db@coredump>
	<1089308231.4857.45.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 8 Jul 2004 20:08:05 +0200

Hi Marcel,

> I don't get the point of your fix, because bind() to a specific
> BD_ADDR and to BDADDR_ANY are totally different and can result in
> different dynamic channel allocations.

I understand why binding to BDADDR_ANY could lead to a different
channel, e.g. when having multiple BT devices but the current code
doesn't work when binding to a specific BD_ADDR. I only talk about
dynamic rfcomm channel allocation which takes place when calling
listen()! Not about the general bind().

... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Success is a journey, not a destination. So stop running.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
