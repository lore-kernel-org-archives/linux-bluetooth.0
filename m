Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4290963C.30103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pskey bootmode value
References: <Pine.LNX.4.33.0505221544450.32193-100000@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.33.0505221544450.32193-100000@redbean.intranet.gw-instruments.de>
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
Date: Sun, 22 May 2005 08:25:00 -0600

Peter,

Thanks for the confirmation.

Yes, this is a CSR dongle (it's the dlink dbt-120, notorious for 
prefering hid mode after the v1.2 firmware update from apple)

i believe I saw code in pskey to bail out if it's not a CSR chip...

brad

Peter Wippich wrote:
> Hi Brad,
> 
> bootmode is nothing which depends on BlueZ but on the dongle you use. If
> you have a CSR Dongle which uses the BlueLab Dual Boot Firmware than
> bootmode 0 is HCI and bootmode 1 is HID mode. However, every
> manufacturer can choose what he wants....
> 
> To be sure what you have you have to consult the manufacturers
> documentation for your dongle. But I'm afraid for most devices this isn't
> documented at all.
> 
> Ciao,
> 
> Peter
> 
> 
> On Fri, 20 May 2005, Brad Midgley wrote:
> 
> 
>>Hi
>>
>>What bootmode value should I use for hci? I see 0x0001 for hid but I
>>don't want to just "guess" that it's 0...
>>
>>Brad
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by Oracle Space Sweepstakes
>>Want to be the first software developer in space?
>>Enter now for the Oracle Space Sweepstakes!
>>http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
>>_______________________________________________
>>Bluez-devel mailing list
>>Bluez-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
> 
> 
> |	Peter Wippich 			Voice: +49 30 46776411		|
> |	G&W Instruments GmbH		fax:   +49 30 46776419		|
> |	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
> |	D-13355 Berlin  / Germany					|
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
