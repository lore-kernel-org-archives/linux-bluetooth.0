Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4252CE90.70603@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] arm boards for embedding bluez
References: <4251F6CB.8080209@xmission.com> <42523631.6020905@thomae-privat.de>
In-Reply-To: <42523631.6020905@thomae-privat.de>
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
Date: Tue, 05 Apr 2005 11:44:48 -0600

Matthias,

Yes, this looks very interesting. Maybe hackable consumer devices are 
the way to go instead of eval boards for small projects.

For asterisk+btsco, it even sounds like someone has gotten asterisk to 
run on a box with similar specs (wrt54gs) but I wish there was a little 
more wiggle room than just 32MB ram.

I had no luck trying to find anything suitable with included line-in to 
do live a2dp streaming. A usb audio dongle could work with the slug I 
guess :(

Brad

Matthias Thomae wrote:
> Hi Brad,
> 
> how about this:
> 
> http://www.nslu2-linux.org/wiki/HowTo/BuildABlueSlug
> 
> Haven't tried it myself (yet), but looking forward to the nearing Beta 
> release of OpenSlug to build a cheap and low-power bluetooth access 
> point/NAS.
> 
> Regards.
> Matthias
> 
> Brad Midgley wrote:
> 
>> Hey
>>
>> Does anyone have a feel for what is available now for doing embedded 
>> bluez stuff with arm? I would like to put together something with a 
>> class 1 adapter... it seems like there was talk of a board for 
>> embedding that had class 1 built in but I can't find it in the 
>> archives and googling reveals a bunch of designs that have probably 
>> been abandoned.
>>
>> I am hoping that by doing linux on arm, it would be 
>> cheaper/smaller/cooler than the $200+ each that a small x86 barebones 
>> board costs, eg: 
>> http://www.kontron.com/products/pdproductdetail.cfm?keyProduct=32658&kps=1689&kpc=237&keySiteRegion=1 
>>
>>
>> but 300Mhz/IDE/VGA is overkill for this... I just want something that 
>> could stream a2dp & do voip to a headset and act as an access point 
>> for a bluetooth pda.
>>
>> Brad
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
