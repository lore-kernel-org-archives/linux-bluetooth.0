Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42AA5C31.2040009@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing plantronics M3000 with my laptop
References: <42AA0EED.9060104@lesagepono.be>
In-Reply-To: <42AA0EED.9060104@lesagepono.be>
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
Date: Fri, 10 Jun 2005 21:36:17 -0600

I would try removing /etc/bluetooth/link_key so the pairing will be reset.

Laurent Lesage wrote:
> info. "bluez-pin" asked me for the pin (0000) and got the info. After 
> that, I used the headset under windows XP, with skype : it worked great 
> as headset : clear sound, mic OK. Then back to Linux, and no way to get 
> 'hcitool info' again.
> 
> laptop:/etc/bluetooth# hcitool cc 00:03:89:4C:2D:C7
> Can't create connection: Input/output error
> 
> I tried in pairing mode but always the same error. this is hcidump 
> during "info", headset  in pairing mode or not


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
