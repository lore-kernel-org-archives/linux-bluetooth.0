Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40A38196.90301@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Christoph Scholz <scholz@cs.uni-bonn.de>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PAN and bridge problem when bnep0 disconnects before
 bnep1
References: <1084452714.2318.12.camel@willie.informatik.uni-bonn.de>
In-Reply-To: <1084452714.2318.12.camel@willie.informatik.uni-bonn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 13 May 2004 16:09:26 +0200

Hi Christoph,

Christoph Scholz wrote:
> I experienced the same problem as Matthias Thomae. I already posted this

Glad there's others with the same problem ;)

> to the mailing-list some time ago (see attached mail). It is actually a

Missed your mail although I searched the archives...

> problem with the Linux bridge code. It does not seem to be able to cope
> with multiple interfaces using the same MAC-Address.

Aha. These MAC addresses seem to be used in the forwarding database. 
Maybe setting the ageing time to 0 (man brctl) would help...

> Unfortunately, I have no real solution to the problem.

What kernel version are you using (on the GN)? I noticed in the 
changelog for 2.6.6 there were a number of bridge-related changes, e.g.:

<shemminger@osdl.org>
	[BRIDGE]: Forwarding database changes.
	
	Make forwarding database more robust.
	  + Don't insert invalid ether address,
	  + Report errors back so adding an interface to bridge can fail
	  + get rid of unneeded explicit pads in data structure
	  + replace bitfields with byte's for simple booleans.

Maybe that fixes our problem? I might be able to try 2.6.6 and the 
ageing timer tonight...

BTW, have you written to the bridge people?

Regards.
Matthias


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
