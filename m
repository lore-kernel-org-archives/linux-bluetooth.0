Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42250ABB.2020501@cloutier-vilhuber.net>
From: Lars Vilhuber <lists.all@cloutier-vilhuber.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: Report of working dongle: IOGear GBU311 and question
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
Date: Tue, 01 Mar 2005 19:37:15 -0500

> Message: 12
> Date: Tue, 01 Mar 2005 10:06:42 -0500
> From: "Fredy P." <digitalfredy@debiancolombia.org>
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Report of working dongle: IOGear GBU311 and 
> 	question
> Reply-To: bluez-users@lists.sourceforge.net
> 
> Lars Vilhuber escribi=F3:
>>> I can happily report that my new IOGear GBU311 works under stock SuSE=20
>>> 9.2 (connections tested with Palm T3 and Sony-Ericsson T610, using=20
>>> OBEX-FTP, OBEX-transfer, DUN).
>>>=20
> can you send me your config files?
> I have a t610 and using obexftp only can send files from the pc, i can't =
> get files from the movil  :( 

I should note that I am using the KDE tools to do all of this - don't 
know about command line tools (if that is what you are implying with 
'obexftp').

Here's /etc/bluetooth/hcid.conf:

options {
         autoinit yes;

         security auto;

         pairing multi;

         pin_helper /bin/bluepincat;

}
device {
         name "SOMETHING";

         class 0x14010c;


         iscan enable;
         pscan enable;

         lm accept;

         lp rswitch,hold,sniff,park;

         encrypt disable;
         auth enable;
}




-- 
Lars Vilhuber                    lists.all@cloutier-vilhuber.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
