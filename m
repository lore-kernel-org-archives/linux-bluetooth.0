Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with service level security (2.6.10-mh1)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200501030040.48387.bluez-devel@schaettgen.de>
References: <200501030040.48387.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1104713308.8894.39.camel@pegasus>
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
Date: Mon, 03 Jan 2005 01:48:28 +0100

Hi Fred,

> I've got some problems with enabling service level security for rfcomm.
> First I was hoping that this is in 2.6.10, but obvisously it isn't.
> Btw. rctest doesn't work with a vanilla kernel, because setsockopt() is called 
> (and fails), no matter if it's necessary or not. 
> 
> So after applying the mh1-patch for 2.6.10, the result looks like this:
> 
> $ ./rctest -d -P 27 -A
> rctest[12830]: Waiting for connection on channel 27 ...
> rctest[12831]: Connect from 00:E0:03:32:28:37
> rctest[12831]: Receiving ...
> rctest[12831]: Recevied 4 bytes
> (nothing more to expect at this point..)
> rctest[12831]: Disconnect
> $
> 
> No authentication is triggered, even though the two devices are not paired.
> rctest seems to recognize the A-switch nicely. setsockopt is called and 
> doesn't fail.
> Is service level security supposed to work at the moment with 2.6.10-mh1?

it is removed from 2.6.10-mh1, because of a schedule problem.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
