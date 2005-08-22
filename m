Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] [Fwd: Bug#322732: bluez-utils: rfcomm bind fails
	with obscure error message]
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200508221448.11084.bluez-user@schaettgen.de>
References: <1124658001.1592.21.camel@saag.bunker.heddley.com>
	 <1124709149.23599.19.camel@pegasus>
	 <200508221448.11084.bluez-user@schaettgen.de>
Content-Type: text/plain
Message-Id: <1124720419.23599.37.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 22 Aug 2005 16:20:19 +0200

Hi Fred,

> > > > When the 'rfcomm' kernel module isn't compiled with
> > > > CONFIG_BT_RFCOMM_TTY enabled, 'rfcomm bind' will fail with an obscure
> > > > error message, "Can't create device: Operation not supported".  It does
> > > > this when it's trying to bind to a device in /dev.
> >
> > this error message is correct. It follows the errno error code that
> > comes back from the kernel.
> 
> There is a difference between "correct" and "helpful" ;)
> You might at least consider pointing users to the manpage along with the 
> generic error message for diagnosis of the error, because not too many will 
> actually try the manpage.
> Error codes are for scripts, error messages are for people. If you need the 
> manpage to figure out what's wrong, then you could just as well print the 
> error code only. Listing the error codes in the manpage should be only 
> necessary to list all *possible* errors, so that scripts can handle all of 
> them for instance.

the command line tools are still the Unix world and an error which is
called "Operation not supported" is from my perspective a clear error
that the tool in use or the kernel lacks support for something. And in
this specific case he compiled the kernel by itself and not included
support for RFCOMM TTY in the rfcomm.ko module.

Said this, I don't like additional switch or if statements to add a lot
of user friendly error messages to make the users feel better. For
command line tools it is fine to expect people to open a manual page to
investigate further. For graphical tools this is different, but the last
time I checked rfcomm is still command line only ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
