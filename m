Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems while sending and receiving with rfcomm
 sockects
Message-Id: <20040601145616.3419c335@coredump>
In-Reply-To: <1086093267.4702.20.camel@pegasus>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
	<1086093267.4702.20.camel@pegasus>
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
Date: Tue, 1 Jun 2004 14:56:16 +0200

Hi,

> I never used RFCOMM in a multi-threaded program. Actually I avoid to
> use threads wherever possible. However sending and receiving at the
> same time should work. Maybe there is a kernel bug, what version do
> you use?

I allways thought one should ONLY use a socket within a single thread
at the same time. I write my programs in that way that I never call
read() and write() on a specific socket at the "same time" also I
only access each socket within a single thread.

Somehting else: I need a UUID for my application - any hints on where to
find some information/instructions?


... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Sun light is good, if it stays outside of my room!


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
