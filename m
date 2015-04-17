Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150417115613.GA9308@t440s.lan>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
	<20150417115613.GA9308@t440s.lan>
Date: Fri, 17 Apr 2015 16:51:07 +0200
Message-ID: <CADDKRnBCUW2huD9yEapdxoCnrvmpeHA2H--g=f74gzATKo=zwg@mail.gmail.com>
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2015-04-17 13:56 GMT+02:00 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi J=C3=B6rg,
>
> (unnecessary people and lists dropped from CC)
>
> On Fri, Apr 17, 2015, J=C3=B6rg Otte wrote:
>> The BT mouse is "death" in v4.1.
>
> Could you be a bit more specific what you mean by v4.1, considering that
> it's not yet released (we don't even have a 4.1-rc1 yet).

The kernel is 4.0.0-07300-g4fc8adc.

The top of my tree is:
4fc8adc Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
84588e7 Merge branch 'for_linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
a39ef1a Merge branch 'for-4.1/drivers' of git://git.kernel.dk/linux-block
d82312c Merge branch 'for-4.1/core' of git://git.kernel.dk/linux-block
7d69cff Merge tag 'scsi-misc' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
8fa6f49 Merge branch 'mailbox-for-next' of
git://git.linaro.org/landing-teams/working/fujitsu/integration
...

>
>> The BT mouse has been working in 4.0 and previous kernels, so this
>> is a regression.
>>
>> BT adapter is an intel 8087:07da. The mouse is an MS Notebook Mouse 500.
>
> There was an initialization issue with 8087:07da that was already fixed,
> and the fix should be going to the 4.1 kernel. Could it be that you're
> simply missing this commit in your tree? It is this one:
>
> commit 407550fe2ccfca3fa0ac4bcdb0a412adeabf84ba
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Sun Feb 22 15:41:18 2015 -0800
>
>     Bluetooth: btusb: Fix issue with CSR based Intel Wireless controllers

I already have this commit in the tree.

Thanks, J=C3=B6rg
