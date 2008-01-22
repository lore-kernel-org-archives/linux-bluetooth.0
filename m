Return-Path: <cyrus@holtmann.org>
Message-ID: <4796056A.8030306@aircable.net>
Date: Tue, 22 Jan 2008 13:02:02 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <QiqzmGYI.1201010734.9272710.fma@alezan.org>	<4795F9EC.20509@aircable.net>
	<1201012984.21244.9.camel@McM>	<47960225.4000004@aircable.net>
	<1201013784.21244.12.camel@McM>
In-Reply-To: <1201013784.21244.12.camel@McM>
Subject: Re: [Bluez-users] Newbie needs help to start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Miguel escribi=F3:
> and is it possible to access to a mobile profile bluetooth?
>   =

I'm not sure about it, it just opens an RFCOMM connection, I would say so.
> Is it possible to do via Java? (access to the mobile agenda, read
> sms, ...)
>   =

You might need to implement the a service of RFCOMM, or use any of the
dbus services that do it for you, there's a dbus binding for java.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
