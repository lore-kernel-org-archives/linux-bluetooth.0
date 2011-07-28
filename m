Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Jul 2011 09:33:40 +0100
Message-ID: <CAJ+AEyNxFa0OeYG2qGhUXk0iQvapOJEJOZ_Nxnn0J5fZ=UdWUA@mail.gmail.com>
Subject: ACL/SCO packets not transferred to slave device with new btusb/BlueZ driver
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your reply Peter.

The problem I've got is that I work for a company testing Bluetooth so
I have my hands tied as to how much information I can give - this is
obviously a nightmare for both you who is trying to help me and for me
who is trying to get the issue fixed :)

It could be very well that the program I'm using (that used to work
with BlueZ just fine when the hci_usb driver was around) is no longer
compatible.

I need to speak to the developers of the program I'm using to work out
how they communicate with BlueZ/the chip.

Cheers.


On Fri, Jul 15, 2011 at 9:41 PM, Eponymous - <the.epon@gmail.com> wrote:
>
> I'm not sure I follow you.
>
> What is wrong with the subject line?
>
> Cheers.
>
> On Thu, Jul 14, 2011 at 3:40 PM, Markus Burvall <markus.burvall@swedenconnectivity.com> wrote:
>>
>> Hi,
>>
>> I don't think they read this mail due to the subject line.
>>
>> Best of luck!
>>
>> On 2011-07-12 11:07, Eponymous - wrote:
>>
>> I'm now thinking that it's going to be a waste of time unless I can
>> get SCO support as well.
>>
>> To re-iterate my prev question: is this a bug and if so, will it be fixed?
>>
>> On Fri, Jul 1, 2011 at 8:06 AM, Eponymous - <the.epon@gmail.com> wrote:
>>
>> Hmm, is this patch included/due to be included in later releases of
>> btusb? It sounds like a bug if you can't send ACL/SCO packets over a
>> RAW socket.... Am I wrong?
>>
>> How exactly is everything packaged up? Is btusb part of the bluez
>> suite or is it a separate packaged?
>>
>> Cheers.
>>
>>
>> On Fri, Jul 1, 2011 at 7:59 AM, Markus Burvall <
>> markus.burvall@swedenconnectivity.com> wrote:
>>
>> **
>> Hello,
>>
>> For non SCO packets the fix from Kim works.
>>
>> Recompile btusb.c and use RAW mode.
>>
>> However it didn't work work SCO over RAW.
>>
>> http://lkml.org/lkml/2010/4/7/146
>>
>> Best Regards, Markus
>>
>>
>> On 2011-07-01 08:46, Eponymous - wrote:
>>
>> Thanks for the information.
>>
>> Hmm, I'm not sure what you mean about a "raw hci" socket. Could you
>> tell me how I can check this?
>>
>> I'm using a custom program that can communicate directly to the chip
>> over hci using bluez as a go-between. Does this help?
>>
>> Cheers.
>>
>> On Thu, Jun 30, 2011 at 4:47 PM, Peter Hurley <peter@hurleysoftware.com> <peter@hurleysoftware.com> wrote:
>>
>>  On Wed, 2011-06-29 at 06:22 -0400, Eponymous - wrote:
>>
>>  Thanks for your reply Peter.
>>
>> Sorry if I came across a bit rude there, it is just very frustrating
>> sometimes :)
>>
>>  I get it. BT can be <arggghhh>...
>>
>>
>>  You mentioned enabling debug messages for btusb and bluetooth. Do you
>> by any chance know how to do this?
>>
>>  I always run a debug kernel. My relevant build settings in the "Kernel
>> hacking" submenu are:
>>  Kernel Debugging => DEBUG_KERNEL=y
>>  Debug Filesystem => DEBUG_FS=y
>>  Compile the kernel with debug info => DEBUG_INFO=y
>> and most importantly,
>>  Enable dynamic printk() support DYNAMIC_DEBUG=y
>>
>> Then read the short dynamic debug howto in the kernel documentation:
>> Documentation/dynamic-debug-howto.txt (there are some copies online as
>> well if that's easier).
>>
>> Then when I want to see debug messages, I just enable those source
>> files. Eg.,
>> # echo -n 'file hci_core.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>>
>> M.Sc Markus Burvall
>> Senior Consultant
>>
>> Adress:
>> Torshamnsgatan 30B / 28A
>> 164 40 Kista
>> Sweden
>> Mobile: +46 70 650 11 44
>> Mail: Markus.Burvall@SwedenConnectivity.com
>> Web: http://swedenconnectivity.com
