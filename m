Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Fabio Coatti <fabio.coatti@wseurope.com>
In-Reply-To: <200401231125.12823.mtortonesi@ing.unife.it>
References: <200401221042.53134.mtortonesi@ing.unife.it>
	 <200401221221.49241.mtortonesi@ing.unife.it>
	 <1074771503.19046.12.camel@pegasus>
	 <200401231125.12823.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1074864505.3071.112.camel@pegasus>
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
Date: Fri, 23 Jan 2004 14:28:25 +0100

Hi Mauro,

> very interesting. do you think there is a bug in the UHCI code which is 
> related to isochronous traffic type? see this thread:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107238134310638&w=2
> 
> i am asking this because a friend of mine (fabio coatti, included in cc) has a 
> dlink dbt120 usb dongle (hardware revision b2) and if he compiles the 2.6 
> kernel with sco support over hci_usb he gets an oops each time he unplugs the 
> dongle. IIRC, the crash happens only if he has hcid and sdpd running. 

I haven't seen this crash on an OHCI host adapter, but I can't proof
that this is an UHCI problem. The USB guys are informed about that
problem and I hope they find the answer.

> oddly enough, with the same kernel and the same dbt120 usb dongle (although 
> hardware revision b3) i had no such problems on my laptop. i don't know if 
> this depends from the chipsets (i have an intel 815P and he has a brand new 
> intel i875P), but it is sure worth investigating.

Yes, of course. Every help to track this problem is welcome. Please post
bug reports or patches to the USB developer mailing list.

> BTW: marcel & max, can i ask you what tools you use to debug your bluetooth 
> kernel code? printk? kgdb? kdb?

I use the good old printk ;)

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
