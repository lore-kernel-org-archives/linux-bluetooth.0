Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re:how to transmit hexadecimal data and voice?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050718075432.27262.qmail@web15702.mail.cnb.yahoo.com>
References: <20050718075432.27262.qmail@web15702.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1121673800.22662.56.camel@pegasus>
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
Date: Mon, 18 Jul 2005 10:03:20 +0200

Hi,

> Thanks Marcel for your reply! And I have solved the
> first problem,I created a rfcomm connection,and sent
> data sucessfully! Thanks again!
> 
> However,I am still puzzled with then second
> problem.What I did is as follows:
> on platform A: 
> $ rfcomm listen 0 1
> Waiting for connection on channel 1
> 
> on platform B: 
> $ hsmicro 4A:49:4E:00:15:2F 1
> -t: No such file or directory
> Voice setting: 0x0060
> RFCOMM channel connected
> SCO audio channel connected (handle 44, mtu 64)

you can't listen only for a RFCOMM channel. You must also listen for a
SCO connection. Why don't you test with scotest as I told you last time.

> Then ,I inserted a microphone into the MC145483 Codec
> on platform B and spoken,but on platform A there was
> no response from the Code's speaker! 
> Please correct me if i"m wrong. Do I need to add some
> services such as HS,HF,A2SRC and A2SNK?

This depends on the tools. Most Linux tools will also work without any
service records if you specify the right command line parameters.

> Or maybe there is something wrong on the connection
> between Bluetooth module's PCM interface and the
> Motoral MC145483 Codec?

This can be, but how should I know?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
