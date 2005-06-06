Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42A4C773.7020200@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Mouse and sound in parallel
References: <200506051936.38116.pieczy@web.de> <42A3DAD4.7060501@xmission.com> <200506062318.06702.pieczy@web.de>
In-Reply-To: <200506062318.06702.pieczy@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 06 Jun 2005 16:00:19 -0600

Frank,

I couldn't find it, but I think that other discussion was about the link 
policy. My link policy is:

  lp rswitch,hold,sniff,park;

what do you have?

Brad

Frank Pieczynski wrote:
> On Monday 06 June 2005 07:10, Brad Midgley wrote:
> Brad,
> thanks for your tip.
> 
> 
>>This may be different from that conversation, but you need to make sure
>>your computer is not making a scatternet (master to mouse, slave to
>>headset). I believe it can't communicate to both at the same time when
>>this happens.
>>
>>So, in /etc/bluetooth/hcid I have the link mode set:
>>
>>lm accept,master;
> 
> I added the master to my settings and restarted,
> but its still the same.
> 
> 
>>And for my a2dp+sco headset, I cannot have it connected to the computer
>>and the phone at the same time or the computer goes into scatternet mode.
> 
> I tried only with notebook as single master, no additional devices.
> 
> Frank
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> a projector? How fast can you ride your desk chair down the office luge track?
> If you want to score the big prize, get to know the little guy.  
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
