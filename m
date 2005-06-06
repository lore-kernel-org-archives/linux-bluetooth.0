Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frank Pieczynski <pieczy@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Mouse and sound in parallel
References: <200506051936.38116.pieczy@web.de> <42A3DAD4.7060501@xmission.com>
In-Reply-To: <42A3DAD4.7060501@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506062318.06702.pieczy@web.de>
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
Date: Mon, 6 Jun 2005 23:18:06 +0200

On Monday 06 June 2005 07:10, Brad Midgley wrote:
Brad,
thanks for your tip.

> This may be different from that conversation, but you need to make sure
> your computer is not making a scatternet (master to mouse, slave to
> headset). I believe it can't communicate to both at the same time when
> this happens.
>
> So, in /etc/bluetooth/hcid I have the link mode set:
>
> lm accept,master;
I added the master to my settings and restarted,
but its still the same.

>
> And for my a2dp+sco headset, I cannot have it connected to the computer
> and the phone at the same time or the computer goes into scatternet mode.
I tried only with notebook as single master, no additional devices.

Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
