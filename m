Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] malloc & free
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <424C259C.9000201@futurlink.com>
References: <424C259C.9000201@futurlink.com>
Content-Type: text/plain
Message-Id: <1112554711.8263.13.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 03 Apr 2005 20:58:31 +0200

Hi Pedro,

> In the application I am developing, I want to log some information about 
> Bluetooth devices, pretty much like "sdptool browse" and "hcitool info" 
> do. In the code of these applications, there are calls to some library 
> functions like hci_dflagstostr(), hci_lmtostr()... that create a string 
> with information about the device (flags, features, etc.).
> 
> The problem with these functions is that they call malloc(), expecting 
> the caller to call free(). The problem with that is that this approach 
> is not save, as it is not guaranteed that calling malloc() in a library 
> function and free() in the main program works. In fact, I have seen a 
> segmentation fault doing that.

explain why this is not safe.

> AFAIK, there are two alternatives: either the library functions expect a 
> buffer (and its size) to be filled or malloc() and free() are both done 
> within the library, which means creating a new library function call for 
> freeing buffers allocated with malloc(). Are any of this alternatives 
> implemented or on the roadmap? What workaround do you suggest?

We can do that, but it is not on my roadmap. Send my patches for it and
I will review them.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
