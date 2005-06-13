Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42ADEBE4.9040308@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] python error on bluepin
References: <20050613201611.36779.qmail@web50709.mail.yahoo.com>
In-Reply-To: <20050613201611.36779.qmail@web50709.mail.yahoo.com>
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
Date: Mon, 13 Jun 2005 22:26:12 +0200

If your computer needs a pin for pairing, it gets called.
usually you're in security mode 1, there's no pin required...

hcid.conf holds the mentioned settings.


regards
Marco


John H. wrote:
> ah ok.  it's not getting called no matter what,
> though, what is supposed to call it?  It never pops
> anything up when I tell my phone to search and pair.
> 
> 
> --- Marco Trudel <mtrudel@gmx.ch> wrote:
> 
> 
>>You've to supply the apropriate parameters if you
>>wan't to call it 
>>yourself. It won't work withhout them.
>>It's a pyton script, you can look at the source...
>>
>>regards
>>Marco
>>
>>
>>John H. wrote:
>>
>>>I ran this from X:)
>>>
>>>--- Fredy P <digitalfredy@debiancolombia.org>
>>
>>wrote:
>>
>>>
>>>>El dom, 12-06-2005 a las 19:50 -0700, John H.
>>>>escribió:
>>>>
>>>>
>>>>>bluepin
>>>>>Xlib: connection to ":0.0" refused by server
>>>>>Xlib: No protocol specified
>>>>>
>>>>>Traceback (most recent call last):
>>>>> File "/usr/bin/bluepin", line 39, in ?
>>>>>   import gtk
>>>>> File
>>>>>
>>>>
> "/var/tmp/pygtk2-2.6.2-root/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py",
> 
>>>>>line 37, in ?
>>>>>RuntimeError: could not open display
>>>>
>>>>its becouse your blue_pin needs X, for use without
>>
>>x
>>
>>>>you can made a
>>>>simple pin_helper, you can see it in:
>>>>
>>>
>>>
> http://el-directorio.org/index.php/Bluetooth_en_debian
> 
>>>>In spanish, but if you read the congig files you
>>
>>can
>>
>>>>understand
>>>>
>>>>
>>>>
>>>>__________________________________________________
>>>>
>>>>>Do You Yahoo!?
>>>>>Tired of spam?  Yahoo! Mail has the best spam
>>>>
>>>>protection around 
>>>>
>>>>
>>>>>http://mail.yahoo.com 
>>>>>
>>>>>
>>>>>
>>>>
> -------------------------------------------------------
> 
>>>>>This SF.Net email is sponsored by: NEC IT Guy
>>>>
>>>>Games.  How far can you shotput
>>>>
>>>>
>>>>>a projector? How fast can you ride your desk
>>
>>chair
>>
>>>>down the office luge track?
>>>>
>>>>
>>>>>If you want to score the big prize, get to know
>>>>
>>>>the little guy.  
>>>>
>>>>
>>>>>Play to win an NEC 61" plasma display:
>>>>
>>>>http://www.necitguy.com/?r=20
>>>>
>>>>
>>>>>_______________________________________________
>>>>>Bluez-users mailing list
>>>>>Bluez-users@lists.sourceforge.net
>>>>>
>>>>
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
>>>>
>>>>
> -------------------------------------------------------
> 
>>>>This SF.Net email is sponsored by: NEC IT Guy
>>
>>Games.
>>
>>>>How far can you shotput
>>>>a projector? How fast can you ride your desk chair
>>>>down the office luge track?
>>>>If you want to score the big prize, get to know
>>
>>the
>>
>>>>little guy.
>>>>Play to win an NEC 61" plasma display:
>>>>http://www.necitguy.com/?r 
>>>>_______________________________________________
>>>>Bluez-users mailing list
>>>>Bluez-users@lists.sourceforge.net
>>>>
>>>
>>>
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
>>>
>>>
>>>
>>>		
>>>__________________________________ 
>>>Discover Yahoo! 
>>>Have fun online with music videos, cool games, IM
>>
>>and more. Check it out! 
>>
>>>http://discover.yahoo.com/online.html
>>>
>>>
>>>
>>
> -------------------------------------------------------
> 
>>>This SF.Net email is sponsored by: NEC IT Guy
>>
>>Games.  How far can you shotput
>>
>>>a projector? How fast can you ride your desk chair
>>
>>down the office luge track?
>>
>>>If you want to score the big prize, get to know
>>
>>the little guy.  
>>
>>>Play to win an NEC 61" plasma display:
>>
>>http://www.necitguy.com/?r=20
>>
>>>_______________________________________________
>>>Bluez-users mailing list
>>>Bluez-users@lists.sourceforge.net
>>>
>>
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
>>>
>>
>>
>>
> -------------------------------------------------------
> 
>>This SF.Net email is sponsored by: NEC IT Guy Games.
>> How far can you shotput
>>a projector? How fast can you ride your desk chair
>>down the office luge track?
>>If you want to score the big prize, get to know the
>>little guy.  
>>Play to win an NEC 61" plasma display:
>>http://www.necitguy.com/?r=20
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>
> 
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Read only the mail you want - Yahoo! Mail SpamGuard. 
> http://promotions.yahoo.com/new_mail 
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
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
