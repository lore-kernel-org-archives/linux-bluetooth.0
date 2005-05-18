Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <428AEE59.9070409@whitelabel.org>
From: Stefan Magdalinski <stefan@whitelabel.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3COM PCMCIA Bluetooth question
References: <B7A120329D087840A54E2A221FCCE8D074732D@PSCMAIL01.rochester.itsphoenix.com>
In-Reply-To: <B7A120329D087840A54E2A221FCCE8D074732D@PSCMAIL01.rochester.itsphoenix.com>
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
Date: Wed, 18 May 2005 08:27:21 +0100

John G. Moose wrote:
> Hi Marcel,
>  
> When I do the "hciattach ttyS3 3com" the response is "Initialization 
> timed out". I ran the timeout period up to 20 seconds in 5 second incs 
> and same result.
>  
> BTW - I very much appreciate your help with this!

typo?

try "hciattach ttyS03 3com"

>  
> John
> 
>  >
>  > Yes, I see two new tty devices:
>  > 
>  > ttyS03  at  port  0xF6000000  (irq = 153)  is  a  16C950/954
>  > ttyS04  at  port  0xF6000008  (irq = 153)  is  a  8250
> 
> then use "hciattach ttyS3 3com".
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click 
> <http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


-- 
/*
Stefan Magdalinski
+447769 666528 (telephone)
smagdali (IM/flickr.com/etc)
*/


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
