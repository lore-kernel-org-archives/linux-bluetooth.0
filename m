Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422D78C3.9090002@ul.ie>
From: Joe Sloan <joe.sloan@ul.ie>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connecting To GPRS net in Fedocra Core 3
References: <20050308080943.21418.qmail@webmail49.rediffmail.com>
In-Reply-To: <20050308080943.21418.qmail@webmail49.rediffmail.com>
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
Date: Tue, 08 Mar 2005 10:04:51 +0000

Hi Adil,

I guess you need to add a (default) route to use that interface.

route add .....

Joe

adil fulara wrote:

>  
>
>
> hello,
>
> I have succesfully established a connection on my fedocra core 3 via 
> bluetooth using my SE p910i fone. when i typed "ipconfig" i saw that 
> the ppp0 connection. my problem is i am not able to use it. Firefox 
> doesnt sense this ppp0 connection. can any1 tell me what to do to tell 
> my browser that ppp0 exists and to use it....
>
>
> adil
>
>
>
> <http://clients.rediff.com/signature/track_sig.asp> 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
