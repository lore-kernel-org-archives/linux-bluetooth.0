Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP retransmission, flow control
From: Imre Deak <imre.deak@nokia.com>
To: Bluez-Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107938887.13863.4.camel@pegasus>
References: <1107934854.9489.4.camel@mammoth.research.nokia.com>
	 <1107938887.13863.4.camel@pegasus>
Content-Type: text/plain
Message-Id: <1107940961.9489.32.camel@mammoth.research.nokia.com>
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
Date: Wed, 09 Feb 2005 11:22:41 +0200

On Wed, 2005-02-09 at 09:48 +0100, ext Marcel Holtmann wrote: 
> Hi Imre,
> 
> > is anyone involved in implementing L2CAP rfc according to the 1.2 spec?
> 
> not that I know of.
> 
> > If not I'll give it a try.
> 
> Feel free to start. I am happy to get L2CAP 1.2 support included. The

Ok, we'll have already some basic stuff to support the new config
options, I'll start then to implement the rest. L2CAP QoS could also be
done at some point, for the moment I don't plan to add support to
anything but 'best effort'.

> L2CAP options now contain a mode value and this is exactly for this
> purpose. Let the rest of the RFC config values be the defaults from the
> specification by now. Another way to activate RFC would be to use the
> SOCK_STREAM socket type.
> 

Yes, I agree. Is it ok then to do the following?

For SOCK_STREAM try to negotiate RFC, if peer doesn't accept use basic
mode.

For SOCK_DGRAM, SOCK_RAW try to negotiate FC, if  peer doesn't accept
use basic mode.

Other issues I was thinking about:

The 1.2 spec says it's possible for L2CAP to send incorrect packets
(with missing fragments) to upper layers with indication of the
incorrect parts of the given packet. The only possiblity I found so far,
is to signal that L2CAP reliability can't be guaranteed any more and
drop the packet.
Is there a way or is there a case at all where we should support
applications that need such incorrect packets?

Regards,
Imre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
