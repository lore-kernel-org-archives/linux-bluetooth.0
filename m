Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42EF8B0F.6020108@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco problems
References: <39673606050801205131f308d3@mail.gmail.com>	 <42EEF35E.4080405@xmission.com> <3967360605080206231820ee1f@mail.gmail.com>
In-Reply-To: <3967360605080206231820ee1f@mail.gmail.com>
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
Date: Tue, 02 Aug 2005 09:02:39 -0600

Rob,

I believe CSR was the only chipmaker that was willing to give Marcel the 
info he needed to implement SCO in the driver. You'll have to ask him.

I'm watching for a bt2.0 class 1 module :)

Brad

Robert Brewer wrote:
> Any thoughts on how hard it would be to make broadcom work?
> I'm willing to donate some time to help make it happen... I have
> some previous lower-level coding experience, but no bluetooth
> experience.
> 
> Failing that, can anyone recommend a CSR dongle that is class 1 (100m range)
> and bluetooth 1.2?
> 
> Thanks,
> Rob
> 
> On 8/2/05, Brad Midgley <bmidgley@xmission.com> wrote:
> 
>>Robert
>>
>>
>>>Zonet zub6101c usb dongle (class 1, bluetooth 1.2, broadcom chipset)
>>
>>I believe this is the problem. btsco can transfer audio only to CSR modules.
>>
>>Brad
>>
> 
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
