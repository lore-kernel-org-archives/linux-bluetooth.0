Return-Path: <cyrus@holtmann.org>
Message-ID: <4BF50114.2000108@vmars.tuwien.ac.at>
Date: Thu, 20 May 2010 11:29:56 +0200
From: Bernhard Froemel <froemel@vmars.tuwien.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <201005191906.o4JJ6ktf030453@imap1.linux-foundation.org>	 <1274303130.26613.517.camel@localhost.localdomain>	 <4BF45CB5.4050504@vmars.tuwien.ac.at>	 <1274338372.27220.4.camel@localhost.localdomain>	 <4BF4E67B.3050900@vmars.tuwien.ac.at> <1274344173.27220.7.camel@localhost.localdomain>
In-Reply-To: <1274344173.27220.7.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000201000703060108000009"
Subject: Re: + btusb-patch-add_apple_macbookpro62.patch added to -mm tree
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000201000703060108000009
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,
On 05/20/2010 10:29 AM, Marcel Holtmann wrote:
> Please send your patch to linux-bluetooth@vger.kernel.org and include
>>> the part for this device from /proc/bus/usb/devices in your commit
>>> message.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>>
>>>        
>>    usbfs disappears on recent kernels [1], at least for desktop machines
>> (and most certainly on my stock distribution). Don't want to be contra
>> productive here, but if you insist on this "proof" (i.e. don't accept
>> the output of the above lsusb command or my forum discussion reference
>> [2] as proof enough) and want me to spend another hour compiling a
>> kernel with enabled usbfs for such a small fix, then I'll pass on this
>> one for now.
>>      
> just run the attached script. It does the same thing. Or you could just
> mount usbfs.
>    
There is *no* usbfs available in my current kernel - I'd need to enable 
and recompile: that's why I can't mount. Distribution vendors (like 
Ubuntu) follow the recommendation concerning usbfs support in their 
stock kernels (it's marked deprecated).

Your script does not work on devices attached to (internal) hubs - they 
are silently omitted. I modified it accordingly and that's the output:
> T:  Bus=1 Dev#=8 Spd=12 MxCh=0
> D:  Ver=2.00 Cls=ff(vendr) Sub=01 Prot=01 MxPS=64 #Cfgs=1
> P:  Vendor=05ac ProdID=8218 Rev=0.22
> S:  Manufacturer=Apple Inc.
> S:  Product=Bluetooth USB Host Controller
> C:  #Ifs=4 Cfg#=1 Atr=e0 MxPwr=0mA
> E:  Ad=00(both) Atr=00(Control) MxPS=0040 Ivl=0ms
> I:  If#=00 Alt=0 #EPs=03 Cls=ff(vendr) Sub=01 Prot=01 Driver=btusb
> I:  If#=01 Alt=0 #EPs=02 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> I:  If#=02 Alt=0 #EPs=02 Cls=ff(vendr) Sub=ff Prot=ff Driver=(none)
> I:  If#=03 Alt=0 #EPs=00 Cls=fe(apspe) Sub=01 Prot=01 Driver=(none)
As visible here and in my previously quoted lsusb output the class isn't 
set correctly (0xff instead of 0xe0), so the driver won't detect the 
device. It does here, because - of course - I run the patched btusb module.
When I remove my patched DKMS module (and use the stock module as 
shipped in 2.6.32), the output is:
> T:  Bus=1 Dev#=8 Spd=12 MxCh=0
> D:  Ver=2.00 Cls=ff(vendr) Sub=01 Prot=01 MxPS=64 #Cfgs=1
> P:  Vendor=05ac ProdID=8218 Rev=0.22
> S:  Manufacturer=Apple Inc.
> S:  Product=Bluetooth USB Host Controller
> C:  #Ifs=4 Cfg#=1 Atr=e0 MxPwr=0mA
> E:  Ad=00(both) Atr=00(Control) MxPS=0040 Ivl=0ms
> I:  If#=00 Alt=0 #EPs=03 Cls=ff(vendr) Sub=01 Prot=01 Driver=(none)
> I:  If#=01 Alt=0 #EPs=02 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
> I:  If#=02 Alt=0 #EPs=02 Cls=ff(vendr) Sub=ff Prot=ff Driver=(none)
> I:  If#=03 Alt=0 #EPs=00 Cls=fe(apspe) Sub=01 Prot=01 Driver=(none)
I hope you're finally convinced, so attached once more the patch (and CC 
to linux-bluetooth).

Signed-off-by: Bernhard Froemel <froemel@vmars.tuwien.ac.at>

-bf

--------------000201000703060108000009
Content-Type: text/x-patch;
 name="btusb_add_apple_MacBookPro62.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="btusb_add_apple_MacBookPro62.patch"

--- linux/drivers/bluetooth/btusb.c	2010-05-06 15:56:18.228630685 +0200
+++ linux_p/drivers/bluetooth/btusb.c	2010-05-02 11:03:55.955362854 +0200
@@ -75,6 +75,9 @@
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
+	/* Apple MacBookPro6 BT device */
+	{ USB_DEVICE(0x05ac, 0x8218) },
+
 	{ }	/* Terminating entry */
 };
 

--------------000201000703060108000009--
