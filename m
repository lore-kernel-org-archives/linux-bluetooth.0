Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EF30EE3.6050602@monom.org>
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com>
	<4EF30EE3.6050602@monom.org>
Date: Thu, 22 Dec 2011 12:38:26 -0600
Message-ID: <CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com>
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
From: bubba junk <junkbubba2@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your reply. I forgot to mention in my original post that I
have beenusing the same BT usb dongle and BT headset in Ubuntu 10.10,
11.04, and 11.10.Everything worked fine in Ubuntu 10.10 and 11.04
which I think were based onLinux Kernel 2.6.35 and 2.6.38
respectively. In those versions, I was able topair and connect /
disconnect / connect without issue. I've seen other postselsewhere
that other folks are having the same bluetooth headset issue
afterUbuntu 11.04. The symptoms and behavior appear to be the same.
I'd love to try to help debug the issue so that it can be resolved. I
would justneed some guidance on how to capture any needed information.
I will try tocapture it and post it. Let me know how I can help.

On Thu, Dec 22, 2011 at 5:05 AM, Daniel Wagner <wagi@monom.org> wrote:
> Hi bubba,
>
> On 21.12.2011 23:40, bubba junk wrote:
>> I am new to posting to mailing lists, so forgive me in advance if I am not
>> following protocol. I have an issue connecting to my bluetooth headset in
>> Ubuntu 11.10 Linux Kernel 3.0.0-14-generic. I am able to pair and connect
>> at first. But after disconnecting, I am no longer able to connect. I have to
>> un-pair then re-pair the device to connect again. After re-paring the headset
>> , it stays connected until I disconnect. Then again after disconnecting,
>> I am not able to connect. I saw some regression bug documentation to something
>> similar in Linux 2.6. Is this a known bug in 3.0?
>>
>> Thanks in advance for your help. Sorry for such a newbie question.
>
> I am experience the something very similar here. I though my setup is
> broken but maybe it isn't only on my system.
>
> I started to debug it but had to fix other pressing things first. My
> current understanding is that in on my system for some reasons the PC
> does after a fresh pairing a correct encryption of the connection. After
> that it does not encrypt it anymore and the device rejects the connection.
>
> Be aware that this is not really proven yet. Luckily I have a BT sniffer
> on my table... just need more time...
>
> cheers,
> daniel
>
