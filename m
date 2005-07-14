Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f205071408293075bb92@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Using bluez-libs for non-blocking I/O
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
Date: Thu, 14 Jul 2005 17:29:43 +0200

Hi,
I've been digging the bluez mailing lists and the source code of the
libraries for a while, but couldn't find a solution for my problem yet.
I'm writing a bluetooth library in C++, it wraps the whole bluez-libs
around C++ objects, I'll use it for my project of a GUI-based
bluetooth management tool.
Things have not been though until now, I've layed out the whole class
hierarchy and most class member functions don't do anything but calling
their bluez-counterpart.
Now I wanted to implement an event-driven interface, using libsigc++
to provide a basic callback mechanism (basically, the library gets a
event from the hci device and dispatches it to the originating object
trough the appropriate callback functor) but this is giving me quite
some headaches, I'm going to have a single, separate, thread which
does all the poll()ing stuff, I want to reuse as most of the original
bluez library as possible, but I don't know how to make the existing
hci_send_req() return immediately without waiting for a reply (which,
in case of a asynchronous request, will be handled in the
event-dispatching-thread described above), I don't want to rewrite
hci_send_req() nor any of the many functions which rely on it, which
could be the best solution ?

Another question: the existing kernel modules and the library are able
to handle multiple pending requests at once or am I just wasting my
time trying to do something Bluez wasn't actually designed for ?

thanks in advance,
Paul


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
