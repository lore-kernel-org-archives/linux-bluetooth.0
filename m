Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BLueZ Questions
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42380154.3080005@carmedialab.de>
References: <4237F516.2040804@carmedialab.de>
	 <1110965751.9818.87.camel@pegasus>  <42380154.3080005@carmedialab.de>
Content-Type: text/plain
Message-Id: <1110967438.9818.110.camel@pegasus>
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
Date: Wed, 16 Mar 2005 11:03:58 +0100

Hi Marcus,

> > if the protocol is implemented you can easily have an application
> > running that provides the profile function.
> > 
> > This is not general, but if you ask what profiles you have in mind, I
> > can give you a more detailed answer.
> 
> Just shortly descibing our hardware: Embedded Box using an AC45 GSM/GPRS 
> Modem (serial  connection) , GPS Samsung modul (serial connection), 
> BT-Infioneon singlestone Bluemoon (serial connection).

make sure that you adding my latest -mh patch for that kernel.

> Profiles looking for:
> Serial Profile (through rfcomm ?)

To what should this be connected? The GPS or the GSM/GPRS unit?

> Handsfree (for using a external mobile phone)

Are the SCO audio data sent over the PCM interface of the chip?

> SAP (would be nice, cause AC45 supports SAP)

Nobody has written anything like this, because the hardware for testing
is missing. However this works like PDUs over a RFCOMM socket and should
be quite simple.

> Network(through PAN?)

You can use pand for it.

> Fileexchange (through openobex)

Depending on what you wanna do you may need do write some extra code,
but there are a lot of examples.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
