Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Desperate newbie
From: Marcel Holtmann <marcel@holtmann.org>
To: Gary Martin <gary_martin_au@yahoo.com.au>
Cc: Andreas Deresch <aderesch@fs.tum.de>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
References: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1080742767.2536.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 31 Mar 2004 16:19:27 +0200

Hi Gary,

> Thank you for your support Andreas. Problems like this make me
> want to go back to Mac OS X, but there is something about Linux
> that draws me back. It has been a struggle --- I think a lot of
> the problems I have encountered with Linux have been the result of
> trying to run it on a PowerPC chip!!
> 
> I started using Linux because my Masters thesis will be on the use
> of OSS in the public health care system --- I thought I should
> practice what I will preach!

most problems on PowerPC are because this is a big endian platform and
i386 is little endian. The kernel side should be clean of any endian
bugs, but there are maybe some code parts that are never got really
intensiv testing on big endian platforms. So I am of course not 100%
sure. On the other side I think that the userspace part still have some
missing byteswap operations, so try to isolate them and I will try to
fix them as soon as possible.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
