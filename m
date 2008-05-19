Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805190124x1fced786h16c3475cf76a4a80@mail.gmail.com>
References: <3e9cdced0805190124x1fced786h16c3475cf76a4a80@mail.gmail.com>
Date: Mon, 19 May 2008 10:52:48 +0200
Message-Id: <1211187168.13248.0.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] using bluez without the dbus-daemon,
	just	dbus-lib as peer-to-peer connection
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

Hi Fritz,

> dbus can be used in two modes, on the one hand just the dbus library
> in order to establish a point-to-point communication between two
> processes,
> on the other hand with the dbus-daemon which uses the library in order
> to allow the communication of many different processes with each
> other.
> 
> In my specific scenario I have to safe system resources since I'm
> developing for an embedded arm system and I only have one single
> application which has to communicate with bluez.
> 
> Is it possible to use bluez only with the dbuslib (without
> dbus-daemon) in order to establish a point-to-point communication
> between bluez and an application which uses the bluez/bluetooth
> features?
> If yes which part of bluez is responsible for doing that?
> Are there any differences in the view of bluez-functionalities between
> this two modes of communication besides the obvious that there can be
> only one peer-to-peer connection?

the answer is no, you can't do that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
