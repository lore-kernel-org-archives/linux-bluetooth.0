Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <423811DA.10403@carmedialab.de>
From: Marcus Mikolaiczyk <marcus.mikolaiczyk@carmedialab.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BLueZ Questions
References: <4237F516.2040804@carmedialab.de>	 <1110965751.9818.87.camel@pegasus>  <42380154.3080005@carmedialab.de> <1110967438.9818.110.camel@pegasus>
In-Reply-To: <1110967438.9818.110.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 16 Mar 2005 12:00:42 +0100

Hi Marcel,


> make sure that you adding my latest -mh patch for that kernel.
for Kernel 2.4.19 I do (patch-2.4.19-mh18).
> 
>>Profiles looking for:
>>Serial Profile (through rfcomm ?)
> 
> 
> To what should this be connected? The GPS or the GSM/GPRS unit?
What ever is possible.
-GPS for using a PDA(bt) to get positioning informations to spare a 
separate GPS Module.
-A terminal to connect to from a PC
-Maybe using GSM/GPRS as Dial up connection.
> 
>>Handsfree (for using a external mobile phone)
> 
> 
> Are the SCO audio data sent over the PCM interface of the chip?
In the first Hardware release there's no Audio codec but ther will be 
one in the second. I'm not sure how it will be implemented. In the 
moment the PCM interface is connected to a synchronus serial interface 
on the tc1130. I'll think we got to diskuss this internally more deeply 
to clarify the needs and usage.
> 
>>Fileexchange (through openobex)
> 
> 
> Depending on what you wanna do you may need do write some extra code,
> but there are a lot of examples. 
I thought it's done through the openobex package. I suppose I can find 
example on the openobex project site.

Bye Marcus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
