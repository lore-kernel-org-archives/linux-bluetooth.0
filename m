Return-Path: <cyrus@holtmann.org>
Message-ID: <492FFB09.7020704@powercraft.nl>
Date: Fri, 28 Nov 2008 15:07:05 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Simon Kenyon <simon@koala.ie>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (the saga continues)
References: <492FC4A3.4020601@koala.ie> <492FCDD1.1010304@koala.ie> <492FDF90.9010305@koala.ie> <492FEF38.3020702@koala.ie> <492FF071.8030909@powercraft.nl> <492FF7D5.6060202@koala.ie>
In-Reply-To: <492FF7D5.6060202@koala.ie>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simon Kenyon wrote:
> Jelle de Jong wrote:
>> Hi Simon, I share your frustrations :-p. I will do some testing with the
>> latest git this weekend. You may want to look at my previous postings in
>> the archive.
>>
>> I advice you to give it a few hours rest and let me do some tesing on
>> Debian SID with the latested bluez-git. I don't know for sure if the
>> manatory xorg patch made it into the experimental packages...
>>   
> it is rather frustrating
> i've had this remote for 6 months now and would like to get it working 
> "properly"
> 
> what i would love to getis a description of a working configuration 
> (config files in particular)
> i don't know if i'm supposed to put something into one or more of the 
> /etc/bluetooth config files.
> or something in hal or dbus for that matter
> 
> we've both been told "it just works" but it doesn't
> --
> simon

I know it is frustrating, and I also got this device a while and spent
way to much time getting it working "out of the box"

As I said in my first response it does not yet just works, but I am not
an developer of bluez, just an heavy user and tester. BTW you should not
have to make any changes to the bluez config files.

I will look into it, this weekend and report back.

If you really want to try out right now, use the latest bluez git of
bluez-utils and bluez-gnome and the latest xorg git and try to get an
input event.

Best regards,

Jelle

