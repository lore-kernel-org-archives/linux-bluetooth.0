Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm simultaneous connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80511120733m222f37b0u580167f357e3b282@mail.gmail.com>
References: <45bf5ff80511120733m222f37b0u580167f357e3b282@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131811109.29461.24.camel@blade>
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
Date: Sat, 12 Nov 2005 16:58:29 +0100

Hi Artur,

no cross-posting. I mentioned that many times now.

> Can someone please confirm me that i have the correct understanding of
> the following:
>  
>  
> Im trying to send a file over obex to device 1 a bt phone. He receives
> the prompt to accept the file and i dont answer.
> If i try to send another file to device 2 anoter btphone, bluez says
> no resources, but  if i accept the file in device 1 and start to
> download it i can then prompt the device 2 to accept the file and
> transmit to both at the same time. Resuming when rfcomm is trying to
> connect to a device he haves to wait until that device gives a time
> out or accepts the connection before trying to connect to another
> device.
>  
> Is this true? Can i control the timeout of the connection on the bluez
> side? 
>  
> Is there a way to establish several connections to many devices
> without depending between them?

use "hcidump -X -V" to show what's going on.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
