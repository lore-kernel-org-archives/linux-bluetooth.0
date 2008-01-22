Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <QiqzmGYI.1201010734.9272710.fma@alezan.org>
In-Reply-To: <4795F1C9.9050609@aircable.net>
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= <fma@gbiloba.org>
MIME-Version: 1.0
Date: Tue, 22 Jan 2008 15:05:34 +0100 (CET)
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


Le 22/1/2008, "Manuel Naranjo" <manuel@aircable.net> a =E9crit:

>The process is simple, when you start a connection there's an initial
>phase where both devices authenticate, for this they exchange something
>called link key it's something similar to the way ssh works. If the link
>keys aren't generated yet then they exchange a PIN code, this is what
>the passkey agent does.
>
>After the authentication has been done then the connection is possible.

Ok, I got it. But how and where do I generate link keys?

>The fast and easy way to do it, it's using the old rfcomm tool from the
>bluez-utils package then you do:
>rfcomm connect rfcomm# ADDR [CHANNEL]
>
>For SPP you generally use channel 1 (the Serial3 is one of those cases)
>
># is a number of a valid and available rfcomm node, you will need to
>create it, check the web for the mayor number of the rfcomm node.

So, after I connect the BT device to the rfcomm channel, I can read/write
to it using the /dev/rfcomm entry, like if I'm using a /dev/ttySxx ?

If I understand correctly, rfcomm is not supported anymore? If it is the
old way, what is the new way?

>Again BlueZ is the stack, without it you can't do any bluetooth work
>under linux. D-Bus layer is used to make the programmers life easier as
>it hides all the bluez lib complexity (trust me you don't want to get
>much deeply into it, it requires serious bluetooth understanding)

I certainly don't want to deep inside d-bus, but the fact is that python
examples on bluez wiki use d-bus module :o/

>Anyway, and again, without a full hcidump trace, we can't tell you
>what's wrong, and guide you through this stuff.

I attached it.

>PS: BTW slackware has some patches in common with debian, they have a
>folder called /etc/bluetooth/passkeys there you can store files for
>default passkeys, you can have one called default and it uses for a
>default pin code, not the most secure way, but it works some how.

Ok.

--
    Fr=E9d=E9ric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
