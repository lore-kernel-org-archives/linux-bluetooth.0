Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU140-W15FA67671DB5E1E6450FBECB220@phx.gbl>
From: mountain rides <gstaad22@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 19 Feb 2008 21:11:54 +0000
In-Reply-To: <mailman.551346.1203302340.26582.bluez-users@lists.sourceforge.net>
References: <mailman.551346.1203302340.26582.bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Twinkle and bluetooth headset's microphone
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




Thanks Leszek, you were right.  I didn't need to be bothering with hcitool =
etc at all.  The Gnome applet had me sorted all along.  I guess my understa=
nding stemmed from reading too many out-of-date web pages.

A new challenge for the readers of the mailing list: getting the bluetooth =
headset's microphone working with Twinkle.

Twinkle is software I use to access my VOIP account (phone line).  I am abl=
e to hear the people I talk to with Twinkle through the bluetooth headset h=
aving having (A) created a ~/.asoundrc as explained in http://wiki.bluez.or=
g/wiki/HOWTO/AudioDevices and (B), in Twinkle, opened Edit> System Settings=
...> Audio and, for Speaker, selected "ALSA: other device" and then entered=
 in the "Other device" field: the word "bluetooth".

The sound from Twinkle comes through the headset loud and clear.

I tried the same for the Microphone: I selected "ALSA: other device", and i=
n the corresponding "Other device" field, I entered the word "bluetooth".  =
But, after making those settings, no one can hear anything I'm saying throu=
gh the headset and Twinkle.  Hmmmmm.
_________________________________________________________________
Climb to the top of the charts!=A0Play the word scramble challenge with sta=
r power.
http://club.live.com/star_shuffle.aspx?icid=3Dstarshuffle_wlmailtextlink_jan
-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
