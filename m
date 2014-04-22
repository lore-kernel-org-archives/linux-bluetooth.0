Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F292C463-102B-458E-BE3C-2BA274D21AFB@holtmann.org>
References: <5354F3AA.9070707@canonical.com>
	<F292C463-102B-458E-BE3C-2BA274D21AFB@holtmann.org>
Date: Tue, 22 Apr 2014 20:34:38 +0800
Message-ID: <CAH10aOjfgBHjbXS2uY6DLW6wTki9FzDPusR-8ODFnwGajd69sA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add BCM20702 firmware upgrade support
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Petri Gynther <pgynther@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, yk@canonical.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2014-04-22 2:19 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Jesse,
>
>> Sorry for creating a new thread instead since I didn't subscribe this ma=
iling list.
>>
>>>>>> Interestingly, now that I look at that page more closely, Ubuntu 12.=
04
>>>>>> LTS with kernel 3.8 supports this already? Has Ubuntu made a patch
>>>>>> that bluetooth-next doesn't have?
>>>>>
>>>>> That is Ubuntu for you. They just push patches into their kernel and =
never give them back to upstream or make sure they get merged into bluetoot=
h-next. I really dislike that behavior. It is always the easy way out inste=
ad of trying to do the right thing.
>>>>>
>>>>
>>>> See this page: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/10=
65400
>>>
>>> It is a stupid userspace version that is racy as hell. Even the bug men=
tions that it should be done in the kernel. And I am pretty sure that was m=
y initial comment as well. Just posting the userspace patch for reference.
>>
>> No it's not the stupid userspace loader you're referring to.
>>
>> And no, these patches are not pushed into Ubuntu kernel only.
>>
>> These stupid patches were sent to this mailing list for review, for thre=
e or four times, and all of them were rejected by you. The latest version o=
f patches that got rejected should be quite similar to Petri's.
>
> so do you have answers to all the questions I raised with Petri? I can go=
 through the archive and read my own comments, but if I rejected the patche=
s, then there was a reason for that.

You did have a reason, and I don't complain about the rejection at all.

The reason I reply is that Petri asked why there's a patch in Ubuntu
and not in upstream, and, with all due respect, the answer of "That is
Ubuntu for you. They just push patches into their kernel and never
give them back to upstream or make sure they get merged into
bluetooth-next." doesn't reflect what happened. The launchpad link
Petri mentioned is all about patching btusb instead of using userspace
loader, but guess you're too busy to read the short description.

For Petri's question, patches have been rejected for several times.
Since these patchram modules are equipped on more and more devices
recently, making them supported is better than just leaving them
unsupported, even with a solution that does not perfectly match the
expectation of upstream IMHO. That's why I tried to push these
rejected patches into Ubuntu kernel. The Ubuntu kernel team accepted
them though they do have concerns about these patches are not accepted
by upstream. I'm still working on a solution when I have time to do
so.

And as I didn't subscribe to this mailing list, would you mind to show
me the questions you're referring to? Most likely I won't have answers
to all of the questions, after all, all the clue I have is the
userspace loader. But I'd be more than happy to give it a try.

Regards,
Jesse
