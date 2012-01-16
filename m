Return-Path: <cyrus@holtmann.org>
Message-ID: <4F13E0CD.50704@monom.org>
Date: Mon, 16 Jan 2012 09:33:17 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: bubba junk <junkbubba2@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Headset Connection Issue Linux v3.0
References: <CAMk70DBANeAndgm-nV=9Cgt2tvz=dRmd8WdpnJkNTe=a2LDugA@mail.gmail.com> <4EF30EE3.6050602@monom.org> <CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com>
In-Reply-To: <CAMk70DAh0gaydUbj-ryqeo350+64j=vn-_-yGUk_wo=fYSuXYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi bubba,

Sorry for the late response.

On 22.12.2011 19:38, bubba junk wrote:
> Thanks for your reply. I forgot to mention in my original post that I
> have beenusing the same BT usb dongle and BT headset in Ubuntu 10.10,
> 11.04, and 11.10.Everything worked fine in Ubuntu 10.10 and 11.04
> which I think were based onLinux Kernel 2.6.35 and 2.6.38
> respectively. In those versions, I was able topair and connect /
> disconnect / connect without issue. I've seen other postselsewhere
> that other folks are having the same bluetooth headset issue
> afterUbuntu 11.04. The symptoms and behavior appear to be the same.
> I'd love to try to help debug the issue so that it can be resolved. I
> would justneed some guidance on how to capture any needed information.
> I will try tocapture it and post it. Let me know how I can help.

After debugging a bit and some discussions my problem seem to be a  with
simple pairing and promotion of an already existing connection to a
higher security level (that means enable encryption).

There is a patch from Peter Hurley called

"[PATCH] Bluetooth: Fix l2cap connfailures for ssp devices"

which might help in the case you are suffering from the same problem.

There are also some bug reports about this one:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/839157

cheers,
daniel
