Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-devel] RFCOMM problemms
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat@poczta.onet.pl
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040412081545Z4895221-32087+441336@kps6.test.onet.pl>
References: <20040412081545Z4895221-32087+441336@kps6.test.onet.pl>
Content-Type: text/plain
Message-Id: <1081778046.5398.127.camel@pegasus>
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
Date: Mon, 12 Apr 2004 15:54:06 +0200

Hi Maciej,

> Marcel I told you that I red couple times the specification and I used
> hcidump to see how BlueZ treats RFCOMM connection but when I'm doing the
> same as BlueZ it doesn't want to work. I want only answer if BlueZ makes sth
> else not shown by hcidump like sending some 0x00 bytes or setting some
> parameters?

hcidump shows you the raw communication on the HCI level. This is open
source we don't need to hide any special parameters.

> I'm doing the same as BlueZ that why I don't understand this behaviour of my
> devices.

I you do so, it would work. Actually you better try to understand your
own stuff, because in every communication between two Bluetooth devices
there are variable parameters (for example ACL handle and L2CAP cid).

Read the specification and understand what you have to do. If you unsure
at some point look at the output of hcidump and see how BlueZ does it.

> This is the only thing that I want to know and this is BlueZ related
> question but your answer I will use to solve my problem!

No. You don't ask this question. You posted the same stupid question
again and again and nobody is going to answer it. Stop it, because you
will waste our time.

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
