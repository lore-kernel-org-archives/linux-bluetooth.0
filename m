Return-Path: <cyrus@holtmann.org>
Message-ID: <4795F1C9.9050609@aircable.net>
Date: Tue, 22 Jan 2008 11:38:17 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <YjUrTxrF.1201006822.0605530.fma@alezan.org>
In-Reply-To: <YjUrTxrF.1201006822.0605530.fma@alezan.org>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


> The fact is that I don't understand the blutetooth process, and I'm
> missing half of your explanations... I'm still looking for a good
> documentation which presents BT.
>   
The process is simple, when you start a connection there's an initial
phase where both devices authenticate, for this they exchange something
called link key it's something similar to the way ssh works. If the link
keys aren't generated yet then they exchange a PIN code, this is what
the passkey agent does.

After the authentication has been done then the connection is possible.
> Bluetooth seems to mix hardware and software layers, and the linux
> implementation seems to add more out-of-topic stuffs (dbus, for
> exemple). The result is that I'm totally lost...
>   
Indeed bluetooth specifies both software and hardware, bluez is the
Bluetooth stack for Linux, a sort of firmware if you want to understand
it like that.

> My goal is not to develop bluetooth, but, as a first step, to use the
> Serial3 like I use a USB-to-Serial converter (simply talking to
> /dev/ttyUSBxx, like to any other ttySxx). I want my app to be
> cross-plateform, and if I have to go so deep in the system on each one,
> I think I made a mistake choosing bluetooth!
>   
The fast and easy way to do it, it's using the old rfcomm tool from the
bluez-utils package then you do:
rfcomm connect rfcomm# ADDR [CHANNEL]

For SPP you generally use channel 1 (the Serial3 is one of those cases)

# is a number of a valid and available rfcomm node, you will need to
create it, check the web for the mayor number of the rfcomm node.

> Debian is maybe also the wrong plateform to use BT, as I seem to have
> more troubles than you, under Mandriva...
>   
Thing is that I have them solved :D, not that I didn't have those in the
past.
> Last, I didn't understand what exactly starts and ends bluez project...
>   
Again BlueZ is the stack, without it you can't do any bluetooth work
under linux. D-Bus layer is used to make the programmers life easier as
it hides all the bluez lib complexity (trust me you don't want to get
much deeply into it, it requires serious bluetooth understanding)

Hope this clarifies your ides,
Anyway, and again, without a full hcidump trace, we can't tell you
what's wrong, and guide you through this stuff.

Cheers,
Manuel

PS: BTW slackware has some patches in common with debian, they have a
folder called /etc/bluetooth/passkeys there you can store files for
default passkeys, you can have one called default and it uses for a
default pin code, not the most secure way, but it works some how.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
