Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <425F3FE5.5070404@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP BC02 UART
References: <20050415035841.69304.qmail@web40721.mail.yahoo.com>
In-Reply-To: <20050415035841.69304.qmail@web40721.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 14 Apr 2005 22:15:33 -0600

KrAnTi

>  I am new to this mailing list, not sure if anyone
> else posted this. Will A2DP work with CSR BC02
> connected to a host controller with a UART? 

yes

> the recomended baud rate?

921kbps if you can do it.

> mechanism on the host? Any sample code? Which
> processor is used with BC02 to verify this?

we do have sample code. build and run a2play from the 
bluetooth-alsa.sf.net cvs.

so far it has only been done with desktop cpus. i am interested in 
trying it myself with a pxa255, but i am concerned about all of the 
double-precision floating point ops in the current implementation.

it could and should be converted to integer ops.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
