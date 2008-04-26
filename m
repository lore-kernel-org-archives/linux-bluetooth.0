Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300804261337y599d34d5p4454238c08cb9698@mail.gmail.com>
Date: Sat, 26 Apr 2008 14:37:46 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] exports for pulseaudio
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

I've been looking over the pulse integration problem. I'd like to help
get issues out of the way for Jo=E3o Vita to make some good headway.

Maybe the biggest issue is we need to export some functions for
getting the audio stream socket. It would also make a lot of sense to
provide access to the sbc codec at the same time. A native pulse
plugin will need direct access to do its own sbc encoding. Hopefully
Lennart will be ok with the idea of some minimal codec handling in a
plugin--I can't see any other way around it.

Jo=E3o could hack things up for a proof of concept by copying code from
bluez/audio into his plugin, but will he need to do that?

http://wiki.bluez.org/wiki/PulseIntegration

-- =

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
