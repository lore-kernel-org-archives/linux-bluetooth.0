Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Fulvio <fulvio@pc.jaring.my>
To: bluez-users@lists.sourceforge.net
Date: Mon, 24 Sep 2007 19:09:50 +0200
References: <1190642401.6465.20.camel@localhost>
In-Reply-To: <1190642401.6465.20.camel@localhost>
MIME-Version: 1.0
Message-Id: <200709241909.50864.fulvio@pc.jaring.my>
Subject: Re: [Bluez-users] problem pairing device
Reply-To: fulvio@pc.jaring.my, BlueZ users <bluez-users@lists.sourceforge.net>
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

On luned=EC 24 settembre 2007, Michele Puccio wrote:
> =A0 =A0 =A0 =A0 Class: 0x000100
> =A0 =A0 =A0 =A0 Service Classes: Unspecified
> =A0 =A0 =A0 =A0 Device Class: Computer, Uncategorized

Try to specify a better class like:

hciconfig hci0 (or which rely on) class 0x03e100

I can't assure this is the fix, but there'll be other things to try like

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez /o=
rg/bluez/hci0 =

org.bluez.Adapter.GetMode

To know if it's in discorable mode

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez /o=
rg/bluez/hci0 =

org.bluez.Adapter.GetDiscoverableTimeout

To know how long it'll remain on disoverable mode

F

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
