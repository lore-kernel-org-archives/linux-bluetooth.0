Return-Path: <cyrus@holtmann.org>
Message-ID: <47BB5F2D.8010706@wershofen.de>
Date: Tue, 19 Feb 2008 23:58:53 +0100
From: Wolfgang Wershofen <wolfgang@wershofen.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <mailman.551346.1203302340.26582.bluez-users@lists.sourceforge.net>
	<BLU140-W15FA67671DB5E1E6450FBECB220@phx.gbl>
In-Reply-To: <BLU140-W15FA67671DB5E1E6450FBECB220@phx.gbl>
Subject: Re: [Bluez-users] Twinkle and bluetooth headset's microphone
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

mountain rides schrieb:
>
> A new challenge for the readers of the mailing list: getting the bluetooth headset's microphone working with Twinkle.
>
> The sound from Twinkle comes through the headset loud and clear.
>
> I tried the same for the Microphone: I selected "ALSA: other device", and in the corresponding "Other device" field, I entered the word "bluetooth".  But, after making those settings, no one can hear anything I'm saying through the headset and Twinkle.  Hmmmmm.
>   
Same situation here. arecord works flawlessly, but the other end of a
VOIP connection through twinkle only gets loud white noise from my side.
There's actually a discussion about that on the twinkle mailing list and
the developers there are pretty sure it's a timing problem. twinkle is
rapidly opening and closing the alsa input device during a connection
and it seems, the closing of the bluetooth device returns asynchronously
and later than the next subsequent open instruction. That's at least my
limited understanding of the problem.
The twinkle guys are suspecting a bug in the bluetooth audio
implementation, see the following quote from the ongoing discussion:

<quote>

bluetooth has problems with twinkle!
Anyway, rapid closing and reopening a handle isn't anything rogue at all. If 
this is the source of the problem, it's clearly a bug in ALSA stack resp. the 
bluez/pulseaudio plugins. Those plugins have to handle any timing issues with 
their associated hardware. You never can guarantee that such a close-open 
sequence never will occur, from *any* app - just twinkle is doing this 
frequently. It's up to the bluez devs to write a (twinkle-inspired?) 
testframe to provoke this error, and to harden their plugin so it handles 
this correctly. I.E close() MUST NOT return premature (alias async), and 
open() maybe has to wait until any "pending" close() has finished inside 
driver.

</quote>

So, now, we are at least two people with the same problem - maybe anyone from the bluez side will finally have a look into this matter now.

cu
Wolfgang


-- 
Geek by nature, Linux by choice



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
