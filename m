Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RFCOMM communication gets stalled
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDC76@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDC76@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1089915789.4517.43.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Jul 2004 20:23:09 +0200

Hi Richard,

> I use the rfcomm tty interface quite successfully for sending GPS data
> strings from a GPS receiver to an Ipaq and then to another small wrist display.
> Why use the rfcomm socket interface instead of the TTY ? 
> 
> Should I consider changing my code from TTY to socket ? Its not so difficult, I just
> wonder why you recommend one vs the other.

the question is what is the advantage of keeping a legacy TTY if you
already have the source code? There is no difference between a socket
descriptor and a file descriptor, so why involve another subsystem?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
