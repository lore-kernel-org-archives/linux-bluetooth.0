Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT mouse disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: sandro.weiser@gmx.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406210029.58265.sandro.weiser@gmx.de>
References: <200406201934.30037.sandro.weiser@gmx.de>
	 <1087756769.4781.44.camel@pegasus>
	 <200406210029.58265.sandro.weiser@gmx.de>
Content-Type: text/plain
Message-Id: <1087787604.4781.149.camel@pegasus>
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
Date: Mon, 21 Jun 2004 05:13:24 +0200

Hi Sandro,

> > May you wanna try to start hidd with the --timeout option and set your
> > own value that is shorter than the timeout value of the mouse. My list
> > says that it uses a timeout of 11 minutes. Maybe you wanna try eight
> > minutes. In the case we terminate the connection everything should work
> > fine.
> I already tried with -t 0 and -t 999999 but none of them solved the problem. 
> After your email I tried -t 8 and now it works as expected.

the point here is who terminates the connection. With -t equal 0 or
greater 12 the mouse will initiate the disconnect and this causes the
problem. This bug is now on my todo list and I hopefully can fix it in a
nice way.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
