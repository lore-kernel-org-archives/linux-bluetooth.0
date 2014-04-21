Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: btusb: Add BCM20702 firmware upgrade support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5354F3AA.9070707@canonical.com>
Date: Mon, 21 Apr 2014 11:19:37 -0700
Cc: Petri Gynther <pgynther@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <F292C463-102B-458E-BE3C-2BA274D21AFB@holtmann.org>
References: <5354F3AA.9070707@canonical.com>
To: Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> Sorry for creating a new thread instead since I didn't subscribe this mailing list.
> 
>>>>> Interestingly, now that I look at that page more closely, Ubuntu 12.04
>>>>> LTS with kernel 3.8 supports this already? Has Ubuntu made a patch
>>>>> that bluetooth-next doesn't have?
>>>> 
>>>> That is Ubuntu for you. They just push patches into their kernel and never give them back to upstream or make sure they get merged into bluetooth-next. I really dislike that behavior. It is always the easy way out instead of trying to do the right thing.
>>>> 
>>> 
>>> See this page: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1065400
>> 
>> It is a stupid userspace version that is racy as hell. Even the bug mentions that it should be done in the kernel. And I am pretty sure that was my initial comment as well. Just posting the userspace patch for reference.
> 
> No it's not the stupid userspace loader you're referring to.
> 
> And no, these patches are not pushed into Ubuntu kernel only.
> 
> These stupid patches were sent to this mailing list for review, for three or four times, and all of them were rejected by you. The latest version of patches that got rejected should be quite similar to Petri's.

so do you have answers to all the questions I raised with Petri? I can go through the archive and read my own comments, but if I rejected the patches, then there was a reason for that.

Regards

Marcel

