Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Palm problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhang <Lan.Zhang@Zoran.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E65CD2CAB74C80498703D6EF7624BB4C4ACAF0@zmaex.zma.zoran.com>
References: <E65CD2CAB74C80498703D6EF7624BB4C4ACAF0@zmaex.zma.zoran.com>
Content-Type: text/plain
Message-Id: <1082159556.4489.3.camel@pegasus>
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
Date: Sat, 17 Apr 2004 01:52:36 +0200

Hi Lan,

> Thanks for your answer before, I bought a new dongle and the problem is
> gone. 
> 
> The problem now is the palm i705, I used BtPrint try to send data to my
> linux box, and of course I set my linux class to printer, the problem
> looks happened in rfcomm level. I used hcidump to catch the stream data,
> and it is been attached. I think it is rfcomm channel problem. Could you
> take several min to look at the file and give me some suggestion? 

the problem is that the Palm don't likes the values that it gets from
its SDP request and it don't even tries to open a RFCOMM channel.

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
