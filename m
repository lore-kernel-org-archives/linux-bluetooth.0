Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42E5CA58.4030408@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Can't get btsco to connect to Plantronics M2500
 headset
References: <20050726042812.GA16828@as.arizona.edu>
In-Reply-To: <20050726042812.GA16828@as.arizona.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 25 Jul 2005 23:30:00 -0600

John,

You can force the pairing to be built again by removing 
/etc/bluetooth/link_key

I've looked at your messages and I can't think of many other things. Do 
you have other bluetooth devices you can try? Can you easily try it with 
a 32-bit kernel/userland?

Brad

> * The first time I tried to use the headset in Linux, I encountered these same
>   problems, but I *did* get it to work.  I was even able to play and record
>   audio.  After a short time, btsco exited and I haven't gotten it to work
>   again.  :(
> 
> * That first time, I also found an entry in the logs which I have never seen
>   again: 
>   hcid[4365]: pin_code_request (sba=00:0C:41:E1:E2:F1, dba=00:03:89:6E:C9:11)
>   This comes immediately after a link_key_request.  I still see the
>   link_key_request messages every time I I do any bluetooth commands, but I
>   have not seen the pin_code_request line again.  I don't know if that is
>   significant.
> 
> Please help!
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
