Return-Path: <cyrus@holtmann.org>
Message-ID: <51E01B77.5080206@hurleysoftware.com>
Date: Fri, 12 Jul 2013 11:06:31 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: Gustavo Padovan <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2] Fix refcounting issues in rfcomm/tty.c
References: <20130711190150.GA24422@debian.seek.priv> <20130712101852.GB2065@joana>
In-Reply-To: <20130712101852.GB2065@joana>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 06:18 AM, Gustavo Padovan wrote:
> Hi Gianluca,
>
> * Gianluca Anzolin <gianluca@sottospazio.it> [2013-07-11 21:01:50 +0200]:
>
>> Hello,
>>
>> This is a second version of the previous patches I sent to linux-bluetooth
>> list. I grouped the two patches together since they are related.
>>
>> I fixed some bugs in my previous attempt:
>
> If you are fixing different bugs I want one patch for each fix.
>
>> 1. skb_queue_purge is now called in the cleanup method to avoid a circular
>> dependency between the dev struct and dlc struct.
>>
>> 2. refcomm_dev_release should check REFCOMM_TTY_RELEASED instead of
>> REFCOMM_RELEASE_ONHUP.
>>
>> I checked with both bluez4 and bluez5 and everything works as expected.
>
> Please send a proper inline patch with git-format-patch and git-send-email. Also
> get rid of all BT_DBG changes you've made, read the dynamic debug doc to learn
> how to print the function name when debugging. And if you are moving functions around
> please do this in a separated patch.

Please cc me on this series when these changes are split up and
I'll be happy to review it.

Regards,
Peter Hurley
