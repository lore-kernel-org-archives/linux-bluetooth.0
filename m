Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: Dave Henriksen <dhenriksen@optibrand.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Ideal mru and mtu ?
Message-ID: <20040630232127.GK30504@hp.com>
References: <1088608978.4959.9.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088608978.4959.9.camel@linux.site>
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
Date: Thu, 1 Jul 2004 09:21:27 +1000

An ideal MTU would be the largest that works over the total network path
from the FTP client to the FTP server.

pppd's mru option determines how it negotiates this option with the
peer.  The negotiated mru forms the basis for the interface MTU.  The
MTU can be changed up and down after interface creation, using "ifconfig
ppp0 mtu".

pppd running over bluetooth just believes it has a byte stream to the
peer.  There may be bluetooth specific reasons to choose an MTU that
matches on the air packet sizes, in order to reduce latency, but if your
goal is mainly FTP my guess is that latency isn't important.

-- 
James Cameron                         http://quozl.netrek.org/
HP Open Source, Volunteer             http://opensource.hp.com/
PPTP Client Project, Release Engineer http://pptpclient.sourceforge.net/


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
