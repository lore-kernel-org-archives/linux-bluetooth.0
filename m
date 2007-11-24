Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300711240853v4c1aa41cj3c9cf46f4a9b4a8@mail.gmail.com>
Date: Sat, 24 Nov 2007 09:53:57 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <474827AB.1040102@gmail.com>
MIME-Version: 1.0
References: <474827AB.1040102@gmail.com>
Subject: Re: [Bluez-users] using BlueZ with pulseaudio
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

Kristof

I tried the same thing. pulse is the only alsa client I've seen that
automatically tries to use the same mixer as the device you've
specified. You might try to fake it out by making ctl.bluetooth in
asound.rc refer to a hardware mixer.

> (by adding  "load-module module-alsa-sink device=headset" to
> /etc/pulse/default.pa),
>
> I get the following error:
> ----------------------------------------------------------------------------------------------------------------------------------
>
> ALSA lib ctl_bluetooth.c:150:(bluetooth_send_ctl) Unable to request new
> volume value to server: Socket operation on non-socket
> W: alsa-util.c: Unable to load mixer: Socket operation on non-socket
> --------------------------------------------------------------------------------------------------------------------

The ctl side of the code hasn't been worked out completely.

> How can I use this mixer anyway? I have not yet found any alsa
>
> mixer application which lets me configure the name of the mixer device
> to use.

alsamixer -D bluetooth

should give you the same error

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
