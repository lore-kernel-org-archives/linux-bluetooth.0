Return-Path: <cyrus@holtmann.org>
Message-ID: <4DA9CB83.4050000@gmail.com>
Date: Sat, 16 Apr 2011 10:01:55 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Gottfried Haider <gottfried.haider@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [Regression] Bluetooth pairing does not work anymore in 2.6.39-rc3
 (works in 2.6.38.3)
References: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
In-Reply-To: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/16/2011 09:38 AM, Gottfried Haider wrote:
> Hello,
>
> I am having problems pairing bluetooth devices in 2.6.39. Scanning
> works fine (hcitool scan), but when I try to pair a device using
> "bluez-simple-agent hci0 $MAC", I receive the following error message:
> "Creating device failed: org.bluez.Error.Failed: Input/output error"
>
> The same command reliably works on a 2.6.38.3 kernel with pretty much
> the same config.
>
> According to lsusb, I have a Broadcom Bluetooth Controller with ID
> 0a5c:217f. I don't see anything related in either of the dmesgs.
> My lspci output is here: http://sukzessiv.net/x120e/
> Userspace is an up-to-date Ubuntu 11.04 beta (with bluez 4.91).
>
> If there are any debugging steps that I could do or patches to try or
> revert, let me know. Unfortunately I can't do a proper bisect since
> the machine is a netbook type.
>
> cheers,
> gohai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I'm wondering if you are hitting what I was hitting a few days ago.. the 
commit below got things working over here:
(not sure if this is in the stable yet)
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git;a=commitdiff;h=b99faf1b798d6d0e33526fd2cef55a405c08ff09;hp=58b6e124aac64bebb2e9e1a136cbd21a5ab0485a

hope this helps,

Justin P. Mattock
