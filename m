Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4402B812.40204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A2DP alsa no sound
References: <43FDE154.7050803@cs.bgu.ac.il> <43FDFC4E.8040104@xmission.com> <4400F1DE.5070804@cs.bgu.ac.il>
In-Reply-To: <4400F1DE.5070804@cs.bgu.ac.il>
Content-Type: text/plain; charset=UTF-8
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Feb 2006 01:28:02 -0700

Niv

> I am attaching the whole diff between the mpg123 pipe to a2play that
> works and the dump from xmms that doesnt.
> also attaching the xmms output (23M open)

> 11c11
> <     L2CAP(s): Connect req: psm 1 scid 0x0040
> ---
> 
>>    L2CAP(s): Connect req: psm 25 scid 0x0040

I haven't been able to dig in but something looks wrong already... isn't
the correct code going to connect on psm 25 first for the commands and
then on the detected psm (usually 1) later for the stream? Yet from what
you've sent it looks like the working version connects to psm 1 first?

If I read your diff wrong, then maybe it's just that the plugin
incorrectly tries to go right to streaming without setting it up
properly using the l2cap connection on psm 25.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
