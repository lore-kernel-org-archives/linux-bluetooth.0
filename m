Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0709092329y686f2f38x479898e640438f03@mail.gmail.com>
References: <e96e9eeb0709092329y686f2f38x479898e640438f03@mail.gmail.com>
Date: Mon, 10 Sep 2007 21:05:52 +0200
Message-Id: <1189451152.687.51.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez obex problem
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

Hi Voni,

> i'm trying to use btobex (compiled from bluez' obex cvs package).
> 
> i can push files just wonderful using:
> 
>  ./btobex -i hci0 push target-bdaddr file-to-send
> 
> but i didn't manage to receive files as I need to supply btobex some "channel":
> 
> ./btobex pull <bdaddr> [channel]
> 
> what is this channel ?
> how can i get it ?
> i just want my device to accept files pushed from other devices...

you ahead and actually do read the Object Push Profile specification
since you messed up the terminology here. The pull command is still a
client connection that pulls something from a server and not a server
that might accept incoming connections.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
