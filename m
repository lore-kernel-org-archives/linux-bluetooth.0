Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030306150232.02448f80@mail1.qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Stephen Crane <steve.crane@rococosoft.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: New BlueZ Security Manager
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1046879580.1823.136.camel@pegasus.local>
References: <1046871982.2860.1155.camel@baroque.rococosoft.com>
	<1046871982.2860.1155.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Thu, 06 Mar 2003 15:10:50 -0800
Content-Type: text/plain; CHARSET=us-ascii

At 07:52 AM 3/5/2003, Marcel Holtmann wrote:
>I never used it, but if I remember correclty this can be done through
>the L2CAP_LM option with setsockopt(). 
Yep. pand --encrypt uses that features.

>But it can't be done for RFCOMM at the moment. Max told me that he have 
>this on his todo list.
Yep.

>> I don't think that the current kernel API is rich enough to permit this.
>> It ought to be possible for a server listening on a socket to discover
>> the BDADDR of the connecting peer and either accept() or reject access
>> --- probably through an ioctl(). On the client-side, a special error
>> return from (or argument to) connect() could indicate that a PIN was
>> required to connect.
>
>It would be great to know the IP before doing a accept(), but as I know
>the socket API didn't provide this. If you don't like the BDADDR you can
>close the connection right after connect. Maybe it is possible to extend
>shutdown() to return a request denied option to the other end.
>
>I also have this idea with the connect() return with an error to request
>a PIN. This can be set through a setsockopt() or can be a paramter of
>sockaddr. But the problem is that you don't have a PIN or pairing for
>one L2CAP or RFCOMM connection. You only have it at HCI layer and what
>if two applications on the same host request some services on the same
>device. Which PIN has to be entered? Should one connect() be delayed
>until the first finished his authentication?
Like I said application doesn't have to be involved in this. All it has 
to do is say "this socket needs authenticated (or encrypted) connection".

>>>From my point I think the application which establish the connection has
>to handle the PIN code. 
>If a device is already paired, the link key exchange and request should be 
>handled global. I also have played a little bit with in-kernel (HCI core) 
>handling of the link notification and response to link requests. But the keys 
>have to stored on shutdown and restored on the boot.
We talked about that. PIN code is not a per application or per user level thing.
Current implementation is fine. We just need a database that can be easily updated.

>And a question for the brave ;) How do we handle authentication with a
>Bluetooth keyboard?
Good one. Voice recognition ? ;-)

Max



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
