Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] modify RFCOMM_DISC_TIMEOUT
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003b01c47095$488aa3e0$5000005a@naxus>
References: <000a01c46ff6$f6013a10$5000005a@naxus>
	 <1090517537.21828.26.camel@pegasus>  <003b01c47095$488aa3e0$5000005a@naxus>
Content-Type: text/plain
Message-Id: <1090575554.4791.5.camel@pegasus>
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
Date: Fri, 23 Jul 2004 11:39:14 +0200

Hi Carlos,

> I run a rfcomm server built on top of bluez using sockets, the client runs a
> different bluetooth protocol implementation that is very buggy and sometimes
> stops the rfcomm comunication without sending a DISC. So the rfcomm server
> waits for 20 seconds (RFCOMM_DISC_TIMEOUT) and then closes the connections
> and become available again. The sending loop of the server is:
> 
> //using sockets
> //send until write returns -1
>  while(n>=0)
>  {
>     n=write(client,s,strlen(s));
>     sleep(1);
>  }
> //go to listen again
> 
> 
> If the client simply stops the communication, not disconnect, the server
> must be available as soon as possible. 20 seconds it's too long for our
> application.

what you want is an idle timeout detection. The RFCOMM_DISC_TIMEOUT is
not meant for doing this. Show us the output of "hcidump -x -t" while
this happens.

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
