Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sockfd_lookup missing from older kernel patches
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200501102004.11028.bluez-devel@cpinkney.org.uk>
References: <200501102004.11028.bluez-devel@cpinkney.org.uk>
Content-Type: text/plain
Message-Id: <1105401255.8056.3.camel@pegasus>
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
Date: Tue, 11 Jan 2005 00:54:15 +0100

Hi Colin,

> I was updating a BlueZ package for the Sharp Zaurus PDAs that use the 2.4.18 
> kernel. The previous package had been using BlueZ libs and utils v2.3 and 
> patch 2.4.18-mh8 and had been working ok.
> 
> With the latest userspace source and patch 2.4.18-mh15 I noticed the function 
> sockfd_lookup had been removed from the sock.c files. This caused a 
> unresolved symbol error upon loading the bnep module on the Zaurus.
> 
> I noticed in the comments on http://www.holtmann.org/linux/kernel/ that 
> sockfd_lookup was removed on Dec 15, 2003 from kernel patches for kernels 
> 2.4.22 and later. I presume this function has been moved into more central 
> kernel code? Was this function supposed to be removed from the patches for 
> kernels 2.4.21 and earlier (or at least kernel 2.4.18)?

all -mh patches for 2.4 should deal correctly with an exported or non
exported sockfd_lookup(). I tested that a long time ago. However if you
got problems with then simply export that function from the socket core.

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
