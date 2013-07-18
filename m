Return-Path: <cyrus@holtmann.org>
Message-ID: <51E7F5C6.2080203@globaledgesoft.com>
Date: Thu, 18 Jul 2013 19:33:50 +0530
From: Sathish N <sathish.n@globaledgesoft.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: girish.br@globaledgesoft.com, ajay.kv@globaledgesoft.com,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH bluez] attrib: Fix interactive gatttool segfault
References: <1374144156-16351-1-git-send-email-sathish.n@globaledgesoft.com> <20130718111646.GA4708@x220.p-661hnu-f1>
In-Reply-To: <20130718111646.GA4708@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi johan,

Yes it is my first submission. The full name is Sathish Narasimman.
solved the "git am" error and the patch is resubmitted(extra bluez/* 
directory removed).

Thanks,
Sathish Narasimman

On Thursday 18 July 2013 04:46 PM, Johan Hedberg wrote:
> Hi Satish,
>
> On Thu, Jul 18, 2013, Sathish N wrote:
>> From: sathish N <sathish.n@globaledgesoft.com>
> Since this seems to be your first submission let me confirm these git
> author details: is this really how you want your author name to be, i.e.
> with a lower case "s" and just "N" as your surname? At least in your
> email "From" header your name was with a capital "S".
>
>> ---
>>   bluez/attrib/interactive.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> There seems to be something strange with your tree that generates this
> extra bluez/* path component. It makes "git am" fail to apply this
> patch:
>
> Applying: attrib: Fix interactive gatttool segfault
> error: bluez/attrib/interactive.c: does not exist in index
> Patch failed at 0001 attrib: Fix interactive gatttool segfault
>
> Besides the above issues the actual change to the code itself looks fine
> to me.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

