Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Service registering but not visible
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Stoddart <d.stoddart@cs.ucl.ac.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer>
References: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer>
Content-Type: text/plain
Message-Id: <1090012501.9117.29.camel@pegasus>
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
Date: Fri, 16 Jul 2004 23:15:01 +0200

Hi Daniel,

> When i add a service using the command
>  
> root@darkstar:~# sdptool add --channel=13 OPUSH
> 
> OBEX Object Push service registered
> 
> And then using my Nokia 6600, search for available services no
> services are shown.

check with "sdptool browse local" if the service record is really
present.

Run "hcidump -x" as root to see for what services your phone is
searching and try to set the correct class of device bits.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
