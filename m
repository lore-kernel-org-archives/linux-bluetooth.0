Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F3237D8.3060700@monom.org>
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com>
	<4EF30EE3.6050602@monom.org>
	<CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com>
	<4F13E0CD.50704@monom.org>
	<CAMk70DAo9no5aHJ7LaqYvQEE1-MO-4mGZbiMb7r1mUpiaA1N_Q@mail.gmail.com>
	<4F3237D8.3060700@monom.org>
Date: Fri, 10 Feb 2012 10:12:01 -0600
Message-ID: <CAMk70DCotYGECxFSmQvozXQE4TOwkB1ENaBTsVXoe1nM2UwV1g@mail.gmail.com>
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
From: bubba junk <junkbubba2@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Daniel,


Thanks for responding. Last night I tried your suggestion to run the terminal
command to change the status of the sspmode to 0. It worked!!! As you
suggested, I first unpaired the device, ran the command to disable the sspmode
and repaired the device. Then after disconnecting the headset, I was able to
successfully reconnect it without any problems. I was able to reconnect
multiple times, and across several users on the same laptop (fast user
switching). Each time while the sspmode is disabled, the headset was able to
reconnect.


I then tried rebooting the laptop. I noticed that after rebooting the laptop,
I was not able to reconnect the headset. I thought that maybe the sspmode had
been re-enabled. I checked and it looked like it was re-enabled after reboot.
I again ran the terminal command to disable it, this time without
un-pair/re-pair and the headset was able to again connect. Is there a way to
permanently disable the sspmode or disable it automatically after reboot until
the bug has been patched?


It seems like such a simple issue, but from a users perspective, the issue can
have a devastating impact on the perception of the system. Users take for
granted simple things like being able to connect a BT device and to have the
ability to reconnect it the next time it is needed. For me, this has been an
ongoing frustration since I upgraded to Ubuntu 11.10 from 11.04 back in
October, almost 3 months ago. Until your email, I had spent hours reading
different forums and posts trying to find out what was causing the issue. It
was extremely frustrating to know that something that used to work, no longer
did work.


I'm glad to hear that a more permanent fix is in the works to correct the
issue. Would you suggest that I create a bug report in the Ubuntu Launchpad
forum and link to this thread so that at least this fix can be incorporated
into my current distribution release? I've never created a bug report, so I'm
not sure of the correct protocol.


You seem to be referring to a longer term fix as well. How would I go about
monitoring the status of the longer term fix?


Best Regards.

On Wed, Feb 8, 2012 at 2:52 AM, Daniel Wagner <wagi@monom.org> wrote:
> Hi bubba,
>
> The patch has been accepted for fixing this problem. A better fix is in
> the works. The patch is still in bluetooth-next, that means it will not
> make it for the 3.3 kernel release. As soon the patch reaches Linus'
> tree then it can be promoted to the stable releases (such as 3.0 kernel)
> which will then be picked up by your distribution (I think).
>
> Until then you need to patch your kernel yourself. There is plenty of
> information available how to build your own kernel, so I wont explain it
> here (I am very lazy person :)). Anyway, there is a simple work around
> in the meantime-
>
> Unpair your device then run following on your computer
>
> sudo hciconfig hci0 sspmode 0
>
> and then repair. This will disable secure simple pairing and then you
> will fallback to legacy pairing. After that your devices should work
> fine again.
>
> cheers,
> daniel
>
>
> On 06.02.2012 21:54, bubba junk wrote:
>> Daniel,
>>
>> I must have missed your response several weeks ago. I've read several of the
>> posts including the patch notes from Peter Hurley. This patch sounds very much
>> like it would address the problem I am having. I can pair and connect the
>> device upon the initial pairing, but subsequent connections fail. In order to
>> connect again, I have to delete the pairing and re-pair. I have two Samsung
>> headsets both of which are based on BT v2.1 + EDR, using Secure Simple Pairing
>> (SSP). Both headsets have the same issue in Ubuntu 11.10 with Linux Kernel
>> v3.0. I did not have the issue with either headset in Ubuntu 11.04 based on
>> Linux Kernel v2.6.38.
>>
>> Do you know if this patch will be applied to the Linux Kernel used by Ubuntu
>> 11.10 (v3.0)? If not, could you provide some guidance on how to go about
>> downloading and applying the patch to my current Ubuntu installation? I am not
>> super technical, so if you can help me figure out how to apply the patch, I
>> can at least report back whether or not this resolves my issue.
>>
>> Thanks again for your help.
>>
>> On Mon, Jan 16, 2012 at 2:33 AM, Daniel Wagner <wagi@monom.org> wrote:
>>> Hi bubba,
>>>
>>> Sorry for the late response.
>>>
>>> On 22.12.2011 19:38, bubba junk wrote:
>>>> Thanks for your reply. I forgot to mention in my original post that I
>>>> have beenusing the same BT usb dongle and BT headset in Ubuntu 10.10,
>>>> 11.04, and 11.10.Everything worked fine in Ubuntu 10.10 and 11.04
>>>> which I think were based onLinux Kernel 2.6.35 and 2.6.38
>>>> respectively. In those versions, I was able topair and connect /
>>>> disconnect / connect without issue. I've seen other postselsewhere
>>>> that other folks are having the same bluetooth headset issue
>>>> afterUbuntu 11.04. The symptoms and behavior appear to be the same.
>>>> I'd love to try to help debug the issue so that it can be resolved. I
>>>> would justneed some guidance on how to capture any needed information.
>>>> I will try tocapture it and post it. Let me know how I can help.
>>>
>>> After debugging a bit and some discussions my problem seem to be a  with
>>> simple pairing and promotion of an already existing connection to a
>>> higher security level (that means enable encryption).
>>>
>>> There is a patch from Peter Hurley called
>>>
>>> "[PATCH] Bluetooth: Fix l2cap connfailures for ssp devices"
>>>
>>> which might help in the case you are suffering from the same problem.
>>>
>>> There are also some bug reports about this one:
>>> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/839157
>>>
>>> cheers,
>>> daniel
>
