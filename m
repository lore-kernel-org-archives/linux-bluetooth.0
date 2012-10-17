Return-Path: <cyrus@holtmann.org>
From: "Kim Schulz" <kim@schulz.dk>
To: <linux-bluetooth@vger.kernel.org>
References: <507D6F26.8040306@schulz.dk> <CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com> <507D7480.6040205@schulz.dk>
In-Reply-To: <507D7480.6040205@schulz.dk>
Subject: RE: gatttool and multiple devices connected
Date: Wed, 17 Oct 2012 11:00:40 +0200
Message-ID: <005601cdac45$e1ee8ac0$a5cba040$@dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Den 2012-10-16 16:51, Kim Schulz skrev:
> On 10/16/2012 04:45 PM, Anderson Lizardo wrote:
>> Which kernel version are you running? Older kernels had a LE 
>> connection routing issue which I believe was fixed long ago. And what 
>> do you mean with not being able to get services? which error did you 
>> get? Do you have hcidump logs from these sessions? Regards,
>
> The Bluez code is one taken from git a few days ago. I don't recall 
> which kernel version (will have to check at the office tomorrow) but 
> it is one of the latest that we compiled for this test.
> We do have some logs of the session and I will be looking at those 
> more thoroughly tomorrow.
>
> kim
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hi,
Turns out that the guy compiling our kernel choose a version 
3.4.0.030400 so not really the
bleeding edge version.
Do you have any recommendation on what version of the kernel we should 
aim for?


-- 
Kim Schulz


