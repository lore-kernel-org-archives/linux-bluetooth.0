Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <1101932186.15615.37.camel@pegasus>
References: <D041B252-43B9-11D9-9BD7-00039390D626@pepper.com> <1101929973.15615.32.camel@pegasus> <888FEE62-43D1-11D9-9BD7-00039390D626@pepper.com> <1101930622.15615.34.camel@pegasus> <F6F2876E-43D2-11D9-9BD7-00039390D626@pepper.com> <1101932186.15615.37.camel@pegasus>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BD226CAD-43D6-11D9-9BD7-00039390D626@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] hidd weirdness under 2.4.20
To: bluez-devel@lists.sourceforge.net
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
Date: Wed, 1 Dec 2004 15:22:35 -0500

Marcel,

here is the dump:

root@(none):~# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
 > ACL data: handle 0x0001 flags 0x02 dlen 10keyboard.c: can't emulate 
rawmode for keycode 272

     L2CAP(d): cid 0x0041 len 6 [psm 0]
       0000: a1 02 01 00 00 00                                 ......

Yes -- I am running the latest mh patch.


Michael


On Dec 1, 2004, at 3:16 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> No keyboard,  It happens when I press the mouse button.
>
> run "hcidump -X" and show us the report that generates this event. This
> is the latest -mh patch for that kernel version, right?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real 
> users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
