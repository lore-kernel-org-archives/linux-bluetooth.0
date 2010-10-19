Return-Path: <cyrus@holtmann.org>
Message-ID: <4CBD88A8.1050909@atheros.com>
Date: Tue, 19 Oct 2010 17:31:44 +0530
From: Balamurugan Mahalingam <mbalamurugan@atheros.com>
MIME-Version: 1.0
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>, <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>, <charubala@charubala.com>
Subject: Re: [PATCH] Fix GUI crash while connecting Interlink Bluetooth Mouse
 in android platform.
References: <1287482080-10093-1-git-send-email-mbalamurugan@atheros.com> <20101019112328.GA12554@jh-x301>
In-Reply-To: <20101019112328.GA12554@jh-x301>
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi,
>
> On Tue, Oct 19, 2010, Balamurugan Mahalingam wrote:
>   
>> Crash is due to some junk characters in the device name.
>> The device name is copied from a string variable after freeing the memory it points to, so there were some junk characters in it which was the reason for the crash.
>> Fixing the issue by freeing the memory in string variable after device name is copied.
>>
>> Signed-off-by: Balamurugan Mahalingam <mbalamurugan@atheros.com>
>> ---
>>  compat/sdp.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>     
>
> Looks like a good fix, but could you please fix your commit message and
> resend:
>
> 1. The commit message doesn't so much describe the change as it does
> some symptom in a downstream system (android). E.g. the summary line
> should be something like "Fix accessing freed memory". You can still
> talk about the background to this issue wrt. android but the main point
> should be in a bluez-only context.
>
> 2. Keep the commit message lines below 74 characters so that it's
> properly viewable on a 80-character wide terminal when running "git log"
>
> 3. Remove the signed-off-by line. We don't use that in userspace.
>
> Johan
> .
>
>   
Hi Johan,

Thanks for your comments. I will do the changes and send the patch once 
again

Thanks
Balamurugan Mahalingam
