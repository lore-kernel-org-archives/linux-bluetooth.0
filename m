Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM communication gets stalled
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: lista bluez <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002c01c46a77$034a25e0$5000005a@naxus>
References: <002c01c46a77$034a25e0$5000005a@naxus>
Content-Type: text/plain
Message-Id: <1089913722.4517.37.camel@pegasus>
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
Date: Thu, 15 Jul 2004 19:48:42 +0200

Hi Carlos,

> I'm using bluez-libs-2.7 and bluez-utils-2.7 to develop a GPS system
> that communicates via bluetooth. I use the RFCOMM and the connection
> and disconnection works fine but the transmission gets stalled in
> about ten minutes. Both sides indicate that they are still connected,
> but in the GPS side, the process that writes in the rfcomm device
> (/dev/bluetooth/rfcomm/0) stops on a blocking write call:
>  
>     write(fdbluetooth,s,strlen(s));
>  
> I open the rfcomm device this way:
>  
>     fdbluetooth= open("/dev/bluetooth/rfcomm/0",O_RDWR | O_NOCTTY);
>  
>  
> That write call works fine for a while until the communication gets
> stalled.

don't use the RFCOMM TTY terminal emulation. Go directly throught the
RFCOMM socket interface. If you still got problems check with hcidump
what is going on.

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
