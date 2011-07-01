Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000e0ce00a58298def04a6fca5b9@google.com>
References: <BANLkTim5MekMVbzZE34g_V6v0QJVj7c9xA@mail.gmail.com>
	<000e0ce00a58298def04a6fca5b9@google.com>
Date: Fri, 1 Jul 2011 08:06:58 +0100
Message-ID: <BANLkTinMnC3VsCKkxz5NP400yPotfj8bxA@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hmm, is this patch included/due to be included in later releases of
btusb? It sounds like a bug if you can't send ACL/SCO packets over a
RAW socket.... Am I wrong?

How exactly is everything packaged up? Is btusb part of the bluez
suite or is it a separate packaged?

Cheers.


> On Fri, Jul 1, 2011 at 7:59 AM, Markus Burvall <
> markus.burvall@swedenconnectivity.com> wrote:
>
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
