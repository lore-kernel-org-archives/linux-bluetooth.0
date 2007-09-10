Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e96e9eeb0709092329y686f2f38x479898e640438f03@mail.gmail.com>
Date: Mon, 10 Sep 2007 09:29:25 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluez obex problem
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

hi list,

i'm trying to use btobex (compiled from bluez' obex cvs package).

i can push files just wonderful using:

 ./btobex -i hci0 push target-bdaddr file-to-send

but i didn't manage to receive files as I need to supply btobex some "channel":

./btobex pull <bdaddr> [channel]

what is this channel ?
how can i get it ?
i just want my device to accept files pushed from other devices...

(it is embedded and i need the simplest possible command line obex
tool)

thank you !
voni

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
