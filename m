Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 28 Nov 2007 15:39:35 +0100
Message-ID: <56C8D22F4B7F104DBE581411F10682E9268FE8@beyondsoft.dyndns.org>
References: <474D6B82.40206@aircable.net>
From: "Matthias Becker" <matthias.becker@beyondsoft.de>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Set security level?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Most phones don't require pairing when using obex push (not obex ftp). =


-----Urspr=FCngliche Nachricht-----
Von: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-devel-bounces@=
lists.sourceforge.net] Im Auftrag von Manuel Naranjo
Gesendet: Mittwoch, 28. November 2007 14:22
An: BlueZ development
Betreff: [Bluez-devel] Set security level?

Hello everyone,

I'm working on an Open Source Proximity marketing solution. And I need
to know something, I know that there's a way to send files over obex
without the need to pair (depending on the phone capabilities off
course, and user acceptance). I know that this can be used for spamming,
but that's not my intention.

The question would be, is there any way to change the security level of
a connection via dbus? I know this has to be handled at a very low
level, before you can even get the rfcomm connection, and I don't think
this should be handled for the hole hci device because this would be a
security issue.

Thanks,
Manuel

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
