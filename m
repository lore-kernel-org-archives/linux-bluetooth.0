Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1c9b31320711220913r1f89aafgcf88c0927bfb1c1@mail.gmail.com>
Date: Thu, 22 Nov 2007 19:13:55 +0200
From: "Johan Hedberg" <johan.hedberg@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <9a119b3c0711220826u405b3845pb1101fcfb2c42e3c@mail.gmail.com>
MIME-Version: 1.0
References: <9a119b3c0711220826u405b3845pb1101fcfb2c42e3c@mail.gmail.com>
Subject: Re: [Bluez-users] Using AVRCP with current BlueZ
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

Hi Kristof,

On Nov 22, 2007 6:26 PM, Csillag Krist=F3f <csillag.kristof@gmail.com> wrot=
e:
> My question is, how can I use AVRCP now? bluetooth-alsa used to contain
> some support for it, but now I guess it's gone. Browsing the source
> code of bluez-utils, I see some dbus interface, but I can not find
> any example demonstrating how to use this.
>
> Could you please point me to the right documentation (if it exists)?

I don't think there is any proper documentation yet. bluez-utils-3.22
has some preliminary AVRCP support but by default it's disabled. You
need to add a line "Enable=3DControl" to the General section in
/etc/bluetooth/audio.conf to enable it. Currently no D-Bus signals or
or methods are supported. Instead, the audio service uses the kernel
uinput interface (you need to have the uinput module loaded) to inject
keypress events to the kernel input subsystem. You can see what kind
of AVRCP->keycode mappings are used by looking in the audio/control.c
file from bluez-utils.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
