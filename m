Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Rfcomm problem
From: Marcel Holtmann <marcel@holtmann.org>
To: amine@baracoda.com
Cc: Halam Rose <halam.rose@7layers-uk.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <33083.82.127.5.232.1081511369.squirrel@baracoda.com>
References: <C1B29E01A9B748458D51DBBE04E4B9EA2E5628@7layers.7layers-uk.com>
	 <33083.82.127.5.232.1081511369.squirrel@baracoda.com>
Content-Type: text/plain
Message-Id: <1081512358.13202.1.camel@pegasus>
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
Date: Fri, 09 Apr 2004 14:05:59 +0200

Hi,

> I have a problem with rfcomm connection.
> when i try to connect my bluetooth interface using rfcomm it working but i
> have this message:
> 
> &Can't open RFCOMM device: No such file or directory
> 
> and when i connect the interface on second time, i have this message:
> 
> &Can't connect RFCOMM socket: Connection timed out

what kernel are you using? Are you using udev? Is the /dev/rfcommX
device node present? What version of the bluez-utils are installed?

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
