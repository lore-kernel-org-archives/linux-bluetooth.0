Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421042D2.2040905@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] position of multiple bluetooth dongles
References: <420B9635.6020701@gmx.ch>  <200502101825.15870.cijoml@volny.cz> <1108057316.15974.93.camel@pegasus>
In-Reply-To: <1108057316.15974.93.camel@pegasus>
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
Date: Mon, 14 Feb 2005 07:18:58 +0100

Hello Marcel

so it's no problem? no mather of the bluetooth version of the dongle? no 
interference, respectively maybe a couple if thousands in a second?
corrected by rfcomm? the distance of two dongles doesn't matter?

regards
Marco


Marcel Holtmann wrote:
> Hi Michal,
> 
> 
>>BT 1.1 dongles may interference...
>>BT 1.2 only when comunication with 1.1 devices - 1.2 devices can never 
>>interference
> 
> 
> let me correct this. AFH is not for detecting used frequencies of other
> Bluetooth piconets. It only detects other wireless technologies, because
> for itself it is already protected by the hopping sequence itself. If it
> is the same hopping sequence it is the same piconet and thus it really
> wants to listen to its traffic.
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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
