Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO socket data transmission status
From: Marcel Holtmann <marcel@holtmann.org>
To: Roderick Taylor <rtaylor@hcvwireless.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <opsa5i9odng1fi0r@trippin>
References: <opsa5i9odng1fi0r@trippin>
Content-Type: text/plain
Message-Id: <1089889215.3569.30.camel@notepaq>
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
Date: Thu, 15 Jul 2004 13:00:15 +0200

Hi Roderick,

> When you send to a SCO socket in BlueZ, is there a way to find out if the  
> bt device has transmitted the data you have written?  Do SCO sockets have  
> any interaction with the select function?
> 
> To me it seems that sending to a bluez SCO socket will work no matter  
> what.  If you send data to fast for the device to handle then, then the  
> data written will be ignored.

the SCO sockets are for audio only. You can expect that every packet is
transmitted and the Bluetooth chip may drop packets if you send to much
to it.

> Is this a question for bluez-users rather than bluez-devel?

It is correct at this place.

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
