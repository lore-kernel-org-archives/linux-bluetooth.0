Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] [Fwd: Bug#322732: bluez-utils: rfcomm bind fails with obscure error message]
References: <1124658001.1592.21.camel@saag.bunker.heddley.com> <1124709149.23599.19.camel@pegasus>
In-Reply-To: <1124709149.23599.19.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508221448.11084.bluez-user@schaettgen.de>
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
Date: Mon, 22 Aug 2005 14:48:10 +0200

On Monday, 22. August 2005 13:12, Marcel Holtmann wrote:
> Hi Edd,
>
> > > When the 'rfcomm' kernel module isn't compiled with
> > > CONFIG_BT_RFCOMM_TTY enabled, 'rfcomm bind' will fail with an obscure
> > > error message, "Can't create device: Operation not supported".  It does
> > > this when it's trying to bind to a device in /dev.
>
> this error message is correct. It follows the errno error code that
> comes back from the kernel.

There is a difference between "correct" and "helpful" ;)
You might at least consider pointing users to the manpage along with the 
generic error message for diagnosis of the error, because not too many will 
actually try the manpage.
Error codes are for scripts, error messages are for people. If you need the 
manpage to figure out what's wrong, then you could just as well print the 
error code only. Listing the error codes in the manpage should be only 
necessary to list all *possible* errors, so that scripts can handle all of 
them for instance.

regards
Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
