Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] modify RFCOMM_DISC_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: lista bluez <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000a01c46ff6$f6013a10$5000005a@naxus>
References: <000a01c46ff6$f6013a10$5000005a@naxus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1090517537.21828.26.camel@pegasus>
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
Date: Thu, 22 Jul 2004 19:32:18 +0200

Hi Carlos,

> I am developing a GPS unit that communicates via RFCOMM and I noticed
> that the timeout of the RFCOMM disconnection is 20 seconds.
> =BFDoes exists a way to change this timeout from a rfcomm server progra=
m
> that uses sockets?
> It seems that changing this #define in the rfcomm.h is not enough

what do you expect that RFCOMM_DISC_TIMEOUT is doing?

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
