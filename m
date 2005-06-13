Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42ACD3A7.1010809@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing plantronics M3000 with my laptop SOLVED
 (bis)
References: <42AA0EED.9060104@lesagepono.be> <42AA5C31.2040009@xmission.com> <42AB720D.20806@lesagepono.be> <42AC42C1.7050903@lesagepono.be> <42ACAE93.3050200@xmission.com>
In-Reply-To: <42ACAE93.3050200@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 13 Jun 2005 00:30:31 +0000

Well, just to add that sometime, the sound disappear when using skype or=20
IAX client. I must stop the call and redo it to get the sound back.=20
Maybe another application picked up the route? (grip and XMMS where=20
present at the same time).

Brad Midgley a =E9crit :

> Hi
>
> I suspect a volume problem (try using a soft mixer on your computer=20
> and try volume controls on the headset)
>
> or sco routing; as root run
>  hciconfig hci0 revision
> and see if sco is routed to hci as it should be
>
> It's possible that Marcel's new pskey program can reroute sco but I=20
> haven't tried that.
>
> Brad




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
