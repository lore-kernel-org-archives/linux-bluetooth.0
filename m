Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F13E0CD.50704@monom.org>
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com>
	<4EF30EE3.6050602@monom.org>
	<CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com>
	<4F13E0CD.50704@monom.org>
Date: Mon, 6 Feb 2012 14:54:05 -0600
Message-ID: <CAMk70DAo9no5aHJ7LaqYvQEE1-MO-4mGZbiMb7r1mUpiaA1N_Q@mail.gmail.com>
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
From: bubba junk <junkbubba2@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Daniel,

I must have missed your response several weeks ago. I've read several of the
posts including the patch notes from Peter Hurley. This patch sounds very much
like it would address the problem I am having. I can pair and connect the
device upon the initial pairing, but subsequent connections fail. In order to
connect again, I have to delete the pairing and re-pair. I have two Samsung
headsets both of which are based on BT v2.1 + EDR, using Secure Simple Pairing
(SSP). Both headsets have the same issue in Ubuntu 11.10 with Linux Kernel
v3.0. I did not have the issue with either headset in Ubuntu 11.04 based on
Linux Kernel v2.6.38.

Do you know if this patch will be applied to the Linux Kernel used by Ubuntu
11.10 (v3.0)? If not, could you provide some guidance on how to go about
downloading and applying the patch to my current Ubuntu installation? I am not
super technical, so if you can help me figure out how to apply the patch, I
can at least report back whether or not this resolves my issue.

Thanks again for your help.

On Mon, Jan 16, 2012 at 2:33 AM, Daniel Wagner <wagi@monom.org> wrote:
> Hi bubba,
>
> Sorry for the late response.
>
> On 22.12.2011 19:38, bubba junk wrote:
>> Thanks for your reply. I forgot to mention in my original post that I
>> have beenusing the same BT usb dongle and BT headset in Ubuntu 10.10,
>> 11.04, and 11.10.Everything worked fine in Ubuntu 10.10 and 11.04
>> which I think were based onLinux Kernel 2.6.35 and 2.6.38
>> respectively. In those versions, I was able topair and connect /
>> disconnect / connect without issue. I've seen other postselsewhere
>> that other folks are having the same bluetooth headset issue
>> afterUbuntu 11.04. The symptoms and behavior appear to be the same.
>> I'd love to try to help debug the issue so that it can be resolved. I
>> would justneed some guidance on how to capture any needed information.
>> I will try tocapture it and post it. Let me know how I can help.
>
> After debugging a bit and some discussions my problem seem to be a  with
> simple pairing and promotion of an already existing connection to a
> higher security level (that means enable encryption).
>
> There is a patch from Peter Hurley called
>
> "[PATCH] Bluetooth: Fix l2cap connfailures for ssp devices"
>
> which might help in the case you are suffering from the same problem.
>
> There are also some bug reports about this one:
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/839157
>
> cheers,
> daniel
