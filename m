Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42AB720D.20806@lesagepono.be>
From: Laurent Lesage <laurent@lesagepono.be>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pairing plantronics M3000 with my laptop
References: <42AA0EED.9060104@lesagepono.be> <42AA5C31.2040009@xmission.com>
In-Reply-To: <42AA5C31.2040009@xmission.com>
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
Date: Sat, 11 Jun 2005 23:21:49 +0000

Thanks : that works!

> Brad Midgley a =E9crit : I would try removing /etc/bluetooth/link_key s=
o=20
> the pairing will be reset.
>
> Laurent Lesage wrote:
>
>> info. "bluez-pin" asked me for the pin (0000) and got the info. After=20
>> that, I used the headset under windows XP, with skype : it worked=20
>> great as headset : clear sound, mic OK. Then back to Linux, and no=20
>> way to get 'hcitool info' again.
>>
>> laptop:/etc/bluetooth# hcitool cc 00:03:89:4C:2D:C7
>> Can't create connection: Input/output error
>>
>> I tried in pairing mode but always the same error. this is hcidump=20
>> during "info", headset  in pairing mode or not
>
>


Now, I tried the commands in "hcitool" to create connection and get=20
parameters for the link and the headset. My question : is there a link=20
where you can find more explanation about the result of the commands=20
(what do the values of rssi, lq -link quality-, ... mean? I see the=20
values changing on my screen when I move the headset but I don't know=20
their meaning)

Another question : does the class of the device (you define in=20
/etc/bluetooth/hcid.conf) mean exactly? Does it mean that the dongle is=20
not able to use other device that the one you define with that value or=20
does it mean you *don't want* to use other devices than the ones you=20
define with that value?

thanks for your attention

Laurent Lesage





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
