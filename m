Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez-hciemu-1.0 on Debian--GLib not
	found
From: Marcel Holtmann <marcel@holtmann.org>
To: Tehyih D Wan <tdwan@MIT.EDU>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1081889721.407c53b90c5d4@webmail.mit.edu>
References: <1081889721.407c53b90c5d4@webmail.mit.edu>
Content-Type: text/plain
Message-Id: <1082161011.4489.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 17 Apr 2004 02:16:51 +0200

Hi Debbie,

> I'm trying to install bluez-hciemu on Debian, and getting the error "checking
> for glib-config...not found" when I run the ./configure script.
> 
> I've installed libglib2.0, libglib2.0-dev, libglib2.0-data, and libglib2.0-dbg,
> but I still get the same error when running the ./configure script.
> 
> There was a thread about this same problem back in 2003 but the only suggestion
> seemed to be to try installing the -dev packages for Glib.  Any ideas on what
> else I might try?

change the source of hciemu to use Glib 2.x (and send us a patch) or
install the development packages of Glib 1.4.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
