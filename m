Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42519CD7.1030606@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco - headset profile activated but no sco packets
 transmitted ???
References: <20050404194542.GA7640@lsweb.de>
In-Reply-To: <20050404194542.GA7640@lsweb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 04 Apr 2005 14:00:23 -0600

Lars

I hate to say it but it looks like you're doing everything right, the 
adapter seems to be good, etc.

I haven't heard success stories for using the bt110 but I can't remember 
if we've had trouble reports on this one or not.

> root@sigma:~/src/btsco# ./btsco -v 00:07:A4:95:41:76 2

The only thing I would suggest is that you don't specify the channel 
here, but I suspect btsco will autodetect channel 2 anyway.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
