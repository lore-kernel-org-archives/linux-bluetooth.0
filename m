Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 18 Jun 2006 15:09:45 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150540202.17539.24.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.63.0606181503351.8278@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0606131336450.23668@redbean.intranet.gw-instruments.de>
	<1150540202.17539.24.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM TTY behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net



Hi Marcel, 

> the main API of RFCOMM is the socket. So I don't actually bother that
> much with the TTY stuff. However patches are always welcome. Feel free
> to provide actual code for the change you described.

Yes, I know that BlueZ is focused on the socket API. This isn't bad as 
long as you can use sockets. In the case we have here the tty API is 
needed because of backward compatibility reasons. 

I will try to implement the suggested changes and send a patch if it 
works. And I hope I don't forget to change my editor to Hard Tab indenting 
so it gets a chance to get accepted.

Ciao, 

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
