Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] [Fwd: Bug#322732: bluez-utils: rfcomm bind fails
	with obscure error message]
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1124658001.1592.21.camel@saag.bunker.heddley.com>
References: <1124658001.1592.21.camel@saag.bunker.heddley.com>
Content-Type: text/plain
Message-Id: <1124709149.23599.19.camel@pegasus>
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
Date: Mon, 22 Aug 2005 13:12:29 +0200

Hi Edd,

> > When the 'rfcomm' kernel module isn't compiled with CONFIG_BT_RFCOMM_TTY
> > enabled, 'rfcomm bind' will fail with an obscure error message, "Can't
> > create device: Operation not supported".  It does this when it's trying to
> > bind to a device in /dev.

this error message is correct. It follows the errno error code that
comes back from the kernel.

> > Could this be changed to report something more useful, such as "Check
> > rfcomm.ko is compiled with TTY support"?

What about a patch for the RFCOMM manual page that explains this
problem?

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
