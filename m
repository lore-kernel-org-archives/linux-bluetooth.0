Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42490CD5.2000505@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] getting bluetooth v1.2, success report
References: <1112015700.9016.30.camel@pegasus>	 <20242.1112026706@www42.gmx.net>  <1112030513.9016.40.camel@pegasus>	 <1112031386.30560.6.camel@lynx.auton.cs.cmu.edu> <1112032100.9016.42.camel@pegasus>
In-Reply-To: <1112032100.9016.42.camel@pegasus>
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
Date: Tue, 29 Mar 2005 10:07:49 +0200

Hello

I downloaded the Bluetooth Firmware Updater from apple, putted my dongle 
into the apple and run the updater. everything went perfectly fine...
i now have Build 1586 (HCI 18.2) and Bluetooth 1.2... nice!

If someone has no mac operating system and is interested in the 
GenericCSR.dfu, I can email it.

My last questions (hopefully) regarding this topic now are:
- What is dangerous about updating the dongle?
the procedure itself? only the linux btdfu tool (secure with mac)?

- Widcomm delivers update-software too, will/should this work too with the 
GenericCSR.dfu?

- I now have to run hid2hci every time after I plug the dongle in (thanks 
for the info marcel). What is this exactly doing, why is it necessary?

- doing hid2hci I get:
Switching device 0a12:1000 to HCI mode failed (Invalid or incomplete 
multibyte or wide character)
but everything's fine after that. is this a problem? why the error?


Thanks for all your hints and help!

regards
Marco


Marcel Holtmann wrote:
> Hi Adam,
> 
> 
>>Yes, the "if you are lucky" part is very important. The one-line patch
>>may look simple, but it took a LONG time of experimenting to figure it
>>out!
> 
> 
> you can also make your dongle unusable when you try the wrong firmware
> or if the btdfu aborts at the wrong time, because of a timeout.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 

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
