Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 15:02:30 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/8] Bluetooth: L2CAP updates for PSM validation and
 ERTM.
In-Reply-To: <1280778649.12579.50.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1008021450290.18432@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org> <1280778649.12579.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Mon, 2 Aug 2010, Marcel Holtmann wrote:

> Hi Mat,
>
>> This is a collection of ERTM-related patches, including some L2CAP
>> configuration fixes and allowing partial-frame reads from L2CAP
>> SOCK_STREAM sockets.  PSM validation is also included, although that
>> is not restricted to ERTM.
>
> so the merge window for 2.6.36 is basically closed and these patches
> came in too late. If they fix a bug, I like you to explain that in
> detail in the commit message so I can pick them out and include them for
> submission to John.

Marcel -

I'll fix up my commit messages and make the other changes you 
recommended.  I don't have a specific need for these to be in 2.6.36, 
but with more detail on the bug fixes you can decide if they're urgent 
enough.

Thanks for the feedback.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

