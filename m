Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42492C79.700@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] getting bluetooth v1.2, success report
References: <1112015700.9016.30.camel@pegasus> <1112032100.9016.42.camel@pegasus> <42490CD5.2000505@gmx.ch> <200503291156.57781.cijoml@volny.cz>
In-Reply-To: <200503291156.57781.cijoml@volny.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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
Date: Tue, 29 Mar 2005 12:22:49 +0200



Michal Semler wrote:
> Dne út 29. bøezna 2005 10:07 Marco Trudel napsal(a):
> 
>>Hello
>>
>>I downloaded the Bluetooth Firmware Updater from apple, putted my dongle
>>into the apple and run the updater. everything went perfectly fine...
>>i now have Build 1586 (HCI 18.2) and Bluetooth 1.2... nice!
>>
> Download it from dongle via btdfu - then it should have right timing.

I have no idea what you mean with this...


>>If someone has no mac operating system and is interested in the
>>GenericCSR.dfu, I can email it.
> 
> We all have it :)

no. not everyone has it.
maybe you already have it...


>>My last questions (hopefully) regarding this topic now are:
>>- What is dangerous about updating the dongle?
>>the procedure itself? only the linux btdfu tool (secure with mac)?
> 
> you can destroy it, but now are all dongles very cheap

So the procedure itself is dangerous...


>>- Widcomm delivers update-software too, will/should this work too with the
>>GenericCSR.dfu?
> 
> We know nothing about this software - it should be better then Marcel's btdfu, 
> coz they have specifications


>>- I now have to run hid2hci every time after I plug the dongle in (thanks
>>for the info marcel). What is this exactly doing, why is it necessary?
> 
> yes, it is

I know that it is, I wrote that.
My question was why it is necessary and what it's doing...


>>- doing hid2hci I get:
>>Switching device 0a12:1000 to HCI mode failed (Invalid or incomplete
>>multibyte or wide character)
>>but everything's fine after that. is this a problem? why the error?
> 
> error somewhere in usb subsystem - contact usb guys

regards
Marco

Content Security by MailMarshal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
