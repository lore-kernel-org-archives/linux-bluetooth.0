Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 16 Jan 2007 08:28:37 -0500
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
	<200701151033.37304.akohlsmith-bluez@benshaw.com>
	<d23110170701160502l158c445dwd84a5876ce553820@mail.gmail.com>
In-Reply-To: <d23110170701160502l158c445dwd84a5876ce553820@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200701160828.37391.akohlsmith-bluez@benshaw.com>
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

On Tuesday 16 January 2007 8:02 am, Ulisses Furquim wrote:
> Sorry, but this org.bluez is not an interface, but the bluez service.

I'm still trying to get my head around the dbus nomenclature.  It's a work in 
progress (my understanding, that is).  The various FAQs are helping, but it's 
taking some time yet.

> Yep, hcid is not answering the Introspect calls with the interface
> methods and their signatures.

The latest bluez (3.8) does return a grammatically correct XML response now 
(empty node).  I must ask again though -- how does one see which 
methods/properties bluez makes available through dbus?  How does one find out 
which bluetooth interfaces (hci0, hci1, etc.) are available?

I mean ok I can see how dbus is taking a lot of programming load off of the 
bluez IPC requirements, but it seems that the soul of dbus was removed in the 
bluez implementation.

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
