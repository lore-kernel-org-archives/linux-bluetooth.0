Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41AD2B86.6010002@avantwave.com>
References: <41AD2B86.6010002@avantwave.com>
Content-Type: text/plain
Message-Id: <1101882506.18840.18.camel@pegasus>
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
Date: Wed, 01 Dec 2004 07:28:26 +0100

Hi Mike,

>     I have tried to fork two process, One use socket system call - 
> accept at rfcomm channel 2, and another try to connect to a bluetooth 
> device thought channel 3. But i found that i can not use a 3rd device to 
> connect to the listen channel 2 at the same time.

show us the source code for that.

>     I am using bluez-lib-2.6, utils-2.6. ,hci-uart and linux-2.4.18 
> patched with patch-2.4.18-mh15.

The bluez-libs and bluez-utils are at version 2.11 and you should update
both of them.

>     My question is simple, Could bluez be multi-tasking?

You may not be able to do some crazy things, but in general yes.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
