Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Need for Bluetooth A2DP sink
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42430E8D.9030609@xmission.com>
References: <20050324184727.51038.qmail@web52809.mail.yahoo.com>
	 <42430E8D.9030609@xmission.com>
Content-Type: text/plain
Message-Id: <1111705540.9195.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 25 Mar 2005 00:05:40 +0100

Hi Brad,

> As Marcel pointed out, Henryk's SBC implementation includes decoding.
> 
> Implementing the AVDTP part of the sink would be very much like what 
> we're doing in a2play.c, but it would require some coding. If you're 
> familiar with the spec it could be done in a few days.

for checking out the Toshiba Windows stack, I wrote something that could
be extended to A2DP sink. However I can't find it anymore.

The Toshiba Windows stack also supports the A2DP profile, but only with
their own SR-1 headphone. The details for that can be found at

	http://www.holtmann.org/linux/bluetooth/audio.html

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
