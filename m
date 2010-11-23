Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 14:51:56 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Grahame Jordan <gbj@theforce.com.au>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: sdptool hanging remote
Message-ID: <20101123175156.GA30860@eris.indt.org>
References: <4CEB532F.1070804@theforce.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CEB532F.1070804@theforce.com.au>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16:37 Tue 23 Nov     , Grahame Jordan wrote:
> Hi,
> 
> I am using bluez-4.77 on a Gumstix Verdex kernel 2.4.32 patch 21
> 
> When I run:
> sdptool records 00:80:37:2F:06:08"
> from the Workstation Ubuntu 10.04 Bluez-4.6? to the Gumstix the Gumstix 
> hangs.
> It does not hang completely but is very busy. It hangs for about 20 
> seconds and then releases for about 1 second
> before it locks up again.

I couldn't find anything that could solve this kind of problem in the logs
between 4.6 and the git head. But anyway, could you give a try to 4.80, or
better yet, the git head[1]? and see if the problem still happens?

> 
> I have tried this on several different Gumstix with the same issue.
> 
> Changing workstations from Ubuntu 10.04 to Ubuntu 8.04 does make a 
> difference.
>  From Ubuntu 8.04 there seems to be no problem. blue-utils 3.26?
> 

A really helpful piece of information that you could provide is the hcidump[2]
logs of both cases, just be sure to give hcidump the options "-V" (verbose
output) and "-t" (timestamps, to see where the hang happens). 

> Appreciate help
> 
> 
> Thanks
> 
> Grahame Jordan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

[1] http://git.kernel.org/?p=bluetooth/bluez.git;a=summary

[2] http://git.kernel.org/?p=bluetooth/bluez-hcidump.git;a=summary
