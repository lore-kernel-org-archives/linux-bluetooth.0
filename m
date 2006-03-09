Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <440FE11B.90106@service2media.com>
From: Herman Meerlo <herman@service2media.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sending wap-push via bluetooth to mobile phone
References: <8a995dd50603050455o6a4a39f6s846afb277bf22a9c@mail.gmail.com>
In-Reply-To: <8a995dd50603050455o6a4a39f6s846afb277bf22a9c@mail.gmail.com>
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
Date: Thu, 09 Mar 2006 09:02:35 +0100

Hi Franz,

Franz Pucher wrote:
> Hi,
>
> I am planning a project, where I need to send a wap push link via
> bluetooth to a mobile phone.
> Scenario: Someone walks near a bluetooth server and if his phone has
> blueooth enabled then he receives a link on his mobile phone, that
> links to a wap-url.
>
> Although some people tell me that this is possible, I have not yet
> found information about how to do this technically.
>
> Can anyone inform me if this is possible in general and if this is
> supported by Bluez?
>
> Thanks a lot!
> Franz
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=k&kid0944&bid$1720&dat1642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   
this is possible with OBEX Push. You can send a WML/HTML/XHTML page with 
a link in it to a phone..... but there are not many phones that accept 
these contenttypes over Bluetooth (well, many accept them but can not 
display them). I know that SonyEricsson phones are able to show this, 
but Nokia for example not. That is also one of the major drawbacks of 
OBEX Push; you don't know what the mobile is capable of receiving.....

Regards,
Herman


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
