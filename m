Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: bluetoothd specification - new patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05072612066bd4d11a@mail.gmail.com>
References: <e1effdeb05071213476bbc0fa0@mail.gmail.com>
	 <e1effdeb050715103731d599d7@mail.gmail.com>
	 <42DBD4F5.8000805@palmsource.com>
	 <e1effdeb05071809461382a01c@mail.gmail.com>
	 <e1effdeb05072609312aa92cc0@mail.gmail.com>
	 <1122398308.5805.24.camel@notepaq>
	 <e1effdeb05072612066bd4d11a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1122415021.6005.7.camel@notepaq>
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
Date: Tue, 26 Jul 2005 23:57:01 +0200

Hi Claudio,

> I will fix it. The current patch is just a skeleton(draft)
> of my idea.

very good.

> Basically only the function signature or name changed, the behaviour 
> are the same. The current code is compatible with 0.23, 0.33 and 0.34.
> I didn't test the 0.35 version. But, I belive that we will not have problems.
> The current "configure"(2.18) file is using AC_CHECK_LIB, for check function
> availability. This is not so elegant too.
> In my current implementation the version of D-Bus is checked by "configure".
> There is no references to changed functions in the code, I defined macros
> replacing the function name/signature according to D-Bus version.

I think you missed my point. If some function is not available in 0.23,
but it is in 0.3x then implement it in compat.c via a "static inline"
function covered by an "#ifdef".

And I do think that the checking for a specific library is a good thing
to do, because tracking specific versions is bad. And after D-Bus 1.0 is
released I might remove all compat D-Bus function from the BlueZ source
code.

> The current main loop is exactly the same approach of Glib.
> bluetoothd supposes to be the main daemon, therefore it must
> be the first D-Bus object of the hierarchy and the object resposible
> for start the connection, register the object, register filters, 
> handle signals(Disconnect, NameOwnerChanged, NameAcquired ...)
> The file descriptor poll should be flexible in order to handle other
> file descriptors(socket for incomming connections, socket for hci packets).
> These are the assumptions that I considered.

What has the D-Bus object to do with the event loop? The event loop is
something that is provided by Glib and we need our own implementation.
The bluetoothd then adds file descriptors to the watch and that's it. I
don't see any need why D-Bus must be the first file descriptor in the
list and so bluetoothd itself and the event loop implementation are
independent from each other.

> I am not understanding how you plan integrate hcid and HAL. Could you
> give me more details?

This is not what I said. I said that we should model the D-Bus methods
and signals like the HAL people did.

> HCI and SDP are essential to the others profiles. PAN is important to me
> because I am developing a network library to help multiplayer games
> developers and UPnP applications control bluetooth connections.
> I will create a document with the basic interfaces required and submit 
> a for your analysis as son as possible. But I will keep coding because
> I have a schedule to follow.

I can't do anything about your schedule. For it is important that we get
a clean interface over D-Bus.

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
