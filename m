Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419784ED.8080800@dark-reality.de>
References: <20041110041405.3CC331D4758@sc8-sf-uberspam1.sourceforge.net>
	 <003101c4ca02$b9f20d90$6f04a8c0@ZBOX> <1100446527.21403.23.camel@pegasus>
	 <419784ED.8080800@dark-reality.de>
Content-Type: text/plain
Message-Id: <1100450097.21403.53.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Nov 2004 17:34:57 +0100

Hi Lars,

> | The ioctl() way is a no go. You have everything you must know inside the
> | kernel. You know the number of SCO connections and the voice setting and
> | the driver must be able to deal with this by itself.
> 
> Question is, how can we handle the endpoint selection when we can't use
> usb_set_interface() in the notify function? Or to be more precisly, when.
> 
> Next question is what happens to not-yet-send packages, I think we must
> empty all queues before we can use usb_set_interface.

you must stop the current ISOC URBs and then change the alternate
setting and then submit them again. Even more you shouldn't started them
in the open routine. Only start them when a SCO link is created.

> What function in the kernel driver would you use to add this? maybe the
> send functions? We could set a flag "change endpoint to..." in notify
> and apply the change when queues are empty - and reject/hold new send
> urbs until we were able to change the endpoint setting.

I don't think that this will more, because you are in the wrong context
too. However check with in_interrupt() and do this always on a SMP and
preempt enabled kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
