Return-Path: <cyrus@holtmann.org>
Message-ID: <15840.82.115.163.144.1208171593.squirrel@posta.7girello.net>
Date: Mon, 14 Apr 2008 13:13:13 +0200 (CEST)
From: "Jimmi" <jimmi@libero.it>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez3.30 audio/serial plugin issue
Reply-To: jimmi@libero.it,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann <marcel <at> holtmann.org> writes:
> I would like to ignore it, but I can't. Can you do a ls -la inside the
> installed plugins directory. Maybe libtool is messing this up. Or
> maybe is still tries to load the *.la files and fails, because of

Same problem here, Marcel. I run Archlinux with kernel 2.6.24 on my laptop
and after upgrading today to bluez 3.30 I got the same error.

The plugin directory looks as follow:
# ls -ll /usr/lib/bluetooth/plugins/
totale 296
-rwxr-xr-x 1 root root 132972 13 apr 09:49 libaudio.so
-rwxr-xr-x 1 root root  52504 13 apr 09:49 libinput.so
-rwxr-xr-x 1 root root  58111 13 apr 09:49 libnetwork.so
-rwxr-xr-x 1 root root  50857 13 apr 09:49 libserial.so

BTW where should I put the option --enable-glib?

If you have any other debugging procedure I'll be glad to try them.

Thanks in advance
Jimmi


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
