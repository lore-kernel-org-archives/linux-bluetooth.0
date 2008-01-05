Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801050657g399de737ib2ad62e80af31570@mail.gmail.com>
Date: Sat, 5 Jan 2008 07:57:54 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <477F94BC.3040509@gmail.com>
MIME-Version: 1.0
References: <477F94BC.3040509@gmail.com>
Subject: Re: [Bluez-users] Possible insignificant bug in pcm_bluetooth.c
	(bluez-utils)
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

Hi

> As I understood, bt_config->channel_mode and
> bt_config->allocation_method will never be set properly

I changed this in cvs. Send a unified diff next time... it's quicker
to figure out what you've found.

> Further, if it is bug, it is insignificant for now the configuration of
> A2DP (~/.asoundrc) is not fully implemented.
> Found this in above file:
>     /* FIXME: this needs to be really implemented (take into account
> real asoundrc settings + ALSA hw settings ) once server side sends us
>     more than one possible configuration */

yeah I'm not sure what the status is on this piece.

> And something else: I got choppy sound (it chops every 2 sec) when
> listening my A2DP stereo headset Southwing SA505 (BT dongle ASUS WL-BTD-202,
> Ubuntu Gutsy, bluez-3.24). Tried to:
> - change configuration in ~/.asoundrc but unfortunately settings for
> A2DP unimplemented .
> - changed hcid.conf -> lm accept,master and removed lp rswitch. with no use
> Anybody knows what can it be?

the other hcid.conf suggestion is to remove sniff from lp. Do you have
any other bt devices that you use? Is hcitool con only showing the
a2dp connection?

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
