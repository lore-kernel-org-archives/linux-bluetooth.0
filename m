Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm receive problem and success
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7407.1080119240@www16.gmx.net>
References: <7407.1080119240@www16.gmx.net>
Content-Type: text/plain
Message-Id: <1080129568.2515.100.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 24 Mar 2004 12:59:28 +0100

Hi Franz,

> with your help i had quite a success in sending data from my mobile phone to
> bluez.
> but there's something i don't understand.
> i registered a SP service: sdptool add --channel=10 SP
> 
> ./rctest -d
> rctest[2482]: Waiting for connection on channel 10 ...
> rctest[2483]: Connect from 00:00:00:00:00:00
> rctest[2483]: Receiving ...
> rctest[2483]: Recevied 51 bytes
> rctest[2483]: Disconnect
> 
> and the programm doesn't exit, i have to use ctr-c to stop it. is this
> normal or is something going wrong although  the receiving was successful?

this is normal, because you can connect another time.

> and something else: 
> if i try to receive with the 'r' option there's an error:
> 
> ./rctest -r
> rctest[2458]: Waiting for connection on channel 10 ...
> rctest[2459]: Connect from 00:00:00:00:00:00
> rctest[2459]: Receiving ...
> rctest[2459]: Read failed. Connection reset by peer(104)
> rctest[2459]: Disconnect
> 
> has anybody an idea what's my fault?

You received data (one UIH frame) and then the phone disconnects you.
Actually they are the same 51 bytes as above, but you only see an extra
error message.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
