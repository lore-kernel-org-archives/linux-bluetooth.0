Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F08719F.70708@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: Cozza <ac2crp@blueyonder.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
References: <3F02DBA9.1060305@superbug.demon.co.uk>
	<004701c34153$0e650ba0$fd02a8c0@troll>
	<3F062FF5.7020703@superbug.demon.co.uk>
In-Reply-To: <3F062FF5.7020703@superbug.demon.co.uk>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 06 Jul 2003 19:59:43 +0100
Content-Type: text/plain; CHARSET=us-ascii; FORMAT=flowed

James Courtier-Dutton wrote:
> Cozza wrote:
> 
>> Hi,
>>
>> I believe that there is a problem with the hci-usb driver. I performed 
>> some
>> brief investigations which I posted earlier to this mailing list.
>>
>> Are you using a USB device? I've used the same code and Bluetooth headset
>> with a PC card Bluetooth adaptor and everything worked fine.
>>
>> Both Bluetooth devices use the CSR chipset, but the UART one using the 
>> BCSP
>> protocol works whereas the USB one misses half the data packets, as you
>> suggest.
>>
>> My earlier message was posted on 20th June, entitled "SCO problem with 
>> USB
>> devices" - I'd be interested to see if your problem looks the same. I 
>> think
>> it possibly is, from what you've posted.
>>
>> I haven't yet got around to investigating the problem with the USB 
>> stack -
>> but I have the same problem, if it helps! If you are in a rush, then 
>> PC card
>> devices seem to work at the moment...
>>
>> Regards,
>>
>> Colin
>>
>>
>>
>>
> I have made some progress. I can now record audio from the headset 
> without it loosing any samples. I.e. I can record 8 bit PCM at 8000hz 
> and it sounds fine. Before it was loosing samples and recording at more 
> like 4000hz.
> Once I get playback to work, I will post a patch to this list.
> Cheers
> James
> 
> 
If anyone is interested, the fix for recording required 2 urbs for each 
isoc connection. The current cvs only uses 1 urb for isoc connections, 
so the usbcore fills one urb in real time, and then when it is full, 
sends it to hci_usb.c via a callback. Once hci_usb.c has finished with 
the urb it sends it back to the usbcore to get refilled. The problem is 
that while hci_usb.c is processing the urb, usbcore has no urb to put 
real time audio samples in, so it just drops them. If 2 urbs are used, 
if hci_usb.c is processing one, usbcore always has another to place 
samples in. As long as hci_usb.c does not hold on to it's urb for too 
long, all is ok. This fix was discovered by comparing the alsa 
snd-usb-audio driver with the hci_usb.c driver.
I hope to get playback working soon.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
