Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <87zmeuq6iw.fsf@phugues.par.afp.com>
References: <87zmeuq6iw.fsf@phugues.par.afp.com>
Date: Sat, 29 Jul 2006 14:54:50 +0200
Message-Id: <1154177690.25939.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] typo in dbus-test python script
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

Hi Hugues,

> Just in case you did'nt notice, there is apparently a typo in the
> dbus-test python script in the CVS repository.
> 
> Index: hcid/dbus-test
> ===================================================================
> RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
> retrieving revision 1.20
> diff -u -r1.20 dbus-test
> --- hcid/dbus-test	26 Jun 2006 12:33:13 -0000	1.20
> +++ hcid/dbus-test	28 Jul 2006 12:01:58 -0000
> @@ -186,7 +186,7 @@
>      @dbus.decorators.explicitly_pass_message
>      def mgr_signal_handler(*args, **keywords):
>          dbus_message = keywords["dbus_message"]
> -        print '%s: ' % dbus_messsage.get_member()
> +        print '%s: ' % dbus_message.get_member()
>          for arg in args[1:]:
>              print '%s   ' % arg,
>          print

you are right. Thanks for pointing this out. It is fixed in the CVS now.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
