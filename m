Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4747F86B.4010504@gmail.com>
Date: Sat, 24 Nov 2007 11:09:47 +0100
From: Csillag Kristof <csillag.kristof@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <9a119b3c0711220304w352b42ads21eb25f021c2ed80@mail.gmail.com>
In-Reply-To: <9a119b3c0711220304w352b42ads21eb25f021c2ed80@mail.gmail.com>
Subject: Re: [Bluez-users] integrating BlueZ into remote session
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

Csillag Krist=F3f wrote:

> Hi there!
>
> I am maintaining a system with thin-client terminals,
> which are running X locally, and remote gnome sessions
> on the server. (This works pretty good.)
>
> I would like to configure BlueZ on the clients, so
> that they can use local Bluetooth devices.
>
> [...]
>
> Or should I try to run the relevant GUI applications locally on
> the client, and integrate them into the desktop running remotely
> on the server? (Does the gnome panel accept applets running on
> different hosts than the desktop?)
>   =

This approach worked. So, here is how to do it:
  1. start the X server on the client
  2. start the gnome session on the server
     (LTSP handles the first two steps automatically.)
  3. from your gnome session running on the server,
      one an SSH session to the client
  4. set the DISPLAY variable to the local X server (:6 in LTSP)
  5. start the blutooth-applet
      (Steps 3-5 can be done automatically, from a script.)

If I do this, the bluetooth applet automagically appears in the tray
applet! (This is cool, because the tray applet is sitting on the
gnome panel which is running on the server, but the locally running
bluetooth-applet finds at anyway.)

After this, the bluetooth-applet works just fine. (Asks for PIN, etc.)

So, after all, this works, almost out-of-the-box.

    Kristof


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
