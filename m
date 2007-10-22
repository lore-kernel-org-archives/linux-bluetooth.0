Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <471C9196.20801@cilnu.com>
Date: Mon, 22 Oct 2007 13:03:34 +0100
From: Jon Maber <jon@cilnu.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47179EC5.8080808@cilnu.com> <1193045302.6184.165.camel@violet>
In-Reply-To: <1193045302.6184.165.camel@violet>
Subject: Re: [Bluez-devel] LED Output Reports to Keyboard
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Jon,
>
>   
>> Right place to talk about the Bluez source code that is now in the Linux 
>> Kernel? Hope so.
>>
>> In essence: testing with kernel 2.6.22, it seems to me that LED 
>> information is sent to bluetooth devices using the boot protocol 
>> regardless of whether the boot protocol is active and even if the device 
>> explicitly declares that it doesn't support boot protocol.
>>
>>
>>
>> In detail:  I'm designing a Bluetooth keyboard device which has some 
>> LEDs which are for customised use.   This means that they have ID 
>> numbers that cannot be represented in the boot protocol keyboard output 
>> report.  So, the device has a customised report descriptor. The first 
>> byte of the output report is the same as the boot protocol but a second 
>> byte is added containing eight more LED flags. 
>>
>> I'm testing my device on a laptop running Fedora Core 6 with kernel 
>> 2.6.22.  Digging in the kernel source code I found that the LED output 
>> reports are sent from the function hidp_queue_event in the source file 
>> net/bluetooth/hidp/core.c.  I added an extra line for debugging;
>>
>>     BT_DBG("Sending keyboard boot protocol LED output report. Session is 
>> in %s mode.",
>>         ((session->flags & (1 << 
>> HIDP_BOOT_PROTOCOL_MODE))?"boot":"report") );
>>
>> which confirms that the HIDP module has correctly understood from my 
>> service record that boot protocol mode is not set.  The rest of this 
>> function however sends a hard wired boot protocol frame and therefore 
>> ignores completely any LED events that cannot be represented.  In fact 
>> for my customised LEDs no frame is sent at all since to this function it 
>> seems that no significant LED has changed state.
>>
>> By the way, I also use a customised input report for key presses which 
>> is handled perfectly O.K.
>>
>> First question: can anyone tell me that the more unusual LED events do 
>> get through to their Bluetooth keyboard when using Linux?  It is of 
>> course possible that I've messed up my Service Record and all of the 
>> above is a load of tosh.
>>
>> Second question: actually I'll not dive into a load more questions about 
>> fixing the bug until I know that I've actually found one.
>>     
>
> don't force it to use the boot protocol mode. 
I am successful in getting the kernel to use report mode.  That 
debugging line does output "report".
> Lets use Linux the report
> protocol mode and make sure your HID report descriptor is sane. 
That's a good point - I've been hand crafting a descriptor as an array 
of hexadecimal numbers.  Can you recommend any tools to help construct 
report descriptors?  Is there a report descriptor FAQ or just a list of 
tips?
> Then we
> can fix it up in the common HID parser of Linux to handle you leds.
>   
I think I need to study the source code of the HID parser a bit more.  I 
don't really understand how it chooses the right output report to use to 
send LED events to a device. 
> Run "hcidump -X -V" to show what is send by your keyboard.
>   
I've just found some things using hcidump that are a bit strange. For 
example when the device connects;

< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 01 00 00 00 00 00 00 00  00    
This looks suspiciously like a boot protocol keyboard input report but 
it's being sent as an output report to the device. This packet is 
immediately followed by an LED output report - also boot protocol.

Here is an actual keyboard event generated in the device by pressing a 
key after connection:

 > ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 01 00 00

This is using my own customised input report which is shorter than a 
boot protocol one.  It gets interpreted correctly and the key event gets 
to the input subsystem properly via the HID subsystem.  There are no 
change of protocol messages appearing in the hcidump output and it seems 
certain that report protocol is in effect.

I think I need to do some more study before a come back with any more 
questions.
1) I need to understand the HID subsystem in the kernel.
2) I need to get some more info on report descriptors so I can check 
that mine are correct.
3) I need to dig into the firmware library of my device - I'm 
programming a CSR chip using BlueLab.
> Regards
>
> Marcel
>   
(By the way, you may be interested to know that the device I'm 
developing is a pocket computer with a wireless wearable keyboard for 
use by blind and visually impaired users.  The user interface will use 
keyboard input and voice synthesis output.)

Thanks for your response.

Jon


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
