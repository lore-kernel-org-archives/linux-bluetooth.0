Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411250131.50765.adq_dvb@lidskialf.net>
References: <200411241854.13007.adq_dvb@lidskialf.net>
	 <1101325813.7538.6.camel@pegasus>
	 <200411250131.50765.adq_dvb@lidskialf.net>
Content-Type: text/plain
Message-Id: <1101350516.7538.15.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 25 Nov 2004 03:41:56 +0100

Hi Andrew,

> OK: my next question is about the "Bluetooth serial port" on the phone. When I 
> connect to it with:
> 
> rfcomm connect 0 00:60:57:7C:31:49 2
> 
> It connects, but then the phone immediately disconnects. A short time later,  
> the phone connects back to my computer on seemingly the service with the 
> highest channel id - in my case kbemusedsrv (from kdebluetooth - an XMMS 
> control service for the phone).
> 
> kbemused handily has a raw data dump option, and I can see the phone sending 
> what are obviously PPP LCP packets at it.
> 
> How do I get the phone to connect to something sensible - e.g. to dund. I 
> found various sets of instructions on the web, but the damn thing keeps 
> connecting to kbedmused. 
> 
> Is this connect-disconnect-reconnect behaviour normal?

welcome to the world of this mRouter crap. You can try the latest dund
from bluez-utils-2.11 package. I added some support for mRouter, but I
am not sure if it is really working.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
