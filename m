Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425390E3.6060408@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] malloc & free
References: <424C259C.9000201@futurlink.com> <1112554711.8263.13.camel@pegasus> <42538BC5.7060106@futurlink.com>
In-Reply-To: <42538BC5.7060106@futurlink.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 06 Apr 2005 09:33:55 +0200

>>>The problem with these functions is that they call malloc(), expecting 
>>>the caller to call free(). The problem with that is that this approach 
>>>is not save, as it is not guaranteed that calling malloc() in a library 
>>>function and free() in the main program works. In fact, I have seen a 
>>>segmentation fault doing that.
>>>    
>>>
>>
>>explain why this is not safe.
>>  
>>
> I am not an expert in these issues, but I have read many times that 
> there is no guarantee that the malloc/free implementation is the same in 
> the main program and in the libraries. This is due to how the different 
> modules are compiled: compiler version, compile flags, etc. But, as I 
> said, I am not 100% sure. I am quite sure that I have read this for 
> Windows, but maybe (probably) Linux is different.

Except if statically linked with the libc or if malloc and free have 
been re_#define_d, functions from the lib and the main program will uses 
the system default libc implementation.

Regards,
Xavier Garreau


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
