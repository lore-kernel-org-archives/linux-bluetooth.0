Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean-Jacques Brucker <jjbrucker@free.fr>
In-Reply-To: <200609300218.36747.jjbrucker@free.fr>
References: <17692.1030.64904.774688@altoids.csail.mit.edu>
	<200609292208.33700.jjbrucker@free.fr>
	<1159571362.29673.34.camel@localhost>
	<200609300218.36747.jjbrucker@free.fr>
Date: Sat, 30 Sep 2006 10:01:16 +0200
Message-Id: <1159603276.5407.7.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid pairing bug when security is auto
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

Hi Jean-Jacques,

> > This is for debugging purpose and really special use cases.
> Which ones (use cases) ?

I think the debugging purpose is clear, I needed it. The special use
cases are fixed pair of devices with a fixed PIN or a static random PIN
that people can remember. It is possible to implement all this using the
passkey agent, but for some embedded devices a static PIN is needed and
therefor it is there. However, this feature is undocumented for a
reason, but it is not for the ordinary desktop user. The desktop user
also has no write access to this directory.

> I've tried the bluez passkey-agent, and it is not very practical to have 3 
> "deamons" (hcid, dbus-daemon and the passkey agent) just to pair new devices.

The hcid is running as root, the system D-Bus daemon as message bus user
and the passkey agent as normal unprivileged user. It is not black and
white and Linux (including Bluez) scales from very small system to big
ones.

> At least explain me why the auto mode make the difference between outgoing and 
> incoming connections ? 
> Or make the auto mode use the default passkey in both cases ! (or remove the 
> auto mode to really force users to use dbus ...).

The auto mode is no longer default. That was a mistake in the default
config. What you really want is user, which is also more secure than a
default PIN for all incoming connection. The reason why it exists is
historical. We wrote it when the first chips supported authentication
and encryption. Sounded like a nice idea back then.

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
