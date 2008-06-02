Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Mats Karlsson <mkn0014@gmail.com>
Date: Mon, 2 Jun 2008 17:51:29 +0000 (UTC)
Message-ID: <loom.20080602T174639-887@post.gmane.org>
References: <4531BD65.1020107@gmail.com> <1160917860.23675.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PIN Authentication Problems on MDV 2007
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

> Hi Manuel,
>
> starting with bluez-utils-3.x the PIN helper concept has been replaced
> with a passkey agent interface. You need to run a passkey agent to get
> you PIN request dialog. One example would be bt-applet from the
> bluez-gnome package.
> 
> Regards
> 
> Marcel

Marcel,

Witch passkey agent is recommended on machines with only console interface
(CLI), example: Servers and appliances ?

Is the passkey-agent.c still a example or has it matured to a non example code ?


Kind regards
Mats


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
