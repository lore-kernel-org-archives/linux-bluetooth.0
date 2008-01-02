Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801012103l48e26e3ax379e391055e31e72@mail.gmail.com>
Date: Tue, 1 Jan 2008 22:03:16 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200801012109.19744.lists@spudulike.me.uk>
MIME-Version: 1.0
References: <200801012109.19744.lists@spudulike.me.uk>
Subject: Re: [Bluez-users] Stereo audio headset - half a second of audio,
	8 seconds of silence, then disconnection.
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

Colin

> On hitting the 'play' button there is a 2 second delay before XMMS begins to
> play, and the Graphic EQ bars start to dance.  Half a second, or so, of audio
> can be heard from the headphones, after which they go silent

this could be the scatternet problem we've been working over.

what does
 hcitool con
show during the audio playing?

what other bluetooth devices are you using?
is the headset trying to connect to a phone at the same time?
do you know which bluetooth adapter your pc uses?

if you have "master" in hcid.conf's lm setting and you take "rswitch"
out of the lp setting, you are making the pc prefer to be master and
to hopefully behave better.

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
