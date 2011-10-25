Return-Path: <cyrus@holtmann.org>
Message-ID: <4EA69B6D.3000905@canonical.com>
Date: Tue, 25 Oct 2011 19:20:13 +0800
From: Jesse Sung <jesse.sung@canonical.com>
MIME-Version: 1.0
To: Oliver Neukum <oneukum@suse.de>
CC: linux-bluetooth@vger.kernel.org, 812132@bugs.launchpad.net
Subject: Re: [PATCH] Bluetooth: set reset_resume handler
References: <4EA67552.1090703@canonical.com> <201110251040.14016.oneukum@suse.de>
In-Reply-To: <201110251040.14016.oneukum@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/25/2011 04:40 PM, Oliver Neukum wrote:
> Am Dienstag, 25. Oktober 2011, 10:37:38 schrieb Jesse Sung:
>>
>> On some machines, it seems that usb hubs do not get power while
>> being suspended. We can get something like this in dmesg:
>>       usb usb2: root hub lost power or was reset
>>
>> When this is the case, .reset_resume is called instead of .resume.
>> If .reset_resume is not set, bluetooth modules would stay in an unusable
>> state because the resume function is not called.
>
> Have you experimentally verified that? This state of affairs is years
> old and should result in a virtual unplug/replug cycle. What are you
> seeing?
>
> 	Regards
> 		Oliver

Hi Oliver,

Humm... You're right, there is an unplug-replug cycle, but bluetooth 
doesn't work until I restart bluetoothd. If the resume function is 
called through .reset_resume, then bluetooth works right after resume.

Regards,
Jesse
