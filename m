Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200701160828.37391.akohlsmith-bluez@benshaw.com>
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
	<200701151033.37304.akohlsmith-bluez@benshaw.com>
	<d23110170701160502l158c445dwd84a5876ce553820@mail.gmail.com>
	<200701160828.37391.akohlsmith-bluez@benshaw.com>
Date: Tue, 16 Jan 2007 14:59:12 +0100
Message-Id: <1168955952.8918.9.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez and dbus - how to turn on discovery?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andrew,

> > Sorry, but this org.bluez is not an interface, but the bluez service.
> 
> I'm still trying to get my head around the dbus nomenclature.  It's a work in 
> progress (my understanding, that is).  The various FAQs are helping, but it's 
> taking some time yet.

we all had our problems. You actually need to use it to understand how
it works.

> > Yep, hcid is not answering the Introspect calls with the interface
> > methods and their signatures.
> 
> The latest bluez (3.8) does return a grammatically correct XML response now 
> (empty node).  I must ask again though -- how does one see which 
> methods/properties bluez makes available through dbus?  How does one find out 
> which bluetooth interfaces (hci0, hci1, etc.) are available?

The introspection support is a problem and we know that. Mainly this is
because the low-level D-Bus API (which we use) makes it kinda hard to
easily support introspection. Especially if you have a lot of methods
and signals it is kinda horrible. And right now we simply haven't added
full introspection support. However we have a dbus-api.txt document in
the the source code that describes all methods and signals.

And to answer your question. You connect to the org.bluez service and
then you call org.bluez.Manager.ListAdapters() on the /org/bluez object
path. The return will be a list of object paths that implement the
org.bluez.Adapter interface. It sounds strange, but once you understood
it, it makes perfect sense.

> I mean ok I can see how dbus is taking a lot of programming load off of the 
> bluez IPC requirements, but it seems that the soul of dbus was removed in the 
> bluez implementation.

This has nothing to do with the soul of D-Bus. It is simply a big
difference if you use a high-level language or C with no additional
bindings.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
