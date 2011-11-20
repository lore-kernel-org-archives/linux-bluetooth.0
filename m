Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC91C7F.9070500@gmail.com>
Date: Sun, 20 Nov 2011 16:27:59 +0100
From: Michael Schmitt <tcwardrobe@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: marcel@holtmann.org, padovan@profusion.mobi
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
References: <4EC679A0.7050309@gmail.com> <20111118153652.GA3647@fusion.localdomain> <4EC67E88.6060202@gmail.com> <20111118162111.GA4680@fusion.localdomain> <4EC68909.40108@gmail.com> <20111118203019.GA24250@x220.ger.corp.intel.com>
In-Reply-To: <20111118203019.GA24250@x220.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 18.11.2011 21:30, schrieb Johan Hedberg:
> HI Michael,
>
> On Fri, Nov 18, 2011, Michael Schmitt wrote:
>> Thanks for the input. But do you know why the device works with
>> older kernel / userland?>
> Probably because the list of supported commands wasn't previously
> requested as part of the adapter init sequence, or because the kernel
> code didn't actually wait for all commands to complete before notifying
> success to user space (I know the latter is at least true since I
> submitted a patch for it).

So that means, if the bt-stack in the kernel would ignore the successful 
completion of those "what protocol version do you understand"-commands 
all bt-related stuff with the stick would work nevertheless?

>> So, and what do we do from here on?
> Well, the attached patch will at least make sure that the failure of
> this command is correctly detected so you get an immediate error instead
> of a timeout. The next step is to decide whether to do a quirk for your
> specific adapter or to make it a general rule that errors for this
> particular HCI command are ignored (for that we'd need feedback from the
> real kernel experts like Marcel and Gustavo).

But apparently none of them had the urge to actually respond in this 
ml-thread yet. :) Let's see, I try to poke them "mildly" in cc'ing them...

General speaking, the bt-stick in question is old (at least 5 years or 
so) and I have another (working) stick here, so there is no immediate 
adversity for me. But I guess as this stick is from major bt-accessoirs 
supplier from germany (AVM GmbH Berlin) this hardware may be around for 
many users for a fairly long time. But then again... it seems to be a 
hardware-bug...

Anyway, I guess it would ne nice to have it "fixed" someday. :)

Greetings
Michael
