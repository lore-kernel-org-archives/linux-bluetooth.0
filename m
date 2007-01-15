Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sourceforge.net
Date: Mon, 15 Jan 2007 11:08:14 -0500
References: <200701150802.45350.akohlsmith-bluez@benshaw.com>
	<1168867454.5728.8.camel@violet>
In-Reply-To: <1168867454.5728.8.camel@violet>
MIME-Version: 1.0
Message-Id: <200701151108.14727.akohlsmith-bluez@benshaw.com>
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

On Monday 15 January 2007 8:24 am, Marcel Holtmann wrote:
> I never used kdbus and so I can't tell you if that would work or not. I
> always use the native interface from C or from Python. Some people use
> dbus-send, but I can't remember the syntax.

For the archives, this is how you do it with dbus-send:

$ dbus-send --system --dest=org.bluez --print-reply=1 /org/bluez/hci0 
org.bluez.Adapter.SetMode string:discoverable

Howver... I see no hci0, I see no methods (i.e. Adapter isn't there, SetMode 
isn't there)...  it looks like the bluez 3.7 release does not have any kind 
of introspection or way of seeing what it provides programmatically.  Is this 
true?

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
