Return-Path: <cyrus@holtmann.org>
Message-ID: <502A49B6.4090300@jeffhansen.com>
Date: Tue, 14 Aug 2012 06:51:02 -0600
From: Jeff Hansen <x@jeffhansen.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: Implement idle timeout for fakehid
References: <50293C10.2000305@jeffhansen.com> <1344937850.2733.2.camel@novo.hadess.net>
In-Reply-To: <1344937850.2733.2.camel@novo.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/14/12 03:50, Bastien Nocera wrote:
> On Mon, 2012-08-13 at 11:40 -0600, Jeff Hansen wrote:
>> (bump)
>>
>> The batteries on my BD remote would die in a few days without this
>> patch.  The idle timeout needs to be enforced for fakehid devices as
>> well as normal HID devices.
> Except that the timeout is disabled by default for HID devices. I posted
> a patch that requires a little bit of work to get pushed last month or
> so.
>
Yes, of course it is disabled by default (which I don't understand, but 
that's a separate issue).  That is fine, but if a general timeout *is* 
specified by the user, it should carry into fakehid devices as well as 
normal HID devices.

Are there any bluez maintainers that can take a look at this patch?  
Anything that needs to change?

-Jeff

-- 
---------------------------------------------------
"If someone's gotta do it, it might as well be me."
                 x@jeffhansen.com

