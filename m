Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1046871982.2860.1155.camel@baroque.rococosoft.com>
References: <1046871982.2860.1155.camel@baroque.rococosoft.com>
Message-Id: <1046879580.1823.136.camel@pegasus.local>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: New BlueZ Security Manager
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 05 Mar 2003 16:52:53 +0100
Content-Type: text/plain

Hi Stephen,

> On Marcel's German slides (for which I've lost the link) I noticed a
> revamped security manager on the TODO list. However I don't ever
> remember seeing a discussion about it here on the list. I'd like to
> kick-start this discussion if possible.

here is the link to me slides

	http://www.holtmann.org/papers/bluetooth/

There was no real discussion about this topic, but some problems have
raised from time to time. And it is clear that the device up/down
functionaltiy of hcid will be removed and placed as bluetooth.agent in
the hotplug scripts. If you remove this from hcid the only thing which
is left is the security manager and it should be named like this ;)

> The main thing wrong with hcid (in my opinion) is what the security
> white-paper (http://www.bluetooth.com/upload/24Security_Paper.PDF)
> defines as support for security mode 2. This is where the
> owning-application enforces the security requirements for a service.
> 
> The difference between this and the current setup (security modes 1 and
> 3 in the whitepaper's terminology) is (I think) that hcid enforces
> permissions at the ACL level whereas service-level security takes place
> /after/ the ACL link is already up. It should be possible to allow SDP
> searches for example, but deny access to services discovered through
> SDP.

I never used it, but if I remember correclty this can be done through
the L2CAP_LM option with setsockopt(), but it can't be done for RFCOMM
at the moment. Max told me that he have this on his todo list.

> I don't think that the current kernel API is rich enough to permit this.
> It ought to be possible for a server listening on a socket to discover
> the BDADDR of the connecting peer and either accept() or reject access
> --- probably through an ioctl(). On the client-side, a special error
> return from (or argument to) connect() could indicate that a PIN was
> required to connect.

It would be great to know the IP before doing a accept(), but as I know
the socket API didn't provide this. If you don't like the BDADDR you can
close the connection right after connect. Maybe it is possible to extend
shutdown() to return a request denied option to the other end.

I also have this idea with the connect() return with an error to request
a PIN. This can be set through a setsockopt() or can be a paramter of
sockaddr. But the problem is that you don't have a PIN or pairing for
one L2CAP or RFCOMM connection. You only have it at HCI layer and what
if two applications on the same host request some services on the same
device. Which PIN has to be entered? Should one connect() be delayed
until the first finished his authentication?

>From my point I think the application which establish the connection has
to handle the PIN code. If a device is already paired, the link key
exchange and request should be handled global. I also have played a
little bit with in-kernel (HCI core) handling of the link notification
and response to link requests. But the keys have to stored on shutdown
and restored on the boot.

And a question for the brave ;) How do we handle authentication with a
Bluetooth keyboard?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
